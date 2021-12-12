# kolla-ansible-aio-configs

Deploy All-In-One node OpenStack using Kolla-Ansible for following use cases:
- Containers workload provisioning

OpenStack Services: Core Services, Barbican, Cinder, Magnum, Octavia

Hardware requirements:
- CPU 4 cores
- RAM 16 GB
- HDD/SSD 128 GB (/ 20 GB, swap 8 GB, /var 100 GB)
- OS: CentOS Stream 8
- Internet connectivity

Exec based on the following order:
1. pre-flight.txt
2. flight.txt
3. instance-test.txt
4. pre-magnum-test.txt
5. magnum-test.txt
6. octavia-ingress-controller-test.txt
7. octavia-ingress-controller-tls-test.txt