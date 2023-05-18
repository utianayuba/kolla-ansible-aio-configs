# kolla-ansible-aio-configs yoga-centos

Deploy All-In-One node OpenStack using Kolla-Ansible for following use cases:
- Containers workload provisioning
- Database as a Service
- Web application

OpenStack Services: Core Services, Aodh, Barbican, Ceilometer, Cinder, Designate, Gnocchi, Kuryr, Magnum, Octavia, Swift, Trove

Hardware requirements:
- CPU 4 cores
- RAM 16 GB
- HDD/SSD 256 GB (/ 28 GB, swap 8 GB, /var 50 GB, /nfs_shares 50 GB, part0 40 GB, part1 40 GB, part2 40 GB)
- OS: CentOS Stream 8 Minimal
- Internet connectivity

Exec based on the following order:
1. pre-flight.txt
2. flight.txt
3. instance-test.txt
4. magnum-test.txt