Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222264582DE;
	Fri, 31 Jul 2026 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524736; cv=none; b=QWho5dEiyjyEBOro8cgGqanlXwZXAzK5UOsRYt4SqePQwZFau4d/pNAWzbr976lD40P5u+p8BSnfh88X4QCyhQKYd7CLZS+Ki052Ob9Ba69Ze/BTeODRsNsVscdpKD1d7oy14PkwsHsgJpNYEx3cgJwQBfXbAMTmU3MECqhc7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524736; c=relaxed/simple;
	bh=Ny2yTuX01F4NKzf5GLq9Qz3MWfpApebxl9ztTvdn+Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gj70fxqNx0zAxe7R5paGgT5EHZeRz9ieIhg+WWRSZvLltG8Vw3h+seg0dsQVZP6SwMrOY5MjS9Vxl9QunwSXs1pQ8VupdPZjICEqmsGnkwe9/K7sTajmZbebZctasbf6SrYFVcUcegwo20yv54/knuWmj5Xtccdth0MTXSSh+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=q/W4w3zD; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="q/W4w3zD"
Received: by dvalin.narfation.org (Postfix) id A141A20268;
	Fri, 31 Jul 2026 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785524728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8es6j2T4uWDHkN9zn7twbC0XdaR/06DY9gMYm9pk8LQ=;
	b=q/W4w3zDpVkKCeXSPREu4f1Jgx4+yneXOmba9fT9f2MlyDqFREKVgsS7lbNZHvWdBF8Ouh
	SNr7euBXcM4yvROD8O34Wb/IHNV03VDCQff/WY/AzvH3WN6Bv0/k6fVDHGplEUeROvnKEF
	zwetPyUi+BcprZJl1gPKf0c4/c6RKdk=
From: Sven Eckelmann <sven@narfation.org>
To: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com
Cc: David Lee <david.lee@trailofbits.com>, Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH] batman-adv: reject unrepresentable multicast TVLV offsets
Date: Fri, 31 Jul 2026 21:05:22 +0200
Message-ID: <4820667.LvFx2qVVIh@sven-desktop>
In-Reply-To: <178551276854.62695.15966621050711216654.b4-review@b4>
References:
 <20260731135222.566367-1-david.lee@trailofbits.com>
 <178551276854.62695.15966621050711216654.b4-review@b4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2488068.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2488068.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Jul 2026 21:05:22 +0200
Message-ID: <4820667.LvFx2qVVIh@sven-desktop>
In-Reply-To: <178551276854.62695.15966621050711216654.b4-review@b4>
MIME-Version: 1.0

On Friday, 31 July 2026 17:46:08 CEST Sven Eckelmann wrote:
> >
> >
> > diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
> > index 5600aaf00627c..8354c62bd86a7 100644
> > --- a/net/batman-adv/tvlv.c
> > +++ b/net/batman-adv/tvlv.c
> > @@ -437,6 +437,9 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
> >                        return NET_RX_SUCCESS;
> >  
> >                tvlv_offset = (unsigned char *)tvlv_value - skb->data;
> > +              if (skb_headroom(skb) + tvlv_offset + tvlv_value_len >= U16_MAX)
> > +                      return -EINVAL;
> > +
> 
> Just for documentation purposes:
> 
> This is (skb->data - skb->head) + tvlv_offset + tvlv_value_len
> 
> The calculation in skb_set_transport_header():
> 
> offset = skb->data - skb->head
> offset += (tvlv_offset + tvlv_value_len)
> 
> >                skb_set_network_header(skb, tvlv_offset);
> >                skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
> >  

I've checked a little bit further and it might not be the preferred solution. 
Please check Eric Dumazet's
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=d45cf1e7d7180256e17c9ce88e32e8061a7887fe 
for a similar problem in IPv6. It is basically the same but without the 
additional offset parameter which skb_set_transport_header_careful would need.

Regards,
	Sven
--nextPart2488068.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCamzx8gAKCRBND3cr0xT1
y8qbAQCAJpC+N8gtVp1zcu3oovIeDC71peKFSUsrUOGbgZZ34QD+NI1obkaTjFbq
liSohRms8Aq8bavyjqWupQ04BcSR4Ac=
=dZpi
-----END PGP SIGNATURE-----

--nextPart2488068.ElGaqSPkdT--



