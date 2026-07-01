Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9183DA5B4
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893836; cv=none; b=UN8T6m6x5CTeq1vY7e/7vmzmHkY1N7MW6/4zbj6XqSakBerXX53ME3T6sJdPhfXlkfrvT/SlndLB2q/uLA9wH45kyuVlItKWT9zWSL8V0pzgPf6SWm/jU+Cxt2ll3SGm6WfeG41m7rI0GNTJ+hQMIWwQCFl4CEu8qBU/F1+h65c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893836; c=relaxed/simple;
	bh=GySAsycjR63k/GB/dXo/5+vZFq/ViuFH0zAfHNV0uew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxWHRC2VNbataZbMbtOEPvyUx/YrkJPRmJ6yzT7FgF9k/mCnH1cxL6tT/sVPQRSkFnFTvrtD5uFbY8bhljJQMSGiMgQfVz/aS6jTvhr9kRpNZAl223jvAS2VZaBdFX1hrcjHUT4Gy4WRGrJcfrUON1ooQELQvNo3WLDzT+XVp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw0lptYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw0lptYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402471F000E9;
	Wed,  1 Jul 2026 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782893834;
	bh=RzhTxuFodxvEXlgXrBHukVCoVwruBpsa+xssP0mR+Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dw0lptYbaymT83k7d6A2o9THRx8vOcVUZMedngV5ZBgB6hXqXgi0dlOtOVQ2En6fM
	 /ojOVfYxaSetsJ6ST6Jkfko9F+CP6rAJlt3RWF5wLxXmgR/ffhl+AfZZBGP7xnxF6G
	 RsHkltw/zSDh/r+CBEE1fjlgvZ7qxvWvWt0Tk1M4cvyk7Z/IUe4l54pgCviV6NNkUn
	 +4t/0PuA05zVhB7CGAAxAMhEG8Oe9FYwcGjaf0akxsVCrcZQ4D2dKIDKDZ4YTFavOY
	 UrI0MjqX5KguwfXhh7nL5DMIzmwXlQ2KSks8bbPHoy7tv5rCpF6Nf1pf2ncQjiErE3
	 ktiNG5PG3RRRA==
Date: Wed, 1 Jul 2026 10:17:12 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: zhulei <zhulei_szu@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND net-next] net: airoha: Make use of the helper
 function dev_err_probe()
Message-ID: <akTNCEOPowBDhyIo@lore-desk>
References: <20260630015247.43322-1-zhulei_szu@163.com>
 <akOcrmDpfzNUTR2n@lore-desk>
 <23f58025.6d6d.19f1cb25385.Coremail.zhulei_szu@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ioK5U5naEOjL0ygd"
Content-Disposition: inline
In-Reply-To: <23f58025.6d6d.19f1cb25385.Coremail.zhulei_szu@163.com>


--ioK5U5naEOjL0ygd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> At 2026-06-30 18:38:38, "Lorenzo Bianconi" <lorenzo@kernel.org> wrote:
> >> From: Lei Zhu <zhulei@kylinos.cn>
> >>=20
> >> Use dev_err_probe() to reduce code size and simplify the code.
> >>=20
> >> Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
> >> ---
> >> The last submission was when net-next is closed.Resending it.
> >>=20
> >>  drivers/net/ethernet/airoha/airoha_eth.c | 21 +++++++++------------
> >>  1 file changed, 9 insertions(+), 12 deletions(-)
> >>=20
> >> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/et=
hernet/airoha/airoha_eth.c
> >> index 31cdb11cd78d..189f64e83a46 100644
> >> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> >> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> >> @@ -3071,10 +3071,9 @@ static int airoha_probe(struct platform_device =
*pdev)
> >>  	eth->dev =3D &pdev->dev;
> >> =20
> >>  	err =3D dma_set_mask_and_coherent(eth->dev, DMA_BIT_MASK(32));
> >
> >I do not think dma_set_mask_and_coherent() can return -EPROBE_DEFER, so =
there
> >is no point adding dev_err_probe() here.
> >
> >Regards,
> >Lorenzo
> >
> Hi Lorenzo,
>=20
> Thanks for your review.
>=20
> Before making this patch, I referred to the comments of dev_err_probe:
> "even if @err is known to never be -EPROBE_DEFER, the benefit compared
> to a normal dev_err() is the standardized format of the error code."
>=20
> In the probe function, I noticed devm_platform_ioremap_resource_byname
> already uses dev_err_probe, while other functions still use dev_err.
> Replace them with dev_err_probe for consistency, more compact error paths,
> and better readability of error codes.
>=20
> Best regards
> Lei
>=20

I do not have a strong opinion about it, from my pov it is more clear if we=
 use
dev_err_probe() when it really does something, but up to you.

Regards,
Lorenzo

--ioK5U5naEOjL0ygd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakTNCAAKCRA6cBh0uS2t
rM9SAPwKULDPG7Eldix1Rkos0teGj6oOj3nbv2vYEHznfyoV6gD/cYx5XEIM64Rj
6H/wLsoACkApxD86chmnbSbAN5+d4Aw=
=dVgt
-----END PGP SIGNATURE-----

--ioK5U5naEOjL0ygd--
