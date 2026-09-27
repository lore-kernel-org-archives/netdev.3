Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BAB3C09E8;
	Sun, 27 Sep 2026 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512107; cv=none; b=tXJxddnpIlSQjY0oSL9kFiUG5RsgOIE/IdLpTLyHxLbkCZ2WuuEIMtye+gHlkioq+suaR7GbovWnSxSqs0BKGqlQJZGdEPRez5V7q6DZxNdx6VHzgI2g8Mmul3HywrFNoZQ6slYdiDjo41lLy4yvImSAKL/ZUqgWhhWEUKGk7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512107; c=relaxed/simple;
	bh=1o9hDzsKyA6zPhpEOaaX8ZpeFpYeaQbaHCVHQcjTVHk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4xjEc5EPKmDfgarzCoBHqYFGgYHsaTPWRRnaE5GsugQUSbhTDJAqRqBKqw0jIvbOURe6866YfmBRh67hzoB3W40UX7lzUsKtxvQBrvCWID7PBiziVCgAamyzpy4YSZkj8zCU24DLM1ycI9SaY6xYDAjc13jLxAvUUIFCWlylmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKYt9EBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKYt9EBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEB01F000FF;
	Sun, 27 Sep 2026 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512105;
	bh=wWjTZHxKYr1rh6Hbv6k8LGLjXum/V5dZAB6Mf9UvOAQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bKYt9EBpZ+A7BBjtgACXAdEswtyzSfnGnFsS813MGjAF0K12JSsJkgROE5IT2hTJO
	 cmmrhifDuk6tYprcML0P285dMpIa4cmOlLXVSC5pEqQC/1b/pTNsveofdXcUWhuuAz
	 /AV0KIq/X2cnvXNadjKB7xp/2f0CCBcqzk2ApZlQswzMq4UaDAv6eEz4TyEW+OrcMc
	 McPGG50utluNe6IpAyEQi/296VXKqjQPLp2BeKGG89m5i0rGNEUI5+RWcfYcte2s3B
	 8J+AwUNUP7LBhadpnCFyK0iX4y8a4WaZUKULYvz2Jne6hcvLiYaSHBqENkpNE1atx8
	 vPMMOvREkXfCg==
Subject:
 Re: [PATCH net-next v3 2/8] dt-bindings: net: Add SoC-e SWIP MDIO controller
From: netdev-bot+sashiko@kernel.org
To: v.strassheim@linutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 martin.kaistra@linutronix.de, b.spranger@linutronix.de
Date: Sun, 27 Sep 2026 12:28:24 +0000
Message-ID: <179051210447.2160803.13761066598804865928@kernel.org>
In-Reply-To:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
References:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-2-ddebafcb9ba7@linutronix.de>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In soce,swip-mdio.yaml the MDIO controller owns the whole
  32-bit 'control' register (<0x200 0x4>), which the binding calls the…
- [Low] The only compatible is 'soce,swip-mdio-23-02', and neither the
  binding nor the commit message explains the '23-02' suffix.

--

dt-bindings: net: Add SoC-e SWIP MDIO controller

This adds a devicetree binding for the MDIO controller built into SoC-e
SWIP Ethernet switch IP cores. The controller has a data register region
and a shared transaction control and bus selector register. It is the
parent bus for an MDIO mux that reaches the external MDIO interfaces.

> diff --git a/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml b/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml
> new file mode 100644
> index 0000000000000..3cf4bde0508ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/soce,swip-mdio.yaml
> @@ -0,0 +1,47 @@

[ ... ]

> +description:
> +  MDIO controller integrated into SoC-e Ethernet switch FPGA IP cores.
> +  The controller accesses multiple external MDIO buses through a mux.
> +
> +$ref: mdio.yaml#
> +
> +properties:
> +  compatible:
> +    const: soce,swip-mdio-23-02

[Severity: Low]
What does the 23-02 suffix mean? Neither the binding nor the commit
message explains it. It looks like a YY-MM IP release tag. The DSA
driver commit in this series mentions testing an MRS 25.01 core.

This MDIO block is part of the larger SWIP switch. It sits at
0x200-0x20f inside the switch register window.
Documentation/devicetree/bindings/writing-bindings.rst says:

  For sub-blocks/components of bigger device (e.g. SoC blocks) use rather
  device-based compatible (e.g. SoC-based compatible), instead of custom
  versioning of that component.

Could the version scheme be documented, or could a device-based
compatible be used instead? As it stands, it isn't clear whether each
future IP release would need a new compatible.

> +
> +  reg:
> +    items:
> +      - description: MDIO parameter, write data, and read data registers
> +      - description: Shared MDIO transaction control and bus selection register

[Severity: Medium]
Is this the right way to describe the bus selector? This node claims the
whole 32-bit control register at <0x200 0x4>, bus selector field
included. The binding gives the mux no way to reach that field. There is
no #mux-control-cells and no mux child node, even though the description
says the buses are reached through a mux.

Later in the series, the example in "dt-bindings: net: dsa: Add SoC-e
SWIP switch" covers this with a sibling mdio-mux-mmioreg node:

Documentation/devicetree/bindings/net/dsa/soce,swip.yaml:
    mdio-mux@202 {
        ...
        reg = <0x202 0x2>;
        ...

That range is the upper halfword of the register that mdio@204 already
claims as control. The driver commit "net: mdio: Add SoC-e SWIP MDIO
controller driver" says the same thing: the selector is bits 26:16, and
a generic MMIO MDIO mux manages it through the upper 16-bit halfword.

The result is two sibling nodes with overlapping reg ranges for one
hardware register. This only works because neither driver requests its
region exclusively. soce_mdio_iomap() in drivers/net/mdio/mdio-soce.c
does:

    return devm_ioremap(dev, res.start, resource_size(&res));

mdio_mux_mmioreg_switch_fn() also does a plain ioremap() on every
switch. If either driver moved to devm_platform_ioremap_resource(),
probe would fail with -EBUSY.

Nothing fails with the current series. There is no -EBUSY today. The
mux's 16-bit read-modify-write and the 32-bit read-modify-write in
soce_mdio_start() are serialized: mdio_mux_read() and mdio_mux_write()
hold the parent bus mdio_lock around both switch_fn() and the parent
access.

The concern is the DT ABI. Once this binding is merged, moving to a
description without overlapping ranges would break compatibility. Two
options would avoid the overlap:

  - make this controller a mux provider with #mux-control-cells
  - have the controller register its child buses itself

Would it be better to choose one of these before the binding is merged?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7%40linutronix.de
