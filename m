Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE835966;
	Tue,  4 Aug 2026 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810661; cv=none; b=KEASycDxE+i86tqNBZZzkZe5+m3PRcbJKjdZlWFTY97plYd0D4gaSTm18+crBXO7rZLV9c1FIk8nlIRckT6N8Ppzq5CkBrK5YZFeswUna5SaIPhzJ43Nl/vp0QARcPINYG9YOgi4YU8vJrS/9vwY3pNOLMW0giwltX7v5Ws9/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810661; c=relaxed/simple;
	bh=EBSRCsqRpPjH1FhNhxroBQljLYJeRgEEsDY88A47lwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km5FeFxTiocl9u3jr27oWKvHAuTmEofdp42MrdFijkpGwuH0Z+wF8VLlgsRx4tzTggmLvU3J8+cSJ3yFbBJGGEATiYPitx4IMH50SgVOHJ/HmbTIOXyj7R0i+LmYzXR8yBvQrpbHmrcS0BtXZs/9LFubNo1av4pJqJC9403N+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R4HmSVjN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R4HmSVjN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WGmmMlNcON0+V+tmzkD5Tdw5YX+Qzu2QFd6T0TsZ0rc=; b=R4HmSVjNqTobnNn/RKZ0rEFHLn
	BT27jIUaY0Wg3pWLPmQ/wO4+PVQudnghrWpRCgWcuvpmRxTSuvtOn8NoDxqROa5nVKiXqRYn6dwus
	Px0hrLJfBoTZSN6jQc7Qs0YWumqRvprvKqGXt4CeTF+gJn9OQ13F0KlBVf3Zk1DXfJQI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr4vb-00FtYG-NS; Tue, 04 Aug 2026 04:30:51 +0200
Date: Tue, 4 Aug 2026 04:30:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/3] net: phy: add DAPU Telecom DAP8211R(I)
 Gigabit Ethernet PHY driver
Message-ID: <239a7699-bbda-4fab-bfa0-604b1d8806a9@lunn.ch>
References: <20260803101734.270821-1-a.shimko.dev@gmail.com>
 <20260803101734.270821-4-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803101734.270821-4-a.shimko.dev@gmail.com>

> +/* Initial RGMII RX delay per hardware specification: 0 * 150ps == 0.00ns */
> +#define DAP8211R_INITIAL_RX_DEL_VAL	0
> +/* Initial RGMII TX delay per hardware specification: 1 * 150ps == 0.15ns*/
> +#define DAP8211R_INITIAL_TX_DEL_VAL	1
> +/* Default RGMII delay: 13 * 150 == 1.95ns */
> +#define DAP8211R_DEFAULT_DEL_SEL	0xD


> +static int dap8211r_config_init(struct phy_device *phydev)
> +{
> +	u16 set = 0;
> +	int ret, val;
> +	s32 rx_internal_delay = DAP8211R_INITIAL_RX_DEL_VAL;
> +	s32 tx_internal_delay = DAP8211R_INITIAL_TX_DEL_VAL;
> +
> +	if (!phy_interface_is_rgmii(phydev))
> +		return 0;
> +
> +	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_TXID)
> +		rx_internal_delay = phy_get_internal_delay(phydev, dap8211r_internal_delay,
> +							   DAP8211R_DELAY_SIZE, true);
> +
> +	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_RXID)
> +		tx_internal_delay = phy_get_internal_delay(phydev, dap8211r_internal_delay,
> +							   DAP8211R_DELAY_SIZE, false);
> +
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		if (rx_internal_delay < 0)
> +			rx_internal_delay = DAP8211R_INITIAL_RX_DEL_VAL;
> +
> +		if (tx_internal_delay < 0)
> +			tx_internal_delay = DAP8211R_INITIAL_TX_DEL_VAL;
> +		break;

Why 0.00 for one and 0.15ns for the other? PHY_INTERFACE_MODE_RGMII
means no delays.

	Andrew
