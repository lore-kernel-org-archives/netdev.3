Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98742049F
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282230; cv=none; b=VeVa/oyS6P8WWNwiFddCRrGCH4JL38W76fcv/C/l8kKtWXYqOlgFhMFgPdJj2DMnhycvkBOs/wHeikfazKBAO48Ueaxrmj9y1QIoiKYTwMr0T7hlnvbRlFWIV00NdUflhxQ24CJDYQpAX+wo1jsI/cC/0eXmLOkeJlJdh3SQZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282230; c=relaxed/simple;
	bh=kmcocA2fK2UuaEoTow1ozw9Tx1Hmf12zjoTokES8KmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqStgb6YqoQ1o6sf0Md2ltXtOk/dotLr07cz6nhak+OZmwxvR02WwsuFj9n5qiysgq9vUa2mANJHCJ4VGeoIC+3Ske4AJZ1X+VqONuuUHymwaO69hsydwjANUN7HGe9DkVQKX96u++phxiMek1OY7IQqI/tReRbFQ5DmP0TT/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=IHB/GMXr; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="IHB/GMXr"
Received: by dvalin.narfation.org (Postfix) id 78C721FE3B;
	Tue, 01 Sep 2026 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788282222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eEiFK4fhFRFEx4C3WuFVBW00EISoLMKBQpn4kxezFo=;
	b=IHB/GMXr9W/LqU5axoVxe6tEJRRkQBCjIZROd/e3317JkidlLJeo7Ou0wQa7U9+hj0Q7cf
	+7osDgO+o9+DoSss0R2O4Ebmw5O9JB6e8pshVqBuM+OA6otkn8AM+rytgsCVDxC98jwD2R
	U/yVbFzmmzpWM+MdkVPaQwYGwvMPRIY=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 01/15] batman-adv: dat: fix printing of unknown 4addr
 subtype
Date: Tue, 01 Sep 2026 19:03:40 +0200
Message-ID: <2290990.Mh6RI2rZIc@sven-desktop>
In-Reply-To: <20260831135117.574836-2-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-2-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3782765.R56niFO833";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3782765.R56niFO833
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 19:03:40 +0200
Message-ID: <2290990.Mh6RI2rZIc@sven-desktop>
In-Reply-To: <20260831135117.574836-2-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D1


> --- Patch [1]: [PATCH net-next 01/15] batman-adv: dat: fix printing of un=
known 4addr subtype ---
> commit 974c511b32b67ede89d952e4508493380b181449
> Author: Sven Eckelmann <sven@narfation.org>
>=20
> batman-adv: dat: fix printing of unknown 4addr subtype
>=20
> The default arm of the subtype switch in batadv_dbg_arp() was printing
> unicast_4addr_packet->u.packet_type instead of the subtype that was not
> recognized. This changes the debug message to print the subtype value.
>=20
> > diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/di=
stributed-arp-table.c
> > index 011cfdc47fab..270f8d6e2954 100644
> > --- a/net/batman-adv/distributed-arp-table.c
> > +++ b/net/batman-adv/distributed-arp-table.c
> > @@ -548,7 +548,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_=
priv, struct sk_buff *skb,
> >  			break;
> >  		default:
> >  			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: Unknown (%u)!\n",
> > -				   unicast_4addr_packet->u.packet_type);
> > +				   unicast_4addr_packet->subtype);
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should this carry a Fixes: tag?
>=20
> The change corrects a real defect in batadv_dbg_arp(): the default arm of
> the switch (unicast_4addr_packet->subtype) block was printing the outer
> packet_type, which on that path is always BATADV_UNICAST_4ADDR, so the
> message never showed the unknown value.
[...]
> Would adding
>=20
>   Fixes: 5c3a0e553593 ("batman-adv: Distributed ARP Table - add ARP parsi=
ng functions")
>=20
> be appropriate here, so netdev and stable tooling can date the affected
> history? The code change itself looks correct; only the missing tag stands
> out.

I am not allowed to add Fixes: lines for patches targeting net-next. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/

Regards,
Sven
--nextPart3782765.R56niFO833
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcFbAAKCRBND3cr0xT1
y++pAQD8SbxH2mc0nZ1HpGd4OIjRN2vo2Nik6g6z46mCItAzgwD+ImssDGqfIkj+
gPZkWWEsl5xSHFE+IOQUXJ0a92bwogU=
=4oxe
-----END PGP SIGNATURE-----

--nextPart3782765.R56niFO833--



