Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2C42882B;
	Sun, 18 Oct 2026 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792305934; cv=none; b=gDd5ZneO2NR2LQa/meD3GO5rl8L5IoZFlCynZpNgPrghvifE0uFPohV9xybDkDHenkKUJ61uLs1NKGRruD2OctIKtNp9l2Bpdx+90n+CcwZKDJFmv3EOOhS0381QDVw49OYamvMw2P1zJ0iDr835MoVNe80gEtn3htwSCp6Igcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792305934; c=relaxed/simple;
	bh=kGVfoNZHNRN1OQPN2rIAUMB8E7o995LRGVgxQiiOYco=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3vF8n4A6CIXzGBsCw0eD69CXPV2VNiW2jWcimErcPCj8fEF7MBr4xmUfRRplmn2YiBlsGfFqZwO7qJCzq3ptxlNkm4UoVA5icqiFwVfyxQiciiAyVs5eS0++AVrNHPzLlkeaFDRWBfhu1Y89WxPuHARc3rB7rCw2bWjbfgQidk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDTtpgBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDTtpgBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DAC1F000C5;
	Sun, 18 Oct 2026 06:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792305933;
	bh=Aw3jt4zHNgm4deRIvVS+AZXuU23cUxhaCwFbDt3G//8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IDTtpgBKYaBm2zaIDQhOZ2PSPkv++aTyX8wVxTj2Q0K4oYfe2P93j8UmQzy8lF96z
	 DUbtyoT9e6jjvvowflopO2xrDud7A/6k90+MWxFWOqOPUVGdheUC5VbHjxVDQb45jP
	 QaUwTFsOn8GIQ0mzFKM0tjGXBHU4ItG8DV4W6eyd/LQWwQLPABkuzuDGL+QJwJY1ex
	 KtxIHmkUVQ0ShJsuOFgWVp63M5Lh811FxiJz14zK5bn7wk+HGEST9FP71tDuGB+k8T
	 K1FdW67lK9RxBnPG4N5JDaWxFeQenCyXH7NsUoxkwKtrc9Q520suhkHwmvhuF191kk
	 Wob3D59UMvzxQ==
Subject: Re: [PATCH net-next v12 4/6] dt-bindings: net: rockchip-dwmac:
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
Date: Sun, 18 Oct 2026 06:45:32 +0000
Message-ID: <179230593214.3135.8437298852154217978@kernel.org>
In-Reply-To: <20261017054406.1828061-5-coiaprant@gmail.com>
References: <20261017054406.1828061-5-coiaprant@gmail.com>
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

- [Low] The rule that makes pcs-handle required is true even when phy-
  mode is absent, and the patch adds a redundant rule that the commit…

--

dt-bindings: net: rockchip-dwmac: document pcs-handle

This adds a pcs-handle property to the Rockchip GMAC binding for the SGMII
support added later in the series. It also adds two allOf rules for
rockchip,rk3568-gmac. The first requires phy-mode. The second requires
pcs-handle when phy-mode is "sgmii".

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

[Severity: Low]
Is the sgmii if above true when phy-mode is missing?

In JSON Schema, a properties subschema passes when the property is not
there. That means a rockchip,rk3568-gmac node without phy-mode matches
this if. It then gets a "pcs-handle is a required property" error, even
though nothing says the link is SGMII.

The standalone phy-mode block before it does not make this if false.
Each allOf entry is checked on its own, so that block only adds its own
error.

Is the standalone phy-mode block needed at all? rockchip-dwmac.yaml
already pulls in snps,dwmac.yaml with "- $ref: snps,dwmac.yaml#" under
allOf. That schema already requires phy-mode at the top level:

Documentation/devicetree/bindings/net/snps,dwmac.yaml:
required:
  - compatible
  - reg
  - interrupts
  - interrupt-names
  - phy-mode

So an rk3568-gmac node with no phy-mode would get two "phy-mode is a
required property" errors and a misleading pcs-handle error.

The commit message also does not say that phy-mode becomes mandatory for
rk3568. It only says pcs-handle is required when phy-mode is "sgmii".

Could required: [phy-mode] go inside the sgmii if instead, which is the
usual idiom? The standalone phy-mode block could then be dropped.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017054406.1828061-1-coiaprant%40gmail.com
