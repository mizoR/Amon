use strict;
use warnings;
use utf8;

package Amon2::Setup::Flavor::Lite;

sub parent { 'Base' }
sub is_standalone { 1 }
sub plugins { qw(
    Web::HTTPSession
    Web::CSRFDefender
) }

1;
__DATA__

@@ app.psgi
: cascade "!";
: around app -> {
use Plack::Builder;
use Amon2::Lite;

# put your configuration here
sub config {
    my $env = $ENV{PLACK_ENV} || 'development';
    if ($env eq 'development') {
        +{
: $plugin.config_development
        }
    } elsif ($env eq 'deployment') {
        +{
: $plugin.config_deployment
        }
    } elsif ($env eq 'test') {
        +{
: $plugin.config_test
        }
    } else {
        die "Unknown PLACK_ENV: $env";
    }
}

get '/' => sub {
    my $c = shift;
    return $c->render('index.tt');
};

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;
        $res->header( 'X-Content-Type-Options' => 'nosniff' );
    },
);

: $plugin.context

: $plugin.web_context

builder {
    enable 'Plack::Middleware::Static',
        path => qr{^(?:/static/|/robot\.txt$|/favicon.ico$)},
        root => File::Spec->catdir(dirname(__FILE__));
    enable 'Plack::Middleware::ReverseProxy';
: $plugin.middleware

    __PACKAGE__->to_app();
};

<: '__DATA__' :>

<: '@@' :> index.tt
<!doctype html>
<html>
<head>
    <met charst="utf-8">
    <title><: $module :></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <: $module :>
</body>
</html>
: }

__END__

=head1 NAME

Amon2::Setup::Flavor::Lite - Amon2::Lite flavor

=head1 SYNOPSIS

    % amon2-setup.pl --flavor=Lite MyApp

=head1 DESCRIPTION

This is a flavor for project using Amon2::Lite.

=head1 AUTHOR

Tokuhiro Matsuno
