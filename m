Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365C3B1EC8;
	Mon, 21 Sep 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019856; cv=none; b=mS4AVLXXXnCNE+yiXJc/By5pnk4MVWnttHocAu30suY1A8qjT2MFbvZ1mQVY63cT2Lh3rQHVd2K3wgPaZ+Og1g8eGLQCpxyjlducPB/j0HzbMM6/rquU4M7jCJUvA+E7HJV8KrkdauavG8CfNYDuMHu9GrL3cg+5b0AEGuyHwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019856; c=relaxed/simple;
	bh=cb8vbZoGHEoYr+tLZPP8O5fWLKNSB/5hY50GjAikAUs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+k0dwKJmWaH4DeKxCNBujDrDVruz0X+k+uTPnPrq7NbWHs2YKt3k+YwYTzBsHKLvXGJXjIM2PDCTgkCapzrp1cJl5L9VbHx/pRCTt2iHW7q8id0I/coJnbA1BtXTQWXDX+/t8KuY8n2ZyB+JTzM3RSx6sAIgi0a5K9HUzW7YIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csLjuYLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csLjuYLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756AC1F000FF;
	Mon, 21 Sep 2026 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790019855;
	bh=WikS7Kvn2vapa+IqHYX/84b8JT4k5u12Yes0fBncn7U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=csLjuYLIl0MCuQphTiZVhl+LcsVY4dmzKbRyrUqAOfSximj1+TouIF1zwapDHBFr2
	 OeOPI8G5l0fsELuU7clrseqLaRCc07ichvI8yjSywVoFazkeOuCSlItwmwSc5qXMzu
	 j/Xs96bfU4P9LAV4PDzs2CvuOJzb8Ot9zqwmxkJePSms8olMDdyBQtqHcfUeNJUrCC
	 Ttuq0tk162YaT79uo4Kpe7zWxtk9NBB61D/pdPXO34BUc+Vv84icFg5RR8un+PVvRP
	 QeCz5OowgFHtMoLbh+CaKkqDQ1Vm5wRg/ym2M5DXJfTi6l14aOkyl6iwPiu0Pwu8dR
	 rg0pcDbdYi1pg==
Subject:
 Re: [PATCH net-next v3 7/8] net: dsa: motorcomm: Split MDIO bus module
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 19:44:14 +0000
Message-ID: <179001985406.2160803.13727531690149784439@kernel.org>
In-Reply-To: <20260917185010.3189199-8-mmyangfl@gmail.com>
References: <20260917185010.3189199-8-mmyangfl@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit-message accuracy claim: "net: dsa: motorcomm: Split MDIO
  bus module" / "Split it in order to be used in other modules" while…

Pre-existing issues:
- [Medium] Binding-vs-driver mismatch for the `mdio-external` child bus:
  Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml…

--

net: dsa: motorcomm: Split MDIO bus module

This moves the internal and external MDIO master bus accessors, along with
the YT921X_*_MBUS_* register definitions, out of chip.c into a new
mdio_bus.c/mdio_bus.h compilation unit that is linked into the same
yt921x module. The two bus init helpers lose their static qualifier so
they can be called from chip.c.

> diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
> new file mode 100644
> index 0000000000000..ba70343f3f330
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/mdio_bus.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 David Yang
> + */
> +
> +#include <linux/of_mdio.h>
> +
> +#include "chip.h"
> +#include "mdio_bus.h"
> +#include "smi.h"

[ ... ]

> +int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
> +{
> +	struct device *dev = to_device(priv);
> +	struct mii_bus *mbus;
> +	int res;
> +
> +	mbus = devm_mdiobus_alloc(dev);
> +	if (!mbus)
> +		return -ENOMEM;
> +
> +	mbus->name = "YT921x external MDIO bus";
> +	snprintf(mbus->id, MII_BUS_ID_SIZE, "%s@ext", dev_name(dev));
> +	mbus->priv = priv;
> +	/* TODO: c45? */
> +	mbus->read = yt921x_mbus_ext_read;
> +	mbus->write = yt921x_mbus_ext_write;
> +	mbus->parent = dev;
> +
> +	res = devm_of_mdiobus_register(dev, mbus, mnp);
> +	if (res)
> +		return res;
> +
> +	priv->mbus_ext = mbus;
> +
> +	return 0;
> +}

[Severity: Medium]

This isn't something introduced by this patch, it is pre-existing behaviour
that just becomes more visible now that the external bus registration is
exported as shared driver infrastructure.

Can yt921x_mbus_ext_init() ever be used successfully?  Its only caller,
yt921x_dsa_setup() in chip.c, registers the bus and then aborts the switch
setup unconditionally:

	/* External mdio bus is optional */
	child = of_get_child_by_name(np, "mdio-external");
	if (child) {
		res = yt921x_mbus_ext_init(priv, child);
		of_node_put(child);
		if (res)
			return res;

		dev_err(dev, "Untested external mdio bus\n");
		return -ENODEV;
	}

At the same time,
Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml lists
mdio-external as a supported optional MDIO bus and its example instantiates
it:

	mdio-external {
		phy@b { reg = <0xb>; };
	};

with ethernet-port@9 referencing that phy via phy-handle.

So does a device tree written exactly as the in-tree binding documents make
the whole switch fail to probe with -ENODEV?  Would it make sense to either
drop mdio-external and the corresponding example from the binding, or drop
the -ENODEV bail-out, in a separate patch?

> diff --git a/drivers/net/dsa/motorcomm/mdio_bus.h b/drivers/net/dsa/motorcomm/mdio_bus.h
> new file mode 100644
> index 0000000000000..ae5792b8da24c
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/mdio_bus.h
> @@ -0,0 +1,39 @@

[ ... ]

> +struct yt921x_priv;
> +
> +int yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp);
> +int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp);
> +
> +#endif

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917185010.3189199-1-mmyangfl%40gmail.com
