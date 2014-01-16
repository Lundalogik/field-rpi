#!/bin/bash
SSHARGS=$1
DEFAULTKEY=${2:-$( ls ~/.ssh/*.pub | head -1 )}
SSHKEY=$2
while [ -z "$SSHKEY" ]; do
	echo "Found SSH keys:"
	ls ~/.ssh/*.pub
	read -p "Enter name of SSH key to add to PI [$DEFAULTKEY]: " keyname
	SSHKEY=${keyname:-$DEFAULTKEY}
done

cat $SSHKEY | ssh $SSHARGS "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"
