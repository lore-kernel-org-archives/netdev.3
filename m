Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4F36E460
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291087; cv=none; b=uVvp3kvbvfbJFsdfLJJaUm1cWKqU8mnpiDZXml9FyEynDPf4TqR114Zw60ZeBoI579V1h9FHgFNXvKBUCW59xdkFzTCrTiPNwSbCtiB7DYpRE2kAbFkdTC7ELRyhulWRqpIzeJLkOstlFkj+t7ICRxg+uivRX4CqxBYYfEl+pig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291087; c=relaxed/simple;
	bh=YNwMAMdjJUVbMECvYyIcYMHFG/AzeFznTfNKkU7bkAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhO5YGSz+lykLYWuk03NGm3fS/TCOzyqBjeGGC01UmfawM5u54qcbuXsjlSlftyQzuOm4Qv6pAaAeSNV/+CC9xW8XqvMVkjY42XyWXjab3RgsMinAxdJ1Ugb1QsJdOvUWaUkyJ692uWQcRePlKMMk3RCoEmONzI87CJjBB/jonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=In7PdX1Q; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="In7PdX1Q"
Received: by dvalin.narfation.org (Postfix) id 0CCE620396;
	Tue, 01 Sep 2026 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788291079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8/3xnSGNAuxKXecyvenpH9ckOoYM2DkfQ9xiFLBGm4=;
	b=In7PdX1QgpCvP6splh6EY5cd+AoJtviWIFGOm7hpUnzJ2fF+Lp5r+TSCetbliyIIS+hWJi
	ydBmA7ETjYnjKIBgSqR30e9UGA440bKLnaUqseT6ZyNy7uam2aDwtlv5iehcV9Wd6RjL7F
	gGWVGRdrr0Xpey4yCxMMpEmqDszgoRk=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 13/15] batman-adv: tt: transition NEW local entries only
 under lock
Date: Tue, 01 Sep 2026 21:31:16 +0200
Message-ID: <6209959.MhkbZ0Pkbq@sven-desktop>
In-Reply-To: <20260831135117.574836-14-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-14-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1886846.VLH7GnMWUR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1886846.VLH7GnMWUR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 21:31:16 +0200
Message-ID: <6209959.MhkbZ0Pkbq@sven-desktop>
In-Reply-To: <20260831135117.574836-14-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D13


[...]
> Should a Fixes: tag naming that commit be added?
>=20
> Note that this patch depends on the tt_common_entry->flags_lock
> infrastructure added earlier in the same series, so a direct stable
> backport would need adaptation and the tag would mostly serve
> identification.

I am not allowed to add Fixes: lines for patches targeting net-next. And th=
is=20
is not suitable for net or stable backports. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/


>=20
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> > index 163f90962306..a870d9a97e32 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -333,6 +333,10 @@ static void batadv_tt_local_size_mod(struct batadv=
_priv *bat_priv,
> >   *  given vid
> >   * @bat_priv: the bat priv with all the mesh interface information
> >   * @vid: the VLAN identifier
> > + *
> > + * It must only be called when removing the NEW flag of a
> > + * batadv_tt_local_entry while it is still part of the bat_priv->tt.lo=
cal_hash.
> > + * It must therefore be checked under the specific list_locks[i].
> >   */
> >  static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
> >  				     unsigned short vid)
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This is a pre-existing issue and not introduced by this patch, but does
> the new invariant ("It must therefore be checked under the specific
> list_locks[i]") hold on the removal side as well?
>=20
> batadv_tt_local_remove() decides that no batadv_tt_local_size_dec() is
> owed while holding only flags_lock, then drops it before unlinking:
[...]
> Can vlan->tt.num_entries stay inflated by one in that case, the same
> "nothing will reduce the counter again" failure mode, reached through
> the check side instead of the walk side?


Out-of-scope for this specific patch. See patch
"batman-adv: tt: decrement count for committed client on local_remove"

Regards,
	Sven
--nextPart1886846.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcoBAAKCRBND3cr0xT1
yytgAP0abRyhK1qE8phNcYEUwb3RLsZYEza5P0U3/7+qEBaGRwD/fY1NCC6BfXGa
DzZdIS4cke3tZBQCD2gQQsteKb2piwQ=
=UNY8
-----END PGP SIGNATURE-----

--nextPart1886846.VLH7GnMWUR--



