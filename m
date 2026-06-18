Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A963E00A0
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777028; cv=none; b=FGMSMy7ggN3N7SL6i8MzfqTA9212wytQOkuZ+m2DrqspTsjuXNpz4J/jrL9tkQH1kyefqZHaeiw3uG+XmGaVz8ZfZ6/l3aAOSnrQmwawUE3EDWThFwY3OFPxp9LhNcIG92qOQDOCkQjhBkt8Pmemibnd4hcDVkIPB/kO/CrzTuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777028; c=relaxed/simple;
	bh=/YVueeeUe/gawX533OTdpdjxHchn1sPHZ4ENs6Yx2yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYPwhOLIOX6oU6urRAxdz6S+E9nC8b9CMrfiMnjbPSN/QwrBrOOb3moXpuQWBtdQpf80xaZ3KPmyZjjll0aOtNg0kq+zxMJoir2N4MycbG3GvwQGNjycL2WCS8tAX4tX8GP1+bmvfj/ZTZGwuGgyRMb3nHsLBM6J5qRt5E/9R7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcHZq7Xu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcHZq7Xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D581F000E9;
	Thu, 18 Jun 2026 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781777026;
	bh=Iom3D6FWo9fllJWbYMA89UYN58mi46iOwnkKnoRIuIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PcHZq7Xu9Xos5Y3JaTW2tn+d3FghRtNMdMfvmEfcLw8GZUqArX/N8qgIINhrHwH1K
	 41cxCdFC4XeJs6V8D1RiXf00+K1KtH1X327h+wwu8t8TzHRi2uUJ8hvoRAghdpvA+l
	 xMff8g0GJVhjEYOexJO3+AX3ceM3GlrlzITsVneMFECtu+mn1pEG/loVMxOZHCPj5A
	 ibMwbjroxJbNccIjlA/KYICTDI0h+fc4UbdUESm9t14QWbLUgoGGJjYdZgriu5Ulfv
	 qF2MA++Gdpv917gr9nBmsipqQrar0TB7IrOLhC4iTk5RkqPY88QKnXPDvqTMqG8c+Z
	 U0mSLnUtZhYyg==
Date: Thu, 18 Jun 2026 12:03:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wayen Yan <win847@gmail.com>, netdev@vger.kernel.org, horms@kernel.org,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v3] net: airoha: Fix skb->priority underflow in
 airoha_dev_select_queue()
Message-ID: <ajPCgH7E_ke6Fdur@lore-desk>
References: <178161373805.2167512.2544164327472822616@gmail.com>
 <20260617161951.52abe413@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y49npv9b6mmAWoJY"
Content-Disposition: inline
In-Reply-To: <20260617161951.52abe413@kernel.org>


--y49npv9b6mmAWoJY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 14 Jun 2026 07:30:54 +0800 Wayen Yan wrote:
> > In airoha_dev_select_queue(), the expression:
> >=20
> >   queue =3D (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;
> >=20
> > implicitly converts to unsigned arithmetic: when skb->priority is 0
> > (the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
> > and UINT_MAX % 8 =3D 7, routing default best-effort packets to the
> > highest-priority QoS queue. This causes QoS inversion where the
> > majority of traffic on a PON gateway starves actual high-priority
> > flows (VoIP, gaming, etc.).
> >=20
> > Fix by guarding the subtraction: when priority is 0, map to queue 0
> > (lowest priority), otherwise apply the original (priority - 1) % 8
> > mapping.
> >=20
> > Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Reviewed-by: Joe Damato <joe@dama.to>
> > Signed-off-by: Wayen Yan <win847@gmail.com>
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 31cdb11cd7..d476ef83c3 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -1933,7 +1933,7 @@ static u16 airoha_dev_select_queue(struct net_dev=
ice *dev, struct sk_buff *skb,
> >  	 */
> >  	channel =3D netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port-=
>id;
> >  	channel =3D channel % AIROHA_NUM_QOS_CHANNELS;
> > -	queue =3D (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
> > +	queue =3D skb->priority ? (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES=
 : 0;
>=20
> Hi Lorenzo, is there a reason we're subtracting 1 here in the first
> place? Could be just me, but may be worth adding a comment here.
>=20
> Intuitively if we are "narrowing" 16 prios to 8 queues it'd make most
> sense to group the adjacent ones -- divide by two.
>=20
> Please respin with some sort of an explanation..

IIRC this is a leftover of the ETS offload support.
I agree it is righ to just do:

	queue =3D skb->priority % AIROHA_NUM_QOS_QUEUES; /* QoS queue */

@Wayen: can you please respin fixing the issue? Please add even my Acked-by:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Regards,
Lorenzo

>=20
> >  	queue =3D channel * AIROHA_NUM_QOS_QUEUES + queue;
> > =20
> >  	return queue < dev->num_tx_queues ? queue : 0;
> --=20
> pw-bot: cr

--y49npv9b6mmAWoJY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajPCgAAKCRA6cBh0uS2t
rEPCAQCqDCrcwKyucjgOFBgvz0L4RGD7O8nbPLHaiOpvjvOwjAD9GhOOU9yIs2ZA
nE8h3U0jkTu24u7OOiE+sJeJpIjNIg8=
=8RTw
-----END PGP SIGNATURE-----

--y49npv9b6mmAWoJY--
