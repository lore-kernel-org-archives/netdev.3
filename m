Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1C3A1687;
	Tue, 15 Sep 2026 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471039; cv=none; b=UuBIE5/Cov0wFtYvuywBI5STSt24vNPknxLOfhG6ufWsRV1rrIkbIfBvZRZDo0UWGL5Gn98/MIL8IAT4hc9g11nc6m6nNabmCh3jC+M2P2XjyrU5H3NZz1MltLwgGz0oqfY0e8TPbZ9VlIQTjOmqewt7HvzDPBDImeaYi/T3aH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471039; c=relaxed/simple;
	bh=0OJjJmPs4MWLh3/qkaMVTTSK/Cxs5AhfFmUYTmBbRb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyUjrXSpNiK5LkcoV4r7qhpmmBqnVWpNTxiUtQcU/syMdLCXdmYspC5Bf0U9dOL96h75GDz1MbdlUvIPgjoowgOz+fL+HlUg1QHv1cRp5qUC4Nv+gACmyXtYcGBp6UHO6SMxFWRQ0i5p/9S7wf77+eUVTql2cEGlAG0gOR4De2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x6RA0-000000007TH-3Of7;
	Tue, 15 Sep 2026 11:17:12 +0000
Date: Tue, 15 Sep 2026 12:17:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: dsa: mxl-gsw1xx: force internal PHYs
 into a known reset state
Message-ID: <aqkpNVyoJdXpQz4n@makrotopia.org>
References: <20260915091856.1375914-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915091856.1375914-1-alexander.sverdlin@siemens.com>

On Tue, Sep 15, 2026 at 11:18:45AM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> When the switch is bootstrapped with PS_NOWAIT = 0, the internal PHYs
> default to a held-in-reset state. The driver previously only worked with
> PS_NOWAIT = 1 where PHYs are released from reset automatically.
> 
> Program the PHY reset lines via the RST_REQ register before the MDIO bus
> is registered, so that PHY IDs can be read during bus scan. Release only
> the PHYs of ports that have a phy-handle in the device tree and keep the
> unused ones held in reset. Driving both directions makes the resulting
> state identical regardless of the PS_NOWAIT bootstrap: unused PHYs no
> longer stay powered when PS_NOWAIT = 1 released them automatically.
> 
> A single 300ms delay after deasserting the needed resets ensures the PHYs
> are ready for MDIO communication (refer to Intel XWAY, Maxlinear GPY111
> datasheets or the Lantiq counterpart of the driver). The delay is skipped
> when no PHY is released from reset.
> [...]
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index 66bf7e3319057..08c633b2caebf 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> [...]
> @@ -589,6 +590,52 @@ static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
>  	gsw1xx_phylink_get_lpi_caps(config);
>  }
>  
> +static int gsw1xx_setup(struct dsa_switch *ds)
> +{
> +	struct gsw1xx_priv *priv = container_of(ds->priv, struct gsw1xx_priv, gswip);
> +	struct gswip_priv *gswip_priv = ds->priv;
> +	u32 phy_mask = 0, active_mask = 0;
> +	struct device_node *phy_np;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	dsa_switch_for_each_user_port(dp, ds) {

This loop runs only over *user ports*. It skips DSA_PORT_TYPE_UNUSED.

> +		struct phylink_config cfg = {};
> +
> +		/* Is there an internal PHY on this port? */
> +		gswip_priv->hw_info->phylink_get_caps(ds, dp->index, &cfg);
> +		if (!test_bit(PHY_INTERFACE_MODE_INTERNAL, cfg.supported_interfaces))
> +			continue;
> +
> +		phy_mask |= GSW1XX_RST_REQ_PHY(dp->index);
> +
> +		/* Will the PHY be really used? */
> +		phy_np = of_parse_phandle(dp->dn, "phy-handle", 0);
> +		if (!phy_np)
> +			continue;

Hence this check is redundant and doesn't make much sense.

> +
> +		of_node_put(phy_np);
> +		active_mask |= GSW1XX_RST_REQ_PHY(dp->index);
> +	}
> +
> +	if (!phy_mask)
> +		return 0;

So this means if only the MII interfaces are in use the PHYs are
not being put into reset. Why?

> +
> +	/* Deassert resets for PHYs referenced by active ports and hold the
> +	 * unused ones in reset, so the state is identical regardless of the
> +	 * PS_NOWAIT bootstrap.
> +	 */
> +	ret = regmap_update_bits(priv->shell, GSW1XX_SHELL_RST_REQ, phy_mask,
> +				 phy_mask & ~active_mask);
> +	if (ret)
> +		return ret;
> +
> +	if (active_mask)
> +		msleep(300);
> +
> +	return 0;
> +}
> +
>  static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
>  							 phy_interface_t interface)
>  {
