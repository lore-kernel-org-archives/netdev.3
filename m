Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560066;
	b=lu6MLy7SY4cyYzdU1lUpAJa2m12l1RaBLkAsz6yEMdRTPssefWco46GGcEY5w2nb8E/9
	 Jn0Dss4JgqScoiCEi19KqLpT7uwpBdSipQysBEubDJPnjU8SjD4JLp8uPXgOnqMIaEP+Q
	 63wmuCcKDEbxl+C+x6Tz0rp3k2j6JuzprP9Y8RN1w5iEiRolkjuac/EGEea9ZqqiNwnY6
	 ot8I3yu9rMXe+3V9Nc1E9Mc88CRvWaR5hxxm0zv3Y3UuNWT9zDA2Yg94OQpCFtuEu63bX
	 lGYys5tkKaEAW4siOcnrWEq4eHfz3gZWwxOUkoz7gvMFw3VzWUVB9P0SL684dkq7BMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560066;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N1IkFkLJmopa22B4Ujdc/+lpdLepjyVDkGevXe28X7I=;
	b=YV2Wr0pN0FyrF8pRkFdeignYpfVfLFuaitlN4q2qSoP4IpauGvwUpbLokS4lzy008Qgs
	 L2hVrO4cZMEJWcJgEqDyhDzXgdOUtv6Df3Nvr16ppgqdO/ST3G6Hdk10bdPFpFD5Cu6ej
	 goQUVBWMSXI55cI6INHF3SnbWVJgCMsTqe4NRTBamhys1kLnaKFOO0DVaK/8RfSqN1lDb
	 u74Ek8b+igF+r8SeZRl7zwWVp6HWGpWDBsQImE9ztwu3L5RG7RshpLjQzVw46lSbDQ7ls
	 9ZCHfazGNpHdnltJ3KrqBjW0NTX0/tGiqC1xlLs/W33VwEuZNX+BPadX8mY5jUvDHmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O80iRg6z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0C606A31B;
	Wed, 21 Oct 2026 05:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O80iRg6z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B001F000CB;
	Wed, 21 Oct 2026 05:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792560065;
	bh=N1IkFkLJmopa22B4Ujdc/+lpdLepjyVDkGevXe28X7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O80iRg6z5H1Pr/oZT1x/DLOhP8KI6ZZMfxTW+P2esfqgkubw4hhuicVE2UemUX1tX
	 3EXQK7F/XE3fULx1Y0YiEmB8ekLStOqiSD1Me5zMHsFw59IM97qTCgA6eYkQNN5sM0
	 YiPJeQnU0vKxp5jUpalr10pzryvExW1MUX3EdRrVOKtKPs6wkudW/edu5RegKyvflk
	 JCM1Nsc0e1lN8ErsB4kzuO8DBtYyTiu+dh42pDsNrsLjgGbPIVCQXazGv757U7dv5S
	 +V4NPkf2SOKHQO38R/Xe73rWus9O9RXmqZPgpm4vHYn8gjpeSdhG7YaoglfRGLbWWX
	 uZz1HkwG2XljA==
Subject: Re: [PATCH net-next v27 1/3] dt-bindings: net: Document Motorcomm
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
Date: Wed, 21 Oct 2026 05:21:03 +0000
Message-ID: <179256006385.3135.9820779006338159316@kernel.org>
In-Reply-To: <20261020021929.3028490-2-kyle.switch@motor-comm.com>
References: <20261020021929.3028490-2-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml,
  the package 'reg' is redefined as the absolute MDIO address of the…

--

dt-bindings: net: Document Motorcomm YT8824 PHY package

This commit adds a DT binding schema for the Motorcomm YT8824, a package
of four PHYs, built on ethernet-phy-package.yaml. It adds a
motorcomm,package-mode property and defines the package reg as the MDIO
address of the shared top extend register block. It also adds the new
file and a second maintainer to the MOTORCOMM PHY DRIVER entry in
MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> new file mode 100644
> index 000000000000..4c67f8afcf27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml

[ ... ]

> +  reg:
> +    description:
> +      The absolute MDIO address of the YT8824 shared top extend
> +      register block.
> +      For internal mode, this is fixed at 9;
> +      For external mode, it is the base MDIO address of the four
> +      member PHYs plus 4, where base is typically 0x0.
> +      Note that this is NOT the reg of the first member PHY.
> +
> +required:
> +  - compatible
> +  - motorcomm,package-mode
> +  - reg
> +
> +unevaluatedProperties: false

[Severity: Low]
Does the schema enforce "fixed at 9" for internal mode anywhere? I could
not find an allOf/if-then on motorcomm,package-mode that sets reg to
const 9. So a node with package-mode = "internal" and any reg in the
0..31 range inherited from ethernet-phy-package.yaml would still pass
dt_binding_check.

The two address rules also don't line up. The internal mode example below
has the member PHYs at 4..7 and reg = <9>:

    ethernet-phy-package@9 {
        ...
        reg = <9>;

        motorcomm,package-mode = "internal";

        ethernet-phy@4 {

For that layout, the "base plus 4" rule from external mode would give 8.
Could the description explain why the top extend block sits at a different
offset in internal mode?

The reg value matters at runtime. Later in this series,
of_phy_package_join() in drivers/net/phy/phy_package.c reads the package
node's reg into base_addr:

    if (of_property_read_u32(package_node, "reg", &base_addr)) {

and ytphy_read_top_ext()/ytphy_write_top_ext() in drivers/net/phy/motorcomm.c
access offset 0 from that base:

    ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);

With a wrong reg, every top extend access (page select, SerDes PLL control
and so on) would go to a member PHY or to an empty MDIO address.

Would it make sense to add an if/then on motorcomm,package-mode that
constrains reg to const 9 for internal mode?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020021929.3028490-1-kyle.switch%40motor-comm.com
