Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338B488204
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282638; cv=none; b=lJSN1WLfWLLGitv8UsCOL/Sh5wLqGXsUSXV2zO1+s03sNLQdagCkYaKdwea4ItLDJ2xtPIUTbIAtfR6P/+nqwUxTBu6hbDnExg4hWYk6sIDE//Q0SZWgDWmjeQ/ocGmN6o3SxAe0+apoenLCpu1KL/mmwG/JId14bxhyHPyZt8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282638; c=relaxed/simple;
	bh=CUt72YIeT1byJv1hX3TDEO5S+fqB1PTD3D3G+5ityCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MugJwjzOJlKiuKKUh5ZScv2s57GP0ffQ7qvdg/K84sz4fprXbyz76aHhT1erpIZWK7WyrF6SQIQ9FIip5xou1D0jlcnE5k4mZi4pf4WUGb68aRUI4Kvli9lD3oV0IBEQgerswNQw5ZVHHKYzxodumNMafJXrTB+pZlyiqn5soYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=QxMozD5M; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="QxMozD5M"
Received: by dvalin.narfation.org (Postfix) id 07DFB2043A;
	Tue, 01 Sep 2026 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788282630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFv/gYEE+weqVIiW9IDNLzhXjgssJht0V2j5b9kXJJo=;
	b=QxMozD5M0QnQFi8EoE9XovU64m+o57RTbWP/Ose9GBvl8zPuP2mPdgm1oG9/qcnImT2aPf
	4f1CriXHg2q985ORP9fniMnVgAq+ASOW5a8wCHzWkxPQI/E4we1iAhuoK9qjy8uzcxqVkI
	46YPBVsjeywprk/7ph6poRS9wedqvxk=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 03/15] batman-adv: bat_v: fix bonding candidate selection
Date: Tue, 01 Sep 2026 19:10:27 +0200
Message-ID: <48341980.fMDQidcC6G@sven-desktop>
In-Reply-To: <20260831135117.574836-4-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-4-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2293903.Icojqenx9y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2293903.Icojqenx9y
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 19:10:27 +0200
Message-ID: <48341980.fMDQidcC6G@sven-desktop>
In-Reply-To: <20260831135117.574836-4-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D3

> > diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
> > index 0c27447cf688..2d3045733db1 100644
> > --- a/net/batman-adv/bat_v.c
> > +++ b/net/batman-adv/bat_v.c
> > @@ -519,8 +519,8 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_n=
ode *neigh1,
> >   * @neigh2: second neighbour to compare
> >   * @if_outgoing2: outgoing interface to use for @neigh2
> >   *
> > - * Return: true if the throughput of @neigh2 is at least 3/4 of the
> > - *  @neigh1 throughput
> > + * Return: true if the throughput of @neigh1 is at least 3/4 of the
> > + *  @neigh2 throughput
> >   */
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't an issue introduced by this patch, the "at least" wording was
> already there before the swap, but does the rewritten kernel-doc for
> batadv_v_neigh_is_sob() still describe the boundary case incorrectly?
>=20
> The implementation uses a strict comparison:
>=20
> net/batman-adv/bat_v.c:batadv_v_neigh_is_sob() {
> 	threshold =3D ifinfo2->bat_v.throughput / 4;
> 	threshold =3D ifinfo2->bat_v.throughput - threshold;
>=20
> 	ret =3D ifinfo1->bat_v.throughput > threshold;
> }
>=20
> So a candidate whose throughput is exactly tp2 - tp2/4 returns false, as
> does the tp1 =3D=3D tp2 =3D=3D 0 case, while "at least 3/4" reads as incl=
usive.

Out-of-scope for this patch and adjusted in a later patch.

>=20
> The remaining inclusive wording is the pre-existing ops-table description
> in net/batman-adv/types.h, which still documents
> batadv_algo_neigh_ops::is_similar_or_better as "check if neigh1 is equally
> similar or better than neigh2"; that text is untouched by this series.
> Should it be reworded too?

Out-of-scope for this patch.

>=20
> > @@ -540,10 +540,10 @@ static bool batadv_v_neigh_is_sob(struct batadv_n=
eigh_node *neigh1,
> >  	if (!ifinfo2)
> >  		goto err_ifinfo2;
> > =20
> > -	threshold =3D ifinfo1->bat_v.throughput / 4;
> > -	threshold =3D ifinfo1->bat_v.throughput - threshold;
> > +	threshold =3D ifinfo2->bat_v.throughput / 4;
> > +	threshold =3D ifinfo2->bat_v.throughput - threshold;
> > =20
> > -	ret =3D ifinfo2->bat_v.throughput > threshold;
> > +	ret =3D ifinfo1->bat_v.throughput > threshold;
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should this carry a Fixes: tag and a stable indication?
[...]
> That means every released kernel containing 9786906022eb keeps accepting
> bonding candidates with arbitrarily low throughput whenever
> bat_priv->bonding is enabled.  Without a Fixes: tag the change is not
> visible to stable/AUTOSEL tooling.


I am not allowed to add Fixes: lines for patches targeting net-next. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/

Regards,
Sven
--nextPart2293903.Icojqenx9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcHAwAKCRBND3cr0xT1
y+IYAQDnmKgD/H9L+eAiGA9H1fj/kFWars1dyEt/JXZ8K+MtNwEA+t2inykYK0mV
Ua0V1EiG+ZgEyqrJP60X4mGNTcQ+ugI=
=UMvS
-----END PGP SIGNATURE-----

--nextPart2293903.Icojqenx9y--



