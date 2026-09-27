Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1833C9895;
	Sun, 27 Sep 2026 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512114; cv=none; b=mcqXSKlqVAYZaJlbOMA4TJ8buHcTnVYWki/0nV0SEG8UQbi251j7YJiXZ7gAJHAzuI9ARVJ10yAFzoiVHO5RtuqeLouPTArK/TXJigqDAT2tetCThZN985SxlEpnDdP82a0bfRW3NyOfDcMMulQN9VE4ZOnKFiiWIDZEDNPuCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512114; c=relaxed/simple;
	bh=zKthrq34kXFb+mRor3DL/8iSz0Cl++z0usYbbE3MasI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a+95KdxZw/MYnqp8mT1377PH8p4As7MJnIWjyBcDcl+0VibTZ448xz14Uiqd5ut/TyaLfbioMnOu195MXBIudabS28x6K4zLUbqlB+7lyCZ7i582vuw3PIUoC/tst0pBP08KwmAsYW22BOm165/Z8BvX3NQUDLWOcndp9UjmsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaaEqBxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaaEqBxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9611F00898;
	Sun, 27 Sep 2026 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512110;
	bh=Wiqh2kqUcqfVjwhzD9UwKTz/F1aRCmwwsKwx829HPJw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IaaEqBxsBd3p+RSG3KJo9M+Y/zeEPyLFlxyupIBKwK6cXcyWG0RKGzkHvU7uI1FmA
	 m7ng6pPTPBg5P1hP418O64P1Bpz3wL/AvOQmFLnX+fV5Gmwr8w7NWohNHRkvRWgd5Y
	 Y+FEnseB858I+BIxp9wcNPtkvZcfgbNT5XhYXw2gNWbFzqiqwsoqSu0S8+2rdPiYOE
	 Y0jC4/T2iZSwvS00BdF0vR1QsRAOAJ5qHwhr3+nl//KCKOnW4kSxzXzluC+asHb255
	 qcKFw6UTcxWHPoD6qQI0/fsfasOIcZdcEc3p3k6RpxDh5lSjGwJ17BtA4QuQ4LEy6u
	 V6lvNJam9NScg==
Subject:
 Re: [PATCH net-next v3 5/8] net: mdio: Add SoC-e SWIP MDIO controller driver
From: netdev-bot+sashiko@kernel.org
To: v.strassheim@linutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 martin.kaistra@linutronix.de, b.spranger@linutronix.de
Date: Sun, 27 Sep 2026 12:28:29 +0000
Message-ID: <179051210920.2160803.11497808586391363644@kernel.org>
In-Reply-To:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-5-ddebafcb9ba7@linutronix.de>
References:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-5-ddebafcb9ba7@linutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] soce_mdio_iomap() (drivers/net/mdio/mdio-soce.c:48) returns
  whatever devm_ioremap() returns.
- [Medium] The external MDIO bus selector (bits 26:16) lives in the same
  32-bit control register as OPSTATUS (bit 0), but the idle check does…

--

net: mdio: Add SoC-e SWIP MDIO controller driver

This adds a driver for the MDIO controller in SoC-e Ethernet switch IP
cores. It supports Clause 22 and Clause 45 accesses. The transaction
control register also holds an external MDIO bus selector in bits 26:16,
which a generic MMIO MDIO mux manages and which the driver preserves when
it starts a transaction.

> diff --git a/drivers/net/mdio/mdio-soce.c b/drivers/net/mdio/mdio-soce.c
> new file mode 100644
> index 0000000000000..59c0b3da483eb
> --- /dev/null
> +++ b/drivers/net/mdio/mdio-soce.c
> @@ -0,0 +1,239 @@

[ ... ]

> +static void __iomem *soce_mdio_iomap(struct device *dev, int index)
> +{
> +	struct resource res;
> +	int ret;
> +
> +	ret = of_address_to_resource(dev->of_node, index, &res);
> +	if (ret)
> +		return IOMEM_ERR_PTR(ret);
> +
> +	return devm_ioremap(dev, res.start, resource_size(&res));

[Severity: Medium]
Can a failed mapping get past the checks in soce_mdio_probe()?

devm_ioremap() returns NULL on failure, not an ERR_PTR. This happens both
when the devres allocation fails and when ioremap() fails:

lib/devres.c:__devm_ioremap() {
	void __iomem **ptr, *addr = NULL;
	...
	if (!ptr)
		return NULL;
	...
	} else
		devres_free(ptr);

	return addr;
}

soce_mdio_probe() checks both results only with IS_ERR():

	priv->data = soce_mdio_iomap(dev, SOCE_MDIO_DATA_IOMAP_IDX);
	if (IS_ERR(priv->data))
		return PTR_ERR(priv->data);

	priv->ctrl = soce_mdio_iomap(dev, SOCE_MDIO_CTRL_IOMAP_IDX);
	if (IS_ERR(priv->ctrl))
		return PTR_ERR(priv->ctrl);

IS_ERR(NULL) is false, so probe would continue into
devm_of_mdiobus_register() with a NULL base.

The first bus access would then dereference NULL. That access comes either
from a PHY child during registration or through the mux:

mdio_mux_read()
  soce_mdio_read()
    soce_mdio_wait_for_idle()
      readl_poll_timeout(NULL, ...)

Could soce_mdio_iomap() convert a NULL result into IOMEM_ERR_PTR(-ENOMEM),
or could probe use IS_ERR_OR_NULL()? A helper that also requests the region
doesn't fit here, because the parent switch driver already requests the
whole range.

> +}
> +
> +static int soce_mdio_wait_for_idle(struct soce_mdio *priv)
> +{
> +	void __iomem *ctrl = priv->ctrl;
> +	u32 val;
> +
> +	return readl_poll_timeout(ctrl, val,
> +		!(val & SOCE_MDIO_CTRL_OPSTATUS), 10,
> +		SOCE_MDIO_TIMEOUT_US);
> +}
> +
> +static void soce_mdio_start(struct soce_mdio *priv, u32 command)
> +{
> +	void __iomem *ctrl = priv->ctrl;
> +
> +	/* Keep the currently selected MDIO bus while updating op bits. */
> +	command |= readl(ctrl) & SOCE_MDIO_CTRL_BUS_MASK;
> +	writel(command, ctrl);
> +}
> +
> +static int soce_mdio_read(struct mii_bus *bus, int phy_addr, int regnum)
> +{
> +	struct soce_mdio *priv = bus->priv;
> +	void __iomem *data = priv->data;
> +	u32 command;
> +	int ret;
> +
> +	ret = soce_mdio_wait_for_idle(priv);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Does this idle check also protect the bus selector bits in the same
register?

The commit message says:

    Return a timeout instead of waiting indefinitely, and allow a later
    access to retry if the hardware becomes idle again.

So when a completion wait returns -ETIMEDOUT, the engine may still be busy.
Nothing aborts or resets it before mdio_lock is released, and there is no
mii_bus->reset callback.

If the next access goes through the mux to a different child bus,
mdio_mux_read() calls switch_fn before it calls the parent's read callback:

drivers/net/mdio/mdio-mux.c:mdio_mux_read() {
	...
	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
	...
	r = pb->mii_bus->read(pb->mii_bus, phy_id, regnum);
	...
}

mdio_mux_mmioreg_switch_fn() then rewrites the selector halfword without
checking OPSTATUS:

			x = ioread16(p);
			y = (x & ~s->mask) | desired_child;
			if (x != y) {
				iowrite16((x & ~s->mask) | desired_child, p);

This means soce_mdio_wait_for_idle() runs only after bits 26:16 have
already changed.

If the hardware doesn't latch the selector when a transaction starts, could
the rest of the timed-out frame be sent to a different external MDIO bus?
The original PHY would get a truncated frame and the newly selected bus
would get a fragment from the middle of it. Neither the mux's current_child
nor the return code would show that this happened.

soce_mdio_write() and the c45 variants have the same ordering. Does this IP
latch the selector per transaction, or does the idle check also need to
cover the selector writes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7%40linutronix.de
