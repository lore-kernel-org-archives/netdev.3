Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D02C1584
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399792; cv=none; b=ANYXmdxYC8+m1aR93LLk/UyN8PxqImNOSkcoHxHabyhBNtalZxEjMsxVU+D1YqMvcBxuX8Iq07H1+WDM95W0bhhgDeS0DgTQQyx2JB/qKZnMVpfOOC3A6zJVR59u8Hh9aJHQd8hQztFVnZ7TPHIa4uLMqH8gveXDYjJy24kVTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399792; c=relaxed/simple;
	bh=caqA0avrxy6pCPXQFoGDoN6deZ5R/Gph2QHjMY+rQVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2Q/IsXyA2gYofQ2pFQfnrfS14lZ6l1y4wef5srvM0IED69MtHImTVdYerY6ao1OS7ur1M8gQ4yKAdJQP25Ukv/jODVQGgeLkq1w5i1cE1tiFzHGtInfOPnI+UR/NO9BAfqQFlY1XYmbWwcM3uc3ZbnCA5TiLxgu3kratorDvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=QtB2CuQj; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="QtB2CuQj"
Received: by dvalin.narfation.org (Postfix) id 8C843200FB;
	Sat, 22 Aug 2026 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787399784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkrHjrxPJU2+2QsZs39qamgqA/1b0zrZYk1nxsr4q7w=;
	b=QtB2CuQjIFfssKD6hyWFZQdJmT6KlCW4CEalHrAn1uEZGRXGS917+dg5Lmxp1tjbKP09xo
	3S/T5m8mQKl0dyZiUXi9Woyt+g2aX+1tp4HlmuzwJ7k2C580dIBJ4SLjZcLOBd+K2PGB7X
	XhfrlWuZH+hoZMCEARq3f+N8g5JUcQ4=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, stable@kernel.org,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net 9/9] batman-adv: bla: fix freeing of claims on meshif deletion
Date: Sat, 22 Aug 2026 13:56:13 +0200
Message-ID: <2492208.NG923GbCHz@sven-desktop>
In-Reply-To: <20260821094813.201800-10-sw@simonwunderlich.de>
References:
 <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-10-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart893706146.0ifERbkFSE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart893706146.0ifERbkFSE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 13:56:13 +0200
Message-ID: <2492208.NG923GbCHz@sven-desktop>
In-Reply-To: <20260821094813.201800-10-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1=
=2Dsw%40simonwunderlich.de?part=3D9

[...]
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
>=20
> This isn't a regression introduced by this patch, but since the commit
> message names the missing rehashing as the reason for the change, is there
> a plan to address the underlying problem in
> batadv_bla_update_orig_address()?

See https://www.open-mesh.org/issues/452

[...]
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, gpt-5-6-sol, sashiko-ge=
mini =C2=B7 Confirmed by: gpt-5-6-sol
>=20
> Also pre-existing rather than caused by this patch: the 6 byte
> ether_addr_copy() into backbone_gw->orig is not a single atomic store, and
> batadv_bla_purge_claims() reads that same field under rcu_read_lock() and
> forwards the pointer straight into batadv_handle_unclaim():
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_purge_claims() {
> 	...
> 			batadv_handle_unclaim(bat_priv, primary_if,
> 					      backbone_gw->orig,
> 					      claim->addr, claim->vid);
> 	...
> }
>=20
> After this patch the batadv_compare_eth(backbone_addr,
> primary_if->net_dev->dev_addr) test is the only remaining decision in
> batadv_handle_unclaim(), because the claim is now removed unconditionally.
> Can a reader that observes a mix of the old and new MAC bytes here wrongly
> skip, or wrongly inject, the local UNCLAIM frame while the claim is delet=
ed
> either way?

Will definitely not change the patch because of this unrelated finding (whi=
ch=20
seems to be self-healing). Documented for Simon at=20
https://www.open-mesh.org/issues/469

Regards,
	Sven
--nextPart893706146.0ifERbkFSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaomOXQAKCRBND3cr0xT1
yww/AP92Z4vUW62S/ucm+Ddse7NTAyiBbQr06N84OSjUqSfsLwD/Y2BBFwxC1dzr
H2ONzWMF3P2rHHJaVidIgmjszrJlXgY=
=IEGh
-----END PGP SIGNATURE-----

--nextPart893706146.0ifERbkFSE--



