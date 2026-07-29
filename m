Received: from out01-fra1-mx.uberspace.de (out01-fra1-mx.uberspace.de [185.139.157.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA14248D7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.139.157.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344998; cv=none; b=pHpKaa0GvSYfG/tLK44MrTvGUnB54PiyLyIKb69q37UwYRqAtpXBqETCu323gii5lncSdY6RG5V1piXXIsPWa6wI+62lUE+WgnCUvNzGfkay8cZRuLU7eePQj1TdwHwkJFFYfVpYATmPo4ozYYp61Uyuyrvl7ZnRoUOSgfgb00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344998; c=relaxed/simple;
	bh=EZYL9nRxpnQ53tz5dEt7H9LDjP+b+mG5bke59NfU2WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slKylrgoW4qpZtzDIWT6h0QUQMXsJCqpHJVhwwfIzNkkRAzTUB5EsV0iz6EWVthnt+4nF8cUIEHlm5pvyWTF5Z7IPnE3mZb/gGbqjhq+nvrUnPAccOFZUHYUUkyC4WA/X2FJ/Df8DDInJw2VxCO4r8Xo4rxDJmK0IFC/WTWby5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=CES/HsN/; arc=none smtp.client-ip=185.139.157.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plantwatch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b="CES/HsN/"
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out01-fra1-mx.uberspace.de (Postfix) with ESMTPS id 797F8402EC;
	Wed, 29 Jul 2026 19:09:44 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1785344984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZYL9nRxpnQ53tz5dEt7H9LDjP+b+mG5bke59NfU2WI=;
	b=CES/HsN/9KwIYMYK+0oG5J6MYtiqXNwrO3Tp2E8+enoS8liRSjIEU9lqCr+WyE7x+X9Cox
	ZXJTbjI0I4gu844JUYk1+JFmck3qFBpUpli+7DdQucSmp7l0zlYgLWmkjjP5p4YtpdJjsN
	vuJqmjGOA8/3szIn+kP7+ch8F09VOYO2YrGnpZprtyfCUPD0yt1nLrqg46Mp2OfsAUZ5SH
	uPx1t69ZuQBaRFSXKBT8ascy1D6G0Vzh+sgc5tR54b/rRhjmC3ADOIlBD72ePN+WK+M2MH
	nOPRlO1o54RD6Uh67yFpibhFDhcTVbv3ygIlq9AKlhWck2zk8meYoIbGvR35Hw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=simon.dietz@plantwatch.de smtp.mailfrom=simon.dietz@plantwatch.de
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	dietz23838@hs-ansbach.de,
	netdev@vger.kernel.org,
	simon.dietz@plantwatch.de
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Date: Wed, 29 Jul 2026 19:07:31 +0200
Message-ID: <20260729170731.1666391-1-simon.dietz@plantwatch.de>
In-Reply-To: <f837b9c2-b2e4-44b5-8e05-6191505fea8c@lunn.ch>
References: <f837b9c2-b2e4-44b5-8e05-6191505fea8c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.37 / 999.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.53)[80.47%];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	LOCAL_OUTBOUND(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[plantwatch.de:s=uberspace1];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[]

> Let frame this in IP/Ethernet/802.11 words, where applicable,
> since they are better understood by everyone.

Okay.

> [...]
> So i don't think thinking about a tunnel actually helps.

So let's stick to bridges and multiple interfaces.

> But how do we handle multiple interfaces?

That's the central question.

> Does an 802.1 bridge actually break and cause loops [when using
> GeoBroadcast / the L2 flood mechanism]?

I think, yes. Currently there is a actually a mechanism implemented,
which is described in the standard and mitigates some of the flooding,
called gn_dpd_find in gn_routing.c. It is based on the sequence number
of the last few packets recieved and a packet is dropped, if it has a
same sequence number as seen before (determined by if an entry of that
sequence number exists in a ring buffer). But I am not completely sure
if that addresses all possible problems, that could arise from all
(or even most possible) scenarios with multiple interfaces (maybe even
bridged).

> And the L2 food mechanism and the L2.5 unicast mechanism, both need
> considering, and the two might interact with each other.

I don't think they interact with each other. The worst case regarding
L2.5 unicast is - I think - when both interfaces (with the same
position) are closest to the destination node of a unicast, but not
close enough to be in range to that node. That may be problematic. But
an interaction between the L2 flood mechanism and the L2.5 unicast
mechanism I don't see at the moment.

> For the broadcast flooding, i assume there is some packet duplication
> detection, and duplicates get dropped.

It is, gn_dpd_find called from gn_update_location_table which in turn
is called in the handling process of each recieved packet.

> Can you add on top of interfaces a GN bridge, and have hierarchical
> duplication detection? If the interface has seen the packet before it
> do not rebroadcast, it just sends it up to the bridge. If the bridge
> has seen the packet before drops it.

I think gn_dpd_find currently is 'global' to the gn module, so the
other interface of the bridge would detect the duplicate packet, too
and drop it. Which in turn would mean, that bridged packets currently
would be dropped instantly. (Which is the current behavior, gn packets
currently are not transmitted over a bridge, properly).

> since interfaces can be in different locations, the table is an
> interface property. So it might require hierarchical tables, and the
> interface table just says pass the frame to the global routing table,
> and the global routing table then decides which egress interface to
> use?

Would it solve our problems/open questions, if we drop the capability
of interfaces being in different locations? (I think not completely,
but it may be worth considering nevertheless, I think).

> So lots of questions here.

Indeed.

> What we need is an architect

That I think exceeds my capabilities. Therefore I lack at least
knowledge of the linux kernel (e.g. its internal implementation of
bridges) and probably even more.

Simon
