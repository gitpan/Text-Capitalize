package __title_tests;

# Test cases for Text::Capitalize
# DEPRECATED

require 5.000;

use locale;
use strict;
use Exporter;
use vars qw(@ISA @EXPORT @EXPORT_OK $VERSION);
use vars qw(@test_cases
            %expect_capitalize_title_default
            %expect_capitalize_title_PRESERVE_WHITESPACE
            %expect_capitalize_title_PRESERVE_ALLCAPS
            %expect_capitalize_title_PRESERVE_ANYCAPS
            %expect_capitalize_title_PRESERVE_ALLCAPS_PRESERVE_WHITESPACE
            %expect_capitalize_title_PRESERVE_ANYCAPS_PRESERVE_WHITESPACE
            %expect_random_case
            %expect_scramble_case
           );

@ISA		= qw(Exporter);
@EXPORT		= qw();
@EXPORT_OK      = qw(@test_cases
                     %expect_capitalize_title_default
                     %expect_capitalize_title_PRESERVE_WHITESPACE
                     %expect_capitalize_title_PRESERVE_ALLCAPS
                     %expect_capitalize_title_PRESERVE_ANYCAPS
                     %expect_capitalize_title_PRESERVE_ALLCAPS_PRESERVE_WHITESPACE
                     %expect_capitalize_title_PRESERVE_ANYCAPS_PRESERVE_WHITESPACE
                     %expect_random_case
                     %expect_scramble_case
                    );

$VERSION	= '0.4';  # to match Text::Capitalize version

# Some possibly useful test case strings.
# The %expect_* series below is what's actually used by "make test"

@test_cases = (
      "This And ThAt",
      "Revenge is Doom's",
      "forget gilroy, A. Snakhausem was here",
      "the end of the dream: three-holed button manufacture in a four-holed world",
      "chords against culture -- counter-sexist themes in the later works of Fetal Tissue Kleenex",
      'a history of n.a.s.a.',
      'the n.a.s.a. sucks rag',
      's.a.d. days t.a.n. shades',
      "it's the man's, you know?",
      "hey doc the ticker is hocked, the dial is locked, the face is botoxed, whazzup?",
      "Hell's Swells",
      "you're wrong, it doesn't fly, it's not there and they're lost, so you'd better not",
      "DOODZ I AM SO THERE! NOT.",
      "Tis called perserverence in a good cause, and obstinacy in a bad one.",
      "And the rest is silence...",
      'a brief history of the word of',
      'AWOL in the DMZ of WWIII',
      "TLAs i have known and loved",
      "The Next iMac: Just Another NeXt?",
      "Mr. Wong and Dr. And Report",
      "Quinn Weaver, agent of SFPUG",
      "sarcasm, yet",
      "sarcasm yet not humor",
      "...and justice for all",
      "kill 'em all",
      "history of the gort-verada-nictu moving company",
      "Erratic spacing:  your KEY    to     creativity   ",
      "it came from texas:  the new new world order?",
      "pOiksIFiciZaLaTIonoRyISM",
      "What about: a an the and or nor for but so yet not to of by at for but in, huh?",
      "Ah ha: and so forth",
      "a theory I have",
      "and/or testified it shall be",
      "...nor lost, nor found",
      "Ask not",
      "'for not!', he said.",
      "\"but so!\", sayeth I",
      'The wind whispers "But!"',
      'say "but!", say what?',
      "yet by and by but in for to",
      "-- ack, ack, bang!",
      '  very spacey  ',
      '  ...huh?   ',
      'Didaktische Überlegungen/Erfahrungsbericht über den Computereinsatz im geisteswissenschaftlichen Unterricht am Bsp. "Historische Zeitung"',
      'über maus',
      'Explicación dél significado de los términos utilizados en "Don Quijote", por capítulo.',
      "où l'on découvre une époque à travers l'oeuvre imposante d'Honoré de Balzac",
      "évêque, qu'il eût aimé voir infliger à ceux qui ont abdiqué, J'ai été reçu, and pepe le peau",
      "Baron von Arnheim's revenge",
      "forget gilroy, A. Snakhausem was here",
      'The 13 Clocks',
      'The 4 False Weapons',
      '10 Little-Endians',
      'the dirty 27',
      'machine13',
      'ice9count0',
      "Why? Well, why not?",
      "Ping... ping... ping... pong!",
      "Document. Test. Code. Repeat.",
      "And so they tramped on through the night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp..." ,
      "And more. And still more.",
      "mo' beta-testing",
      'a laboratory of the open fields',
      'Scientific Study of the So-called Psychical Processes in the Higher Animals',
      'The Running-Down of the Universe',
      'In the beginning... was the global-set-key',
      'how should one read a book?',
      'of beauty',
      'on style',
      "As I Ebb'd with the Ocean of Life",
      "When I Heard the Learn'd Astronomer",
      "From Pent-Up Aching Rivers",
      "One's Self I Sing",
      "BEAT! BEAT! DRUMS!",
      "The Wound-Dresser",
      "Pain--has an Element of Blank",
      ''
);


# Hash of test cases (keys) and expected results (values) for the
# vanillia "capitalize_title" sub, without options.

%expect_capitalize_title_default = (
     'This And ThAt' =>
        'This and That',
     "Revenge is Doom's" =>
        "Revenge Is Doom's",
     'the end of the dream: three-holed button manufacture in a four-holed world' =>
        'The End of the Dream: Three-Holed Button Manufacture in a Four-Holed World',
     'chords against culture -- counter-sexist themes in the later works of Fetal Tissue Kleenex' =>
        'Chords Against Culture -- Counter-Sexist Themes in the Later Works of Fetal Tissue Kleenex',
     'a history of n.a.s.a.' =>
        'A History of N.A.S.A.',
     'the n.a.s.a. sucks rag' =>
        'The N.A.S.A. Sucks Rag',
     's.a.d. days t.a.n. shades' =>
        'S.A.D. Days T.A.N. Shades',
     'it\'s the man\'s, you know?' =>
        'It\'s the Man\'s, You Know?',
     'hey doc the ticker is hocked, the dial is locked, the face is botoxed, whazzup?' =>
        'Hey Doc the Ticker Is Hocked, the Dial Is Locked, the Face Is Botoxed, Whazzup?',
     'Hell\'s Swells' =>
        'Hell\'s Swells',
     'you\'re wrong, it doesn\'t fly, it\'s not there and they\'re lost, so you\'d better not' =>
        'You\'re Wrong, It Doesn\'t Fly, It\'s Not There and They\'re Lost, so You\'d Better Not',
     'DOODZ I AM SO THERE! NOT.' =>
        'Doodz I Am so There! Not.',
     'Tis called perserverence in a good cause, and obstinacy in a bad one.' =>
        'Tis Called Perserverence in a Good Cause, and Obstinacy in a Bad One.',
     'And the rest is silence...' =>
        'And the Rest Is Silence...',
     'a brief history of the word of' =>
        'A Brief History of the Word Of',
     'AWOL in the DMZ of WWIII' =>
        'Awol in the Dmz of Wwiii',
     'TLAs i have known and loved' =>
        'Tlas I Have Known and Loved',
     'The Next iMac: Just Another NeXt?' =>
        'The Next Imac: Just Another Next?',
     'Mr. Wong and Dr. And Report' =>
        'Mr. Wong and Dr. And Report',
     'Quinn Weaver, agent of SFPUG' =>
        'Quinn Weaver, Agent of Sfpug',
     'sarcasm, yet' =>
        'Sarcasm, Yet',
     'sarcasm yet not humor' =>
        'Sarcasm yet Not Humor',
     '...and justice for all' =>
        '...And Justice for All',
     'kill \'em all' =>
        'Kill \'Em All',
     'history of the gort-verada-nictu moving company' =>
        'History of the Gort-Verada-Nictu Moving Company',
     'Erratic spacing:  your KEY    to     creativity   ' =>
        'Erratic Spacing: Your Key to Creativity',
     'it came from texas:  the new new world order?' =>
        'It Came From Texas: The New New World Order?',
     'pOiksIFiciZaLaTIonoRyISM' =>
        'Poiksificizalationoryism',
     'What about: a an the and or nor for but so yet not to of by at for but in, huh?' =>
        'What About: A an the and or nor for but so yet Not to of by at for but in, Huh?',
     'Ah ha: and so forth' =>
        'Ah Ha: And so Forth',
     'a theory I have' =>
        'A Theory I Have',
     'and/or testified it shall be' =>
        'And/or Testified It Shall Be',
     '...nor lost, nor found' =>
        '...Nor Lost, nor Found',
     'Ask not' =>
        'Ask Not',
     '\'for not!\', he said.' =>
        '\'For Not!\', He Said.',
     '"but so!", sayeth I' =>
        '"But So!", Sayeth I',
     'The wind whispers "But!"' =>
        'The Wind Whispers "But!"',
     'say "but!", say what?' =>
        'Say "But!", Say What?',
     'yet by and by but in for to' =>
        'Yet by and by but in for To',
     '-- ack, ack, bang!' =>
        '-- Ack, Ack, Bang!',
     '  very spacey  ' =>
        'Very Spacey',
     '  ...huh?   ' =>
        '...Huh?',
     'Didaktische Überlegungen/Erfahrungsbericht über den Computereinsatz im geisteswissenschaftlichen Unterricht am Bsp. "Historische Zeitung"' =>
        'Didaktische Überlegungen/Erfahrungsbericht Über Den Computereinsatz Im Geisteswissenschaftlichen Unterricht Am Bsp. "Historische Zeitung"',
     'über maus' =>
        'Über Maus',
     'Explicación dél significado de los términos utilizados en "Don Quijote", por capítulo.' =>
        'Explicación Dél Significado de Los Términos Utilizados En "Don Quijote", Por Capítulo.',
     'l\'oeuvre imposante d\'Honoré de Balzac' =>
        'L\'Oeuvre Imposante d\'Honoré de Balzac',
     'Baron von Arnheim\'s revenge' =>
        'Baron von Arnheim\'s Revenge',
     'forget gilroy, A. Snakhausem was here' =>
        'Forget Gilroy, A. Snakhausem Was Here',
     'The 13 Clocks' =>
        'The 13 Clocks',
     'The 4 False Weapons' =>
        'The 4 False Weapons',
     '10 Little-Endians' =>
        '10 Little-Endians',
     'the dirty 27' =>
        'The Dirty 27',
     'machine13' =>
        'Machine13',
     'ice9count0' =>
        'Ice9count0',
     'Why? Well, why not?' =>
        'Why? Well, Why Not?',
     'Ping... ping... ping... pong!' =>
        'Ping... Ping... Ping... Pong!',
     'Document. Test. Code. Repeat.' =>
        'Document. Test. Code. Repeat.',
     'And so they tramped on through the night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...' =>
        'And so They Tramped On Through the Night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...',
     'And more. And still more.' =>
        'And More. And Still More.',
     'mo\' beta-testing' =>
        'Mo\' Beta-Testing',
     'a laboratory of the open fields' =>
        'A Laboratory of the Open Fields',
     'Scientific Study of the So-called Psychical Processes in the Higher Animals' =>
        'Scientific Study of the so-Called Psychical Processes in the Higher Animals',
     'The Running-Down of the Universe' =>
        'The Running-Down of the Universe',
     'In the beginning... was the global-set-key' =>
        'In the Beginning... Was the Global-Set-Key',
     'how should one read a book?' =>
        'How Should One Read a Book?',
     'of beauty' =>
        'Of Beauty',
     'on style' =>
        'On Style',
     'As I Ebb\'d with the Ocean of Life' =>
        'As I Ebb\'d with the Ocean of Life',
     'When I Heard the Learn\'d Astronomer' =>
        'When I Heard the Learn\'d Astronomer',
     'From Pent-Up Aching Rivers' =>
        'From Pent-Up Aching Rivers',
     'One\'s Self I Sing' =>
        'One\'s Self I Sing',
     'BEAT! BEAT! DRUMS!' =>
        'Beat! Beat! Drums!',
     'The Wound-Dresser' =>
        'The Wound-Dresser',
     'Pain--has an Element of Blank' =>
        'Pain--Has an Element of Blank',
     '' =>
        '',
);


%expect_capitalize_title_PRESERVE_WHITESPACE = (
     'This And ThAt' =>
        'This and That',
     "Revenge is Doom's" =>
        "Revenge Is Doom's",
     'the end of the dream: three-holed button manufacture in a four-holed world' =>
        'The End of the Dream: Three-Holed Button Manufacture in a Four-Holed World',
     'chords against culture -- counter-sexist themes in the later works of Fetal Tissue Kleenex' =>
        'Chords Against Culture -- Counter-Sexist Themes in the Later Works of Fetal Tissue Kleenex',
     'a history of n.a.s.a.' =>
        'A History of N.A.S.A.',
     'the n.a.s.a. sucks rag' =>
        'The N.A.S.A. Sucks Rag',
     's.a.d. days t.a.n. shades' =>
        'S.A.D. Days T.A.N. Shades',
     'it\'s the man\'s, you know?' =>
        'It\'s the Man\'s, You Know?',
     'hey doc the ticker is hocked, the dial is locked, the face is botoxed, whazzup?' =>
        'Hey Doc the Ticker Is Hocked, the Dial Is Locked, the Face Is Botoxed, Whazzup?',
     'Hell\'s Swells' =>
        'Hell\'s Swells',
     'you\'re wrong, it doesn\'t fly, it\'s not there and they\'re lost, so you\'d better not' =>
        'You\'re Wrong, It Doesn\'t Fly, It\'s Not There and They\'re Lost, so You\'d Better Not',
     'DOODZ I AM SO THERE! NOT.' =>
        'Doodz I Am so There! Not.',
     'Tis called perserverence in a good cause, and obstinacy in a bad one.' =>
        'Tis Called Perserverence in a Good Cause, and Obstinacy in a Bad One.',
     'And the rest is silence...' =>
        'And the Rest Is Silence...',
     'a brief history of the word of' =>
        'A Brief History of the Word Of',
     'AWOL in the DMZ of WWIII' =>
        'Awol in the Dmz of Wwiii',
     'TLAs i have known and loved' =>
        'Tlas I Have Known and Loved',
     'The Next iMac: Just Another NeXt?' =>
        'The Next Imac: Just Another Next?',
     'Mr. Wong and Dr. And Report' =>
        'Mr. Wong and Dr. And Report',
     'Quinn Weaver, agent of SFPUG' =>
        'Quinn Weaver, Agent of Sfpug',
     'sarcasm, yet' =>
        'Sarcasm, Yet',
     'sarcasm yet not humor' =>
        'Sarcasm yet Not Humor',
     '...and justice for all' =>
        '...And Justice for All',
     'kill \'em all' =>
        'Kill \'Em All',
     'history of the gort-verada-nictu moving company' =>
        'History of the Gort-Verada-Nictu Moving Company',
     'Erratic spacing:  your KEY    to     creativity   ' =>
        'Erratic Spacing:  Your Key    to     Creativity   ',
     'it came from texas:  the new new world order?' =>
        'It Came From Texas:  The New New World Order?',
     'pOiksIFiciZaLaTIonoRyISM' =>
        'Poiksificizalationoryism',
     'What about: a an the and or nor for but so yet not to of by at for but in, huh?' =>
        'What About: A an the and or nor for but so yet Not to of by at for but in, Huh?',
     'Ah ha: and so forth' =>
        'Ah Ha: And so Forth',
     'a theory I have' =>
        'A Theory I Have',
     'and/or testified it shall be' =>
        'And/or Testified It Shall Be',
     '...nor lost, nor found' =>
        '...Nor Lost, nor Found',
     'Ask not' =>
        'Ask Not',
     '\'for not!\', he said.' =>
        '\'For Not!\', He Said.',
     '"but so!", sayeth I' =>
        '"But So!", Sayeth I',
     'The wind whispers "But!"' =>
        'The Wind Whispers "But!"',
     'say "but!", say what?' =>
        'Say "But!", Say What?',
     'yet by and by but in for to' =>
        'Yet by and by but in for To',
     '-- ack, ack, bang!' =>
        '-- Ack, Ack, Bang!',
     '  very spacey  ' =>
        '  Very Spacey  ',
     '  ...huh?   ' =>
        '  ...Huh?   ',
     'Didaktische Überlegungen/Erfahrungsbericht über den Computereinsatz im geisteswissenschaftlichen Unterricht am Bsp. "Historische Zeitung"' =>
        'Didaktische Überlegungen/Erfahrungsbericht Über Den Computereinsatz Im Geisteswissenschaftlichen Unterricht Am Bsp. "Historische Zeitung"',
     'über maus' =>
        'Über Maus',
     'Explicación dél significado de los términos utilizados en "Don Quijote", por capítulo.' =>
        'Explicación Dél Significado de Los Términos Utilizados En "Don Quijote", Por Capítulo.',
     'l\'oeuvre imposante d\'Honoré de Balzac' =>
        'L\'Oeuvre Imposante d\'Honoré de Balzac',
     'Baron von Arnheim\'s revenge' =>
        'Baron von Arnheim\'s Revenge',
     'forget gilroy, A. Snakhausem was here' =>
        'Forget Gilroy, A. Snakhausem Was Here',
     'The 13 Clocks' =>
        'The 13 Clocks',
     'The 4 False Weapons' =>
        'The 4 False Weapons',
     '10 Little-Endians' =>
        '10 Little-Endians',
     'the dirty 27' =>
        'The Dirty 27',
     'machine13' =>
        'Machine13',
     'ice9count0' =>
        'Ice9count0',
     'Why? Well, why not?' =>
        'Why? Well, Why Not?',
     'Ping... ping... ping... pong!' =>
        'Ping... Ping... Ping... Pong!',
     'Document. Test. Code. Repeat.' =>
        'Document. Test. Code. Repeat.',
     'And so they tramped on through the night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...' =>
        'And so They Tramped On Through the Night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...',
     'And more. And still more.' =>
        'And More. And Still More.',
     'mo\' beta-testing' =>
        'Mo\' Beta-Testing',
     'a laboratory of the open fields' =>
        'A Laboratory of the Open Fields',
     'Scientific Study of the So-called Psychical Processes in the Higher Animals' =>
        'Scientific Study of the so-Called Psychical Processes in the Higher Animals',
     'The Running-Down of the Universe' =>
        'The Running-Down of the Universe',
     'In the beginning... was the global-set-key' =>
        'In the Beginning... Was the Global-Set-Key',
     'how should one read a book?' =>
        'How Should One Read a Book?',
     'of beauty' =>
        'Of Beauty',
     'on style' =>
        'On Style',
     'As I Ebb\'d with the Ocean of Life' =>
        'As I Ebb\'d with the Ocean of Life',
     'When I Heard the Learn\'d Astronomer' =>
        'When I Heard the Learn\'d Astronomer',
     'From Pent-Up Aching Rivers' =>
        'From Pent-Up Aching Rivers',
     'One\'s Self I Sing' =>
        'One\'s Self I Sing',
     'BEAT! BEAT! DRUMS!' =>
        'Beat! Beat! Drums!',
     'The Wound-Dresser' =>
        'The Wound-Dresser',
     'Pain--has an Element of Blank' =>
        'Pain--Has an Element of Blank',
     '' =>
        '',
);


%expect_capitalize_title_PRESERVE_ALLCAPS = (
     'This And ThAt' =>
        'This and That',
     "Revenge is Doom's" =>
        "Revenge Is Doom's",
     'the end of the dream: three-holed button manufacture in a four-holed world' =>
        'The End of the Dream: Three-Holed Button Manufacture in a Four-Holed World',
     'chords against culture -- counter-sexist themes in the later works of Fetal Tissue Kleenex' =>
        'Chords Against Culture -- Counter-Sexist Themes in the Later Works of Fetal Tissue Kleenex',
     'a history of n.a.s.a.' =>
        'A History of N.A.S.A.',
     'the n.a.s.a. sucks rag' =>
        'The N.A.S.A. Sucks Rag',
     's.a.d. days t.a.n. shades' =>
        'S.A.D. Days T.A.N. Shades',
     'it\'s the man\'s, you know?' =>
        'It\'s the Man\'s, You Know?',
     'hey doc the ticker is hocked, the dial is locked, the face is botoxed, whazzup?' =>
        'Hey Doc the Ticker Is Hocked, the Dial Is Locked, the Face Is Botoxed, Whazzup?',
     'Hell\'s Swells' =>
        'Hell\'s Swells',
     'you\'re wrong, it doesn\'t fly, it\'s not there and they\'re lost, so you\'d better not' =>
        'You\'re Wrong, It Doesn\'t Fly, It\'s Not There and They\'re Lost, so You\'d Better Not',
     'DOODZ I AM SO THERE! NOT.' =>
        'DOODZ I AM SO THERE! NOT.',
     'Tis called perserverence in a good cause, and obstinacy in a bad one.' =>
        'Tis Called Perserverence in a Good Cause, and Obstinacy in a Bad One.',
     'And the rest is silence...' =>
        'And the Rest Is Silence...',
     'a brief history of the word of' =>
        'A Brief History of the Word Of',
     'AWOL in the DMZ of WWIII' =>
        'AWOL in the DMZ of WWIII',
     'TLAs i have known and loved' =>
        'Tlas I Have Known and Loved',
     'The Next iMac: Just Another NeXt?' =>
        'The Next Imac: Just Another Next?',
     'Mr. Wong and Dr. And Report' =>
        'Mr. Wong and Dr. And Report',
     'Quinn Weaver, agent of SFPUG' =>
        'Quinn Weaver, Agent of SFPUG',
     'sarcasm, yet' =>
        'Sarcasm, Yet',
     'sarcasm yet not humor' =>
        'Sarcasm yet Not Humor',
     '...and justice for all' =>
        '...And Justice for All',
     'kill \'em all' =>
        'Kill \'Em All',
     'history of the gort-verada-nictu moving company' =>
        'History of the Gort-Verada-Nictu Moving Company',
     'Erratic spacing:  your KEY    to     creativity   ' =>
        'Erratic Spacing: Your KEY to Creativity',
     'it came from texas:  the new new world order?' =>
        'It Came From Texas: The New New World Order?',
     'pOiksIFiciZaLaTIonoRyISM' =>
        'Poiksificizalationoryism',
     'What about: a an the and or nor for but so yet not to of by at for but in, huh?' =>
        'What About: A an the and or nor for but so yet Not to of by at for but in, Huh?',
     'Ah ha: and so forth' =>
        'Ah Ha: And so Forth',
     'a theory I have' =>
        'A Theory I Have',
     'and/or testified it shall be' =>
        'And/or Testified It Shall Be',
     '...nor lost, nor found' =>
        '...Nor Lost, nor Found',
     'Ask not' =>
        'Ask Not',
     '\'for not!\', he said.' =>
        '\'For Not!\', He Said.',
     '"but so!", sayeth I' =>
        '"But So!", Sayeth I',
     'The wind whispers "But!"' =>
        'The Wind Whispers "But!"',
     'say "but!", say what?' =>
        'Say "But!", Say What?',
     'yet by and by but in for to' =>
        'Yet by and by but in for To',
     '-- ack, ack, bang!' =>
        '-- Ack, Ack, Bang!',
     '  very spacey  ' =>
        'Very Spacey',
     '  ...huh?   ' =>
        '...Huh?',
     'Didaktische Überlegungen/Erfahrungsbericht über den Computereinsatz im geisteswissenschaftlichen Unterricht am Bsp. "Historische Zeitung"' =>
        'Didaktische Überlegungen/Erfahrungsbericht Über Den Computereinsatz Im Geisteswissenschaftlichen Unterricht Am Bsp. "Historische Zeitung"',
     'über maus' =>
        'Über Maus',
     'Explicación dél significado de los términos utilizados en "Don Quijote", por capítulo.' =>
        'Explicación Dél Significado de Los Términos Utilizados En "Don Quijote", Por Capítulo.',
     'l\'oeuvre imposante d\'Honoré de Balzac' =>
        'L\'Oeuvre Imposante d\'Honoré de Balzac',
     'Baron von Arnheim\'s revenge' =>
        'Baron von Arnheim\'s Revenge',
     'forget gilroy, A. Snakhausem was here' =>
        'Forget Gilroy, A. Snakhausem Was Here',
     'The 13 Clocks' =>
        'The 13 Clocks',
     'The 4 False Weapons' =>
        'The 4 False Weapons',
     '10 Little-Endians' =>
        '10 Little-Endians',
     'the dirty 27' =>
        'The Dirty 27',
     'machine13' =>
        'Machine13',
     'ice9count0' =>
        'Ice9count0',
     'Why? Well, why not?' =>
        'Why? Well, Why Not?',
     'Ping... ping... ping... pong!' =>
        'Ping... Ping... Ping... Pong!',
     'Document. Test. Code. Repeat.' =>
        'Document. Test. Code. Repeat.',
     'And so they tramped on through the night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...' =>
        'And so They Tramped On Through the Night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...',
     'And more. And still more.' =>
        'And More. And Still More.',
     'mo\' beta-testing' =>
        'Mo\' Beta-Testing',
     'a laboratory of the open fields' =>
        'A Laboratory of the Open Fields',
     'Scientific Study of the So-called Psychical Processes in the Higher Animals' =>
        'Scientific Study of the so-Called Psychical Processes in the Higher Animals',
     'The Running-Down of the Universe' =>
        'The Running-Down of the Universe',
     'In the beginning... was the global-set-key' =>
        'In the Beginning... Was the Global-Set-Key',
     'how should one read a book?' =>
        'How Should One Read a Book?',
     'of beauty' =>
        'Of Beauty',
     'on style' =>
        'On Style',
     'As I Ebb\'d with the Ocean of Life' =>
        'As I Ebb\'d with the Ocean of Life',
     'When I Heard the Learn\'d Astronomer' =>
        'When I Heard the Learn\'d Astronomer',
     'From Pent-Up Aching Rivers' =>
        'From Pent-Up Aching Rivers',
     'One\'s Self I Sing' =>
        'One\'s Self I Sing',
     'BEAT! BEAT! DRUMS!' =>
        'BEAT! BEAT! DRUMS!',
     'The Wound-Dresser' =>
        'The Wound-Dresser',
     'Pain--has an Element of Blank' =>
        'Pain--Has an Element of Blank',
     '' =>
        '',
);


%expect_capitalize_title_PRESERVE_ANYCAPS = (
     'This And ThAt'=>
        'This And ThAt',
     "Revenge is Doom's" =>
        "Revenge Is Doom's",
     'the end of the dream: three-holed button manufacture in a four-holed world' =>
        'The End of the Dream: Three-Holed Button Manufacture in a Four-Holed World',
     'chords against culture -- counter-sexist themes in the later works of Fetal Tissue Kleenex' =>
        'Chords Against Culture -- Counter-Sexist Themes in the Later Works of Fetal Tissue Kleenex',
     'a history of n.a.s.a.' =>
        'A History of N.A.S.A.',
     'the n.a.s.a. sucks rag' =>
        'The N.A.S.A. Sucks Rag',
     's.a.d. days t.a.n. shades' =>
        'S.A.D. Days T.A.N. Shades',
     'it\'s the man\'s, you know?' =>
        'It\'s the Man\'s, You Know?',
     'hey doc the ticker is hocked, the dial is locked, the face is botoxed, whazzup?' =>
        'Hey Doc the Ticker Is Hocked, the Dial Is Locked, the Face Is Botoxed, Whazzup?',
     'Hell\'s Swells' =>
        'Hell\'s Swells',
     'you\'re wrong, it doesn\'t fly, it\'s not there and they\'re lost, so you\'d better not' =>
        'You\'re Wrong, It Doesn\'t Fly, It\'s Not There and They\'re Lost, so You\'d Better Not',
     'DOODZ I AM SO THERE! NOT.' =>
        'DOODZ I AM SO THERE! NOT.',
     'Tis called perserverence in a good cause, and obstinacy in a bad one.' =>
        'Tis Called Perserverence in a Good Cause, and Obstinacy in a Bad One.',
     'And the rest is silence...' =>
        'And the Rest Is Silence...',
     'a brief history of the word of' =>
        'A Brief History of the Word Of',
     'AWOL in the DMZ of WWIII' =>
        'AWOL in the DMZ of WWIII',
     'TLAs i have known and loved' =>
        'TLAs I Have Known and Loved',
     'The Next iMac: Just Another NeXt?' =>
        'The Next iMac: Just Another NeXt?',
     'Mr. Wong and Dr. And Report' =>
        'Mr. Wong and Dr. And Report',
     'Quinn Weaver, agent of SFPUG' =>
        'Quinn Weaver, Agent of SFPUG',
     'sarcasm, yet' =>
        'Sarcasm, Yet',
     'sarcasm yet not humor' =>
        'Sarcasm yet Not Humor',
     '...and justice for all' =>
        '...And Justice for All',
     'kill \'em all' =>
        'Kill \'Em All',
     'history of the gort-verada-nictu moving company' =>
        'History of the Gort-Verada-Nictu Moving Company',
     'Erratic spacing:  your KEY    to     creativity   ' =>
        'Erratic Spacing: Your KEY to Creativity',
     'it came from texas:  the new new world order?' =>
        'It Came From Texas: The New New World Order?',
     'pOiksIFiciZaLaTIonoRyISM' =>
        'pOiksIFiciZaLaTIonoRyISM',
     'What about: a an the and or nor for but so yet not to of by at for but in, huh?' =>
        'What About: A an the and or nor for but so yet Not to of by at for but in, Huh?',
     'Ah ha: and so forth' =>
        'Ah Ha: And so Forth',
     'a theory I have' =>
        'A Theory I Have',
     'and/or testified it shall be' =>
        'And/or Testified It Shall Be',
     '...nor lost, nor found' =>
        '...Nor Lost, nor Found',
     'Ask not' =>
        'Ask Not',
     '\'for not!\', he said.' =>
        '\'For Not!\', He Said.',
     '"but so!", sayeth I' =>
        '"But So!", Sayeth I',
     'The wind whispers "But!"' =>
        'The Wind Whispers "But!"',
     'say "but!", say what?' =>
        'Say "But!", Say What?',
     'yet by and by but in for to' =>
        'Yet by and by but in for To',
     '-- ack, ack, bang!' =>
        '-- Ack, Ack, Bang!',
     '  very spacey  ' =>
        'Very Spacey',
     '  ...huh?   ' =>
        '...Huh?',
     'Didaktische Überlegungen/Erfahrungsbericht über den Computereinsatz im geisteswissenschaftlichen Unterricht am Bsp. "Historische Zeitung"' =>
        'Didaktische Überlegungen/Erfahrungsbericht Über Den Computereinsatz Im Geisteswissenschaftlichen Unterricht Am Bsp. "Historische Zeitung"',
     'über maus' =>
        'Über Maus',
     'Explicación dél significado de los términos utilizados en "Don Quijote", por capítulo.' =>
        'Explicación Dél Significado de Los Términos Utilizados En "Don Quijote", Por Capítulo.',
     'l\'oeuvre imposante d\'Honoré de Balzac' =>
        'L\'Oeuvre Imposante d\'Honoré de Balzac',
     'Baron von Arnheim\'s revenge' =>
        'Baron von Arnheim\'s Revenge',
     'forget gilroy, A. Snakhausem was here' =>
        'Forget Gilroy, A. Snakhausem Was Here',
     'The 13 Clocks' =>
        'The 13 Clocks',
     'The 4 False Weapons' =>
        'The 4 False Weapons',
     '10 Little-Endians' =>
        '10 Little-Endians',
     'the dirty 27' =>
        'The Dirty 27',
     'machine13' =>
        'Machine13',
     'ice9count0' =>
        'Ice9count0',
     'Why? Well, why not?' =>
        'Why? Well, Why Not?',
     'Ping... ping... ping... pong!' =>
        'Ping... Ping... Ping... Pong!',
     'Document. Test. Code. Repeat.' =>
        'Document. Test. Code. Repeat.',
     'And so they tramped on through the night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...' =>
        'And so They Tramped On Through the Night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...',
     'And more. And still more.' =>
        'And More. And Still More.',
     'mo\' beta-testing' =>
        'Mo\' Beta-Testing',
     'a laboratory of the open fields' =>
        'A Laboratory of the Open Fields',
     'Scientific Study of the So-called Psychical Processes in the Higher Animals' =>
        'Scientific Study of the So-Called Psychical Processes in the Higher Animals',
     'The Running-Down of the Universe' =>
        'The Running-Down of the Universe',
     'In the beginning... was the global-set-key' =>
        'In the Beginning... Was the Global-Set-Key',
     'how should one read a book?' =>
        'How Should One Read a Book?',
     'of beauty' =>
        'Of Beauty',
     'on style' =>
        'On Style',
     'As I Ebb\'d with the Ocean of Life' =>
        'As I Ebb\'d with the Ocean of Life',
     'When I Heard the Learn\'d Astronomer' =>
        'When I Heard the Learn\'d Astronomer',
     'From Pent-Up Aching Rivers' =>
        'From Pent-Up Aching Rivers',
     'One\'s Self I Sing' =>
        'One\'s Self I Sing',
     'BEAT! BEAT! DRUMS!' =>
        'BEAT! BEAT! DRUMS!',
     'The Wound-Dresser' =>
        'The Wound-Dresser',
     'Pain--has an Element of Blank' =>
        'Pain--Has an Element of Blank',
     '' =>
        '',
);


%expect_capitalize_title_PRESERVE_ALLCAPS_PRESERVE_WHITESPACE = (
     'This And ThAt' =>
        'This and That',
     "Revenge is Doom's" =>
        "Revenge Is Doom's",
     'the end of the dream: three-holed button manufacture in a four-holed world' =>
        'The End of the Dream: Three-Holed Button Manufacture in a Four-Holed World',
     'chords against culture -- counter-sexist themes in the later works of Fetal Tissue Kleenex' =>
        'Chords Against Culture -- Counter-Sexist Themes in the Later Works of Fetal Tissue Kleenex',
     'a history of n.a.s.a.' =>
        'A History of N.A.S.A.',
     'the n.a.s.a. sucks rag' =>
        'The N.A.S.A. Sucks Rag',
     's.a.d. days t.a.n. shades' =>
        'S.A.D. Days T.A.N. Shades',
     'it\'s the man\'s, you know?' =>
        'It\'s the Man\'s, You Know?',
     'hey doc the ticker is hocked, the dial is locked, the face is botoxed, whazzup?' =>
        'Hey Doc the Ticker Is Hocked, the Dial Is Locked, the Face Is Botoxed, Whazzup?',
     'Hell\'s Swells' =>
        'Hell\'s Swells',
     'you\'re wrong, it doesn\'t fly, it\'s not there and they\'re lost, so you\'d better not' =>
        'You\'re Wrong, It Doesn\'t Fly, It\'s Not There and They\'re Lost, so You\'d Better Not',
     'DOODZ I AM SO THERE! NOT.' =>
        'DOODZ I AM SO THERE! NOT.',
     'Tis called perserverence in a good cause, and obstinacy in a bad one.' =>
        'Tis Called Perserverence in a Good Cause, and Obstinacy in a Bad One.',
     'And the rest is silence...' =>
        'And the Rest Is Silence...',
     'a brief history of the word of' =>
        'A Brief History of the Word Of',
     'AWOL in the DMZ of WWIII' =>
        'AWOL in the DMZ of WWIII',
     'TLAs i have known and loved' =>
        'Tlas I Have Known and Loved',
     'The Next iMac: Just Another NeXt?' =>
        'The Next Imac: Just Another Next?',
     'Mr. Wong and Dr. And Report' =>
        'Mr. Wong and Dr. And Report',
     'Quinn Weaver, agent of SFPUG' =>
        'Quinn Weaver, Agent of SFPUG',
     'sarcasm, yet' =>
        'Sarcasm, Yet',
     'sarcasm yet not humor' =>
        'Sarcasm yet Not Humor',
     '...and justice for all' =>
        '...And Justice for All',
     'kill \'em all' =>
        'Kill \'Em All',
     'history of the gort-verada-nictu moving company' =>
        'History of the Gort-Verada-Nictu Moving Company',
     'Erratic spacing:  your KEY    to     creativity   ' =>
        'Erratic Spacing:  Your KEY    to     Creativity   ',
     'it came from texas:  the new new world order?' =>
        'It Came From Texas:  The New New World Order?',
     'pOiksIFiciZaLaTIonoRyISM' =>
        'Poiksificizalationoryism',
     'What about: a an the and or nor for but so yet not to of by at for but in, huh?' =>
        'What About: A an the and or nor for but so yet Not to of by at for but in, Huh?',
     'Ah ha: and so forth' =>
        'Ah Ha: And so Forth',
     'a theory I have' =>
        'A Theory I Have',
     'and/or testified it shall be' =>
        'And/or Testified It Shall Be',
     '...nor lost, nor found' =>
        '...Nor Lost, nor Found',
     'Ask not' =>
        'Ask Not',
     '\'for not!\', he said.' =>
        '\'For Not!\', He Said.',
     '"but so!", sayeth I' =>
        '"But So!", Sayeth I',
     'The wind whispers "But!"' =>
        'The Wind Whispers "But!"',
     'say "but!", say what?' =>
        'Say "But!", Say What?',
     'yet by and by but in for to' =>
        'Yet by and by but in for To',
     '-- ack, ack, bang!' =>
        '-- Ack, Ack, Bang!',
     '  very spacey  ' =>
        '  Very Spacey  ',
     '  ...huh?   ' =>
        '  ...Huh?   ',
     'Didaktische Überlegungen/Erfahrungsbericht über den Computereinsatz im geisteswissenschaftlichen Unterricht am Bsp. "Historische Zeitung"' =>
        'Didaktische Überlegungen/Erfahrungsbericht Über Den Computereinsatz Im Geisteswissenschaftlichen Unterricht Am Bsp. "Historische Zeitung"',
     'über maus' =>
        'Über Maus',
     'Explicación dél significado de los términos utilizados en "Don Quijote", por capítulo.' =>
        'Explicación Dél Significado de Los Términos Utilizados En "Don Quijote", Por Capítulo.',
     'l\'oeuvre imposante d\'Honoré de Balzac' =>
        'L\'Oeuvre Imposante d\'Honoré de Balzac',
     'Baron von Arnheim\'s revenge' =>
        'Baron von Arnheim\'s Revenge',
     'forget gilroy, A. Snakhausem was here' =>
        'Forget Gilroy, A. Snakhausem Was Here',
     'The 13 Clocks' =>
        'The 13 Clocks',
     'The 4 False Weapons' =>
        'The 4 False Weapons',
     '10 Little-Endians' =>
        '10 Little-Endians',
     'the dirty 27' =>
        'The Dirty 27',
     'machine13' =>
        'Machine13',
     'ice9count0' =>
        'Ice9count0',
     'Why? Well, why not?' =>
        'Why? Well, Why Not?',
     'Ping... ping... ping... pong!' =>
        'Ping... Ping... Ping... Pong!',
     'Document. Test. Code. Repeat.' =>
        'Document. Test. Code. Repeat.',
     'And so they tramped on through the night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...' =>
        'And so They Tramped On Through the Night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...',
     'And more. And still more.' =>
        'And More. And Still More.',
     'mo\' beta-testing' =>
        'Mo\' Beta-Testing',
     'a laboratory of the open fields' =>
        'A Laboratory of the Open Fields',
     'Scientific Study of the So-called Psychical Processes in the Higher Animals' =>
        'Scientific Study of the so-Called Psychical Processes in the Higher Animals',
     'The Running-Down of the Universe' =>
        'The Running-Down of the Universe',
     'In the beginning... was the global-set-key' =>
        'In the Beginning... Was the Global-Set-Key',
     'how should one read a book?' =>
        'How Should One Read a Book?',
     'of beauty' =>
        'Of Beauty',
     'on style' =>
        'On Style',
     'As I Ebb\'d with the Ocean of Life' =>
        'As I Ebb\'d with the Ocean of Life',
     'When I Heard the Learn\'d Astronomer' =>
        'When I Heard the Learn\'d Astronomer',
     'From Pent-Up Aching Rivers' =>
        'From Pent-Up Aching Rivers',
     'One\'s Self I Sing' =>
        'One\'s Self I Sing',
     'BEAT! BEAT! DRUMS!' =>
        'BEAT! BEAT! DRUMS!',
     'The Wound-Dresser' =>
        'The Wound-Dresser',
     'Pain--has an Element of Blank' =>
        'Pain--Has an Element of Blank',
     '' =>
        '',
);


%expect_capitalize_title_PRESERVE_ANYCAPS_PRESERVE_WHITESPACE = (
     'This And ThAt' =>
        'This And ThAt',
     "Revenge is Doom's" =>
        "Revenge Is Doom's",
     'the end of the dream: three-holed button manufacture in a four-holed world' =>
        'The End of the Dream: Three-Holed Button Manufacture in a Four-Holed World',
     'chords against culture -- counter-sexist themes in the later works of Fetal Tissue Kleenex' =>
        'Chords Against Culture -- Counter-Sexist Themes in the Later Works of Fetal Tissue Kleenex',
     'a history of n.a.s.a.' =>
        'A History of N.A.S.A.',
     'the n.a.s.a. sucks rag' =>
        'The N.A.S.A. Sucks Rag',
     's.a.d. days t.a.n. shades' =>
        'S.A.D. Days T.A.N. Shades',
     'it\'s the man\'s, you know?' =>
        'It\'s the Man\'s, You Know?',
     'hey doc the ticker is hocked, the dial is locked, the face is botoxed, whazzup?' =>
        'Hey Doc the Ticker Is Hocked, the Dial Is Locked, the Face Is Botoxed, Whazzup?',
     'Hell\'s Swells' =>
        'Hell\'s Swells',
     'you\'re wrong, it doesn\'t fly, it\'s not there and they\'re lost, so you\'d better not' =>
        'You\'re Wrong, It Doesn\'t Fly, It\'s Not There and They\'re Lost, so You\'d Better Not',
     'DOODZ I AM SO THERE! NOT.' =>
        'DOODZ I AM SO THERE! NOT.',
     'Tis called perserverence in a good cause, and obstinacy in a bad one.' =>
        'Tis Called Perserverence in a Good Cause, and Obstinacy in a Bad One.',
     'And the rest is silence...' =>
        'And the Rest Is Silence...',
     'a brief history of the word of' =>
        'A Brief History of the Word Of',
     'AWOL in the DMZ of WWIII' =>
        'AWOL in the DMZ of WWIII',
     'TLAs i have known and loved' =>
        'TLAs I Have Known and Loved',
     'The Next iMac: Just Another NeXt?' =>
        'The Next iMac: Just Another NeXt?',
     'Mr. Wong and Dr. And Report' =>
        'Mr. Wong and Dr. And Report',
     'Quinn Weaver, agent of SFPUG' =>
        'Quinn Weaver, Agent of SFPUG',
     'sarcasm, yet' =>
        'Sarcasm, Yet',
     'sarcasm yet not humor' =>
        'Sarcasm yet Not Humor',
     '...and justice for all' =>
        '...And Justice for All',
     'kill \'em all' =>
        'Kill \'Em All',
     'history of the gort-verada-nictu moving company' =>
        'History of the Gort-Verada-Nictu Moving Company',
     'Erratic spacing:  your KEY    to     creativity   ' =>
        'Erratic Spacing:  Your KEY    to     Creativity   ',
     'it came from texas:  the new new world order?' =>
        'It Came From Texas:  The New New World Order?',
     'pOiksIFiciZaLaTIonoRyISM' =>
        'pOiksIFiciZaLaTIonoRyISM',
     'What about: a an the and or nor for but so yet not to of by at for but in, huh?' =>
        'What About: A an the and or nor for but so yet Not to of by at for but in, Huh?',
     'Ah ha: and so forth' =>
        'Ah Ha: And so Forth',
     'a theory I have' =>
        'A Theory I Have',
     'and/or testified it shall be' =>
        'And/or Testified It Shall Be',
     '...nor lost, nor found' =>
        '...Nor Lost, nor Found',
     'Ask not' =>
        'Ask Not',
     '\'for not!\', he said.' =>
        '\'For Not!\', He Said.',
     '"but so!", sayeth I' =>
        '"But So!", Sayeth I',
     'The wind whispers "But!"' =>
        'The Wind Whispers "But!"',
     'say "but!", say what?' =>
        'Say "But!", Say What?',
     'yet by and by but in for to' =>
        'Yet by and by but in for To',
     '-- ack, ack, bang!' =>
        '-- Ack, Ack, Bang!',
     '  very spacey  ' =>
        '  Very Spacey  ',
     '  ...huh?   ' =>
        '  ...Huh?   ',
     'Didaktische Überlegungen/Erfahrungsbericht über den Computereinsatz im geisteswissenschaftlichen Unterricht am Bsp. "Historische Zeitung"' =>
        'Didaktische Überlegungen/Erfahrungsbericht Über Den Computereinsatz Im Geisteswissenschaftlichen Unterricht Am Bsp. "Historische Zeitung"',
     'über maus' =>
        'Über Maus',
     'Explicación dél significado de los términos utilizados en "Don Quijote", por capítulo.' =>
        'Explicación Dél Significado de Los Términos Utilizados En "Don Quijote", Por Capítulo.',
     'l\'oeuvre imposante d\'Honoré de Balzac' =>
        'L\'Oeuvre Imposante d\'Honoré de Balzac',
     'Baron von Arnheim\'s revenge' =>
        'Baron von Arnheim\'s Revenge',
     'forget gilroy, A. Snakhausem was here' =>
        'Forget Gilroy, A. Snakhausem Was Here',
     'The 13 Clocks' =>
        'The 13 Clocks',
     'The 4 False Weapons' =>
        'The 4 False Weapons',
     '10 Little-Endians' =>
        '10 Little-Endians',
     'the dirty 27' =>
        'The Dirty 27',
     'machine13' =>
        'Machine13',
     'ice9count0' =>
        'Ice9count0',
     'Why? Well, why not?' =>
        'Why? Well, Why Not?',
     'Ping... ping... ping... pong!' =>
        'Ping... Ping... Ping... Pong!',
     'Document. Test. Code. Repeat.' =>
        'Document. Test. Code. Repeat.',
     'And so they tramped on through the night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...' =>
        'And so They Tramped On Through the Night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...',
     'And more. And still more.' =>
        'And More. And Still More.',
     'mo\' beta-testing' =>
        'Mo\' Beta-Testing',
     'a laboratory of the open fields' =>
        'A Laboratory of the Open Fields',
     'Scientific Study of the So-called Psychical Processes in the Higher Animals' =>
        'Scientific Study of the So-Called Psychical Processes in the Higher Animals',
     'The Running-Down of the Universe' =>
        'The Running-Down of the Universe',
     'In the beginning... was the global-set-key' =>
        'In the Beginning... Was the Global-Set-Key',
     'how should one read a book?' =>
        'How Should One Read a Book?',
     'of beauty' =>
        'Of Beauty',
     'on style' =>
        'On Style',
     'As I Ebb\'d with the Ocean of Life' =>
        'As I Ebb\'d with the Ocean of Life',
     'When I Heard the Learn\'d Astronomer' =>
        'When I Heard the Learn\'d Astronomer',
     'From Pent-Up Aching Rivers' =>
        'From Pent-Up Aching Rivers',
     'One\'s Self I Sing' =>
        'One\'s Self I Sing',
     'BEAT! BEAT! DRUMS!' =>
        'BEAT! BEAT! DRUMS!',
     'The Wound-Dresser' =>
        'The Wound-Dresser',
     'Pain--has an Element of Blank' =>
        'Pain--Has an Element of Blank',
     '' =>
        '',
);


# Hash of test cases (keys) and expected results (values) for
# random_case, when seeded with a known value: srand(666)

%expect_random_case = (
     '' =>
        '',
     '  ...huh?   ' =>
        '  ...HUh?   ',
     '  very spacey  ' =>
        '  vEry spaCey  ',
     '"but so!", sayeth I' =>
        '"bUt so!", SAyEth I',
     '\'for not!\', he said.' =>
        '\'FoR NOT!\', hE SAid.',
     '-- ack, ack, bang!' =>
        '-- ACk, ACK, bAng!',
     '...and justice for all' =>
        '...aNd JUsTIce fOr All',
     '...nor lost, nor found' =>
        '...nOr lOsT, noR FOuNd',
     '10 Little-Endians' =>
        '10 LIttle-ENDiANS',
     'AWOL in the DMZ of WWIII' =>
        'Awol in THE dmZ OF WwiiI',
     'Ah ha: and so forth' =>
        'AH ha: AND SO ForTh',
     'And more. And still more.' =>
        'And morE. ANd STILL more.',
     'And so they tramped on through the night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...' =>
        'AnD SO ThEY TRAmpEd on tHROUGh tHe NIghT. trAmp. TramP. TramP. TRAMP. Tramp. TramP. trAMp...',
     'And the rest is silence...' =>
        'AnD THe Rest Is SIlEnce...',
     'As I Ebb\'d with the Ocean of Life' =>
        'as i EBb\'D wITH ThE OCeaN of life',
     'Ask not' =>
        'asK nOT',
     'BEAT! BEAT! DRUMS!' =>
        'beaT! beAt! DRUMs!',
     'Baron von Arnheim\'s revenge' =>
        'bARon vON aRNHEim\'s rEvEngE',
     'DOODZ I AM SO THERE! NOT.' =>
        'DoODz i Am so tHEre! NOT.',
     'Didaktische Überlegungen/Erfahrungsbericht über den Computereinsatz im geisteswissenschaftlichen Unterricht am Bsp. "Historische Zeitung"' =>
        'DiDAKtIsCHe ÜbERLeGUNgEn/eRfAhRUNGsBericht üBER deN coMpUTerEInsatZ iM GEistESWIsSenSchafTLichEN UntErricHT Am BSP. "hIsToRIsChE zEitUNG"',
     'Document. Test. Code. Repeat.' =>
        'doCumeNt. tesT. CoDe. rEpEAt.',
     'Erratic spacing:  your KEY    to     creativity   ' =>
        'erRaTIc spaCiNg:  yOur KEY    To     CReatIvITY   ',
     'Explicación dél significado de los términos utilizados en "Don Quijote", por capítulo.' =>
        'ExPlIcACIón dÉL SIGNIFICadO de LOS tÉRmiNos UtIlIZAdoS eN "dON QuIJote", pOr CApíTuLO.',
     'From Pent-Up Aching Rivers' =>
        'FROm pENT-Up AChInG rIVeRS',
     'Hell\'s Swells' =>
        'heLL\'s SweLLS',
     'In the beginning... was the global-set-key' =>
        'in The BEGINNING... wAs THe GloBAL-SeT-keY',
     'Mr. Wong and Dr. And Report' =>
        'mr. woNg AND dr. aND rEPorT',
     'One\'s Self I Sing' =>
        'one\'s SelF i sing',
     'Pain--has an Element of Blank' =>
        'Pain--HaS aN EleMEnt Of bLanK',
     'Ping... ping... ping... pong!' =>
        'PiNg... PinG... piNG... Pong!',
     'Quinn Weaver, agent of SFPUG' =>
        'QUINn WeAvER, aGEnt Of SFPug',
     'Scientific Study of the So-called Psychical Processes in the Higher Animals' =>
        'SCieNTIFic StUDy Of THE SO-CalleD psYchICaL pROCeSsES iN THe HigHEr AnIMalS',
     'TLAs i have known and loved' =>
        'TLaS I haVE KNOwN AnD lOvED',
     'The 13 Clocks' =>
        'tHe 13 ClOcKs',
     'The 4 False Weapons' =>
        'ThE 4 FAlsE WEapoNS',
     'The Next iMac: Just Another NeXt?' =>
        'tHe NeXT imac: JUSt aNOTher NeXt?',
     'The Running-Down of the Universe' =>
        'The ruNNING-DOwN of ThE unIvErsE',
     'The Wound-Dresser' =>
        'THE woUNd-DrEsSER',
     'The wind whispers "But!"' =>
        'tHe winD WHiSPeRS "But!"',
     'Tis called perserverence in a good cause, and obstinacy in a bad one.' =>
        'tis CaLleD PerserveREnCe IN A gooD Cause, AND oBSTinacY IN a BAd ONE.',
     'What about: a an the and or nor for but so yet not to of by at for but in, huh?' =>
        'wHat aBouT: a An the aND oR nOr FOr BUT SO YET NOt to of BY at FOr buT iN, huh?',
     'When I Heard the Learn\'d Astronomer' =>
        'wHen i hEARD The Learn\'d aSTRONoMEr',
     'Why? Well, why not?' =>
        'WhY? WEll, Why Not?',
     'a brief history of the word of' =>
        'a bRiEF HIsTory OF THE Word Of',
     'a history of n.a.s.a.' =>
        'a hISTORY OF n.A.S.a.',
     'a laboratory of the open fields' =>
        'a laborATORY OF THe oPen FIELds',
     'a theory I have' =>
        'A theORY I have',
     'and/or testified it shall be' =>
        'anD/or TeSTified IT shall be',
     'chords against culture -- counter-sexist themes in the later works of Fetal Tissue Kleenex' =>
        'ChOrdS agaINSt CUlTuRE -- cOUntER-sexiSt THemEs IN thE LaTEr wORKs Of fETal TiSSUE KLEEnex',
     'forget gilroy, A. Snakhausem was here' =>
        'FORGeT GIlROY, a. snAKhauSEM WAS heRE',
     'hey doc the ticker is hocked, the dial is locked, the face is botoxed, whazzup?' =>
        'Hey DOC ThE tICker IS hockeD, THE Dial iS LocKeD, THE fACe is botOxEd, wHAzzUp?',
     'history of the gort-verada-nictu moving company' =>
        'hIstOry Of The gOrT-VERaDA-Nictu moVINg cOMPANY',
     'how should one read a book?' =>
        'hOW SHoulD ONe read a BOok?',
     'ice9count0' =>
        'ice9cOUnT0',
     'it came from texas:  the new new world order?' =>
        'iT Came froM texaS:  ThE nEW NEw WOrlD OrdeR?',
     'it\'s the man\'s, you know?' =>
        'it\'S THe MAN\'S, YOu KnoW?',
     'kill \'em all' =>
        'kiLl \'EM AlL',
     'machine13' =>
        'MACHinE13',
     'mo\' beta-testing' =>
        'MO\' beta-TesTinG',
     'of beauty' =>
        'of BeaUTY',
     'on style' =>
        'oN STYlE',
     'où l\'on découvre une époque à travers l\'oeuvre imposante d\'Honoré de Balzac' =>
        'oÙ L\'on DÉcouvRe UnE éPoquE À TrAverS l\'oeUvrE IMpoSaNtE d\'honorÉ DE BALZAC',
     'pOiksIFiciZaLaTIonoRyISM' =>
        'POikSIFicizalatIoNORyISM',
     's.a.d. days t.a.n. shades' =>
        's.A.D. dAYS T.A.N. sHADEs',
     'sarcasm yet not humor' =>
        'SarcAsM yET not hUmor',
     'sarcasm, yet' =>
        'SaRcAsM, yET',
     'say "but!", say what?' =>
        'SAy "BuT!", sAy whAt?',
     'the dirty 27' =>
        'tHE dIRTY 27',
     'the end of the dream: three-holed button manufacture in a four-holed world' =>
        'tHE enD OF tHe DREAM: THREE-hOLeD butTON ManufacTuRe In a foUR-hoLEd woRLd',
     'the n.a.s.a. sucks rag' =>
        'The n.A.s.A. SUckS Rag',
     'yet by and by but in for to' =>
        'yEt bY and BY BuT In fOr TO',
     'you\'re wrong, it doesn\'t fly, it\'s not there and they\'re lost, so you\'d better not' =>
        'YOu\'RE wROng, It DoeSN\'t FLY, IT\'s nOT tHEre anD thEY\'rE LOSt, so yOU\'d BEtteR not',
     'évêque, qu\'il eût aimé voir infliger à ceux qui ont abdiqué, J\'ai été reçu, and pepe le peau' =>
        'évÊQue, Qu\'iL eûT AIMÉ vOiR inflIgER à ceux quI onT AbdiQué, J\'aI éTé REçU, and pepe lE peaU',
     'über maus' =>
        'ÜbeR mAuS',
);

# Hash of test cases (keys) and expected results (values) for
# scramble_case, when seeded with a known value: srand(666)

%expect_scramble_case = (
     '' =>
        '',
     '  ...huh?   ' =>
        '  ...hUh?   ',
     '  very spacey  ' =>
        '  vEry spACey  ',
     '"but so!", sayeth I' =>
        '"bUt so!", SAyEth I',
     '\'for not!\', he said.' =>
        '\'FoR NOT!\', hE Said.',
     '-- ack, ack, bang!' =>
        '-- ACk, ACk, bang!',
     '...and justice for all' =>
        '...aNd JUsTICe fOr All',
     '...nor lost, nor found' =>
        '...nOr losT, noR FOuNd',
     '10 Little-Endians' =>
        '10 LIttle-ENDiANS',
     'AWOL in the DMZ of WWIII' =>
        'Awol In THE dmZ OF WwiiI',
     'Ah ha: and so forth' =>
        'Ah ha: AND SO forTh',
     'And more. And still more.' =>
        'And moRE. And STIlL more.',
     'And so they tramped on through the night. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp. Tramp...' =>
        'AnD So ThEY TRAmpEd on tHROUGh tHe NIghT. tramp. TramP. TramP. TRAMP. Tramp. TramP. trAMp...',
     'And the rest is silence...' =>
        'And The Rest Is SIlEnce...',
     'As I Ebb\'d with the Ocean of Life' =>
        'as i EBb\'D wITH ThE OCeaN of life',
     'Ask not' =>
        'asK nOT',
     'BEAT! BEAT! DRUMS!' =>
        'beAT! beAt! DRUMs!',
     'Baron von Arnheim\'s revenge' =>
        'bARon vON aRNHEim\'s rEvEngE',
     'DOODZ I AM SO THERE! NOT.' =>
        'doODz i Am so THEre! NOT.',
     'Didaktische Überlegungen/Erfahrungsbericht über den Computereinsatz im geisteswissenschaftlichen Unterricht am Bsp. "Historische Zeitung"' =>
        'DiDAktIsCHe ÜbERleGUNgEn/erfAhrUNGsbericHt üBER deN coMpUTerEInsatZ IM GeistESWIsSenSchafTLichEN UntErricHT Am BSP. "hIsToRIsChE zEitUNG"',
     'Document. Test. Code. Repeat.' =>
        'doCumeNt. tesT. CoDe. rEpEAt.',
     'Erratic spacing:  your KEY    to     creativity   ' =>
        'erRaTIc SpaCiNg:  yOUr KEY    To     CReatIvITY   ',
     'Explicación dél significado de los términos utilizados en "Don Quijote", por capítulo.' =>
        'ExPlicACIón DÉL SiGNiFICadO de LOS tÉRmiNos UtIlIZAdoS eN "dON QuIJote", pOr CApíTuLO.',
     'From Pent-Up Aching Rivers' =>
        'FrOm pEnT-Up AChIng rIVeRS',
     'Hell\'s Swells' =>
        'heLL\'s SweLLS',
     'In the beginning... was the global-set-key' =>
        'in The BEGINNinG... wAs THe gloBAL-SeT-keY',
     'Mr. Wong and Dr. And Report' =>
        'mr. woNg AND dr. aND rEporT',
     'One\'s Self I Sing' =>
        'onE\'s SelF i sinG',
     'Pain--has an Element of Blank' =>
        'Pain--HaS aN EleMEnt Of bLanK',
     'Ping... ping... ping... pong!' =>
        'piNg... PiNG... piNG... Pong!',
     'Quinn Weaver, agent of SFPUG' =>
        'QUinn WeAvER, aGEnt Of SFPug',
     'Scientific Study of the So-called Psychical Processes in the Higher Animals' =>
        'SCieNTIfic StUDy Of THE SO-Called psYchICaL pROCeSsES iN THe higHEr AnIMalS',
     'TLAs i have known and loved' =>
        'TLas I haVE KnOwN anD lOveD',
     'The 13 Clocks' =>
        'tHe 13 ClOcKs',
     'The 4 False Weapons' =>
        'ThE 4 FAlse WEapoNS',
     'The Next iMac: Just Another NeXt?' =>
        'tHe NeXT imac: JUSt aNOTher NeXt?',
     'The Running-Down of the Universe' =>
        'The ruNNING-DOwN of thE unIversE',
     'The Wound-Dresser' =>
        'tHE woUNd-drEsSER',
     'The wind whispers "But!"' =>
        'tHe winD WHISPeRS "But!"',
     'Tis called perserverence in a good cause, and obstinacy in a bad one.' =>
        'tis CaLleD PerserveRENCe IN A gooD Cause, AND OBSTInacY IN a BAd ONE.',
     'What about: a an the and or nor for but so yet not to of by at for but in, huh?' =>
        'wHat aBouT: a An the aND oR NOR FOr BUT SO YET NOt to of BY at FOr buT iN, huh?',
     'When I Heard the Learn\'d Astronomer' =>
        'wHen i hEARd The Learn\'d aSTRONoMEr',
     'Why? Well, why not?' =>
        'WhY? wEll, Why Not?',
     'a brief history of the word of' =>
        'a bRiEF HIsTory OF THE Word Of',
     'a history of n.a.s.a.' =>
        'a hISTORY OF n.A.S.a.',
     'a laboratory of the open fields' =>
        'a labORATORY of The oPen FIELds',
     'a theory I have' =>
        'a thEORY I have',
     'and/or testified it shall be' =>
        'anD/or TeSTified IT shalL be',
     'chords against culture -- counter-sexist themes in the later works of Fetal Tissue Kleenex' =>
        'chOrdS AgaINSt CUlTuRE -- cOUntER-sexiSt THeMEs IN thE LaTEr wORKs Of fETal TiSSUE KLEenex',
     'forget gilroy, A. Snakhausem was here' =>
        'FORgeT GilRoY, a. snAKhauSEM WAS heRe',
     'hey doc the ticker is hocked, the dial is locked, the face is botoxed, whazzup?' =>
        'Hey DOC ThE tICker IS hockeD, THE Dial iS LocKeD, THE FACe is botOxEd, wHAzzUp?',
     'history of the gort-verada-nictu moving company' =>
        'hIstOry Of The gOrT-VERaDA-Nictu moVINg cOMPaNy',
     'how should one read a book?' =>
        'hOW SHoulD ONe read a BOok?',
     'ice9count0' =>
        'ice9cOUnT0',
     'it came from texas:  the new new world order?' =>
        'iT CamE froM tExAS:  ThE nEW NEw WOrlD OrdeR?',
     'it\'s the man\'s, you know?' =>
        'it\'S THe MAN\'S, YOu KnoW?',
     'kill \'em all' =>
        'kiLl \'EM AlL',
     'machine13' =>
        'mACHinE13',
     'mo\' beta-testing' =>
        'mO\' beta-TesTinG',
     'of beauty' =>
        'of BeaUTY',
     'on style' =>
        'oN STYlE',
     'où l\'on découvre une époque à travers l\'oeuvre imposante d\'Honoré de Balzac' =>
        'oÙ L\'on DÉcouvRe UnE éPoquE À TrAverS l\'oeUvrE IMpoSaNtE d\'honorÉ DE BALZAC',
     'pOiksIFiciZaLaTIonoRyISM' =>
        'pOikSIFicizalAtIoNORyISM',
     's.a.d. days t.a.n. shades' =>
        's.A.D. dAYS T.A.N. sHADEs',
     'sarcasm yet not humor' =>
        'SarcAsM yET not hUmor',
     'sarcasm, yet' =>
        'saRcAsM, yET',
     'say "but!", say what?' =>
        'Say "BuT!", sAy wHAt?',
     'the dirty 27' =>
        'tHE dIrTY 27',
     'the end of the dream: three-holed button manufacture in a four-holed world' =>
        'tHE enD OF tHe DReAM: THrEE-hOleD butTON ManufacTuRe In a FoUR-hoLEd woRLd',
     'the n.a.s.a. sucks rag' =>
        'The n.A.s.A. SUckS Rag',
     'yet by and by but in for to' =>
        'yEt bY And BY BuT In fOr TO',
     'you\'re wrong, it doesn\'t fly, it\'s not there and they\'re lost, so you\'d better not' =>
        'You\'RE wROng, It DoeSN\'t FLY, IT\'s nOt tHEre anD thEY\'rE LOSt, so yOU\'d BEtteR not',
     'évêque, qu\'il eût aimé voir infliger à ceux qui ont abdiqué, J\'ai été reçu, and pepe le peau' =>
        'évÊQue, Qu\'iL eûT AIMÉ vOiR inflIgER à ceux quI onT AbdIQué, J\'aI éTé REçU, and pepe lE peaU',
     'über maus' =>
        'übeR mAuS',
);

1;
