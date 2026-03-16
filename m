Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21F3921E3;
	Mon, 16 Mar 2026 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666884; cv=none; b=WG4pcBi1DnwI5Ze6+Vvn8qvHPrMQYeZkVS4jM474D51bnncOfLrT3GzO/mmqoYgPxtg4iTTZQ0bvWYmCGqisEoaW2e/NOetR8vZwlt7rAk895K/eaUZuNqHcorIDxq7T9VFvzdrsAMlSDc3N/3lyBGlu885rParNcrWYcPzB1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666884; c=relaxed/simple;
	bh=78RR+1YAyd3rZnk8FtBG+NDDnBqU3GFDMhyZcVSWe6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnwwRM88jG5+eQaBsVlRvboTV6dz7piNUhYfdVFuWfyuVBcBOWuFf5S2ucP+EooD/QeQgVNl99/OTj0FUwScIuNnE89ZtjoB35vtAkujdM51tmgnp6FiFybXtLuwDrNN/+BPewCjcgyQpxLC/THHj/smfIq6StAhd+HMXv3VKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LrceKKVu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LrceKKVu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DrTshH/5XD1DwX0wXvoMVhK/9Oqc9g5Mye/0IL4m/yc=; b=LrceKKVuKrubslp3vHydqm6i8p
	1P/v3Oa8Q70B1SvOBLekVnJBGKwzboYjMm65GO1N8LbHLkTrHDxlIqTxWhYzAZC7USrdTq23QSJmd
	Anu27vbAtIhVhlhVj/66jIN85OLJxGQOYlQdq3bxAH3G9FgNvqQxMZLL7rOuYF9dg6/x+bIRU4YHf
	SBrRwvdtGH+99ATjmbpGfp8RWWY24FnGRXQSzbt9KnquOnBd9sAX/wtqTKyoggQyXME6KXdK4aOgq
	ltezR7567RM5hY3G/yphScuJYe3ra0DOffk7WbdaEdfUpLx1CrfISHdHLDSb2UK/76cU/lRiRp5kY
	A0T88G9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44540)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w27mB-000000003pQ-1oCh;
	Mon, 16 Mar 2026 13:14:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w27m8-0000000056Y-1GC9;
	Mon, 16 Mar 2026 13:14:28 +0000
Date: Mon, 16 Mar 2026 13:14:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christophe ROULLIER <christophe.roullier@foss.st.com>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	antonio.borneo@foss.st.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: stmmac: fix pinctrl management during
 suspend/resume
Message-ID: <abgCNFIiX6In3baa@shell.armlinux.org.uk>
References: <20260313105718.359614-1-christophe.roullier@foss.st.com>
 <20260313105718.359614-2-christophe.roullier@foss.st.com>
 <abPwHh12MLwMwOIs@shell.armlinux.org.uk>
 <CAD++jLmBP5Puwf1ZuFOzF6U0XowoF1nfqEL3gwLy-svXsXrbJA@mail.gmail.com>
 <abStv0IPLfkKMD-W@shell.armlinux.org.uk>
 <abfHUrOpHnjv3GGW@shell.armlinux.org.uk>
 <4de50fb9-35e6-48e7-8111-c5a94099d4f7@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4de50fb9-35e6-48e7-8111-c5a94099d4f7@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 16, 2026 at 11:01:02AM +0100, Christophe ROULLIER wrote:
> Hi Russell, Linus, All,
> 
> Le 16/03/2026 à 10:03, Russell King (Oracle) a écrit :
> > On Sat, Mar 14, 2026 at 12:37:19AM +0000, Russell King (Oracle) wrote:
> > > On Sat, Mar 14, 2026 at 12:44:56AM +0100, Linus Walleij wrote:
> > > > On Fri, Mar 13, 2026 at 12:08 PM Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > > On Fri, Mar 13, 2026 at 11:57:16AM +0100, Christophe Roullier wrote:
> > > > > > In the deepest low-power modes, the pinctrl configuration is lost
> > > > > > and is never restored if the interface is down.
> > > > > > This commit ensures that the pinctrl state is set in all cases.
> > > > > Shouldn't the pin state be restored by the pinctrl layer?
> > > > What we have in the device core only applies "init" and "default"
> > > > states, and provides these handles for transitioning to "sleep"
> > > > and "default" again (like a state machine).
> > > What I was meaning is that - for a driver using the "default" state,
> > > if the hardware loses the pinctrl state during sleep, isn't it the
> > > responsibility of the pinctrl driver to restore the state rather
> > > than leaving it in whatever states it happens to be when the SoC
> > > comes back from suspend?
> > > 
> > > If that is not the case, then don't we have a major issue where
> > > drivers using pinctrl but do not issue any pinctrl calls in the
> > > resume function are buggy?
> > I would like an answer on this before this patch is merged, because
> > even with your reviewed-by, I don't think this patch is correct.
> > 
> > For example, if pinctrl loses the pinmux state across suspend/resume,
> > then this patch only solves the case where the NIC is down when
> > suspending.
> > 
> > It does not address the case where the NIC is up but WoL is disabled.
> > Also, what happens when WoL is enabled at the MAC, when we expect the
> > NIC to still be functional - which means that the pinmux state must
> > remain active over suspend.
> 
> For me this case (when NIC is up) is already managed by the driver and
> function suspend/resume:
> 
> On stmmac_suspend :
> 
> ==>      /* Enable Power down mode by programming the PMT regs */
>      if (priv->wolopts) {
>          stmmac_pmt(priv, priv->hw, priv->wolopts);
>          priv->irq_wake = 1;
>      } else {
>          stmmac_mac_set(priv, priv->ioaddr, false);
> *         pinctrl_pm_select_sleep_state(priv->device);*
>      }
> 
> On stmmac_resume :
> 
> ==>     if (priv->wolopts) {
>          mutex_lock(&priv->lock);
>          stmmac_pmt(priv, priv->hw, 0);
>          mutex_unlock(&priv->lock);
>          priv->irq_wake = 0;
>      } else {
> *         pinctrl_pm_select_default_state(priv->device);*
>          /* reset the phy so that it's ready */
>          if (priv->mii)
>              stmmac_mdio_reset(priv->mii);
>      }
> 

I don't know if there's a difference between your two seperate replies
that appear to be saying the same thing.

I also didn't realise that we're already changing the pinctrl state
on suspend/resume when the interface is up - thanks for pointing that
out.

I think it may be better to move the pinctrl changes after the
priv->plat->suspend() call:

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 428b2e5bb4c4..596f9e2349cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8174,6 +8174,7 @@ int stmmac_suspend(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	u8 chan;
+	int ret;
 
 	if (!ndev || !netif_running(ndev))
 		goto suspend_bsp;
@@ -8203,7 +8204,6 @@ int stmmac_suspend(struct device *dev)
 		priv->irq_wake = 1;
 	} else {
 		stmmac_mac_set(priv, priv->ioaddr, false);
-		pinctrl_pm_select_sleep_state(priv->device);
 	}
 
 	mutex_unlock(&priv->lock);
@@ -8225,8 +8225,14 @@ int stmmac_suspend(struct device *dev)
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
 suspend_bsp:
-	if (priv->plat->suspend)
-		return priv->plat->suspend(dev, priv->plat->bsp_priv);
+	if (priv->plat->suspend) {
+		ret = priv->plat->suspend(dev, priv->plat->bsp_priv);
+		if (ret)
+			return ret;
+	}
+
+	if (!priv->wolopts)
+		pinctrl_pm_select_sleep_state(priv->device);
 
 	return 0;
 }
@@ -8280,6 +8286,9 @@ int stmmac_resume(struct device *dev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	int ret;
 
+	if (!priv->wolopts)
+		pinctrl_pm_select_default_state(priv->device);
+
 	if (priv->plat->resume) {
 		ret = priv->plat->resume(dev, priv->plat->bsp_priv);
 		if (ret)
@@ -8301,7 +8310,6 @@ int stmmac_resume(struct device *dev)
 		mutex_unlock(&priv->lock);
 		priv->irq_wake = 0;
 	} else {
-		pinctrl_pm_select_default_state(priv->device);
 		/* reset the phy so that it's ready */
 		if (priv->mii)
 			stmmac_mdio_reset(priv->mii);

This means that we don't switch the pinctrl state until we've finished
suspending the device as necessary, which seems way more sane than
trying to do it part-way through suspending - for example, while
phylink and phylib is still active.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
