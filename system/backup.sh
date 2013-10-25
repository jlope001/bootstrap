# change the destination file
DESTINATION_FOLDER='/home/jlope001/archive/backup/system/ubuntu/'
DESTINATION_FILENAME=`date +system_backup_%Y_%m_%d`

# update directories/files to exclue
EXCLUDE_FILES=(
  '/proc'
  '/lost+found'
  '/mnt'
  '/sys'
  '/home/jlope001/archive'
  $DESTINATION_FOLDER$DESTINATION_FILENAME.tgz
)


EXCLUDE_STRING=$(printf " --exclude=%s" "${EXCLUDE_FILES[@]}")
EXCLUDE_STRING=${EXCLUDE_STRING:1}

sudo tar cvpzf $DESTINATION_FOLDER$DESTINATION_FILENAME.tgz $EXCLUDE_STRING /