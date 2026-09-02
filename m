Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087E3876BA;
	Wed,  2 Sep 2026 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327402; cv=none; b=t1i6LQSEFUSW/RC+iikEoqWe6inDPeENL/FqKFYbRVDcLOXwdBZ7NLqWD2O3bWS1Tg5/MdxeQhWrVKDa0Hg6xconjtW3KRLXSD3P9q+DgszBWooHO0K5zVUuBZTYdoJt1O8nSDjpDXTVLMZp8JGpMrEqWBcsZN1YYBg6iedKVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327402; c=relaxed/simple;
	bh=ht41V6MtGZVbL48TcIofhjYcLSf+qoyHoFCuWg3W9xM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GFAT/MizuyoVoyVsczuoHExcuK7K0RzObAYG74Dg/n0efXy7c1xRlqmvm3zuPtIPL+86NZJoEsAiJtfJj4jZEdBrjUgkYDLmmvqauOVZ9jPSUrzC/U9b70R5PRCRlkYsIYX0rk99ulS3CBBRK43hETd/aBHfwnwp6A8IAiTHB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEm48Psj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEm48Psj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40231F000E9;
	Wed,  2 Sep 2026 05:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327400;
	bh=q/6350j5tr76EwiS+0JIL32F4Qpmzle5ZoqnurlGURc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DEm48Psj29969OVoimslFVGwZXEYWcEXgUufbpRRC5fFn3aDg5L6hLTslFvGcT4Hi
	 dWG3s52lFCNn72ts9U4Yd+09hlBuGTbqLjekCewd2HLQj/PEeyNC+k1B+74LNU85hK
	 hJregFo6ADhRZ8DNqVv6c+7g6dxUayDw1H7sTwNcqq4TtQ0Lu6mOjOKE0tJCh0oBRA
	 FCPBQdj9Dik+V/7kCKIWvkByLgd/eQexcWsqTuBSIrrkrzybh8nxb05oEW2ccWM+5K
	 9AMlTREU1aCT76ljkhTbXVl78sRum1IjVHMd61zTvNOwZqI3ne4sbtRPO4HHIRpFRK
	 0AEdj7jFueLKA==
Subject: Re: [net-next,v15,06/13] net: mdio: realtek-rtl9300: suppress sysfs
 bind/unbind attributes
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 05:36:39 +0000
Message-ID: <178832739920.3394541.414098829237532078@kernel.org>
In-Reply-To: <20260831143439.2404484-7-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-7-markus.stockhausen@gmx.de>
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

- [High] Incomplete fix: `.suppress_bind_attrs = true` in
  `otto_emdio_driver` (drivers/net/mdio/mdio-realtek-rtl9300.c:847)…

--

net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes

This sets suppress_bind_attrs in otto_emdio_driver so the driver cannot be
unbound through sysfs. The stated goal is to mitigate a use-after-free of
the devm allocated otto_emdio_priv structure, which the reference counted
mii_bus objects keep pointing at after the controller devres is released.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 69565a87f99db..7de8adec243ba 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -844,6 +844,7 @@ static struct platform_driver otto_emdio_driver = {
>  	.driver = {
>  		.name = "mdio-rtl9300",
>  		.of_match_table = otto_emdio_ids,
> +		.suppress_bind_attrs = true,

[Severity: High]

Does this flag actually cover the paths named in the commit message?  In
drivers/base/bus.c the only consumers are bus_add_driver() and
bus_remove_driver():

	if (!drv->suppress_bind_attrs) {
		error = add_bind_files(drv);

plus the CONFIG_DEBUG_TEST_DRIVER_REMOVE check in drivers/base/dd.c.  So
the sysfs bind/unbind files disappear, but device_release_driver() and the
devres unwind can still be reached by other means.

The commit message names the probe failure case as a trigger:

    "A corrupt devicetree might produce a load failure and a cleanup too."

That path is still open.  otto_emdio_probe() registers buses one child at a
time and returns on the first failure:

	device_for_each_child_node_scoped(dev, child) {
		err = otto_emdio_probe_one(dev, priv, child);
		if (err)
			return err;
	}

If the second child hits "undefined smi bus number" or
"illegal (dangling) smi bus number", the first bus was already published by
devm_of_mdiobus_register(), and the driver core then releases priv (and
destroys priv->lock) while the mii_bus can survive on a phy_device
reference held by a MAC/DSA consumer.

Can the bus callbacks then run against the freed priv?  otto_emdio_probe_one()
stores a raw back pointer into the refcounted bus:

	chan = bus->priv;
	chan->mdio_bus = mdio_bus;
	chan->priv = priv;

and otto_emdio_bus_to_priv() hands it back with no lifetime or bus->state
check, so otto_emdio_read_c22() and friends do:

	scoped_guard(mutex, &priv->lock)
		ret = priv->info->read_c22(bus, port, regnum, &value);

which is a mutex_lock plus an indirect call through freed memory.  Note that
phy_detach_internal() in drivers/net/phy/phy_device.c calls the new hook
unconditionally:

	if (notify_bus && phydev->mdio.bus->notify_phy_detach)
		phydev->mdio.bus->notify_phy_detach(phydev);

and __mdiobus_read()/__mdiobus_write() never test bus->state either.

The commit message also states:

    "The driver is usually integrated into the kernel and not loaded as a
    module."

Is that enforced anywhere?  drivers/net/mdio/Kconfig has:

	config MDIO_REALTEK_RTL9300
		tristate "Realtek RTL9300 MDIO interface support"

and the file still ends with module_platform_driver(otto_emdio_driver) and
MODULE_DEVICE_TABLE(), so rmmod reaches driver_unregister() ->
driver_detach() and the same devres teardown.  Removal of the parent node
via of_platform_depopulate() has the same effect.

Given that, should the Fixes: tag and "This mitigates issues for the known
use cases" be softened, or would one of the other two options listed in the
commit message (making bus->priv self contained, or gating the callbacks and
the notify hooks on bus->state) be the change to make instead?  Those would
replace this line rather than build on it.

The end of the series (c965284c5acebf7c11c9214f77cbc28873491728) still has
devm_kzalloc() for priv, chan->priv = priv and module_platform_driver(), so
no later patch changes the ownership model.

>  	},
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831143439.2404484-1-markus.stockhausen%40gmx.de
