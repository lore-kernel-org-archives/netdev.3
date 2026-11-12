Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481079;
	b=NYL23/suniKhipQMiTMY010yby+Ky+gRn/WVmjFDxaL5VIRT3NkJOOPT+44fnd/oKm3E
	 l0oz23qOqpxmmHtcggKpePi2jWzB220a4+WRzlkpS0lNoNbsGmKCHB04/v3nTmX3pSWV4
	 ClUdythONhC2z163TqwJelH+SR2I3jsAD+GJNoFvXDI06HNdjtbpi5MfswVeFvqTV+81h
	 7FkWZKZelxcdnjxXRK0iUP0W7Bqwo1M8oFuQn5h5lQu7h6ohgEdVsSU3S0Mz+kTADSCXc
	 Q79uaJy6rkjHzRxBoTS9JL4Oxw+/4mviaGD1fCw8RQj2JXkmj3KbYluv8KqWU8Tk8ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481079;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type;
	bh=ycpTw26ozG7nGyxNHYwJnlgidjx45yFTso1Q38E6eC8=;
	b=UcOst0nj3TDekbW08456Bzf0DA/dQnf+/7LOwsMCa/jcuQl+WohRONoi5Mr1igSsGpP9
	 0DyGw+x/U5x+0w5uSa7hdLLAFHinYix76fazg8pj3Fae/wN3PbinhtBgWPvXbVjdkcUuo
	 QnwEOlChxkiVacj4+VypXf8WovQiEK4ECozGFNyEv6UaJ33pssLUZglA8+vatyiChrh1A
	 GNf7vTI+khOCQMlCBVWcWgUItsjy26xaNsVHgIg4UmpzumoSteG6lXTZHCjQcVY/RF0es
	 lkOweLaQCDZArNqnsgyYasP7MHUcW9nPpPS0PU+dIYFYxsaQr1ybYHuz1KoE0lqN7Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=V2zvC8CS;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BC606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B6BC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=V2zvC8CS
Received: by dvalin.narfation.org (Postfix) id 7DB7A1FEF7;
	Thu, 12 Nov 2026 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794481077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycpTw26ozG7nGyxNHYwJnlgidjx45yFTso1Q38E6eC8=;
	b=V2zvC8CS10XdJfMs1wizSVU/bVMVxl4+Y4HkAcFfF6Qy+Ib+WuFKzV6cVukCowGYJp/WjH
	4AMEHM5ikYrdPyEEXPGwsKlQJPi2+fQKN0a28+017xhQjmsNKhZhouBbnKdM5Z9anJPgSU
	oP6Wg2FEEDh0dY/kEQ+4Fsx2nkrnP8M=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev, netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject:
 Re: [PATCH net-next 08/15] batman-adv: tt: annotate last_seen with
 READ/WRITE_ONCE
Date: Thu, 12 Nov 2026 11:57:55 +0100
Message-ID: <2765052.7s5MMGUR32@ripper>
In-Reply-To: <sashiko-outbox-210958@kernel.org>
References:
 <20261111102729.2096241-1-sw@simonwunderlich.de>
 <20261111102729.2096241-9-sw@simonwunderlich.de>
 <sashiko-outbox-210958@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3402950.aV6nBDHxoP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3402950.aV6nBDHxoP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev, netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 12 Nov 2026 11:57:55 +0100
Message-ID: <2765052.7s5MMGUR32@ripper>
In-Reply-To: <sashiko-outbox-210958@kernel.org>
MIME-Version: 1.0

On Thursday, 12 November 2026 11:34:43 CET sashiko-bot@kernel.org wrote:
[...]
> [Severity: High]
> This problem wasn't introduced by this patch, but can dropping
> common->flags_lock in batadv_tt_local_add_existing() before queueing the
> ADD event [1] let a delayed ADD cancel a concurrent DEL event?
> 
> batadv_tt_local_add_existing() clears BATADV_TT_CLIENT_PENDING under
> common->flags_lock, and its caller batadv_tt_local_add() only queues the
> corresponding ADD event via batadv_tt_local_event() after the lock has
> been released:

This is handled by a pending patchset [1] which couldn't be submitted here 
because were have so many other things to fix in the TT code and already fill 
our submission up to the max of 15 patchset since a while.

And it is completely irrelevant for the submitted patchset.

Regards,
	Sven

[1] https://git.open-mesh.org/pub/ecsv/batman-adv.git/log/?h=b4/tt-avoid-unhashed-event

--nextPart3402950.aV6nBDHxoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavWbswAKCRBND3cr0xT1
y/YpAP9pCjha3Y6xeOY65LTDoFqSdDfgud9m+uI8fWcRtekfsQEAsqHTFRxclv59
2bqkJCF1r3maEqFRRG6k5F/gwf64VAo=
=b0cZ
-----END PGP SIGNATURE-----

--nextPart3402950.aV6nBDHxoP--



