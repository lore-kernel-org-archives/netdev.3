Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7F3B14D7;
	Sun, 27 Sep 2026 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526547; cv=none; b=eN+WjkxVpkz2v2JHPHYVshsPVH96hRhnWKnv2Nl4YTLJD7d1t+aZKW8QWBl4k9d86buKUiGp8eRrjaiTg2yp4EJ4UAIrVYZnVZZr48E6tBvdrq5z481I7+S2Nskow5NQU0dx98v3Qzu5/lk5QmB/8JjkGyfMGur1Pye3Th0h8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526547; c=relaxed/simple;
	bh=NFwGvC4VcTSAbSA8FSD8ChPzP4PPCj/LwW9t2T9a8zA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0UAO1QBZJ7l3BItuB2YR0IZSK79+zoNAT/03S1tC4jC+Hfc1MxXx+sZyLhOPoJRT9Ad8tw6NA/TbLI0qJSl+/xddwoprT1XTIjgv3gD5OvTY7F4kYtj3D1Hta2GjoJfJiuHc7zxn/+857iSdIfLKe6ICAKYXARWcxib8E995Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IggNfbCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IggNfbCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002D31F000FF;
	Sun, 27 Sep 2026 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790526546;
	bh=lMcI0XjYXxee6gQybGjy+nF52Zob3DzrgHJzmXEp8fc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IggNfbCOWc3Qu2tHK8WHnDs24hP2X51WEjGQiUMCT3DAKwlWx+bJ2owge4SRyItne
	 p/YpydwrSEs+xZKdAH785auXYfIjvrNKDIDBUAxAo/fiCqY00BehgZU5c54oX8hC6K
	 K9jCzqmBItHAHdjk8iSth2KVRjfPInxo3/LlNMAG2uthWkQ0tLYPpdGi3TJsngGu/y
	 w8Vx/fxAHLAzMU15096FUduU0PNkJDGiVCemZpXViZtmcBbX7bDWUs6r7rFjhsykYP
	 RZxgnrIIqHOLoUnECh48i98eyWQRZi62VyGfLtyp9IkvBhsi4xxoVEGsUWWYjDTz2y
	 xDD4ugM5ILP0w==
Subject: Re: [PATCH net-next v15 2/9] dt-bindings: phy: document the serdes
 PHY on sa8255p
From: netdev-bot+sashiko@kernel.org
To: bartosz.golaszewski@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, vkoul@kernel.org,
 peppe.cavallaro@st.com, wens@kernel.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 shawnguo@kernel.org, festevam@gmail.com, jan.petrous@oss.nxp.com, s32@nxp.com,
 mohd.anwar@oss.qualcomm.com, romain.gantois@bootlin.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, mripard@kernel.org,
 christophe.roullier@foss.st.com, brgl@kernel.org, radu@rendec.net,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, dfustini@tenstorrent.com,
 linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-mips@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
 bartosz.golaszewski@linaro.org
Date: Sun, 27 Sep 2026 16:29:03 +0000
Message-ID: <179052654351.2160803.11432185989352625433@kernel.org>
In-Reply-To: <20260923-qcom-sa8255p-emac-v15-2-e82f33720737@oss.qualcomm.com>
References: <20260923-qcom-sa8255p-emac-v15-2-e82f33720737@oss.qualcomm.com>
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

- [Low] In the new binding
  Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgmii-…

--

dt-bindings: phy: document the serdes PHY on sa8255p

This commit adds a new binding for the SGMII/SerDes PHY on Qualcomm sa8255p
platforms. The hardware is the same as sa8775p rev3, but here firmware
manages the PHY over SCMI.

> diff --git a/Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgmii-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgmii-phy.yaml
> new file mode 100644
> index 0000000000000..9e846e3815555
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgmii-phy.yaml

[ ... ]

> +  power-domains:
> +    maxItems: 1
> +
> +  power-domain-names:
> +    maxItems: 1

[Severity: Low]
This isn't a bug, but should power-domain-names pin its value here?

The property is listed under required, and the example uses "serdes".
However, the only constraint is maxItems: 1. A node with
power-domain-names = "foo" would still pass dt_binding_check, so the value
of a required property is left undefined in the ABI.

The other firmware-managed sa8255p bindings fix their names with const
entries. For example, qcom,sa8255p-geni-i2c.yaml has:

  power-domain-names:
    items:
      - const: power
      - const: perf

qcom,sa8255p-ethqos.yaml, added later in this series, does the same with
core and mdio.

power-domains also has no description, so the binding doesn't say what the
single domain represents.

Could this use items: - const: serdes for power-domain-names, and add an
items: - description: entry for power-domains? Another option is to drop
power-domain-names, since there is only one entry.

The driver added later in the series (phy-qcom-sgmii-eth-scmi.c) doesn't
look the domain up by name. The driver core attaches the single domain
automatically, so an unexpected name causes no runtime failure. The concern
is limited to the schema and the ABI definition.

> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - power-domains
> +  - power-domain-names

[ ... ]

> +        power-domains = <&scmi7_dvfs 0>;
> +        power-domain-names = "serdes";
> +    };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-qcom-sa8255p-emac-v15-0-e82f33720737%40oss.qualcomm.com
