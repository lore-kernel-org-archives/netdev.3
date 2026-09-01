Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0ED419304
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283237; cv=none; b=af3TWnpzdb+2wMze8bHBO+p6jOHeFPRgfrUoPL1T1ncVefbrFKFeQ7PMeOEbsR+/RcSH2Oy6TcSfNm4a6m+f3fEK1hxoNJvrJdMj5S/ScWXZfOopFUTzimAcyzPHZyCuK3Wpg1MpOnKciw0FxvrOhmR8FVC1r+8sZgXbMNgWI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283237; c=relaxed/simple;
	bh=hDtd7WViYBh9GmGJERNa2KqPxQzY7B4p/Oq+TC3MaPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOBF1L3X/TBj2r+UFG3cFRNcaCh7J8A/V2MscHaNQEEUorzbPQjnEg5dPrL54lhYJFJO8nwBO9MuuCbEFrcjbrApf3lsFkN33kRp3Ud27mNkfP+OwWMkF+n2hvb7NIs/WtdQObGH06p29oL40N4xCc7mf7YUwN9wXJnfHnPiyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=hBQx4vaS; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="hBQx4vaS"
Received: by dvalin.narfation.org (Postfix) id 9F9071FE7E;
	Tue, 01 Sep 2026 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788283229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKotAP8wIM632B6Qzi4Laf7xzJu+rWicdboEu6B0ej8=;
	b=hBQx4vaS08u++5lmX+bTNC88m2XBLjeSOqDlBuUtdPljg4we65V/IInSANMhqFT9a8B0mu
	4cRz1fiVImlUVuA6VZep9pwMpP7IMhZwInLbFPnENXrg7Z8+/yIadOGfnXEkXuTe9pp89s
	6hFTC7YzP9Sp0MuOH8rWB/EfPSc9+ew=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 05/15] batman-adv: use more descriptive var names for
 is_similar_or_better
Date: Tue, 01 Sep 2026 19:20:26 +0200
Message-ID: <5705187.Sb9uPGUboI@sven-desktop>
In-Reply-To: <20260831135117.574836-6-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-6-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2067881.yKVeVyVuyW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2067881.yKVeVyVuyW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 19:20:26 +0200
Message-ID: <5705187.Sb9uPGUboI@sven-desktop>
In-Reply-To: <20260831135117.574836-6-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D5

> > diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> > index 53fbdbbe8f4f..3fe09b4c3046 100644
> > --- a/net/batman-adv/bat_iv_ogm.c
> > +++ b/net/batman-adv/bat_iv_ogm.c
> > @@ -2424,25 +2424,26 @@ static int batadv_iv_ogm_neigh_cmp(struct batad=
v_neigh_node *neigh1,
> >  /**
> >   * batadv_iv_ogm_neigh_is_sob() - check if neigh1 is similarly good or=
 better
> >   *  than neigh2 from the metric prospective
>                 ^^^^^^          ^^^^^^
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug, but was the summary line of the kernel-doc for
> batadv_iv_ogm_neigh_is_sob() meant to be converted too?

Good point, prepared a follow up patch.
https://patch.msgid.link/20260901-bat_iv-sob-kdoc-v1-1-54be2f58b715@narfati=
on.org

Regards,
	Sven
--nextPart2067881.yKVeVyVuyW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcJWwAKCRBND3cr0xT1
yxAuAQDG1I805mYMpXg55gEtqWSCdXkO9pQvbiaP3RsjAwPQtwEAqgvHVVn/oUa/
XbNWp3FK3qw2v8YD4pjsSw95Q08EjgA=
=jSDt
-----END PGP SIGNATURE-----

--nextPart2067881.yKVeVyVuyW--



