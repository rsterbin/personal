# Project-based configs

if [ "$personal_single_project" = yes ]; then
    export VIM_PROJECT=$personal_project
fi

if [[ $personal_code_location != "" ]]; then
    alias tocode="cd $personal_code_location"
fi

if [[ $personal_project == "Ora" ]]; then
    export APPLICATION_ENV=$peronal_env_name
fi

if [[ $personal_project == "DoodleDeals" ]]; then
    export PLATFORM=$peronal_env_name
fi

if [[ $personal_project == "OmniCMS" ]]; then
    export APPLICATION_ENV=$peronal_env_name
    export OMNICMS_INI="$personal_code_location/etc/local_project.ini"
    export OMNICMS_ADMIN_INI="$personal_code_location/etc/local_admin.ini"
fi

if [[ $personal_project == "Taubman" ]]; then
    export PERL5LIB="$personal_code_location/CPAN/lib:$personal_code_location/CPAN/lib/site_perl"
    alias taubsearch="find . -type f \( -name \"*.asp\" -o -name \"*.inc\" -o -name \"*.html\" -o -name \"*.pm\" -o -name \"*.pl\" -o -name \"*.conf\" \) | xargs grep"
    alias taubsearch1="find www/docs/ -type f \( -name \"*.asp\" -o -name \"*.inc\" -o -name \"*.html\" \) | xargs grep"
    alias taubsearch2="find www/docs/ -type f \( -name \"*.asp\" -o -name \"*.inc\" -o -name \"*.html\" -o -name \"*.xml\" \) | xargs grep"
    alias taubsearch3="find www/docs/ -type f \( -name \"*.asp\" -o -name \"*.inc\" -o -name \"*.html\" -o -name \"*.xml\" -o -name \"*.css\" -o -name \"*.js\" -o -name \"*.htm\" -o -name \"*.txt\" \) | xargs grep"
fi

if [[ $personal_project == "Corpweb" ]]; then
    export PYTHONPATH=/www/bin/pylib
fi

if [[ $personal_project == "TaubmanCrawler" ]]; then
    export PYTHONPATH=/home/ec2-user/git/url-finder/pylib
fi

