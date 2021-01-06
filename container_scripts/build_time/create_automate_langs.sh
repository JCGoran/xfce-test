#!/usr/bin/env bash
echo "Running in travis: ${TRAVIS}"
if [ "$TRAVIS" == "FALSE" ]; then
  PIPE=/dev/stdout
else
  echo Filtered package output to save output log size
  PIPE=/dev/null
fi


set +x +e

pushd /usr/share/i18n/locales/
VALID_LANGS=$(ls|egrep -o "^(...?$)|^(...?_[^@]+)"|sort -u)
for l in $VALID_LANGS; do
  
  if [[ $l == *_* ]]; then
      CUR_LANG="${l/_/automate_}"
  else
      CUR_LANG="${l}automate"
  fi
  echo "Creating $CUR_LANG"
  cp $l $CUR_LANG
  sed -i -E "s/(language +\".*)(\")/\1 Automate\2/" $CUR_LANG
  sed -i -E "s/(lang_lib +\".*)(\")/\1automate\2/" $CUR_LANG
  sed -i -E "s/(lang_name +\".*)(\")/\1 Automate\2/" $CUR_LANG
  localedef -i $CUR_LANG -f UTF-8 ${CUR_LANG}.UTF-8 -c -v &>$PIPE || echo "Ignoring warnings..."
  echo "$CUR_LANG UTF-8" > /var/lib/locales/supported.d/$CUR_LANG &>$PIPE
  locale-gen $CUR_LANG &>$PIPE 
done
popd
