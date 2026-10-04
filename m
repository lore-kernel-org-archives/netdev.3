Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C646C85F;
	Sun,  4 Oct 2026 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791148223; cv=none; b=a/ppjl6zpGVmEwV0PnPrGhMBT1SnE18GNB9JwxewNofCA0Ga9SShVBENPfaDNPMYa3sp6AocquzJTxpKbjTrqb6gcMUx+hcFQRG6HHVXo790K3y9UfvhdLdsoEvZ4XIPOM0v4WmXXF8kEXTHRkdRoQ5rCuAc85CUas0Rtycs9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791148223; c=relaxed/simple;
	bh=4aSUFRX+tLqnskLAeLetlaXZT5vnxyRRfLsVOsXH+Cw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBoRT8M3u/Y33ObJm0e2gZldfjm9xewV35Ni4UozwvAaHwq+GbTSIxY3GjGnSLs4q/5rj3Go0CXpx3/vog7qEKWu2PbpoM2I70HjpmKsJEfkbpNDgm1UKO2+nivZXP0QxRNzaTok6wzjTKUKEGzBG2hcl5Vb+JM2DDpodAd/f1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw5PiDgD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw5PiDgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E3D1F000FF;
	Sun,  4 Oct 2026 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791148222;
	bh=Y/EtaPFwIeBTlTn5rIOrcMwLMywbgR03fyUX+9XI0jQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lw5PiDgD1KVo9TQyyGIhDE2b2/Kdf7ARPmcauqbVnopZIecI+s2cH3snVK+RveTqI
	 a9HxsHHk0ES6KMUxIidIKnjP6R97jW76Yc26M5/ck11zJYrCBUAMLgPwn9RK5/EM/y
	 Ccxo6aW0s0I0u3eDcIuev/BGRikCFFc1Z2b93HKQYIBZaNEQ8k+z4YdGhP2WHG4HYQ
	 OZmyzi+jhbSal8BQS311kano/WxmDCmyiC1gRGEpGG2tMlSQMjrqQWeNdIAkE4eKfZ
	 gULLln4ZbdihHi7yqOunOgfE1NZbB1zAxke/hXiejMmtwZXXNcwmoGq7aZPOtNS2hH
	 X1kPvSt8DuJEw==
Subject: Re: [PATCH net-next v23 1/3] dt-bindings: net: Document Motorcomm
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
Date: Sun, 04 Oct 2026 21:10:20 +0000
Message-ID: <179114822051.434549.5131570857765960403@kernel.org>
In-Reply-To: <20260930194513.663575-2-kyle.switch@motor-comm.com>
References: <20260930194513.663575-2-kyle.switch@motor-comm.com>
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

- [Low] In motorcomm,yt8824.yaml, the rules for the package `reg` exist
  only as prose, and the schema does not enforce them.

--

dt-bindings: net: Document Motorcomm YT8824 PHY package

This commit adds a new DT binding schema for the Motorcomm YT8824 quad
PHY package. The schema is based on ethernet-phy-package.yaml, and a
vendor property, motorcomm,package-mode, selects internal or 10g-qxgmii
mode. The commit also adds the new file and a co-maintainer to the
MOTORCOMM PHY DRIVER entry in MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> new file mode 100644
> index 0000000000000..4c67f8afcf27a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> @@ -0,0 +1,78 @@

[ ... ]

> +  reg:
> +    description:
> +      The absolute MDIO address of the YT8824 shared top extend
> +      register block.
> +      For internal mode, this is fixed at 9;
> +      For external mode, it is the base MDIO address of the four
> +      member PHYs plus 4, where base is typically 0x0.
> +      Note that this is NOT the reg of the first member PHY.

[Severity: Low]
The rules for reg are only in the description text. No allOf/if-then
block ties reg to motorcomm,package-mode, so this node would pass
dt_binding_check:

    motorcomm,package-mode = "internal";
    reg = <4>;

That passes even though the description says reg is fixed at 9 in
internal mode. Could an if/then be added that requires reg to be 9 when
motorcomm,package-mode is "internal"?

The value matters at runtime, because of_phy_package_join() uses the
package reg as base_addr:

drivers/net/phy/phy_package.c:of_phy_package_join() {
    ...
	if (of_property_read_u32(package_node, "reg", &base_addr)) {
		ret = -EINVAL;
		goto exit;
	}

	ret = phy_package_join(phydev, base_addr, priv_size);
    ...
}

The driver added later in the series ("net: phy: Add driver for
Motorcomm Quad 2.5GbE phy") has ytphy_read_top_ext() and
ytphy_write_top_ext(). Both access the shared top block through
__phy_package_read() and __phy_package_write() with offset 0, so they go
to exactly that address.

The inherited ethernet-phy-package.yaml describes reg as "Commonly the
ID of the first PHY in the PHY package". That is the value this binding
says not to use.

If a board DT sets reg to the first member PHY's address, would the
top-block page select and data writes end up in that member PHY's
register space?

The two modes also seem to use different address layouts. In the
internal-mode example below, the member PHYs are at 4-7 and the top
block is at 9. That is base plus 5, with 8 unused. External mode is
described as base plus 4.

Is that difference real in the hardware? If so, could the description
say so explicitly?

[ ... ]

> +        ethernet-phy-package@9 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "motorcomm,yt8824-package";
> +            reg = <9>;
> +
> +            motorcomm,package-mode = "internal";
> +
> +            ethernet-phy@4 {
> +                reg = <4>;
> +            };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930194513.663575-1-kyle.switch%40motor-comm.com
