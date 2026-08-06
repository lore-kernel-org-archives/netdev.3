Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA191485CCA
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033581; cv=none; b=uRCcYf//h1v8I/aae9FBJM+1+t15vk19VaBf7ji2uT2SUz3pA3xJ1UncYhd/rSI1GQ7sdte1jLTb8BsHUJcH4faIYqD+Umx6MYxK2qlTqWLytNW+PldYjNEd+St3jr++5uz/yvH7JEj7ys6It4d/hGHLXrIvpFBAA2dDNRaGRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033581; c=relaxed/simple;
	bh=3B1/gl1WnYqOyJrtllf4c6KbqTOe8zJQUfIk5b8s6Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4w2bKeT/4hX9DRCymupMhOtpuI8jsCpWdsOBAJOnmtv9Npjb//EEXtldFtwPU0fgwjhxN8x2wB+7X2EejLlaEGDg39jBJ8QcP19Y6d9ZlURLQAhK9V8g6ivvvZ6ibyPKPXhl5koviCduA70Y7yXp7/2o4j7bQbrHDCVsrsWkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=1TzcCNwe; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="1TzcCNwe"
Received: by dvalin.narfation.org (Postfix) id 66A5120590;
	Thu, 06 Aug 2026 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786033573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4H2yC6PQ2JDPAI14NORM1ZMyLk4eXcA18IFYJSe5x4=;
	b=1TzcCNweAvClvrGEez+sywN2Dj2fVj889fNaWTYIRPuLPNf9gXft8Pjv6+fpVCWzNVm/17
	o7O6qYcE1508LadKDLrGypBccePFntkyoWXm4MYBx8uYBqO/CVReDaDofdnUhbvqgUuWpT
	mJzfQ/EUxX7GDq0XK8BGQdo0VTmz5CE=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 10/10] batman-adv: remove negative returns for
 batadv_send_skb_unicast
Date: Thu, 06 Aug 2026 18:26:07 +0200
Message-ID: <3216364.e9J7NaK4W3@sven-desktop>
In-Reply-To: <20260805143200.722098-11-sw@simonwunderlich.de>
References:
 <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-11-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3584836.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3584836.aeNJFYEL58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 18:26:07 +0200
Message-ID: <3216364.e9J7NaK4W3@sven-desktop>
In-Reply-To: <20260805143200.722098-11-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D10

> --- Patch [10]: [PATCH net-next 10/10] batman-adv: remove negative return=
s for batadv_send_skb_unicast ---
[...]
> > @@ -360,7 +361,10 @@ int batadv_send_skb_unicast(struct batadv_priv *ba=
t_priv,
> >  	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest, vid))
> >  		unicast_packet->ttvn =3D unicast_packet->ttvn - 1;
> > =20
> > -	ret =3D batadv_send_skb_to_orig(skb, orig_node, NULL);
> > +	res =3D batadv_send_skb_to_orig(skb, orig_node, NULL);
> > +	if (res =3D=3D NET_XMIT_SUCCESS)
> > +		ret =3D NET_XMIT_SUCCESS;
> > +
>=20
> Discovered by: opus-5, old-prompts =C2=B7 Missed by: sashiko-gemini
> Does this change more than the counter in
> batadv_dat_snoop_incoming_arp_request()?
>=20
> In distributed-arp-table.c the same condition that bumps the counter also
> sets the boolean return value:
>=20
> 	err =3D batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
> 					   BATADV_P_DAT_CACHE_REPLY,
> 					   NULL, vid);
> 	if (err !=3D NET_XMIT_DROP) {
> 		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
> 		ret =3D true;
> 	}
> out:
> 	batadv_dat_entry_put(dat_entry);
> 	if (ret)
> 		kfree_skb(skb);
> 	return ret;

[...]
> Could the changelog also mention that the packet disposition changes, i.e.
> that the snooped ARP request is now delivered locally instead of being
> dropped when the cached reply cannot be sent?

=46air enough, but not sure if it is worth sending the PR again to document=
 that=20
this is the correct behavior too.

Regards,
	Sven
--nextPart3584836.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanS1nwAKCRBND3cr0xT1
y7CvAQDMBvgESXFOmJfS2TUbdom9xSRdSCv5fy8cxYRiXvFVlwEAvSAvBEy1uAlu
+cteZTtC4bu4dF5Hsa+aXx3bkZnHHwc=
=0ajW
-----END PGP SIGNATURE-----

--nextPart3584836.aeNJFYEL58--



