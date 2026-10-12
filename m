Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038F427FB7;
	Mon, 12 Oct 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831693; cv=none; b=Lz9vTSYAQF2I51AKieZKmzRaUVcNWCqkUMIqpjQpTJy11O0Ru8oTI7Sr/uivq5kxR+HqNj66bbX3Dt8cn2jYbJOei9ZjSfveEtp6nuofwp95yvwfxM7IkKyfiK5S84lngVdraBma4yPRxhBR/LI8XVu0UvDg3y05xkXxtAHbjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831693; c=relaxed/simple;
	bh=hx93oBV5ay7h1WKyBPg33bFUUDHTPHEjKcm5CfVX5+Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SWz044RZSpvHr+oDfQTk/66QPW+/H+Mvw8hg/mXba59p2RwDX2Tgn6t4Yn2zs1nWrbTCGHdDuV/WVD7vNfxVbEt8cHzHud7jygQ1P5zufYfghyUA2AeqP5ApoiqDAMNMg6XWbmNjKFhmLO8xCEWcBGfhDP7CkPxuGPGQr9Fj77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1212i0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1212i0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54601F008A1;
	Mon, 12 Oct 2026 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831691;
	bh=zHYdiOvoPMM4fKDDQu6aYgmkSz9zei65hX1+eT9iVnE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m1212i0Heg3Ok5j7k4aYr3MYBbpWrUTI4j8sr2lTfEPh0NHtvXqOHwh0+pWFtYUei
	 12qErMtNs/m6V8MW0VeNkZY33fSio1nn9NBV3a5+7vEPu4Zjd6E7V9oipyQa6jW54h
	 tN5OEcD6VNzQlPU1lB8HBQYE8kJc7A8YI/IV6xrIRlWwDBMo1gdUwkbCKoJQ9+4gpZ
	 HWGMyxyBd0Zv9Mmt2X7CxOlDaTzkRX1/CkB0D4XXkeoIdjY58i7pAcpkffqDNjyaDr
	 I/luYbsjrC4H62aZ3uVYMRrJkDEteNAaaP6i1LEhdtXwrYe/ZbHxjoyeTOYVlQCrcY
	 gjHIvejXagSNw==
Subject: Re: [PATCH net-next v11 4/6] dt-bindings: net: rockchip-dwmac:
 document pcs-handle
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 david.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 19:01:30 +0000
Message-ID: <179183169035.434549.10534973207994828766@kernel.org>
In-Reply-To: <20261008175225.3375274-5-coiaprant@gmail.com>
References: <20261008175225.3375274-5-coiaprant@gmail.com>
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

- [Low] The patch adds an allOf entry to
  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml (lines…
- [Low] At this commit, rockchip-dwmac.yaml documents `pcs-handle` and
  requires it for rk3568 when phy-mode is "sgmii", but nothing in dwmac-…

--

dt-bindings: net: rockchip-dwmac: document pcs-handle

This patch documents a pcs-handle property in the Rockchip GMAC binding.
It makes the property required for rockchip,rk3568-gmac when phy-mode is
"sgmii". The SGMII driver support that uses the property arrives later in
the series.

> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 80c252845349c..c434450fd07ff 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml

[ ... ]

> @@ -159,6 +165,27 @@ allOf:
>          clocks:
>            minItems: 5
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-gmac
> +    then:
> +      required:
> +        - phy-mode
> +

[Severity: Low]
Is this block needed? The commit message doesn't mention it.

rockchip-dwmac.yaml already includes snps,dwmac.yaml through its allOf:

  - $ref: snps,dwmac.yaml#

That schema already requires phy-mode for every node, with no condition:

Documentation/devicetree/bindings/net/snps,dwmac.yaml:
required:
  - compatible
  - reg
  - interrupts
  - interrupt-names
  - phy-mode

So phy-mode is already required for all Rockchip GMAC compatibles,
including rk3568, and dt_binding_check / dtbs_check give the same results
with or without this block.

Repeating the requirement for rk3568 only could also suggest that phy-mode
is optional on the other Rockchip SoCs.

If the goal is to keep the sgmii if clause below from matching when
phy-mode is absent, the inherited requirement already does that. Could
this block be dropped? Alternatively, a local required: [phy-mode] could
go inside the sgmii if clause.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-gmac
> +        phy-mode:
> +          contains:
> +            const: sgmii
> +    then:
> +      required:
> +        - pcs-handle
> +

[Severity: Low]
At this commit, nothing in dwmac-rk.c reads pcs-handle yet, and the driver
doesn't accept SGMII. Doesn't that leave the binding and the driver out of
sync if someone bisects to this commit or applies only part of the series?

The consumer arrives in the next patch, "net: stmmac: dwmac-rk: add SGMII
support for RK3568". That patch adds rk_pcs_init():

drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:rk_pcs_init() {
    ...
	pcs_node = of_parse_phandle(node, "pcs-handle", 0);
	if (!pcs_node)
		return -ENODEV;
    ...
}

It also adds the SGMII pcs_init/pcs_exit/select_pcs handling to
rk_gmac_probe(). By the end of the series the binding and driver match,
and putting the binding before its user is the usual DT submission order.
I'm only noting it here for completeness.

>  unevaluatedProperties: false
>  
>  examples:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008175225.3375274-1-coiaprant%40gmail.com
