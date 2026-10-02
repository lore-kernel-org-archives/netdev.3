Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6904398F5;
	Fri,  2 Oct 2026 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926683; cv=pass; b=U33744G/LM/8O/GGxWqrskvlBNP5nTB/XcA3Zx3MysZalokjWfHvInP2WgECIBRHwYnanHHEpPmVswgiqI9uFyLIQuBFcYUhg/dx0ivinC6z0mlQ0r4+HCYM4QUc8XSFZJOgQ7snzKKW0lbpAJ/dlsjIv7Zz4VvlXSmL7T65S40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926683; c=relaxed/simple;
	bh=oYlQ21R4HQlx3vVK0kr8E8QTtj8C3t8fpkgT41RyBPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T89YKUTE2zqbWzCautmIXV+p11c4vpG30jT01eHwAEKw02ApG6fbgLopAoJ/m56RtQTZiY5aA0mr1RkJs4quIFLSkAWpKQoicXdl6SfDfmQ/8QtBasEDgWw2fTAGzjwmxPwZ5mzmZyMyp3aX7lmgHgJuNKuM9xGpk6u1AF4opVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=LuXWrZqB; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="LuXWrZqB"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 144F5201C7E;
	Fri, 02 Oct 2026 09:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790926677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ioPGJibz7gaYFz5Z6bnx7RTmBLJohx6gGPI543XIhYs=;
	b=LuXWrZqBZ088UzvwjEBBEJavVSr52TfqHbcU0eMIhcVtOL3FDNSmyTgQ1VInImrgt+F/8/
	PndRygh1A8fWfhSzjWesIWBvEaFlp6HYKYX6wgAREkzUQeuZnFiIEdM7prFfrffdgaZamC
	FlVCqO9oaD0lXqZeme5iGCQXBMVM90QJbCOfmsGJt7UF9y+yVWgOOchJjtCLBrFx3m5w4p
	pWHWypOyl80CmMu3+/NoY4iDQ7DHuIQoD7+oHfPILhIwxsD7rDVwDIqAZ/G7ge3CBJGwQH
	EMkSL46h7Fp/CckSnTpIHideS1RoPjc9m2foAqn2ENiNCQhqjjtckSAfgk6tPg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790926677; a=rsa-sha256;
	cv=none;
	b=d3BKUpRyZadCo2T5P/Bn5nZWFPfRWuzoiw+NE671pZelAKQsGFWTN5BjneuBMI0981o/+m
	OlWrjiJ6okLOyN+BUpy1hE8sfL7xWPz0Z1wlAbTA5a9zBHsE4xHQoqUuDJfDQh4rlDE2/1
	6BV6XBsJDyXFHk/fxRxL1x5XK1dDGIVgv7KQNCvre9Pz1/sS53iX/Ski4ayrH4Rx+9nxAt
	2Ep6GYzYE6X4BS65XEpjZ0re60MXIumuUsNJs9CGlwI7EPGcwQki5uf1FKiLLaB36PtMra
	YxpsrUTyMRwMM+ciJTPvgQgpn9HwWJA4RovvBSitHJ89+dR8VuBM3V1SWHR0Cg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790926677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ioPGJibz7gaYFz5Z6bnx7RTmBLJohx6gGPI543XIhYs=;
	b=QAnLDb5eFGCrgnCI8qpbNAq0fum/wvEfE+pG+9XwN+5NR/pNrYBi8x1/GAKwTzGfBP9xSl
	pQPezcdW9bzqU/JXGN2sxm5Rbg9iD4pJZ30W8i7oxwtoQnMc+6B2Aag6UNu0ID0LPpaZdk
	zZS8CJOc/jmOeWluzfsSeoZZqIB1GaGYyZunf/sSBFbzqU0MZPyBFws/3ocEU91bh1dKWr
	7KYk//6INrH96zlR6hEFT+/kPSOz1Br4wMQqyrk7/du8UScH1NUk+CQi4lUOUkR8E5RN1U
	167MZXMzLwViZOc6wOQxjHHLO4Uc9uoLRILG6IdDaVmZ9aifVdk6ItCdfv4BKA==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xCXq9-003r9X-00;
	Fri, 02 Oct 2026 09:37:57 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xCXq8-000000079hr-3kgU;
	Fri, 02 Oct 2026 09:37:56 +0200
Date: Fri, 2 Oct 2026 09:37:56 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Javen Xu <javen_xu@realsil.com.cn>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <ar9fVCfceZG7Nz3l@pengutronix.de>
References: <ar5vAxEqS8tO8aVT@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar5vAxEqS8tO8aVT@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Javen,

On Thu, Oct 01, 2026 at 03:32:35PM +0100, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   drivers/net/ethernet/realtek/r8169_main.c
> 
> between commit:
> 
>   3cdeaef1754ab ("r8169: disable EEE on RTL8168h/8111h")
> 
> from the net tree and commit:
> 
>   8a3c76523e449 ("r8169: add support for phylink")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc drivers/net/ethernet/realtek/r8169_main.c
> index ee1bc9bd04470,1d06ddff98327..0000000000000
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@@ -5474,22 -5619,6 +5619,12 @@@ static int r8169_mdio_register(struct r
>   		return -EUNATCH;
>   	}
>   
> - 	tp->phydev->mac_managed_pm = true;
> - 	if (rtl_supports_eee(tp))
> - 		phy_support_eee(tp->phydev);
> - 	phy_support_asym_pause(tp->phydev);
> - 
> - 	/* mimic behavior of r8125/r8126 vendor drivers */
> - 	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
> - 		phy_disable_eee_mode(tp->phydev,
> - 				     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
> - 
>  +	/* Keep EEE off but the version stays EEE-capable so that link-up
>  +	 * still clears the MAC TX-LPI bits.
>  +	 */
>  +	if (tp->mac_version == RTL_GIGA_MAC_VER_46)
>  +		phy_disable_eee(tp->phydev);
>  +
>   	/* PHY will be woken up in rtl_open() */
>   	phy_suspend(tp->phydev);

I guess this quirk should be folded in to rtl8169_get_lpi_caps() or
rtl_supports_eee(). Can you please take a look at it? I do not have
access to any stand alone realtek MACs.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
