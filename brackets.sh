#! /bin/bash

function guesswinner {
        rankA=$1
        rankB=$2

        d16A=$(( ( $RANDOM % 16 ) + 1 ))
        d16B=$(( ( $RANDOM % 16 ) + 1 ))

        if [ $d16A -gt $rankA -a $d16B -le $rankB ] ; then
                # team A wins and team B loses
                return $rankA
        elif [ $d16A -le $rankA -a $d16B -gt $rankB ] ; then
                #team A loses and team B wins
                return $rankB
        else
                # no winner
                return 0
        fi
}

function winner {
        teamA=$1
        teamB=$2

        echo -n "$teamA vs $teamB : "

        count=0

        #iterate and return winner, if found

        while [ $count -lt 10 ] ; do
                guesswinner $teamA $teamB
                win=$?

        if [ $win -gt 0 ] ; then
                #winner found
                echo $win
                return $win
        fi

                count=$(( $count + 1 ))
        done

        # no winner found, return a default winner

        echo "=$teamA"
        return $teamA
}


function playbracket {
        echo -e '\nround 1\n'

        winner 1 16
        round1A=$?

        winner 8 9
        round1B=$?

        winner 5 12
        round1C=$?

        winner 4 13
        round1D=$?

        winner 6 11
        round1E=$?

        winner 3 14
        round1F=$?

        winner 7 10
        round1G=$?

        winner 2 15
        round1H=$?

        echo -e '\nround 2\n'

        winner $round1A $round1B
        round2A=$?

        winner $round1C $round1D
        round2B=$?

        winner $round1E $round1F
        round2C=$?

        winner $round1G $round1H
        round2D=$?

        echo -e '\nround 3\n'

        winner $round2A $round2B
        round3A=$?

        winner $round2C $round2D
        round3B=$?

        echo -e '\nround 4\n'

        winner $round3A $round3B

        return $?
}

echo -e '\n___MIDWEST___'

playbracket

echo -e '\n___EAST___'

playbracket

echo -e '\n___WEST___'

playbracket

echo -e '\n___SOUTH___'

playbracket
