Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2828420472;
	Mon, 12 Oct 2026 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831690; cv=none; b=T1TDKpounyCFtOLdKk4M7nK2aU6B9+TOuyLXWcCfQqvtHH8R+cFf0mOh3Qo0McM3f1HCDS5E2V+qpfeswbwtouU+lsQWAwAeMEfKZoByzLiCMpGM4leSfS8yiUFP4DIQCFi1hUNUgs2mSznR8uJly3HdpoezUuGxTtKjrf08If8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831690; c=relaxed/simple;
	bh=hkJayNZQgrwdqqCuojchsmQlG6+Vkhn//x49kMEmH1I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrUdw02TAgf1xhNVGlcUDhgqMv6bzmH7yxqJbnuhm+hA36jlU4Kqr0htA6MT9pBZpBP7ZzsawuDd7r16+ejbVqBoutvVKqSVMyrCtHi/YQWgrzegrzGDiPqSfL9K/gW36S5k/K1WtXE74jx+8tH6Z0wf49aD+fQ3sS4E04sfksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7oJfps7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7oJfps7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D71A1F008A1;
	Mon, 12 Oct 2026 19:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831688;
	bh=xk+6pVVCUnWUK9IgM7r73lRfaDtOS1AqOjhCfpJf030=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l7oJfps7OydmdVFQdL8dS9pBt+n65dUip9H0ZEO7xSKTWtHAbYRwCtjeXiOREazIw
	 yeb8gkyBgiJZJ4y+Ns/8KBTQ92H4xWWZFkO4LKYnF6EmrtAGLA0jVHLhYLeAgjp079
	 Q08BuXxkaZXM/+txQ4jDAJzfj3eo/VnhK0vbwg0y4AQXBMnDJM1Zd22xmNS3hhc/eS
	 MRfVGUf4Gb5sJvvUsQJe6jxqN7m6sh9It1rEfvzfio/jg0Rh4GBVy+1b7oHCTlgvNP
	 flAUcbfddRcLaSFteFoymlntXLXmQknLG+LfhO43TX3VnsFWLk6OabYpiwJp3954nV
	 kk/PuK07up5YA==
Subject: Re: [PATCH net-next v11 2/6] dt-bindings: net: pcs: add
 rockchip,rk3568-xpcs support
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 david.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 19:01:27 +0000
Message-ID: <179183168700.434549.4839888235106301371@kernel.org>
In-Reply-To: <20261008175225.3375274-3-coiaprant@gmail.com>
References: <20261008175225.3375274-3-coiaprant@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new binding
  Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml…

--

dt-bindings: net: pcs: add rockchip,rk3568-xpcs support

This adds a new device tree binding for the Synopsys DesignWare XPCS on
the Rockchip RK3568 SoC. The XPCS is accessed over APB3 and connected to a
Naneng Combo SerDes PHY. The binding covers reg, the csr and eee clocks,
one phy and one power domain, and on purpose leaves out the CRU reset
lines.

> diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> new file mode 100644
> index 0000000000000..a331880eb11c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> @@ -0,0 +1,69 @@

[ ... ]

> +  phys:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - phys
> +  - power-domains
> +
> +additionalProperties: false

[Severity: Medium]
The properties list has no resets or interrupts entries, and
additionalProperties is false. Would a DT that fully describes this block
then fail dt_binding_check?

The SoC has four CRU reset inputs for this IP, defined in
include/dt-bindings/clock/rk3568-cru.h:

#define SRST_XPCS		150
#define SRST_XPCS_TX_DIV10	151
#define SRST_XPCS_RX_DIV10	152
#define SRST_XPCS_XGXS_RX	153

The commit message says they are left out because "no in-tree user
requests them". Documentation/devicetree/bindings/writing-bindings.rst
says the opposite:

  - DO attempt to make bindings complete even if a driver doesn't support some
    features. For example, if a device has an interrupt, then include the
    'interrupts' property even if the driver is only polled mode.

  - DON'T refer to Linux or "device driver" in bindings. Bindings should be
    based on what the hardware has, not what an OS and driver currently support.

Could resets and reset-names be added now, so the binding matches the
hardware?

The commit message also says the resets "can be added later as optional
without breaking ABI". Once DTs ship without them, though, they would have
to stay optional for good.

Could a driver then ever rely on putting the TX/RX div10 and XGXS RX
domains into a known state? The in-IP soft reset may not cover those
domains.

The same question applies to interrupts. The generic binding for this IP,
snps,dw-xpcs.yaml, documents an auto-negotiation interrupt output:

  interrupts:
    description:
      System interface interrupt output (sbd_intr_o) indicating Clause 73/37
      auto-negotiation events':' Page received, AN is completed or incompatible
      link partner.
    maxItems: 1

Is sbd_intr_o routed to the GIC on RK3568? If it is, should this binding
have an interrupts property too? If it isn't, could the commit message say
so?

The later patches in this series leave this binding unchanged, so neither
point is addressed later in the series.

> +
> +examples:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008175225.3375274-1-coiaprant%40gmail.com
