## Wyzwanie - Devops Engineer

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

Zakładamy ze wszystkie składniki komponenty infrastrukturalne (vmware / aws) już możliwości i mamy do nich pełen dostęp cli / api.

# Początek
### Dziękuje za wyzwanie! Poniżej znajduje się instrukcja do zadań. 


## Pierwsze Wyzwanie
W folderze zadań:
1. $ `docker build -t task1 .`
2. $ `docker run -dp 8080:80 task1`
3. $ `curl localhost:8080`

## Drugie Wyzwanie
Uruchom następujące kroki w folderze:
1. Zaktualizuj szczegóły połączenia vSphere w vars.yml
2. Run playbook `playbook-VM.yaml`

## Trzecie Wyzwanie
Uruchom następujące kroki w folderze: :)
1. $ `create_tls.sh`
2. $ `terraform init`
3. $ `terraform plan`
4. $ `terraform apply`