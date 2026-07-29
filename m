Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF92377AA7;
	Wed, 29 Jul 2026 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303025; cv=none; b=c3N2KeKHAPXrZzjH8ev+UwjselxGocZiUZAbjiRZUUko05fN4CghsAcesadoxJwi51Z9Wqc1u9Ye17UbsAzkarIbqqj4kNQG1bxdF5UAQo77Rij+b+NPQFlBzkzAd0syNxf15tiJkUI9+DTFBGsUE0kujJnC2RWTuwSnmjYf74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303025; c=relaxed/simple;
	bh=S74QlMw3en/WquuTyRzO+tx+XBm8tR9h48XkECLtBzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlHack0cf6wTHw7F95NUpIFfY1jZTmSpmsKJ5XB/3HbyOnXJAGZOPnlndtgZ+e4RIPLKVjtwm2hHt1Qo8IgMbR0Gl9E6sjdjx2qq6vSsP0koNG3ciDr/MyQWFZwU50xyWzJkayFs/o1I9DhEoBMO9/fOR1+gjORvSVi/ppSIkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B655F201D85;
	Wed, 29 Jul 2026 07:30:17 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wowrx-001pfo-26;
	Wed, 29 Jul 2026 07:30:17 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wowrx-0000000CL28-2Ar1;
	Wed, 29 Jul 2026 07:30:17 +0200
Date: Wed, 29 Jul 2026 07:30:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Zxyan Zhu <zxyan0222@gmail.com>, thomas.petazzoni@bootlin.com,
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 1/2] net: stmmac: Don't use PHY loopback for
 selftests
Message-ID: <ammP6SaJ44fzc5bW@pengutronix.de>
References: <20260728155728.1193169-1-maxime.chevallier@bootlin.com>
 <20260728155728.1193169-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728155728.1193169-2-maxime.chevallier@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Jul 28, 2026 at 05:57:26PM +0200, Maxime Chevallier wrote:
> Stmmac selftests validate the internal behaviour of the various IPs,
> using local loopback. The current logic is relies on PHY-side local
> loopback if a PHY is attached, with a fallback to MAC loopback
> otherwise.
> 
> However, PHY loopback is currently fragile especially for stmmac that
> may require RXC to be provided from the PHY. Some PHYs shutdown RXC
> while in loopback, while others will report carrier off when in local
> loopback. This also fails when using SFP setup with a module that embeds
> a PHY, that may also fail to enter loopback.
> 
> MAC loopback is done at the GMII level on dwmac, allowing the internal
> to be just as meaningful as PHY-loopback testing.
> 
> Let's simplify stmmac selftests by only relying on MAC-side local
> loopback, which makes the selftests runnable on a wider HW variety.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  .../stmicro/stmmac/stmmac_selftests.c         | 112 ++----------------
>  1 file changed, 9 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> index 29e824bd90ca..c0e5dee86451 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> @@ -374,25 +374,6 @@ static int stmmac_test_mac_loopback(struct stmmac_priv *priv)
>  	return __stmmac_test_loopback(priv, &attr);
>  }
>  
> -static int stmmac_test_phy_loopback(struct stmmac_priv *priv)
> -{
> -	struct stmmac_packet_attrs attr = { };
> -	int ret;
> -
> -	if (!priv->dev->phydev)
> -		return -EOPNOTSUPP;
> -
> -	ret = phy_loopback(priv->dev->phydev, true, 0);
> -	if (ret)
> -		return ret;
> -
> -	attr.dst = priv->dev->dev_addr;
> -	ret = __stmmac_test_loopback(priv, &attr);
> -
> -	phy_loopback(priv->dev->phydev, false, 0);
> -	return ret;
> -}
> -
>  static int stmmac_test_mmc(struct stmmac_priv *priv)
>  {
>  	struct stmmac_counters initial, final;
> @@ -1815,10 +1796,6 @@ static int stmmac_test_tbs(struct stmmac_priv *priv)
>  	return ret;
>  }
>  
> -#define STMMAC_LOOPBACK_NONE	0
> -#define STMMAC_LOOPBACK_MAC	1
> -#define STMMAC_LOOPBACK_PHY	2
> -
>  static const struct stmmac_test {
>  	char name[ETH_GSTRING_LEN];
>  	int lb;
> @@ -1826,131 +1803,96 @@ static const struct stmmac_test {
>  } stmmac_selftests[] = {
>  	{
>  		.name = "MAC Loopback               ",
> -		.lb = STMMAC_LOOPBACK_MAC,
>  		.fn = stmmac_test_mac_loopback,
> -	}, {
> -		.name = "PHY Loopback               ",
> -		.lb = STMMAC_LOOPBACK_NONE, /* Test will handle it */
> -		.fn = stmmac_test_phy_loopback,
>  	}, {
>  		.name = "MMC Counters               ",
> -		.lb = STMMAC_LOOPBACK_PHY,
>  		.fn = stmmac_test_mmc,
>  	}, {
>  		.name = "EEE                        ",
> -		.lb = STMMAC_LOOPBACK_PHY,
>  		.fn = stmmac_test_eee,

Hm, not sure this test can be properly executed in all conditions.
We do not support forced LPI mode from phylink perspective, and it is
not forced by the tests. If it passes, only by accident if link partner
local system and link partner advertise the EEE support. 

>  	}, {
>  		.name = "Hash Filter MC             ",
> -		.lb = STMMAC_LOOPBACK_PHY,
>  		.fn = stmmac_test_hfilt,
>  	}, {
>  		.name = "Perfect Filter UC          ",
> -		.lb = STMMAC_LOOPBACK_PHY,
>  		.fn = stmmac_test_pfilt,
>  	}, {
>  		.name = "MC Filter                  ",
> -		.lb = STMMAC_LOOPBACK_PHY,
>  		.fn = stmmac_test_mcfilt,
>  	}, {
>  		.name = "UC Filter                  ",
> -		.lb = STMMAC_LOOPBACK_PHY,
>  		.fn = stmmac_test_ucfilt,
>  	}, {
>  		.name = "Flow Control               ",
> -		.lb = STMMAC_LOOPBACK_PHY,
>  		.fn = stmmac_test_flowctrl,

Interesting test, it will be cool to have it in generic form. Probably
most of them, but it will be a lot of work.

So, yes - most of this tests do not relay on the PHY, instead - on some
kind of running link configuration. But this tests seems to not enforce
needed link configuration before and after patches - correct?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
