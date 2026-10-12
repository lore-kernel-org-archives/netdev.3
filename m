Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A348F031;
	Mon, 12 Oct 2026 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810215; cv=none; b=uhzYz5Kni4mPJmmiBSA682D2SABGLj3tvaWdix8Du6rnOb1djtlLbUUtoPvadxvul4cagmGEA7Do88NNRuqOpcrnOr35aGRKWWltchXz1X6BL+vbCRpY5p5rcjy/oAr9WMaGBfqbOLwkdRp+t4k7nPdWOYyc4DYpsQF4cWXJxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810215; c=relaxed/simple;
	bh=sbRx7PFD6C/DHdmfeTiP/+MH0ABhr6gwvbSwtZ2sYC4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MjpgHOpPEAYXMRvB+FWh1TQeu5Cno7rABYrczpfXqjl9uq9BtriQqeNq0WgfSAwL4S3hv52jKQ43aVCyy8rN+P/fW54RrAHPWRFRGguXsERcW9oicnJd1xZrVFvpXkwBknI6m74MR9A9tV96QlyTZrDGDLjnMWaPuwKMbpSXGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EatOWNJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EatOWNJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318C61F0089C;
	Mon, 12 Oct 2026 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810213;
	bh=/X0ljJCRiBzR0SUPr9qu+IyHNUOMMR4lJysIgf/mBi0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EatOWNJeh00aNPJbNjmtDFR5+2+tUHaeGQbX9W78O4ZdOWG/3lI9+DdgukhbVqFvS
	 K9WSXfwA00KVKmTkSLEU6pCN6jGBIZbbA0uGrmrWeOwmqAKZkjrIPo3kPEqcwkXwtU
	 4q/9NDJfA3SCEEbMSkyPvVpQLFynLHoWJ/WZgufm+mwrZEWoova2QEo5BSEG/ZGeCX
	 QyR8cuhddDKpAa48zPOB5l9VQ9c17k6dgSdwqxp/FJL5qEwt2NjgNCVLGRta+olSIZ
	 GQSoIZkr616Y9F/kHV4kIJM/2NcquxiDy/pjOPzlHqj7CtmjVbidhfD/xmceN73CNj
	 UbTkO/CLkXxPg==
Subject: Re: [PATCH net-next v2 03/11] dt-bindings: net: qcom,ipq9574-ppe: Add
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
Date: Mon, 12 Oct 2026 13:03:31 +0000
Message-ID: <179181021174.434549.3754588049756407155@kernel.org>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-3-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-3-8c7b057e2c43@oss.qualcomm.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The PPE port pattern still misses port nodes that ethernet-
  switch.yaml allows, so the patch does not deliver what its commit…
- [Low] The new IPQ5424 paragraph in the binding description
  (qcom,ipq9574-ppe.yaml lines 77-79) calls the three front-panel MACs…

--

dt-bindings: net: qcom,ipq9574-ppe: Add IPQ5424 PPE support

This patch adds the qcom,ipq5424-ppe compatible to the PPE binding and
moves the interconnect lists into per-SoC allOf conditionals. It limits
the IPQ5424 Ethernet port reg values to 3. It also widens the port node
pattern so that out-of-range ports are checked against the reg limits.

> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> index c899f4b56945..96e9b9420892 100644
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

Is "GMAC0-2" accurate here? The IPQ9574 part of this description calls
the front panel MACs "GMAC/XGMACs", and the IPQ5424 ports look
XGMAC-capable too.

drivers/clk/qcom/nsscc-ipq5424.c registers NSS_CC_XGMAC0_PTP_REF_CLK
through NSS_CC_XGMAC2_PTP_REF_CLK, along with their resets.

The IPQ5424 platform support patch in this series reserves only XGMAC3-5
in ppe_reserved_ranges_ipq5424, so XGMAC0-2 stay accessible. The
companion documentation patch uses "MAC0 to MAC2".

Would "MAC0-2" or "GMAC/XGMAC0-2" describe the hardware more accurately?

[ ... ]

> @@ -182,7 +179,7 @@ properties:
>  
>    ethernet-ports:
>      patternProperties:
> -      "^ethernet-port@[1-6]+$":
> +      "^ethernet-port@[0-9a-f]+$":
>          type: object
>          unevaluatedProperties: false
>          $ref: ethernet-switch-port.yaml#

[Severity: High]

The commit message says:

  Also match all Ethernet port nodes, so that ports out of the supported
  range are rejected by the reg limits instead of being left unchecked.

Does this pattern match all the port nodes the schema accepts? The
referenced ethernet-switch.yaml accepts both spellings for the container
and for its children:

Documentation/devicetree/bindings/net/ethernet-switch.yaml:
patternProperties:
  '^(ethernet-)?ports$':
    type: object
    unevaluatedProperties: false
    ...
    patternProperties:
      '^(ethernet-)?port@[0-9a-f]+$':
        type: object
        description: Ethernet switch ports
...
oneOf:
  - required:
      - ports
  - required:
      - ethernet-ports

Take a qcom,ipq5424-ppe node with this child:

  ethernet-ports {
      port@5 {
          reg = <5>;
      };
  };

The port@5 child seems to match only the generic "type: object" pattern
in ethernet-switch.yaml. That means it counts as evaluated and passes
unevaluatedProperties: false.

None of the PPE port checks would run on it:
- the reg minimum and maximum
- the IPQ5424 "maximum: 3" limit
- the required clocks and resets
- the ethernet-switch-port.yaml reference

A "ports { port@N { ... }; };" container would skip all of the PPE port
checks in the same way.

The new IPQ5424 conditional in allOf uses the same
"^ethernet-port@[0-9a-f]+$" pattern, and only under ethernet-ports, so it
has the same gap. Later patches in the series don't seem to change these
patterns.

Could both this pattern and the IPQ5424 conditional use
'^(ethernet-)?ports$' and '^(ethernet-)?port@[0-9a-f]+$', as qca8k.yaml,
mt7530.yaml and lan966x-switch.yaml do?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43%40oss.qualcomm.com
