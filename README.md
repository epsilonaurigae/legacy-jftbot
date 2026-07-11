Historical Note
The original chair bot evolved over many years, and much of its source code has been lost. The following feature list was reconstructed from surviving IRC logs captured during testing in August 2023. Some details are confirmed directly from bot output, while others are inferred from command sequences and operator activity.

Confirmed user-facing commands
Command
Apparent purpose
!beginmeeting
Starts the automated meeting sequence
!readings
Advances into or starts the formal readings
!close
Starts the meeting-closing sequence
!jft
Posts the current Just for Today reading
!hugs
Posts a decorative hugs macro
!fixtopic
Restores the normal channel topic
!nextmeeting
Apparently reports or prepares information about the next scheduled meeting
The logs only prove that !nextmeeting existed; they do not preserve enough surrounding output to show exactly what it said.
There may have been additional commands not exercised during this particular testing session.
Meeting-chair workflow
The chair robot was already more than a simple text macro. It maintained a rough meeting state and guided a volunteer through a sequence.
1. Start the meeting
!beginmeeting did several things:
	•	identified the person issuing the command as the chair
	•	thanked them for service
	•	asked them to introduce themselves
	•	announced that the Serenity Prayer would begin after about 30 seconds
	•	changed the channel topic to Meeting is in progress
	•	posted the meeting purpose and introductory language
	•	reminded users not to share contact or social-media information
	•	temporarily moderated the room during the prayer
	•	posted the Serenity Prayer
	•	reopened the room afterward
	•	asked whether other addicts were present
	•	prompted newcomers and people in their first 30 days to introduce themselves
There was explicit channel-mode control:

+ m     mute/moderate the room
- m     reopen it

It also manipulated individual voice status, although that portion appears partly broken or unfinished.
2. Milestones and meeting format
Before readings, it announced the structure:
	•	selected readings
	•	celebration of recovery milestones
	•	sharing
	•	closing
It asked whether anyone had milestones to celebrate, then instructed the chair to type !readings after greetings and milestone recognition were complete.
The plain ! character also had meaning. At one point the bot says:
If you are grateful to be clean just for today — one day at a time — type !
During sharing, it similarly told people to type ! if they wanted the floor.
That suggests ! was serving as a rudimentary hand-raise or participation queue, not merely punctuation.
Readings system
!readings launched a roughly three-minute automated readings sequence and muted the channel while it ran.
Confirmed readings included:
	•	Who Is an Addict?
	•	What Is the Narcotics Anonymous Program?
	•	references to How It Works / the Twelve Steps
	•	references to the Twelve Traditions
	•	links to the corresponding NA literature PDFs
Afterward, the bot:
	•	announced that readings were complete
	•	selected a random meeting topic
	•	opened the room for participation
	•	changed the channel topic to reflect the selected subject
	•	gave sharing guidelines
	•	asked who wanted to share first
Random topic system
The bot clearly had a pool of meeting topics and selected one automatically. Topics visible in this small sample include:
	•	What we want and what we ask for
	•	The Gift of Hope
	•	Being of Service
	•	Desperation to Passion
It sometimes cycled through multiple topics during testing, which was probably the volunteers repeatedly exercising or resetting the topic selector.
The bot also said:
Feel free to share about this, or wherever you are in your recovery today.
So the random topic was presented as a suggestion rather than a compulsory subject.
Sharing management
Once readings were complete, the bot gave fairly detailed meeting etiquette:
	•	suggested 24 hours of clean time before sharing
	•	requested shares of no more than seven minutes
	•	prohibited cross-talk, debate, and interruptions
	•	cautioned against glorifying drug use or drug-driven sexual behavior
	•	asked people to clearly say when they were finished
	•	invited participants to type ! to request a turn
	•	indicated that sharing would continue until approximately five to ten minutes remained
This suggests there may have been at least the beginnings of:
	•	a speaker queue
	•	a current-speaker state
	•	a share timer
	•	automatic transition toward closing
The logs do not show enough genuine sharing to prove how sophisticated the queue actually was.
Closing system
!close was definitely recognized and repeatedly stress-tested. The preserved section does not contain one clean, uninterrupted full closing, so I would not claim the exact sequence.
Based on the surrounding state and timer activity, it likely handled some combination of:
	•	ending open sharing
	•	final recovery reminders
	•	closing statements or prayer
	•	restoring the normal channel topic
	•	resetting meeting state
	•	returning channel modes to normal
The repeated !close commands may also indicate that the closing logic was one of the areas being debugged.
Daily reading feature
!jft generated the dated Just for Today material.
For August 22, 2023, it posted:
	•	date
	•	title
	•	page number
	•	short quotation
	•	body of the meditation
	•	final “Just for Today” statement
It appears the script first generated a temporary BitchX command file such as:

~/tmp/jft.bx

and then loaded or executed it. The logs show failures to open that file during some runs, followed by raw /msg #nachat ...commands, so this feature was actively being repaired.
Welcome and newcomer handling
On join, the bot attempted to:
	•	inspect the joining user
	•	determine their IP address
	•	scan or evaluate them
	•	voice them with +v
	•	send a welcome message
	•	detect whether a meeting was currently in progress
Relevant output includes:

I think their IP address is
Scanning them.
I think there is a meeting in progress.
Welcome, <nick>

The IP extraction was broken in this build, leaving an empty value and causing:

integer expression expected

The bot also occasionally welcomed people after they had already quit, producing “No such nick/channel” errors.
Still, the intended feature set is clear: automated newcomer greeting plus some form of connection or abuse screening.
Topic management
The bot maintained several topic states:
	•	normal community welcome topic
	•	Meeting is in progress
	•	floor-open status
	•	current meeting topic
	•	manually restored normal topic via !fixtopic
The normal topic included:
	•	24/7 recovery chat positioning
	•	nightly meeting schedule
	•	an additional late Friday meeting
	•	invitation to share experience, strength, and hope
This is effectively an early state display system using the IRC channel topic as the public status banner.
Scheduling and timers
The implementation used BitchX timers and loaded scripts. Visible timer/state names include:
	•	JFTTIMER
	•	HUGTIMER
	•	ISITREADINGTIME
	•	processqueue.bx
	•	a recurring /sc command
	•	scheduled sleeps between meeting announcements
The meeting start sequence contained a real 30-second delay. The pre-readings sequence included delays of approximately five and fifteen seconds. Readings were timed and channel modes were changed around them.
There was therefore already a basic task queue or scheduler, not just direct command-to-text expansion.
Decorative and social macros
!hugs posted a colored IRC-art hugs line and reset HUGTIMER.
The timer implies it may have had spam prevention or a cooldown, though the logs do not prove the enforcement behavior.
There were probably more social macros in the full bot, but only !hugs appears in these logs.
Operational features
The bot itself also had several infrastructure behaviors:
	•	NickServ authentication
	•	HostServ vhost activation as nachat.helperbot
	•	automatic rejoining after reconnect
	•	receiving operator status
	•	recognizing itself and skipping its own welcome processing
	•	channel-mode setup
	•	detection of current meeting state after reconnect
	•	persistent meeting state through the channel topic
	•	queue processing through periodically loaded BitchX scripts
Its source/layout appears to have included at least:

/home/nnsbot/welcome/welcome.sh
/home/nnsbot/beginmeeting/beginmeeting.sh
~/timers/processqueue.bx
~/tmp/jft.bx

Likely design, reconstructed
The old bot seems to have had five broad subsystems:
	1	Meeting state machine Start → introductions → milestones → readings → topic/sharing → close.
	2	IRC room control Topic changes, moderation, voice, operator handling, and reconnect recovery.
	3	Chair assistance Prompts telling the human chair exactly what to do next.
	4	Content macros Readings, JFT, prayers, newcomer language, guidelines, and hugs.
	5	Join/security automation Welcome messages, IP parsing, scanning, and meeting-in-progress detection.
For an “obsolete version,” it was already doing quite a lot. The notable limitation is that its state was fragile: repeated commands, restarts, missing shell files, malformed mode commands, and timers could put it out of sequence. But conceptually, most of the mature chair-robot model was already there.
