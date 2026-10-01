Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379A547142F;
	Thu,  1 Oct 2026 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848473; cv=none; b=lbUOQxtLLwugHJge+SzEksYKTL6HWrfGnFiHgA9+lUXMZxHf2dOPgD2ajAriPhirxaUaGLoCo+dHXBNTT8oHvslfzdR9mRjujXbF+qC935r3KHqxRl7p3fvRuJnKwFSrfZPvjfmWNlqsFM7vXLnposhvzy9F3dlbZbQQR92nk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848473; c=relaxed/simple;
	bh=1xD25xI5ozZc/PJ5KZ2Edgx2w8wDkU1pdjzqEYI9XIM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNUHARMx+fahQUdbelKSZrBSBSX82epcmgNCx2OH27zQB0crLtjvuq3084BRGp7bDO/Bn+QhNswM/2EFNW/FvfCOieLJG25N0ObHEpuAXX5wCtViNZUylHF4SuBJZj/dS1s7rQVSl6fNNMRiRlT/hh8mVNo7pa9ZvuQpAOnw34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNXF/13a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNXF/13a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF831F000FF;
	Thu,  1 Oct 2026 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790848471;
	bh=4eu1oL57dVhp8fFmU4CP4nSCYdhGgLwKiIew50WVtFY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GNXF/13ag8ykU56uKpQglhT4NGLFjWKx9rT+p5O/3YQYit7DhNy4SCRixFWweKZEi
	 o4GGoa1vd0SYnNg2SQPnlRbP9P019E+/IsTk3cPEjpM0ibBWFikIdXEtRYuNpp4FQB
	 ljTSWRvysqnmTBKBvE29eE2vVoo7D3i8zoBFtDRXpflkmdFZr5eYoyNxSi3hqbMfiu
	 BlZkD2PstgIhSi46NYE/I6XW+tk0mE4brQtFQFiItuRc1xiNfP4sd/DgYLA1w3GRH5
	 mRplOrSl15axtP558+39e/BTVDfknjqmDWyqIl3dPmZUteOa0NiV/9ASIdeOD34y3d
	 GhFoeK5XH9JxA==
Subject: Re: [PATCH net-next v22 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
Date: Thu, 01 Oct 2026 09:54:30 +0000
Message-ID: <179084847040.434549.4916716253018620171@kernel.org>
In-Reply-To: <20260929095430.508657-2-kyle.switch@motor-comm.com>
References: <20260929095430.508657-2-kyle.switch@motor-comm.com>
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

- [Low] The commit is titled "dt-bindings: net: Document Motorcomm YT8824
  PHY package" and its body is one line ("Motorcomm YT8824 Ethernet PHY…
- [Low] (Baseline: fixed later in the series.) The concern was that the
  compatible "motorcomm,yt8824-package" and the required…
- [Low] The binding redefines the package node's `reg` as the MDIO
  address of the shared "top extend" register block and gives mode-…
- [Low] The required `motorcomm,package-mode` property (enum: internal,
  10g-qxgmii) mixes two kinds of information.
- [Low] (Speculative, depends on the YT8824 hardware.) The package node
  sets `unevaluatedProperties: false` and defines only compatible, reg…

--

dt-bindings: net: Document Motorcomm YT8824 PHY package

This adds a new YAML binding for the Motorcomm YT8824 quad PHY package.
It builds on ethernet-phy-package.yaml, adds a vendor
motorcomm,package-mode property, and uses the package reg as the address
of the shared top extend register block. It also updates the MOTORCOMM
PHY DRIVER entry in MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> new file mode 100644
> index 0000000000000..4c67f8afcf27a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> @@ -0,0 +1,78 @@

[ ... ]

> +$ref: ethernet-phy-package.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - motorcomm,yt8824-package

[Severity: Low]
At this commit, nothing in the tree uses the motorcomm,yt8824-package
compatible or the motorcomm,package-mode property.

The later patch in the series, "net: phy: Add driver for Motorcomm Quad
2.5GbE phy", appears to add the user:

  - yt8824_probe() calls devm_of_phy_package_join().
  - yt8824_phy_package_probe_once() reads motorcomm,package-mode and
    returns -EINVAL when it is missing.

That matches the binding making the property required. It looks
resolved by the end of the series, so I'm only noting it here.

> +
> +  motorcomm,package-mode:
> +    description: |
> +      PHY package can be configured in 2 modes:
> +      - internal: YT8824 is embedded in the switch, using
> +        an internal interface to the MAC.
> +      - 10g-qxgmii: YT8824 is a standalone external PHY,
> +        connected via 10G QXGMII.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ internal, 10g-qxgmii ]

[Severity: Low]
Should "internal" be a separate compatible instead of a property value?
It describes an embedded integration variant with a different
programming model:

  - The later driver uses yt8824_internal_config_init_paged() for it,
    but yt8824_extern_config_sds_init_paged() and
    yt8824_extern_config_utp_init_paged() for the external case.
  - reg is fixed at 9.

writing-bindings.rst says "DON'T add properties to avoid a specific
compatible".

"10g-qxgmii" is the standard phy-mode string, and the connected MAC
nodes already carry it in phy-mode. In the later driver patch,
yt8824_phy_package_probe_once() matches it with phy_mode_check(). Nothing
compares priv->package_mode with phydev->interface.

Could a DT with package-mode = "internal" and a MAC using 10g-qxgmii (or
the reverse) pass validation? In that case the PHY SerDes would be set
up differently from the MAC side.

qcom,qca807x.yaml has a similar qcom,package-mode for SerDes selection,
so the phy-mode overlap may be acceptable. The internal variant still
seems to fit a compatible better.

> +
> +  reg:
> +    description:
> +      The absolute MDIO address of the YT8824 shared top extend
> +      register block.
> +      For internal mode, this is fixed at 9;
> +      For external mode, it is the base MDIO address of the four
> +      member PHYs plus 4, where base is typically 0x0.
> +      Note that this is NOT the reg of the first member PHY.

[Severity: Low]
These mode-dependent rules exist only in the description. There is no
allOf/if/then keyed on motorcomm,package-mode, such as reg: const: 9
for "internal". So reg only inherits the 0..31 range from
ethernet-phy-package.yaml.

Would a node with package-mode = "internal" and any other reg value
still pass dt_binding_check?

The meaning also differs from the generic ethernet-phy-package.yaml
text:

      The base ID number for the PHY package.
      Commonly the ID of the first PHY in the PHY package.

A DT author could follow that convention. In the later driver, top
extend accesses go through this path:

  ytphy_write_top_ext()
    __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, ...)

phy_package_address() returns base_addr + 0 here. With the wrong reg,
these writes could reach member PHY 0's extended page registers instead
of the top block.

The binding also doesn't say which MDIO addresses the member PHYs use in
internal mode. The example puts them at 4..7 and the top block at 9.
Could the description document this, including why address 8 is
skipped?

> +
> +required:
> +  - compatible
> +  - motorcomm,package-mode
> +  - reg
> +
> +unevaluatedProperties: false

[Severity: Low]
The package node sets unevaluatedProperties: false and defines only
compatible, reg and motorcomm,package-mode. How would a board describe a
package-level reset GPIO, supply rails or a SerDes reference clock for
the standalone 10g-qxgmii configuration?

This depends on the YT8824 hardware, which I couldn't confirm.

If the chip has one shared reset pin, the only option left is the
per-member reset-gpios from ethernet-phy.yaml. That would describe one
shared pin as four per-PHY resets.

writing-bindings.rst says "DO attempt to make bindings complete even if
a driver doesn't support some features."

[ ... ]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6de1ff058db64..39da17c8aa875 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18413,8 +18413,10 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
>  
>  MOTORCOMM PHY DRIVER
>  M:	Frank <Frank.Sae@motor-comm.com>
> +M:	Kyle Switch <kyle.switch@motor-comm.com>

[Severity: Low]
The commit message doesn't mention this M: line. It makes the author a
co-maintainer of the whole MOTORCOMM PHY DRIVER entry, including
drivers/net/phy/motorcomm.c and motorcomm,yt8xxx.yaml, not only the new
binding.

Should this be a separate patch? Or could the changelog at least mention
it, with an ack from the current maintainer?

The F: line for the new binding fits this patch. The later patches in
the series don't touch MAINTAINERS again.

>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
>  F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>  F:	drivers/net/phy/motorcomm.c

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929095430.508657-1-kyle.switch%40motor-comm.com
