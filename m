Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F235F8D9
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532135; cv=none; b=IuZhz341UiSKXOyfpQrnKAs4/wGWdG59Pgp2sqboRUeNYSseLBS0jS7QTqwco/k3jovUg64IeeMFbfIzAqICu+iX6FUU7DgzVJgWQTZPqAvC+P1j7oSJnCrBLPkLTrPj2xu0gsydW5spXquVcTlaVR6UUti3LNipVkGWdzwia/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532135; c=relaxed/simple;
	bh=j8sp3QGf37nbleyw/RaqEW95/cl3flELdEcXdYOW2bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNXxumxt+IwipXefazHax7smZDXM4J1CwoFvoBxfkN1p6WMVr6TyCmaET0ycxARECiIWOzUAQcQUIdB5L877omI85BT13ylZVPpaCQN3KmCsrrlUy+/h2x0aEfgZ3pnOGgTl/mnp1NKuHujyWT9UB48nkwFnuCJvO9nC0acecAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KbPTUWlI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KbPTUWlI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fZVjX9lX2Ban4DpR6ZQBha73OP/uBEs+HGE3uJob2G0=; b=KbPTUWlI0Ai/lnyJd5LQFXag5m
	RPxut20xgoSUWjrx2WhAzD6ZzGXmTjpWdr2zJRAWDtZLKLY4HV0vLac7PseH5dhhgUPlazoy607r9
	l31Hve4O6cud7incPWsHHM7QQEV+s+VBKvLsDV6geL4aRmuhy28BeX6GdpIbRt7E5eurdqwyn2p7y
	4JVDfAg0xj+DPo4zW7HmgBgzd9RPre+ApnOYpFmMwXy8eQbZQf9Tee7fGfWavXzHBXMEthhcBxogV
	TmykISJ0fW9b2cb8MvlJAQmonT/RNBM6KgDQQzDj/izX92UboDEqEV25F60cUbDBM1A95ZM35YUA4
	CooobalQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57802)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkm8m-000000006R4-0j8w;
	Tue, 27 Jan 2026 16:42:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkm8j-0000000064K-1Vtw;
	Tue, 27 Jan 2026 16:42:05 +0000
Date: Tue, 27 Jan 2026 16:42:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-stm32@st-md-mailman.stormreply.com, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	pabeni@redhat.com, linux-rockchip@lists.infradead.org,
	heiko@sntech.de, alexandre.torgue@foss.st.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [net-next,v2,06/22] net: stmmac: rk: add SoC specific ->init()
 method
Message-ID: <aXjq3VisP4XjWYSi@shell.armlinux.org.uk>
References: <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
 <20260127004020.3785641-1-kuba@kernel.org>
 <aXgMIYPiL9JK-c_K@shell.armlinux.org.uk>
 <aXidBha0FahIS6Du@shell.armlinux.org.uk>
 <20260127081804.64841f65@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127081804.64841f65@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 27, 2026 at 08:18:04AM -0800, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 11:09:58 +0000 Russell King (Oracle) wrote:
> > > > If ops->init() fails here, does bsp_priv->phy_reset need to be released?
> > > > 
> > > > Earlier in rk_gmac_setup(), at line 1610, the code calls:
> > > > 
> > > >     bsp_priv->phy_reset = of_reset_control_get(plat->phy_node, NULL);
> > > > 
> > > > of_reset_control_get() is not a devm-managed function, so the reset control
> > > > would need to be explicitly released with reset_control_put() on error paths.
> > > > 
> > > > This new error return happens after phy_reset could have been acquired (when
> > > > the device has an integrated PHY), but before the function successfully
> > > > returns. If this path is taken, it appears the reset control would be leaked.
> > > > 
> > > > Currently no SoC sets ops->init so this path cannot trigger, but when a
> > > > future SoC implements this callback, the leak would occur on init failure
> > > > for devices with integrated PHYs.  
> > > 
> > > However, the driver does not release this resource when cleaning up, so
> > > that's already a bug as the driver currently stands. I think this could
> > > be converted to devm_reset_control_get(), which would resolve both
> > > leakages, but not sure.  
> > 
> > Note that fixing this is going to add yet another patch to the series,
> > because this is a pre-existing bug in the driver. It can't be replaced
> > with devm_reset_control_get(), because this driver is getting resources
> > for a foreign device (we don't have the struct device pointer.)
> > 
> > So, it isn't going to be a simple patch to fix this.
> 
> Would it work to make that plus patches 1-4,6 a separate series?

The problem I have with that is the proximity of the merge window, and
the likelyhood of conflicting changes making the _entire_ series very
very very painful, because it changes all the individual SoC support.

If I'm going to have to split it up just for the sake of reducing the
cost of AI review, can I ask for a moritorium on other development
changes to dwmac-rk until this is merged?

As I see it, this is required _because_ of the introduction of AI
review, not because something has actually changed. You have said in
the past to me that the 15 patch limit is only advisory and can be
exceeded where it makes sense to, and for this series, it does make
sense.

Note that fixing _this_ problem has added yet another patch to the
series, as fixing the underlying issue (the lack of release of
bsp_priv->phy_reset on remove) is a separate issue. I've not yet
decided whether that needs to be submitted via the net tree or not,
which will further complicate the submission of this series if it
the fix needs to go through the net tree.


Author: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

    net: stmmac: rk: fix missing reset_control_put()

    rk_gmac_setup() delves into the PHY's DT node to retrieve its reset
    control using of_reset_control_get(). However, it never releases it
    when the driver is removed. Add reset_control_put() to rk_gmac_exit()
    to clean this up.

    Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethern
et/stmicro/stmmac/dwmac-rk.c
index 0e66252eb5ae..2237b09b50bb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1779,6 +1779,8 @@ static void rk_gmac_exit(struct device *dev, void *bsp_pri
v_)

        if (priv->plat->phy_node && bsp_priv->integrated_phy)
                clk_put(bsp_priv->clk_phy);
+
+       reset_control_put(bsp_priv->phy_reset);
 }

 static int rk_gmac_probe(struct platform_device *pdev)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
