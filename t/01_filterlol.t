use Test::More tests => 21;

use_ok( 'POE::Filter::LOLCAT' );

my $orig = POE::Filter::LOLCAT->new();
my $clone = $orig->clone();

foreach my $filter ( $orig, $clone ) {

  isa_ok( $filter, 'POE::Filter::LOLCAT' );
  isa_ok( $filter, 'POE::Filter' );

  my $YOUR = qr/Y?(?:O|U)?(?:A|R)(?:E|R)?/;
  my $Z    = qr/(?:S|Z)/;

  my @phrases = (
	"can i please have a cheeseburger?",
	"you're right, i want more pickles.",
	"I'm in your bathroom, reading your magazine",
	"i'm in your world, planning your domination",
	"i think that is a nice bucket",
	"hello, i want to ask you a question",
	"I'm in your bed and breakfast, eating your sausages",
	"free parties, events & more! what's happening?  who's going?",
  );

  my @regexen = (
	qr/I CAN HA$Z CHEEZBURGR\?/,
	qr/$YOUR RITE, I WANT$Z MOAR PICKLE$Z/,
	qr/IM IN $YOUR BATHROOM, READIN$Z? $YOUR MAGAZINE/,
	qr/IM IN $YOUR WH?(?:U|I)?RR?LD, PLANNIN$Z? $YOUR DOMINASHUN/,
	qr/I THINK THAT AR (?:TEH )?NICE BUKKIT/,
	qr/O(?:HS?)? HAI, I WANT$Z (?:TO?|2) ASK Y?(?:U|OO|OU$Z) Q(?:W|U)ES(?:J|SH)UN/,
	qr/IM IN $YOUR BED AND BREKKFAST, EATIN$Z? $YOUR SAUSUJ$Z?/,
	qr/FREE PARTIE$Z?, EVENT$Z? & MOAR! WH?UT$Z HAPPENIN$Z?\? HOO$Z GOIN$Z?\?/,
  );

  my $lols = $filter->get( \@phrases );

  like( $_, shift @regexen, "translated: $_" ) for @$lols;

}
