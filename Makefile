#!make

# use this to create initial S3 bucket which save tfstate file
initial_bucket:
	scripts/create_s3_bucket "${name}"

init:
	terraform init -force-copy -reconfigure

plan:
	terraform plan -input=false

apply:
	terraform apply -auto-approve -input=false

destroy:
	terraform destroy -auto-approve

# use this to delete AccessKeyId for root user or others
delete_access_key:
	aws iam delete-access-key --access-key-id "${id}"

user.show: # use this to see newly created user.
	terraform state show 'module.iam_user.aws_iam_user_login_profile.example["${name}"]'
