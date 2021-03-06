module TimeUtils exposing (..)

import Time exposing (Posix, posixToMillis)
import Time.Extra exposing (Interval(..), add, ceiling, diff, floor)


startOfDay =
    Time.Extra.floor Day


endOfDay =
    Time.Extra.ceiling Day


addHours =
    add Hour


addMinutes =
    add Minute


previousDay =
    add Day -1


nextDay =
    add Day 1


halfMonthBack =
    add Day -15


halfMonthForward =
    add Day 15


intervals : Interval -> Time.Zone -> Posix -> Posix -> List Posix
intervals interval zone start end =
    let
        startDay =
            startOfDay zone start

        total =
            diff interval zone startDay end
    in
    List.map (\i -> add interval i zone startDay) <| List.range 0 total


hourIntervals =
    intervals Hour


dayIntervals =
    intervals Day


before : Posix -> Posix -> Bool
before a b =
    posixToMillis a < posixToMillis b


addFloatHours : Float -> Posix -> Posix
addFloatHours dt posix =
    posix
        |> Time.posixToMillis
        |> (+) (round <| dt * 3600000)
        |> Time.millisToPosix
