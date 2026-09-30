Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2EB4E1C93;
	Wed, 30 Sep 2026 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772922; cv=none; b=HTuuH9eL2JiPqvJWN3vSjjcVpfpG2k/dU736ENjODwpdJPTgTKCPvgT4PZrHCbJ6TOUnRceKpsuUPtYYPkLpLTAK/YQ0jiJ0lYEy9qnReHFrDRkNnVqRPCR4WXsp9tswRas31bCXJt17oeVSe+ZniHYS0KXHcdykr0AqArFy4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772922; c=relaxed/simple;
	bh=lacdbLI3xUd4daF6VsncABGp6gJ0RYBthB9GXAssU2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vETa7D23RZhtqtLU7oxpjzNWSQ4tOtLNiMtJYuBKRryHZ2CAOWgLjg3e3+0VXG3koodo68Bg972P6YTEeAGQnkkG7Uhu2mT+3km1HzNVsPBM10VgfKOSrXmBYrknGrfJ4yUc/r1NOF/l7ht6V7gwi87hLT1EgQ9k2jYdzVHO6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zHI5M8EF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zHI5M8EF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T7694IwjMt0iGn1o9+SSySBxVpdM/FekLloodgNQ8zs=; b=zHI5M8EFUBiNvzxbQwbmsZajUs
	wIS8Dre30/yWvGJ0P8eFzgpnDKfAkC0Q75SYSRmF2hScKI7oKciMrSItqlTyTWRhvBPnvCYPcZkZ1
	6YNqe5F93oHXc0VM++LeEv0L1v1W4fW7ORmfCX/cKApMi5WqjOBnDuB1n85YRULCGkUg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBtpv-0089pJ-O9; Wed, 30 Sep 2026 14:55:03 +0200
Date: Wed, 30 Sep 2026 14:55:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY=?= =?utf-8?Q?=3A?= [PATCH 0/5]
 net: ftgmac100: Add AST2700 support
Message-ID: <e8a8de24-4f6d-4645-9022-36995d8fd770@lunn.ch>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
 <14a281e2-c88e-42e3-acd3-b20f111a4c28@lunn.ch>
 <SEYPR06MB5134D5AEAD86D3E4C97D1DB99D8C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <36d6dac0-30ab-440a-bf35-81b33ecd8e8b@lunn.ch>
 <SEYPR06MB5134FA89E6754F168E94C1B29D8B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134FA89E6754F168E94C1B29D8B2@SEYPR06MB5134.apcprd06.prod.outlook.com>

> > Does your AST2700 bootloader also have the delays off by default?
> > 
> 
> Yes. All of MACs in AST2700 are configured to disable RGMII delay with "rgmii-id".

static int ftgmac100_mii_probe(struct net_device *netdev)
{
        struct ftgmac100 *priv = netdev_priv(netdev);
        struct platform_device *pdev = to_platform_device(priv->dev);
        struct device_node *np = pdev->dev.of_node;
        struct phy_device *phydev;
        phy_interface_t phy_intf;
        int err;

        if (!priv->mii_bus) {
                dev_err(priv->dev, "No MDIO bus available\n");
                return -ENODEV;
        }

        /* Default to RGMII. It's a gigabit part after all */
        err = of_get_phy_mode(np, &phy_intf);
        if (err)
                phy_intf = PHY_INTERFACE_MODE_RGMII;

This default is now incorrect for the 2700.

I would suggest that for the 2700 you make phy-mode a required DT
property, and fail the probe if it is missing.

	  Andrew
