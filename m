Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D92DCF46;
	Wed, 15 Jul 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132343; cv=none; b=HWxpCPyH0yG0zOuN+h34tTXTjyVSd5Ldthlx9qDswkng59/ya/AWaiJksoRKpxw9XfSS6n99qJuO0JQywX1QCI7Ux3YgDVt3H8M4Tt4kpnqb17nbuXR2oMNP/Rc+yoC9y1KLw5JhfOhOQ2J2o0ghJocxxjqkK2OUX3Q9z3348fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132343; c=relaxed/simple;
	bh=QahVq81pzXr5oTwRN49Fh9Z5JxuzbUNhlkoyXdz/MbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON2Cj3x/+EKs2ln64QJUJSxOMVP6Tfwb5q1Q0N0PohtVEhoFUh2ZS0LkMd8GzlgskiAreLXAwgbsukaO+xo9Yq5OxF4p9IjR9NUSMHv8Mn43aiAB9rMCIdKkguBOygrUAis7oHytur2XU6B+YE0GYYhgxf843HZkvEhuldi9aEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4BFmktiX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4BFmktiX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aguL97Ql3yPQNpH1dBfOCcdYj1as7lHHUNdIAvpBQJ0=; b=4BFmktiXrOOH7w5eZ40k+3a2iH
	fAE73NbloJTaVWH2fbAL3pH/q/JtOz9wVwctZYEUf2kMCIVv0V0Cw9v4kmWZBCQAzshTvh1H+Xlxf
	ZTf0y6dcwz5ti6+bVTft2eiQ4h8IrjpPO3h/RfsGHv7r3CuIXNqR4mjJXtKDeRwNtpzw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wk2Js-00CNxG-LM; Wed, 15 Jul 2026 18:18:48 +0200
Date: Wed, 15 Jul 2026 18:18:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, robh@kernel.org, krzk+dt@kernel.org,
	heiko@sntech.de, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 07/10] net: pcs: xpcs: add Rockchip RK3568 platform
 glue driver
Message-ID: <1d92078f-3009-43d1-a228-c3e67a1f4f4c@lunn.ch>
References: <20260714191341.690906-1-coiaprant@gmail.com>
 <20260714191341.690906-8-coiaprant@gmail.com>
 <4823c1d9-51d9-45fa-a96c-f2caab1cb29e@bootlin.com>
 <CALj3r0h4cFd-tp9-UVxihL9-a1W7_4nvnKoXW_cP5WECKc66Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALj3r0h4cFd-tp9-UVxihL9-a1W7_4nvnKoXW_cP5WECKc66Hw@mail.gmail.com>

> This is intentional. The SerDes is attached to the XPCS node because
> on RK3568, a single SerDes serves all four XPCS MII ports in QSGMII
> mode.

This is not the only device supporting QSGMII, and so the issues you
are addressing should be common to many QSGMII implementations.

Please take a step back. What would a generic solution look like?

Can the reference counting be placed into the core somewhere? The
common clock framework allows a clock to be enabled and disabled by
multiple consumers, and the core clock code does the reference
counting, only calling into the clock driver when state change is
actually needed. Maybe the generic PHY core needs something similar?

	Andrew
