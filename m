Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27B370AE7;
	Sat, 10 Oct 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619121; cv=none; b=E9FyyzeASdCdaz693bfbVC0eSjlfE+dL911hUqTh1PaeoMBkLQkpxWP8mRevuz2HF72NV1f+kTuevLHlvVRooNYSICeYW6MbsQchjfPUb5ZtSiIxG8uxpUn7pMSf1t/9jJtzWFlW6xw8Z0o/Q2Etd2TYtd6WNc9S9RizL8lYJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619121; c=relaxed/simple;
	bh=0sOYYVW6e1ibf8hHtLPShzDRhUbnHP4+ZziC+5WDgoI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVDIqCBkeCoULz9jMmG10/3DUI53CzJSG+g1A9+k0oWhp1I0g2e5/uLQY7LTYD0YD7lT90TBG+Oz9ENdmRBykTKT+E/ocI2NPfWWq/yXazmzltC35aewe+VNHCWaxPrisRbEa/D3h+AjvJ7LeTRLd46/CgzC7U7Qnc4re8ZM3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlBWvGYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlBWvGYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC66A1F000FF;
	Sat, 10 Oct 2026 07:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619119;
	bh=TOodvZ/Z1OL3DouPwaKF+cp7xl8SVz0utrqiuJvN8QY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GlBWvGYH7dcSeyv9f6bsXGy0q3XMl7SDZPBwo95JKuyJPZ3C6LBi1+QBvdrq6eNXU
	 Brs7P9+9mw05fwGUUuuHNvTB00j23YSDrPaahtvxlMxWSq9wKGOpY9Oejx+LVqB6WX
	 oXB3j/oyZ3BIxLzemW+jnYwCOOwhltnI0/8nYnXq/byU1gGuKztO4H9Nkbuz3XuSPM
	 3SSltqqMvjCfIwUQqm83Aog1MeiU/3/m8ZXJuEtMYa5ajGTFkBBMHLL5kuyyuSrgcj
	 Rje7ALGjG80BkuVGgx4/0nl0l1jQioh1OZtnRUygErE2E6LNy+5+Wcco4V8i4Gxefu
	 5F7UGn5/8Xl3A==
Subject: Re: [PATCH net-next v2 1/6] dt-bindings: net: ftgmac100: Add AST2700
 compatible
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 07:58:38 +0000
Message-ID: <179161911824.434549.4075299707625994950@kernel.org>
In-Reply-To: <20261006-support_ast2700-v2-1-36de51fb8066@aspeedtech.com>
References: <20261006-support_ast2700-v2-1-36de51fb8066@aspeedtech.com>
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

- [Low] Already fixed later in this series, so the baseline decision is
  false.

--

dt-bindings: net: ftgmac100: Add AST2700 compatible

This adds aspeed,ast2700-mac to the FTGMAC100 compatible list, which
requires the faraday,ftgmac100 fallback. It also updates the RMII RCLK
clock description to include AST2700, and allows the resets property for
AST2700 in the same way as for AST2600.

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
With this patch, "aspeed,ast2700-mac", "faraday,ftgmac100" becomes a
valid compatible pair. However, at this commit, ftgmac100_of_match[] in
drivers/net/ethernet/faraday/ftgmac100.c has no aspeed,ast2700-mac entry.
Such a node could only bind through the generic faraday,ftgmac100 entry
(FTGMAC100_FARADAY).

On that path, ftgmac100_probe() would do the following:

  - program the ring-end bits at BIT(15) instead of the Aspeed BIT(30)
  - leave is_aspeed false, so ftgmac100_setup_clk() never claims
    MACCLK/RCLK
  - register the embedded MDIO bus through ftgmac100_setup_mdio()
  - never set a DMA mask wider than 32 bits

Would an AST2700 node work correctly if it fell back to the Faraday
match?

Later patches in this series fix this. "net: ftgmac100: Add AST2700
compatible support" adds FTGMAC100_AST2700 and an aspeed,ast2700-mac
match entry, ahead of the faraday fallback. That entry selects the
BIT(30) and is_aspeed path.

"net: ftgmac100: Add AST2700 upper DMA address support" then adds
dma_set_mask_and_coherent(..., DMA_BIT_MASK(35)).

So the problem only shows up when bisecting to this commit, and only with
an out-of-tree AST2700 DTS on an ARM64 build. ARM64 builds are only
enabled by "net: ftgmac100: Allow building on ARM64". Landing the binding
before the driver match is the usual order for dt-bindings series.

[ ... ]

^ annotation: none needed for the [ ... ] above; snipped hunks are the RCLK description and the resets allOf block.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-support_ast2700-v2-0-36de51fb8066%40aspeedtech.com
