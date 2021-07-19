#!/bin/bash

# #########
# Variables
# #########

home_dir="` cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd `"

source "${home_dir}/print_colors.sh"
source "${home_dir}/resources/unicode_emojis.sh"
source "${home_dir}/resources/loading_fairy.sh"

align_fairy=0
align_human=0
align_victor=0
align_victim=0

owl_feather=0
mothers_brooch=0

# #########
# Functions
# #########

# All scenes have four (4) parts:
#     clear
#     A message that narrates what's happening
#     A question, giving the user a choice
#     Actions (at least 1; no more than 3) for the user to choose from (or the carry_on function)

message() {
    local message="${1}"
    
    cols=`tput cols`
    border=""
    
    for ((i=0; i < $cols; i++))
    do
        border="$border#"
    done
    
    echo "$border"
    echo
    echo -e "${message}" | fold -w "$cols" -s
    echo
    echo
    echo "$border"
    echo
}

question() {
    local question="${1}"

    cols=$(tput cols)
    
    echo "${question}" | fold -w "$cols" -s
    echo
}

carry_on() {
    read -p "Press [Enter] key to continue..." fackEnterKey
}

actions() {
    local answer_1="${1}"
    local answer_2="${2}"
    local answer_3="${3}"
    
    answer_array=()
    answer_array+=("${answer_1}")
    
    if [ ! -z "${answer_2}" ]
    then
        answer_array+=("${answer_2}")
    fi
    
    if [ ! -z "${answer_3}" ]
    then
        answer_array+=("${answer_3}")
    fi
    
    answer_array+=("Leave Game")
    
    select final_answer in "${answer_array[@]}"
    do
        if [[ "${final_answer}" == "Leave Game" ]]
        then
            exit_game
        else
            next_scene=`echo "${final_answer}" | tr '[:upper:]' '[:lower:]' | tr ' ' '_'`
            eval "$next_scene=$next_scene"
            "$next_scene"
            break
        fi
    done
}

exit_game() {
    killall afplay
    clear
    exit 0
}

trap exit_game EXIT

loading_fairy_scene() {
    clear
    echo
    echo
    echo
    echo
    loading_fairy
    clear
}

# ######
# scenes
# ######

# 1. The Garden

scene_1_the_garden() {
    local message="'Bridget!'
    
    Oh dear. Mother is calling again. You had just freed yourself from her only a few minutes ago. What could she want now? You are already wearing the dress, and your hair is already done. Maybe she wants to put a hat on you. But you don't feel like wearing a hat. The day is so sunny and nice. You want to feel the nice weather as much as you can."
    
    clear
    message "${message}"
    carry_on

    local message="On the happy side, mother did allow you to wear her brooch, the silver one in the shape of a bell. You love that brooch so much. Mother always looked so beautiful when she wore it. Though she would never let you wear it for fear that you would lose it.
    
    But you can be trusted. You're not a baby anymore after all. You'll be starting school soon, in fact. Mother can see this, which is why she said you could wear her brooch for a little bit while you played in the garden."
    
    clear
    message "${message}"
    carry_on

    local message="Of course, the garden is only so much fun. The woods beyond the hedge are much more exciting. That's where you are right now, wandering along the tree line, your family's cottage not too far behind you. You always love coming out here in the summer. It's quieter than in the city, and there aren't any children to play with. Still, there's something wonderful about the old cottage, the garden behind it, and the woods beyond that. The whole place feels... magical."

    clear
    message "${message}"
    carry_on

    local message="As you walk along a little further, you notice something waving in tall the grass, just within the trees. Almost without noticing, you venture past the trees, just a little way into the woods. Looking closer, you see it is a feather. You had seen a white barn owl outside your window last night. It scared you at first. But it was also terribly exciting. That must be where it came from.
    
    Maybe you should play with that instead of your mother's brooch. But, you do so love the brooch."
    
    clear
    message "${message}"

    local question="Do you play with the feather, or keep playing with the brooch?"

    question "${question}"
    actions "Play with the feather" "Play with the brooch"
}

play_with_the_feather() {
    ((owl_feather++))
    ((align_fairy++))

    local message="You pick up the feather, and set your mother's brooch down on a nearby stump. It should be safe there. You watch as the feather flutters slightly and shimmers in the warm breeze. You can almost hear it hum with magic.

    You dance around to the feather's music, letting your body move with the wind. The air around you feels charged with energy. This is so much more fun than you were having with that old brooch."
    
    clear
    message "${message}"
    carry_on
    scene_2_the_garden
}

play_with_the_brooch() {
    ((mothers_brooch++))
    ((align_human++))

    clear
    local message="Mother would be very upset if you lost her brooch. And it is so lovely, the way that it shines in the morning sun. Holding it up, you can almost hear the ringing it would make if it were a real bell. In fact... is it ringing?

    Your body starts to sway from side to side as you imagine the music the bell would make. The world seems still, and you are reminded of why you love coming out to the cottage. It was very kind of mother to let you play with the brooch. Speaking of which..."
    
    message "${message}"
    carry_on
    scene_2_the_garden
}

scene_2_the_garden() {
    local message="You can hear mother's voice calling for you. She sounds like she's in the garden. You'd better go back to her before she becomes very upset with you.

    But just as you are about to turn and leave the woods, something catches your eye. Turning back, you see something deeper in the woods where the trees are thick enough to cast long and dark shadows... a light!"

    clear
    message "${message}"
    carry_on

    local message="There is a blue light, flickering like a flame, just a little further into the woods where the trees start to thicken. Something inside is telling you to follow the light, to find out what it is. It's certainly not the sort of thing you expect to see so far out in the country side.

    Then again, mother is calling you. You don't want to keep her waiting."
    
    clear
    message "${message}"
    carry_on

    local message="The light isn't too far away. You could just run to it very quickly to see what it is, and then hurry back to the garden."
    
    clear
    message "${message}"

    local question="Do you go toward the eery light to see what it is, or follow your mother's voice back to the garden?"

    question "${question}"
    actions "Follow the light" "Return to the garden"
}

follow_the_light() {
    ((align_fairy++))
    quarry="blue light"

    local message="Mother can wait a little while. You need to find out what that light is. This shouldn't take long."

    clear
    message "${message}"
    carry_on

    local message="You step further into the woods. Somehow this feels right. All you need to do is see what is making that strange blue light, and then you can return home.

    Although you are getting closer and closer to where you saw the light, you don't appear to be any closer to the light itself. Were you mistaken about how far away it was, or is it moving? You decide to run rather than walk, and as you do the light seems to grow stronger."

    clear
    message "${message}"
    carry_on

    local message="You're getting closer now. You're sure of it. The light seems to be getting brighter as you move toward it. Or... is it just getting darker outside.

    As you glance around you, it becomes apparent that either you have been running for much longer than you thought and nightfall has already come, or else you have journeyed far enough into the woods that very little sunlight reaches here."

    clear
    message "${message}"
    carry_on
    scene_3_the_garden
}

return_to_the_garden() {
    ((align_human++))
    quarry="tiny person"
    
    local message="Best not to keep mother waiting any longer. You turn your gaze cautiously away from the blue light and toward your family cottage. It sounded like mother is in the garden.

    Leaving the woods, you run quickly back to the garden hedge and through the gate. Looking around, however, you don't see mother anywhere. How strange!"

    clear
    message "${message}"
    carry_on
    
    local message="You walk slowly through the garden, wondering if perhaps you had only imagined mother calling you, when you suddenly hear another voice behind you.

    '${GREEN}Hello.${NO_COLOR}'"

    clear
    message "${message}"
    carry_on
    
    local message="Turning around quickly, you see nobody there. The voice was high-pitched and airy. It could easily have been just a breeze.

    But there it is again. '${GREEN}Hello there. Come here.${NO_COLOR}' The small voice seems to be coming from the flower bed. You walk over to it, and crouch down to peer among the flowers."

    clear
    message "${message}"
    carry_on
    
    local message="There, to your utter surprise, is a small person, no bigger than a teacup. Her skin shimmers as though it is covered in morning dew. She doesn't appear to be wearing proper clothing, but only a green bit of fabric, like a tunic or jacket, and a small red cap. 'Hello!' you say. 'Who are you?'

    The little person giggles, and smiles at you. '${GREEN}Follow me!${NO_COLOR}' she says, and disappears among the flowers."

    clear
    message "${message}"
    carry_on
    
    local message="'Wait!' you call after her. You begin crawling through the flowers after the small person. You can hear her giggling a head of you. Past flowers and bushes you crawl, then through a gap in the garden hedge. Once outside the garden, you can see the little person dashing across the grass toward the woods. She is either flying, or else skipping across the grass so lightly that she barely touches the ground.

    'Wait! Where are you going?' you call after her. But she hardly seems to hear you. '${GREEN}Come on! Follow me!${NO_COLOR}'"

    clear
    message "${message}"
    carry_on
    
    local message="You follow the small person into the woods where she moves between the trees with as much familiarity and ease as someone moves through the halls of their own home. '${GREEN}Come with me, child!${NO_COLOR}' You've now gone from crawling, to jogging, to all out sprinting to keep up with her.

    As you give chase, a burst of laughter escapes from your lips. Even though your skin is scratched and dirty (to say nothing of your dress), you are having more fun than you can remember ever having."

    clear
    message "${message}"
    carry_on
    scene_3_the_garden
}

scene_3_the_garden() {
    local message="Very quickly you come to a sudden stop. You feel a fearful lump rising up in your throat. Right before you are several very large frogs.

    You're not normally afraid of frogs. You've spent many summer afternoons chasing them playfully around the garden. But these are much bigger. Maybe the dim forest light is playing tricks on you, but these frogs appear to be almost the size of dogs."

    clear
    message "${message}"
    carry_on

    local message="Their eyes watch you silently as you stand there unsure what to do. The frogs don't show any signs that they would hurt you. They just sit there silently regarding you. Still, they're very large for frogs, and they seem to be guarding the way between you and the ${quarry} you were following."

    clear
    message "${message}"

    local question="Do you walk between the frogs to continue chasing the ${quarry}, or go the long way around them?"

    question "${question}"
    actions "Walk between the frogs" "Go around the frogs"
}

walk_between_the_frogs() {
    ((align_victor++))

    local message="You pluck up your courage and walk cautiously between two of the larger frogs in front of you. To your great surprise and relief, the frogs don't move an inch and simply continue to silently watch you as you pass by."

    clear
    message "${message}"
    carry_on

    scene_4_the_garden
}

go_around_the_frogs() {
    ((align_victim++))
    
    local message="While keeping a wary eye on the massive frogs, you slowly walk around the one furthest to the right, making sure to give it a wide berth. Thankfully, the frogs appear interested only in silently watching you, since they don't move a muscle."

    clear
    message "${message}"
    carry_on

    scene_4_the_garden
}

scene_4_the_garden() {
    local message="Having made your way safely past the squad of frogs, you turn your attention back toward the ${quarry} you were following. But, looking around, you don't see it anymore. You're now in a very dark and overgrown part of the forrest. The trees are humongous, towering over you like mighty pillars holding up the dark green canopy above.

    You look around for anything that might indicate where you are or what to do next. You are just about to give up and begin planning your return home (wherever that might be from here), when you notice that just before you is a large circle of mushrooms."

    clear
    message "${message}"
    carry_on
    
    local message="You approach the ring of mushrooms carefully. Something about the place has a strange feeling to it. You cock your head to the side a little, listening as a faint music greets you. Or, at least, it seems like music.

    Looking down at your feet, you see that you are standing just outside the ring. The air around you shivers, and something inside tells you you step in the ring."

    clear
    message "${message}"

    local question="Do you step into the mushroom ring, or leave it and try to find your way home?"

    question "${question}"
    actions "Step into the ring" "Try to find a way home"
}

step_into_the_ring() {
    ((align_victor++))

    local message="There's no going back at this point. You take a deep breath, and let it out slowly. Closing your eyes, you lift one foot forward and step forward into the ring of mushrooms."

    clear
    message "${message}"   
    carry_on
    scene_1_faerie
}

try_to_find_a_way_home() {
    ((align_victim++))

    local message="Things have gone far enough. Whatever this mushroom ring is, it can't be nearly as important as mother and what she will say when she sees the state that you are in. You decide it is best to return home.
    
    However, just as you are about to turn away from the ring, you hear a small and high-pitched voice behind you. '${GREEN}Come inside!${NO_COLOR}' There is a strong push behind you, like tiny hands that give you a mighty shove. And you find yourself uncontrollably falling into the mushroom circle."

    clear
    message "${message}"   
    carry_on
    loading_fairy_scene
    scene_1_faerie
}

# 2. Into Faerie

scene_1_faerie() {
    local message="What was that?
    
    You find yourself ..."

    clear
    message "${message}"   
    carry_on

    exit_game
}
