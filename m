Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55455489885
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283469; cv=none; b=VEk/Oa9OnEC8/qV4Leg303Kseh61GCuqNPNorvDmsig/Gaop9CvZN0IipM4Z8xYJFShNuMh+iOmjeskidplM8nZN1KCBF+XdbkeyM3hTokajIr9z+zAsNxQMj4eOAVitwZNKb0Wx/fdbsuUyRNebOpbtZFW9shb4esQ4lFUGy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283469; c=relaxed/simple;
	bh=V++8RJKAhD9jmXsN2ra2GRlz6ByXsfCKxRtHy1+D76g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xrv5kIlSRNE0i/dfYM3vNRM6LtnUr1BHtNUfKELrNgA6hvDmaKcjJfCnsmYXAlU4YunqFMaN/c7mJez9G2MvXC+Ei5KuYGIDemfktnPaCFH+fqQeUaj4vc06+WcF7oXIvRAEEE3mMNb0c/H95GnvDVlgVuFaZpIYZul4Dk+KEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=eEKWGOGD; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="eEKWGOGD"
Received: by dvalin.narfation.org (Postfix) id 0DF0E1FE7E;
	Tue, 01 Sep 2026 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788283462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X1ppzOEJMSS7dm9q753kJPAR6gmpcAyyraBBvCv4WzM=;
	b=eEKWGOGD99etOq6BW66ReYBKdbCCj5IZuQTpKzuD6ewCo8I2JcmlNFi6tC4mqLfNynVI5X
	5hqHk2DXvNVszm719u/p/UZ7DEfV54BdKdvrRPbpn8TdFsWXyGXXblEz08Sw9NjkBfjpaa
	y486llneMYZKQ7rptIr7w/7AbQZIOHc=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 07/15] batman-adv: ensure u16 aligned mac address in
 structs
Date: Tue, 01 Sep 2026 19:24:14 +0200
Message-ID: <2932049.BEx9A2HvPv@sven-desktop>
In-Reply-To: <20260831135117.574836-8-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-8-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15835535.tv2OnDr8pf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart15835535.tv2OnDr8pf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 19:24:14 +0200
Message-ID: <2932049.BEx9A2HvPv@sven-desktop>
In-Reply-To: <20260831135117.574836-8-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D7

> > An u8 array in structures have a natural alignment of only 1 byte. An
> > u8[ETH_ALEN] array must therefore be assumed to only be 1 byte aligned.=
 But
> > many etherdevices.h functions are requiring a 2 byte (u16) alignment.
> >
> > All these addresses were either on the start of a struct or after a str=
uct
> > member which required at least an alignment of 2 byte. Still, annote all
> > u8[ETH_ALEN] arrays on the stack as __aligned(2) to make sure that this
> > assumption isn't broken by other modifications inside the structs.
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should "arrays on the stack" read "arrays in structs" here?

Yes, copy+paste error. Minor for this PR

> > diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> > index 99667f632d4d..c42a4aa8f41a 100644
> > --- a/net/batman-adv/types.h
> > +++ b/net/batman-adv/types.h
>=20
> [ ... ]
>=20
> > @@ -634,12 +634,12 @@ struct batadv_hardif_neigh_node {
> >  	struct hlist_node list;
> > =20
> >  	/** @addr: the MAC address of the neighboring interface */
> > -	u8 addr[ETH_ALEN];
> > +	u8 addr[ETH_ALEN] __aligned(2);
> > =20
> >  	/**
> >  	 * @orig: the address of the originator this neighbor node belongs to
> >  	 */
> > -	u8 orig[ETH_ALEN];
> > +	u8 orig[ETH_ALEN] __aligned(2);
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Is the claim "All these addresses were either on the start of a struct or
> after a struct member which required at least an alignment of 2 byte"
> accurate for batadv_hardif_neigh_node.orig?
>=20
> That member directly follows u8 addr[ETH_ALEN], which only requires 1 byte
> alignment; orig ends up on an even offset because ETH_ALEN happens to be
> even, not because the preceding member forces 2 byte alignment.  Would it
> be worth rewording that sentence?

But the struct member required indirectly an aligned of 2 bytes

Regards,
	Sven
--nextPart15835535.tv2OnDr8pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcKPgAKCRBND3cr0xT1
y4a4AQCjFk+sHDBBtfBPMvaF9V3OJlOI2QTKV2YLoSyrTCPdTQD9HKjKrKBqT+eF
+cEhLzSLSqF5uZjv7X/hyPhVLG1+vQg=
=9UEE
-----END PGP SIGNATURE-----

--nextPart15835535.tv2OnDr8pf--



