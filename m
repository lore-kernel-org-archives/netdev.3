Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314094A8A00
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366100; cv=none; b=KNKxUNAd73trkMGSoR1l91qkdjrvGY0DS393o6xgn9oPq1dsnwFl5t21Lbos08f6lcRPky1wKjyJO9Nms+kCUe4xB8XbDYdRZwlVfsXp13XCvr+f0rm1abzgx0r2o+1C4IxGSslQAeC9zayJJuOfaypzgEd/K6TM259Fh6oajCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366100; c=relaxed/simple;
	bh=y/khQQSGhRfHeUOqhYrGcOadyfzhUGoGZ9z7hJrow8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWjgJE0GvA2plyzAwhgSV9xPZC3gnaxVl4zioLDBGFjqCnEAtSpgRh4JBj/ZAvuiZE4VKr3CLt10F6p6FVAQwriICfeYh9YLibE6PbW3lGYYt5wcbJ3dSq/VpIrjbOEpMEs218UEJGhK6935E098zTqk9Q8V4svx/rp79NF+vb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4F5ZSNIB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4F5ZSNIB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XxAElav+z1tZfDJ0WrSKdM3ffkIpKM7YgcJCIWZcrGM=; b=4F5ZSNIBUMr4O99GM+4L0EEZJy
	JpcMM1qmhRhx/0Sd8tb+PMz3s9I7msH7O2AZA6+np50qijaiDBVe1F8GkDULZv9E0o+/ExjAk9lIZ
	No4WK1X3an/Eb8znFSwQLXiCy+W4uKl3gQ86jK7hXMS8Cw3kX7UoLxa1Tqo4hHCze7hY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1niQ-002YGw-Ud; Wed, 02 Sep 2026 18:21:34 +0200
Date: Wed, 2 Sep 2026 18:21:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>
Subject: Re: [PATCH] Add config phase for dp83td510e phy
Message-ID: <9ddbcd2d-297f-4159-9290-fd87b7fccbfb@lunn.ch>
References: <0d5badda1670a578b18fae293d8cdd7e57d4d01a.camel@sprinte.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d5badda1670a578b18fae293d8cdd7e57d4d01a.camel@sprinte.eu>

On Wed, Sep 02, 2026 at 03:52:58PM +0000, Julien Blanc wrote:
> Add a config phase for the Texas Instruments DP83TD510E ethenet PHY
> 
> The config phase currently sets the following properties from the
> device tree:
>   * RMII / RGMII mode (note : RMII master / slave can only be set
>     by straps and cannot be changed at runtime on this phy)
>   * RGMII delays. These delays can be enabled on the phy side, only
>     as a boolean. Delays are enabled if phy-mode is rgmii-id, or
>     rgmii-[rx|tx]id which enables only the corresponding delay.

> +static int dp83td510_config_init(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	int rgmii_delay = 0;
> +	s32 rx_int_delay;
> +	s32 tx_int_delay;
> +	int ret;
> +
> +	if (phy_interface_is_rgmii(phydev)) {
> +		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
> +						      true);
> +

If delays are simple on/off, you don't need this. Do something more
like mxl86110_config_rgmii_delay() which just look at
phydev->interface.

    Andrew

---
pw-bot: cr
