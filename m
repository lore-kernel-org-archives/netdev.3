Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D13546EC;
	Sat, 22 Aug 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787388758; cv=none; b=j1t8o+idShUILNqMO61XKTbbis26ngYDVSH7Kfex1/Z+vRJE7rBxj2JUYMr9XvQ2lJDpvutlUP9g5nBSwxFJ2587M2YvyB55F8yQDr63ZrSW9oh1/agkWo/P8zwIUiCNa3wgMfqiiDePzIQ1ZgnHJfRJwzRKJ+ZN4K5yC7MVgFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787388758; c=relaxed/simple;
	bh=pRT2HC3e4K5AX5o2Ld9A4kx4qzpZuC59viiQU6xaBO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAkYOIrHOO0qgiTW4pKYM7+cxJN5Ym1u5K9cqTMZPKH31p7893MEwsiuEbQ0569ccnt1BdgGCOPSZpeMjkhZQILS7mI8k4drksNCz6s50MG+AOeS6JGNKDQlRRv324/aPVM8a0gAaVyXTTcXQjJEqs5qOZAu7h7zmnzRknOSPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4wsDVas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4wsDVas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515641F000E9;
	Sat, 22 Aug 2026 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787388756;
	bh=pRT2HC3e4K5AX5o2Ld9A4kx4qzpZuC59viiQU6xaBO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d4wsDVas/Q9Ljsb3PtAKhZFGFePpBzd2LGdfe18PfvmSgCQwAC0heZVkr/JDM22p+
	 /lpi4SgWAMQS7TjiDfvjPJNcEHRfq4UCBtre6W3mYtPmBfbxh9AfwPwN8fWTJPScEx
	 yTxiTGlSvhRSCcEj60gelX8IG3De5QnUuFfx3foONNbmK0SNZQil5AZ/NbXSqgKGYp
	 ZH8d8PFFzbmMP6t6hdRb32n/jYYTvXAFXl7+yBZwdEYekSaLNTLG+mahagyO784bNm
	 oSM0DLu4UZhkTMq4r8A7glmS5oaYGe3F+J6VUN0bYHUsknTwf/pbuVZrWj5jIr3ESz
	 Tyvj4CSrPhboA==
Date: Sat, 22 Aug 2026 10:52:32 +0200
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
Message-ID: <aoljUFw-rQTLDXg0@lore-qca>
References: <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>
 <20260821174121.326f3c49@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2D5i0aIdzt8Hqvqs"
Content-Disposition: inline
In-Reply-To: <20260821174121.326f3c49@kernel.org>

--2D5i0aIdzt8Hqvqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 21, Jakub Kicinski wrote:
> On Wed, 19 Aug 2026 21:07:07 +0800 Shiji Yang wrote:
> > Change WDMA RESV_BUFF from 0x40 to 0x80 to avoid CDM TX FIFO overflow.
> > Without this patch mt7986 and mt7981 may have WDMA TX hang issue. This
> > patch was pulled from mtk-openwrt-feeds GPL open source project.
>=20
> Lorenzo, could you TAL? (incl. Simon's suggestion of the Fixes tag)

sure, I am AFK now, I will review it next week.

Regards,
Lorenzo

--2D5i0aIdzt8Hqvqs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaoljUAAKCRA6cBh0uS2t
rMCMAQD5Qhui+X9AUoo4oP0JV/Wuu0TQWDg8vvOxE6LmoOSbHgD/XM3ORM99Gp+R
ASb7s30VS2r9X2oSaUY9H1C0wOUwYAw=
=geZr
-----END PGP SIGNATURE-----

--2D5i0aIdzt8Hqvqs--
