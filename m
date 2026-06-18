Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243935DA40
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768037; cv=none; b=MHK8SKbTP06W2EIwQg3rBoPZ0qjuUfCu1AVg3BaHalF+C0L1sfezlV4BZqCd4vkbzOCcMd/Qy4xcRALbEJTZu3hTWeLI0O93fbkzRXpFjVH318OVtWAimdZMTN4riQ8XARj5BmjGJvLBB5haOt+aAXSaPnET0AZve74CHVT0GUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768037; c=relaxed/simple;
	bh=hjMxI0rZYwVnV9vNeuTO15pUJpl61GpEQMcW7U9iWKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5HRwdxaEzEg/0P2TKBlxdQmCjPpjNO0CpInOsKPWBkWY6JSXMpVaYuvvx1nASgVkM2JLSe/DSqhL7g3HtUFlP4dc7kZvkLWpiuu3/zzEUrKgQemnhkR6Iab3evv16CXv43InV4eCdRGuOEN+30eVue6njfXKb9GQOcFYurBxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIkqaZEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIkqaZEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621E51F000E9;
	Thu, 18 Jun 2026 07:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781768033;
	bh=hjMxI0rZYwVnV9vNeuTO15pUJpl61GpEQMcW7U9iWKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oIkqaZEnuai5ih9lPd40PVg0x1+o9AkBx60gJR878OY28inJhTYspcBvK8qstse9m
	 jm7JLACnLUvBFQxzf7xbahErqMuuGi3IwdjzVVERkfjXafu/B9pC7ohnSX8Gdamxb6
	 7aXS+FU3x+M7PnI2sRMU1gG/fE64v5x2M7LyostDTO4dLHNMfLh9RxlBOJPSconIRX
	 cPwkB0e9yYGjJwprwLfbSDckRUJLVfT+KPp3uebi1n5g4QHEavPrf5tJlUPkRsG0G3
	 P2Zeuiy5wX6U2Q3684S8nQcIQ2TgZQv6TWL76CG2Hz/1a6Em529ZTeVYQ8wbPCLXLN
	 CYGPtKSDSwTiA==
Date: Thu, 18 Jun 2026 09:33:51 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wayen Yan <win847@gmail.com>, netdev@vger.kernel.org, horms@kernel.org,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Stop TX queues on error path in
 airoha_dev_open
Message-ID: <ajOfX7RFoSrzopNN@lore-desk>
References: <178160729880.2156257.7978513589649053826@gmail.com>
 <20260617164448.31e189bc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hz9vSoCD4yGittIQ"
Content-Disposition: inline
In-Reply-To: <20260617164448.31e189bc@kernel.org>


--hz9vSoCD4yGittIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 16 Jun 2026 18:50:39 +0800 Wayen Yan wrote:
> > In airoha_dev_open(), if airoha_set_vip_for_gdm_port() fails after
> > netif_tx_start_all_queues() has been called, the TX queues remain
> > started while the device configuration is incomplete. This leaves
> > the device in an inconsistent state where packets could be
> > transmitted before the VIP/IFC port configuration is complete.
>=20
> Not sure if this was superseded by another posting but FWIW
> this posting did not apply.

I think we do not need this patch.

Regards,
Lorenzo

--hz9vSoCD4yGittIQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCajOfXwAKCRA6cBh0uS2t
rHn/AQCS/e+lABQrjqQaBlZzOEnOM4iJBB83aLuUkcW2RcDJXwEAqw9wyBTx3Mqx
NCJ9SEynSiNrX7kK38yFjOOyveylwwQ=
=FtFY
-----END PGP SIGNATURE-----

--hz9vSoCD4yGittIQ--
