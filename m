Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D343B48C
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030585; cv=none; b=Fi6Kxc3ncidpJHbrgUmJcS+9zpAwOP0YCgz4gKM5uN9Fj6AnIUEsFfzl6JAv7/bQ02UfhFJAIsQRgBpN1YsV7rZjUOs3qHI8fq+qwHoK52M/yJ/ra8G+EOuiyevF3Ej/baYAZwfyWr7zVQnz8LZkXlRR8LN5SMhf7iXUf8rhGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030585; c=relaxed/simple;
	bh=d1lDI58yoVBFvQO1zG3mJiIg8DGTThPnJb8tOB0IkTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRx23VwFhACOjkrVborzBDZF1O9bzOifA7DxVznAAfaAxI2F4jGN057G1/dKeAz/D9341PhEhGhzyB6BkNzIuB3xGui8hDNHQiF7ApmpR20/jFqO9eEkFfoJn+j5ocB55q05muJqA8iVfof3NW1fdsaXl/+ifXrfi/DW7+4RW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=cbpu+kEn; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="cbpu+kEn"
Received: by dvalin.narfation.org (Postfix) id 3CFA420E0D;
	Thu, 06 Aug 2026 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786030578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxOqj046lOlY9vx8KGzYwQr5rgbueGKyjX7Y1DhoNNw=;
	b=cbpu+kEnQLOBOc0wQldpcDVwcgqH1fXjrfN9MiZWfNXvQm3cC5e9xRckSzVaA8jEv76HvH
	IFuBA+zRenAHYPH/+TLN9gqC7chYFg0f7jtr8+R3SpUD3fzZmE7qyQ1jlVZ0F7hdtimyq0
	J5rD0lqV6phxMROhLeDw4E2+6PJrVdU=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 02/10] batman-adv: tvlv: handle negative tvlv processing
 return codes
Date: Thu, 06 Aug 2026 17:36:12 +0200
Message-ID: <13100789.O9o76ZdvQC@sven-desktop>
In-Reply-To: <20260805143200.722098-3-sw@simonwunderlich.de>
References:
 <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-3-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6172109.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6172109.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 17:36:12 +0200
Message-ID: <13100789.O9o76ZdvQC@sven-desktop>
In-Reply-To: <20260805143200.722098-3-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D2

> --- Patch [2]: [PATCH net-next 02/10] batman-adv: tvlv: handle negative t=
vlv=20
processing return codes ---
[...]
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Does batadv_recv_mcast_packet() really match the new "NET_RX_SUCCESS if t=
he
> skb was locally received" wording?
>=20
> In net/batman-adv/routing.c, ret is assigned exactly once, from
> batadv_tvlv_containers_process(), and the local delivery is gated by an
> additional length test:
>=20
> 	ret =3D batadv_tvlv_containers_process(bat_priv, BATADV_MCAST, NULL,=20
skb,
> 					     tvlv_buff,=20
tvlv_buff_len);
> 	...
> 	hdr_size +=3D tvlv_buff_len;
>=20
> 	if (ret =3D=3D NET_RX_SUCCESS && (skb->len - hdr_size >=3D ETH_HLEN)) {
> 		...
> 		batadv_interface_rx(bat_priv->mesh_iface, skb, hdr_size,=20
NULL);
> 		/* skb was consumed */
> 		skb =3D NULL;
> 	}
>=20
> free_skb:
> 	kfree_skb(skb);
>=20
> 	return ret;

Yes, there are additional checks down the path. But it was still considered=
 in=20
the parsing of the TVLV as code which should be received locally. I am not =
a=20
person which writes documentation all day and I have no idea how to convey =
all=20
the details without repeating basically the whole code. At some point, we h=
ave=20
to use something which is just good enough or somebody has to be found whic=
h=20
is better than me in writing of documentation.

I will not submit any patch for this.

[..]
> Since the stated goal here is to make these return values reliable for
> future callers, should the wording be something like "NET_RX_SUCCESS if t=
he
> skb was processed successfully"

No, this is not what is the (unfortunate) meaning of NET_RX_SUCCESS and=20
NET_RX_DROP here.

Regards,
	Sven
--nextPart6172109.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanSp7AAKCRBND3cr0xT1
y+3cAP9Bgos/68o4rtE36Mp1RREe0rZHjuc9O9x2dvk1ChHLRAEAi8ofm3b8zmuj
wFad719lpRvDouBXIwMqgQDf4xtGuAQ=
=4etA
-----END PGP SIGNATURE-----

--nextPart6172109.DvuYhMxLoT--



