Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917EF54785;
	Fri, 25 Sep 2026 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301818; cv=none; b=pGJ2oAwt5HTw6GQMY0DsoBYjxbkqB/U9358nMPQBQq7Eh5Jjj1IZKbrI+Av5Ed5lpvC37SIIrCeUL9f8g20Q2cflGf3Zzgfvptl0CAM8SDLO/o6DCE6udEMqzob307qwicVWQrHFABCAtpR74KrMweSNNDQ76SKh7byFMS6U1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301818; c=relaxed/simple;
	bh=N/PSO4fYDWazwFi2PhBtRLxtBhEs6MeOLHx6NjfSSAQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXi/yGRkoq03Ri7y/RmMVzJsPUoFhcpCsJpTskGpNoFs4PyVKLlEiB8O2n+5Tl8Z8b+R1ibh4bu1fPfoRTtqW96cyOhHI+wkm6XtVZK1z5tLjRQvC8toPojuucqNbF+RRDHxH3JBxAeV5G2x7CyRewidJDO+rqsEJnpbGNXmjvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcLGa2sI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcLGa2sI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C891F000FF;
	Fri, 25 Sep 2026 02:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301817;
	bh=XbfLt567UruTanIr/tJZNwrVVvx5lCkEUIU6u9TuyOc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QcLGa2sI2CSFd+1OYFPqtvbpBgmOTP3N190z13MvZcnWpLL3h3ZTDtQ3Y6Wujbb9j
	 ZDD4qzR0OYXQKF5vHa+lrjv0GfT7A2CAijea5tALLiO41vORmdCMBNXHtEDCkf8auC
	 aIRJZtRUHFiGGM4NdVuW62rokrRWRndcIRzw42AvY6QyK1cxQeNRkE3maPME4O4HEb
	 Z9fFkewi6U2HVuRNoUgpToVf9Zg4H5pdJEFS7u6NSKlD/QD+HAUHWLmY+MdHEn7AFX
	 /ilwNJShqcpYrpjsJq9blWOUIAM0yphSACBZMW+hgQhqhuPydtDSHjkqEy5JL7JuoU
	 wQZ7nuMr/eUKA==
Subject: Re: [PATCH net-next v10 01/11] net: stmmac: move XPCS lifetime
 management to platform drivers
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org,
 linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
Date: Fri, 25 Sep 2026 02:03:35 +0000
Message-ID: <179030181534.2160803.2909836028801902052@kernel.org>
In-Reply-To: <20260922200336.2201212-2-coiaprant@gmail.com>
References: <20260922200336.2201212-2-coiaprant@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit message audit claim: "every DTS that pairs a dwmac node
  with a PCS goes through a glue that sets pcs_init() (Intel, Renesas,…
- [Low] Commit message framing: the removal of the unconditional
  `priv->hw->xpcs = xpcs;` in stmmac_pcs_setup() is described as fixing…

--

net: stmmac: move XPCS lifetime management to platform drivers

This moves XPCS creation and destruction out of the common
stmmac_pcs_setup() and stmmac_pcs_clean(), which now only dispatch to
plat->pcs_init() and plat->pcs_exit(). The Intel mGbE glue gains its own
pcs_init()/pcs_exit() pair, and the renesas-gbeth, rzn1 and socfpga
pcs_exit() callbacks clear priv->hw->phylink_pcs after destroying the PCS.

No Link: tags are present in the commit header.

I looked at the two places in stmmac_pcs_setup() that seemed worth double
checking and did not find anything to report.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index afe98ff5bdcb0..7396b68899c66 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -426,35 +426,14 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  int stmmac_pcs_setup(struct net_device *ndev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> -	struct fwnode_handle *devnode, *pcsnode;
> -	struct dw_xpcs *xpcs = NULL;
> -	int addr, ret;
> -
> -	devnode = dev_fwnode(priv->device);
> -
> -	if (priv->plat->pcs_init) {
> -		ret = priv->plat->pcs_init(priv);
> -	} else if (fwnode_property_present(devnode, "pcs-handle")) {
> -		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
> -		xpcs = xpcs_create_fwnode(pcsnode);
> -		fwnode_handle_put(pcsnode);
> -		ret = PTR_ERR_OR_ZERO(xpcs);
> -	} else if (priv->plat->mdio_bus_data &&
> -		   priv->plat->mdio_bus_data->pcs_mask) {
> -		addr = ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
> -		xpcs = xpcs_create_mdiodev(priv->mii, addr);
> -		ret = PTR_ERR_OR_ZERO(xpcs);
> -	} else {
> +	int ret;
> +
> +	if (!priv->plat->pcs_init)
>  		return 0;
> -	}

Dropping the generic "pcs-handle" and pcs_mask parsing here matches the
in-tree users I could find: the only dwmac nodes carrying pcs-handle go
through dwmac-rzn1 (r9a06g032.dtsi) and dwmac-renesas-gbeth, both of which
set plat->pcs_init(), and dwmac-intel gains pcs_init() in this same patch.

>  
> +	ret = priv->plat->pcs_init(priv);
>  	if (ret)
> -		return dev_err_probe(priv->device, ret, "No xPCS found\n");
> -
> -	if (xpcs)
> -		xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
> -
> -	priv->hw->xpcs = xpcs;
> +		return dev_err_probe(priv->device, ret, "Failed to initialize PCS\n");
>  
>  	return 0;
>  }

Removing the trailing priv->hw->xpcs assignment also looks right. None of
the pcs_init() implementations present before this patch touch
priv->hw->xpcs (renesas_gmac_pcs_init(), rzn1_dwmac_pcs_init() and
socfpga_dwmac_pcs_init() all set priv->hw->phylink_pcs), so no existing
platform changes behaviour, and a glue that does set priv->hw->xpcs from
pcs_init() would previously have had it clobbered.

> @@ -463,14 +442,10 @@ void stmmac_pcs_clean(struct net_device *ndev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  
> -	if (priv->plat->pcs_exit)
> -		priv->plat->pcs_exit(priv);
> -
> -	if (!priv->hw->xpcs)
> +	if (!priv->plat->pcs_exit)
>  		return;
>  
> -	xpcs_destroy(priv->hw->xpcs);
> -	priv->hw->xpcs = NULL;
> +	priv->plat->pcs_exit(priv);
>  }

The Intel side pairs this with intel_mgbe_pcs_exit(), which calls
xpcs_destroy() and clears priv->hw->xpcs, so the destroy path is preserved
for the only platform that was relying on the common code.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922200336.2201212-1-coiaprant%40gmail.com
