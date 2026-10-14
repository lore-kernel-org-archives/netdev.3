Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC04E80B7;
	Wed, 14 Oct 2026 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981433; cv=none; b=Gi9KnTwBOJWr+JFIvU5OCRmoOZG8Xjd27JAZ0o36/gLxW79mvDFg65M/EsNrw+NhBHT8C5GscMRiyp0/+w8mTHzWElCNXY7LuhU0wBhM+Hr5XrgfqTgNEsUUsOegOAZkMGHGvI1rAO9uiQT/Q7piiWkODv/Wfatjq9BhT6E73dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981433; c=relaxed/simple;
	bh=Qp96MpWdU5xal9WPRFyPr3on2TMkAjzjAFXo1kcudLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R34D6tjj1pb8ie+SVfFzxUniuyTh94vv4Us5avpWrOouQ/+IpAfFSNXw7BeaX617okdyCzslBdKdhYC/FUzTKLR5uYHfxfdYcIqMFTMrhadUtg2Q1HaY11+AhwH4rQW4+xP/HNYjFSIaWhnnHg9LuUOgcsF9x6Eu2blYhK/PjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M2NhgmN1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M2NhgmN1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zcDK/pebo2mPEMQZ0p0oqr6UiazZd9GFCzRu+HIk0DU=; b=M2NhgmN1lO9irghBDCYlbRM8SS
	w0CY12HmYRITG6PK2i7bv55vNs8IktqgyMX08xWIk9fzIwULJQ0FsZkUDhxiEPA1qz2uPxjiV36vX
	MkoO9uhvcxx08tJpKPAV79mFlUDIsdab+9ApuLGKZkGsf+6EY1LCqQ+KJ3z4E+F7KUzM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGyE9-00AjBI-BM; Wed, 14 Oct 2026 14:37:01 +0200
Date: Wed, 14 Oct 2026 14:37:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	stefandoesinger@gmail.com, krzk@kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 16/24] net: phy: Add Sanechips ZX5201 PHY support
Message-ID: <788c9b01-473e-4c45-b6f0-b2ba054da8e9@lunn.ch>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-17-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014072109.1759502-17-ghahramani.navid@gmail.com>

> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Sanechips ZX5201 Ethernet PHY
> + *
> + * The ZX5201 answers on two MDIO addresses: the copper PHY on its own
> + * address and its MAC-side SerDes interface on the next one.

What do you get when you read registers 2 and 3 of the SERDES? Is
there an ID in them?

If the mdio bus is scanned, and there is an ID, phylib will try to
probe a PHY driver on the SERDES.

> +static int zx5201_sds_read(struct phy_device *phydev, u32 regnum)
> +{
> +	return mdiobus_read(phydev->mdio.bus, phydev->mdio.addr + 1, regnum);
> +}

I would suggest adding a probe, and validate phydev->mdio.addr is not
31. ENODEV, or EINVAL, to indicate the setup is invalid.

> +static int zx5201_config_init(struct phy_device *phydev)
> +{
> +	static const u16 led_regs[] = { 0xb409, 0xb407, 0xb406, 0xb408 };

> +	/* LED control registers, all cleared as the vendor firmware does */
> +	for (i = 0; i < ARRAY_SIZE(led_regs); i++) {
> +		ret = zx5201_ext_write(phydev, led_regs[i], 0);
> +		if (ret)
> +			return ret;

It would be nice to reverse engineer what these bits do. And then add
proper LED controls. However, that can be later.

Ah, now i'm confused:

https://www.sanechips.com.cn/en/ProductEn/WiredEn/ethernetConnectivityEn/index.html

This says it is an RGMII PHY. Why does it have a SERDES? That suggests
SGMII?

We need to understand this, because if it is an RGMII PHY, we need to
address the RGMII delays, which that page says it can controller.

	Andrew
