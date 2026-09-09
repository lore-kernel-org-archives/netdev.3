Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3C559C86;
	Wed,  9 Sep 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957544; cv=none; b=HzbOCGnrK/IcWRnmxyXUSTv+Q/FL3f61ieJB+E4gRe3dev/Gr1xmwoiBi/Dri0uE1kBJkDUal5n/x+rU7JCL/xNAR5Yd5cbUEDBRdNkGaanJNxAhmC8MB27m6Q7PabJH2Ivbs/x4K0/Q1A115qJfyZGeif3FJ7hG6+YYb17pCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957544; c=relaxed/simple;
	bh=lCeG+xm9ToRkbrD+58QQCV5PM+ShqPvpg6MfO7g+bs4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELE3GrLVX8sQ/HrF0rSw31PYiQO8e0FCEt8nST6QjdY6k5xB3ej91kAIulRcS6iimMFXP9dAjgTP1PvBfh/Q9RDv0zsqKL9KnGiTUhFC2eviqKBEVBk4ogmMWb7XvWfN0u7yiFqzzsBGb4Thfq/UDVwr3arkOJueAoFyjv3w8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYYkeH39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYYkeH39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8005A1F00A3D;
	Wed,  9 Sep 2026 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957541;
	bh=VjhVwWNc0wgGZbbWlLPcJl6T8SE0Puveqmtl/B0/jhA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SYYkeH39KXUlLD1d9rjIKqFGNOay4K1KQLZT3PuX+eqASlMDcOvXhuAWxXSvvc4ig
	 F7MD7G8+LCPNFfUT7BafTPrL3K92VLRGakt4OclNSk9LFPhAnaZv5tz6wAoY8m7/PV
	 Xjzy8ZBquxi74mZ+ipMgc6edLnMeeV/GbZlS91azedH3iJSIz+FYzWMCSwfbNpk+sd
	 EniZmyb5nrARBCi+3W5wSYf6AyVVAW5pj3giQczPax5gEjIqWonk7uN3fxlRSbIVPx
	 cFj7M/STLUwzenzo8zIFqjI4+8Gs0XdaV7ewWGOBY43+ci9s+QwZYcUIXEnkyjjKCa
	 zIC+/wqgms92g==
Subject: Re: [PATCH net-next v7 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@oss.qualcomm.com
Date: Wed, 09 Sep 2026 12:39:00 +0000
Message-ID: <178895754004.219967.902137420360139647@kernel.org>
In-Reply-To: <20260904-wiznet-link-gpio-v7-2-69f01b70c96f@marmottus.net>
References: <20260904-wiznet-link-gpio-v7-2-69f01b70c96f@marmottus.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Documentation/devicetree/bindings/net/wiznet,w5100.yaml: the
  newly added second `interrupts` entry is described as being…
- [Low] Concern (assessed as a FALSE POSITIVE; retained only because
  requires_validation=true): the claim that the newly documented second…

--

dt-bindings: net: wiznet,w5100: add link status interrupt

The wiznet,w5100 binding is extended so that the interrupts property can
carry a second entry for a link status interrupt wired to the LINKLED pin,
and the example is updated to show both interrupts.

> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> index 601d828bae927..d0717ab45de6c 100644
> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
> @@ -24,7 +24,11 @@ properties:
>        - wiznet,w5500
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: Main interrupt (INT pin on the device).
> +      - description:
> +          Optional interrupt for link status changes (LINKLED pin on w5500).

[Severity: Low]

The description of the second entry says the pin is on the w5500, but the
constraint sits in the top-level properties block with no allOf/if-then
keyed on compatible.  The compatible enum in this same file is:

  compatible:
    enum:
      - wiznet,w5100
      - wiznet,w5200
      - wiznet,w5500

so a node such as:

  ethernet@0 {
      compatible = "wiznet,w5100";
      interrupts = <25 IRQ_TYPE_EDGE_FALLING>,
                   <24 IRQ_TYPE_EDGE_BOTH>;
      ...
  };

passes make dt_binding_check even though the schema text says the pin only
exists on the w5500.

Should the item count be tied to the compatible string, for example:

  allOf:
    - if:
        properties:
          compatible:
            contains:
              enum:
                - wiznet,w5100
                - wiznet,w5200
      then:
        properties:
          interrupts:
            maxItems: 1

The driver side of the series treats index 1 as w5500-only:

drivers/net/ethernet/wiznet/w5100.c:w5100_probe() {
    ...
    priv->link_irq = ops->chip_id == W5500 ?
                     fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;
    ...
}

with w5100_get_link() returning a hardcoded 1 for the parts that have no
PHYCFGR link-status register.  So for w5100/w5200 a second interrupt in DT
would validate but then be silently ignored, since fwnode_irq_get() is
never called for index 1 on those chip ids.

Alternatively, if LINKLED wiring is equally describable on w5100 and w5200,
should the description be widened instead of naming only the w5500?

Nothing in the rest of the series changes this block, so the published
schema stays permissive for all three compatibles.  Adding the conditional
later would tighten the schema rather than break the ABI, so it seems it
could still be done, but it seems better to get it right here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-wiznet-link-gpio-v7-0-69f01b70c96f%40marmottus.net
