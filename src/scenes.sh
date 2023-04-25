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

tired=true

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
    printf "%b\n" "${message}" | fold -w "$cols" -s
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
    local answer_4="${4}"
    
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
    
    if [ ! -z "${answer_4}" ]
    then
        answer_array+=("${answer_4}")
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
    
    clear
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
    loading_fairy_scene
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
    
    You awake to find yourself in a grassy clearing surrounded by reeds. The sky above you shimmers with stars, and glows with a strange blue and purple phosphorescence. Not far away is the dark shore of a lake, and in the distance surrounding the lake you notice mountains surrounding the valley which the lake resides in.
    
    This certainly isn't the countryside where your family's cottage sits."

    clear
    message "${message}"
    carry_on

    local message="Cautiously you approach the edge of the lake. Its water seems eerily still, almost like glass. You peek into the water curiously. But instead of the reflection of distant mountains or the glowing sky, you see your family's cottage along with the garden and woods, almost as though you were floating on clouds above them.
    
    As your eyes wander over the familiar landscape below you, you begin to hear music in the distance. Your attention slowly turns away from the scenery in the lake, and toward a knoll near the shore some distance away."

    clear
    message "${message}"
    carry_on

    local message="Curiosity gets the better of you, and you start walking toward the hill and the music coming from it. As you approach, the music grows louder. You can make out the sound of flutes and drums. You also begin to notice lights scattered along the grassy hillside, the largest of which sits at the very top.
    
    When you get to the foot of the knoll, a cobblestone pathway opens up before you, revealing a collection of dwellings on either side. Perhaps someone here can provide some explanation for where you are and how you got here. You walk slowly up the pathway. But as you peer into a number of windows, you realize that nobody is at home in any of them."

    clear
    message "${message}"
    carry_on

    local message="The only place showing any signs of life is the bright spot a the top of the knoll. Quickly you begin to make your way up the winding stone path through the village, at the end of which you find yourself standing before a pair of large silvery doors. The music is clearly coming from the other side, and you can hear a dull roar of voices as well.
    
    Looking around, you have to catch your breath when you see two large frogs, the same size as the ones you encountered earlier, sleeping on either side of the doors, apparently intended to guard it. Best not wait for them to awaken. So with what courage you can muster, you stretch out your fist to knock on the doors."

    clear
    message "${message}"
    carry_on

    local message="A tingling sensation rushes through your body, and the next thing you know you're on the other side of the silver doors. The music quickly dies out, and you find yourself staring at the edge of a large courtyard before a large crowd of people, apparently midway through a celebration of some sort, all of whom have turned to look at you.
    
    But these aren't ordinary people. As you stand there somewhat embarrassed, you realize that all of these folk are roughly your own size, even as they appear to be full grown. Their skin is plump and smooth like porceline, their cheeks rosy, and their ears long and pointy. What's more, they wore the strangest assortment of clothes you've ever seen, a peculiar blend of extravagent gowns and dresses as well as leaves and branches.
    
    Then, quite suddenly a voice cries out, at the same time both high pitched and gruff, '${GREEN}At last!${NO_COLOR}'"

    clear
    message "${message}"
    carry_on

    local message="'${GREEN}Welcome, welcome!${NO_COLOR}' continues the speaker, who you now see as a large and rotund fellow sitting on a throne of giant flower petals at the far end of the courtyard. He has a large grey beard that glitters and curls at the ends, and atop his head sits a crown of thistles and holly. '${GREEN}We've been expecting you. Come closer, my child.${NO_COLOR}'
    
    Cautious and unsure of your strange new surroundings, you glance around. Seeing your hesitation, the crowned fellow turns to a couple of larger individuals standing nearby and says with an air of authority, '${GREEN}Bring her closer.${NO_COLOR}'"

    clear
    message "${message}"
    carry_on

    local message="The larger individuals walk purposefully toward you and then gently, but firmly, guide you toward the other end of the courtyard, up a small flight of stairs, and before the seated fellow on the throne. '${GREEN}Ah, that's better,${NO_COLOR}' He chides. '${GREEN}Allow me to introduce myself. I am Oberon, king of the fair folk,${NO_COLOR}' he says, gesturing to the crowd behind you. '${GREEN}And you must be Bridget. It's an honor to finally meet you, and to have you join me in my humble palace.${NO_COLOR}'
    
    The old king has a kindly smile, which gives you courage. Politely you respond, 'Thank you, your majesty. It's a lovely palace. Might I ask, what are you celebrating this evening?' '${GREEN}What are we celebrating? Why, you, my child! We are celebrating the great privilege it is to have you among us.${NO_COLOR}'
    
    With a chuckle, Oberon motions for you to sit next to him."

    clear
    message "${message}"
    carry_on

    local message="You sit comfortably next to the king. Almost immediately a trio of fairies approach you with large plates. The food on these plates looks strange. Not unappetizing. Still, you've always been a bit hesitant about trying new foods. And wasn't there a nursery rhyme about eating fairy food? But you don't want to be rude, and father always says you should be willing to try new foods before declaring you don't like them."

    clear
    message "${message}"

    local question="Do you eat the new fairy food?"

    question "${question}"
    actions "Eat the food" "Reject the food"
}

eat_the_food() {
    ((align_fairy++))
    tired=false

    local message="'Thank you!' you say as you take a portion of food from one of the plates. Gingerly, you bite into it, unsure what to expect. To your amazement, it explodes with flavors, the likes of which you'd never even dreamed of. This is utterly delicious! Beyond that, you can feel the flavor moving through you, filling you up and changing you.
    
    Wait, that can't be right. Flavor can't change you. You quietly examine yourself. You look the same. There's been no evident change to you, whether physically, mentally, or emotionally. But you could have sworn... Oh well. What a strange sensation."

    clear
    message "${message}"
    carry_on

    scene_2_faerie
}

reject_the_food() {
    ((align_human++))

    local message="'No, thank you,' you say politely to the fairies carrying the plates of food. They look at you somewhat alarmed and confused. Clearly they expect you to eat something. One of them moves their plate a little closer to you, encouraging you to take a morsel. 'Oh,' you exclaim quietly. 'I really couldn't.' The servers glance cautiously up at the king beside you.
    
    '${GREEN}Come now, you must eat something. We have a long night of celebrating ahead of us, and you'll need your strength.${NO_COLOR}' You don't really feel like eating. But you grab a small yellow pancake-like sample from one of the plates and smile graciously. This seems to satisfy both the king and the servers, who return their attentions to the rest of the celebration.
    
    After holding the pancake in your hand for a few minutes, you set it down and forget about it entirely."

    clear
    message "${message}"
    carry_on

    scene_2_faerie
}

scene_2_faerie() {
    feeling_sleepy=`[[ $tired == true ]] && echo "you begin to feel tired, and can feel yourself nodding off." || echo "you are as wide awake as ever. Something in the fairy food must have given you an amazing amount of energy."`

    local message="The night wears on, and though the revelry continues for several hours, they seem to go by rather quickly. After what might have been ages ${feeling_sleepy}
    
    '${GREEN}Come!${NO_COLOR}' Oberon exclaims. The old king shows no signs of fatigue. But he does seem to be somewhat lost in his enjoyment. Maybe he's been a little wild and nutty this whole time, and you are just now noticing. '${GREEN}Let us share our merrymaking!${NO_COLOR}'
    
    Almost as if on cue, the entire party begins preparing to travel. Coaches and chariots are brought forth from a gateway off to one side, and various animals - hummingbirds, bats, moths, butterflies, etc. - each one much larger than it ought to be, are set to draw the numerous carriages."
    
    clear
    message "${message}"
    carry_on

    local message="You are swept off your feet by several hands and deposited on a cushioned seat in the largest sleigh alongside Oberon. The king roars with laughter as the driver cracks a whip and ten massive dragonflies pull the sleigh swiftly off the ground and through the air, soaring above the palace and away from the grassy knoll.
    
    The cold night air rushes past your face, and you find yourself suddenly invigorated. Looking around, you see that a whole host of chariots and sleighs surround the one you're in, with all the celebratory party looking both stately and wild at the same time. And blanketing the whole affair is a white fog which spirals and dances below and between all of the carriages."
    
    clear
    message "${message}"
    carry_on

    local message="Below you the countryside rushes past in a blur. Very quickly the whole affair crosses over moors and valleys, lakes and rivers. Looking ahead, you see a body of water so large that it must be the ocean. 'Can we have come so far already?' you ask yourself. You lift your gaze above the horizon to the sky, and see a rainbow of lights dancing to the north. Oberon's voice booms out over the procession, '${GREEN}Aloft!${NO_COLOR}'

    Almost immediately your sleigh and all those around it rise quickly up into the night sky, moving rapidly toward the rippling lights above. Oberon's laughter seems to resonate through the whole parade. Then, just as suddenly as it all began, everything seems to slow to a halt. Glancing around, you find yourself and the whole party standing in the very midst of a moving collage of colors."
    
    clear
    message "${message}"
    carry_on

    local message="'${GREEN}Come, child,${NO_COLOR}' Oberon says, offering his hand to you.
    
    You take his hand and he leads you out of the sleigh and onto a floor so polished and clear that you can scarcely tell where it ends and the surrounding rainbow of moving colors begins. You are so fascinated by walking on a nearly invisible floor that you don't notice the palace in front of you until you are already walking up the front steps.
    
    '${GREEN}My dear Bridget,${NO_COLOR}' Oberon says as he wraps one large arm around you, guiding you forward through a pair of enormous shimmering doors beneath a vaulted portico. '${GREEN}Allow me to introduce to you the Queen of the Northern Lights.${NO_COLOR}'"
    
    clear
    message "${message}"
    carry_on

    local message="Inside you find yourself standing in a vast throne room with a vaulted cathedral-like ceiling filled with swirling, shimmering colors. Supporting the ceiling are colossal pillars made of what appears to be nothing more than clouds and mist.
    
    At the far end of the throne room sits the most beautiful woman you've ever seen. Her skin is white and smooth like porceline, and her eyes are piercing and sharp. Her regal demeanor is most severe."
    
    clear
    message "${message}"
    carry_on

    local message="Oberon greets the queen and introduces you. '${LIGHT_BLUE}Welcome, child,${NO_COLOR}' she greets you. Here eyes, full of swirling mist, look directly into your own, unblinking. They seem both cold and hungry, and you quickly look away.
    
    '${LIGHT_BLUE}Come, Oberon. Let us sit and listen.${NO_COLOR}'"
    
    clear
    message "${message}"
    carry_on

    local message="As the two royals take their seats, the rest of the fairy procession files into the room. Although they were quite jovial before, the whole crowd is now quiet and somber.
    
    '${LIGHT_BLUE}Tell us, Bridget,${NO_COLOR}' the queen says, '${LIGHT_BLUE}What poems do you know? Recite something for us.${NO_COLOR}'"
    
    clear
    message "${message}"
    carry_on

    local message="Recite something? Oh dear, you hadn't prepared for this. Mother had taught you Psalm 23. You also remember the opening verses to the funny Jabberwocky poem. Then again, maybe it would be polite to ask the king and queen what they'd like to hear. Or maybe it would be best to say, 'No, thank you,' so as not to make a fool of yourself."

    clear
    message "${message}"

    local question="What to do?"

    question "${question}"
    actions "Recite Psalm 23" "Recite Jabberwocky" "Take a request" "Recite nothing"
}

recite_psalm_23() {
    ((align_human++))

    local message="You decide to recite Psalm 23. You close your eyes in concentration. 
    
    'The LORD is my shepherd; I shall not want
    He maketh me to lie down in green pastures
    He leadeth me beside the still waters
    He restoreth...'
    
    '${GREEN}STOP!${NO_COLOR}' Oberon's voice booms out across the spaceous hall."

    clear
    message "${message}"
    carry_on

    local message="You open your eyes and look around. The queen is seated on her thrown, leaning away from you, with one hand clasped over her chest. Oberon is standing next to her, his face red with beads of sweat dripping down the sides. His eyes seem filled with fury. All around the room, the party guests appear distraught. Many have their hands over their ears, and some have fallen to their knees.
    
    'I'm sorry,' you say timidly. 'Did I do something wrong?'"

    clear
    message "${message}"
    carry_on

    local message="Oberon seems to remember himself, and his countenance shifts back to its normal cheerful self. '${GREEN}Oh no, dear child,${NO_COLOR}' he croons, mopping his brow with his one hand. '${GREEN}It's just, uh... well, you see... er... it's very late now. I believe it is time we best be on our way. After all, I'm not as young as I used to be,${NO_COLOR}' he says with a slight chuckle.
    
    The rest of the crowd laughs lightly as well, and begins gather itself to depart. It seems strange to be leaving so soon when you had just arrive. But the king seems insistent, and the way the queen looks at you makes you feel distictly unwelcome."

    clear
    message "${message}"
    carry_on

    scene_3_fairie
}

recite_jabberwocky() {
    ((align_fairy++))

    local message="You decide to recite Jabberwocky, or at least what you can remember of it.
    
    ’Twas brillig, and the slithy toves
    Did gyre and gimble in the wabe:
    All mimsy were the borogoves,
    And the mome raths outgrabe.

    “Beware the Jabberwock, my son!
    The jaws that bite, the claws that catch!
    Beware the Jubjub bird, and shun
    The frumious Bandersnatch!”"

    clear
    message "${message}"
    carry_on

    local message="You continue reciting the poem, and before long find that you've quoted the entire thing. You didn't even know you knew the whole thing.
    
    The crowd erupts with cheer and applause. Oberon's laughter rings through among the throne room's pillars and he claps with joy. Even the queen's serene and austere face breaks into a smile as she lighly applauds.
    
    You can't help but smile from ear to ear."

    clear
    message "${message}"
    carry_on

    local message="'${GREEN}Excellent! Absolutely brilliant, my child!${NO_COLOR}' Oberon exclaims. '${GREEN}Come, take your place beside me,${NO_COLOR}' he gestures to a seat beside his. '${GREEN}And let us have more music and dancing!${NO_COLOR}'"

    clear
    message "${message}"
    carry_on

    ending_party
}

take_a_request() {
    ((align_victim++))

    local message="'What would you like to hear?' you ask the king and queen.
    
    '${LIGHT_BLUE}Something of the Tuatha Dé Danann,${NO_COLOR}' the queen answers.
    
    'Oh,' you reply somewhat embarrased. 'I'm afraid I don't know much about the Tuatha Dé Danann, and certainly not any of their poems.'"

    clear
    message "${message}"
    carry_on

    local message="'${GREEN}Do not worry, dear Bridget,${NO_COLOR}' Oberon chuckles. '${GREEN}Sit hear, and learn well.${NO_COLOR}'
    
    You take your seat next to Oberon's as the king steps forward and begins to recite in Gaelic,
    
    Am gaeth i m-muir
    Am tond trethan
    Am fuaim mara
    Am dam secht ndirend
    Am séig i n-aill"

    clear
    message "${message}"
    carry_on

    local end_text=`[[ $tired == true ]] && echo "." || echo ", just like you felt after eating some of the food in Oberon's palace." `

    local message="The whole room is captivated by the king's words. They ring and echo throughout the throne room with an enchanting thrum.
    
    You don't know Gaelic, but somehow you seem to know... or rather feel the meaning of the words. As you listen, some part of you inside feels like you are changing${end_text}
    
    Oberon's recital is followed by a great deal of applause and cheering."

    clear
    message "${message}"
    carry_on

    ending_party
}

recite_nothing() {
    ((align_victor++))

    local message="'Oh... I don't know any poems, your majesty,' you reply.
    
    The queen eyes you with suspicion. '${LIGHT_BLUE}You don't know ${ITALIC}any${END_ITALIC}${LIGHT_BLUE} poems?${NO_COLOR}' she asks.
    
    'No, ma'am,' you reply timidly."

    clear
    message "${message}"
    carry_on

    local message="The queen stares at you expressionless for a moment. Then brusquely remarks, '${LIGHT_BLUE}Hmm. Pity.${NO_COLOR}'
    
    Oberon, seeming eager to ease the tension, forces a chuckle. '${GREEN}Eh, haha! No matter. Uh... Bridget, my dear, come and have a seat next to me.${NO_COLOR}'
    
    Turning to his subjects, the king proclaims with a smile, '${GREEN}Let us have more music and dancing. This is a celebration, after all!${NO_COLOR}'"

    clear
    message "${message}"
    carry_on

    ending_party
}

ending_party() {
    local message="The crowd breaks out into merrymaking just as they had back at Oberon's palace, as though there had been no interruption at all between the two. The party carries on for a good while longer, and only begins to wind down just as a small sliver of light begins to glow along the east horizon.
    
    The entire procession then gathers their things and the few members who had passed out some time during the revelry, and make their way back to their carriages, while you and Oberon bid farewell to the queen."

    clear
    message "${message}"
    carry_on

    scene_3_fairie
}

scene_3_fairie() {
    local message="Before long you find yourself back in Oberon's carriage and whisked away to the palace at the top of the knoll."

    clear
    message "${message}"
    carry_on

    exit_game
}