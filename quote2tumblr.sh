#!/bin/ash
# Your login details
TMB_USER='user@mail.addres';
TMB_PASS='password';

# What to Write
TMB_TYPE='quote';

# Send to twitter
TWEET='auto';

# Get quotes
CLIPPINGSFILE='/mnt/us/documents/My Clippings.txt';
if [ -f "$CLIPPINGSFILE" ]; then # file exists?
	TMB_QUOTE=$(tail -n5 "$CLIPPINGSFILE" | sed -n '1!G;h;$p' | sed -n -e '1,/Highlight/p' | grep -v -e 'Highlight' -e '===' | sed '$d');
	TMB_SRC=$(tail -n5 "$CLIPPINGSFILE" | sed -n '1!G;h;$p' | grep -m1 -A1 "Highlight" | tail -1);
else
CLIPPINGSFILE='/mnt/us/documents/Мои вырезки.txt';
if [ -f "$CLIPPINGSFILE" ]; then # file exists?
	TMB_QUOTE=$(tail -n5 "$CLIPPINGSFILE" | sed -n '1!G;h;$p' | sed -n -e '1,/Выделение/p' | grep -v -e 'Выделение' -e '===' | sed '$d');
	TMB_SRC=$(tail -n5 "$CLIPPINGSFILE" | sed -n '1!G;h;$p' | grep -m1 -A1 "Выделение" | tail -1);
fi
fi

# Post quote to blog via curl
if [ "$TMB_SRC" != "" ]; then
	curl -s \
	-d "email=$TMB_USER&password=$TMB_PASS&type=$TMB_TYPE&quote=$TMB_QUOTE&source=$TMB_SRC&send-to-twitter=$TWEET&generator=kindle" \
	"http://www.tumblr.com/api/write" > /dev/null	
fi
