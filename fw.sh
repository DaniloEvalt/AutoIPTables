#!/bin/bash
#
cat /home/admin/auth.log.4 | grep rhost= | awk '{print $14}' >> /home/AutoIPTables/admin/sec.log
sed -i 's/^rhost=//' /home/admin/sec.log
sort -u /home/admin/AutoIPTables/sec.log -o /home/AutoIPTables/admin/sec.log.aux
awk '{print "iptables -I INPUT -s "$0" -j DROP"}' /home/AutoIPTables/admin/sec.log.aux > /home/AutoIPTables/admin/sec.log
rm /home/admin/AutoIPTables/sec.log.aux
echo "#!/bin/bash" > /home/AutoIPTables/admin/sec.sh
echo "#" >> /home/AutoIPTables/admin/sec.sh
cat /home/AutoIPTables/admin/sec.log >> /home/AutoIPTables/admin/sec.sh
rm /home/AutoIPTables/admin/sec.log
chmod 775 /home/AutoIPTables/admin/sec.sh
chmod +X /home/AutoIPTables/admin/sec.sh
sed -i '$ d' sec.sh
