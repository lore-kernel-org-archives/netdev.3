Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511154;
	b=MvcXsgl2BzCcyMel25FeZQtEjsXEyim8cQyI4fc4rkh5BApqHhoLZpjlHwV9Y63NSEua
	 YytH0mFYYCqPJp7RYFrqWXT0/c/WyN6vAgWlACdz7wsGHgFbpaIvci8mz2SwJSkaT2UxH
	 LKXd9YlZATVKs943ZA318AGLEu1NqfJeVTo98W66x2vcLwGRh3+WrzAiQDhD7rMQrtB+2
	 G5fzGZv9lAkUEBcXuLCQIaaJQZDIefQohzaEQuJabnI7QtuwS5gGGHONtBiKYepHhlQdO
	 ASdgvr/KO9jnIN0q6KOz8eA8xZ93tzz0ZNxI36eW87BJlPBbGrYFwVi3u81PGh/aonw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511154;
	h=Received:Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 X-sashiko-severity:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=2cAZVCLAQpN5a+aDVXVz9w99JGOZYk0P7w6fotRmbJI=;
	b=MSW4O/r/x3g4HhS9QqY/baxOxtopgDQpO6e4AlPB7aJSNE48Rv7hep+5sY/qYoZB0+mA
	 8FBm/wJwrAqUKfGk34Q+O5ypSVIfa0V2fc+0DblufXCpQU/E9HSlJRj9FkEu+FzJ5DUo/
	 Tw1DHZr12T4iJqmN2igiPC2DhpEBW7vWi0dpW9msgcEHoE8tiDxJG7cfkK7T8Yl+vTlVH
	 +wdl5mBMP2M28V7mBTJJO8uXvjt/74/2Ozl9gPKentvfVIyCHPH60Zn0FY0cqziG8veyc
	 b9+7nfOlLsY4EkQsamgbMvM2KFGVF78lkZftJBp2I+qPefkPEjJJHT+NL7yxfeEgXjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABED606A31C;
	Tue, 20 Oct 2026 15:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF6A1F000C5;
	Tue, 20 Oct 2026 15:45:53 +0000 (UTC)
Subject: Re: [PATCH net-next v2 2/3] dt-bindings: net: qcom,ipq9574-ppe: Add
 IPQ5332 support
From: netdev-bot+sashiko@kernel.org
To: mail@tk154.de
Cc: netdev@vger.kernel.org, jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-doc@vger.kernel.org
Date: Tue, 20 Oct 2026 15:45:22 +0000
Message-ID: <179251112267.3135.4070073484020309929@kernel.org>
In-Reply-To: <20261016152449.934312-3-mail@tk154.de>
References: <20261016152449.934312-3-mail@tk154.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The IPQ5332 port conditional in
  Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml (allOf[1]…

--

dt-bindings: net: qcom,ipq9574-ppe: Add IPQ5332 support

This adds the qcom,ipq5332-ppe compatible to the IPQ9574 PPE binding. It
also adds per-SoC conditional blocks that constrain clocks, interconnects,
EDMA resets, interrupts and ring names. IPQ5332 port nodes are meant to be
limited to port IDs 1 and 2.

> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> index 6d0b21a10732a..1e95f3a1d0b12 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml

[ ... ]

> @@ -229,6 +246,65 @@ required:
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

> +      patternProperties:
> +        "^(ethernet-)?ports$":
> +          patternProperties:
> +            "^(ethernet-)?port@[0-9a-f]+$":
> +              properties:
> +                reg:
> +                  maximum: 2

[Severity: Medium]
The commit message says:

  IPQ5332 takes four interconnects and only port IDs 1 and 2 ...
  Apply the port-count limit to both container and port naming forms.

Does this block reject port ID 0? It only sets maximum: 2. The only lower
bound in the file is in the base ethernet-ports schema:

  ethernet-ports:
    patternProperties:
      "^ethernet-port@[1-6]+$":
        ...
        properties:
          reg:
            minimum: 1
            maximum: 6

That pattern does not match ethernet-port@0. It also does not apply to a
container named ports. Nodes like these are matched only by the generic
'^(ethernet-)?port@[0-9a-f]+$' pattern in ethernet-switch.yaml, which is
just type: object.

With compatible = "qcom,ipq5332-ppe", would both of these pass
dt_binding_check?

  ethernet-ports {
      ethernet-port@0 {
          reg = <0>;
      };
  };

  ports {
      port@0 {
          reg = <0>;
      };
  };

If so, the accepted set is {0, 1, 2}, not {1, 2}. Port 0 is the CPU port
according to the updated description.

These nodes also skip the per-MAC clocks, clock-names, resets and
reset-names. Those are only required under "^ethernet-port@[1-6]+$". The
ports/port@ spelling already skipped them on IPQ9574, but this block now
applies per-SoC port constraints to that form as well.

Would adding minimum: 1 next to maximum: 2 here fix this? A shared lower
bound in the base schema that covers both naming forms would also work.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016152449.934312-1-mail%40tk154.de
