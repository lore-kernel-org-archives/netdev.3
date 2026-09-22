Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D73BB674;
	Tue, 22 Sep 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074455; cv=none; b=fyS1ST2KHgvHCwks40lCMsNiK/fO0QrAjZIAM8ngLqGVaTDOM8mCnMndDHtwB6gyoJ9KSSoT1n8k0KT0UELFZaGmd8WE4SCkd9dHQccOzRYMGCPjxPvrGdyF12ycbU0XCiAFfeoNdhT5dxT5e2vpjB/Hk7ZFQz/U7e+qaDJN3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074455; c=relaxed/simple;
	bh=t5p+DeVFySLPUo98JwsIrRuSP1NSLjZ8sNO8pVCFJ3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdJ0VBmMJnJpZS6gOFYIGVhWM1CmCtWd8pyalJhPhNADsMh984pIFU71F8fKaNdgYREN1yJQ9Z9k+Mxym7NM6d5Giu0cv6Y6HR45/4RERkoXm0F8BTdnawOOA3KpDDTRSWLyF3lsI6+OlcGCC8JjvnExRM/Kbl8YSTWZC4q5Dfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x8y8P-000000006Qz-3nQU;
	Tue, 22 Sep 2026 10:54:02 +0000
Date: Tue, 22 Sep 2026 11:53:48 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: dsa: mxl-gsw1xx: force internal PHYs
 into a known reset state
Message-ID: <arJePPY2gHpVeIKU@makrotopia.org>
References: <20260922104124.311334-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922104124.311334-1-alexander.sverdlin@siemens.com>

On Tue, Sep 22, 2026 at 12:41:22PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> When bootstrapped with PS_NOWAIT = 0 the internal PHYs stay held in
> reset, so the driver only worked with PS_NOWAIT = 1 where they are
> released automatically.
> 
> Add a ->setup() hook, run before the MDIO bus is registered so PHY IDs
> are readable during the bus scan, that programs the RST_REQ PHY reset
> lines: release the PHYs of used (DSA user) ports and hold all other
> internal PHYs in reset. Driving both directions yields the same state
> regardless of the PS_NOWAIT bootstrap and keeps unused PHYs from staying
> powered.
> 
> A single 300ms settle delay is applied only when at least one PHY is
> released.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> [...]
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -589,6 +589,37 @@ static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
>  	gsw1xx_phylink_get_lpi_caps(config);
>  }
>  
> +static int gsw1xx_setup(struct dsa_switch *ds)
> +{
> +	struct gsw1xx_priv *priv = container_of(ds->priv, struct gsw1xx_priv, gswip);
> +	struct gswip_priv *gswip_priv = ds->priv;
> +	u32 phy_mask = 0, active_mask = 0;
> +	int port, ret;
> +
> +	/* Reset bits exist only for the internal-PHY ports preceding the first
> +	 * MII port.
> +	 */
> +	for (port = 0; port < gswip_priv->hw_info->max_ports; port++) {
> +		if (gswip_priv->hw_info->mii_cfg[port] != -1)
> +			break;
> +
> +		phy_mask |= GSW1XX_RST_REQ_PHY(port);
> +
> +		if (dsa_port_is_user(dsa_to_port(ds, port)))
> +			active_mask |= GSW1XX_RST_REQ_PHY(port);
> +	}
> +
> +	ret = regmap_update_bits(priv->shell, GSW1XX_SHELL_RST_REQ, phy_mask,
> +				 phy_mask & ~active_mask);

```suggestion
				 ~active_mask);
```

regmap_update_bits already applies the mask for you, so applying it
also in the caller is redundant.

With that change applied:
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
