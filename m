Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21D32D7F1
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127736; cv=none; b=FtvuY8wfudENrx22ZGZWyeNRkcsPvkPrGv+Q0QfFYnKmyqkGbJxTV6BX1yy7FQsbavDiq8sn3ktROqoOEU0GhXktMpIMGyTVrrVRRKGaHIMv7br3gyFTJLiagTQ4/Hdinu8oRKssLAqHZzz64E2klmIO9yCmBUIZKEaJEi0+JXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127736; c=relaxed/simple;
	bh=HGxk4sZA19QD+6m7cggyFeGdYR74UGPBsDZDqHQp+kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M70KlBp7+qTL9DF5qCq4JN9vhVy7sWR+y1EGnF05YYk1K2E7DpymOjqkzwYVVAdkKvIm9MIffZJf+D3QLmCKBLnD14xfqEWp5TXDgnS3SXJh/AqJDLLxac16qVYlowEZ6Vwr4Mhm6co0ZGgion0dpHO8gouydnkPFksSDd6feXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tFxtwG/j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f6W2T6f6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tFxtwG/j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f6W2T6f6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tFxtwG/j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f6W2T6f6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tFxtwG/j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f6W2T6f6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 981795BCC3;
	Tue,  3 Feb 2026 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770127733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPSnDBU32LxsJ53VLcxkP8o8jdWVn+BzXix6F2rT9M4=;
	b=tFxtwG/j9Rif8gYKCwPeg/HeJ4UmqT9ht8EMiPN6QvBGIyuHaASfb8hdIP65pjFFSnFSze
	CQdEwGdsbSOgssXIc5fdOMZtrLfpod9jkDFmRDDmsCq+jWwIeDjbcvwa7l6ltzjH4f5isa
	C7NHPBUaI5q8N+nSLrIe9BsxvPMAIgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770127733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPSnDBU32LxsJ53VLcxkP8o8jdWVn+BzXix6F2rT9M4=;
	b=f6W2T6f6BPjoYLoF1mrI1jZCG8z5PqZfFocMMtIhwloM6LsK03LtyUq1KShj5KJJlHwoEE
	TLtF3Tijezqq/ZCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770127733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPSnDBU32LxsJ53VLcxkP8o8jdWVn+BzXix6F2rT9M4=;
	b=tFxtwG/j9Rif8gYKCwPeg/HeJ4UmqT9ht8EMiPN6QvBGIyuHaASfb8hdIP65pjFFSnFSze
	CQdEwGdsbSOgssXIc5fdOMZtrLfpod9jkDFmRDDmsCq+jWwIeDjbcvwa7l6ltzjH4f5isa
	C7NHPBUaI5q8N+nSLrIe9BsxvPMAIgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770127733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPSnDBU32LxsJ53VLcxkP8o8jdWVn+BzXix6F2rT9M4=;
	b=f6W2T6f6BPjoYLoF1mrI1jZCG8z5PqZfFocMMtIhwloM6LsK03LtyUq1KShj5KJJlHwoEE
	TLtF3Tijezqq/ZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EDB73EA62;
	Tue,  3 Feb 2026 14:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lw4yFnUBgmliZwAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 03 Feb 2026 14:08:53 +0000
Date: Tue, 3 Feb 2026 15:08:46 +0100
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: only set speed/duplex to unknown, if
 getting speed failed
Message-ID: <20260203150846.5251f62b@samweis>
In-Reply-To: <aYFqWcyuuN8V71LX@fedora>
References: <20260130111904.144024-1-tbogendoerfer@suse.de>
	<aXylwyr2pV0rZAW3@fedora>
	<20260202151726.36abe1d0@samweis>
	<aYFqWcyuuN8V71LX@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 3 Feb 2026 03:24:09 +0000
Hangbin Liu <liuhangbin@gmail.com> wrote:

> On Mon, Feb 02, 2026 at 03:17:26PM +0100, Thomas Bogendoerfer wrote:
> > On Fri, 30 Jan 2026 12:36:19 +0000
> > Hangbin Liu <liuhangbin@gmail.com> wrote:
> >  =20
> > > On Fri, Jan 30, 2026 at 12:19:04PM +0100, Thomas Bogendoerfer wrote: =
=20
> > > > bond_update_speed_duplex() first set speed/duplex to unknown and
> > > > then asks slave driver for current speed/duplex. Since getting
> > > > speed/duplex might take longer there is a race, where this false st=
ate
> > > > is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding=
:   =20
> > >=20
> > > The patch looks good to me. But based on your description, I don't th=
ink
> > > the fixes tag is correct. =20
> >=20
> > the race is old, but it got visible by that commit. Before=20
> > bond_update_speed_duplex() was only called on enslaving and when bond
> > is brought up. Now it could also be called during normal operation and
> > that's what caught attention by customers.
> >=20
> > I'm fine changing the fixes tag to whatever we agree to. So which should
> > I take ? =20
>=20
> Maybe
> 98f41f694f46 ("bonding:update speed/duplex for NETDEV_CHANGE") and
> 589665f5a600 ("bonding: comparing a u8 with -1 is always false")?
>=20
> The 98f41f694f46 set speed/duplex to -1 by default, which could cause the
> race to show SPEED_UNKNOWN. But (slave->duplex =3D=3D -1) checking is alw=
ays
> false, so no possible to show DUPLEX_UNKNOWN. The 589665f5a600 fixed this
> issue, after that speed/duplex both could be shown as UNKNOWN.

589665f5a600 only replaces the -1 with defines. So it doesn't introduce
semantic changes, but 98f41f694f46 did.

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Werner Knoblich
