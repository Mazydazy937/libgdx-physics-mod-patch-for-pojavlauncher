
name=$1
namepatched=${name/.jar/-patched.jar}
if ! command -v wget > /dev/null; then
	echo "wget is not installed."
elif ! command -v zip > /dev/null; then
	echo "zip is not installed."
elif ! command -v unzip > /dev/null; then
	echo "unzip is not installed."
elif [ -z $name ]; then
	echo "Command syntax: $0 <path-to-mod-file>"
elif [ ! -f $name ]; then
	echo "The mod file does not exist at path '$name'."
else
	echo -n "Type password: "
	read p
	# Password here! ↓
	if [ "$p" != "youfoundit" ]; then
		echo "Wrong password... Password is youfoundit and no forkbombs here!"
	else
		echo "Start patching..."
		if ! unzip -q -o $name -d mod; then
			echo "The provided file is not a mod archive!"
		elif [ ! -d "mod/physx" ]; then
			echo "The provided file is not Physics mod!"
		else
			wget -q https://github.com/Mazydazy937/libgdx-physics-mod-patch-for-pojavlauncher/releases/download/v1.0.0/libgdx_android_physics.zip
			if ! unzip -q -o libgdx_android_physics.zip -d patch; then
				echo "Weirdly Downloading the patch failed."
			else
				rm $(find mod -name "*.dll*")
				rm $(find mod -name "*.so*")
				rm $(find mod -name "*.dylib*")
				cp -r patch/* mod
				cd mod
				if ! zip -9 -q -r $namepatched *; then
					echo "Repacking mod failed."
					rm $namepatched
				else
					mv $namepatched ..
					echo "Patching done. File name: $namepatched"
					echo "To start running the mod, download and install the pojavlauncher app from the offical github or the google play store."
          echo "it Works on your pojavlauncher"
					echo "Thank you."
				fi
				cd ..
				rm -rf classes.jar mod patch > /dev/null
			fi
		fi
	fi
fi



