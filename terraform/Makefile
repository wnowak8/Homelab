apply:
	sudo terraform apply -auto-approve

plan:
	sudo terraform plan

init:
	sudo terraform init --upgrade

destroy:
	sudo terraform destroy -auto-approve

do: remove init plan apply info

rm: destroy kill info
	sudo virsh vol-delete --pool ubuntu commoninit.iso

remove:
	rm -f terraform.tfstate 
	rm -f .terraform.lock.hcl
	rm -rf .terraform
	rm -f terraform.tfstate.backup

info:
	sudo virsh list --all
	sudo virsh pool-list
	sudo virsh net-dhcp-leases default

console:
	sudo virsh console ubuntu-terraform

# -i <sciezka-do-klucz-prywatnego> - wskazanie lokalizacji klucza
# -o StrictHostKeyChecking=no - wyłącza sprawdzanie klucza hosta (nie ma konieczności dodania nowego klucza hosta do listy znanych hostów)
ssh:
#	ssh user@192.168.122.155
	ssh -i ~/.ssh/id_rsa_kvm -o StrictHostKeyChecking=no user@192.168.122.155


kill:
	sudo virsh vol-delete --pool ubuntu commoninit.iso
	sudo virsh pool-destroy ubuntu
	sudo virsh pool-undefine ubuntu
	sudo virsh shutdown ubuntu-terraform
	sudo virsh undefine ubuntu-terraform