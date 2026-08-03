Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269F277035;
	Mon,  3 Aug 2026 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721710; cv=none; b=oQ1jrfVerDGBUd34Gp8/ezimfOdiNRgFrlLOEC7138zsvkGUkztfUCT7EnKMzcoFeawSXrddOuKy8AI41kpY72lguGsCvtpoegunuQ5vU0afF4UFEeS3ai7xcZ3zoE9d/M8HasclfUfghTxy+KgXs3/2v91U49Amccc+9sW/7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721710; c=relaxed/simple;
	bh=0D60OAFZS0pHsEF3mRUjGQUfRFQesoh4XoWWFbp+njU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4YOC88js8g2++KtRmNIHgHwWWRc8EXNPYvv+fTdta+K0rfcNYZXwOlBxP6mVdJlBbMDzCtQ+DCpzcSOG+pdsfwbTDjD1X5N1+DlUoXdQQB9HaWq/BtLAMvlFiERYkujE3kUqzxtdkTG8isnnaTewhTTI+7VGxQDfdxuN82ps/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JXZkcoYh; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JXZkcoYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785721204;
	bh=oE7uPS84rSpgE0ni9IOO8HgaNujh320gvuSNqcIFKN0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JXZkcoYhdP4wQ8rk0b7KSvcLBNnm9iL3BDXs5bb/g/C/7jo069HuDO3gLd0euy8Mf
	 Rd6WHdFXuoj5bJNnqzdwMO9PZdnzAHwGGf7gH/0g1KqkGdaHwsYHck5ui2BDRsgrYW
	 HeYusjq2HspMnZ77704SLvYG6G5EiPmSrqjGXrTIA8uDCB3jYfavdx1QjLBx9m/B0/
	 NeNdSJ7uv3nGfsRVwOrFCg1awpI+3bhec5Jd/AeLisCpJ5tyOQP+fNVen6BTEDAySB
	 t7pqb9HAGJ2974YwhSTVZd3KZ+gSX/fgVlMsv9G+Kay0yEJkxtbe2n5SPJygtyBIdH
	 RHdkqKyUs9zSQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 27CC6655A9;
	Mon,  3 Aug 2026 09:40:03 +0800 (AWST)
Message-ID: <4f46ee4a8a0c389ca03dfab5d90cf53eb24a0cdb.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: hold route device before source address
 lookup
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Yiqi Sun <sunyiqixm@gmail.com>, matt@codeconstruct.com.au
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 	horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 03 Aug 2026 09:40:02 +0800
In-Reply-To: <20260731022926.913865-1-sunyiqixm@gmail.com>
References: <20260731022926.913865-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Yiqi Sun,

> mctp_route_lookup() walks the route table under RCU and may find a direct
> route whose route-table reference to rt->dev is being removed concurrentl=
y
> by NETDEV_UNREGISTER.
>=20
> Since commit 22cb45afd221 ("net: mctp: perform source address lookups
> when we populate our dst"), the direct-route lookup path reads the source
> address with mctp_dev_saddr(rt->dev) before mctp_dst_from_route() takes t=
he
> dst's own mctp_dev reference. If device teardown wins that race,
> mctp_route_remove_dev() can delete the route and mctp_route_release() can
> drop the route's mctp_dev reference to zero. mctp_dev_put() frees
> mdev->addrs synchronously, while only the mctp_dev body is deferred with
> kfree_rcu().
>=20
> That leaves the lookup side able to read freed mdev->addrs in
> mctp_dev_saddr(), or later increment a zero refcount in mctp_dev_hold().
>=20
> Add a try-hold helper for mctp_dev and use it before reading the source
> address from a direct route. mctp_dst_from_route() now consumes that held
> reference when it populates dst. If no dst is requested, drop the tempora=
ry
> reference in mctp_route_lookup(). Do the same when the route cannot be us=
ed
> for a gateway path without a source address.

Good find, thank you. Just a couple of comments on the fix though:

> index 1f3dccbb7aed..3d0737030917 100644
> --- a/net/mctp/route.c
> +++ b/net/mctp/route.c
> @@ -897,15 +897,16 @@ static mctp_eid_t mctp_dev_saddr(struct mctp_dev *d=
ev)
> =C2=A0	return addr;
> =C2=A0}
> =C2=A0
> -/* must only be called on a direct route, as the final output hop */
> +/* must only be called on a direct route, as the final output hop, with =
a
> + * reference already held on route->dev.
> + */
> =C2=A0static void mctp_dst_from_route(struct mctp_dst *dst, mctp_eid_t ei=
d,
> =C2=A0				mctp_eid_t saddr, unsigned int mtu,
> -				struct mctp_route *route)
> +				struct mctp_route *route, struct mctp_dev *dev)
> =C2=A0{
> -	mctp_dev_hold(route->dev);
> =C2=A0	dst->nexthop =3D eid;
> -	dst->dev =3D route->dev;
> -	dst->mtu =3D READ_ONCE(dst->dev->dev->mtu);
> +	dst->dev =3D dev;
> +	dst->mtu =3D READ_ONCE(dev->dev->mtu);
> =C2=A0	if (mtu)
> =C2=A0		dst->mtu =3D min(dst->mtu, mtu);
> =C2=A0	dst->halen =3D 0;

I don't see the need to pass the dev argument separately here, it's
duplicating route->dev; all we need is to drop the mctp_dev_hold(), and
update the comment, as you have done.

> @@ -998,14 +999,25 @@ int mctp_route_lookup(struct net *net, unsigned int=
 dnet,
> =C2=A0			mtu =3D mtu ?: rt->mtu;
> =C2=A0
> =C2=A0		if (rt->dst_type =3D=3D MCTP_ROUTE_DIRECT) {
> -			mctp_eid_t saddr =3D mctp_dev_saddr(rt->dev);
> +			struct mctp_dev *dev =3D rt->dev;
> +			mctp_eid_t saddr;
> +
> +			if (!mctp_dev_try_hold(dev))
> +				break;

I would also be fine with using refcount_inc_not_zero() directly, but
adding the helper is good too.

> +
> +			saddr =3D mctp_dev_saddr(dev);
> =C2=A0
> =C2=A0			/* cannot do gateway-ed routes without a src=C2=A0 */
> -			if (saddr =3D=3D MCTP_ADDR_NULL && depth !=3D 0)
> +			if (saddr =3D=3D MCTP_ADDR_NULL && depth !=3D 0) {
> +				mctp_dev_put(dev);
> =C2=A0				break;
> +			}
> =C2=A0
> =C2=A0			if (dst)
> -				mctp_dst_from_route(dst, daddr, saddr, mtu, rt);
> +				mctp_dst_from_route(dst, daddr, saddr, mtu, rt,
> +						=C2=A0=C2=A0=C2=A0 dev);
> +			else
> +				mctp_dev_put(dev);
> =C2=A0			rc =3D 0;
> =C2=A0			break;

If you end up doing a v2, don't forget the `[PATH net]` subject prefix,
to indicate the net (vs. net-next) tree.

Cheers,


Jeremy
