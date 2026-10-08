Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2626158B;
	Thu,  8 Oct 2026 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430278; cv=none; b=Dpr70VY+wVBHc+Ar4Z0ztBmsP8K2+/keDzXWrh79Mk0f6Q2xYiD9SKYvBcFPruQ/kqaAyhtX5zeFEjeXQi2nGrbHIs1b7F5DZslkSklSyCyvUIZrhDPQvnMF37ZsstbsqfmKhtXFMfxOuBzTFw9gjpZjlqOr1nTa+qjMzm1L1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430278; c=relaxed/simple;
	bh=aTBV22tb5rCe4fmyv+Cz8akZ7WXnE+6J/Dlj0OCzqFY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MuxR5a5+eRi7b6uTisU2w9FaSNCnYLHH/1RCNS675ALU6zbpPpVf8SwJ8H2F6x84lZXYuEQ2eF/mSKJ6VsUdLXSqHyy+eRCNmvGRoHITbP+3KuCIZ87CPjcIPkWZ+GUa+6eozLLuFddtSFySZbB0wBmifcGlMe6eo3n8BkiP07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgJueFK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgJueFK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9EC1F000FF;
	Thu,  8 Oct 2026 03:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791430276;
	bh=MAdIzT5K3jeSj8cPsQf4M6G1Hao344SAaHz8q1wewsU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jgJueFK9r4q/rS0YTMEyGxKdNMDB2fRnYkWd7rcKxdarcJuzXxzam2mDMVb3LK4jh
	 Dkw+rTlbvjW2aVvhbQ7Hw7fZ02Eoyu3T3gL331rF9Wel+/eBpX0YeibKIo+pTJMhMY
	 /2V+/AcoIzevPV396ECQT+7zH2i0d051IwjAW5bI+WP1C1ZjAH0h2kP8lR1XATc+ky
	 LUT6i0D5qMJlNWAI3lfoOc+Fr/wYtiQlONHOfdaCdtGLXYBt9AYf7kanocJYuuR4VW
	 hxKu5LAgZquv9x4qHxe0ykGDZRExYW644mUMbsDLCbvrQClLaZbuZi1a5GqtQlpi07
	 eSwiyv/ScZxCQ==
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: qcom,ipq9574-ppe: Tighten
 ethernet port node constraints
From: netdev-bot+sashiko@kernel.org
To: mail@tk154.de
Cc: netdev@vger.kernel.org, jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, quic_pavir@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Thu, 08 Oct 2026 03:31:15 +0000
Message-ID: <179143027505.434549.14985682962873043848@kernel.org>
In-Reply-To: <20261005152915.101780-3-mail@tk154.de>
References: <20261005152915.101780-3-mail@tk154.de>
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

- [High] This patch only closes off the `ethernet-ports` spelling of the
  port container.
- [Low] The commit fixes schema-validation defects already present in the
  binding, but it has no `Fixes:` tag.

--

dt-bindings: net: qcom,ipq9574-ppe: Tighten ethernet port node constraints

This patch drops the stray '+' from the ethernet-port node pattern in the
qcom,ipq9574-ppe binding, so only single-digit unit addresses match. It
also gives the ethernet-ports container type: object and
additionalProperties: false, plus explicit #address-cells and #size-cells
constraints.

> Also restrict the ethernet-ports object to its declared properties.
> Without this, nodes outside the port pattern are accepted through the
> generic ethernet-switch schema.
>
> Signed-off-by: Til Kaiser <mail@tk154.de>

[Severity: Low]
This fixes validation problems that have been in the binding since it was
added. Should it carry a Fixes: tag?

Both the unclosed ethernet-ports block and the "^ethernet-port@[1-6]+$"
pattern come from this commit:

Fixes: 1898fc572118 ("dt-bindings: net: Add PPE for Qualcomm IPQ9574 SoC")

> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> index 6d0b21a10732a..1a78e2c82b90c 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> @@ -174,8 +174,17 @@ properties:
>        - interrupt-names
>  
>    ethernet-ports:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
>      patternProperties:
> -      "^ethernet-port@[1-6]+$":
> +      "^ethernet-port@[1-6]$":

[Severity: High]
This closes off the ethernet-ports container. Can the same nodes still get
through if the container is named ports instead?

The binding pulls in the generic schema:

    allOf:
      - $ref: ethernet-switch.yaml

ethernet-switch.yaml accepts either container name, and accepts any
port@ or ethernet-port@ child with a hex unit address:

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

qcom,ipq9574-ppe.yaml has no ports entry, and it does not list
ethernet-ports under its top-level required: list. Because ports is
evaluated through the allOf $ref, the top-level unevaluatedProperties:
false does not reject it either.

So it looks like a PPE node like this would still validate:

    ports {
        #address-cells = <1>;
        #size-cells = <0>;
        port@7 { };
        ethernet-port@11 { };
    };

None of the PPE per-port constraints apply to that node. That covers the
reg 1..6 range, the required clocks/clock-names/resets/reset-names, the
unevaluatedProperties: false on the port node, and the new single-digit
pattern.

That means the case described in the commit message, "nodes outside the
port pattern are accepted through the generic ethernet-switch schema", can
still happen.

The later patch in this series, "dt-bindings: net: qcom,ipq9574-ppe: Add
IPQ5332 support", also constrains only ethernet-ports in its IPQ5332
if/then block. That includes the "^ethernet-port@[3-6]$": false rule, so
ports { port@3 { }; } would also get past the IPQ5332 port-count limit.

Other bindings with per-port constraints match '^(ethernet-)?ports$', so
both spellings are covered. Examples are dsa/qca8k.yaml,
dsa/mediatek,mt7530.yaml, dsa/microchip,ksz.yaml and dsa/nxp,sja1105.yaml.

Could this binding do the same? Another option would be to forbid the
other spelling with ports: false, and add ethernet-ports to the top-level
required: list.

>          type: object
>          unevaluatedProperties: false
>          $ref: ethernet-switch-port.yaml#

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005152915.101780-1-mail%40tk154.de
