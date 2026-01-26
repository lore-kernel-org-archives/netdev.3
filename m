Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7533E35D;
	Mon, 26 Jan 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769441651; cv=none; b=MMkpeJ1wfFtMs+fr2k82VSeT8w0/Z5xtRWCWOn2RkLhQewJGx4AryAFAOwW+JK4qoQsU5ej167So6r6US9VtHVr2H7kIg1R53fdmi6oVkC3bf2nDpye6AtMzhzcyY39GSHoT9+E5xbsONW9MPvtA+u72Knp3kn4ITnTPUa8ags4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769441651; c=relaxed/simple;
	bh=c4zIUaVR/lkn9ej0uJMksg0BObX0gJEu8Pk9DSo/GgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuGCmoQi/4GOEUoRQC2SPiDSd9egBF1kBp5g8pHFa7WhoB6kwsyxhSbOFamguC1Hy0VEjBp+4poY00a0UK19dqFwaLTzzqtMoKNp6AWCCqxhopqNeRQHpd+53V1hqmyQVbTJknmFCJIXmF1loS6lDbp1qDpzi7ybTvfpXWlgAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PVSXX3pa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PVSXX3pa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eae6B3pYhJ65yiJ/woVw/sITqVU+XQC0UckLLwclRkM=; b=PVSXX3paoP2wq8qCHoHUZWhYIi
	dqkW3/AGt5t0PjIhJjxoPF0ZRs/xbuaZu/ZFrL1mXcQhocrCS0ZakfIFYnjtaq2nylaFQeC6qGPZX
	jzLRSTfuqZSpz4sXdVekpqz2JckScisybCNTXK79Vt4gJgOSOF8x/96DmjN3NXynVHudSQhJD+dEn
	cL7XXmLLXnqxnoRcY15Lqrn+B1qRv/e9GfCkl0nusIb0doBZRmBOxEes7qBffEXjPleMKNYn2dKj/
	rhXiCC4uttqL/6NFsuQeNlXBUfAUfbOeeGmOp8aPbe2610SqOXXhYp55nRKb1YjbEtuENctuIIhFE
	6bvIprsA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54392)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkObG-0000000051g-3n3m;
	Mon, 26 Jan 2026 15:33:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkObC-00000000530-35q3;
	Mon, 26 Jan 2026 15:33:54 +0000
Date: Mon, 26 Jan 2026 15:33:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: dan.carpenter@linaro.org, robh@kernel.org, kuba@kernel.org,
	festevam@gmail.com, ghennadi.procopciuc@oss.nxp.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, shawnguo@kernel.org, mbrugger@suse.com,
	mcoquelin.stm32@gmail.com, linaro-s32@linaro.org,
	davem@davemloft.net, s.hauer@pengutronix.de, edumazet@google.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	conor+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
	Frank.li@nxp.com, chester62515@gmail.com, netdev@vger.kernel.org,
	kernel@pengutronix.de, pabeni@redhat.com, jan.petrous@oss.nxp.com,
	linux-stm32@st-md-mailman.stormreply.com, s32@nxp.com
Subject: Re: [v4,1/3] net: stmmac: s32: use a syscon for
 S32_PHY_INTF_SEL_RGMII
Message-ID: <aXeJYo-0iiNuXVGH@shell.armlinux.org.uk>
References: <8f2139e8adf02b485a4c84d558fc23f78cf04add.1769195864.git.dan.carpenter@linaro.org>
 <20260126152430.1390514-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126152430.1390514-1-horms@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 26, 2026 at 03:24:30PM +0000, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
>     net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
> 
> This commit adds syscon/regmap support for accessing the GMAC_0_CTRL_STS
> register on s32 chipsets, while maintaining backwards compatibility with
> the existing direct MMIO approach for older device trees.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > index 5a485ee98fa7..2e6bb41f49e1 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> 
> [ ... ]
> 
> > @@ -40,7 +44,10 @@ struct s32_priv_data {
> >
> >  static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
> >  {
> > -	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> > +	if (gmac->ctrl_sts)
> > +		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> > +	else
> > +		regmap_write(gmac->sts_regmap, gmac->sts_offset, S32_PHY_INTF_SEL_RGMII);
> 
> Should the regmap_write() return value be checked here? The function
> returns int and the caller s32_gmac_init() checks the return value
> expecting errors to be propagated. For comparison, dwmac-sun55i.c in
> sun55i_gmac200_set_syscon() does check regmap_write() return value:
> 
>     ret = regmap_write(regmap, SYSCON_REG, reg);
>     if (ret < 0)
>         return dev_err_probe(dev, ret, "Failed to write to syscon\n");

AI is wrong on this last line - s32_gmac_write_phy_intf_select() is
called from s32_gmac_init(), which is called from plat_dat->init.

plat_dat->init is called from two paths:

1. stmmac_pltfr_probe() -> stmmac_dvr_probe() -> plat_dat->init()

2. stmmac_resume() -> plat_dat->resume() -> stmmac_plat_resume() ->
   stmmac_pltfr_init() -> plat_dat->init()

In the resume path, it is not appropriate to use dev_err_probe()
because we're not in the probe path.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
