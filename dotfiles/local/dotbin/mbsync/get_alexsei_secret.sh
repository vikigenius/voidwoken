#! /bin/sh
python2.7 $DOTBIN/mbsync/oauth2.py \
    --user=vikash@alexsei.com \
    --client_id=83436093591-a8rp8qkesgeinnebdc5ersfoc4mfj5mi.apps.googleusercontent.com \
    --client_secret=GEPIy9Ugt-q4hikaJjApqtWc \
    --generate_oauth2_token \
    --refresh_token=1//04NbY1pKcz1oHCgYIARAAGAQSNwF-L9Irif2gOXhsBcPSqtAAefhs3VO36RAHUKkYvig4QsZHhLOyIrhKmM2tHiqDTvIXg3BiVH8 | \
awk -F" " '{if(NR==1)print $3}'
