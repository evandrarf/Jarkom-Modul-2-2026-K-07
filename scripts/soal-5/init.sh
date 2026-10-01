# add-on init.sh masing-masing
# prab
#!/bin/bash
hostname prab
echo prab > /etc/hostname
grep -v -w prab /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.1.2 prab.k07.com prab" >> /etc/hosts

# tedd
#!/bin/bash
hostname tedd
echo tedd > /etc/hostname
grep -v -w tedd /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.1.3 tedd.k07.com tedd" >> /etc/hosts

# obladi
#!/bin/bash
hostname obladi
echo obladi > /etc/hostname
grep -v -w obladi /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.1.4 obladi.k07.com obladi" >> /etc/hosts

# desmond
#!/bin/bash
hostname desmond
echo desmond > /etc/hostname
grep -v -w desmond /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.1.5 desmond.k07.com desmond" >> /etc/hosts

# oblada
#!/bin/bash
hostname oblada
echo oblada > /etc/hostname
grep -v -w oblada /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.1.6 oblada.k07.com oblada" >> /etc/hosts

# molly
#!/bin/bash
hostname molly
echo molly > /etc/hostname
grep -v -w molly /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.1.7 molly.k07.com molly" >> /etc/hosts

# abbey
#!/bin/bash
hostname abbey
echo abbey > /etc/hostname
grep -v -w abbey /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.4.2 abbey.k07.com abbey" >> /etc/hosts

# penny
#!/bin/bash
hostname penny
echo penny > /etc/hostname
grep -v -w penny /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.5.2 penny.k07.com penny" >> /etc/hosts

# alpha
#!/bin/bash
hostname alpha
echo alpha > /etc/hostname
grep -v -w alpha /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.6.2 alpha.k07.com alpha" >> /etc/hosts

# beta
#!/bin/bash
hostname beta
echo beta > /etc/hostname
grep -v -w beta /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.6.3 beta.k07.com beta" >> /etc/hosts

# gamma
#!/bin/bash
hostname gamma
echo gamma > /etc/hostname
grep -v -w gamma /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.6.4 gamma.k07.com gamma" >> /etc/hosts

# delta
#!/bin/bash
hostname delta
echo delta > /etc/hostname
grep -v -w delta /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.7.2 delta.k07.com delta" >> /etc/hosts

# epsilon
#!/bin/bash
hostname epsilon
echo epsilon > /etc/hostname
grep -v -w epsilon /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.7.3 epsilon.k07.com epsilon" >> /etc/hosts

# rootkit
#!/bin/bash
hostname rootkit
echo rootkit > /etc/hostname
grep -v -w rootkit /etc/hosts > /tmp/h; cat /tmp/h > /etc/hosts
echo "10.67.1.1 rootkit.k07.com rootkit" >> /etc/hosts