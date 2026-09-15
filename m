Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD24A4F17;
	Tue, 15 Sep 2026 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472877; cv=none; b=R0yhiHwT5Kz9MYk5iGKoefNFDgdb1U8htdyV0isHsPdbMPdxuzcdhtoLDM77tfKPDQP/0Kk6XSjfBfrOXkJRH34+LlUMHuVhWlDVV6NsolBF8ttc/6MkAGxkGK/UbZE7+sNFKSSq6DgzJ2cGM2rPZDehMsF0HEvlHAhBvvQjREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472877; c=relaxed/simple;
	bh=31EFcyYjcOudZU20mM+t3o/xEbo5l4Z7/cG7UbcK0H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkB0DMgZVD5BR2gD1QZcZ72QIL8njPTINPxXG1LbTXyrvXoT+lc61Lz2N5dHV3w+YxKCkTtTd7/7oKzIcCIzM45NeCNs71bEcC4M6sZbOPffwcSWifQgZqeNttF4LBHJo+3EbE5xtqlHIaprz/h2U2/b5IVEEk9fus9Y3+JAG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x6Rdd-000000007qj-3QQb;
	Tue, 15 Sep 2026 11:47:49 +0000
Date: Tue, 15 Sep 2026 12:47:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: Re: [PATCH v5 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
Message-ID: <aqkwYd5dTmHDCIW9@makrotopia.org>
References: <20260915113427.113296-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915113427.113296-1-cjd@cjdns.fr>

On Tue, Sep 15, 2026 at 11:34:27AM +0000, Caleb James DeLisle wrote:
> [...]
> +/*
> + * MTK_GPHY_ID_MT7530 ID is also used for an EcoNet SoC FE phy, but that PHY
> + * does not advertise ESTATUS_1000_TFULL.
> + */
> +static bool mt7530_is_gphy(struct phy_device *phydev)
> +{
> +	return phydev->phy_id == MTK_GPHY_ID_MT7530 &&
> +	       (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0;
> +}
> +
> +static int mt7530_phy_match(struct phy_device *phydev,
> +			    const struct phy_driver *phydrv)
> +{
> +	return mt7530_is_gphy(phydev) && !en751221_is_mcm_phy(phydev);
> +}
> +
> +static int en751221_phy_match(struct phy_device *phydev,
> +			      const struct phy_driver *phydrv)
> +{
> +	return mt7530_is_gphy(phydev) && en751221_is_mcm_phy(phydev);
> +}
> +
>  static int mt7531_phy_config_init(struct phy_device *phydev)
>  {
>  	mtk_gephy_config_init(phydev);
> @@ -135,6 +199,23 @@ static struct phy_driver mtk_gephy_driver[] = {
>  		 */
>  		.config_intr	= genphy_no_config_intr,
>  		.handle_interrupt = genphy_handle_interrupt_no_ack,
> +		.match_phy_device = mt7530_phy_match,
> +		.suspend	= genphy_suspend,
> +		.resume		= genphy_resume,
> +		.read_page	= mtk_phy_read_page,
> +		.write_page	= mtk_phy_write_page,
> +	},
> +	{
> +		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),

I'd suggest to actually use phy_id and phy_id_mask assigned by the
PHY_ID_MATCH_EXACT macro by calling genphy_match_phy_device() in your
match functions above instead of open-coding the ID match.
Or drop PHY_ID_MATCH_EXACT from *both* drivers.
