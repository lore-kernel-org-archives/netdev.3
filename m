Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA974A263F;
	Thu,  3 Sep 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448636; cv=none; b=MzCOiQl8CNW1teL03yhojslssjTurWZqcV6aOhcm3AdKHLGXRsNALG6WWaPgCL2mtjBeEjGobo31aUolNJuRqnxFS62Gi13Kw4j5dOT6a4JkWix1aLZRx1KH1n9kER6eQnLC0kckKDEF+NCm8FTrxN2/Mhy1zTRm3VXR0Nw7IZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448636; c=relaxed/simple;
	bh=tBURLkKYMxsS6k8AUfswZerN2qyPXq+sNlV2gBUXm5A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T1fDoNt/4tWEYICvUIJ6wBEYN88dp7+dj8OO2kqHqwzM9hd/p/L2dZU4ZC3Hs5WnDfgMEm8uwiAOrB6VxghKWdBCB6GMnl/peHjdZrZ+fc+Wn6z13ZB2mTof2qCguLrkWokidCHOAEfHdc0t+QwME0zz6GxOuwmgg05+TuBd6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9XAkhvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9XAkhvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C271F000E9;
	Thu,  3 Sep 2026 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448633;
	bh=IV3Cc66uozyYNimvsGwX6CGgpWkPF8bqTZuP7tq8OYs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L9XAkhvWRUG/zrO+Bx6vUIUCCLX1e39IEwfyRRtFvfru6cZAqMXXjzzB1I0qjGBhJ
	 ksal0HTyAnPVT+IOFhH/aoiPFNggpyIPmueau33CayQ/2MLcwJkATGhVxypYM1Oug2
	 A0KWyN54Gpk2HcfwNGvK8lTbx8ww+un0SjqsN7BwAgcWLIcWZna7C3OR6ZG4f8tX1o
	 3YmS8oSH80OlxJyU6k11VddPp61CsfDbRLtqlcwoKvdWIN4BN5/OJ45RDG3CDIkeFu
	 kutBfYdoPkDziND1axKRkBYp3BELl983ku3Kx9AfPUgd0HRAN7Ic6nhFnKrOfBKh/C
	 N0Fq3lS02/vCw==
Subject: Re: [v3] dt-bindings: net: ti,davinci-emac: Convert to DT schema
From: netdev-bot+sashiko@kernel.org
To: j.bhargav.u@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, tony@atomide.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com,
 simona.toaca@nxp.com
Date: Thu, 03 Sep 2026 15:17:12 +0000
Message-ID: <178844863252.3394541.10006643092711574384@kernel.org>
In-Reply-To: <20260901-ti-davinci-emac-v3-1-db41e32f3f6d@gmail.com>
References: <20260901-ti-davinci-emac-v3-1-db41e32f3f6d@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The new schema lets `ti,dm816-emac` nodes carry either 1 or 2
  `reg` entries with no further constraint, while the driver derives…
- [Low] The schema makes `clocks` required (justified in the commit
  message by 'driver probe fails without it') but leaves `power-domains`…

--

dt-bindings: net: ti,davinci-emac: Convert to DT schema

This converts the DaVinci EMAC text binding to YAML, documents clocks,
clock-names, syscon, power-domains and ti,hwmods, and adds per-compatible
conditionals restricting reg, syscon and clock-names.  clocks becomes a
required property and ti,hwmods is marked deprecated.

> diff --git a/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
> new file mode 100644
> index 0000000000000..f0c539d1bac79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
> @@ -0,0 +1,127 @@

[ ... ]

> +properties:
> +  compatible:
> +    enum:
> +      - ti,davinci-dm6467-emac
> +      - ti,am3517-emac
> +      - ti,dm816-emac
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: EMAC core
> +      - description: EMAC control module

[Severity: Medium]

For ti,dm816-emac this leaves reg free to be either 1 or 2 entries, but the
driver derives hardware semantics from the entry count.  In
davinci_emac_probe() the presence of the second region is the only signal
used, both for the control module base:

	res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
	if (res_ctrl) {
		priv->ctrl_base =
			devm_ioremap_resource(&pdev->dev, res_ctrl);
		...
	} else {
		priv->ctrl_base = priv->remap_addr + pdata->ctrl_mod_reg_offset;
	}

and for the SCM eFuse MAC-ID instance:

	rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1, priv->mac_addr);

which flows into ti_cm_get_macid()/cpsw_am33xx_cm_get_macid() and selects the
register pair at offset + slave * 8.

Given that, can a schema-valid DM816x node land on the wrong hardware?  Two
cases seem possible:

A single-reg EMAC0 node with a 0x800 core window (as in dm816x.dtsi, where
MDIO at 0x4a100800 is a separate node) plus ti,davinci-ctrl-mod-reg-offset =
<0x900> would make ctrl_base point 0x900 past the end of the ioremap.

An EMAC1 node written with two reg entries would be passed instance 0 and get
EMAC0's factory MAC address, putting two interfaces on the wire with the same
address.

In-tree, arch/arm/boot/dts/ti/omap/dm816x.dtsi happens to pair these
correctly (eth0 has two reg entries, eth1 has one), but nothing here requires
that pairing.  Would it make sense to constrain this per instance, or at
least document that the presence of the second reg entry also selects the
MAC-ID instance?  The commit message line:

    - Allow 1-2 reg entries for DM816.

reads as though the choice is free.

[ ... ]

> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ti,davinci-ctrl-reg-offset
> +  - ti,davinci-ctrl-mod-reg-offset
> +  - ti,davinci-ctrl-ram-offset
> +  - ti,davinci-ctrl-ram-size
> +  - clocks

[Severity: Low]

clocks is required here, but power-domains stays optional.  For
ti,davinci-dm6467-emac, is clocks alone enough to describe an enabled module?
davinci_emac_probe() only queries the rate and immediately drops the clock:

	emac_clk = devm_clk_get(&pdev->dev, NULL);
	if (IS_ERR(emac_clk)) { ... }
	emac_bus_frequency = clk_get_rate(emac_clk);
	devm_clk_put(&pdev->dev, emac_clk);

There is no clk_prepare_enable() in probe, so the LPSC gate and local reset
appear to be handled by the genpd reached through power-domains.  In
drivers/clk/davinci/psc.c each LPSC registers a domain with
GENPD_FLAG_PM_CLK and davinci_psc_genpd_attach_dev() adds the LPSC clock to
the device's pm_clk list:

	lpsc->pm_domain.attach_dev = davinci_psc_genpd_attach_dev;
	lpsc->pm_domain.flags = GENPD_FLAG_PM_CLK;
	pm_genpd_init(&lpsc->pm_domain, NULL, is_on);

That matches da850.dtsi, the only in-tree user of this compatible, which
carries both clocks = <&psc1 5> and power-domains = <&psc1 5>, and it matches
the example added below.

> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,davinci-dm6467-emac
> +    then:
> +      properties:
> +        syscon: false
> +        clock-names: false
> +        reg:
> +          maxItems: 1

Since this conditional already narrows reg, syscon and clock-names for
ti,davinci-dm6467-emac, would adding power-domains to a required list here be
appropriate?  Without it, a conforming node describes a module that is never
ungated, while probe continues and later register access in emac_dev_open()
and the cpdma setup targets a gated, reset-asserted module.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901-ti-davinci-emac-v3-1-db41e32f3f6d%40gmail.com
