#Perl mailer utility

#!/usr/bin/perl

my $msg=shift @ARGV;

use strict;
  use warnings;
  use Email::Send;
  use Email::Send::Gmail;
  use Email::Simple::Creator;

  my $email = Email::Simple->create(
      header => [
          From    => 'jrhdeploy@gmail.com',
          To      => 'jrhdeploy@gmail.com',
          Subject => 'Problems with the site',
      ],
#	body => 'We have an issue with the site, either the server of mysql and kaput!',
	body => $msg,
  );

  my $sender = Email::Send->new(
      {   mailer      => 'Gmail',
          mailer_args => [
              username => 'jrhdeploy@gmail.com',
              password => 'jrhdeploy353',
          ]
      }
  );
  eval { $sender->send($email) };

