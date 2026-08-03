Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F5194AE6;
	Mon,  3 Aug 2026 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728730; cv=none; b=H7PelgrqLqrXRcBv4yl4vY8/LKJ6hdk51M61kSIO91wYh2rJZE//ID1TiWbRqflYparvEvXJt+cpFtNheoSMSdFk4xLtbrgiScCxpUlB0G44SkBgjFw5xClHacPT9V/pscPyApirZwxPesKIlyQHpTqSSdpq1f+dgNYiR8pTS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728730; c=relaxed/simple;
	bh=AqgTWvYbY8Lt5SwMa+oGhH7ygHjlxirbB8XxRh/pHNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT+xkDg0kMpAqiKtIpdVHPDJwkubxsAaqOBJvmjZpMhVrxsyEGbMmKmtbMmXi+PcWES9eYO9+gA+JoAD/DHlKY9H3vPMnKM058trRvz6f205rMsM82UKfbNUF7PX1YK9L9XEakfjUTFbHNdLehfbxsPk9InLdyXJeHF8/HqAFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AJtqOEAh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AJtqOEAh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=njwIKGLdgpfnbU8tdPotISfWRyBO6jlALlnzijNACdE=; b=AJtqOEAhJMVWc09JBSsEuJHj9w
	vWgUCTdsVmXYei8TkOtclykFEO+UALnaepAu8a38fkI2tQ3ZjCHv4u2F7l43msC77xug+FXttNOpX
	XF/xPLJujFzdixz/oBXBzcHS0oeAI6emkp49fB92yja+prSDux+DYVvrHdLi256qM0zg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqjbw-00FeRm-6F; Mon, 03 Aug 2026 05:45:08 +0200
Date: Mon, 3 Aug 2026 05:45:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
	"daniel@thingy.jp" <daniel@thingy.jp>
Subject: Re: [PATCH net-next v8 3/7] r8169: add support for phylink
Message-ID: <0ddca9cd-4834-4d00-adc5-520e74a803eb@lunn.ch>
References: <20260730065014.883-1-javen_xu@realsil.com.cn>
 <20260730065014.883-4-javen_xu@realsil.com.cn>
 <cfcf87aa-3d4d-411a-9af0-5a5b78c9ae89@lunn.ch>
 <4338caa7b5d244e1b0d9a6713ed8fce3@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4338caa7b5d244e1b0d9a6713ed8fce3@realsil.com.cn>

On Mon, Aug 03, 2026 at 03:32:12AM +0000, Javen wrote:
> >
> >> +static void rtl_mac_link_up(struct phylink_config *config, struct phy_device
> >*phydev,
> >> +                         unsigned int mode, phy_interface_t interface,
> >> +                         int speed, int duplex, bool tx_pause, bool
> >> +rx_pause) {
> >> +     struct rtl8169_private *tp = container_of(config, struct rtl8169_private,
> >phylink_config);
> >> +     struct device *d = tp_to_dev(tp);
> >> +
> >> +     tp->speed = speed;
> >> +     rtl_link_chg_patch(tp, speed);
> >> +
> >> +     pm_request_resume(d);
> >
> >This does nothing with rx_pause and tx_pause. How is the MAC getting
> >configured for flow control?
> 
> To actually generate pause frames, the MAC needs Rx FIFO "Near Full" and "Near Empty" thresholds. The driver configures these statically during hardware initialization (rtl_hw_start_xxx) by writing to ERI registers 0xCC (RFIFONFULL_TH) and 0xD0 (RFIFOEMPTY_TH) via rtl8168g_set_pause_thresholds().
> 
> Software enables/disables flow control by setting the Local PHY registers phy_set_asym_pause(). After auto-negotiation with the Link Partner, the PHY resolves the flow control capabilities. Once the link is up and flow control is negotiated, the integrated Realtek MAC hardware automatically reads the PHY result.
> 
> Therefore, we don't need to do anything with tx_pause and rx_pause in mac_link_up.

Yes you do.

ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]

Pause configuration falls into three major categories:

1: The link is negotiated, and pause is negotiated
2: The link is negotiated, but pause is forced. ethtool -A autoneg off ...
3: The link is forced, ethtool -s autoneg off, and pause is forced, ethtool -A netneg off ...

The PHY registers only tell you about 1:. phylink mac_link_up tells
you the right thing to do for all three.

    Andrew
