Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D56483BEB;
	Mon, 19 Oct 2026 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389203; cv=none; b=W/oAUeYvJoAHt4/PKsKlWfolJII2/n3cHKpdQJpmfgZQoiMEw3lhu5z7IX85ljBVPk8CLyIx4+NrxDWZBQo9jK9pJ3gqC81DULuyhfbiqwkMcdC0+w2dnVkS1OIUUpr2eLQK4/9kpAoQQt+SRuz1ImP6sR/Jqsd2IDQxAhr3Jj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389203; c=relaxed/simple;
	bh=vJV7Qr+Eeb864KRZKdBfni80bJtL6ZfqimVfZz+1qJg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IeQWQWHBD9wkgLcNyi/fah/DPz1gCxfvfnGcJ/WBJMy4mosdpV37mD5+tBl8XhxzgjAluHQCtSB5UkE687X4Gvriu612qrxqr3MtGNTg1mbQtBwA3fLyO2+1d54LR/kaNUIu8UyQtv/+S0S86fUE2d4xVFhkEhDHeXAy/naMGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMm4zCH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMm4zCH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB001F000C4;
	Mon, 19 Oct 2026 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389086;
	bh=6DtvGG5ZnEGfjVnTIlnkEjqB0wdilxWtcVz9lJfD60o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eMm4zCH3b24DZgWIJ+Q+nHIMho4ZRmUA3/xNYBfNpr9e2Px7TpVqOdfi/wgi1+5j5
	 32Pg2tIRF1moBh6jmaBEzaF3w1pK88TNQaZt9OUS0KZClLbBkJuJkCRXBXj3j6NcsR
	 G2rQLqEavnnXbaFBb+f96s0OSH0EcD6VIA9iQiLZCYHw3MUmaKZ2YMk7qeyBc/wX+v
	 SXnsHqtQ644skxv/WNdPpOBnGZrZlcebFh4AMUdBSsZG4aK3ZqSYPtWAzSuahrkREW
	 HSDrXXDliUCfqbi2vz4MAmlOuxTm8TN6VadlflGn1wRNUa97+TUDZLyN0G9J8OJczK
	 /Yofw+PtZGs/g==
Subject: Re: [PATCH net-next v25 1/3] dt-bindings: net: Document Motorcomm
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
Date: Mon, 19 Oct 2026 05:51:24 +0000
Message-ID: <179238908473.3135.16165284021316386587@kernel.org>
In-Reply-To: <20261015145021.2216003-2-kyle.switch@motor-comm.com>
References: <20261015145021.2216003-2-kyle.switch@motor-comm.com>
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

- [Low] The `reg` description in motorcomm,yt8824.yaml gives fixed
  hardware rules: 9 in internal mode, and member-PHY base + 4 in…

--

dt-bindings: net: Document Motorcomm YT8824 PHY package

This adds a YAML binding for the Motorcomm YT8824 PHY package, which holds
four PHYs. It defines the motorcomm,yt8824-package compatible, a
motorcomm,package-mode property (internal or 10g-qxgmii), and a reg that
points at the shared top extend register block. It also adds the binding
and a new maintainer to the MOTORCOMM PHY DRIVER entry in MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> new file mode 100644
> index 0000000000000..4c67f8afcf27a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml

[ ... ]

> +  motorcomm,package-mode:
> +    description: |
> +      PHY package can be configured in 2 modes:
> +      - internal: YT8824 is embedded in the switch, using
> +        an internal interface to the MAC.
> +      - 10g-qxgmii: YT8824 is a standalone external PHY,
> +        connected via 10G QXGMII.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ internal, 10g-qxgmii ]
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
This isn't a bug, but should the internal mode value be enforced by the
schema and not only described in prose?

As written, nothing ties reg to motorcomm,package-mode. The inherited
ethernet-phy-package.yaml only limits reg to the 0..31 range. So a node
with package-mode = "internal" and a reg other than 9 still passes
dt_binding_check.

The driver uses this value directly. of_phy_package_join() reads the
package reg as base_addr, and the YT8824 top extend accessors in
drivers/net/phy/motorcomm.c go to offset 0 from that base:

    ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);

If the package reg is wrong, the top block page select and data accesses
would go to whatever MDIO address was given. Under the base schema
convention, that would usually be the first member PHY.

The external mode rule (child base plus 4) can't be expressed in
json-schema. The internal mode rule could be, though, with something
like:

    allOf:
      - if:
          properties:
            motorcomm,package-mode:
              const: internal
        then:
          properties:
            reg:
              const: 9

> +
> +required:
> +  - compatible
> +  - motorcomm,package-mode
> +  - reg

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015145021.2216003-1-kyle.switch%40motor-comm.com
