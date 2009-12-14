package Amon::Dispatcher;
use strict;
use warnings;
use Amon::Component;
use base 'Exporter';
our @EXPORT = qw/call/;

sub import {
    strict->import;
    warnings->import;
    Amon::Component->export_to_level(1);
    __PACKAGE__->export_to_level(1);
}

sub call {
    my ($controller, $action, @args) = @_;
    $controller = "${Amon::_base}::C::$controller";
    $controller->$action(@args);
}

1;