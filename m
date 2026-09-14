Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5F468C2C;
	Mon, 14 Sep 2026 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387357; cv=none; b=timnqVYi6QCTGwtZQzxXTMzFoC9kObjvNBCvP+0cB5d2i3S/+OuXV8UcKQFZsnDQuGPyxdpB/2SymnxkxMlf1OliMEgaovA8CEdhuethilbBrajgpkeKwP247mA04EB2dYhd9rGCj8ktCy5k13p7JE4BEYx+HVIs5qrViS6oWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387357; c=relaxed/simple;
	bh=4V5rSgGj157OCe/vOVZ02Pgdai5ynI4WZu3FI0WUwv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRlvldlsRJrq/brvc9DpMyZzgsGf7XPnxsw5nNZ+FMoEc3rcdxgk4vR2KdtJECoE92wE5vffZ0eGYNaVEGy4Zr/O7Ak5ro4h4PmHyFW314Y2QKO0BBLGDa7QVA74LZbrobCP5JT48fez1iYj+FLOPhVf3xCd46SxGJu0gQ2fzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L8K44j2N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L8K44j2N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=qLAzhKsUxTEy3WyscyUgfZmNUubzBcet9DIGHn5TpLk=; b=L8
	K44j2NVTUPMiCH9VjA+7dm9CoQuf6fxcIFjIgMb5n22ygkq+eWaOP0PMdTbt44rwpVShsQfAoisCd
	s5TLASYsJeKdL6yE8S7HQntQSemzEn7fk7w1Xo+XsMJu5an06kkv8LhKesJW6L0/27NVmxqhFPJvG
	n6MjgswPA8P9dNg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x65Nk-0054Xh-Tz; Mon, 14 Sep 2026 14:01:56 +0200
Date: Mon, 14 Sep 2026 14:01:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
	SkyLake.Huang@mediatek.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: Re: [PATCH v3 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
Message-ID: <a6e1bb7f-e395-434e-8e9b-992141969d74@lunn.ch>
References: <20260911120646.4123877-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911120646.4123877-1-cjd@cjdns.fr>

> + * The EcoNet EN751221 "G" multi-chip module MT7530 requires additional PHY
> + * configuration.
> + */
> +static int en751221_mcm_phy_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_soft_reset(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* Master/Slave negotiation does not work reliably */
> +	ret = phy_write(phydev, MII_CTRL1000, ADVERTISE_1000FULL |
> +			CTL1000_ENABLE_MASTER | CTL1000_PREFER_MASTER |
> +			CTL1000_AS_MASTER);

Is it sufficiently broken that we should stop the user changing it?

     ethtool     -s     devname    [speed N]    [lanes N]    [duplex half|full]
            [port tp|aui|bnc|mii] [mdix auto|on|off]  [autoneg on|off]  [adver‐
            tise N[/M]  |  advertise mode  on|off  ...]  [phyad N] [xcvr inter‐
            nal|external]        [wol N[/M]         | wol p|u|m|b|a|g|s|f|d...]
            [sopass xx:yy:zz:aa:bb:cc]      [master-slave preferred-master|pre‐
            ferred-slave|forced-master|forced-slave]   [msglvl   N[/M] |    ms‐
            glvl type on|off ...]

You don't appear to have a config_aneg, so genphy_config_aneg() will
be used, which calls genphy_setup_master_slave. 

   Andrew
