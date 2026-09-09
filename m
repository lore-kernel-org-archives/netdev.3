Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9431342509;
	Wed,  9 Sep 2026 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924014; cv=none; b=BS/4CptcbJoZeZN/LMUHFF5luVbQibYCrOY3yjN5ZgCOz9UNVPsmoBlRsfak91u4Nuu3DykLKE6pZoI0yM8IT75EGR5DPr484vAPvQn7CjzBZIzqULiH47Ntrs+R/lt9eys2qcIRaXOzt5C6RvTtcGjITaL9u2QrGJjI5NpFhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924014; c=relaxed/simple;
	bh=WHTT0aHB09NYfZ84LQYXffRCR6zXLrweRwuqfH//AO0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OTxKSO9VR13KfCAyEJ5Af5TMy1OXK44DUJQBDhts4EA22fNHnHQIIJR0FN2OjzFZMmevIqdk2z4Wwk6gkZzbK3G32LvMF2VGpL4U5OLiTbvd1B3Pl1bKGZ+nCKEzs9AVd+F7+EGchq7FV8AxMETu2KmMrc2M/H5ePZlSnAYWBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfBhe8M4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfBhe8M4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F391F00A3A;
	Wed,  9 Sep 2026 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924013;
	bh=Iw03k/3AfN3l3SzaVyyl42dnRPgFngzNDmWYx0/bKRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cfBhe8M4En7MjVTQWzR74BRwrcSoPe/XpuzWMXWxdG4UXfH7mZ8paMfR5dlnfQtku
	 +ApTKKwoHni+17rIXkPSL/KEzxOgrhHX1IVDHPzVaMddJXNIKDHOH8M8KNUt8kWY4v
	 A4CUToWsXoVkxcJ3T2u+jWIxHDIn5YD3V5oHxtAD5gXwpz9rWXFHPXdChgrTlbzrR2
	 cK2FVh6DBNM7WqycOieL536GnoA+CnEGi8M6SMRcTP21+fwaPDBD97Gbk3y+Q3CpHu
	 xmWA5NotAtQDSmkxpIIdFy+ytOrIAvgXLjFLCetZZhLD4mijOGUrTdAb9Pz5oDYuxR
	 QVeZMEppYHBew==
Subject: Re: [PATCH net-next v2 2/3] net: mdio: realtek-rtl9300: Convert
 "fwnode" left-overs to "of"
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 09 Sep 2026 03:20:11 +0000
Message-ID: <178892401189.219967.6693494754880026860@kernel.org>
In-Reply-To: <20260906081946.3499898-3-markus.stockhausen@gmx.de>
References: <20260906081946.3499898-3-markus.stockhausen@gmx.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Non-equivalent API conversion in otto_emdio_probe(): replacing
  `device_for_each_child_node_scoped(dev, child)` with…

--

net: mdio: realtek-rtl9300: Convert "fwnode" left-overs to "of"

This converts the remaining fwnode based property/child-node accesses in
the rtl9300 MDIO driver over to the OF API, and re-indents the
continuation line of otto_emdio_probe_one().

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 11d078ef941cd..429321e9114fd 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -831,14 +831,14 @@ static void otto_emdio_notify_phy_detach(struct phy_device *phydev)
>  }
>  
>  static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_priv *priv,
> -				 struct fwnode_handle *node)
> +				struct device_node *node)
>  {
>  	struct otto_emdio_chan *chan;
>  	struct mii_bus *bus;
>  	u32 mdio_bus;
>  	int err;
>  
> -	err = fwnode_property_read_u32(node, "reg", &mdio_bus);
> +	err = of_property_read_u32(node, "reg", &mdio_bus);
>  	if (err)
>  		return dev_err_probe(dev, err, "undefined smi bus number\n");
>  
> @@ -865,7 +865,7 @@ static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_priv *priv
>  
>  	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
>  
> -	err = devm_of_mdiobus_register(dev, bus, to_of_node(node));
> +	err = devm_of_mdiobus_register(dev, bus, node);
>  	if (err)
>  		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
>  
> @@ -1027,7 +1027,7 @@ static int otto_emdio_probe(struct platform_device *pdev)
>  			return dev_err_probe(dev, err, "failed to setup MDIO bus controller\n");
>  	}
>  
> -	device_for_each_child_node_scoped(dev, child) {
> +	for_each_child_of_node_scoped(dev->of_node, child) {

[Severity: High]

Is this iterator swap intended to be behaviour preserving?  The two
iterators differ in whether they honour the DT status property.

The old one dispatched into the OF fwnode ops:

drivers/of/property.c:of_fwnode_get_next_child_node() {
	return of_fwnode_handle(of_get_next_available_child(to_of_node(fwnode),
							    to_of_node(child)));
}

The new one does not filter:

include/linux/of.h
#define for_each_child_of_node_scoped(parent, child) \
	for (struct device_node *child __free(device_node) =		\
	     of_get_next_child(parent, NULL);				\
	     child != NULL;						\
	     child = of_get_next_child(parent, child))

So nodes with status = "disabled" now reach otto_emdio_probe_one().

Does that turn a disabled bus child into a probe failure for the whole
controller?  A disabled mdio-bus@N node still has a valid reg, so it
passes the reg and num_buses checks and ends up in:

	err = devm_of_mdiobus_register(dev, bus, node);
	if (err)
		return dev_err_probe(dev, err, "cannot register MDIO bus\n");

which reaches:

drivers/net/mdio/of_mdio.c:__of_mdiobus_register() {
	/* Do not continue if the node is disabled */
	if (!of_device_is_available(np))
		return -ENODEV;

and otto_emdio_probe() propagates that error immediately:

	for_each_child_of_node_scoped(dev->of_node, child) {
		err = otto_emdio_probe_one(dev, priv, child);
		if (err)
			return err;
	}

Previously the disabled child was skipped and the enabled buses still
came up.

This looks reachable with in-tree DT: arch/mips/boot/dts/realtek/rtl930x.dtsi
ships all four mdio-bus@0..3 children with status = "disabled", so boards
that enable the controller plus only the buses they use would now fail
probe entirely.

There is also a CONFIG_OF_MDIO=n variant of the same concern: the stub
devm_of_mdiobus_register() in include/linux/of_mdio.h forwards to
devm_mdiobus_register() with no availability check, so a DT-disabled bus
would be registered and address-scanned instead.

Finally, the sibling OF walk in the same driver still filters on
availability:

	for_each_available_child_of_node_scoped(ports_dn, port_dn) {

so otto_emdio_map_ports() and the bus enumeration would no longer agree on
which nodes are usable.  Would for_each_available_child_of_node_scoped(dev->of_node, child)
be the equivalent conversion here?

Note this is still present at the end of the series, in otto_emdio_probe()
at e4ad7bb3a35d ("net: mdio: realtek-rtl9300: Support non-default clock
frequency").

>  		err = otto_emdio_probe_one(dev, priv, child);
>  		if (err)
>  			return err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906081946.3499898-1-markus.stockhausen%40gmx.de
