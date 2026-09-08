Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955463947A4;
	Tue,  8 Sep 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865004; cv=none; b=rEtcj/w9dg9HPacsCm5TiOsfh8+jm85IPs66sYjk/8BrfxrcJ96JLNaQxLSFcOimqvB8842yWRf0k4+HQIMZnFPBTVWbqZxP19QpZmSdul3k8hZUwH0QsiUiyhE+yZgMPFxp+Cbh+oCHRY6Ul4l4Ve80KeUUB8Lg+B0wc2MEsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865004; c=relaxed/simple;
	bh=XPgvxRO+gHLZ90kroqQJo4Ht+VlfWgQRownXMl4K5Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNUuyPWX7UP0HtlcaNhxlkYJVTYZEMmXWbwb94GakN55s98uHQwmRdeBIxdAtECLY1Bg1E2VbOTCXnmWiYgp2YwJixDm+AH8uwOXuM6SiKFhBMJG1aEF2cDKlJPEaYFOnVEOb2ISxcGSEiAfqftuhIac+lmuhH9tRBADmn2BQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x3tVF-000000001A6-1DG8;
	Tue, 08 Sep 2026 10:56:37 +0000
Date: Tue, 8 Sep 2026 11:56:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mxl-gsw1xx: deassert internal PHY resets
 before MDIO registration
Message-ID: <ap_p3hpoa1MII9pz@makrotopia.org>
References: <20260908103030.4032992-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908103030.4032992-1-alexander.sverdlin@siemens.com>

On Tue, Sep 08, 2026 at 12:30:28PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> When the switch is bootstrapped with PS_NOWAIT = 0, the internal PHYs
> default to a held-in-reset state. The driver previously only worked with
> PS_NOWAIT = 1 where PHYs are released from reset automatically.
> 
> Deassert the PHY reset lines via the RST_REQ register before the MDIO bus
> is registered, so that PHY IDs can be read during bus scan. Only release
> PHYs for ports that have a phy-handle in the device tree, so unused ports
> do not consume power. A single 300ms delay after deasserting all needed
> resets ensures the PHYs are ready for MDIO communication (refer to Intel
> XWAY, Maxlinear GPY111 datasheets or the Lantiq counterpart of the driver).
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> [...]
> +static int gsw1xx_setup(struct dsa_switch *ds)
> +{
> +	struct gsw1xx_priv *priv = container_of(ds->priv, struct gsw1xx_priv, gswip);
> +	struct gswip_priv *gswip_priv = ds->priv;
> +	struct device_node *phy_np;
> +	u32 phy_reset_mask = 0;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		struct phylink_config cfg = {};
> +
> +		/* Is there an internal PHY on this port? */
> +		gswip_priv->hw_info->phylink_get_caps(ds, dp->index, &cfg);
> +		if (!test_bit(PHY_INTERFACE_MODE_INTERNAL, cfg.supported_interfaces))
> +			continue;
> +
> +		/* Will the PHY be really used? */
> +		phy_np = of_parse_phandle(dp->dn, "phy-handle", 0);
> +		if (!phy_np)
> +			continue;
> +
> +		of_node_put(phy_np);
> +		phy_reset_mask |= GSW1XX_RST_REQ_PHY(dp->index);
> +	}
> +
> +	if (!phy_reset_mask)
> +		return 0;
> +
> +	/* Deassert resets only for PHYs referenced by active ports */
> +	ret = regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ, phy_reset_mask);

Likewise doing the other change may also be a good idea:
Disable unused PHYs for a switch with PS_NOWAIT = 1 strapped.
Ie. use regmap_update_bits on the inverted phy_reset_mask.
This would make us end up with the identical state independently
of PS_NOWAIT being strapped or not.
