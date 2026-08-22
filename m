Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431082D9792
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787388974; cv=none; b=nMQwlY+JoWS57aTXOchNv3Z+TwzX11ikHMqOuLOoZDi+daso288us4fTZ4Poxs0LM4HIPpc/6z6eOn5TpCylwE1sGhs7cgKySlbmDEysj91Ds+jJN04YucBXbE2PikZd33x9oPxTxowWszEyUzNHyTUqWC+e2FFEP7IyhNIp48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787388974; c=relaxed/simple;
	bh=/jmuCUjs41CYQ7kdv95y2qeY8k2bpfzz3gHEco6cbQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm51Blj/+HUE57b3xdn3+5jIgnoS/aJ4NMOoFdExohkOHwPBATkzKwHO5p+pLJAf+UKN9EUGzFng3ikSAqbMu7oWPHEha7JGxDIuCf0N24CVYRz6Y3Xl14K9r+vnS+eMdbMGxgPAuEPEnSkicCh0YkOQsurVfvc31hp0NcpxlmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxb1eeqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxb1eeqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414131F000E9;
	Sat, 22 Aug 2026 08:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787388972;
	bh=6YE7rVKkppuVjzkxFH0bH0kbXzu8LKHWY6a+DsEbwnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yxb1eeqtycN/SSjtnUdYrw/LYXrdiQnrfclXmZl1EnqW6GnV/H17v80wm01TQKggo
	 z01SZ5rAmYjyRU7i8Ok5QjqSoniTf61ZB7kwT0Bc22PX7yOG+qEm/poEETNZjyo3rE
	 cYHmVXhTAfkpGw44d0pMJek0aOoOf4/kB1sP7PsmKU3UDLfOkzqxiG7wgJzDXyMCsd
	 Mc2Dy7HdPBM1/XuED/DsfudhKBxx9dUas6pXtDUVzCk/Tfknp/MH4Y8mHvVoxqbqUm
	 L94vNphRi/iZp1N3EppGc2txslRVN7iwCXSzi5gNtgE1KP+nZmweePDVWvS6hsVEfm
	 PUupfJ9CtgnWA==
Date: Sat, 22 Aug 2026 10:56:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kuba@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, yangshiji66@outlook.com
Subject: Re: [PATCH v10 1/2] net: airoha: npu: fix missing streaming DMA mask
Message-ID: <aolkKmwLsvnmG8Td@lore-qca>
References: <20260820085941.380401-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4UCTKtFfDws+VdJ1"
Content-Disposition: inline
In-Reply-To: <20260820085941.380401-1-pawlik.dan@gmail.com>

--4UCTKtFfDws+VdJ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The driver calls dma_set_coherent_mask() but never dma_set_mask(),
> leaving the streaming DMA mask at the bus default. On the non-coherent
> EN7581 platform (Cortex-A53), this causes the NPU mailbox to hang
> after approximately 41 calls when using streaming DMA mappings.
>=20
> Replace dma_set_coherent_mask() with dma_set_mask_and_coherent() to
> set both the streaming and coherent DMA masks, matching standard
> driver practice.
>=20
> Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buff=
er")
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/202608141=
10017.2795022-1-pawlik.dan@gmail.com/
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/202608091=
52813.585797-1-pawlik.dan@gmail.com/
> Link: https://patchwork.kernel.org/project/linux-mediatek/patch/202608050=
70851.2885888-1-pawlik.dan@gmail.com/
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index b679bed952de..4045d1eb93ea 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -766,7 +766,7 @@ static int airoha_npu_probe(struct platform_device *p=
dev)
>  		npu->irqs[i] =3D irq;
>  	}
> =20
> -	err =3D dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (err)
>  		return err;
> =20
> --=20
> 2.55.0
>=20

--4UCTKtFfDws+VdJ1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaolkKgAKCRA6cBh0uS2t
rNLJAQClqStH75ruqGvASzQdetMn8Ppz4CPPTVAsMWPo/akT/wD9ECaDg33ScsTK
Dsxo0yNMrKwF78XzKE85XmFCUxf7jw8=
=mecl
-----END PGP SIGNATURE-----

--4UCTKtFfDws+VdJ1--
