#!/bin/bash

# Here you need to pass 2 arguments when you run this script
# 1. The index of the modules you want to run
# 2. The action you want to perform on this modules

# Modules 0. iam_user_all_rules_violation
# Modules 1. account_rules_violation
# Modules 2. cloudtrail_and_s3_bucket_rules_violation
# Modules 3. kms_key_rules_violation
# Modules 4. network_acl_rules_violation
# Modules 5. security_group_rules_violation
# Modules 6. RDS_rules_violation
# Modules 7. EC2_rules_violation
# Modules 8. sns_rules_violation
# Modules 9. sqs_rules_violation
# Modules 10. vpc_rules_violation


# Actions : plan,apply,destroy

# Declare the modules array with all modules

set -e

set -o pipefail

declare -a modules=("iam_user_all_rules_violation" "account_rules_violation" "cloudtrail_and_s3_bucket_rules_violation" "kms_key_rules_violation" "network_acl_rules_violation" "security_group_rules_violation" "RDS_rules_violation" "EC2_rules_violation" "sns_rules_violation" "sqs_rules_violation" "vpc_rules_violation")

module=$1
action=$2

# Function to run the terraform command
run_terraform() {
    local module_name=$1
    local action=$2

    if [ "$action" == "apply" ]; then
        echo "Running terraform apply for module: $module_name"
        terraform apply -auto-approve -target=module.$module_name
    elif [ "$action" == "destroy" ]; then
        echo "Running terraform destroy for module: $module_name"
        terraform destroy -auto-approve -target=module.$module_name
    else
        echo "Running terraform plan for module: $module_name"
        terraform plan -target=module.$module_name
    fi
}

# Function to validate if a module exists
validate_module() {
    local module=${modules[$1]}
    for m in "${modules[@]}"; do
        if [ "$module" == "$m" ]; then
            return 0
        fi
    done
    return 1
}

# Read the modules and run the terraform action based on user input
for index in "${!modules[@]}"; do
    echo "Module $index: ${modules[$index]}"
done

# Convert comma-separated input to array
IFS=', ' read -r -a selected_modules <<<"$module"

if [ -z $action ]; then
    $action="plan"
fi

cd data-generation
# Run terraform init command
terraform init -reconfigure

if [ -z $selected_modules ]; then
    for m in "${modules[@]}"; do
        run_terraform "$m" "$action"
    done
fi

# Iterate over the selected modules and run the corresponding terraform action
for module in "${selected_modules[@]}"; do
    if [ "$module" == "all" ]; then
        for m in "${modules[@]}"; do
            run_terraform "$m" "$action"
        done
    elif validate_module "$module"; then
        run_terraform "${modules[$module]}" "$action"
    else
        echo "Module '$module' is not valid or does not exist."
    fi
done
