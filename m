Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D02318EFF;
	Wed, 23 Sep 2026 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124480; cv=none; b=JGEPzgBG80lUokUSYsodI+tbg/sCeYX2mBfeq8IRtVYQOYl9uS7K4TUCr2/YYe81CQ/XCftY/qtqe8hT0OknaLDriW4HVrFXptsedlrv8T6HJInCXozEDiNTsaadm5U81HaCwlByHuWdV0p0EmDmtrrHS7SR7Z6Ayg1yMiszy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124480; c=relaxed/simple;
	bh=JjslswZ+cK0TgLkfgmRjiJgw2joYDe8D2sQYbTpNyDI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5XJHLK41KE/hswEXh9K/N9WxUnvfJBaI2nB66HO+tDJucg82Vc5jWm+te848x+I3EV99MmOVIMTy8dc5FHoud4O9OBpkNbO/mBcazpZk9XuplzBtPcsb7C0BVzdVPut/R4zjmsdDZNZFnEQc0TyxUA+dydTFvBujl/iWfAK6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbnFXat/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbnFXat/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C069A1F00893;
	Wed, 23 Sep 2026 00:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790124479;
	bh=poISZ7rCykuhOk1FMux5avHnvoojFN+0PMpIfHOXjdM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FbnFXat/wmaPvo0uQrw/rELgy/atjWnfiEkANI1Pf2+KlKAA+bcEV0+p1+WXLhdGn
	 i3d/HIWwqUgrjTY83ksec/+PK6oSrf8p1hC0tcWve6S1HnH+Uj22gEGOxW5Fscd7To
	 9CWC1n6eWPRTT7kDUFSqjb/c+SvrZsLWklQWekho/T8vImYg3bu8zUefaCqLMROiqX
	 UbYzMHMTWnrvlo81wNL2PmNuYhnODFGZOTZGtVppImqYM+7mCCKQCcGqmDRN/U9ng4
	 xWuQpYoXU8pSNyNcDAwYjTg+v6OYwg/TX9ifxM3Knhz+GqhvKfVnFTVTx3nFVWRD0X
	 Di5wD+NuJ2xPA==
Subject:
 Re: [PATCH net-next v5 2/3] dt-bindings: net: allwinner: add H616 EMAC1
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: richard.genoud@bootlin.com, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wens@kernel.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 clabbe.montjoie@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, peppe.cavallaro@st.com, joabreu@synopsys.com,
 alastair@d-silva.org, mripard@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, andre.przywara@arm.com
Date: Wed, 23 Sep 2026 00:47:57 +0000
Message-ID: <179012447733.2160803.4302270702074784510@kernel.org>
In-Reply-To: <20260921-submit-h616-emac1-v1-v5-2-ada661ed9e9b@gmail.com>
References: <20260921-submit-h616-emac1-v1-v5-2-ada661ed9e9b@gmail.com>
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

- [Low] Concern (validated as a FALSE POSITIVE in the series context):
  the patch documents `allwinner,sun50i-h616-emac1` in…

--

dt-bindings: net: allwinner: add H616 EMAC1

Adds the allwinner,sun50i-h616-emac1 compatible to the sun8i-a83t-emac
binding and to snps,dwmac.yaml, with no older fallback compatible, and
constrains phy-mode to rmii for that compatible.  It is also added to the
snps,dwmac.yaml list that excludes snps,tso.

> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> index 323a669fa9823..2cae0133b3cd4 100644
> --- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml

[ ... ]

> @@ -33,6 +34,7 @@ properties:
>        - const: allwinner,sun8i-r40-gmac
>        - const: allwinner,sun8i-v3s-emac
>        - const: allwinner,sun50i-a64-emac
> +      - const: allwinner,sun50i-h616-emac1
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-emac

[Severity: Low]
This isn't a bug, just a note for the record after checking it.

At this commit allwinner,sun50i-h616-emac1 has no match in the tree:

  git grep h616-emac1 drivers/net/ethernet/stmicro/stmmac/
  (no matches)

so a device tree node using only this compatible, with no older
fallback, validates but does not probe here.

The next and final patch in the series, "net: stmmac: sun8i: add support
for Allwinner H616 EMAC1", adds it to sun8i_dwmac_match[]:

  { .compatible = "allwinner,sun50i-h616-emac1",
    .data = &emac_variant_h616_emac1 },

and emac_variant_h616_emac1 uses sun8i_syscon_reg_field_emac1 with only
.support_rmii = true, which matches both the "separate system-control
clock register" statement in the changelog and the phy-mode: const: rmii
constraint added here.

Since bindings are expected to land before the driver, and the
intermediate state only leaves the compatible unmatched, there is
nothing to change.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-submit-h616-emac1-v1-v5-0-ada661ed9e9b%40gmail.com
