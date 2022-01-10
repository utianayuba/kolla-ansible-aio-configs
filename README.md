# kolla-ansible-aio-configs wallaby-centos

Deploy All-In-One node OpenStack using Kolla-Ansible for following use cases:
- Containers workload provisioning
- Database as a Service
- Web application

OpenStack Services: Core Services, Barbican, Cinder, Kuryr, Magnum, Octavia, Swift, Trove

Hardware requirements:
- CPU 4 cores
- RAM 16 GB
- HDD/SSD 256 GB (/ 28 GB, swap 8 GB, /var 100 GB, part0 40 GB, part1 40 GB, part2 40 GB)
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
8. cinder-csi-test.txt
9. trove-test.txt