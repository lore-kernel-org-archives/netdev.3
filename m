Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00C38E8AC
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291228; cv=none; b=Uw2bGshQS/fYUPL8h10DTQiAgNp9JoBV/nhI7k3d8CdN0ZX6cHBZUlyR4C4LMBvUuFg2zVG2+Mapmvm3MGbpTIGV/vkGFIi+FeBcwB+tehgwVC04BEHE3zfUhENdhvtXQZGwb9Pnj4ZgpVZVQWJTSiqAu6k3kY6pRhKW8abTmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291228; c=relaxed/simple;
	bh=uCZR2jXJUV2qsZ0Wdw4TCly12LAE/U0Y1joB7j2q62g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI5kMynCbIM0NQ6fRzrj+ttJEDrgf961Lo/iRSVfyrGythH2UxiHxe1lDLqgUDL0wUI+0MoV3t/B8I9EBWRPiUIhHElfbk5HPosZdh/BFgJfIjjPEj4XMoV2nb86QBjrsFKtd1ksxU8E2qlrMo2DO7xWUr1jCEMc6kbOA1shKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=UB/u0WwE; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="UB/u0WwE"
Received: by dvalin.narfation.org (Postfix) id 5B6AB20396;
	Tue, 01 Sep 2026 19:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788291220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQm3GImKZjX3NSlbzygy8Q61DyRZs0TqW6vyMiHfK74=;
	b=UB/u0WwEJNYzPQF/vN7M6e7/ACp9jJ/kgo6HzG34MQTo0JYGiDgXXB0goFk/P5l8KGotMD
	lqgCQH1Dr1kzSWYCT5ufORDEQ2Ku6XJDUl8hhTaQOp8z1Krjp1pouYgnEKTWoIXCdeGze7
	ulMGMs7P/fEnfv58EOx3YI9/WaheVg4=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 14/15] batman-adv: tt: don't uncount never committed
 clients on pending purge
Date: Tue, 01 Sep 2026 21:33:37 +0200
Message-ID: <2089489.usQuhbGJ8B@sven-desktop>
In-Reply-To: <20260831135117.574836-15-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-15-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3649466.QJadu78ljV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3649466.QJadu78ljV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 21:33:37 +0200
Message-ID: <2089489.usQuhbGJ8B@sven-desktop>
In-Reply-To: <20260831135117.574836-15-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D14

> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> > index a870d9a97e32..794692170b61 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
>=20
> [ ... ]
>=20
> > @@ -4019,8 +4023,13 @@ static void batadv_tt_local_purge_pending_client=
s(struct batadv_priv *bat_priv)
> >  					   tt_common->addr,
> >  					   batadv_print_vid(tt_common->vid));
> > =20
> > -				batadv_tt_local_size_dec(bat_priv, tt_common->vid);
> >  				hlist_del_rcu(&tt_common->hash_entry);
> > +
> > +				/* An entry which still carries BATADV_TT_CLIENT_NEW was
> > +				 * never counted and must not be uncounted here.
> > +				 */
> > +				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
> > +					batadv_tt_local_size_dec(bat_priv, tt_common->vid);
> >  			}
>=20
> Discovered by: gpt-5-6-sol, opus-5, sonnet-5 =C2=B7 Missed by: sashiko-ge=
mini
> Should this carry a Fixes: tag and a Cc: stable hint?


I am not allowed to add Fixes: lines for patches targeting net-next. And th=
is=20
is not suitable for net or stable backports. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/

Regards,
	Sven
--nextPart3649466.QJadu78ljV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcokQAKCRBND3cr0xT1
y/SSAQCtPbvVaDKm5YLFTiYOdgIqrp0Q8igeg9XRglo6tDX5QQD/fV0CDLZDhbFY
dDdEnLN2635iTdFhWIxTKfnvanR0RgI=
=lnez
-----END PGP SIGNATURE-----

--nextPart3649466.QJadu78ljV--



