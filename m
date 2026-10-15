Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582252F27F;
	Thu, 15 Oct 2026 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073945; cv=none; b=BsKqVciDV6Les3ng89047469ALi3sZEb2EVmrnLN1vKg5PdcQepgBcGGz1uXZEIarBDq0vX+ume6zSGTA7+zp8iHvANl2rSop4Dh/rASOOuvvE2e8KHE5zvEFH8fXw579oDx9OX1pu04M+lqm1RM09Ubaj5gc/O5MZaQEfOk0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073945; c=relaxed/simple;
	bh=t/8aSVlAGQ560xeeaccXGG8QWrLWFsQnsWSaDbTyVP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4kCFw/+XC1ssNIdRgKR2CnYJeR4j4Hwi+Cq+eSEUdlYJXLlep/bmb3xsNawrSpXcj/DeuXk+9vG+YaPbUB6+ok0Nbi3lRfaXYeyAPtuMJ5Sr7XK4U43MTn9HL4tWX/mhq/qNksUfOJuNqZF3ch1Gr84ctDQ3mdgNn3en5Y1XZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofmvxIX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofmvxIX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821511F000C5;
	Thu, 15 Oct 2026 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792073944;
	bh=CeSzBwDNP1bLe2YHsb8NqKTNfjCsvy23Eg0OzCMcErs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ofmvxIX5sFpS2nZjQ3emTsjKbeA08Ybf3LomWAMA3CsTaar+cmLX3XueVahpMtYcH
	 WMCw/oQF7fS1Sb0U4FyUO+HAhNdMddq8U8mAjH0avlpGkBb56o+0JoxcDwfPw9Hi8w
	 /z9I2IrSb9hYzftzMkXcGbx9rqa+RV2p5NQDVFs+KbO5xA/KcNOVIUwVkGrs1nl+qb
	 nwQl79/n9lPdozVJSpDHav3zP9i+CydbsJDi43lhAwIxWVS5kQy/j91BdLtkG67epg
	 35MlKf91qFXiOfPqcUYVfkSGcK3lcwdmORnho8mZtZtcZzbSmrDd5/HZ7RhIRexmwd
	 qREot1TN3cJHQ==
Date: Thu, 15 Oct 2026 16:19:01 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	"open list:MEDIATEK ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: Fix dma_unmap_single()
 size
Message-ID: <atDg1UFw9CJpvsxF@lore-desk>
References: <20261015140110.41988-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bf2LvNtCjkzeEFGh"
Content-Disposition: inline
In-Reply-To: <20261015140110.41988-2-fourier.thomas@gmail.com>

--bf2LvNtCjkzeEFGh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In mtk_wed_wo_queue_refill(), the entry->buf is DMA mapped with length
> q->buf_size which saved in entry->len. However, in mtk_wed_wo_dequeue(),
> the same buffer is DMA unmapped with length buf_len which is set to
> SKB_WITH_OVERHEAD(q->buf_size).
>=20
> Change the size to q->buf_size.
>=20
> This was discovered with static analysis and was only compile-tested.
>=20
> Fixes: 799684448e3e ("net: ethernet: mtk_wed: introduce wed wo support")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed_wo.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/eth=
ernet/mediatek/mtk_wed_wo.c
> index 7063c78bd35f..4f720ec53e20 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
> @@ -99,7 +99,6 @@ static void *
>  mtk_wed_wo_dequeue(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q, u3=
2 *len,
>  		   bool flush)
>  {
> -	int buf_len =3D SKB_WITH_OVERHEAD(q->buf_size);
>  	int index =3D (q->tail + 1) % q->n_desc;
>  	struct mtk_wed_wo_queue_entry *entry;
>  	struct mtk_wed_wo_queue_desc *desc;
> @@ -123,7 +122,7 @@ mtk_wed_wo_dequeue(struct mtk_wed_wo *wo, struct mtk_=
wed_wo_queue *q, u32 *len,
>  		*len =3D FIELD_GET(MTK_WED_WO_CTL_SD_LEN0,
>  				 le32_to_cpu(READ_ONCE(desc->ctrl)));
>  	if (buf)
> -		dma_unmap_single(wo->hw->dev, entry->addr, buf_len,
> +		dma_unmap_single(wo->hw->dev, entry->addr, q->buf_size,

I guess you can use entry->len here to align with the tx side. Anyway:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>  				 DMA_FROM_DEVICE);
>  	entry->buf =3D NULL;
> =20
> --=20
> 2.53.0
>=20

--bf2LvNtCjkzeEFGh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCatDg1QAKCRA6cBh0uS2t
rAHDAQCBk2/JP1GlWzVrZmGmNrnZUmPT6fHOUTTZRcN+7YPm+gD9GGJ0a5/HxB8d
rhhirUOm4xPSbbOd9R0UefDOqX6KUwQ=
=PNQo
-----END PGP SIGNATURE-----

--bf2LvNtCjkzeEFGh--
