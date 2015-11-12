# BashRC from https://github.com/rsterbin/personal

# If not running interactively, don't do anything
case $- in
    *i*) ;;
        *) return;;
esac

# Use this line to indicate where the repo is checked out
DIR="__REPO_DIR__"

# Load manual settings
if [ -f $DIR/shellconf/manual.sh ]; then
    . $DIR/shellconf/manual.sh
fi

# Run detection
if [ -f $DIR/shellconf/detect.sh ]; then
    . $DIR/shellconf/detect.sh
fi

# Load all the other configs
for path in $DIR/shellconf/*.sh; do
    fn=$( basename $path )
    if [[ $fn != "manual.sh" && $fn != "detect.sh" ]]; then
        source $path
    fi
done

