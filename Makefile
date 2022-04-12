generate/1:
	@cd 01-init-resource-directory && \
	terraform init && \
	terraform apply -parallelism=1 -auto-approve -var-file=../settings.tfvars

generate/2:
	@cd 02-control-policy && \
	terraform init && \
	terraform apply -parallelism=1 -auto-approve -var-file=../settings.tfvars

generate/3:
	@cd 03-auto-create-role/step1 && \
	terraform init && \
	terraform apply -parallelism=1 -auto-approve -var-file=../../settings.tfvars
	@cd 03-auto-create-role/step2 && \
	terraform init && \
	terraform apply -parallelism=1 -auto-approve

generate/4:
	@cd 04-vpc && \
	terraform init && \
	terraform apply -parallelism=1 -auto-approve -var-file=../settings.tfvars

generate/5:
	@cd 05-action-trail && \
	terraform init && \
	terraform apply -parallelism=1 -auto-approve -var-file=../settings.tfvars
