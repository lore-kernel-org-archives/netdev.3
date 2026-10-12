Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674A4A5EA9;
	Mon, 12 Oct 2026 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819714; cv=none; b=Xc6RQDMQifqkKbW5TUrJ4f+xQCxTYcKViR7G6tJa0fds9SYN7qhsx8HtO9qAMqIEkJqXQO+u0CNWbnFrnB7g/VFHTmlbKEXkoL5k2Rv5xUreCS1F5ll7AEDhVKOjFA4p3JoPqz8wZr53ZflROBAxoIBFBMZMYDin/Kxy5EHF1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819714; c=relaxed/simple;
	bh=7rRa2JfmdB0drekEYd2cRrxKBrtqOOfu/77GrlvI/X8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GAD1RmNHnkabqjxg1I1ZF68ezfdMeSzO1A+axkFvn5tFDOImZ4VUc47USDjBYBjRiCJiXh5AKo49qoXiieRXBuFasqKZL0X52pTH/JRVb5fL5AIUYz/hut7eHoGilckbAPGPAKVXdJnoo6PcmlBuBX8inBzhhKq8NBoFnsnyuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i15zmgja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i15zmgja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BE71F0089B;
	Mon, 12 Oct 2026 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819713;
	bh=nHbMapHTKZ727vEhoiXUoP/oNdKkaDpyXh4LAmd4I7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i15zmgjafBp2j8RNHxrFcF4MgDU7NCq0yNbq+XtCB2WsHy/o+PxLcpCt9WSDFWcQp
	 k1o0U0S2m3Nv4v7LXrwjdwI+JB/bs6R9/l6PY2bgttGsJdVqXFCgKq06fUfNSK9c0C
	 i966B8YLZJzbGnR8syObeUwOyw+sXrHAvXoy8K1pwL6Hdi/5FtEq7ES/8zn0yUaGPy
	 8CKr6UaDNey6ZyzGTH32TVkfhf3HzENfWPc2kO9n7se/oz6LzycM5yF525XO91wmAx
	 t/+LlRcx0ad00/UaOFaNY+JcmRmTGsI4b3P+9OosNWA+uZhy5e+1Ohyz5YF0JVDLFK
	 ZVJHZr5fy/Whw==
Subject: Re: [PATCH net-next 03/11] dt-bindings: net: qcom,ipq9574-ppe: Add
 IPQ5424 PPE support
From: netdev-bot+sashiko@kernel.org
To: jie.luo@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Date: Mon, 12 Oct 2026 15:41:51 +0000
Message-ID: <179181971156.434549.6954774066445278330@kernel.org>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-3-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-3-16caf43e44ee@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The IPQ5424 port limit in
  Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml is…
- [Low] The new prose in the binding description
  (Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml, lines…

--

dt-bindings: net: qcom,ipq9574-ppe: Add IPQ5424 PPE support

This patch adds the qcom,ipq5424-ppe compatible to the IPQ9574 PPE
binding. It moves the interconnect lists into per-compatible allOf
conditionals, with a smaller interconnect set for IPQ5424. It also tries
to limit IPQ5424 to Ethernet ports 1-3.

> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> index c899f4b569458..e5d218fc5d825 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> @@ -74,9 +74,14 @@ description: |
>      +------->|             QCA8075 PHY             | | PHY4  | | PHY5  |
>       (clock) +-------------------------------------+ +-------+ +-------+
>  
> +  The IPQ5424 PPE reuses the same switch core, but wires up only 3
> +  front panel ports (GMAC0-2) and the single EDMA FIFO interface; it
> +  has no EIP FIFO and no ports 4-6.

[Severity: Low]
Is "GMAC0-2" accurate here? The series' own driver has this comment above
ppe_reserved_ranges_ipq5424 in drivers/net/ethernet/qualcomm/ppe/ppe.c:

/* For IPQ5424, there are only three Ethernet ports, the register space of
 * GMAC/XGMAC 3-5 is unavailable.
 */

That suggests both GMAC0-2 and XGMAC0-2 are present. Also,
include/dt-bindings/clock/qcom,ipq5424-nsscc.h defines
NSS_CC_XGMAC0_PTP_REF_CLK through NSS_CC_XGMAC2_PTP_REF_CLK.

The IPQ9574 text above calls the same blocks "GMAC/XGMACs". Would
"GMAC/XGMAC0-2" be more accurate here?

> +
>  properties:
>    compatible:
>      enum:
> +      - qcom,ipq5424-ppe
>        - qcom,ipq9574-ppe

[ ... ]

> @@ -182,7 +179,7 @@ properties:
>  
>    ethernet-ports:
>      patternProperties:
> -      "^ethernet-port@[1-6]+$":
> +      "^ethernet-port@[1-6]$":
>          type: object
>          unevaluatedProperties: false
>          $ref: ethernet-switch-port.yaml#
> @@ -236,6 +233,62 @@ required:
>  
>  allOf:
>    - $ref: ethernet-switch.yaml

[ ... ]

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,ipq5424-ppe
> +    then:
> +      properties:

[ ... ]

> +        ethernet-ports:
> +          patternProperties:
> +            "^ethernet-port@[1-3]$":
> +              properties:
> +                reg:
> +                  maximum: 3
> +            "^ethernet-port@[4-6]$": false

[Severity: Medium]
Does this fully limit IPQ5424 to ports 1-3, as the commit message says?

The allOf also pulls in ethernet-switch.yaml, and its ports container has
a catch-all child pattern:

Documentation/devicetree/bindings/net/ethernet-switch.yaml:
  '^(ethernet-)?ports$':
    type: object
    unevaluatedProperties: false
    ...
    patternProperties:
      '^(ethernet-)?port@[0-9a-f]+$':
        type: object
        description: Ethernet switch ports

If a child name matches none of the PPE patterns, this generic pattern
still marks it as evaluated, so the inner unevaluatedProperties: false
doesn't reject it. Only type: object is checked.

So on qcom,ipq5424-ppe, it looks like these nodes pass dtbs_check without
a reg range check and without the required clocks, resets and
reset-names:

  ethernet-port@0, ethernet-port@7, ethernet-port@a, ethernet-port@10

The same applies to a ports container that uses port@N, for example
ports { port@4 { reg = <4>; }; }. The oneOf in ethernet-switch.yaml
accepts either ports or ethernet-ports, but the PPE schema only constrains
ethernet-ports.

Could the IPQ5424 branch constrain every name the base schema accepts?
For example, it could use '^(ethernet-)?port@[0-9a-f]+$' with
reg: maximum: 3 and disallow the ports container.

There's a related question about the change to the shared pattern under
properties.ethernet-ports:

    "^ethernet-port@[1-6]+$"  ->  "^ethernet-port@[1-6]$"

This also affects the existing qcom,ipq9574-ppe compatible, and the
commit message doesn't mention it. Before this change, a node like
ethernet-port@11 matched the PPE port schema and reg: maximum: 6 rejected
it. Now it only matches the generic ethernet-switch.yaml pattern, so it is
accepted.

Is that loosening of the IPQ9574 validation intended?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee%40oss.qualcomm.com
