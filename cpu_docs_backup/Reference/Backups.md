# Backups

# Backups

Backups are taken automatically every night, and exported to the disk /save-me-something-died on Pando. They are then moved to the F-building every weekend.

We use <https://github.com/wefixit-AT/oVirtBackup> for backups.

All relevant config-files exist in the dumbo-m repo in the folder backup_program. If you create a VM that is not supposed to be backed up, please add it to the `vm_names_skip`-parameter in config.cfg and move the file to `backup.blossom:/backup/config.cfg`

## TODO

- [ ] Add this config-script to ansible
- [ ] Add VMs to vm_names-parameter, so we do not spend too much time on backups.
- [ ] Add cronjob to auto-run

# Snejk

Våra snejkbackups ligger i pando (pando.blossom:/save-me-something-died/snejkBackup) där vi har två olika mappar (**obs** det är inte filer utan mappar. Inklusive den som heter .img). Dessa backupsen har gjorts med ett program som heter CloneZilla, och skapats med det följande kommandot `/usr/sbin/ocs-sr -q2 -c -j2 -z2p -i 0 -sfsck -senc -p choose savedisk 2023-04-19-10-img sda sdb` CloneZilla är ett verktyg som kan backupa hela drives (och individuella mappar tydligen) till flera olika filer som eventuellt kan behöva sättas ihop när de ska användas igen. I min erfarenhet har vi dock inte filer som behöver sättas ihop, utan bara olika filer för olika mappar, men jag kan inte garantera detta.

För att extrahera någon av dessa mapparna behöver man först decompressa dem och sedan göra det till läsliga filer med partclone utilen partclone.ext3 eller partclone.restore (men partclone.ext3 är att föredra).

för att göra detta kan man använda följande oneliner: `lbzip2 -c -k -3 -d <input file here> | sudo partclone.ext3 -W -r -d -s - -o <output file here> -L log.txt`

Detta komandot kör lbzip2 för att unzipa file detta är vad flagsen gör:

* -c : skriv output till stdout
* -k : spara input filen (default är att programmet tar bort den)
* -3 : sätt compression block size till 3 (detta är satt till 3 på Snejk, inte säker om det är nödvändligt här)
* -d : decompress


:::warning
Se till att köra detta resten med sudo

:::

sedan pipar vi partclone.ext3, med följande flags

* -W : restore raw file, så att vi kan mounta med en loop device senare
* -r : restore
* -d : visa debug info (som progress)
* -s : input fil, - betyder att vi tar från stdin
* -o : output fil, byt ut <output file here>
* -L : plats att lägga logs


---

Good luck, godspeed, och hoppas att backups inte behövs för att allting brinner