Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23969305E1F
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028632; cv=none; b=n7Jg1w2m+7xX271OzYbbitfAHCHodA1s9dqBcXM15+zjOdaJsqm/GifjZ/EN8yZKbsZ7Z9MtC9NlAZw8cE51e/A7F3IzOSJKoleOiSDCR9hI3fAZ4UEXlyVHkIkqqJpqQ7EEXp0oh6CbIHE5vj6SIjcAjTjTsuG1PAx3giY2COQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028632; c=relaxed/simple;
	bh=U4enaZJU0Ag8XW5KixXcrTMBFhbFm+Rro2UuEalKp6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chuk2IZQM6hMJWnF0ZHddzAN1Q2MOymRX4bse0JtgDRy2RxWLoIi9G3ibaffEHJkhKvOUAze8HZnIhjkMAk61bx6s5gxn4LNlSCNrFVF3L8NurkD97xp1Ve2vpjfM61UoRC4OYyWE3/3PqgD0UQiRmAxj2RRM+Sji5miJmvQHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=JO1cmrW9; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="JO1cmrW9"
Received: by dvalin.narfation.org (Postfix) id D64BF200D8;
	Thu, 06 Aug 2026 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786028625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JtwsqjhEg4/Ps2dJSppFH6CbIpUpKOfLmJgscIj5QtY=;
	b=JO1cmrW9A9AKSxP95YtIx7zZY1BW277EKJe7z+xcF1B1ir3EmHI9NGxCot4wt4XP44GtAH
	CMLSY1UL6lbzE9NQMOpXptAqclD/9n6BiFhcXT7lsS8TvC4HHZ5lTuF9ELcwAwNfldx7FZ
	09ywjbnKM+P1smQT5rUdh9O/IHN1A/Q=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@mandelbit.com>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 01/10] batman-adv: dat: drop non-4addr backwards
 compatibility
Date: Thu, 06 Aug 2026 17:03:41 +0200
Message-ID: <14211429.uLZWGnKmhe@sven-desktop>
In-Reply-To: <20260805143200.722098-2-sw@simonwunderlich.de>
References:
 <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-2-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3201252.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3201252.e9J7NaK4W3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 17:03:41 +0200
Message-ID: <14211429.uLZWGnKmhe@sven-desktop>
In-Reply-To: <20260805143200.722098-2-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D1

> --- Patch [1]: [PATCH net-next 01/10] batman-adv: dat: drop non-4addr bac=
kwards compatibility ---
[...]
> Discovered by: opus-5 =C2=B7 Missed by: old-prompts, sashiko-gemini =C2=
=B7 Confirmed by: old-prompts
> Was the removed else branch really only reachable when talking to
> pre-compat-15 nodes?

This is a misrepresentation of the commit. The code was added in batman-adv=
=20
with compat 14 when not all nodes had support for 4-addr packets.=20
With compat-15, all nodes must have support for 4addr packets and the=20
backwards compatibility hack is no longer needed

[...]
> After this change those cache replies go out as BATADV_UNICAST_4ADDR, and=
 on
> the receiver batadv_recv_unicast_packet() now takes the is4addr path:
>=20
> 			subtype =3D unicast_4addr_packet->subtype;
> 			batadv_dat_inc_counter(bat_priv, subtype);
>=20
> so BATADV_P_DAT_CACHE_REPLY RX accounting is incremented where it previou=
sly
> was not, and the encapsulation of these replies changes in packet capture=
s.

Yes, but what is wrong about the correct packets and correct accounting?

[...]=20
> Discovered by: opus-5 =C2=B7 Missed by: old-prompts, sashiko-gemini =C2=
=B7 Confirmed by: old-prompts
> This is a pre-existing issue and not introduced by this patch, but while
> looking at the DAT subtype decoding: the default arm of the inner switch =
in
> batadv_dbg_arp() prints the packet type where the message says subtype:
>=20
> 		switch (unicast_4addr_packet->subtype) {
> 		...
> 		default:
> 			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: Unknown (%u)!\n",
> 				   unicast_4addr_packet->u.packet_type);
> 		}
>=20
> That arm is only reachable from case BATADV_UNICAST_4ADDR: of the outer
> switch, so the value printed is always 0x42 rather than the unrecognized
> value from enum batadv_subtype in include/uapi/linux/batadv_packet.h.

Irrelevant for this patch but I've submitted a mini fix:
https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260806-4addr-u=
nknown-subtype-print-v1-1-e906357a5895@narfation.org/

Regards,
	Sven


--nextPart3201252.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanSiTQAKCRBND3cr0xT1
y6t8AQD84YyhEiTBB6riLKZaG7fUtJLbGi7SGzoDcxIdade7fAEA7pecsXc6V744
BCmzGIuj+MzY9/64yJz9Z9ZFKcXOZAs=
=DknP
-----END PGP SIGNATURE-----

--nextPart3201252.e9J7NaK4W3--



