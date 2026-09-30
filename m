Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A24718C9;
	Wed, 30 Sep 2026 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803080; cv=none; b=tsRHuTZpykliv+eaeGbUjw4nzuXJNysGZxs/0ij7HoPffOIaXBymBs5RBxCIRq0yQp2yQCWi22Rm0a8DNkBIgXcxuFj9Ei8chWVo+tqk1Qg6V1DTaknrlvsng/zhh5wGpmnJvKRq9g1wsMafEIXA7tAZesMqSsG+NtWRmZPQr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803080; c=relaxed/simple;
	bh=inxM72j/Q0Tl7vfM2d8Neq+jhZAL1Ya7erjuCgBaDhg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3bJbe3xYD+ljlNpe+20Om+cPCSkhAyGJHdtlOvpEL8RCwRL5W4Tne40w+7lUHDXFlbRojcYriUZsoxgoJgfQzj4zSOammKE+Yw1eb8Smc8+jndCOzmm3QND6YOoOpNqD21fYsCBFKDp+wRqKXROMddFtlFrMlCLO4tNs8dkgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff0h0uBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff0h0uBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357401F000FF;
	Wed, 30 Sep 2026 21:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803079;
	bh=MYQRvi81yXtiB8C3n51k/7/iz6l318EcdBktXmsGO3I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ff0h0uBIbmfsBs07sG7pbJ4TotHpZcnNMzx9jE8DWP8TdtCVnWTliLVj0eS8e9dtd
	 EmVUWSSQvlCFmzDGf3x2XXxFPaPumTauzpm7vUIGDj5eIcTS4fzcVmsxPWDg3V9tlq
	 Bf6xBCxLr6hRvbFSVxXA2n2PvQhFx/0b1IXg1qMR72giLPVH77SpRdAXHdjQFDFbK0
	 mV++fQKabCD6v+ePYK4e4fb6pS62jnh5ah679qQ7NApQioTOjyllcy8vkDYRkjuuNV
	 K8My1VEVgtqHiS0taApcFqIxJYm8ayhBp5fymZ5D+1L7kEA6AS2TpscDEBBhOXjK+L
	 NOhiI3cfbNShg==
Subject: Re: [PATCH 1/5] dt-bindings: net: ftgmac100: Add AST2700 compatible
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ratbert@faraday-tech.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 21:17:57 +0000
Message-ID: <179080307768.434549.3941838523484447374@kernel.org>
In-Reply-To: <20260927-support_ast2700-v1-1-9f03f29d2c82@aspeedtech.com>
References: <20260927-support_ast2700-v1-1-9f03f29d2c82@aspeedtech.com>
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

- [Low] Concern: at this commit, "aspeed,ast2700-mac" is in
  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml…

--

dt-bindings: net: ftgmac100: Add AST2700 compatible

This commit adds aspeed,ast2700-mac to the compatible list in the FTGMAC100
binding. It also extends the RMII RCLK clock description to cover AST2700,
and it allows the resets property for AST2700 the same way it is allowed
for AST2600.

> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf6..bee9570a6f63f 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -18,6 +18,7 @@ properties:
>                - aspeed,ast2400-mac
>                - aspeed,ast2500-mac
>                - aspeed,ast2600-mac
> +              - aspeed,ast2700-mac
>            - const: faraday,ftgmac100

[Severity: Low]
At this commit, ftgmac100_of_match[] in
drivers/net/ethernet/faraday/ftgmac100.c has no entry for
aspeed,ast2700-mac. Would an AST2700 node bind through the
faraday,ftgmac100 fallback and be treated as FTGMAC100_FARADAY?

If it did:

  - is_aspeed would stay false.
  - EDORR/EDOTR would use BIT(15) instead of BIT(30).
  - ftgmac100_setup_clk() would never run.
  - The in-MAC MDIO would be set up.
  - The RMII reset path would be skipped.

Later patches in the series seem to fix this. The patch "net: ftgmac100:
Add AST2700 compatible support" adds:

	{ .compatible = "aspeed,ast2700-mac",
	  .data = &ftgmac100_match_data_ast2700 },

The same patch adds FTGMAC100_AST2700 to the Aspeed branch in
ftgmac100_probe(), which sets BIT(30) and is_aspeed. Separately, "net:
ftgmac100: Add AST2700 upper DMA address support" adds the high address
bits.

No in-tree AST2700 DTS under arch/arm64/boot/dts/aspeed/ has an ethernet
node. So nothing in the tree should be affected between the binding patch
and the driver patch.

One small leftover: this patch changes the binding text to "RMII RCLK
gate for AST2500/2600/2700". The rclk comment in struct ftgmac100 still
says:

	/* AST2500/AST2600 RMII ref clock gate */

Could that comment be updated to include AST2700 too?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927-support_ast2700-v1-0-9f03f29d2c82%40aspeedtech.com
