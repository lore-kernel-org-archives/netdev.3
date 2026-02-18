Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79D32BF22;
	Wed, 18 Feb 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404927; cv=none; b=QguCec/BMThO4kPsXgw2+ZwhvHZifXKpa0gCFR5n++RTFFGChALcj1Cp6gDgvqLEcbaKbflbSEpNRhiDOv9uMomDRnevWIkle3ssWPyXtH1Fd+0AhYgolUHgCY4vq/N8yiDGZOsl50AJtdx1LGUPBQ5hqwY81E8yoJg0sGQyIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404927; c=relaxed/simple;
	bh=7eK6pxXXLmLp6nECjfaryuhoAENDOnpDrucnrk7M0VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkMjdKo6qIdvmVGsQFWwxs24r+WWo5x6/s23MSq6c5BpNeDGE7BGOlA75ziVwcQCM/RK0N1J2aZBh/6AciOeExA5rjzqIlBkvRzhjWUIQCGU5k6k0CcpLeprKy5AmeX9y3W1dJ0f+4F/pZtXkvCahvzG7UDb46xBaGRL4Kw95N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v474WJyg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v474WJyg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HNiml1fPOFHSDNSX5TbGB94poy4lCrg+gQJDPIQHDZk=; b=v474WJygVfbum/Tr2SmpOSwNnM
	ind4ll1vgxaTYpEaV+Ui0Z6TjzgUC+ZNQv47MOAyzt+wfHlnOlP+MtUyBizqlU9RvDEqfljJoKe+/
	agrajN4fc2lWs+tPPxPShkMETDQWMJXNWBirhLXK9hE5meefnGGnH7MznCEUlNOnd3g5GgV3O/YUD
	osNK2JQEgeo0ozA43GEzWB90grbWJ0W1JGWrkJzYNpwhWKf55LWkMBuK73SqmDucjqEoTwcOYngxO
	aBp7tobs0OOlnGaXy1ifdn1ZSa76x0656VVNDPU/HHB/IjyFpBqTp318/vSUMwBK8xF+vhXYGvHDu
	tY09byBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35660)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vsdL2-000000008Mi-1YYB;
	Wed, 18 Feb 2026 08:55:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vsdKx-0000000027A-40OQ;
	Wed, 18 Feb 2026 08:55:11 +0000
Date: Wed, 18 Feb 2026 08:55:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christophe Roullier <christophe.roullier@foss.st.com>,
	Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: stmmac: restore pinctrl when driver remove.
Message-ID: <aZV-b6TdLMdI8dm4@shell.armlinux.org.uk>
References: <20260218083618.67805-1-christophe.roullier@foss.st.com>
 <20260218083618.67805-3-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218083618.67805-3-christophe.roullier@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 18, 2026 at 09:36:17AM +0100, Christophe Roullier wrote:
> when system suspend or unbind, need to set pins
> to low power state to save IO power consumption.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 067b17f03cd09..3d4f0e4cb53fb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8071,6 +8071,9 @@ void stmmac_dvr_remove(struct device *dev)
>  	mutex_destroy(&priv->lock);
>  	bitmap_free(priv->af_xdp_zc_qps);
>  
> +	/* Select sleep pin state */
> +	pinctrl_pm_select_sleep_state(dev);
> +

I'm not convinced this is correct, there's nothing to match it in the
probe function, except what the driver model core does. However, the
driver model core also doesn't clean up the state if probe fails.

Adding LinusW for comment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
