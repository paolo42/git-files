export PATH="$HOME/.node/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH:/Users/chromecp/bin"


# When using sudo, use alias expansion (otherwise sudo ignores your aliases)
alias sudo='sudo '


# This helps me edit files that my user isn't the owner of in Sublime
#alias edit='SUDO_EDITOR="open -FWna /Applications/Sublime\ Text\ 2.app" sudo -e'

# This alias reloads this file
alias reprofile='. ~/.profile'

#
# Development configuration files
#
alias eprofile='sublime ~/.profile'
alias ehosts='sublime /etc/hosts'
alias ehttpd='sublime /etc/apache2/httpd.conf'
alias evhosts='sublime /etc/apache2/extra/httpd-vhosts.conf'
alias elmcenvxml='sublime /etc/lmcenv.xml'
# php - https://getgrav.org/blog/mac-os-x-apache-setup-multiple-php-versions
alias ephp56='sublime /usr/local/etc/php/5.6/php.ini'	# LoadModule php5_module /usr/local/opt/php56/libexec/apache2/libphp5.so
alias ephp70='sublime /usr/local/etc/php/7.0/php.ini'	# LoadModule php7_module /usr/local/opt/php70/libexec/apache2/libphp7.so
# sphp 56 | sphp 70

alias apache_check_sytnax='sudo /usr/sbin/httpd -t'
alias apache_restart='sudo apachectl restart'
alias apache_dump_vhosts='/usr/sbin/httpd -t -D DUMP_VHOSTS'
alias apache='apache_restart && apache_check_sytnax'

alias cd..="cd .."
alias cd.="cd ~"

alias ls='ls -FG'
alias lsa='ls -FGa'
alias ll='ls -lh'
alias lla='ls -lha'

alias c='clear'
alias e='exit'
alias t='tail -f'
alias te='t /var/log/apache2/error_log'
alias ta='t /var/log/apache2/access_log'

#
# symfony
#

alias dev='app/console --env=dev'
alias prod='app/console --env=prod'

#symfony_clear_cache prod
function symfony_clear_cache() {
	app/console cache:clear --env=$1
}

# doctrine

alias doctrineUpdate='app/console doctrine:schema:update --dump-sql'

#
# git
#

#git-fixups - https://filip-prochazka.com/blog/git-fixup
#chmod +x /bin/git-log-vgrep-most-recent-commit

#git-config (git aliases - git up = pull ff-only)
. ~/.git-config.bash

#git-autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

alias ga='git add'
alias g='git status'
alias gc='git commit -am'
alias gcfixup='git commit -a --fixup=HEAD'
alias mgp='m && gp && g'
alias m='git checkout master'
alias gst='git stash'
alias gwip='gst'
alias gstp='git stash pop'
alias gwippop='gstp'
alias gp='git up'	#git pull ff-only atd (alias in .git-config)
alias gu='git push'
alias gd='git diff'
alias gres='git reset HEAD --hard'

# create branch XYZ
function branch() {
 gp
 git checkout -b $1
 git push -u origin $1:$1
 g
}
# create issue XYZ
function issue_withoutmaster() {
 gp
 git checkout -b $1
 git push -u origin $1:feature/$1
 g
}
# checkout master first
function issue() {
 mgp
 git checkout -b $1
 git push -u origin $1:feature/$1
 g
}
# git squash commits: squash 5 (squashes 5 commits)
function squash() {
 git rebase --autosquash -i HEAD~$1
}

# gitTag 1.0.0
function gitTag() {
 git tag -a $1 -m "$1"
 gu --tags
}

# create release issue release/rc/___XYZ___/rc1
# example: `release 14.11.40` creates `origin/release/rc/14.11.40/rc1`
function release() {
 mgp
 git checkout -b release/$1
 git push -u origin HEAD:release/$1
 g
}

function releaseNotFromMaster() {
 gp
 git checkout -b release/$1
 git push -u origin HEAD:release/$1
 g
}

# example: `integration 07-31` creates `origin/integration/2016-07-31`
function integration() {
	mgp
	git checkout -b integration/2016-$1
	git push -u origin HEAD:integration/2016-$1
	g
}

function integrationNew() {
	mgp
	git checkout -b integration/$(date "+%Y-%m-%d%n")
	git push -u origin integration/$(date "+%Y-%m-%d%n")
	g
}

function int() {
	i $(date "+%Y-%m-%d%n")
}

# checkout integration branch and pull
# write `s 08-09` - it will checkout `integration/2015-08-09` and pull changes
function i() {
 git fetch
 git checkout integration/$1
 gp
 g
}

# example: `sprint 10` creates `origin/sprint/15.10`
function sprint() {
 mgp
 git checkout -b sprint/16.$1
 git push -u origin HEAD:sprint/16.$1
 g
}

# checkout sprint branch and pull
# write `s 21` - it will checkout `sprint/15.21` and pull changes
function s() {
 git checkout sprint/16.$1 && gp
 g
}

#
#workspaces
#
alias www='cd ~/www/'

#
#php
#
alias phptest='www && sublime test.php'
alias phpsymfonyrun='php app/console server:run'

alias ser='w && cd ../vagrant/'
alias vu='ser && vagrant up'
alias vs='ser && vagrant ssh'
alias vstop='ser && vagrant halt'
alias vhalt='vstop && vu && vs'

#phpunit
alias phpunitTest='cd app && ../bin/phpunit && cd ..'
#alias phpunitTest='php ./vendor/phpunit/phpunit/phpunit'
alias phpunitTestUnit='php ./vendor/phpunit/phpunit/phpunit --group unit'
alias phpunitTestGroup='php ./vendor/phpunit/phpunit/phpunit -c app/ --group $1'

alias phpunit2Test='php ./vendor/bin/phpunit'
alias phpunit2TestUnit='php ./vendor/bin/phpunit --group unit'
alias phpunit2TestGroup='php ./bin/phpunit -c app/ --group $1'

alias phpunitTestGroupSrc='php ./vendor/bin/phpunit -c src/ --group $1'

#
# js and css builds
#

# bower
alias bcc='bower cache clean'
alias bi='bower install'
alias bjsAll='bi && npm run build && grunt'

# npm
alias nrb='npm run build'
alias npmPublish='npm publish ./'

#
# QA
#
alias seleniumInstall='php ./vendor/bin/steward.php install'
alias seleniumServer='java -jar ./vendor/bin/selenium-server-standalone-2.48.2.jar'

alias seleniumServerHub='java -jar ./vendor/bin/selenium-server-standalone-2.48.2.jar -role hub -port 4444'
alias seleniumServerNode='java -jar ./vendor/bin/selenium-server-standalone-2.48.2.jar -role node -hub http://127.0.0.1:4444 -port 5555'

#example: seleniumRunTest ENV FILE
function seleniumRunTest() {
	c
	./vendor/bin/steward run-tests $1 firefox --pattern "$2.php"
}
#seleniumRunTestLocal FILE
function seleniumRunTestLocal() {
	c
	./vendor/bin/steward run-tests --no-proxy local firefox --pattern "$1.php"
}
#example: seleniumRunGroup GROUP ENV
function seleniumRunGroup() {
	c
	./vendor/bin/steward run-tests --group=$1 $2 firefox $3
}
#example: seleniumRunGroupLocal GROUP
function seleniumRunGroupLocal() {
	c
	./vendor/bin/steward run-tests --no-proxy --group=$1 local firefox
}
