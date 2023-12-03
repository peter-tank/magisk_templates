fake() {
local o n d f
o=$1; n=$2;
test -d "$o" || return 2;
test -d "$n" && echo -n "overwrite: $n/: " && read
tree "$o";
find ./$o -type d -print | while read d; do
  d=$(echo -n "$d" | sed "s/$o/$n/g");
  mkdir -vp "$d";
done

find ./$o -type f -print | while read d; do
  f=$(echo -n "$d" | sed "s/$o/$n/g");
  mv -vi "$d" "$f";
done
tree "$n";
}

fake "$@";
