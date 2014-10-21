use strict;
use warnings;
use Data::Dumper;
use WebService::Spotify;
use Util;

my ($username, $playlist_id, @track_ids) = @ARGV;

unless ($username and $playlist_id and @track_ids) {
  print "Usage: $0 username playlist_id track_id ...\n";
  exit;
}

my $scope = 'playlist-modify';
my $token = Util::prompt_for_user_token($username, $scope);

if ($token) {
  my $sp = WebService::Spotify->new(auth => $token, trace => 1);
  my $results = $sp->user_playlist_add_tracks($username, $playlist_id, [@track_ids]);
  print Dumper $results;
} else {
  print "Can't get token for $username\n";
}