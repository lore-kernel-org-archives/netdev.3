Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370135BDAA;
	Sun, 11 Oct 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747899; cv=none; b=neGjt42kk0tqrVYmU161naNBfoeYlt8ZaJBeDbHcHYzBqqHy9QBcNfpnBoEyQpPvFPBhHjngJrg7STr3flltdyukHvFgz+GERhn5+3yOWVBNdFhzM/qcxNP4F/Hbg31Gy57RXPL80Kxgz/Dr92WyZHCmanDleMrU8SgaFmAwrgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747899; c=relaxed/simple;
	bh=i20Tc7f4556SiYFNNTw21l9Z8Rm27QzVFOFAjWI/HcU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WqKZ1Cohv7/fg8qm09KJGeJQQqFszeLIfIP0E1rI+qM0WUjGi2T4FXZv0bq57aQZoplkJFBtQRJiCSLi2HkPC7XR6R5gNHMI6G+kVxUt/bf/V3z+ZBaP+3oYTeVggLOydeVK1Pnk0rpBgxVpaMpg4MhdbjY7RcpB40GFgirFTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndio30F7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndio30F7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1161A1F0089B;
	Sun, 11 Oct 2026 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791747897;
	bh=ybSHNZN0sLAcAcqooYFFzMCFvgioFe6ifikT0RnbGgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ndio30F74QvWZ+l3sZghTVNaLQrlGwiAW9hNudalix1ZHnaJ44aeLb03WgP0NSS/C
	 VPNIbWnqp+Mkht9eGZcLFmZgwRFdp62HhO2NKsTFISELXQDlpYaryNG2J9hFWz536e
	 MFzCbMZn69Q20R9OOKXTg17sA58NU547H/ueNhk2oipXxfoTCqiEIY3I6vhpic0NNB
	 r0dKLD5CXZ4qwhXZVkYkPP1kgGaHjt3yfsHoVKA5ps09hNymdNBIzDCpMJ+WulEjIU
	 GT75hMdGW11rXmmhP9AkEGHq5hXnnucwEgDGuX4k8I8dMIAFmcoeIA6c+jgzz26wyr
	 TUviXUhy/bJTg==
Subject: Re: [PATCH net-next v7 1/3] dt-bindings: ptp: renesas,rcar-gen4-gptp:
 Add R-Car Gen4
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Sun, 11 Oct 2026 19:44:56 +0000
Message-ID: <179174789660.434549.18248086248544224654@kernel.org>
In-Reply-To: <20261007185920.4042783-2-niklas.soderlund+renesas@ragnatech.se>
References: <20261007185920.4042783-2-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ptp: devm_ioremap_resource() conflict with rtsn Ethernet driver

--

> diff --git a/Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml b/Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# Copyright (C) 2026 Renesas Electronics Corp.
> +# Copyright (C) 2026 Niklas Söderlund <niklas.soderlund@ragnatech.se>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/renesas,rcar-gen4-gptp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car Gen4 gPTP timer
> +
> +maintainers:
> +  - Niklas Söderlund <niklas.soderlund@ragnatech.se>
> +
> +description:
> +  The R-Car Gen4 gPTP timer enables accurate synchronization of the clock in
> +  the control system. The timer is system-wide and used by different Ethernet
> +  devices on each Gen4 platform.
> +
> +    - On R-Car S4 it is shared between RSWITCH and RAVB.
> +    - On R-Car V4H it is shared between RTSN and RAVB.
> +    - On R-Car V4M it is only used by RAVB.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r8a779f0-gptp # S4-8
> +          - renesas,r8a779g0-gptp # V4H
> +          - renesas,r8a779h0-gptp # V4M
> +      - const: renesas,rcar-gen4-gptp
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - power-domains
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a779g0-cpg-mssr.h>
> +    #include <dt-bindings/power/r8a779g0-sysc.h>
> +
> +    ptp@e6449000 {
> +            compatible = "renesas,r8a779g0-gptp", "renesas,rcar-gen4-gptp";
> +            reg = <0xe6449000 0x500>;
> +            clocks = <&cpg CPG_MOD 2723>;
> +            power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
> +            resets = <&cpg 2723>;
> +    };

[Severity: High]
This example places the timer at 0xe6449000. That is the same region
renesas,ethertsn.yaml already describes as the second reg entry
("gptp") of the RTSN node on V4H. rtsn_probe() looks that range up with
platform_get_resource_byname(pdev, IORESOURCE_MEM, "gptp") and maps it
with devm_ioremap_resource(), which requests the region exclusively.

Suppose a V4H DT contains both the ethertsn node and this new ptp node,
and a driver for this binding also maps its reg with
devm_ioremap_resource(). Then whichever of the two probes second will
fail with -EBUSY, and either Ethernet or the gPTP timer is lost at boot.

How is the transition meant to work here? One option is to update
renesas,ethertsn.yaml to drop the gptp reg entry, reference this node
with a phandle instead, and change rtsn.c to match. Or is the plan for
the gPTP driver to avoid claiming the region exclusively? It would be
good to have that spelled out in this series. As it stands, the
bindings describe the same registers in two places.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007185920.4042783-1-niklas.soderlund%2Brenesas%40ragnatech.se
