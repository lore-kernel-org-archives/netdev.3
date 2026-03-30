Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244EF37AA74
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913682; cv=none; b=k+8xZJsAjUvMYIVHAmjXjoSHWADtgQneqdVp/MC/AgY2IycWGVFuho+z0qYO5VI6sX2EK5Mxc584+ueHlQtriSSpTH0iAjyBySSRf+kQccoJAZ/F7a/PG852GXmqcOdCjJszUsphTJkmaC7t6TI3YDHYyfaoDAdlckgYrF2t8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913682; c=relaxed/simple;
	bh=w9dZZxZU99qw+b0WL7+0Igo3/TVEQCjEqHk7h+MczX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUNv1V/03XCEzBBTvG9Odi+gU+eQsAHe+VCBxDsZCwLeFCFSqGtQrT1NDiwWr7lw/X3Xmmyv9+ovSNmJumYiNe7gYnR710VWQ6YQorWOwdt0/grWqm6lGRgi3weI8F/wml8aWIMhLgbd0d1BVBdNHguIWmnNE9Y/mFNm0CoxXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QjC932kW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QjC932kW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5TCR9kPk+c+23u4QRbKQv9JjMf7hk4XzDd7yPnR/Eqk=; b=QjC932kWp23StKo6Sytu1ciQ4U
	zAlkA9rjUDXwXOtg9Kw0QWZ2YnN7aL3ZeXut3q8kpIOQSfU0HARHprjWnu/79QJRvsPIMp+IgXV7S
	nlBBA6WV5+ZG40+WMbNFrE1pddhYtpix1oEft7yPxuLt2kOMyHcxEbU3GZbPO68ttbCgok/W1bOg3
	QniudWbe72zrLcU8+O3nmABP83qp/b4zGME9aWxpcb9m7r18tfzepYgc6ThpgyTJaBXXxE6rVto2c
	/ufJd6FlO9s7yZGHe3q9u8FW9N5pVkMWoHavXNtx9wLhCrjt0Px2LvdEYArishR8tLFS47qvBkjep
	JA6mkesQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59370)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7M7y-0000000013L-2nFh;
	Tue, 31 Mar 2026 00:34:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7M7x-0000000034m-1SmI;
	Tue, 31 Mar 2026 00:34:37 +0100
Date: Tue, 31 Mar 2026 00:34:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net-next v3] net: phy: bcm84881: add BCM84891/BCM84892
 support
Message-ID: <acsIjcc005RUa3wt@shell.armlinux.org.uk>
References: <20260330225310.2801264-1-wagner.daniel.t@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330225310.2801264-1-wagner.daniel.t@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 30, 2026 at 11:53:10PM +0100, Daniel Wagner wrote:
> The BCM84891 and BCM84892 are 10GBASE-T PHYs in the same family as the
> BCM84881, sharing the register map and most callbacks. They add USXGMII
> as a host interface mode.
> 
> bcm8489x_config_init() is separate from bcm84881_config_init(): it
> allows only USXGMII (the only host mode available on the tested
> hardware) and clears MDIO_CTRL1_LPOWER, which is set at boot on the
> tested platform. Does not recur on ifdown/ifup, cable events, or
> link-partner advertisement changes, so config_init is sufficient.
> 
> For USXGMII, read_status() skips the 0x4011 host-mode register: it
> returns the same value regardless of negotiated copper speed (USXGMII
> symbol replication). Speed comes from phy_resolve_aneg_linkmode() via
> standard C45 AN resolution.
> 
> Tested on TRENDnet TEG-S750 (RTL9303 + 1x BCM84891 + 4x BCM84892)
> running OpenWrt, where the MDIO controller driver is currently
> OpenWrt-specific. Link verified at 100M, 1G, 2.5G, 10G.
> 
> Signed-off-by: Daniel Wagner <wagner.daniel.t@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
