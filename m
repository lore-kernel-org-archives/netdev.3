Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247770;
	b=wccbdMlBGuAKkxPoQPxEUGgp7nt8i/TxB/8tFZnYl/D70FCLdkbQNRit8CZ996EHyBiE
	 19hBcDuHMwcz+1mQ0eZC/J8ia6wDGFgz0rTr/dTVHKk9qu1m5cWu5yIeIdzPO7obK4ft/
	 +ariB92wDxy6vFKbMLxLMdPm7BgrdF1Rd796E6bIyuBffc4bQWvdXTTtnK10gve8uiq+F
	 MtBAlb/mtwJ8+TohZoi+bLjdu+uQHL4q7BkNRCx1h+8bbNiI5slN0sqvoNGOzZPFlgBzN
	 wiyw2QJ21jsx2l33BXTmi5YUyD6gx6dbIqCK3RNjsH0JzQz9ufy1RKdj1MyFmhqgzHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247770;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=AhgYO2YTCGyPJ2/VNeCXL72x5NvLo0XiOft6lPOJ+wc=;
	b=qiZdXhkL0hNP0+AwNQj05LF17yuLl5aVo0RJX1bD3k/HsuwtDSmkgiHiCSJvGYl8j7/c
	 5N97SrHyS1JYbgixRoJ+Bp3DCOl7Yf6fVxV1OIyFgibZFVz1hR0X+i3JoRB3aLpup5By1
	 Et1Xz/7iYhjbmyA4BMFJqxrYZgmh2eLGStAYTj3cLn/+aGwXb+J4PNpAev1Ej8ih8VVYF
	 CQE0LuP8VPFEOpbxcOPxxOjSK4DjgF2Nstdhd+Ocyn1wwTiKiCiDaizGgkK4IoBwu5kA6
	 24PTr3stFNSB7W5K9y0pedLqfF/pcF3Gp6ooa2+kg3qRn/au9nwe5dv2qhc71ZOTDzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=S26Y0hDn;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8185606A325;
	Mon,  9 Nov 2026 18:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8185606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=S26Y0hDn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AhgYO2YTCGyPJ2/VNeCXL72x5NvLo0XiOft6lPOJ+wc=; b=S26Y0hDniOtgxnpW1kUYp4W0vT
	c9RLXpQOH43vlorWGxEAzJqqkeUJ1UZ6b7NN9B4SohaQtj0Wvof4Y6BXgRHhqGpdpfEFs2VsbnWpo
	KeNq+YAygRu8g0WKBJNb3G724vGOiTOkJnKwgsAz0G/OiVKv7a7RISKeORXtrNAD/azE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQTnw-00FJvg-Ci; Mon, 09 Nov 2026 19:09:16 +0100
Date: Mon, 9 Nov 2026 19:09:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: c45: select BASE-T1 type for the forced
 speed
Message-ID: <c6a48ee3-6de5-4289-acd2-35e5ca140d55@lunn.ch>
References: <20261109144837.738619-1-iustin.stolniceanu@analog.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109144837.738619-1-iustin.stolniceanu@analog.com>

> +/* Type selection value for the BASE-T1 PMA/PMD control register (1.2100,
> + * 802.3-2022 Table 45-178) matching the forced speed. 10 Mbit/s is ambiguous
> + * between 10BASE-T1L and 10BASE-T1S, so the supported link modes decide.
> + * 2.5G, 5G and 10GBASE-T1 are not handled as there are no link modes for them
> + * yet.
> + */
> +static int genphy_c45_baset1_type_sel(struct phy_device *phydev)
> +{
> +	switch (phydev->speed) {
> +	case SPEED_100:
> +		return MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_100BT1;
> +	case SPEED_1000:
> +		return MDIO_PMA_PMD_BT1_CTRL_TYPE_SEL_1000BT1;
> +	case SPEED_10:
> +		if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,

Overall, this looks good. A nitpick, please could you sort these by
speed. I can see why you put them in this order, 802.3 lists the bits
in this order. But many kernel developers don't seem to read 802.3
that closely.

With this changed, please add: Reviewed-by: Andrew Lunn
<andrew@lunn.ch>

    Andrew

---
pw-bot: cr
