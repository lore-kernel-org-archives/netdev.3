Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37C267B89
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235057; cv=none; b=Ewd/sDb5agrERUq9FGzyWICd1KYxME6m/iINgvQBQdbXbTofE2tcH73F7t9p3BYSrA4STNykRcrcChxQ3ES1HiqtOd/aUzV3v5iRWpE3aNBPRtgprBMg1GTB+zh7xXLAb/azJAUohVprzcHBHPMhPPJHD7NIYx+vmlL4HVTQTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235057; c=relaxed/simple;
	bh=xlx7imhS8egX26fBI66YJcapLdUQv4lJsXpksytMu7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gU/a/6l9ALFKpDWWdlaq9QK6mYvSoJ9DHA5yD6Dv11vevn0Cp2k97qQXjnbU/t8Ilm+vlA5xHenYGwP2ztU2HEujHZrKzXJReUkSPDAxUbvRll4DzVtdYqPg+Vh6o9Gnk6yedgsoYjk9b2MNrcHJgw5HHoVSSjSwmUc2nvsSQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dIvU9Ivg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dIvU9Ivg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=xlx7imhS8egX26fBI66YJcapLdUQv4lJsXpksytMu7E=; b=dIvU9IvgO3p2j6fNWBS7K6IHZu
	SXBMK7cCzcttVrJkGOcvsIiSmsyVXNcr8tiQo8l+3bmQ5dhW+Q6qf6C+C1gK5btrMOVy59fLjJEyt
	9pEbloNKFVhF+TAMbfK9Wv0D1EuIdPJ1kdkOKNb8QhjvmQP0OdeBZ35dAsBAo+NXQyle4KkI5C1cH
	vFRFzfFk2I+z66IlowQ6TnkbNrH+lfdd4EmwlYixiY0oXv3UF26aAGekUlhkmiyfeYxOpwdMsgw2f
	le+XSgzInUdW8BemnIxcQmF97bpj4TkpQxUz9DWkTq2TzCs8F/ZeZpqLY3nEn/krNCtb9j9facFVo
	vCTK22eg==;
Received: from i53875ac7.versanet.de ([83.135.90.199] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vnizy-0070uw-LC; Wed, 04 Feb 2026 20:57:15 +0100
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
 Re: [PATCH net-next 1/6] net: stmmac: rk: introduce flags indicating support
 for RGMII/RMII
Date: Wed, 04 Feb 2026 20:57:13 +0100
Message-ID: <3535226.C4sosBPzcN@diego>
In-Reply-To: <E1vnYxl-00000007hol-3XiH@rmk-PC.armlinux.org.uk>
References:
 <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYxl-00000007hol-3XiH@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 4. Februar 2026, 10:14:17 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Russell King (Oracle):
> Introduce two boolean flags into struct rk_priv_data indicating
> whether RGMII and/or RMII is supported for this instance. Use these
> to configure the supported_interfaces mask for phylink, validate the
> interface mode. Initialise these from equivalent flags in the
> rk_gmac_ops or depending on the presence of the ops->set_to_rgmii and
> ops->set_to_mii methods. Finally, make ops->set_to_* optional.
>=20
> This will allow us to get rid of empty set_to_rmii() methods.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de> #px30,rk3328,rk3568,rk3588



