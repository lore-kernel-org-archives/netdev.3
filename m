Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5930F819;
	Mon, 20 Jul 2026 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591543; cv=none; b=Z5YkkR13mqBVq4c4SVFB2Ep/4HG+dwfn4lP6fVfoWcpAosswoeYhGf21sdwHwO1x4wvfm6CSIpqvMTc05HEeJcvQ08SAvvXdC1Swl5VWSOKDJgEcmeuj64F0vVEB/YpBcz6xZMh/KtA3I44vNpbD0i/coQOwK5bcJgaNPRXwX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591543; c=relaxed/simple;
	bh=Iz/Gfipdr5hArhEumhb5TwS7JVeRFRD15GV7IoEaks4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSRcRVKmnu6cqnXJZf7JttoWL+E/3QCccOp/vymA1S7fIJNyNS9rJpFbDaNjsLJ95FAI2emg1AXqObHmN3qGjRjc7vs3WPOmwyWZ5zdmN3iSEn1vrHhXDFePCPfUf2LOmeGfthQ4Fz4vYATWIg2kzYuLK3jwAES7Toy83F3YbEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0uVFJJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0uVFJJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD581F000E9;
	Mon, 20 Jul 2026 23:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591541;
	bh=G13YaPFSd/V7bcK/XLiMvqxcb1M/pYEfqhH+hd66ERc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0uVFJJ/FN8YKeEPmp+U1C9sNsU1h1d0O4IGy9pZPJLP3kZ/Q83k0bXuYSxZhuPBq
	 i3oq3US1BeV2qoEMemhFkyX5ylOiwMkawtzVrohGIHadjyW8MgmsuclFr9i1bqrB1Y
	 URrcw3xwm+MSws48TQw3X6P8EfU81s8xgzPooNDiBdgr3tkT0ZLGa5eKFMrtUA6zPP
	 NB5l+bNrltznb+e2cGT8y8ar2eRSZ1sJm4MuAxpPyqyKJ6fysDpnzzN5ITCqeDAHwL
	 cmVoH0utKgIS4lt3yQbvvvhT2G0S+L/1aWtZ9Xr82DUB2PaFUC4nyL3rMKPnKQDO0y
	 +XrxN/KV72/CA==
From: Jakub Kicinski <kuba@kernel.org>
To: joey@tinyisr.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	andrew@lunn.ch,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	daniel@makrotopia.org
Subject: Re: [PATCH net-next v6 4/4] net: dsa: initial support for MT7628 embedded switch
Date: Mon, 20 Jul 2026 16:52:19 -0700
Message-ID: <20260720235219.466404-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704105659.140970-5-joey@tinyisr.com>
References: <20260704105659.140970-5-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: initial support for MT7628 embedded switch

Add support for the MT7628 embedded switch. The switch has 5 built-in
100Mbps user ports and one 1Gbps CPU port.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 4ab567c5bbafc..daa1d3d4ba609 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -63,6 +63,14 @@ config NET_DSA_MT7530_MMIO
>  	  are directly mapped into the SoCs register space rather than being
>  	  accessible via MDIO.
>  
> +config NET_DSA_MT7628
> +	tristate "MediaTek MT7628 Embedded Ethernet switch support"
> +	select NET_DSA_TAG_MT7628
> +	select MEDIATEK_FE_SOC_PHY
> +	help

[Severity: Low]
Can this lead to a build or link failure on randconfig? It looks like this
is missing a select REGMAP_MMIO and depends on HAS_IOMEM, which might cause
devm_regmap_init_mmio() to be unresolved when CONFIG_REGMAP_MMIO is not set.

> diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> new file mode 100644
> index 0000000000000..eccdb05fce9b7
> --- /dev/null
> +++ b/drivers/net/dsa/mt7628.c
> @@ -0,0 +1,649 @@
> [ ... ]
> +static int mt7628_setup_internal_mdio(struct dsa_switch *ds)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +	struct device *dev = ds->dev;
> +	struct mii_bus *bus;
> +
> +	bus = devm_mdiobus_alloc(dev);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "MT7628 internal MDIO bus";
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(dev));
> +	bus->priv = esw;
> +	bus->read = mt7628_mii_read;
> +	bus->write = mt7628_mii_write;
> +	bus->parent = dev;
> +
> +	ds->user_mii_bus = bus;
> +	bus->phy_mask = ~ds->phys_mii_mask;
> +
> +	return devm_mdiobus_register(dev, bus);
> +}

[Severity: High]
Does this cause a resource leak and sysfs name collision if the switch setup
callback runs multiple times?

If the DSA master device unbinds and rebinds, dsa_tree_teardown() and
dsa_tree_setup() can be triggered again. Because devm_mdiobus_alloc() and
devm_mdiobus_register() tie the resource to the platform device's lifetime
rather than the DSA tree setup/teardown cycle, the first registration will
leak, and the second might fail with -EEXIST.

> [ ... ]
> +static void mt7628_switch_init(struct dsa_switch *ds)
> +{
> +	struct mt7628_esw *esw = ds->priv;
> +
> +	regmap_write(esw->regmap, MT7628_ESW_REG_FCT0,
> +		     FIELD_PREP(MT7628_ESW_FCT0_DROP_SET_TH, 0x50) |
> +		     FIELD_PREP(MT7628_ESW_FCT0_DROP_RLS_TH, 0x78) |
> +		     FIELD_PREP(MT7628_ESW_FCT0_FC_SET_TH, 0xa0) |
> +		     FIELD_PREP(MT7628_ESW_FCT0_FC_RLS_TH, 0xc8));

[Severity: High]
Can traffic leak across isolated ports (like WAN and LAN) during boot?

It looks like mt7628_switch_init() resets the switch but fails to explicitly
set the MT7628_ESW_POC0_PORT_DISABLE bits for the user ports. Since the
DSA core relies on port_disable during ndo_close and doesn't automatically
disable ports upon initialization, does the hardware default to acting as
an unmanaged switch, bridging all networks until the interfaces are brought
up administratively?
