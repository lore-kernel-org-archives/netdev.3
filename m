Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C43A4F2F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786701; cv=none; b=qAVwIAEWnSLzlLNxE2Oc2Jcc/ctzXXO3cRDxcIIQ+6EeP0yMvfL7AV77eefcG6KV26B0K3pPu7LoGb3owXMjJqR8Mk5jQx4VT0/PriKpxIEijkIXCv/N0VaOJnfVuBNJZqEyIk2eoHG9CUNkqVtyDOvp+gZOMRsaL4K+dbYnDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786701; c=relaxed/simple;
	bh=XmrhaH2TDgHKknIEGYdyh60fXe4kO/67pTBS8izoMqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAHEFyuKA8m6AHaC6lUAmT62dhHXo0FMwXYH2v0i9BRDCorZUcEuocyPdlMyx8ryMl/Tve1tAyDF1/bO+BRb+sUMG8Fyu54DYOC72ygupTANb0ZQr39bl01920CtbTsoWhbjpD60D+hwQprhYeb1fiUAZP1e3Q/yuQZdCT5gobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=CiO+xGAO; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gFtIPEz6; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="CiO+xGAO";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gFtIPEz6"
DKIM-Signature: a=rsa-sha256; b=CiO+xGAOOK0IOA9wsdKoBX3d7Px3FRgX+iQxPAIwuNAy+nWL6Mbw5cOPIUItebL3R2u82XNcMVtsTpLHI/IKGUyHRE8tCbE/Kg8iwCUdiskVIeXAxWxQLa5pFLYI3Si1UO98MpyhLhya9y5cg/tZ8qK5xNzLuoInwpfUSHdfrO3zEST3m0bGtEMvbYkV5Eh50lWSQFtl9Xil/U4QeScRc2ag+BaiAbGAfC75yhfVucPiBvmNUmXWwlvCtJVRpD9z71q6APd56NVsHp9FXcxVR83KB8/+ybctEROzlYVAbzRxOO6I6w+BRefnofiMM6dIt73JFiyXtM9YPVGqpfSWMA==; s=purelymail1; d=tinyisr.com; v=1; bh=XmrhaH2TDgHKknIEGYdyh60fXe4kO/67pTBS8izoMqk=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=gFtIPEz6/XKPEGpaSbtwlB6fIPKRMx8+4a/hHGjr9D/vEOTF8CRaUEpmQju6MLFIV9mdwtgXPmGt5mYL3L5rV9YOSq/OeWfJe4+JljMPPEWu4SjpyxfjFT8cje0FnbFSGPqWXDvKhHQcYcO6uf7Ba4izJsZBctHr+h6BT6vz5/MlnpcijY5bIJ5OFhIdRZsQ4ISR2UY1P8v4cfzDBNTUkGyzvpTHdHOLVd9xQWhmemvA986+WCL/756Ttex8fSEtqr15e/bLtMOmEieyNtl1An6ypI8seq0jQoMu6Z+X1n5APM9G5S9EaHmLyuNAZyZEhtEWLxWpT8Ui5lxRLcPpQg==; s=purelymail1; d=purelymail.com; v=1; bh=XmrhaH2TDgHKknIEGYdyh60fXe4kO/67pTBS8izoMqk=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1533707783;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 03 Aug 2026 19:51:22 +0000 (UTC)
Date: Mon, 3 Aug 2026 22:50:34 +0300
From: Joris Vaisvila <joey@tinyisr.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, andrew@lunn.ch, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com, 
	sean.wang@mediatek.com, daniel@makrotopia.org
Subject: Re: [PATCH net-next v6 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <anDmcBoebeG-DDXc@archlinux>
References: <20260704105659.140970-5-joey@tinyisr.com>
 <20260720235219.466404-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720235219.466404-1-kuba@kernel.org>

On Mon, Jul 20, 2026 at 04:52:19PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: initial support for MT7628 embedded switch
> 
> Add support for the MT7628 embedded switch. The switch has 5 built-in
> 100Mbps user ports and one 1Gbps CPU port.
> 
> > diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> > index 4ab567c5bbafc..daa1d3d4ba609 100644
> > --- a/drivers/net/dsa/Kconfig
> > +++ b/drivers/net/dsa/Kconfig
> > @@ -63,6 +63,14 @@ config NET_DSA_MT7530_MMIO
> >  	  are directly mapped into the SoCs register space rather than being
> >  	  accessible via MDIO.
> >  
> > +config NET_DSA_MT7628
> > +	tristate "MediaTek MT7628 Embedded Ethernet switch support"
> > +	select NET_DSA_TAG_MT7628
> > +	select MEDIATEK_FE_SOC_PHY
> > +	help
> 
> [Severity: Low]
> Can this lead to a build or link failure on randconfig? It looks like this
> is missing a select REGMAP_MMIO and depends on HAS_IOMEM, which might cause
> devm_regmap_init_mmio() to be unresolved when CONFIG_REGMAP_MMIO is not set.

Will fix with v7.

> > diff --git a/drivers/net/dsa/mt7628.c b/drivers/net/dsa/mt7628.c
> > new file mode 100644
> > index 0000000000000..eccdb05fce9b7
> > --- /dev/null
> > +++ b/drivers/net/dsa/mt7628.c
> > @@ -0,0 +1,649 @@
> > [ ... ]
> > +static int mt7628_setup_internal_mdio(struct dsa_switch *ds)
> > +{
> > +	struct mt7628_esw *esw = ds->priv;
> > +	struct device *dev = ds->dev;
> > +	struct mii_bus *bus;
> > +
> > +	bus = devm_mdiobus_alloc(dev);
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	bus->name = "MT7628 internal MDIO bus";
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(dev));
> > +	bus->priv = esw;
> > +	bus->read = mt7628_mii_read;
> > +	bus->write = mt7628_mii_write;
> > +	bus->parent = dev;
> > +
> > +	ds->user_mii_bus = bus;
> > +	bus->phy_mask = ~ds->phys_mii_mask;
> > +
> > +	return devm_mdiobus_register(dev, bus);
> > +}
> 
> [Severity: High]
> Does this cause a resource leak and sysfs name collision if the switch setup
> callback runs multiple times?
> 
> If the DSA master device unbinds and rebinds, dsa_tree_teardown() and
> dsa_tree_setup() can be triggered again. Because devm_mdiobus_alloc() and
> devm_mdiobus_register() tie the resource to the platform device's lifetime
> rather than the DSA tree setup/teardown cycle, the first registration will
> leak, and the second might fail with -EEXIST.

I am not able to find any code path that would trigger dsa_switch_ops
setup other than through `dsa_register_switch`, which is called in the
platform device probe. That would make it impossible for setup to be
called again without removing the platform device first, which tears
down the mdiobus.

This pattern is used in multiple other DSA drivers. A few examples:

	- in NXP NETC priv->dev is sset to the &pci_dev->dev, which is used
	  in devm_mdiobus_alloc_size().
	- in mt7530-mmio priv->dev is set to the &platform_device->dev,
	  which is then used in devm_mdiobus_alloc().
	
This seems like an AI review false positive. 

> > [ ... ]
> > +static void mt7628_switch_init(struct dsa_switch *ds)
> > +{
> > +	struct mt7628_esw *esw = ds->priv;
> > +
> > +	regmap_write(esw->regmap, MT7628_ESW_REG_FCT0,
> > +		     FIELD_PREP(MT7628_ESW_FCT0_DROP_SET_TH, 0x50) |
> > +		     FIELD_PREP(MT7628_ESW_FCT0_DROP_RLS_TH, 0x78) |
> > +		     FIELD_PREP(MT7628_ESW_FCT0_FC_SET_TH, 0xa0) |
> > +		     FIELD_PREP(MT7628_ESW_FCT0_FC_RLS_TH, 0xc8));
> 
> [Severity: High]
> Can traffic leak across isolated ports (like WAN and LAN) during boot?
> 
> It looks like mt7628_switch_init() resets the switch but fails to explicitly
> set the MT7628_ESW_POC0_PORT_DISABLE bits for the user ports. Since the
> DSA core relies on port_disable during ndo_close and doesn't automatically
> disable ports upon initialization, does the hardware default to acting as
> an unmanaged switch, bridging all networks until the interfaces are brought
> up administratively?

The hardware defaults to an all ports disabled state. Will add this as a
comment in v7.
