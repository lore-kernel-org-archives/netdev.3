Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F05921EB
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888408; cv=none; b=emlEQlwl2IWWn/XL82DCAtZ6ng3lzGzWzt0GHOxZQiWrG8ZuncNa6m6HmljK8kTLmK0qy9fSlR/ec+EpitwrhsaLcTlSsJ/2jWWgcC6l0QLNPSQ3uodF7BR5QdVH8csyCNnVUONKch1FIIY6FWgAcml/nIXZPZ13L3drzpEWr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888408; c=relaxed/simple;
	bh=62Hs5rHErbWxEAtgw0qJ/GzLICsmtaHK6cNubZHVXvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiGa7mD/j6E5sg1HIUEzOKFV00/28a//FFp3DeIaeP+jgYgiInBDgg6HRTUuhDjif0W+54sjX3Xr5+6sYWzU6uRn/3vVc2zbeZP48uDLf6om71ycThaQcrEeGxpzE2Xs4nXJjSvGMny6JcDxsWalh0gN/jCwNvecnxoXCf/MDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=NbJXeKrJ; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="NbJXeKrJ"
Received: by dvalin.narfation.org (Postfix) id 28B971FE4D;
	Tue, 08 Sep 2026 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788888404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1WEMwLwpC0O2fnWxbqM0WCToy+BcA1jN5S4hrQvxk0=;
	b=NbJXeKrJOsBsi/Oe48DKBkbH+cN+af/Q9dDEzNIokHwcdNtQJwncgXw8zWONbiwnhCTTwz
	G7rRLL/npG/cj3D7Sxo2/5Yi03LIF0S/cl+AxraBNRbjH/BX0HAvLjR0RAsg+yY3FoqxAu
	jenlP1zaCOC32IyJ+RoPIg20OMUaOgU=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 11/15] batman-adv: tt: extract immediate purge of a local
 entry
Date: Tue, 08 Sep 2026 19:26:41 +0200
Message-ID: <7996121.EvYhyI6sBW@sven-desktop>
In-Reply-To: <20260907081824.2474040-12-sw@simonwunderlich.de>
References:
 <20260907081824.2474040-1-sw@simonwunderlich.de>
 <20260907081824.2474040-12-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3976506.kQq0lBPeGt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3976506.kQq0lBPeGt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 08 Sep 2026 19:26:41 +0200
Message-ID: <7996121.EvYhyI6sBW@sven-desktop>
In-Reply-To: <20260907081824.2474040-12-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-=
1-sw%40simonwunderlich.de?part=3D11


[...]
> Discovered by: opus-5 =C2=B7 Missed by: opus-4-7, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
> Is the "was never announced" wording in this new kernel doc a bit too
> strong?  The body of the same function documents the opposite case a few
> lines later:
>=20
> net/batman-adv/translation-table.c:batadv_tt_local_remove_now() {
> 	/* batadv_tt_local_transition_new() may have committed the entry and
> 	 * thus counted it in the local table size since the
> 	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
> 	 */
> 	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
> 		batadv_tt_local_size_dec(bat_priv, common->vid);
> }
>=20
> batadv_tt_local_mark_removed() drops common->flags_lock before returning
> and batadv_tt_local_remove() holds no other lock, while
> batadv_tt_local_transition_new() only holds the local list_lock and
> flags_lock:
>=20
> batadv_tt_local_commit_changes_nolock()
>   batadv_tt_local_transition_new()   /* clears BATADV_TT_CLIENT_NEW,
>                                         batadv_tt_local_size_inc() */
>   batadv_tt_local_update_crc()
>   atomic_inc(&bat_priv->tt.vn)
>=20
> So in that window the entry can be committed, counted and announced under
> the current ttvn, and batadv_tt_local_remove_now() still unlinks it from
> bat_priv->tt.local_hash instead of leaving it BATADV_TT_CLIENT_PENDING
> until the next ttvn increment, as described by
> batadv_tt_local_set_pending_event():
>=20
>  * Schedule the TT change announcement for the entry. The entry is kept i=
n the
>  * local table until the next TTVN increment so that a consistency-check
>  * response can still be answered.
>=20
> Would it make sense either to soften the new kernel doc (and the matching
> sentence in the commit message, "A client which was added after the last
> ttvn increment was never announced and can be dropped from the local table
> right away") to mention that the entry may already have been committed, or
> to fall back to the pending path when the NEW flag turns out to be cleare=
d?

See https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260908-sas=
hiko-kdoc-v1-3-535b498f2519@narfation.org/

Regards,
	Sven

--nextPart3976506.kQq0lBPeGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaqBFUQAKCRBND3cr0xT1
y5seAQCZYvOU4AIYF3w0R7bW952r3l9YtRIYnYMADqpfKWJebwEA+pTpEAWEZDxH
KuKzsnlu2gddfoimFMEPOXVk8k9rkQ0=
=3jo+
-----END PGP SIGNATURE-----

--nextPart3976506.kQq0lBPeGt--



