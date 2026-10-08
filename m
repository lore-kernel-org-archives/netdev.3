Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189AA37DEBE;
	Thu,  8 Oct 2026 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477174; cv=none; b=R3opP/jKPaeh45Lht9UDazp6MLIdOWXfX1FfRi0U5EfDAO4Q4q2l/ORTMqFp9i5ok/MKPZ+8HCB4F6Vl6P+fVf+cmdfHH+XluzfXF+tL4tp/7dlH/rmtczHpRvP2tbokcpW3p72o3Qc4329cZt7j7UPm8AuO6WVsoVxyq/qssTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477174; c=relaxed/simple;
	bh=HglwvM0IfK8X9s3cNbZPQjwlnUZCnnAzrbO2cNBIz+A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WD60Dupo9pyg0T5koXj2HzWfR88G9MTN+ZbdknBBReSRfTrs2DXdeoeU083Bja9eeEilLdm7rZQ2NHwSBuBB0lFuDVdfJszmr52C6M6vXgOaxP1YJHKrKfCut/ZMQTHTXnxQwzN0Fl0qjczbOpyMlJtZP1s29M4XBxAFEzLEKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrIv3h6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrIv3h6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE031F000FF;
	Thu,  8 Oct 2026 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791477172;
	bh=vOmhtgpp0CunsN7e7nTP80xujGK1hi9KxA+e2Q5Bid0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZrIv3h6uHbT7jpD/++Tbd99EhBLTIXx/iEToD8YKEUGJ0YmDpGUOCBe/rAwePrP4P
	 c6k5m/VX+1k1bl2eyzFSrOgzXFnU6c0BmHT9Og0C3Jsfm1fx8W7zQTJW0vbTTjqcxO
	 wWh/txaYR7j5Doys2nX9VEs0xXBeR/ZbW6LgWaDMrrce+qqRTvNwg1XmWptLAxT8yG
	 4yjEcVBi4j+T9pARmbJgo57sxe69VrDvEGdLQ/R8iJ2qytGwtYh8g7OyZaoRYvaf5F
	 dexO212QCB14qQ6+ncvh02ME0vMaIUlD45Afl3ciXJvbVYtse6Gh5I3Mget2wpJOyi
	 Et45NHqzkBCoA==
Subject: Re: [PATCH net-next v10 1/6] dt-bindings: net: pcs: add
 rockchip,rk3568-xpcs support
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, maxime.chevallier@bootlin.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, david.wu@rock-chips.com,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 16:32:51 +0000
Message-ID: <179147717113.434549.5384797662065196680@kernel.org>
In-Reply-To: <20261005223011.1124347-2-coiaprant@gmail.com>
References: <20261005223011.1124347-2-coiaprant@gmail.com>
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

- [Low] The new binding
  Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml…

--

dt-bindings: net: pcs: add rockchip,rk3568-xpcs support

This adds a new binding for the Synopsys DesignWare XPCS on the Rockchip
RK3568 SoC. The XPCS sits on the APB3 bus, connects to a Naneng Combo
SerDes PHY, and exposes four MII ports as ethernet-pcs-mii@N child nodes.
The commit message says the CRU reset lines are left out on purpose.

> diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> new file mode 100644
> index 0000000000000..703fcff0e3f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml

[ ... ]

> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: serdes
> +
> +  power-domains:
> +    maxItems: 1
> +

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +  - power-domains
> +
> +additionalProperties: false

[Severity: Low]
Should this binding describe the XPCS reset inputs? The CRU binding
header already has four reset IDs for this block:

include/dt-bindings/clock/rk3568-cru.h:
#define SRST_XPCS		150
#define SRST_XPCS_TX_DIV10	151
#define SRST_XPCS_RX_DIV10	152
#define SRST_XPCS_XGXS_RX	153

The commit message gives this reason for leaving them out:

  The CRU reset lines (SRST_XPCS*) are intentionally not described: no
  in-tree user requests them, and bring-up relies on the PD_PIPE power
  domain, the SerDes PHY and the in-IP soft reset.

That reason is based on what drivers use today, not on what the hardware
has. Documentation/devicetree/bindings/writing-bindings.rst says:

  DO attempt to make bindings complete even if a driver doesn't support
  some features.

The schema has no resets or reset-names property and ends with
additionalProperties: false. A DT that fully describes the hardware with
something like resets = <&cru SRST_XPCS>, ... would then fail
dt_binding_check and dtbs_check.

The in-IP soft reset also only acts inside the PCS register block. It
does not appear to cover the TX/RX div10 or XGXS RX reset domains.

Could resets and reset-names be added now, even as optional properties?

On a related point that I have not been able to confirm: the generic
snps,dw-xpcs binding documents an sbd_intr_o interrupts output, and
additionalProperties: false also rejects that here. Does RK3568 route
that interrupt to the GIC? If it does, should interrupts be listed too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005223011.1124347-1-coiaprant%40gmail.com
