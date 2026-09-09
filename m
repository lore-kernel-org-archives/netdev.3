Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F75519B3;
	Wed,  9 Sep 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955950; cv=none; b=KtObms9/Z+bGiKlOwU/H6OAKuWvprCmXNAHRmPbFPnC9MTXB+pK1V02WdNYz7TprELCLerqEOWNCdhDfLxQZzABj0GeKXX/VLaUVpDenA9BnXyaMn9U4Xv8Fqo2X6D5EZw/zp1FSTRoOAKlnZ6RVBWFbD/FkbpRUnz2WHtXK9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955950; c=relaxed/simple;
	bh=ZC0mdFk5q8FNgjsyV9RFk6LTrWvcBB8gVLTu4iiUOSQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akreBfwHUCfwmPP8+mAD7H/V6zS9XC0CNlMLco33TkgnYdJGPg+8e/2RdBTFT9r3r/hG4md759XZyllxhsiHU7aSuXlM4Kh/4Gm0KLQTtCf0n3T5njgux3h+3UDjMHswYbqNn0q1QJFoiZoSpnkjvQggiW91cvSDm/g/TI0TP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+972LGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+972LGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106C61F00A3E;
	Wed,  9 Sep 2026 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955949;
	bh=YkpRTW7aH+SOPISDbzLAxFe6GI6LAf/p2BdybRyyffw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H+972LGJiqjETj5NtZ6Rx3WajFAKuWptpZJYIbD1Zcg+1MPG9OcXYFfuOLkW7Hz5f
	 Rj+Jiz1RvpFQIUkHLJvzTIf1KQ1/EAfBwvbNAcDqPEIYJIBNndnHLlu0FO73OG8Egm
	 q/B17s3fLw09d0s5koKr1IeM+TJW2C+geKTQCIRat1v2Z1MGhDIrggYkBYChPmmhJc
	 zqhRP9g1Wi5iSywp/nONJW0J4oJL4qgZs+vYcYXus8Nwdmj4eO0/vM6kteT6u6vcHc
	 rk9yKWTxTcnRz8tcArT9Bfyqdu4arG2MKIMq6K4EvuQ5o02Tb0oteQU3j47QvpcLol
	 LZQAfdLRqJuKQ==
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: netdev-bot+sashiko@kernel.org
To: v.strassheim@linutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, martin.kaistra@linutronix.de,
 b.spranger@linutronix.de
Date: Wed, 09 Sep 2026 12:12:27 +0000
Message-ID: <178895594761.219967.4769482322073838475@kernel.org>
In-Reply-To:
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
References:
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] The MDIO master transaction sequence never verifies that the
  shared controller is idle before programming PARAMS/WRITE and kicking…
- [Medium] soce_setup() arms the switch's "tag all frames" and "DSA
  custom rules tagging" bits, but the driver provides no .teardown…
- [Low] The compatible string and its binding description declare a
  register layout with "the core version register at offset 0x00 and…

--

net: dsa: soce: Add basic support for SoC-e switch IP cores

This adds a new DSA driver for SoC-e FPGA switch IP cores, detecting the
core version and port counts from memory-mapped registers at probe time
and enabling the SDSA tagging feature. It also exposes each hardware MDIO
output of the integrated MDIO bridge as a separate logical mii_bus.

A few questions about the register descriptor, the MDIO timeout handling
and the missing teardown path.

> diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soce/soce_dsa_core.c
> new file mode 100644
> index 0000000000000..60f9f8c030e88
> --- /dev/null
> +++ b/drivers/net/dsa/soce/soce_dsa_core.c

[ ... ]

> +struct soce_probe_desc {
> +	u32 core_version_offset;
> +	u32 licensed_features_offset;
> +	u32 implemented_features0_offset;
> +	u32 mdio_master_offset;
> +};
> +
> +static const struct soce_probe_desc soce_probe_desc_swip_00_04_0c_10 = {
> +	.core_version_offset		= 0x0000,
> +	.licensed_features_offset	= 0x0004,
> +	.implemented_features0_offset	= 0x000c,
> +	.mdio_master_offset		= 0x0200,
> +};

[Severity: Low]
The compatible name soce,swip-00-04-0c-10 and the binding text describe a
register layout with "the core version register at offset 0x00 and feature
identification registers at offsets 0x04, 0x0c, and 0x10", but this
descriptor only models 0x00, 0x04 and 0x0c.

Is the 0x10 register meant to be read somewhere?  soce_sw_detect_features()
reads only licensed_features_offset and implemented_features0_offset:

	regval = readl(local->base_addr + probe_desc->licensed_features_offset);
	...
	regval = readl(local->base_addr +
		       probe_desc->implemented_features0_offset);

The "features0" suffix also suggests a features1 register at 0x10 that is
currently ignored.

Going the other way, mdio_master_offset = 0x0200 is a register block the
driver depends on for every MDIO transaction, but the binding does not
mention it at all.  Should the binding describe that block too, or should
the offset list in the compatible description match what the driver
actually models?

[ ... ]

> +static void soce_sw_enable_tagging(struct soce_dsa_local *local)
> +{
> +	u32 regval;
> +
> +	regval = readl(local->base_addr + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> +	regval |= SOCE_TAG_ALL_FRAMES_ENABLE;
> +	writel(regval, local->base_addr + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> +
> +	regval = readl(local->base_addr + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> +	regval |= SOCE_CUSTOM_RULES_TAGGING_ENABLE;
> +	writel(regval, local->base_addr + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> +}
> +
> +static int soce_setup(struct dsa_switch *ds)
> +{
> +	struct soce_priv *priv = ds->priv;
> +
> +	soce_sw_enable_tagging(&priv->local);
> +
> +	return 0;
> +}

[ ... ]

> +static const struct dsa_switch_ops soce_switch_ops = {
> +	.get_tag_protocol	= soce_get_tag_protocol,
> +	.setup			= soce_setup,
> +	.phylink_get_caps	= soce_phylink_get_caps,
> +};

[Severity: Medium]
Should there be a .teardown counterpart that clears what soce_setup()
armed?

soce_sw_enable_tagging() sets SOCE_TAG_ALL_FRAMES_ENABLE and
SOCE_CUSTOM_RULES_TAGGING_ENABLE, and nothing in the driver ever clears
them again.  There is no .teardown in soce_switch_ops, and the platform
callbacks only unregister:

soce_sw_remove()
	dsa_unregister_switch(priv->ds);

soce_sw_shutdown()
	dsa_switch_shutdown(priv->ds);

After an unbind or rmmod, does the core keep inserting SDSA source-port
tags into every frame delivered to the CPU port, with the tagger that
would strip them gone?  As described in the commit message, the same bits
also keep the user ports in CPU-directed operation:

    "Enabling this tagging feature of the switch, places all user ports
    into CPU-directed operation"

so the switch would also stay locked out of normal port-to-port
forwarding after the driver is removed.

> +static void soce_sw_remove(struct platform_device *pdev)
> +{
> +	struct soce_priv *priv = platform_get_drvdata(pdev);
> +
> +	if (!priv)
> +		return;
> +
> +	dsa_unregister_switch(priv->ds);
> +	platform_set_drvdata(pdev, NULL);
> +}

[ ... ]

> diff --git a/drivers/net/dsa/soce/soce_mdio.c b/drivers/net/dsa/soce/soce_mdio.c
> new file mode 100644
> index 0000000000000..692dcbe57d1a6
> --- /dev/null
> +++ b/drivers/net/dsa/soce/soce_mdio.c

[ ... ]

> +static int soce_mdio_read(struct mii_bus *bus, int addr, int reg)
> +{

[ ... ]

> +	mutex_lock(&local->mdio_lock);
> +	ret = local->mdio_ops->phy_read(state->ds, state->mdio_output, addr,
> +					reg);
> +	mutex_unlock(&local->mdio_lock);
> +
> +	return ret;
> +}

[ ... ]

> +static int soce_mdio_23_02_wait_for_idle(struct dsa_switch *ds)
> +{
> +	struct soce_priv *priv = ds->priv;
> +	struct soce_dsa_local *local;
> +	void __iomem *ctrl;
> +	u32 val;
> +
> +	local = &priv->local;
> +	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
> +
> +	return readl_poll_timeout(ctrl, val,
> +		!(val & (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET)), 10,
> +		SOCE_MDIO_TIMEOUT * 1000);
> +}

[Severity: Medium]
What happens to the hardware state when this poll times out?

On -ETIMEDOUT the OPSTATUS bit is still set, meaning the operation is
still in flight, and the callers just propagate the error without aborting
or resetting the master:

	ret = soce_mdio_23_02_wait_for_idle(ds);
	if (ret)
		return ret;

The bus wrappers soce_mdio_read(), soce_mdio_write(), soce_mdio_read_c45()
and soce_mdio_write_c45() then drop mdio_lock unconditionally, so the
software lock protecting the shared master is released while the hardware
is still busy.

None of the transaction helpers check for idle before programming the
registers either.  In soce_mdio_23_02_read_c22():

	regvalue = (regnum << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
	writel(regvalue, params);

	regvalue = ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) + ...

Can the next transaction, possibly issued through a different logical bus
sharing the same master, reprogram PARAMS/WRITE and kick CTRL underneath
a still-running operation?

> +int soce_mdio_23_02_read_c45(struct dsa_switch *ds, int mdio_output,
> +			     int phy_addr, int devad, int regnum)
> +{

[ ... ]

> +	regvalue = (devad << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
> +		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
> +	writel(regvalue, params);
> +
> +	writel(regnum, write_reg);
> +
> +	/* address cycle */
> +	regvalue = ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
> +		    (0x0 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
> +		    (0x1 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
> +		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
> +	writel(regvalue, ctrl);
> +
> +	ret = soce_mdio_23_02_wait_for_idle(ds);
> +	if (ret)
> +		return ret;
> +
> +	/* read cycle */

[Severity: Medium]
For Clause 45 the address cycle and the data cycle are separate hardware
operations.  If the address cycle times out here and is never aborted, can
a later data cycle land on a stale address, and can the following

	return readl(read_reg) & 0xffff;

hand the previous transaction's result back to phylib as a valid register
value?

Would it make sense to poll for idle before programming PARAMS/WRITE, and
to clear or reset the master on the timeout path before releasing
mdio_lock?  The same applies to soce_mdio_23_02_write_c22() and
soce_mdio_23_02_write_c45(), where a corrupted transaction would write to
an unintended PHY register.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b%40linutronix.de
