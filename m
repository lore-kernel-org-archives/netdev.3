Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CF6499F08
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788286506; cv=none; b=j6h8Nu35z48CEug/BC6IQf7+3okUY8YIRp9pQ60pBhgv7hSTuAY15Uh9n6tUVBnZz+ZglRsmrLwpHfUPdsxu5M/XLQ7OF0P4aGuwp9QTdj8a1P/FCsAKnaI3vfGa+jFXJ0m4nH2ThrYSCSZj1wijnfQv296S7BWEFpgOW0svz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788286506; c=relaxed/simple;
	bh=7Md21SNFUZ/FwUDnq9F1Vngx+g/GXrEeeHf6P5HY5oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVWkYciQ5REoQQbX4QTQPu+AQPkAzi38am9pZjqHmXYtFi27CCCk5i8FFvzCcEwb0O608bHj3sOlRNnS9I4D3+sPAE4RSeXpQpbksigBxnMAymw4hhfWAIxubbo69b0Nvjt2+nAYS8EtjrzFqAQkHCaHmrSc57y+KUwv4YgD/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=lK+BvUpG; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="lK+BvUpG"
Received: by dvalin.narfation.org (Postfix) id 45383203D9;
	Tue, 01 Sep 2026 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788286498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVKLuxjWTOyErIPOuRo9M8ikjLwSjXWNwjxlJDxKYJw=;
	b=lK+BvUpG0IRjdGJB4UrUW/KlCrXQp/05w3gtNmjVIFEBwA/YGmiqVq7ElSGdRjDwaOD8Ua
	+ZZwkKqzRgC4Djo8FjY3MzGqTSIF93ujtujCj33Syjlwz0XBSmIVasLAsv2ipGLWVHp+O+
	lxm/wwtrKrEkbGBUe1C9/L67cX37PMQ=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 09/15] batman-adv: tt: extract code handling a roam on
 add
Date: Tue, 01 Sep 2026 20:14:55 +0200
Message-ID: <2865163.mvXUDI8C0e@sven-desktop>
In-Reply-To: <20260831135117.574836-10-sw@simonwunderlich.de>
References:
 <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-10-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12980698.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart12980698.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 20:14:55 +0200
Message-ID: <2865163.mvXUDI8C0e@sven-desktop>
In-Reply-To: <20260831135117.574836-10-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D9


> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug introduced by this patch, since it is pure code motion, =
but
> now that the sequence sits in its own helper it becomes more visible: is =
the
> check-then-act on tt_global->common.flags in batadv_tt_local_add_roam()
> racy?
>=20
> The test and the update are separated by the ROAM_ADV loop, and no lock is
> held around either:
>=20
> 	if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
> 		return;
> 	...
> 	hlist_for_each_entry_rcu(orig_entry, head, list) {
> 		batadv_send_roam_adv(...);
> 	}
> 	...
> 		tt_global->common.flags |=3D BATADV_TT_CLIENT_ROAM;
>=20
> The rcu_read_lock() here only covers the orig_list walk.
>=20
> Meanwhile batadv_tt_global_add() does a non-atomic read-modify-write on t=
he
> same field from TVLV processing:
>=20
> 	common->flags |=3D flags & (~BATADV_TT_SYNC_MASK);
>=20
> and batadv_tt_global_del_roaming() also sets BATADV_TT_CLIENT_ROAM. There=
 is
> no common lock between those paths at this commit.
[...]

Please look at the next patches to see how locks are introduced.

Regards,
	Sven
--nextPart12980698.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcWHwAKCRBND3cr0xT1
ywoqAQDIPV8uj0iioqhCBBo+tFp1GDSYvPvIcNf5AkUJc6mgOgEArz5eo9eikxsO
Qy3JKz7VoanpMJ+70ozFWs1IXj4GhAY=
=vMsJ
-----END PGP SIGNATURE-----

--nextPart12980698.O9o76ZdvQC--



