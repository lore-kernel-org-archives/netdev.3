Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844089;
	b=xSWRM5WH60wLiXw+BmnNdkrurVUmhZe5L77nAGbClP0Jz/zpbXMdbNMHqdsO6nyd2XS4
	 WgtmP1GZfhHZBwKhkCb1feSaTUI36uX9tf8oWfNOB5yIuNCz5iw4XXl5g0f+kC1zuS4ra
	 RRVWU6+XFa0hq8kAtv28jIGdwtHOhpwu2gTyo3mkF14Hmt9bSLcbq0n1IcQIUPe03nrGI
	 ZEk6ZsmreuUIR4pE/7eRfVPEymaObJntk2qNIx7YWOSh+bDaUyPRXZcjXRVFOIAlbU0tb
	 eg5VwHGg1lILVwSDS45PitCD4Kseftyfxi7ZVqDWA8xxQdf9UD7WOJKzGUQybhKLtiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844089;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=E5AyoP6mbHziWGgjUa8zzhwiZ6VV6LjlGezRNss3iLk=;
	b=wza3LHqVjTRRyMinpHCNB7kd3ZiSS5Z498yt5vHSQRMS9oPdC7BrrUaDZWKZvCZeExAQ
	 jyI1/laYQss8CiSYPzSWuVed08XHj7fsFIS5pOSi7Q1D5SW3ZgnHZdU5MSu+hGdjMnzqT
	 7iZCxLqsrH8Q+Eu6Nx7BGkQK38mIG1MdnbJ/Z86yWxZgYx25GFpYYtxlln6QMW+678Wtj
	 /2uETldpA3aw3kFIIWvdkF4jqnoioYzW5pZoi1Vqk2InwVRyOTso/akxbFzcU6q4rYw7Q
	 8WCgRmngdGMng5lr5mCCyktXq1SjMJDgibAYMBR4JjV4k1aL0tOVR1o9DEIQuxtFLHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWH8fcI+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA1606A321;
	Sat, 24 Oct 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWH8fcI+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF221F01828;
	Sat, 24 Oct 2026 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792844088;
	bh=E5AyoP6mbHziWGgjUa8zzhwiZ6VV6LjlGezRNss3iLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GWH8fcI+AOK4pO8D2LIpl/lFt4jLQF2hkPxD05pDsYoBxzVR9gtpS9D7iFLY8Crj1
	 Q3p0YEbjlJ7S2USVoGXQnRx64TU/gIRxnWW3KniRyJ2tBAI5UIguf6/XLzWuTgfGry
	 Scie+Jnw8BR0Das9tWaTWt3tfQ2WoPFJ7bA/oQTqvom6AZkApWVTUBn2DJ9cn+Wyu7
	 QgsvmOhbf6tlvsRFYEZYY05jYNIn/t/wzdUC2V3k2xFDGokVIx2aMHcRGD9X4egUy+
	 tKOQqs0XaJQoGk/9J0fVYEWfGOaHtgnfF//Th7xPnd/wV4ZM0bmspJF+VYmSjcih4O
	 GNBEtElTZBKPg==
Subject: Re: [PATCH net-next v4 2/7] dt-bindings: net: ftgmac100: Add AST2700
 compatible
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch
Date: Sat, 24 Oct 2026 12:14:47 +0000
Message-ID: <179284408729.3134.422734573561915200@kernel.org>
In-Reply-To: <20261020-support_ast2700-v4-2-4d36b40939b3@aspeedtech.com>
References: <20261020-support_ast2700-v4-2-4d36b40939b3@aspeedtech.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In this binding patch, the new AST2700 rule `if compatible
  contains aspeed,ast2700-mac then required: [phy-mode]`…
- [Medium] This patch makes `aspeed,ast2700-mac` a standalone compatible,
  "consistent with the other Aspeed compatibles".
- [Low] Concern (baseline: not a valid finding): the commit message says
  the AST2700 phy-mode requirement matches "the driver's probe-time…
- [Low] Concern (baseline: not a valid finding): the binding documents
  `aspeed,ast2700-mac` as standalone, but ftgmac100_of_match[] has no…
- [Low] Concern (baseline: not a valid finding): for AST2700 the binding
  only allows `resets`, as for AST2600, instead of requiring it.

--

dt-bindings: net: ftgmac100: Add AST2700 compatible

This adds aspeed,ast2700-mac as a standalone compatible to the ftgmac100
binding. It allows the resets property for it, as is already done for
AST2600. It also adds a conditional block that requires phy-mode whenever
the AST2700 compatible is used.

> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index c870dd0bda7b2..0a376b849a916 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -17,6 +17,7 @@ properties:
>            - aspeed,ast2400-mac
>            - aspeed,ast2500-mac
>            - aspeed,ast2600-mac
> +          - aspeed,ast2700-mac

[Severity: Medium]
This builds on the previous patch in the series, commit c64ed4df5e64
("dt-bindings: net: ftgmac100: Make Aspeed compatibles standalone"). That
patch turned the compatible into a oneOf of single strings. Do the existing
in-tree Aspeed MAC nodes still pass validation with that?

aspeed-g4.dtsi, aspeed-g5.dtsi and aspeed-g6.dtsi all use the two-string
form. For example, in aspeed-g6.dtsi:

    compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";

A compatible with two entries matches neither oneOf branch. So dtbs_check
would now fail for the MAC nodes on every AST2400/2500/2600 board. The
series doesn't update those dtsi files, and neither commit message
mentions this.

The reason given in the previous patch also looks doubtful. In
__of_device_is_compatible() the score depends on the position in the
compatible list:

    if (of_compat_cmp(cp, compat, strlen(compat)) == 0) {
            score = INT_MAX/2 - (index << 2);
            break;
    }

So the more specific "aspeed,ast2x00-mac" entry always wins over
"faraday,ftgmac100". A two-string node can't bind through the generic
entry alone. The bare "faraday,ftgmac100" alternative is also still
accepted, so the hazard described there is still present.

Could the two-string fallback form stay as an accepted alternative, or
could the dtsi files be updated as part of this series?

[Severity: Low]
At this commit, ftgmac100_of_match[] has no entry for aspeed,ast2700-mac
and there is no FTGMAC100_AST2700 mac_id. Would a node that follows this
binding fail to bind at this point?

A later patch in the series, "net: ftgmac100: Add AST2700 compatible
support", seems to handle this. It adds:

    { .compatible = "aspeed,ast2700-mac",
      .data = &ftgmac100_match_data_ast2700 },

It also adds FTGMAC100_AST2700 to the is_aspeed / BIT(30) selection in
ftgmac100_probe(). So this only affects the intermediate state of the
series, and putting the binding before the driver is the usual DT order.

[ ... ]

> @@ -80,12 +81,21 @@ allOf:
>            contains:
>              enum:
>                - aspeed,ast2600-mac
> +              - aspeed,ast2700-mac
>      then:
>        properties:
>          resets: true
>      else:
>        properties:
>          resets: false

[Severity: Low]
This isn't a bug, but for AST2700 resets is only allowed here, not
required. ftgmac100_probe() gets the reset with
devm_reset_control_get_optional_exclusive(). If resets is missing, the
RMII SCU reset in ftgmac100_reset_and_config_mac() silently does nothing.

This matches the AST2600 handling and the commit message. AST2400/2500 run
the same is_aspeed && RMII reset path while their binding forbids resets,
so this is probably intended.

Does AST2700 hardware need the reset in a way AST2600 does not, so that
resets should be required?

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2700-mac
> +    then:
> +      required:
> +        - phy-mode

[Severity: Medium]
Should NC-SI nodes be exempt from this rule? There is no use-ncsi
exception, so an AST2700 node with use-ncsi and no phy-mode now fails
dtbs_check.

That is the same shape as the first example in this binding, which uses
aspeed,ast2500-mac. The use-ncsi description also says "Currently assumes
rmii (100bT)".

The driver doesn't read phy-mode in NC-SI mode, even at the end of the
series. ftgmac100_probe_dt() returns early:

    if (of_get_property(np, "use-ncsi", NULL))
            return ftgmac100_probe_ncsi(netdev, priv, pdev);

and ftgmac100_probe_ncsi() hardcodes the interface:

    err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
                             PHY_INTERFACE_MODE_RMII);

The phy-mode check that "net: ftgmac100: Require phy-mode for AST2700"
adds to ftgmac100_mii_probe() also looks unreachable on AST2700. Only
ftgmac100_setup_mdio() sets priv->mii_bus, and it is called only for
FARADAY/AST2400/AST2500. So ftgmac100_mii_probe() returns -ENODEV with
"No MDIO bus available" before it gets to the phy-mode test.

That leaves the generic requirement in of_phy_get_and_connect() on the
phy-handle/fixed-link path. AST2600 goes through the same path, but this
binding does not require phy-mode for AST2600.

Given this, is "matching the driver's probe-time requirement" accurate?
Could the rule require phy-mode only when use-ncsi is absent?

[Severity: Low]
On the same topic, the commit message says:

    Require "phy-mode" to be present in the device tree when the AST2700
    compatible is used, matching the driver's probe-time requirement.

At this commit the driver has no AST2700 support yet, and a missing
phy-mode falls back to RGMII. Is the driver requirement referred to here
only the one added later in the series?

After "net: ftgmac100: Add AST2700 compatible support" and "net:
ftgmac100: Require phy-mode for AST2700", the AST2700
phy-handle/fixed-link path does require phy-mode, through
of_phy_get_and_connect():

    ret = of_get_phy_mode(np, &iface);
    if (ret)
            return NULL;

The RGMII default no longer applies to AST2700, because
ftgmac100_mii_probe() returns -ENODEV before reaching it. The remaining
gap is the NC-SI case above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-support_ast2700-v4-0-4d36b40939b3%40aspeedtech.com
