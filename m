Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AC83D669C;
	Tue, 15 Sep 2026 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469356; cv=none; b=g8vF5+rZNc/VyBuv2nHfnMMW0nM7bL06qnJ9beA3B9eU/2TxOMm8aS4eOnB4ywhNka7JOxhdpxAPhG506hzAXn4ErvvKAO5nhjzg+gVlTbTYZCV4R2VTft9j7idf3E55RADnw1KKoT8gQp1ZiGkWEGDnU7eF2ofVsKRQxotwe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469356; c=relaxed/simple;
	bh=h2nN3RPkDO5UWrQnE9qkYdoRNLD0iQwRQZrB/JqFy0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTuEzZkPC3bz12l34LbCewAijqzkkYETgX0sPhiNTZudQKw8Hu0qZG0p8itzHna8n/oy731SMxN2YKMuusn+lIJ7FpLMyskzeEgWt8xBTJEZl78KSmjw89OL8ibytc0psDfZ934kSTvnWk9keM7uZztENK07tC5I+XjFCTQuIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x6Qii-000000007Dm-46Qy;
	Tue, 15 Sep 2026 10:49:01 +0000
Date: Tue, 15 Sep 2026 11:48:53 +0100
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
Subject: Re: [PATCH v4 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
Message-ID: <aqkilcQAs-GERF3x@makrotopia.org>
References: <20260915103550.79957-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915103550.79957-1-cjd@cjdns.fr>

On Tue, Sep 15, 2026 at 10:35:50AM +0000, Caleb James DeLisle wrote:
> The EcoNet EN751221 multi-chip module implementation of the MT7530
> requires some additional configuration of the PHYs on startup.
> The reason for this is not known, but it is possible that it has
> to do with the fact that the EN751221 MCM implementation of the
> MT7530 runs at an abnormal PLL frequency (362.5Mhz).
> 
> Detect whether the MT7530 PHY is attached to the MDIO bus of an
> EcoNet EN751221 switch and if so, apply the necessary register
> updates. Additionally, never attempt to configure an MT7530
> identified PHY which does not have gigabit support because the same
> ID is used for another (FE) PHY.
> 
> Co-developed-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
> Signed-off-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>

> [...]
> +static bool en751221_is_mcm_phy(struct phy_device *phydev)
> +{
> +	struct device *parent = phydev->mdio.bus->parent;
> +
> +	return parent && parent->of_node &&
> +	       of_device_is_compatible(parent->of_node, "econet,en751221");

I thought you had found better options than using the parent of_node...?

> +}
> +
> +/*
> + * MTK_GPHY_ID_MT7530 ID is also used for an EcoNet SoC FE phy, but that PHY
> + * does not advertise ESTATUS_1000_TFULL.
> + */
> +static int mt7530_phy_match(struct phy_device *phydev,
> +			    const struct phy_driver *phydrv)
> +{

You miss the check for the PHY ID, see also below.

I'd suggest something like
	int ret;

	ret = genphy_match_phy_device(phydev, phydrv);
	if (!ret)
		return 0;

> +	return (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0 &&

The above should be helper function used by both .match_phy_device ops.

> +		!en751221_is_mcm_phy(phydev);
> +}
> +
> +static int en751221_phy_match(struct phy_device *phydev,
> +			      const struct phy_driver *phydrv)
> +{
> +	return (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0 &&
> +		en751221_is_mcm_phy(phydev);
> +}
> +
>  static int mt7531_phy_config_init(struct phy_device *phydev)
>  {
>  	mtk_gephy_config_init(phydev);
> @@ -135,6 +195,23 @@ static struct phy_driver mtk_gephy_driver[] = {
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

This assigns phy_id and phy_id_mask, which are used by
genphy_match_phy_device(). However, you are setting a .match_phy_device
op which doesn't call genphy_match_phy_device(), so this is ignored.

> +		.name		= "EcoNet EN751221 MCM PHY",
> +		.probe		= mt7530_phy_probe,
> +		.config_init	= en751221_mcm_phy_config_init,
> +		/* Interrupts are handled by the switch, not the PHY
> +		 * itself.
> +		 */
> +		.config_intr	= genphy_no_config_intr,
> +		.handle_interrupt = genphy_handle_interrupt_no_ack,
> +		.match_phy_device = en751221_phy_match,
>  		.suspend	= genphy_suspend,
>  		.resume		= genphy_resume,
>  		.read_page	= mtk_phy_read_page,
> -- 
> 2.39.5
> 
