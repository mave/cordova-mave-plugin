# Makefile for building and updating a cordova plugin from a cocoapod spec.
#
# You need to first configure your podfile.
# See the docutmention at:
#   http://github.com/mkcode/cocoapod-to-cordova.git
#
# Targets:
#
#   build:     Builds the cocoapod target for release (ios SDKs and archs).
#              Use this for vendoring the product into the plugin.
#
#   build-sim: Builds the cocoapod target for use in the ios simulator.
#              Use this for developing with the ios simulator.
#

default: build

pod: clean
	pod install --no-integrate

build: pod build-ios build-sim
	cat product_path.txt | xargs -I product_path lipo -create product_path-ios product_path-sim -output product_path
	cat product_path.txt | xargs -I product_path rm product_path-ios
	cat product_path.txt | xargs -I product_path rm product_path-sim

build-ios: pod
	cd Pods && cat ../build_target_name.txt | xargs -I targetfile xcodebuild -configuration Release -target targetfile
	cat product_path.txt | xargs -I targetfile mv targetfile targetfile-ios

build-sim: pod
	cd Pods && cat ../build_target_name.txt | xargs -I targetfile xcodebuild -configuration Release -sdk iphonesimulator -target targetfile
	cat product_path.txt | xargs -I targetfile mv targetfile targetfile-sim

clean:
	-rm -rf /var/folders/*/*/C/com.apple.DeveloperTools/*/Xcode/SharedPrecompiledHeaders/Pods-MaveSDK-*
	-rm -rf Pods
	-rm Podfile.lock
	-rm build_target_name.txt
	-rm product_path.txt
