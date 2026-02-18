Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990332548C;
	Wed, 18 Feb 2026 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404526; cv=none; b=YQOuhcwmWIHGtssvLPB0VMbIyJWgvXaVqDSK3drqADVm8s3nZ1PkAbVbvVIFMy0jwsyPhB+cuDmeGm70Uuif5eweYownEgG9lNtAHR8QwGn57RxWimO/xHc+Kq7NybG+Rt7isAbANbnAVfV7+EaG1Z/UMEs4AJ6BPSkGqKT/df0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404526; c=relaxed/simple;
	bh=VaJ8XrG53tmLgDHjE1Bc65rj33P8M5TTM7tKKbqMgrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULyJDIJ5CzBPBoYwzQPjMmdm+OdAYJKOQKy+LbGim774V4Yv2kivdhjrDUEImXe2Cst5Mhd59+P0fr/7Vbbvkjx6GI8AqgxRRQ3bWBY3zR8FO17v9YCMcDUC7xJT3Z6jcnrG03FVScWe3tHB9BlcDNyNS6Epjg4uU2prCebAjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x+57rdak; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x+57rdak"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g+7zpy8WveexkWP3a1zJEdoHkT/j637tD1fWPhFuCLY=; b=x+57rdakNzzgxDdVHb69WLTsxj
	UtamdmM7dJL2dorYYFY7wcpaD3P+4ZYJDSV1PBC/VRYQ9UtvYEXaw3LHjQIjrqLhrqam1dwTINQic
	0lp7qv9JseBabEwA10ZE2wwsCvfsuHMcqou2Ix8CZ5iwENLNZvZopmcjZKr79SoophgjbX69DA1+W
	SlfIJAKV6J9LkDIb68vVIXUgAUscURbyOlIy1fBh82yCQnS8IcyFHFFNWHRbWi8I2WKXn8+ryeVRs
	HcTqmjFx2zOpJZgzl9zoxxiJByq3aWwrCKJ+HuBWd1M9R+rkCycIxcBXP2tIBt34V2hzQeaGfaXFB
	Yf1BM2YA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48880)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vsdEW-000000008Ls-0C6v;
	Wed, 18 Feb 2026 08:48:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vsdEQ-0000000026q-3DPP;
	Wed, 18 Feb 2026 08:48:26 +0000
Date: Wed, 18 Feb 2026 08:48:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: stmmac: fix pinctrl management during
 suspend/resume
Message-ID: <aZV82iEs89PnSnXm@shell.armlinux.org.uk>
References: <20260218083618.67805-1-christophe.roullier@foss.st.com>
 <20260218083618.67805-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218083618.67805-2-christophe.roullier@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 18, 2026 at 09:36:16AM +0100, Christophe Roullier wrote:
> In the deepest low power modes the pinctrl are lost and never restored
> if the interface is down.
> This commit makes sure that pinctrl modes are set in all the cases.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index c63099a77cc0c..067b17f03cd09 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8133,6 +8133,8 @@ int stmmac_suspend(struct device *dev)
>  		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
>  
>  suspend_bsp:
> +	/* Select sleep pin state */
> +	pinctrl_pm_select_sleep_state(dev);

This is wrong. Look above, this, and you will notice that
pinctrl_pm_select_sleep_state() is called _conditionally_, depending
on whether the MAC is doing WoL or not. If WoL is enabled, the MAC
needs to stay functional, which means its pins need to stay properly
configured.

So, we can't unconditionally call this. I suggest moving this to:

-	if (!ndev || !netif_running(ndev)) {
+	if (!ndev || !netif_running(ndev)) {
+		/* Select sleep pin state */
+		pinctrl_pm_select_sleep_state(dev);
                goto suspend_bsp;
+	}

>  	if (priv->plat->suspend)
>  		return priv->plat->suspend(dev, priv->plat->bsp_priv);
>  
> @@ -8194,8 +8196,11 @@ int stmmac_resume(struct device *dev)
>  			return ret;
>  	}
>  
> -	if (!netif_running(ndev))
> +	if (!netif_running(ndev)) {
> +		/* Select default pin state */
> +		pinctrl_pm_select_default_state(priv->device);
>  		return 0;
> +	}

This looks fine to me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
