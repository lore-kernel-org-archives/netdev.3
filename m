Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526D3B1035;
	Wed, 23 Sep 2026 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197661; cv=none; b=N3N/SM5EmdsjugSB/ZDz8A/+xT5UmNMNpKVG+8ge2bdugPTgTcMotmXMup5MM869NosyIo4i7ys7SosnNgQnJqMszkRtap25xusOsaAWtnvUc+MogqLIpmd1UHe1C7O5xDKWITrnxR75tjtgeR52j9XaZfmofN7olnyUYN5Rrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197661; c=relaxed/simple;
	bh=nDb66uiiNFGhUUUjn7cgqgUZ6BcR1DbK/cnx6wM+Ddg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWB3fFrMD2EFbKToEohK2a0/Me82iSpw5vIzooeT4w9Bnz1ahXHCHAvUR5IY0T83UA0phrHA933YMXTjMjW8L8e3xXqBLDZ01Y3WpbtK/+icj0/y8HNbaNURjLYTp58IAr7pdRT2MdslXK1OvVxQVoB0H90eyUwqPGMohFazoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1PSiCHHK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1PSiCHHK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VN4aEgP2gtPnDMOkBg6ML8CWqWSGrENi4tEBE+0pcX0=; b=1PSiCHHKnnqbTphNVBv6328N+O
	+HgG9BNTHTFq+ANUXtZbSHjXXBuvQCvuiXz5qtQXOKboFrUh/otKYHKALwQd0vlUAd3Je3ZbnJksG
	c0/cV1ZDqAVdxFkOb4TdwzfOO8iBblUqXZsQ3fYoYUl/J/dfChYorj98sG/ylkqumWlk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9UBU-006sMU-PK; Wed, 23 Sep 2026 23:07:20 +0200
Date: Wed, 23 Sep 2026 23:07:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: marvell: add support for PHY LEDs
 polarity modes
Message-ID: <ac224909-5f7d-447e-a0f9-be0d1565a700@lunn.ch>
References: <20260923204614.471409-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923204614.471409-1-olek2@wp.pl>

On Wed, Sep 23, 2026 at 10:45:24PM +0200, Aleksander Jan Bajkowski wrote:
> Add the led_polarity_set callback for setting LED polarity. Implement
> this callback for the 88E1318 and 88E1510 PHYs. This should also work on
> other Marvell PHYs, but I don't have access to the TRM or the hardware.
> 
> Tested on Adapteva Paralella board with Marvell 88E1318 PHY.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
> Changes in v2:
>  - add suppoer for PHY_LED_INACTIVE_HIGH_IMPEDANCE mode
> ---
>  drivers/net/phy/marvell.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa88406..d57fcabfec2b 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -149,6 +149,9 @@
>  #define MII_88E1318S_PHY_LED_FUNC_ON		(0x9)
>  #define MII_88E1318S_PHY_LED_FUNC_HI_Z		(0xa)
>  #define MII_88E1318S_PHY_LED_FUNC_BLINK		(0xb)
> +#define MII_88E1318S_PHY_LED_POL		0x11
> +#define MII_88E1318S_PHY_LED_POL_ACT_HIGH(idx)	BIT(2 * (idx))
> +#define MII_88E1318S_PHY_LED_POL_HIGH_IMP(idx)	BIT(2 * (idx) + 1)
>  #define MII_88E1318S_PHY_LED_TCR		0x12
>  #define MII_88E1318S_PHY_LED_TCR_FORCE_INT	BIT(15)
>  #define MII_88E1318S_PHY_LED_TCR_INTn_ENABLE	BIT(7)
> @@ -304,6 +307,8 @@
>  #define NB_FIBER_STATS	1
>  #define NB_STAT_MAX	3
>  
> +#define M88E1318S_MAX_LEDS	3

Why the M88E1318S prefix?

The naming is a bit odd in this file, but maybe NB_MAX_LEDS?

    Andrew
