Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70A3E3142;
	Mon,  7 Sep 2026 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749331; cv=none; b=HGlySsqq778dRNTtRXPr+IzSbhzKT/fCXvY3CrLypnxcqH/AuUoWm77x5gTM83Bl36WoqA3ZF9xlgy4O0O8eXpzmcLtJa3XucRKtnA3LB7gOe3aK+HiaSI2bz+JU3bhFDgFxWB5idDrS0X/f4Nuam5Ye9edbOXDB/ehisfGXK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749331; c=relaxed/simple;
	bh=8YgnrFpVfFjihXYYY3UQSLs/E2OCveqGkvP5oMA8biA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lb0N+V/NriqLdR4nIcOcfRCJscm5JgvWh1ubpwR8j9sWDNnNmiRIwS5yTk/jP/FrJcFdvNgacLU7fpCYQKJ8V3mMCdH321Vo5LTKIQp+VilOBB0F3gwf+is1xZ6K3dJRMnPMR7YxdJRMSs81ocm0iEz7ypflAryYdt0CrhQ4Kyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8DvXvGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8DvXvGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8151F00A3A;
	Mon,  7 Sep 2026 02:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788749321;
	bh=/wAv4T+jkl4ZV2V0Tydx3pf7Q4PuVZf54Q+mv9Dg4MI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q8DvXvGbvzi01MFwe3vxS9dXpxBEYio/azub6U0a3KYce0eK6O8dJrBNC8Lp8t6Ft
	 TJJhNlTSAkmuA/qxHg1q8DMDXfdupa84H9zb/G0TqgxE8AqaYux05Z/mlnlH+odkgJ
	 JzRUw6YdSfwtkAKYGTzp7b6lEMPuXTJGynYVuoPXiTEPNFUm/NUKU588wisJGyqFZq
	 t3+tj4omSJ7xkuASz1Zsmmi7Nvaf9EWo3UN3cj6dlteLiYsyz5oY8Z9Bw0sgKu7Ee5
	 l86/8gxGZlORhrIXoGB4qDJfERdobS8yjqZqBb+776sZNQusolHTcl3ZyH3drob8bJ
	 FwCdSwG/1ZAjw==
Subject: Re: [PATCH net-next v3 09/10] dt-bindings: net: renesas,etheravb: Add
 optional gPTP phandle for Gen4
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 02:48:39 +0000
Message-ID: <178874931979.219967.9907513811055043761@kernel.org>
In-Reply-To: <20260902084703.3228504-10-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-10-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Concern (invalidated): the binding documents `ptp-timer` for Gen4
  EtherAVB while the RAVB driver allegedly never reads it and keeps…

--

dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4

This adds an optional ptp-timer phandle to the EtherAVB binding so that
Gen4 SoCs can point at the external system wide gPTP clock, and adds a
conditional block rejecting the property on non-Gen4 compatibles.

> diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> index 1e00ef5b3acd..fad002492421 100644
> --- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> +++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
> @@ -97,6 +97,8 @@ properties:
>  
>    phy-handle: true
>  
> +  ptp-timer: true
> +

[Severity: Low]
This isn't a bug, just a note for the record after checking the rest of
the series.

At this patch alone there is no consumer of ptp-timer in
drivers/net/ethernet/renesas/, which initially looked like the binding
was documenting a property the driver would never read.

The later patch in the series, "net: ethernet: ravb: Add gPTP support
for Gen4", does add the consumer in ravb_gen4_ptp_probe():

	priv->of_gptp = of_parse_phandle(priv->pdev->dev.of_node, "ptp-timer", 0);

and switches ravb_gen4_hw_info.ptp from &ravb_gen3_ptp_info to
&ravb_gen4_ptp_info, with the reference released in ravb_remove() via
of_node_put(priv->of_gptp).

So no change is needed here; the property is consumed by the end of the
series.

>    '#address-cells':
>      description: Number of address cells for the MDIO bus.
>      const: 1

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902084703.3228504-1-niklas.soderlund%2Brenesas%40ragnatech.se
