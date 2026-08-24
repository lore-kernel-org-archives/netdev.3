Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420B25A642
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555606; cv=none; b=tOQJoNb4Lbl1JMdQHy4mVUeJ0zTe7cfVipy5HU8kuBu2GDXD2bocZ6Ox+CVYo6l5BwUYtSoakJhxNqblrRijlOHaLs6/v90IoPj60od4kFCB77sw1Y71Lnz5BpFk/Kcd71APTqvExEt+SY4hInW1Q80WBb/CUqsL6Y5FAIRpzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555606; c=relaxed/simple;
	bh=rnMxnQ0x2QQGkEKahy+gvFaX4CXTGisUtZpSfR+IKmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKzV6hKGciyqV/7O/uCntzOom4854QkR1KiAW5Rm2j3Edp2NZqGvzOJ4v8e0hgMk+jkC+Qu9vp2fj+0HuqJaXrh7H9nFG0nx94z6AmbmHm5xh44CwguED/Gj6vLN/rKcmH4mhrqztwTNyRvN3Rk7FXMcKA2Mw3Ncom63GRnYs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFK8SuSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFK8SuSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A36B1F000E9;
	Mon, 24 Aug 2026 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555604;
	bh=BkGkUHBq+UzBxHDBQnM/lS2NOOgRMTBcY7T2S+1CUvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jFK8SuSaJ5QR1mA7ZeGkUBxv4gHNCd0PX9+Y4yYg/ZYq41xf8aecNaidHg/XK9aa6
	 GnWuYMeOIDiLoowf/QU3t4fCBUPZNRagABhNkyncj4Uzh16+rtPLrGEfNKEJivUG2k
	 YBHRGVQ/VBxpdz8FT7/vXWst69TfruryUZR0CclD5AsQIOQyfptzrMPT9gllGnLrdI
	 xu3Q1Eogo8FWcYp5/AVCbprx0C6P2YoaIV/SQdXOSjfAH48B4Sm9aMOV5cebfCoYIa
	 I1xGh+Z5ZOSHs6VKI3PSts0RkT+OILcDxzmxh2tousbER04F6OFyXVVMx8j1+wJaH3
	 8pkudckDSzKFQ==
Date: Mon, 24 Aug 2026 09:13:22 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, yangshiji66@outlook.com, upstream@airoha.com
Subject: Re: [PATCH v10 1/2] net: airoha: npu: fix missing streaming DMA mask
Message-ID: <aovvEvI4sADve2iu@lore-desk>
References: <20260820085941.380401-1-pawlik.dan@gmail.com>
 <20260822122727.4f437bb5@kernel.org>
 <CALC2Api8nhePvuUPsw9CE6nX-0pFOMO5qy=4fzqox8_XM4eSqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mUbn9b3xpUqnPYR0"
Content-Disposition: inline
In-Reply-To: <CALC2Api8nhePvuUPsw9CE6nX-0pFOMO5qy=4fzqox8_XM4eSqw@mail.gmail.com>

--mUbn9b3xpUqnPYR0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> I tested both patches independently:
>=20
> - Patch 1 alone (DMA mask): NPU reports version 0.0 - probe fails.
>   The streaming mask is correct but 24-byte buffers still bounce
>   through swiotlb, and the NPU can't write to that address range.

I guess we need to understand why swiotlb bounce buffers are not working
here since these are valid address where the device should be capable of
performing DMA ops.

Adding Airoha folks in the loop. Any input on this?

>=20
> - Patch 2 alone (cacheline buffers): NPU reports version 0.1111 -
>   works. Cache-line-aligned allocations bypass swiotlb entirely.

I guess this is just a workaround for this particular case.

Regards,
Lorenzo

>=20
> So patch 2 is the essential fix, but patch 1 is still good to have as
> a defensive measure - without a proper streaming DMA mask, any
> future sub-cacheline streaming mapping would silently break.
>=20
> Dan
>=20
> sob., 22 sie 2026 o 21:27 Jakub Kicinski <kuba@kernel.org> napisa=C5=82(a=
):
> >
> > On Thu, 20 Aug 2026 10:59:40 +0200 Daniel Pawlik wrote:
> > > The driver calls dma_set_coherent_mask() but never dma_set_mask(),
> > > leaving the streaming DMA mask at the bus default. On the non-coherent
> > > EN7581 platform (Cortex-A53), this causes the NPU mailbox to hang
> > > after approximately 41 calls when using streaming DMA mappings.
> >
> > Can you confirm if patch 2 is still needed after this fix?
>=20
>=20
>=20
> --
> Z powa=C5=BCaniem,
> Daniel Pawlik

--mUbn9b3xpUqnPYR0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaovvEgAKCRA6cBh0uS2t
rNgQAP4gzAxPwYlVZLcsD8FbF199r8CFHfwu4FtyHed86dqaVQD+IEWDsuyiWXi+
Vf05SS9bTDTKiUc1LIT1fLizV1htAAE=
=ET2e
-----END PGP SIGNATURE-----

--mUbn9b3xpUqnPYR0--
