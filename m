Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBFC3EBF1F;
	Sun,  1 Feb 2026 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769907341; cv=none; b=Tv0SAoswms+2JwbVWGlpSTrURRjhrZfNS62oeAVcoA2pCZ6DxZTKJ2F5nCWQFtUCmyXFbVW2nJY8Tn2RPHhGJjxzKNFWKXW0KV0E/aQHkvmwhJl66hlnFcT4RRqM1FGAxX9auelaVcXE72UPIiWDSwsMixHTCyQl+iucpBZeh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769907341; c=relaxed/simple;
	bh=Rmk/RdLFUM79fJ5ed5sOVj+mDcJ1RXrHfn64ScstHkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRHxs0aJboXUUCpqzbRC0sMAqiKpq/21ThP03/ekzdo277yNNkczcY/JS475ma3c0OtpGXH+C27kWvHJwOVeDKHdGc7dgnilYvBiSPLwx2FCXarXNXWbkKThg82bjlOoe+X4zZ6J0q28G4sH0RmqbrzYGUuncNfNpTdyflRjyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vmLkM-00000000252-1sc2;
	Sun, 01 Feb 2026 00:55:26 +0000
Date: Sun, 1 Feb 2026 00:55:22 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: lxu@maxlinear.com, hkallweit1@gmail.com, yweng@maxlinear.com,
	ajayaraman@maxlinear.com, andrew@lunn.ch, netdev@vger.kernel.org,
	bxu@maxlinear.com, olteanv@gmail.com, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, lrosu@maxlinear.com, chad@monroe.io,
	conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
	edumazet@google.com, pabeni@redhat.com, cezary.wilmanski@adtran.com,
	davem@davemloft.net, john@phrozen.org, frankwu@gmx.de,
	jpovazanec@maxlinear.com, linux@armlinux.org.uk,
	fchan@maxlinear.com, horms@kernel.org
Subject: Re: [net-next,v11,4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aX6keghdVMI-A6Fq@makrotopia.org>
References: <46226b74030f76bd04149ed5c92b3e263abbe6c2.1769817939.git.daniel@makrotopia.org>
 <20260131175243.1122906-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131175243.1122906-2-kuba@kernel.org>

On Sat, Jan 31, 2026 at 09:52:44AM -0800, Jakub Kicinski wrote:
> > [...]
> > +/**
> > + * struct mxl862xx_bridge_port_alloc - Bridge Port Allocation
> > + * @bridge_port_id: If the bridge port allocation is successful, a valid ID
> > + *                  will be returned in this field. Otherwise, INVALID_HANDLE
> > + *                  is returned. For bridge port free, this field should
> > + *                  contain a valid ID returned by the bridge port allocation.
> > + *
> > + * Used by MXL862XX_BRIDGE_PORT_ALLOC and MXL862XX_BRIDGE_PORT_FREE.
> > + */
> > +struct mxl862xx_bridge_port_alloc {
> > +	__le16 bridge_port_id;
> > +};
> 
> Is the __packed attribute missing here? The similar struct
> mxl862xx_bridge_alloc has __packed, and both structures have identical
> layout with a single __le16 field. Both are used for firmware
> communication where padding could break the protocol.
> 
> [Jakub] please remove the __packed attribute on structs which are
>         naturally packed according to C rules.

I'll do that for the upcoming submission of v12, but wonder if using
'#pragma pack(push, 1)' around the complete API header file wouldn't be
the better option, as anyway *everything* should always be packed there,
as the switch firmware expects data byte-aligned.

> > [...]
> > +static int mxl862xx_setup_mdio(struct dsa_switch *ds)
> > +{
> > +	struct mxl862xx_priv *priv = ds->priv;
> > +	struct device *dev = ds->dev;
> > +	struct device_node *mdio_np;
> > +	struct mii_bus *bus;
> > +	static int idx;
> > +	int ret;
> > +
> > +	bus = devm_mdiobus_alloc(dev);
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	bus->priv = priv;
> > +	ds->user_mii_bus = bus;
> > +	bus->name = KBUILD_MODNAME "-mii";
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
> 
> Can concurrent probes race on the idx variable?
> 
> The static int idx is shared across all driver instances and accessed
> without synchronization. If multiple instances of this driver are probed
> concurrently on different CPU cores, they could race on the idx++
> operation potentially leading to duplicate MII bus IDs. MII bus IDs must
> be unique system-wide.
> 

Do you think it's worth to fix this also in other drivers which follow
the same pattern? (bcm_sf2, mt7530 and mv88e6xxx if OF node is NULL --
if there is an OF node it uses %pOF, and I'm not sure that's such a good
idea either)

Apart from being racy, this also means the MII bus name depends on probe
order which isn't very nice either. Using

snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(priv->dev));

may result in a slightly more ugly-looking, but predictable and
non-racy (ie. always unique) name.

Other than that there is also
snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d.%d",
         KBUILD_MODNAME, ds->dst->index, ds->index);

The real question here is if we consider MII bus names to be ABI,
ie. if they should never change once a driver is part of the kernel.
