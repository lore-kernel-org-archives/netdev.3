Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096451FE44A;
	Mon, 23 Mar 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258258; cv=none; b=SywneGzCxJMMqvncLzjULehF842RIfyQd/rd+y+fWLBnWVID+4GX4qaGSdfHbjii2gmfKqelNBDhJQVLda6FVvbrL1vxLUdFFcaqgeua77cd29hVEdrjMP0N723iRvH+TgEv/9M0IKH1G7Td1lthhXn7WgNrw5JlIn2EqFEi7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258258; c=relaxed/simple;
	bh=+sB9HwYJtDPm2Yh5tyrCOddW8M/7xA3pzUn3aUos3JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDGDe2YMBQFA4Md/1UeT1Gg1m4HDl8SE7rI2anFYWO77liysRdu4Em+SQ4ywVJtD/zSyq/EUaihQhpAg3x1yYsr/U00v3PxPEkjO8JjY2joYjpuJm3bpFcb2FENUWz46hoRUTcS5RHFr/lLWrwRCEKuMPDlIpUfWAXKH+EOh5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=etqlIQfJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="etqlIQfJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F3rUhqBT1KeCDZlm1nLAVKvFKDzC8SHFz9yiyugPwjo=; b=etqlIQfJSSDSaWC3g3CkplcGX+
	Az+ECRx6Cd67IDOLKoApAzDji/xzE74lFrsxHONaOYr/6D8zl1uKVNXf+EdkRlQYLvjekUSCPPgJl
	B6elVyuHZdADUUDQxvi7dFUr7eCVzXxl8y2zVjFz6YGCEZb/UGk5ApAGJIymWdcY2ByE5R4P2SXkH
	Ay/gkmTp1OTxO+62vbYDEZ5Od3e1c1wGDJ+xblhu518mcW5l5nCzOv6lbc8gCjnEYU8H1l13kthWV
	ugySbdVObDVq418ku/v3FG963j2qdsGQbxQthOMQsnw+tUTC+AWi/TwUKK55j1kpSSqv+mCKZgNAf
	EpjKTHNA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58958)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4bcS-000000000Cw-41vC;
	Mon, 23 Mar 2026 09:30:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4bcQ-000000003up-3Y8E;
	Mon, 23 Mar 2026 09:30:42 +0000
Date: Mon, 23 Mar 2026 09:30:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
	frank.li@nxp.com, chleroy@kernel.org, horms@kernel.org,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 11/14] net: dsa: netc: add phylink MAC
 operations
Message-ID: <acEIQqI-_oyCym8O@shell.armlinux.org.uk>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
 <20260323060752.1157031-12-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323060752.1157031-12-wei.fang@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 23, 2026 at 02:07:49PM +0800, Wei Fang wrote:
> +static void netc_port_set_mac_mode(struct netc_port *np,
> +				   unsigned int mode,
> +				   phy_interface_t phy_mode)
> +{
> +	u32 mask = PM_IF_MODE_IFMODE | PM_IF_MODE_REVMII | PM_IF_MODE_ENA;
> +	u32 val = 0;
> +
> +	switch (phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val |= IFMODE_RGMII;
> +		/* Enable auto-negotiation for the MAC if its
> +		 * RGMII interface supports In-Band status.
> +		 */
> +		if (phylink_autoneg_inband(mode))
> +			val |= PM_IF_MODE_ENA;

I would prefer newer drivers not to use phylink_autoneg_inband()
anymore. Note that there is no need to support RGMII inband in the
kernel (nor is there any proper support without a "phylink_pcs"
being present to provide the inband status.)

> +static void netc_port_set_hd_flow_control(struct netc_port *np, bool en)
> +{
> +	if (!np->caps.half_duplex)
> +		return;
> +
> +	/* The HD_FCEN is used in conjunction with the PM_HD_FLOW_CTRL
> +	 * register, which has a default value, so currently we do not
> +	 * set it in the driver. The half duplex flow control works by
> +	 * the backpressure, and the backpressure is essentially just
> +	 * a long preamble transmitted on the link intended to create
> +	 * a collision and get the half duplex link partner to defer.
> +	 */
> +	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_HD_FCEN,
> +			  en ? PM_CMD_CFG_HD_FCEN : 0);

We don't support half duplex backpressure in the kernel. I notice
you always enable this whenever HD mode is negotiated, which means
there's no way for the user to disable it. Flow control can cause
problems. Ethernet relies on packet dropping for congestion
management.

> +static void imx94_switch_phylink_get_caps(int port,
> +					  struct phylink_config *config)
> +{
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +				   MAC_1000FD;
> +
> +	switch (port) {
> +	case 0 ... 1:
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		config->mac_capabilities |= MAC_2500FD;
> +		fallthrough;
> +	case 2:
> +		config->mac_capabilities |= MAC_10 | MAC_100;
> +		__set_bit(PHY_INTERFACE_MODE_MII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RMII,
> +			  config->supported_interfaces);
> +		if (port == 2)
> +			__set_bit(PHY_INTERFACE_MODE_REVMII,
> +				  config->supported_interfaces);

The "case 2" above already ensures that port is 2 here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
