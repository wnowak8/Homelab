install:
	ansible-playbook -i ./hosts playbooks/install_docker.yaml --ask-become-pass
	ansible-playbook -i ./hosts playbooks/install_microk8s.yaml --ask-become-pass
	ansible-playbook -i ./hosts playbooks/install_kubectl.yaml --ask-become-pass
