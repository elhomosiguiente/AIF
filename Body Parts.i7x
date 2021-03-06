Version 4/150126 of Body Parts by Fictitious Frode begins here.

"Body parts are presented that can be added to any or all persons in a story for greater detail, and sets up a framework for how these might be covered."

[This part is inspired by example 242 (What Not to Wear) of the Inform manual, but modifed and expanded greatly.
Body parts are presented that can be added to any or all persons in a story for greater detail, and sets up a framework for how these might be covered.]

Book 1 - Coverables

A coverable is a kind of thing.
The specification of a coverable is "A coverable is something that can both cover and be covered. It forms the basis for both body parts and clothing (in other extensions)."

Part 1.1 - Relations

[The framework relies on Informs relations to keep track of what covers where. This is defined here, along with some other helpful definitions.]

[The version of covering from example 242 is a recursive use of the overlaying: if A covers B and B cover C, then A also cover C implicitly. This gives us a small bug; Consider the case where A covers B and C; D covers A but does not cover B? Therefore, we instead insist that every piece explicitly states which other parts it cover.]

[The following relations are used by this extension:
* Covering: Specifies which coverables will block access to other parts when worn. Because Inform does not allow references between kinds, we have to "hack" this by making a relationship between all things of the given kinds when play begins.
* Incompatible: Specifies which coverables cannot be worn at the same time.
* Underlying: Specifies coverables are currently blocking other parts.
* Overlaying: The reversal of the Underlying relation.]

[Covering defines which garments will cover which other garments and body parts when worn. It does not mean that the covered item is covered right now.]
Covering relates various coverables to various coverables with fast route-finding.
The verb to cover means the covering relation.

[Underlaying defines which parts are actually covered, and is used by dressing and undressing to keep track of what parts is actually over which other parts, and should not be manually updated.
Similarly, overlaying can be used to se which parts cover.]
Underlaying relates various coverables to various coverables with fast route-finding.
The verb to underlie means the underlaying relation.
The verb to be under implies the underlaying relation.
The verb to overlie means the reversed underlaying relation.
The verb to be over implies the reversed underlaying relation.

[Incompatible defines garments that can not be worn at the same time. This relation is symmetric.]
Incompatible relates various coverables to each other.
The verb to be incompatible with means the incompatible relation.

Part 1.2 - Definitions

[Visible defines which parts can be seen.]
Definition: A coverable is visible if it is not under something opaque.
[Definition: A coverable is visible if it is under something that is visible and transparent.
To decide if (C - a coverable) is visible:
	If C is not under something, decide yes;
	Let covers be the list of coverables overlying C;
	Repeat with current-cover running through covers:
		If current-cover is not visible or current-cover is opaque, decide no;
	Decide yes;]

[Accessible defines which parts can be taken off.]
Definition: a coverable is accessible if it is not under something.

[To decide upon the (B - body part) of a (P - person):
	If P encloses body part of that is B (called A), decide on A;]

Book  2 - Decency

[Decency is a measure of how a character is dressed, derived from how body parts are covered.]
A decency is a kind of value.
The decencies are indecent, immodest, casual, formal and undefined.
A coverable has a decency. The decency of a coverable is usually casual.
A person has a decency. The decency of a person is usually undefined.

[This updates the decency for a person, based on which body parts and other coverable clothing is visible.]
To update decency for (P - a person):
	Let considered-items be the list of coverables worn by P;
	Add the list of body parts that is part of P to considered-items;
	Repeat with I running through considered-items:
		If I is visible and the decency of I is less than the decency of P, now the decency of P is the decency of I;

[Update decency whenever someone changes clothing]
Carry out an actor taking off a coverable:
	Update decency for actor;
Carry out an actor wearing a coverable:
	Update decency for actor;

[Clothing that is defined as worn, is never actually put on, so the relations have not been updated. This updates those relations, and updates decency if needed.
Release 6M62 made it impossible to loop over all persons, so we have to do this small hack instead:]
When play begins:
	Repeat with P running through the list of persons that is not the player:
		Update clothing for P;
	Update clothing for player;

To update clothing for (P - a person):
	Repeat with G running through the list of coverables worn by P:
		Repeat with W running through coverables worn by P:
			If G overlies W, now W underlies the G;
		Repeat with B running through the list of body parts enclosed by P:
			If G overlies B, now B underlies the G;
	If the decency of P is undefined, update decency for P;

Book 3 - Body Parts

A body part is a kind of coverable.
The specification of body part is "Body part is intended as a base ancestor for all the various body parts that can be created, and is not intended to be invoked directly, although nothing would stop it from working. Body parts can be defined as lickable (allows licking and biting) and rubbable (allows rubbing and pinching), and are usually casually decent."

A body part can be lickable. A body part is usually not lickable. [Defines which parts can be licked and bitten.]
A body part can be rubbable. A body part is usually not rubbable. [Defines which parts can be rubbed and pinched.]

A sexual ability is a kind of value.
The sexual abilities are penetrating, orificial and non-sexual.
A thing has a sexual ability. The sexual ability of a thing is usually non-sexual.

Does the player mean examining a body part that is part of the player: It is unlikely.

Part 3.1 - Specific Body Parts

[Define body parts that are ready to use. These must explicitly be made part of any (or every) person that needs them.]
A pair of feet is a kind of body part.
The specification of pair of feet is "Represents the feet of a person. They are usually immodest and not rubbable or lickable."
The plural of feet is pairs of feet. They are plural-named. The indefinite article is "a".
The description of a pair of feet is usually "A pair of normal feet."
A pair of feet is usually immodest.

A pair of legs is a kind of body part.
The specification of pair of legs is "Represents the legs of a person. They are usually casual and not rubbable or lickable."
The plural of some legs is pairs of legs. They are plural-named. The indefinite article is "a".
The description of a pair of legs is usually "Long and shapely legs."

A pair of thighs is a kind of body part.
The specification of pair of thighs is "Represents the thighs of a person. They are usually casual and not rubbable or lickable."
The plural of some thighs is pairs of thighs. They are plural-named. The indefinite article is "a".
A pair of thighs is usually immodest.
The description of a pair of thighs is usually "Formfull and voluptoous."

A tummy is a kind of body part.
The specification of pair of legs is "Represents the tummy of a person. It is usually immodest and not rubbable or lickable."
The description of a tummy is usually "It's a soft, normal, tummy."
A pair of thighs is usually immodest.
Understand "stomach" as tummy.

A pair of armpits is a kind of body part.
The plural of some armpits is pairs of armpits. They are plural-named. The indefinite article is "a".
The specification of pair of thighs is "Represents the thighs of a person. They are usually immodest and not rubbable or lickable."
A pair of armpits is usually immodest.
The description of armpits is usually "Hopefully, they are clean."

A chest is a kind of body part.
The specification of pair of thighs is "Represents the chest/torso of a (usually male) person. It is usually immodest and both rubbable and lickable."
A chest is usually immodest.
A chest is usually rubbable.
A chest is usually lickable.
The description of a chest is usually "It looks firm and muscular."

A pair of breasts is a kind of body part.
The specification of pair of thighs is "Represents the breasts of a (usually female) person. They are usually indecent and both rubbable and lickable. They are also considered orificial, to allow fucking."
The plural of breasts is pairs of breasts. They are plural-named. The indefinite article is "a".
A pair of breasts is usually indecent.
A pair of breasts is usually lickable.
A pair of breasts is usually rubbable.
The sexual ability of a pair of breasts is usually orificial.
The description of a pair of breasts is usually "A pair of plump breasts."
Understand "tit/tits/breast/breasts/boob/boobs/tittie/titties/juggs" as a pair of breasts.

A pair of arms is a kind of body part.
The specification of pair of thighs is "Represents the arms of a person. They are usually casual and not rubbable or lickable."
The plural of some arms is pairs of arms. They are plural-named.
The description of a pair of arms is usually "It's a pair of normal arms."

A pair of hands is a kind of body part.
The specification of pair of thighs is "Represents the hands of a person. They are usually casual and not rubbable or lickable."
The plural of some hands is pairs of hands. They are plural-named. The indefinite article is "a".
The description of a pair of hands is usually "A normal pair of hands, with five fingers on each."

A head is a kind of body part.
The specification of head is "Represents the head of a person. It is usually casual and not rubbable or lickable."
The description of a head is usually "It's a pretty normal head, as far as a human goes. Mouth, nose, two eyes, two ears and hair on the top."

A mouth is a kind of body part.
The specification of mouth is "Represents the mouth of a person. It is usually casual and lickable but not rubbable. It is not usually considered an orifice, to stop fucking, but this can be altered with 'A mouth is usually orificial'."
The description of a mouth is usually "It's the organ used for talking and eating, amongst other things."
Understand "lips" as mouth.
A mouth is usually lickable.

A pair of eyes is a kind of body part.
The specification of pair of eyes is "Represents the eyes of a person. They are usually casual and not rubbable or lickable."
The plural of some eyes is pairs of eyes. They are plural-named. The indefinite article is "a".
The description of a pair of eyes is usually "It's a pair of deep blue eyes."

Some hair is a kind of body part.
The specification of hair is "Represents the hair of a person. It is usually immodest and not rubbable or lickable."
The description of some hair is usually "It's a tangle of brown hair."

An ass is a kind of body part.
The specification of ass is "Represents the ass of a person, and usually is meant to cover both the hole and the cheeks. It is usually indecent and rubbable but not lickable. It is orificial."
The plural of ass is asses. They are plural-named.
An ass is usually indecent.
An ass is usually rubbable.
The sexual ability of an ass is usually orificial.
The description of an ass is usually "A pair of firm buttcheeks."
Understand "ass / asshole / anus / rear / backside / butt / bottom / rump / rear end" as ass.

A penis is a kind of body part.
The specification of penis is "Represents the penis of a (usually female) person. It is usually indecent and both rubbable and lickable. It is also considered penetrating, for us in fucking."
A penis is usually penetrating.
A penis is usually indecent.
A penis is usually lickable.
A penis is usually rubbable.
The description of a penis is usually "Thick and hard."
Understand "cock/dick/wang/dong/wiener/willy/schlong/boner/pecker" as penis.

A vagina is a kind of body part.
The specification of vagina is "Represents the vagina of a (usually female) person. It is usually indecent and both rubbable and lickable. It is also considered orificial for fucking."
A vagina is usually indecent.
The sexual ability of a vagina is usually orificial.
A vagina is usually lickable.
A vagina is usually rubbable.
The description of a vagina is usually "Warm and wet, like hot apple pie."
Understand "pussy/cunt/slit/crotch/snatch/clitoris/clit/twat" as vagina.

Book 4 - Actions

Part 4.1 - Being Silly

[Stop the player from doing silly stuff with body parts.]
Taking a body part is being silly. 
Dropping a body part is being silly. 
Removing a body part from someone is being silly. 
Giving a body part to someone is being silly. 
Taking off a body part is being silly. 
Throwing a body part at something is being silly. 
Pushing a body part is being silly. 
Turning a body part is being silly. 
Putting a body part on something is being silly. 
Consulting a body part about something is being silly. 
Waking a body part is being silly. 

Instead of being silly, say "Don't be silly!"
Instead of asking someone to try being silly, say "Don't be silly!"

Part 4.2 - Stripping

[The fundamentals of stripping is defined here, so that it other framework components can extend it, and not conflict with each other by trying to redefine the action.]

[Stripping is the action of removing all clothes.]
Stripping is an action applying to nothing.
The specification of the stripping action is "Stripping is intended to remove all clothing a person is wearing. This version is only implemented as a bare bones, for other extensions to build on, and only includes the reporting stage."
Understand "strip", "undress", "disrobe" as stripping.

[Report so the player knows the command worked.]
Report an actor stripping (this is the default stripping report rule):
	If the actor is not wearing any coverables, say "[If the player is the actor][We][else][Actor][end if] [are] [now] nude." (A);
	Else say "[If the player is the actor][We][else][Actor][end if] [are] still wearing [list of coverables worn by player]." (B);

Body Parts ends here.

---- DOCUMENTATION ----

This extension makes available two new kinds; coverable and body part. Coverable is not intended for direct use, but as a common ancestor for anything that can be covered by clothing. Body part is a descendant provided here, and provides the mean to give more detail and flexibility to characters in a story. Note, this extension is best used together with either Garments or Outfits.

Chapter - Using this Extension

None of the body parts provided by this extensions is automatically put in use; the author must decide which ones are to be used, and apply them to the characters they are needed for. Every person that has body parts attached to them should also have a description for those parts. See Example A for how to add body parts.

Note; Inform can behave slightly odd regarding the naming (and creation) of body parts which are part of the character, this is described in chapter 4.15 of Writing with Inform. If the player is declared after the creation of the body part, then the body part will be named after what the character was named. Also, any gender-specific creations might not occur if the gender of the player was undetermined at that point. Likewise, changing the identity of the player during play might give interesting results.

In short, declare the player (with gender) before invoking body part creation.

Section - Decency

Decency is a measure of how much "skin" a person is showing off, and is automatically calculated whenever a person takes off or puts on a piece of clothing (that follows the framework standards). This part of the framework does not do any checking for decency, but leaves that in the hand of the story author. This can be used to stop the player moving around like this:

*:
	Instead of going somewhere while indecent, say "You can't go anywhere looking like that!"

The framework defines five levels of decency, of which four are in use. In ascending order, they are indecent, immodest, casual, formal and undefined. Undefined is a special case; it is the default decency for a person and any person with undefined as decency will have their decency calculated at start-up. This means that story authors can skip this calculation by manually defining (hopefully the correct) decency of a person in order to save time at start-up.

The default decency for body parts (and other coverables) is casual. This means, nothing will ever be formal by accident.

Section - List of Body Parts

The following body parts are available:
	A pair of feet (immodest)
	A pair of legs
	A pair of thighs (immodest)
	A tummy / stomach (immodest)
	A pair of armpits (immodest)
	A chest (male torso) (immodest) - Lickable, Rubbable
	A pair of breasts (female torso) (indecent) - Lickable, Rubbable
	A pair of arms
	A pair of hands
	A head
	A mouth - Lickable
	A pair of eyes
	Some hair
	An ass (indecent) - Rubbable
	A penis (indecent) - Lickable, Rubbable
	A vagina (indecent) - Lickable, Rubbable

Section - Visibility and Acessibility

The framework does not concern itself with blocking vision of covered body parts, as most body parts are obviously present even when covered by clothing. Instead, the author should take into account visibility when describing the body parts. Visible means any piece that is worn outmost, or is covered by a transparent piece (but only throuh 1 layer), while accessible means that the piece is worn outmost.
Example B shows how to make variable descriptions based on what is visible, and Example C shows how to block vision of covered body parts.

Note: The frameworks for outfits will do a lot of this.

Section - Stripping

This extensions defines the bare bones of the stripping function, leaving it up to extensions that expand it with clothing to implement the necessary check and carry out functions that are necessary for those to work.
This part is extended by the frameworks for clothing (garments and outfits), but in order to have them not conflict with each other the core implementation is defined here.

Chapter - Technical Notes

This framework is based on the relationship model built into Inform 7. Here's the meaning of the relations used:

	Covering relation: Defines which parts should go on top of other parts when worn. The covering relation is only safe to assume actually covers something if it's also made sure that the item is worn, use the overlying relation (below) to see if something actually is worn atop something else.
	Incompatible relation: Symmetric relationship between two kinds that can never be worn together.
	Underlaying relation: Defines which parts are actually covered, and what part does the covering.
	Overlying relation: The reversal of the underlaying relation.

Body parts also get some attributes that are intended for use with later extensions. The most important is the "sexual ability" attribute, which is one of orificial, penetrating and non-sexual. By default, everything is non-sexual. In short; orificial things can be fucked, while penetrating things can be used to fuck.

Section - Creating New Body Parts

Adding a new kind of body part is very easy; Example D shows how feet are defined in the framework. The main work in adding new body parts is defining which parts of clothing fit over them; this is covered in the extensions for clothing / garments.

Section - Version History

Release 4 (v1.1)

	Fixes compatibility with Inform 6M62
	The relationships model has been changed, as per the technical notes above. Overlying no longer is the same as covering, but instead is the reversal of the underlying.
	Improved documentation (specification).

Release 3 (v1.0): 

	Added eyes, hair and mouth as body parts.
	Added rubbable as a property.
	Improved understanding of what the player means.

Release 2 (v0.6): 

	No code changes, but documentation improved.

Section - Contact Info

The author of the framework can be reached in the following ways:

	* Mail: fictitious.frode@gmail.com
	* Blog: https://informedaif.wordpress.com/ is a blog dedicated to writing AIF with Inform 7, and is the official host of the framework. It contains both dicussions around AIF and tutorials on both Inform in general and this framework in particular.
	* Reddit: https://www.reddit.com/r/AIFCentral/ is the subreddit for the AIF community, and the author checks this regularly.

Feedback of all varieties is welcome, but constructive criticism and discussion is the most appreciated, along with reports of bugs and other issues. For support I would appreciate using public communication, so that other may learn from the request as well.

Example: * Body Parts - Enabling body parts

*:
	The Library is a room,
	Anna is a woman in the Library.
	A head is part of every person.
	A pair of feet is a part of every woman.

	The description of Anna's head is "A pretty plain head."
	
	Test me with "x Anna's head / x feet / x your head."

Example: * Visibility 1 - Description of a body part, taking into account if it is covered:

	The Library is a room,
	Anna is a woman in the Library.
	A pair of feet is a part of every person.

	The description of Anna's feet is "[if Anna's feet are visible]A pair of hairy feet.[else]The feet are covered by [list of visible coverables covering Anna's feet]."

Example: ** Visibility 2 - Stopping the player from examining a covered body part:

*:
	Check examining a body part that is not visible (this is the block covered body parts rule):
		Say "[We] [cannot] [see] that."(A) instead;

Example: *** Custom Body Parts - The definition of "feet" from the framework

	A pair of feet is a kind of body part.
	The specification of pair of feet is "Represents the feet of a person. They are usually immodest and not rubbable or lickable."
	The plural of feet is pairs of feet. They are plural-named.
	The description of a pair of feet is usually "A pair of normal feet."
	A pair of feet is usually immodest.
