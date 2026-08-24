Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528B39EF25;
	Mon, 24 Aug 2026 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557713; cv=none; b=CElC4/dIoAj366moDnXpdvTJN7IWYObH+NGJZvdDT90Wu+jqWuXoUQnNPj9XSjd/YNz0lYHuZ8c0/L+4q3SxiSXRwuC6S+HLVO0PzHjvJsEUF7kekSBnORIuSpS0PwQuRW3+g/d97UqpJiWIc8wiIfqlGijvNZiwnfmxa6hhIvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557713; c=relaxed/simple;
	bh=aLH8tRvP03IrP0Igt+FPh0lRLfkhDDhlhqyfhLJ2ANY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMuYe+suIzgkz7K4HUkI7DizjzDq+K/rx1pV2NDGOSDFHnNJhiRNw+s3uPUYerwRt5PARFI5TisPl68lSDZIVfCzbrjDtMvJsVYhQTGDeIKtdut9GSYPk1hPAIwwDJ5ZzbDC6MYq+aqrm2kmC1vjp/KH3hEo9prsvzNNB4AN69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUszDA6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUszDA6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6ED1F000E9;
	Mon, 24 Aug 2026 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787557711;
	bh=aLH8tRvP03IrP0Igt+FPh0lRLfkhDDhlhqyfhLJ2ANY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oUszDA6I67oDMlfP337Q7h1nsBkLkyATHQ61hiZ5pvYO0BLqbVbxr/Txn8yNeSwA/
	 fN0kvtPsYpyjQ4WC5wDcey9si93RyOLIMfAqBdwfRDyJ5OBh2MF39CiJAeYBDyiRwL
	 aGYxPTPxLoAYQHgPtG+MkLUK3ZzL70vXYzSMd7Ingvzj/+7nY7V2zjj8tj6SeREGOX
	 850Hx32mJjrhpwEVj5TbkPnC2LSWhYd0taZEIv6nKbZ5C4bfsugszMTaRd4INceIrM
	 4NIEnlmxBs6LmsERp3PRxW/Mjudxf8C/Qx1cLGtstHtWDT4kVlwc8cNCo/Vs7/uOpZ
	 Q0uT416HcH0Tw==
Date: Mon, 24 Aug 2026 09:48:29 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shiji Yang <yangshiji66@outlook.com>, netdev@vger.kernel.org,
	Rex Lu <rex.lu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF
 to 0x80
Message-ID: <aov3TTKBZ68yl50k@lore-desk>
References: <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>
 <20260821174121.326f3c49@kernel.org>
 <aoljUFw-rQTLDXg0@lore-qca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xfwh0j0kadPQPpx8"
Content-Disposition: inline
In-Reply-To: <aoljUFw-rQTLDXg0@lore-qca>

--Xfwh0j0kadPQPpx8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Aug 21, Jakub Kicinski wrote:
> > On Wed, 19 Aug 2026 21:07:07 +0800 Shiji Yang wrote:
> > > Change WDMA RESV_BUFF from 0x40 to 0x80 to avoid CDM TX FIFO overflow.
> > > Without this patch mt7986 and mt7981 may have WDMA TX hang issue. This
> > > patch was pulled from mtk-openwrt-feeds GPL open source project.
> >=20
> > Lorenzo, could you TAL? (incl. Simon's suggestion of the Fixes tag)

I am wondering if this is necessary for v3 as well.
@Rex any input on it?

Regarding Fixes tag, I think cf26df8833cc is the right one.

Regards,
Lorenzo

>=20
> sure, I am AFK now, I will review it next week.
>=20
> Regards,
> Lorenzo



--Xfwh0j0kadPQPpx8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaov3TQAKCRA6cBh0uS2t
rGDMAP9twXBYSNOh5AC9jnFT39IOAhsK9ISHTnmOXo5O917ihQD+NA+Jb8/BDLYp
06R2nrCbXoWHc8+GmruoqP1fY3oEqwA=
=i5eV
-----END PGP SIGNATURE-----

--Xfwh0j0kadPQPpx8--
