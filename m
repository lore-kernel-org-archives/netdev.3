Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28E374E55
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040767; cv=none; b=kdegPXzf/nXzWObsXu5G5bCmqbWeBAUPGlWdCH+vTJDf+coSSdnI55t3cSTbCcqU34Tkqk4astHqmyUAkWFlvApod8qIhrT2uPYmzwAEQKAaNmM2uQrxyvD3euSxCEfERVS7post+KgB25xeb/+MJ5nqgK2jBKow1PYsHVyYGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040767; c=relaxed/simple;
	bh=NhiJmScDBc0OZSXFT2WC9wjoW8IEm1e13AyqxR5LDy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFzxgJCQJuvePTomtQCqze5TOVwFIP+NtWpdw43QC8tKFbRfQqKdL0bJr3LrhjwNWVSthbvw24ABkk33aIhu2FvuN/rS6oKeJJ30MsqS2ycGEljTmFFq+t7HzBUPh+iLhPt9nOtHM84phESeZ2H+twtLZxqhohvOHG1xTzT/qpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Lr3Xtk/p; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Lr3Xtk/p"
Received: by dvalin.narfation.org (Postfix) id 42785200D8;
	Thu, 06 Aug 2026 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786040759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnMMoC+jkOYMoMxbTayS/0smcjrBmO15TJdbIvPpFQY=;
	b=Lr3Xtk/pGNS9X10GxkspK0UyOHLvrO9M6aOqkuAnIaDu8UG7xik0o0nh8MpIlPvkCMdGLA
	iP6NuM2s7lCMsWJk/4ThQQELe6Y9/QW7R2AmruQeXTNZt8j1oLIlR6PwBqVl6R7X5oXJEN
	Wqs6vvmPhxyj2D1H5plJGYjbLde7Hpw=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 03/10] batman-adv: add missing kernel-doc comments
Date: Thu, 06 Aug 2026 20:25:50 +0200
Message-ID: <2591882.ElGaqSPkdT@sven-desktop>
In-Reply-To: <20260805143200.722098-4-sw@simonwunderlich.de>
References:
 <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-4-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5263483.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5263483.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 20:25:50 +0200
Message-ID: <2591882.ElGaqSPkdT@sven-desktop>
In-Reply-To: <20260805143200.722098-4-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D3

=2D-- Patch [3]: [PATCH net-next 03/10] batman-adv: add missing kernel-doc =
comments ---

> > @@ -469,6 +510,17 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_=
node *neigh1,
> >  	return ret;
> >  }
> > =20
> > +/**
> > + * batadv_v_neigh_is_sob() - check whether two B.A.T.M.A.N. V neighbou=
rs have
> > + *  a similar or better throughput
> > + * @neigh1: first neighbour to compare
> > + * @if_outgoing1: outgoing interface to use for @neigh1
> > + * @neigh2: second neighbour to compare
> > + * @if_outgoing2: outgoing interface to use for @neigh2
> > + *
> > + * Return: true if the throughput of @neigh2 is at least 3/4 of the
> > + *  @neigh1 throughput
> > + */
> >  static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
> >  				  struct batadv_hard_iface *if_outgoing1,
> >  				  struct batadv_neigh_node *neigh2,
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Does "at least 3/4" match the comparison in the body?  The test is strict:
>=20
> 	threshold =3D ifinfo1->bat_v.throughput / 4;
> 	threshold =3D ifinfo1->bat_v.throughput - threshold;
>=20
> 	ret =3D ifinfo2->bat_v.throughput > threshold;
>=20
> For a neigh1 throughput of 100 the threshold is 75, so an exact 75 on
> neigh2 returns false rather than true.

Correct, will change it to "more than" in a patchset which deals with the=20
bonding in B.A.T.M.A.N. V. Shouldn't be too bad enough to force a resubmiss=
ion=20
of this PR.

>=20
> The second half is about the direction of the comparison.  The ops contra=
ct
> in net/batman-adv/types.h documents the hook the other way around:
>=20
> 	 * @is_similar_or_better: check if neigh1 is equally similar or better
> 	 *  than neigh2 for their respective outgoing interface from the metric
> 	 *  prospective

Already stumbled upon that. I am not really interested in B.A.T.M.A.N. V or=
=20
even bonding in B.A.T.M.A.N. V. But I don't think anyone of the developers=
=20
will react. I have therefore documented the background in=20
https://www.open-mesh.org/issues/464 and will send a patchset which uses mo=
re=20
descriptive names and reorders this calculation.

Regards,
	Sven
--nextPart5263483.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanTRrgAKCRBND3cr0xT1
yzoKAP4tAo9tZkYQ3fhZbmARuA3Zfr0Jg5KcSIH+u2NIcX2rLgD+K2jRljMl6jMC
bTghFlsQ7/TN/andWyX75pkJNiDVDAA=
=yFcm
-----END PGP SIGNATURE-----

--nextPart5263483.GXAFRqVoOG--



