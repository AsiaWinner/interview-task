# Interview Task

Task Instructions
1. Proszę utworzyć Dockerfile za pomocą którego stworzymy kontener który:
- Jako base image będzie używał Ubuntu 20.04
- Uruchomia się na nim dodatkowo  Nginx z dflt stroną główną
- Wystawia Nginxa na porcie 80 "na świat".

2. Za pomocą Ansible, utworzyć maszynę wirtualną w środowisku vSphere.
- 4 CPU
- 16GB Ram
- 100GB HDD,
- nazwa testmachine01

3. Za pomocą terraform utworzyć w AWS grupę serwerów web:.
- bazujemy na dowolnym ami z Nginx
- konfigurujemy autoscalling ( bazowo 3 instancje, zwiększenie o kolejne 3 w przypadku gdy obciążenie cpu  >  50% )
- maszyny podpinamy do ALB
- na ALB dodatkowo konfigurujemy redirect z http na https


# Quick Start
## Task 1
In the task folder:
1. docker build -t task1 .
2. docker run -dp 80:8080 task1
3. curl localhost:8080

## Task 2
Run the following steps in the folder:
1. Update vSphere connection details in vars.yml
2. run playbook

## Task 3
Run the following steps in the folder:
1. create_tls.sh
2. terraform init
3. terraform plan
4. terraform apply