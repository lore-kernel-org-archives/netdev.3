Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C5345CB0
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367543; cv=none; b=mocKubMK/nlMozN8Nin1snw536ZZpVwGIl9lMI3aMaxaq69lGoS4gd7XyUm/U6sg4C4S25JlSRUKt9Lrrw9ES6E2qtY1irgB1XH71Ov84Hfk8Df4sY6GUzSXD3xbGo/2ZyZu8QI5WuN0IB6hijLO9UVJC/cgWXE9VdCwqeAg8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367543; c=relaxed/simple;
	bh=R8JWmMJtySLjZ3s4NOyy29qtw+4NgpQ8fBMz6ekmQnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1C7UyHTevDt3QhTCM1QFb1TFQ4Y/FJYLBD6PBB6wt9cG9iPFu2J6jMTjFIk7hAbeUop39v8b2cm1OUI/8DfkV4bc3uUpiDYcCsz9EWsKQN57WvD9BJV70a5KwbeGfxjVFQFbuLatJ71bxPyho18KJSsJATx82YgIkgjqMr9KmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Aoh/n+Oe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Aoh/n+Oe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=K6AgXLlDJnO7UTHXjUQnGbJVYMZwaMG9Gi599gyL8Lo=; b=Aoh/n+OeRrSMqmlWjUy64MMXce
	wTsg4D0Ih39hv2ucY2CeZLICJYBWWx2agY12GLifsYGidOsS1JlyaygPpabfa5ZowOY3gAv7yfBQ5
	f5/vjGo13yabfUMxNrNw8bT4sYUWtqihhZaNjhKb+pq35JKaEv/DUc3PfB30r6gC2UW4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w543A-00D7nm-M4; Tue, 24 Mar 2026 16:52:12 +0100
Date: Tue, 24 Mar 2026 16:52:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892
 support
Message-ID: <47745fde-3b2a-4a57-9d36-746dc02e6959@lunn.ch>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>

> +static bool bcm84881_is_bcm8489x(struct phy_device *phydev)
> +{
> +	/* For C45 PHYs, phydev->phy_id is 0; match via the driver entry's
> +	 * declared ID, which is what phy_bus_match() used to bind us.
> +	 */
> +	u32 id = phydev->drv->phy_id;
> +
> +	return (id & 0xfffffff0) == 0x35905080 ||
> +	       (id & 0xfffffff0) == 0x359050a0;

phy_id_compare_model(). 

> +/* BCM8489x speed LED control.
> + * Dev1:a83b bit 1 (0x0002) = green, bit 4 (0x0010) = amber.
> + * Dev1:a82f = 0x0020 gates amber on; green ignores the gate.
> + * Writes are best-effort (LED is cosmetic; this callback is void).
> + */
> +static void bcm84881_link_change_notify(struct phy_device *phydev)
> +{
> +	if (phydev->link) {
> +		/* 10G = green, else amber; matches vendor firmware */
> +		u16 color = (phydev->speed == SPEED_10000) ? 0x0002 : 0x0010;
> +
> +		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, BCM8489X_LED_GATE, 0x0020);
> +		phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, BCM8489X_LED_COLOR,
> +			       0x0012, color);
> +	} else {
> +		phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD,
> +				   BCM8489X_LED_COLOR, 0x0012);
> +	}
> +}

What are the capabilities of the LEDs?

This is going to cause problems in the future if somebody implements
proper control of the LEDs via /sys/class/leds and the netdev trigger.

> +	{
> +		.phy_id		= 0x35905081,
> +		.phy_id_mask	= 0xfffffff0,

PHY_ID_MATCH_MODEL()

> +		.name		= "Broadcom BCM84891",
> +		.inband_caps	= bcm84881_inband_caps,
> +		.config_init	= bcm84881_config_init,
> +		.probe		= bcm84881_probe,
> +		.get_features	= bcm84881_get_features,
> +		.config_aneg	= bcm84881_config_aneg,
> +		.aneg_done	= bcm84881_aneg_done,
> +		.read_status	= bcm84881_read_status,
> +		.link_change_notify = bcm84881_link_change_notify,
> +	},
> +	{
> +		.phy_id		= 0x359050a1,
> +		.phy_id_mask	= 0xfffffff0,

PHY_ID_MATCH_MODEL()


    Andrew

---
pw-bot: cr
