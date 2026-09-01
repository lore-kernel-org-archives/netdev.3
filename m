Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413B3AA4F2
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291377; cv=none; b=mckvr+KAwwPuo9Wyz63FbcWYj98sHiZer/E1hdps6dKESfcZpjGIcXe1Ps3uUS3LyeVmvfJ0togYMfAGyIeGtojRZOx73ERs3teIwbTgNDrGTlfQHSSf0ZIBJ3rsIU0b3TtXwUmpHEEL5pBybcdwXmDN0uoCJA9y7Y1GtSx1bkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291377; c=relaxed/simple;
	bh=S8tVcBtQmk1gIOJgZgX6vL6li98lR+0HPMAETmKo1TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IONtUd8TD+0ohfC2cn18h1OCAg15M5g+6inXldYuGh0Wl7NxEE8BYf00d7HeGKvCdR4CB4K8znsCNHS+Ue52nzUG/rZnazEq4gKZgR87+KLZ3KKn4hbvxOh3kBY0JtO3FdhKqc8aaXwCDhnZzrqNB2LlmDJuGIBqwL7jvkFYAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=BnXgbLd6; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="BnXgbLd6"
Received: by dvalin.narfation.org (Postfix) id 0E7F320396;
	Tue, 01 Sep 2026 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788291370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IyloIUtGzLJBXQuyoH+mecbEdju+FMs6EneyHfBdrbc=;
	b=BnXgbLd6UIv+NF+nkq58UjyPcFQC6iB+IOaxKT9VAYjj+wxknxWDEO75gtnW3JlBJBl1OY
	0F3M9sIlbmlAydE68o+1oGgAED6xPIdI8UWHe1m/K78/vKmlOlg1/5uWc3W92d3bzdSbvK
	XvnlnhCL0dcrr+idoOBSbKKEbhVSlzo=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 15/15] batman-adv: tt: decrement count for committed
 client on local_remove
Date: Tue, 01 Sep 2026 21:36:07 +0200
Message-ID: <2735744.Lt9SDvczpP@sven-desktop>
In-Reply-To: <20260831135117.574836-16-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-16-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4549420.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4549420.ejJDZkT8p0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 21:36:07 +0200
Message-ID: <2735744.Lt9SDvczpP@sven-desktop>
In-Reply-To: <20260831135117.574836-16-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D15


> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> > index 794692170b61..44a8cf89382c 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
>=20
> [ ... ]
>=20
> > @@ -1423,6 +1424,13 @@ u16 batadv_tt_local_remove(struct batadv_priv *b=
at_priv, const u8 *addr,
> >  	if (!tt_removed_node)
> >  		goto out;
> > =20
> > +	/* batadv_tt_local_transition_new() may have committed the entry and
> > +	 * thus counted it in the local table size since the BATADV_TT_CLIENT=
_NEW
> > +	 * check above.
> > +	 */
> > +	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT=
_NEW))
> > +		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
> > +
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should this change carry a Fixes: tag?


I am not allowed to add Fixes: lines for patches targeting net-next. And th=
is=20
is not suitable for net or stable backports. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/


Regards,
Sven
--nextPart4549420.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcpJwAKCRBND3cr0xT1
y/4lAP9bzuKmRi7fUkP73L3i7HpGSy+CVGEaCYel6ASiYsnLfQD9EYu2l7koF89B
Om0nx+aTg0QGJZ0+Xd/ZyL8KFizLDAQ=
=gent
-----END PGP SIGNATURE-----

--nextPart4549420.ejJDZkT8p0--



