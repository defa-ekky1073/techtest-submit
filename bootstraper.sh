# !/bin/sh

# Validate the arguments, exit if not provided
if [ ! $1 ] || [ ! $2 ]
    then
        echo "Arguments needed; Usage: bootstraper.sh NODE_TYPE NODE_FQDN"
        exit 1
fi

# Check if instance.key exist in user's home .ssh directory
# and copy from terraform resource directory if doesn't exist
if [ ! -f "~/.ssh/instance.key" ]
    then
        sudo cp ./terraform/resource/instance.key ~/.ssh
        sudo chmod 400 ~/.ssh/instance.key
fi

# Switch case
case $1 in
    master)
        # Bootstrap the node as Master Node with Master Recipe
        knife bootstrap $2 -U ubuntu -i ~/.ssh/instance.key --sudo -N master --run-list 'recipe[techtest]';;
    *)
        # Bootstrap the node as Other Node (Typically Slave) with Slave Recipe
        knife bootstrap $2 -U ubuntu -i ~/.ssh/instance.key --sudo -N $1 --run-list 'recipe[techtest::slave]';;
esac