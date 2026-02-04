Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB91F0994
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235300; cv=none; b=cOnx+SJ2T//jXyCbyoEJ6wCoY4FUytHhVnRDdAfxkakvv4lfYLYFIfqk+J3eePEL6zN9CINP3JD/aPGJGPTqDxm/75LrY+Orry77x53WbmZBz138Fr3gD1PxJOOOXbCtk0Tpet6I2WZOpV9MGjZ0KNJ7qVr02lx/MaIruthgxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235300; c=relaxed/simple;
	bh=+tYsQLwGziPHF42RBTTroOYOUEXabptYdKJrp3JzRek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhuVLFBc+yQs7jwsMt5n3lENlAiX6Vr3PcA/MA1QAKpFOoXE70qSBsdxGNyRLjEx96VN3CksoJrRUGzIiqju7/g4aRi6WK5mC1DbZ2ejU0kBlniLjmBEELS10xqxPubtYILpvhEWwSuFlWtef8JKGF4jAlZg5dtaebQR8dRCYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=t1vzuh4B; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="t1vzuh4B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Kd5J4KD+UWilIWXl775s3u3AtyqpuOqe1d0igb4DjAA=; b=t1vzuh4BbUI7J8iR5DF6aPXWu9
	cRtor9rSOEClYtro/eJzqXsDxY1ywe6TGGvU5O9n5Hk8vm+q+BrFZJifHcC55IEY+0ODy+z5hyqM7
	B60pbQ9Jgn2LCQYdppcEiH5llI1QB4NbPb2B/7C/ybfAT3n9xcYKVhdalqfUVQwVM+u+r+Og4qEiN
	xgzswZdFjAsPvvBrJOuSDtLYippmhkiClUgHWbvzT792dOmvEdRaBv46sQbmrhmTTU9vlUra2V3NB
	sTITHHb1Xxb8/C8MbAiIczc+6fMdbJTVM2vikQ1mrertPl2tgRBrIk02sJuydrSBANQQCAjNsqe18
	WQt2CSkQ==;
Received: from i53875ac7.versanet.de ([83.135.90.199] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vnj3v-0070xM-9X; Wed, 04 Feb 2026 21:01:19 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net-next 4/6] net: stmmac: rk: rk3528: gmac0 only supports RMII
Date: Wed, 04 Feb 2026 21:01:19 +0100
Message-ID: <3881472.Sgy9Pd6rRy@diego>
In-Reply-To: <E1vnYy1-00000007hp3-0hKm@rmk-PC.armlinux.org.uk>
References:
 <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYy1-00000007hp3-0hKm@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 4. Februar 2026, 10:14:33 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Russell King (Oracle):
> RK3528 gmac0 dtsi contains:
>=20
>                 gmac0: ethernet@ffbd0000 {
>                         phy-handle =3D <&rmii0_phy>;
>                         phy-mode =3D "rmii";
>=20
>                         mdio0: mdio {
>                                 rmii0_phy: ethernet-phy@2 {
>                                         phy-is-integrated;
>                                 };
>                         };
>                 };
>=20
> This follows the same pattern as rk3328, where this gmac instance
> only supports RMII. Disable RGMII in phylink's supported_interfaces
> mask for this gmac instance.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




