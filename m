Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844088;
	b=JX2tIS6mGyAkgHHF+QPNR0NAAdldsMQzU9AS7+sE53u6oyNFjX3TDtRFaXU3KGd7TXRl
	 FqX2Q9dQ545ARaYU76UU8F/cXyN08k0WuNbiQlMgcSl39mhXK8iMLEuC2iK+PKmCHx49I
	 4SlFgLGFCWhPw0NG1ksM+7GygkQ28sjnfkBBawMNMw58NXpwv2XAt2zkClYDGXYwlgtKd
	 bPCj+CdPnQcpbQHYwJIveP44rPEtbPPNbZWCTEc5sXCAkpe/D31C1Irokfl462vXH5DSr
	 2PPhexNQ/eGcYYBKueZg46M2fxDnd3qdAcb5PMq5ZG+gSlNe+OtgpCwmzpavKUk2aPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844088;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=K7LxKW+FRj6QhUxGWybJkziD8iYolGetDeRLOo4voUU=;
	b=IRnLYA7gVRuIrwNiZmkOeGvSo5zshFNawENCxsm8qjYB9cUoSJBNBO27gCQuD0bOf1TB
	 u7Wh4WeBuQRGx5D88m+o3RczdbQWGST19agQC28hybc6s+pVnaAiAB4z4TUBKTXGdu/AG
	 PZjaEVFQwizTrLJtpSoxTmU2UFj4DUx2oAHbyPAgdW2Gin0MU+bDFsTDvp4mvBajmeftk
	 uwMHivhSNR8J2WUn61btZ85FJFlIFjmuoxxZ3blXIMsP/7nC64svvYGPpMmI6sH/jsb1G
	 aoBWrtE5FPqxM3lB+fvDPTmnTIKlv/8N55w9b6DypMEwbrWcFhppgDI+l6h5yWD6f5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jadg3h8S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBF606A31A;
	Sat, 24 Oct 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jadg3h8S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577411F01825;
	Sat, 24 Oct 2026 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792844087;
	bh=K7LxKW+FRj6QhUxGWybJkziD8iYolGetDeRLOo4voUU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jadg3h8SLRb3uUDnsNzEkg1KuYpxgcXTiIhDw3HrtvHPdm/Ff70F6TssleNtZkArV
	 8JHRx/LjVeNGGUrfaOZNMCsMAMvGaLxdGb59xyhYp9K9qGPIeirup446eQJuCVEkp8
	 RvsTRP+pPB2JmXO2vF99A5VVEL1e6xnKmY5TeW5Jd3EY7WNlOomoakwl/c8WCztKUm
	 +PAOrPTes4AL9YwyrunlLh1Lz8otExVHTQmj/HLrPWgPnyd91bb+fMKdS+G4AddGQZ
	 iN0CWJWgIes/rLWjwcahyrKIDYHuUJHdZKWDo1s1dFezUkomUNrqbLzlVV9MaUjWQa
	 IH+9IFBthob5Q==
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: Make Aspeed
 compatibles standalone
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch
Date: Sat, 24 Oct 2026 12:14:45 +0000
Message-ID: <179284408591.3134.16629228418200101664@kernel.org>
In-Reply-To: <20261020-support_ast2700-v4-1-4d36b40939b3@aspeedtech.com>
References: <20261020-support_ast2700-v4-1-4d36b40939b3@aspeedtech.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's reason for the change does not hold up
  for the code at this commit.
- [Medium] The binding now asks for a standalone "aspeed,ast2400-mac" /
  "aspeed,ast2500-mac" / "aspeed,ast2600-mac" compatible with no…
- [Medium] The patch deletes the `items: [enum: [aspeed,ast2400-mac,
  aspeed,ast2500-mac, aspeed,ast2600-mac], const: faraday,ftgmac100]`…

--

dt-bindings: net: ftgmac100: Make Aspeed compatibles standalone

This patch changes the faraday,ftgmac100 binding so that aspeed,ast2400-mac,
aspeed,ast2500-mac and aspeed,ast2600-mac are standalone compatibles. It
drops the two-string form that carried the "faraday,ftgmac100" fallback.
The examples now use "aspeed,ast2500-mac" on its own.

> The aspeed,ast2400-mac, aspeed,ast2500-mac, and aspeed,ast2600-mac
> compatibles are currently only valid when paired with the generic
> "faraday,ftgmac100" fallback: if a node ever bound through the
> generic entry alone, ftgmac100_probe() would set
> rxdes0_edorr_mask/txdes0_edotr_mask to BIT(15) instead of the Aspeed
> BIT(30), skip Aspeed clock setup, and leave the DMA mask too narrow.

[Severity: Medium]
Is this rationale accurate for the driver at this commit?

In drivers/net/ethernet/faraday/ftgmac100.c, ftgmac100_of_match[] has
dedicated Aspeed entries ahead of the generic one:

    { .compatible = "aspeed,ast2400-mac",
      .data = &ftgmac100_match_data_ast2400},
    ...
    { .compatible = "faraday,ftgmac100",
      .data = &ftgmac100_match_data_faraday },

The most specific compatible wins. So a node with "aspeed,astXXXX-mac",
"faraday,ftgmac100" always gets the Aspeed mac_id, and ftgmac100_probe()
then does:

    if (priv->mac_id == FTGMAC100_AST2400 ||
        priv->mac_id == FTGMAC100_AST2500 ||
        priv->mac_id == FTGMAC100_AST2600) {
        priv->rxdes0_edorr_mask = BIT(30);
        priv->txdes0_edotr_mask = BIT(30);
        priv->is_aspeed = true;

The two-string form this patch removes therefore can't reach the BIT(15)
and no-clock path. The only node that could reach it is one with just
"faraday,ftgmac100", and the binding still accepts that through
"- const: faraday,ftgmac100".

The DMA mask claim also doesn't seem to match the driver. Nothing under
drivers/net/ethernet/faraday/ calls dma_set_mask*() at this commit. Even at
the end of the series, the only DMA mask set is the 35-bit one under
FTGMAC100_QUIRK_DMA_35BIT, and only the AST2700 match data selects it.

The note below the --- line says there is no known combination "where a
node has actually bound through the generic entry and gotten the wrong
EDORR bit". Before commit 03a2aba50b2c ("net: ftgmac100: List all
compatibles"), though, "faraday,ftgmac100" was the driver's only of_match
entry. Every Aspeed MAC bound through it, and the driver detected Aspeed
afterwards with of_device_is_compatible(). In those kernels the fallback
was how the device bound, not a hazard.

Could the commit message give the real reason for the change and drop the
DMA mask claim?

> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf6..c870dd0bda7b2 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -13,12 +13,10 @@ properties:
>    compatible:
>      oneOf:
>        - const: faraday,ftgmac100
> -      - items:
> -          - enum:
> -              - aspeed,ast2400-mac
> -              - aspeed,ast2500-mac
> -              - aspeed,ast2600-mac
> -          - const: faraday,ftgmac100

[Severity: Medium]
Should this items branch stay in the oneOf with deprecated: true instead of
being removed?

All eight Aspeed MAC nodes in the tree still use the two-string form:

arch/arm/boot/dts/aspeed/aspeed-g4.dtsi (mac0, mac1):
    compatible = "aspeed,ast2400-mac", "faraday,ftgmac100";

arch/arm/boot/dts/aspeed/aspeed-g5.dtsi (mac0, mac1):
    compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";

arch/arm/boot/dts/aspeed/aspeed-g6.dtsi (mac0 to mac3):
    compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";

Every remaining oneOf branch matches a single string. Won't every
AST2400/AST2500/AST2600 board DTB now fail dtbs_check? The schema would
also stop describing the DT form that is deployed in the field.

No later patch in this series touches arch/ or brings the old form back.
The "dt-bindings: net: ftgmac100: Add AST2700 compatible" patch only adds
aspeed,ast2700-mac to the enum plus new if blocks. The tree stays
inconsistent until a separate series lands through another tree.

Runtime binding on this kernel is not affected, because of_match prefers
the first compatible.

> +      - enum:
> +          - aspeed,ast2400-mac
> +          - aspeed,ast2500-mac
> +          - aspeed,ast2600-mac

[ ... ]

> @@ -94,14 +92,14 @@ unevaluatedProperties: false
>  examples:
>    - |
>      ethernet@1e660000 {
> -        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
> +        compatible = "aspeed,ast2500-mac";
>          reg = <0x1e660000 0x180>;
>          interrupts = <2>;
>          use-ncsi;
>      };

[Severity: Medium]
What happens when a DTB written to this binding boots on a kernel that
doesn't have commit 03a2aba50b2c ("net: ftgmac100: List all compatibles")?

Before that commit, ftgmac100_of_match[] had only:

    { .compatible = "faraday,ftgmac100" },

Aspeed variants were identified after binding, with
of_device_is_compatible().

On those kernels, a node with only "aspeed,ast2500-mac" matches nothing.
That includes stable and LTS branches without 03a2aba50b2c. The Ethernet
MAC would never probe, which on BMCs usually means losing NC-SI and network
management. Other DT consumers that match only the generic string would be
affected the same way.

The fallback is what lets new DTBs work with older software. Could the
commit message mention this forward compatibility cost, instead of calling
the change only "a binding correctness fix"?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-support_ast2700-v4-0-4d36b40939b3%40aspeedtech.com
