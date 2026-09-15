Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A03D093C;
	Tue, 15 Sep 2026 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437285; cv=none; b=lUd6LfBsofHmNyEsRXMpwii6J+XxHxcxsSGauVduQwFhtKzsYWvh87HzFHULCbY8nJTaHQKDgFF3kueKv9PpbyX1HCnREmA/fR3LSElRXrEjPEWaE0j8QKnPL4DdYRsTuW6vo3UXo+5M+FbvNsFaAafDXAhLx4YegS3bFUXvoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437285; c=relaxed/simple;
	bh=okEgBT7t6W/cBGgMtCoJtIWGwl3670aATOSArQWg0TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzYdkIL2vHe86L63pPND7gltzFtKDh61GTcTBJIkaNCFMMGe78U12c1QeYC6djeI5i67IgOr7NhOfpXskHp9da/x44Qrp7dZIG0Rq5D2D5v7MCj5F5Nygn9g30xe79+rdd4j5+/JcOmpQw8oSAqwavMicqATT8ihshrVa1iK0WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAIufqXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAIufqXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C3C1F00898;
	Tue, 15 Sep 2026 01:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437283;
	bh=h+IKF0UPkWRSFfSjapZpuTgEFBB9xqIOmmNOaLtlFBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dAIufqXsVkKndAZz4jbkc7voB6s+6jPNlu5zUpiDkBwY0UERpvxidhq+IQYwwzfVJ
	 oVcWmuH9YERvDodHgiMTkYuMarGsTgo9+PAPSAmi5P5Ovefo+O6WWOuH6pR3VXZUUL
	 jX8eR8f+Yw1CkdN6FtNFISwu0UG6SYIqHwGQ/lJoaMT6iQ6pDmFm+qphFeGMYgCf+U
	 LmuJq4gM2+EQgiaab+tkHNjluiRgjlj9q/ANRrCuLjP3aLddlfYYQSug/h35sSmGv3
	 svIiEBdFG2IDH+iyJjgH8CWGf8F+q40cupz39rXQYwN8ORPcn93vMxug32xCgtfBTP
	 UYtF0zf33FLKg==
From: Jakub Kicinski <kuba@kernel.org>
To: niklas.soderlund+renesas@ragnatech.se
Cc: Jakub Kicinski <kuba@kernel.org>,
	paul@pbarker.dev,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	sergei.shtylyov@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 09/10] dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4
Date: Mon, 14 Sep 2026 18:54:42 -0700
Message-ID: <20260915015442.881311-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-10-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-10-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4

This adds an optional ptp-timer phandle property to the EtherAVB binding
and restricts it to the renesas,etheravb-rcar-gen4 compatible, so that a
Gen4 RAVB node can reference the external system-wide gPTP clock shared
with RTSN on V4H and RSWITCH on S4.

> diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> index 1e00ef5b3acda..fad002492421a 100644
> --- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> +++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> @@ -97,6 +97,8 @@ properties:
>  
>    phy-handle: true
>  
> +  ptp-timer: true
> +

[Severity: High]
Is there an in-tree node that this phandle can point at on Gen4?

The property is re-enabled bare here, so it inherits the contract from
Documentation/devicetree/bindings/net/ethernet-controller.yaml:

  ptp-timer:
    $ref: /schemas/types.yaml#/definitions/phandle
    description:
      Specifies a reference to a node representing an IEEE 1588 PTP device.

On Gen4 there is no standalone PTP device node. On R-Car V4H the gPTP
block only exists as a register window of the RTSN controller node in
arch/arm64/boot/dts/renesas/r8a779g0.dtsi:

  tsn0: ethernet@e6460000 {
      ...
      reg-names = "tsnes", "gptp";

and on S4 it lives inside the RSWITCH node.

The consumer added by the closing patch of this series ("net: ethernet:
ravb: Add gPTP support for Gen4") resolves the phandle in
ravb_gen4_ptp_clock_index() with ptp_clock_index_by_of_node(), which
matches through ptp_clock_of_node_match() in drivers/ptp/ptp_clock.c:

  return (dev->parent && dev_of_node(dev->parent) == parent_np);

But the only Gen4 gPTP providers, rtsn.c and rswitch_main.c, both go
through rcar_gen4_ptp_register() in
drivers/net/ethernet/renesas/rcar_gen4_ptp.c:

  ptp_priv->clock = ptp_clock_register(&ptp_priv->info, NULL);

With a NULL parent, ptp->dev.parent is NULL and the of_node match cannot
succeed, so ravb_gen4_ptp_clock_index() returns -1.

Does that mean a Gen4 DTS writing ptp-timer = <&tsn0> validates and is
parsed but still ends up without PTP support? If so, would it make sense
to also pass the RTSN/RSWITCH device as the ptp_clock_register() parent,
and to add a local description plus an example here so DTS authors and
reviewers have a criterion for which node is a valid target?

>    '#address-cells':
>      description: Number of address cells for the MDIO bus.
>      const: 1

[ ... ]

> @@ -305,6 +307,15 @@ allOf:
>              items:
>                - const: fck
>                - const: refclk
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: renesas,etheravb-rcar-gen4
> +    then:
> +      properties:
> +        ptp-timer: false

[Severity: Low]
This isn't a bug, but one note on the ordering within the series, for the
record: at this patch alone the gated ptp-timer property has no reader,
and ravb_gen4_hw_info in drivers/net/ethernet/renesas/ravb_main.c still
sets

  .ptp = &ravb_gen3_ptp_info,

which describes the internal CCC_GAC gPTP with GTI derived from fck, i.e.
the opposite hardware model from the external gPTP this binding
describes.

The following patch, "net: ethernet: ravb: Add gPTP support for Gen4",
resolves that by adding ravb_gen4_ptp_probe() with

  priv->of_gptp = of_parse_phandle(priv->pdev->dev.of_node, "ptp-timer", 0);

and switching ravb_gen4_hw_info to

  .ptp = &ravb_gen4_ptp_info,

so the binding change here is inert documentation on its own and nothing
needs changing for this reason alone.
