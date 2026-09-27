Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115013DD874;
	Sun, 27 Sep 2026 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512109; cv=none; b=sL7huZXZDZxSS1R0AAwLOe2vF7m37h5hnmsa74L//feisuqLSmLh6nnz68E9MLwjlgKm68+sprx/JsMp3ceAkjHkPjCdmgEVRWVhRxpBFZzRJJCQWOcpFOttmZ5aMDzEs9vH3kwRPqS7rFBjkP3pnf8gtA751/OLz5ztroEt3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512109; c=relaxed/simple;
	bh=PlYT9dJhGBOHr+Ul/zykF5eM5SKlnMnGrrbSfekuFUM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVl9rgJFP8BxTDl1CH0I7Ty/E1fgkImkysDWJxa5AL8OHxrCd+0P/xSq0KFsD0omfVRKmXTY3h8LzIxOTdlTa35uA8CJ+75QysQm5Gw+zcC1RbwAL74AGr+B0sVICLl4zZ84k4YUbkTErJEQsG/vX+rcq3kPQijPJm+FV/CfsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyGpGsqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyGpGsqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDF61F00893;
	Sun, 27 Sep 2026 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512107;
	bh=QwwMttGUB6RY+D6bJBWwrCbr4/Gnd0Vx/xlXkzh7eFY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fyGpGsqL7+mvqiHl48AhIbPY0jNS2F2PsBX2gHTfE8LfN/GiJHf6RzrU9WY7DI5y+
	 7GqHUVos8ndP+SLvXFZq8c3IRU2PGF4gOaZSsOfEOQS9dHmhCnMIwfLrMdkqK4Yklc
	 gqEW/fcYlf17/VjNy96WU4Ps9W23HrVNjpB/xbXTBNquzA93Qixb5tHJ5oJvbbZ+YY
	 JIdFugaZZ7QWBtDcyA+RcM/gcnaXOzWZcvMSwhY2zrRdsGMgkc2+lv9Qy8NXLdGbXa
	 SB1rd0vJfL3axkF5GED7Ncr2u5DOcOu9hbI61+mnpdy1znHHdfbLxriEuvEbWMeFk1
	 Z//8fEG9/3Sfg==
Subject:
 Re: [PATCH net-next v3 3/8] dt-bindings: net: dsa: Add SoC-e SWIP switch
From: netdev-bot+sashiko@kernel.org
To: v.strassheim@linutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 martin.kaistra@linutronix.de, b.spranger@linutronix.de
Date: Sun, 27 Sep 2026 12:28:26 +0000
Message-ID: <179051210605.2160803.17533323844368992889@kernel.org>
In-Reply-To:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>
References:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>
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

- [Low] Documentation/devicetree/bindings/net/dsa/soce,swip.yaml accepts
  the MMIO child nodes mdio@204 and mdio-mux@202 but does not require…
- [Low] In Documentation/devicetree/bindings/net/dsa/soce,swip.yaml, the
  per-port constraints (the dsa-port.yaml $ref, `reg` maximum 30,…

--

dt-bindings: net: dsa: Add SoC-e SWIP switch

This commit adds a DT binding for SoC-e FPGA-based Ethernet switch IP
cores. The compatible string encodes the layout of the identification
registers. The binding describes the Ethernet ports and the optional
integrated MDIO controller with its MMIO mux.

> diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
> new file mode 100644
> index 0000000000000..d614fb2a29d3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml

[ ... ]

> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +  mdio@204:
> +    $ref: /schemas/net/soce,swip-mdio.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Integrated MDIO controller bus on the master side of the mux.
> +
> +  mdio-mux@202:
> +    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
> +    unevaluatedProperties: false
> +
> +  ethernet-ports:
> +    type: object
> +    patternProperties:
> +      '^ethernet-port@[0-9a-f]+$':
> +        type: object
> +        $ref: dsa-port.yaml#
> +        unevaluatedProperties: false

[Severity: Low]
Should this pattern be '^(ethernet-)?port@[0-9a-f]+$'?

This schema includes ethernet-switch.yaml through dsa.yaml. That file
also accepts port@N nodes under ethernet-ports, with only a type check:

    '^(ethernet-)?port@[0-9a-f]+$':
      type: object
      description: Ethernet switch ports

As a result, a node named port@3 counts as evaluated and passes
validation. None of the checks here apply to it: the dsa-port.yaml
reference, the reg maximum, the required reg and phy-mode, and the
phy-mode enum.

dsa_switch_parse_ports_of() in net/dsa/dsa.c still uses such a node. It
walks every available child with for_each_available_child_of_node() and
does not check node names. An unvalidated phy-mode can then reach
soce_phylink_get_caps(), which only handles the listed modes.

The other DSA bindings that constrain port nodes (lantiq,gswip, mt7530,
ksz, sja1105, qca8k and others) all use '^(ethernet-)?port@[0-9a-f]+$'.

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - ethernet-ports

[Severity: Low]
When the mdio@204 or mdio-mux@202 children are present, should ranges,
#address-cells and #size-cells be required?

As written, a switch node that has those MMIO children but no ranges
still passes dt_binding_check. The kernel then cannot translate the
children's reg:

drivers/of/address.c:__of_translate_address() {
    ...
	ranges = of_get_property(parent, rprop, &rlen);
	if (ranges == NULL && !of_empty_ranges_quirk(parent) &&
	    strcmp(rprop, "dma-ranges")) {
		pr_debug("no ranges; cannot translate\n");
		return 1;
	}
    ...
}

So mdio_mux_mmioreg_probe() fails in of_address_to_resource() with
"could not obtain memory map". soce_mdio_iomap() in
drivers/net/mdio/mdio-soce.c fails the same way. No PHY behind the mux
can then be reached.

dtc already warns about missing cell properties, but it does not warn
about a missing ranges.

Would a dependentRequired (or dependencies) entry help here? It could
make mdio-mux@202 and mdio@204 require ranges, #address-cells and
#size-cells.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7%40linutronix.de
