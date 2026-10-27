Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103105;
	b=RB11lItLQK6OKmF9ZqblwBsFV7fsa9thJZTzrOPS8ujTvBJhNbVdL0fZCKLNcNzPIJ9M
	 csIlyNp7Mx4JybglKg6KZbguDABS+BkrSePCT46oMjFdeaJbCLHRe3IQfps9IeV24rAhx
	 R0m8A58dX54GPO2eTJx5WbxV9SoQF2XHnGMnUB5iqkU8VnuY07Ism7VUSzr4gFbFtETgC
	 UHlr1wJAEmocrmllxYaCVHHMYgLNwRlDHG4R9/x9qgjkNyyND5uWx+cmDplS74BJiKxng
	 ww0PCdthke9p4kn/rI4YeqtTls3x/tV7abE5ojGfl4b1lyWZaP6RlQViYRdW6vTgwog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103105;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type;
	bh=9RA/xsPWE7iX/5+zhjVd4uSj9i7bQuXj68Gc6UmAfS0=;
	b=nhLEJkl3uRIDgz0x2lzX7jITmsCQk6tWZZde3Qp4O62W7gMTyQXWYwPbV5+i/ZhbcprJ
	 PI3GfNsmp4TwSo/+4pa+O91XKC1dCS5Jjmmmt08N4oJv7aLHoGjJ6gdM6ZSFCrQlxcWLn
	 kezU8gvV07k3mvI6F9d7o6JaxFvLOz1l70+90YbCTspUXUpTZc/k5u+KHQcGTglotmeUU
	 lRG+CwNUi/7GkJndBVLRhFGw7X+aJi4wzHNxPceolWPI4ntdILczClfbWv+rvAond0B4L
	 H5gL5svarkZA3FhG/PaZkunXZCI5V6bAyhnf/JWyYufdNCUooJ6fjQvzNvbvSCTy8TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=BBKHFlx2;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3F606A321
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64F3F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=BBKHFlx2
Received: by dvalin.narfation.org (Postfix) id 029ED202F3;
	Tue, 27 Oct 2026 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793103096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9RA/xsPWE7iX/5+zhjVd4uSj9i7bQuXj68Gc6UmAfS0=;
	b=BBKHFlx2Fhz5/44C+m+jbdE9Qglch5ZLWct58ZUG56OfblYF/qENFmpe8EvTsfdrB/apHm
	ymrq6H1U51xMn+WOe5+VjqWyLHq4z4wKqtSHh/rYqkxjoivPHjxDX2cgbj528d1Ol8IcfD
	x6kYzYNjogfNz4nlk2DIaXPnj1aDUAc=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject:
 Re: [PATCH net 07/10] batman-adv: tt: only transmit local ROAM flag together
 with DEL
Date: Tue, 27 Oct 2026 13:11:30 +0100
Message-ID: <2294364.Icojqenx9y@ripper>
In-Reply-To: <179309132249.3134.16887364336514212941@kernel.org>
References:
 <20261026085309.1074911-8-sw@simonwunderlich.de>
 <179309132249.3134.16887364336514212941@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart119544528.nniJfEyVGO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart119544528.nniJfEyVGO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 27 Oct 2026 13:11:30 +0100
Message-ID: <2294364.Icojqenx9y@ripper>
In-Reply-To: <179309132249.3134.16887364336514212941@kernel.org>
MIME-Version: 1.0

On Tuesday, 27 October 2026 09:55:22 CET netdev-bot+sashiko@kernel.org wrote:
> batman-adv: tt: only transmit local ROAM flag together with DEL
> 
> This patch stops local TT entries from sending BATADV_TT_CLIENT_ROAM
> unless it comes with BATADV_TT_CLIENT_DEL. The ROAM bit is now cleared
> for non-DEL events in __batadv_tt_local_event() and for full table
> responses in batadv_tt_local_valid(). The goal is to stop receivers from
> treating a plain ADD as a roaming advertisement.
[...]
> 
> [Severity: Medium]
> 
> Does this fix the requester-side symptom described in the commit
> message?
>
> The commit message says:
> 
>   When the requester is the node which sent the ROAMING_ADV, it then
>   marks its own (new) local client as roamed back to the old originator
>   and drops it when it is still NEW.


No, this is not the symptom. It is just the way the roaming works.

The relevant part is "But such a behavior doesn't make sense for non-ROAM_ADV 
because a new TTVN [...] should therefore be used to create a temporary (roam) 
global entry in a node." It is there to announce the "committed" local entries 
which everyone should use in their global table for this originator. And ADD 
is therefore required - but not the roaming flag because it would be 
interpreted as roaming announcement. See also 
https://www.open-mesh.org/projects/batman-adv/wiki/Client-roaming#Translation-table-consistency

There are also pending changes for TT which avoid this odd removal of the 
ROAMING and flash it out more in the receiver side [1,2,3].

Regards,
	Sven

[1] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261008-tt-avoid-unhashed-event-v2-2-7c4eed81606d@narfation.org/
[2] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261008-tt-avoid-unhashed-event-v2-3-7c4eed81606d@narfation.org/
[3] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261008-tt-avoid-unhashed-event-v2-4-7c4eed81606d@narfation.org/
--nextPart119544528.nniJfEyVGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCauCU8gAKCRBND3cr0xT1
y9ZtAP0drgonQgtLdtN+ois4rAObGdjhVcdOZRhqLIO/gZ9OcwD/YJbHo4BEByYC
51zGNh19L04Y0SN+ZIeks2+lvDyLtQc=
=HsmC
-----END PGP SIGNATURE-----

--nextPart119544528.nniJfEyVGO--



