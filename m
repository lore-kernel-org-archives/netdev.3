Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C8499F2D;
	Tue,  6 Oct 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304302; cv=none; b=TFRhifwgEpogmGmz0D0sy3BqhV7g3XmxLBIhPTk7qRxKzNH5V3EvacLPYGlP5pvdJCcGaE9w/UcgYOjfIjQ9yzeJua4AA4QfNcTXz8GAn2QM8bFgRJDhDl/frBSn45ueOp5UPo2ToeIs34g5dqPcigz1j3nsz3+60Leu1zvbXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304302; c=relaxed/simple;
	bh=rhT08b+glvPpW1l6yH8H9qdpaK3d17/NBaj+vAT8ryw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YenYgRb6UGybHWxE7n7fzIf1v1NKtRcAAmmbbMoPtM/cwaok6cenW8T9H/1/cPkJZo3BTMqGupibQ4OFhM6xJQk0Pp4LVM0aXxXoAYyiGTqo1HH8bwiZVpJvSZOt6wbGDqn6116tUCZoluLU8LsoUSgKk/AqSa6SN2IlFWWQvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvOu8AtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvOu8AtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14131F0089B;
	Tue,  6 Oct 2026 16:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791304300;
	bh=EQxdhBfbtyMgMfbca0rm+ILKO2CQUIh6DyHyMegL+1M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fvOu8AtKB4A8ASvuODnmUFNHNGH8/HJ/+Gb28doNh90F8npImOhT1UjS37UBUKrbx
	 AHRJif5nzTCkALpHx2aQ/OV5rOGVokNUIxCKVGoSZBlwazHGPvcRkoUObE6Rkx5XUd
	 mvanWiiVaBF8UzVlZL9j55dGhSd43vb12twvuMSFf0NEsBtO+/VXdxE+iPcfjf2Hpq
	 UdDEdnlYlOqfVHZlOYuH6O7T+2syOcdZvtyX600NRjefxyg0qoM1DSW3G8ETvT7PTU
	 ZfyGRR7B1hsjt5/ACdKg3p+tQ9tr2Dk9i7YFoRoPufOGN2kHUZEyLmF41y9IDCrQ10
	 JtPQ+u3koAsmA==
Subject: Re: [PATCH net-next v24 1/3] dt-bindings: net: Document Motorcomm
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
Date: Tue, 06 Oct 2026 16:31:39 +0000
Message-ID: <179130429912.434549.15478715617108213161@kernel.org>
In-Reply-To: <20261002153034.934814-2-kyle.switch@motor-comm.com>
References: <20261002153034.934814-2-kyle.switch@motor-comm.com>
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

- [Low] The YT8824 binding gives the package node's `reg` a device-
  specific meaning: the MDIO address of the shared 'top extend' register…

--

dt-bindings: net: Document Motorcomm YT8824 PHY package

This commit adds a devicetree binding for the Motorcomm YT8824, a package
of four PHYs. The binding is built on ethernet-phy-package.yaml. It adds a
motorcomm,package-mode property and gives the package reg a
device-specific meaning. MAINTAINERS is updated to list the new file and
a new maintainer.

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
Should the schema enforce the constraints that this description states?

The text says reg is fixed at 9 in internal mode. In 10g-qxgmii mode it
says reg is the member PHY base plus 4. The binding has no allOf if/then
block that ties reg to motorcomm,package-mode, so any reg value passes
dt_binding_check. For example, nothing like this exists:

  if:
    properties:
      motorcomm,package-mode:
        const: internal
  then:
    properties:
      reg:
        const: 9

This meaning of reg also differs from ethernet-phy-package.yaml. That file
describes reg as "The base ID number for the PHY package. Commonly the ID
of the first PHY in the PHY package". A DT that follows the common
convention would pass validation here without any warning.

This matters for the driver added later in this series.
ytphy_read_top_ext() and ytphy_write_top_ext() in
drivers/net/phy/motorcomm.c send every top extend access to package
offset 0:

  ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);

phy_package_address() in drivers/net/phy/phy_package.c turns offset 0
into base_addr:

  return base_addr + addr_offset;

of_phy_package_join() reads base_addr directly from the package node's
reg. The call path is:

  of_phy_package_join()
    of_property_read_u32(package_node, "reg", &base_addr)
  phy_package_join()
  ytphy_write_top_ext()
    __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, ...)
      phy_package_address() -> base_addr

If a board DT sets reg to the first member PHY's address, would the driver
write the top extend page select and data values into that member PHY's
registers 0x1e/0x1f?

Could a per-mode if/then block be added to constrain reg? For internal
mode this could be const: 9.

> +
> +required:
> +  - compatible
> +  - motorcomm,package-mode
> +  - reg

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002153034.934814-2-kyle.switch%40motor-comm.com
