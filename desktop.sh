xres=($(echo $(xfconf-query --channel xfce4-desktop --list | grep last-image)))

for x in "${xres[@]}"

do
    xfconf-query --channel xfce4-desktop --property $x --set "/teleportation.jpg"
done

xwallpaper --center /teleportation.jpg
