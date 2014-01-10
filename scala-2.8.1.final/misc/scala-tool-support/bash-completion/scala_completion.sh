# Bash Scala completion
#
# Add this file to /etc/bash_completion.d/ (or your local equivalent)
# or place a line like this in your .bashrc or .profile:
#
#   .  /path/to/file/scala_completion.sh
#
# For more information, see:
#
#   http://bash-completion.alioth.debian.org/
#
# This file is generated by running scala.tools.util.BashCompletion.
#

SCALA_PHASES="all parser namer packageobjects typer superaccessors pickler refchecks selectiveanf liftcode selectivecps uncurry tailcalls specialize explicitouter erasure lazyvals lambdalift constructors flatten mixin cleanup icode inliner closelim dce jvm terminal"
SCALA_PHASE_SETTINGS=( "-Ycheck" "-Ylog" "-Xprint" "-Ybrowse" "-Yskip" "-Ystop" )
SCALA_OPTIONS="-D -P -X -Xassem-extdirs -Xassem-name -Xassem-path -Xcheck-null -Xcheckinit -Xdisable-assertions -Xelide-below -Xexperimental -Xfatal-warnings -Xfuture -Xgenerate-phase-graph -Xlog-implicits -Xmigration -Xno-forwarders -Xno-uescape -Xnojline -Xplugin -Xplugin-disable -Xplugin-list -Xplugin-require -Xpluginsdir -Xprint-icode -Xprint-pos -Xprint-types -Xprint: -Xprompt -Xresident -Xscript -Xshow-class -Xshow-object -Xshow-phases -Xsource-reader -Xsourcedir -Xwarninit -Y -Ybrowse: -Ybuild-manager-debug -Ybuilder-debug: -Ycheck: -Yclosure-elim -Ycompact-trees -Ycompletion-debug -Ydead-code -Ydebug -Ydependent-method-types -Ydetach -Yide-debug -Yinfer-argument-types -Yinline -Ylinearizer: -Ylog-classpath -Ylog: -Yno-completion -Yno-generic-signatures -Yno-imports -Yno-predefs -Ynotnull -Ypmat-debug -Ypmat-naive -Yrangepos -Yrecursion -Yrepl-debug -Yself-in-annots -Yshow-trees -Yskip: -Ysqueeze: -Ystatistics -Ystop: -Ystruct-dispatch: -Ysuppress-vt-typer-warnings -Ytyper-debug -Ywarn-dead-code -bootclasspath -classpath -d -dependencyfile -deprecation -encoding -explaintypes -extdirs -g: -help -javabootclasspath -javaextdirs -make: -no-specialization -nowarn -optimise -print -shutdown -sourcepath -target: -unchecked -uniqid -usejavacp -verbose -version @<file>"
SCALA_OPTIONS_EXPANDED="-D -P -X -Xassem-extdirs -Xassem-name -Xassem-path -Xcheck-null -Xcheckinit -Xdisable-assertions -Xelide-below -Xexperimental -Xfatal-warnings -Xfuture -Xgenerate-phase-graph -Xlog-implicits -Xmigration -Xno-forwarders -Xno-uescape -Xnojline -Xplugin -Xplugin-disable -Xplugin-list -Xplugin-require -Xpluginsdir -Xprint-icode -Xprint-pos -Xprint-types -Xprint: -Xprompt -Xresident -Xscript -Xshow-class -Xshow-object -Xshow-phases -Xsource-reader -Xsourcedir -Xwarninit -Y -Ybrowse: -Ybuild-manager-debug -Ybuilder-debug:none -Ybuilder-debug:refined -Ybuilder-debug:simple -Ycheck: -Yclosure-elim -Ycompact-trees -Ycompletion-debug -Ydead-code -Ydebug -Ydependent-method-types -Ydetach -Yide-debug -Yinfer-argument-types -Yinline -Ylinearizer:dfs -Ylinearizer:dump -Ylinearizer:normal -Ylinearizer:rpo -Ylog-classpath -Ylog: -Yno-completion -Yno-generic-signatures -Yno-imports -Yno-predefs -Ynotnull -Ypmat-debug -Ypmat-naive -Yrangepos -Yrecursion -Yrepl-debug -Yself-in-annots -Yshow-trees -Yskip: -Ysqueeze:off -Ysqueeze:on -Ystatistics -Ystop: -Ystruct-dispatch:invoke-dynamic -Ystruct-dispatch:mono-cache -Ystruct-dispatch:no-cache -Ystruct-dispatch:poly-cache -Ysuppress-vt-typer-warnings -Ytyper-debug -Ywarn-dead-code -bootclasspath -classpath -d -dependencyfile -deprecation -encoding -explaintypes -extdirs -g:line -g:none -g:notailcalls -g:source -g:vars -help -javabootclasspath -javaextdirs -make:all -make:changed -make:immediate -make:transitive -make:transitivenocp -no-specialization -nowarn -optimise -print -shutdown -sourcepath -target:jvm-1.5 -target:msil -unchecked -uniqid -usejavacp -verbose -version @<file>"

_scala_completion()
{
  local cur prev opts colonprefixes
  
  COMPREPLY=()
  opts=""
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  colonprefixes=${cur%"${cur##*:}"}
  
  # special case escaping madness because bash treats : as a separator.
  case "${cur}" in
    -*:*)
      precolon=$(echo "${cur}" | sed 's/:.*//g')
      
      for p in ${SCALA_PHASE_SETTINGS[@]}; do
        if [[ "${precolon}" == "${p}" ]] ; then
          cur=$(echo "${cur}" | sed 's/.*://g')  # cut cur down to postcolon part
          opts=${SCALA_PHASES}
    	  fi
    	done
    	
    	if [ "${opts}" == "" ] ; then
    	  opts=${SCALA_OPTIONS_EXPANDED}
    	fi
    	;;
  esac
  
  if [ "${opts}" == "" ] ; then
	  opts=${SCALA_OPTIONS}
  fi
  
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  
  local i=${#COMPREPLY[*]}
  while [ $((--i)) -ge 0 ]; do
    COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
  done
  
  return 0
}

_scala_commands()
{
  complete -o default -F _scala_completion fsc
  complete -o default -F _scala_completion scala
  complete -o default -F _scala_completion scalac
  complete -o default -F _scala_completion scaladoc

}
_scala_commands
