package Attribute::Abstract;

use warnings;
use strict;
use Attribute::Handlers;

our $VERSION = '0.01';

sub UNIVERSAL::Abstract :ATTR(CODE) {
	my ($package, $symbol) = @_[0,1];
	no strict 'refs';
	my $sub = $package . '::' . *{$symbol}{NAME};
	*{$sub} = sub {
		my ($file, $line) = (caller)[1,2];
		die "call to abstract method $sub at $file line $line.\n";
	};
}

1;
__END__

=head1 NAME

Attribute::Abstract - implementing abstract methods with attributes

=head1 SYNOPSIS

  package SomeObj;
  use Attribute::Abstract;

  sub new { ... }
  sub write : Abstract;

=head1 DESCRIPTION

Declaring a subroutine to be abstract using this attribute causes
a call to it to die with a suitable exception. Subclasses are
expected to implement the abstract method.

Using the attribute makes it visually distinctive that a method is
abstract, as opposed to declaring it without any attribute or method
body, or providing a method body that might make it look as though
it was implemented after all.

=head1 BUGS

None known so far. If you find any bugs or oddities, please do inform the
author.

=head1 AUTHOR

Marcel GrE<uuml>nauer, <marcel@codewerk.com>

=head1 COPYRIGHT

Copyright 2001 Marcel GrE<uuml>nauer. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

perl(1).

=cut
