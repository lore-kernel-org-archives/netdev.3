Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BE372071;
	Thu,  8 Oct 2026 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430279; cv=none; b=E/fEET7F8zleytgY05D6SIteFdV7yyESj7nsDorZ4WpYKgnpksloVkU3eXQE6AHmeDLsRarrvYa9uD4LY0tIPzEm9ZGdlFame+25gsp8TJAQDm19ddjsok6h+PJGzHfGUEpsRiwmzrh6BKV5ZuAesmBLfMr28vtb1S/q2W1twko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430279; c=relaxed/simple;
	bh=jGnf4YTTbgp3pyVWYzvtTpjTWilXRuuOmq4er15KPj4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ltUUO7OmJ3Gvox+Mv5guvE6/hcoaX2JJ5CDDvduSVKQr2CLAzaigGHUpj5EXdlKAS1xJGzX/9tFNKuSRGO1RHS2Obk50vF2B8iB810hisyJI1R5GzYs6gQz5W0jXa4rrbfEBZeqwbZVGmK01V8C/7m6+fjFCcpTpGDq7PgqUHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNCCewUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNCCewUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604BF1F00893;
	Thu,  8 Oct 2026 03:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791430278;
	bh=4PImF/bcS4wg1Tz3UGd/A5bh6Tl7WV37bYZRssHDge0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dNCCewUnYkD6yVPU35QbYs1ZhKJZtHu/g6xm9yOkpbF/+5gpSHNEO0gaClqOIjFlH
	 +I+cQ8tVvw4Q1TYJXSyNRkdnmlZ0aAB4UFZZIaLEzS6uI3il+egKrKwr5+FeJ9s4rk
	 Gv+AyELZvu9Cr58VU6ngInh/i778blWf6ZFSmR0u5Gv6Y2HQC0qAPfHCvUY/ghfXvl
	 LKVeDN/cvC+yEwueD9cOZr2FWHt8WIzut10SQ9JPwZ2k8tqFvK5ecVXCveERJpKerE
	 9XBdspsKZvIZCvNylx1c2yT60oN5evOJkdxkOToODhYIrd6cQoIcwHF8UEIhhzTYh8
	 UTe36DoyZezuQ==
Subject: Re: [PATCH net-next 3/4] dt-bindings: net: qcom,ipq9574-ppe: Add
 IPQ5332 support
From: netdev-bot+sashiko@kernel.org
To: mail@tk154.de
Cc: netdev@vger.kernel.org, jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 quic_leiwei@quicinc.com, quic_suruchia@quicinc.com, quic_pavir@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Thu, 08 Oct 2026 03:31:16 +0000
Message-ID: <179143027694.434549.10144875217597591854@kernel.org>
In-Reply-To: <20261005152915.101780-4-mail@tk154.de>
References: <20261005152915.101780-4-mail@tk154.de>
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

- [Low] The IPQ5332 port limits (`"^ethernet-port@[3-6]$": false` and
  `reg: maximum: 2`) apply only under the `ethernet-ports` container…

--

dt-bindings: net: qcom,ipq9574-ppe: Add IPQ5332 support

This adds the qcom,ipq5332-ppe compatible to the IPQ9574 PPE binding. It
adds an optional GCC sleep clock and a second EDMA reset, and lowers the
minimum interconnect and EDMA interrupt counts. New per-SoC if/then blocks
constrain those counts, and limit IPQ5332 to ethernet-port@1 and
ethernet-port@2.

Link: https://lore.kernel.org/r/20240829082830.56959-7-quic_varada@quicinc.com
Link: https://lore.kernel.org/r/20240110112059.2498-3-quic_luoj@quicinc.com

> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> index 1a78e2c82b90c..29dd34210ac89 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml

[ ... ]

> @@ -238,6 +255,65 @@ required:
>  
>  allOf:
>    - $ref: ethernet-switch.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,ipq5332-ppe
> +    then:

[ ... ]

> +        ethernet-ports:
> +          patternProperties:
> +            "^ethernet-port@[1-2]$":
> +              properties:
> +                reg:
> +                  maximum: 2
> +            "^ethernet-port@[3-6]$": false

[Severity: Low]
Is the IPQ5332 port limit enforced when the node uses "ports" as the
container name instead of "ethernet-ports"?

The new constraints only apply under ethernet-ports. The binding also
pulls in ethernet-switch.yaml through allOf, and that schema accepts
either container name:

Documentation/devicetree/bindings/net/ethernet-switch.yaml:
    patternProperties:
      '^(ethernet-)?ports$':
        ...
        patternProperties:
          '^(ethernet-)?port@[0-9a-f]+$':
            type: object
    ...
    oneOf:
      - required:
          - ports
      - required:
          - ethernet-ports

The referenced schema evaluates "ports", so the top-level
unevaluatedProperties: false in qcom,ipq9574-ppe.yaml does not reject it.
The PPE binding also does not list ethernet-ports in its required list.

So an IPQ5332 node like this would seem to pass dt_binding_check:

    ports {
        #address-cells = <1>;
        #size-cells = <0>;
        ethernet-port@3 {
            reg = <3>;
        };
    };

That would not match the commit message, which says IPQ5332 takes "only
ethernet-port@1 and ethernet-port@2".

The same gap already lets nodes skip the shared per-port clocks and resets
requirements for IPQ9574. The earlier patch in this series that tightened
the port node constraints also covered only ethernet-ports.

Would it make sense to forbid ports (for example ports: false), require
ethernet-ports, or apply the constraints to both spellings?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005152915.101780-1-mail%40tk154.de
