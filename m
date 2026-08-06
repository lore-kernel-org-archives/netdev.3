Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11CE481FCF
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032805; cv=none; b=HYpB7CpVRJjUSMH2dwrseK/DJBZOjWaXIpXBoZdlzfSY9JQDqfBTblQyxjw1s4sgN24T5kcis2SGuBGuQfFwr9K9etUtu/85Dy1V/49OiWwj+QL4Ao1xn12RKi9aoEVOPy6RHVKPnitivQ971l9hqmBPad4wi5R0gWuz0EvIZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032805; c=relaxed/simple;
	bh=GncdFdXrJIhAgpTC6brrBR4dJW92SyoZwymrV1TZRqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjlW4tHVAeqnz+JZpNZfRy3d2ZSCn2esurW/poCbxaJU/qQk7qC9J+aIbmdPu3HEJEx+rx+ziSM0WakqBbKhgeQkjd0D3lTxRvdVAylxab/6FsluwnFx8rFnwzaBHewy5f42tey5bAIUdZYU2NTBmwhv4s1L7m7nOhUvD26/h5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=M4PABhAw; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="M4PABhAw"
Received: by dvalin.narfation.org (Postfix) id 5BA3E21002;
	Thu, 06 Aug 2026 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786032797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FDnJjr6u5CI2FNAIvthxuWqMU0c59QUxaGduLMRi80k=;
	b=M4PABhAwzeME3pAJ//y1LUuDSUdp8sDpbtiOoQoMiu+BsfFAqKKRw/EVx2sFGUS3D/zJUT
	1Hgon80Q76fVkSS6owsAw+COavPvA8VI8YUWmxXmsF6xTKFG+CDZ4Bde7nAd79utOl6ANm
	C/JDDLiKus3P3iZ+CeidHY71gaQxTaU=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject:
 Re: [PATCH net-next 05/10] batman-adv: annotate functions which may
 reallocate the skbuff
Date: Thu, 06 Aug 2026 18:13:14 +0200
Message-ID: <5280888.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260805143200.722098-6-sw@simonwunderlich.de>
References:
 <20260805143200.722098-1-sw@simonwunderlich.de>
 <20260805143200.722098-6-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4913403.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4913403.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Aug 2026 18:13:14 +0200
Message-ID: <5280888.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260805143200.722098-6-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805143200.722098-1=
=2Dsw%40simonwunderlich.de?part=3D5

> --- Patch [5]: [PATCH net-next 05/10] batman-adv: annotate functions whic=
h may reallocate the skbuff ---
[...]
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug, but the ellipsis in the batadv_dat_snoop_outgoing_arp_r=
equest()
> annotation has an extra dot ("batadv_dat_get_vid()/....") compared to the
> "/..." spelling used in the other hunks of this patch.

=46eel free to use the extra dot for whatever you want. Will not resend the=
 PR=20
or create a patch because of this.

>=20
> > + * from skb->data or eth_hdr()) before this call must be considered
> > + * invalid afterwards and has to be reacquired.
> > + *
> >   * Return: true if the message has been sent to the dht candidates, fa=
lse
> >   * otherwise. In case of a positive return value the message has to be=
 enqueued
> >   * to permit the fallback.
> > @@ -1271,6 +1286,11 @@ bool batadv_dat_snoop_outgoing_arp_request(struc=
t batadv_priv *bat_priv,
> >   * @skb: packet to check
> >   * @hdr_size: size of the encapsulation header
> >   *
> > + * Warning: This function may reallocate the skb data buffer via
> > + * batadv_dat_get_vid()/... Any pointer into the skb data (e.g. obtain=
ed
> > + * from skb->data or eth_hdr()) before this call must be considered
> > + * invalid afterwards and has to be reacquired.
> > + *
> >   * Return: true if the request has been answered, false otherwise.
> >   */
> >  bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_pri=
v,
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Is the advice to reacquire the pointers correct for the true return path =
of
> batadv_dat_snoop_incoming_arp_request()?  On that path the skb is not just
> reallocated, it is released:
>=20
> net/batman-adv/distributed-arp-table.c:batadv_dat_snoop_incoming_arp_requ=
est() {
> 	...
> out:
> 	batadv_dat_entry_put(dat_entry);
> 	if (ret)
> 		kfree_skb(skb);
> 	return ret;
> }

This is outside the scope of this patch. The WARNING is of course only vali=
d=20
when there is still an skb to use.

> [ ... ]
>=20
> > @@ -1788,6 +1818,11 @@ void batadv_dat_snoop_outgoing_dhcp_ack(struct b=
atadv_priv *bat_priv,
> >   * This function first checks whether the given skb is a valid DHCPACK=
=2E If
> >   * so then its source MAC and IP as well as its DHCP Client Hardware A=
ddress
> >   * field and DHCP Your IP Address field are added to the local DAT cac=
he.
> > + *
> > + * Warning: This function may reallocate the skb data buffer via
> > + * pskb_may_pull()/batadv_dat_get_vid()/... Any pointer into the skb d=
ata
> > + * (e.g.obtained from skb->data or eth_hdr()) before this call must be
>        ^^^^^^^^^^
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Missing space after "e.g." in the batadv_dat_snoop_incoming_dhcp_ack()
> annotation.

Will not resend the PR because of this.

> [ ... ]
>=20
> > diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast=
_forw.c
> > index 1404a3b7adfb1..60ec12805742c 100644
> > --- a/net/batman-adv/multicast_forw.c
> > +++ b/net/batman-adv/multicast_forw.c
> > @@ -1080,6 +1080,11 @@ unsigned int batadv_mcast_forw_packet_hdrlen(uns=
igned int num_dests)
> >   * Tries to expand an skb's headroom so that its head to tail is 1298
> >   * bytes (minimum IPv6 MTU + vlan ethernet header size) large.
> >   *
> > + * Warning: This function may reallocate the skb data buffer via
> > + * skb_cow()/skb_linearize()/... Any pointer into the skb data (e.g.
> > + * obtained from skb->data or eth_hdr()) before this call must be
> > + * considered invalid afterwards and has to be reacquired.
> > + *
>=20
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Are skb_cow() and skb_linearize() the right helpers to name here?
> batadv_mcast_forw_expand_head() calls neither of them; the only
> reallocating primitive in its body is pskb_expand_head():
>=20
> net/batman-adv/multicast_forw.c:batadv_mcast_forw_expand_head() {
> 	...
> 	if (skb_headroom(skb) < hdr_size &&
> 	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
> 		return -ENOMEM;
>=20
> 	return 0;
> }

The relevant changes were lost when the fixes were removed from the PR. Wil=
l=20
not resend the PR without this line. The statement will be true when the fi=
xes=20
are added.

Regards,
	Sven
--nextPart4913403.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanSymgAKCRBND3cr0xT1
y5M4AQDtiv3xZfVq1t+gGMqETnnfR6iXthq5uJa6Vyuc4LVhvwEA6sCgsuW12hU/
ssXA+bh+FDQterPz9a3EhE/ADtaFQgk=
=H7jn
-----END PGP SIGNATURE-----

--nextPart4913403.LvFx2qVVIh--



