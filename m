Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA411418A29;
	Sun, 27 Sep 2026 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526553; cv=none; b=jjAhrPbM5sR3YHEZbjDmNp9H37DpoJqy+rsf1g7rQFFAIdhHTqMB2SHR8JZ39EFS40wsiLGhwc/Er07WfJ0+hKpjQxWLsffPYl0QLYFQjj9e/7Z+2/519rCavkOz5u2u1obXWbeaKZy+XV7aBw8HhYL9PerNnaCf1Zv43F4j9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526553; c=relaxed/simple;
	bh=cgM5yc5YR5LcA0ggRlCC2PjuzuLLctYUpXeQJB+og7A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3kTGhDe3sZqM4sg7XOal+INXpk60I9R5T1twBxZ51XbpgP/Th/yaMstLW3wOINQT5gqz8+1BDSaKZugyOwgGMHnWygTq3x/gxMrDmj6us1LrDrVFbkjH27Tej9IiBm39OF1JcAJ00eRfJtS6ZOSy/sHdIkWOUjlXaoIlnNDTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxICCo1r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxICCo1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0663A1F000FF;
	Sun, 27 Sep 2026 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790526552;
	bh=MlHTKFJ9nOjJ4sei8TYyoCL9woju/FNAQOM8EKr+6Eo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IxICCo1rUsPvmAF8mGGbFkPTJ05RBCUvmgy0UW4EUH76muN5ijdWchfDgdrhVUnJI
	 DqizfgfFeCpZ3NJm4x5u3yT0j9l14+gPWqRSeC2jaHAUC2KyzsaTn6XWRVNtZQd3TI
	 jiq839Ujj9K7/+0qMDQDFXIL28VrHq1M+QIS06NTqW1b6jQI7cpplV1F15dgONJcTv
	 DYjcDiDgcgL1CiF1fjfr+bjgrO5X+f+AhMN8MYHdKoNZHrriryVFVHnNsI5AliU08+
	 l95TAGiQbIcFCjwFMxd1qNLhC5LcrvjItGrB+3gsQtloH4zHcN9iJ2LeItn7yiTplv
	 fwKE+ITzIHRdA==
Subject: Re: [PATCH net-next v15 4/9] dt-bindings: net: qcom: document the
 ethqos device for SCMI-based systems
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
Date: Sun, 27 Sep 2026 16:29:09 +0000
Message-ID: <179052654960.2160803.15091686199225539012@kernel.org>
In-Reply-To: <20260923-qcom-sa8255p-emac-v15-4-e82f33720737@oss.qualcomm.com>
References: <20260923-qcom-sa8255p-emac-v15-4-e82f33720737@oss.qualcomm.com>
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

- [Medium] This patch raises the shared `power-domains` limit in
  Documentation/devicetree/bindings/net/snps,dwmac.yaml from `maxItems:…

--

dt-bindings: net: qcom: document the ethqos device for SCMI-based systems

This commit adds a separate binding for the firmware-managed qcom,sa8255p-ethqos
variant of the Qualcomm DesignWare MAC. It also adds that compatible to
snps,dwmac.yaml and raises the shared power-domains limit there to two. To
keep the old limit for other devices, it adds power-domains maxItems: 1 to the
vendor bindings that reference snps,dwmac.yaml.

> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 0ff9e3284a061..1f2ee684dc391 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml

[ ... ]

> @@ -186,7 +187,8 @@ properties:
>            - enum: [ahb, stmmaceth-ocp]
>  
>    power-domains:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

[Severity: Medium]
Was ultrarisc,dp1000-gmac.yaml missed? The commit message says:

  let's update existing bindings referencing the top-level
  snps,dwmac.yaml and limit their maxItems for power-domains to 1.

Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml already
exists at the baseline and references this schema:

  allOf:
    - $ref: snps,dwmac.yaml#

  unevaluatedProperties: false

Its properties block lists compatible, reg, clocks, clock-names, interrupts,
interrupt-names and phy-mode. It has no power-domains entry, so it only gets
the relaxed limit from snps,dwmac.yaml.

Before this patch, dt_binding_check and dtbs_check rejected a DP1000 node
with power-domains = <&a>, <&b>. With this patch that node is accepted. This
is still the case at the end of the series.

Nodes checked only through the select in snps,dwmac.yaml are affected too.
That covers generic snps,dwmac* or snps,dwxgmac* compatibles with no vendor
schema. These nodes now also accept two power domains, because no vendor
schema restores the limit of 1.

One option is to add power-domains maxItems: 1 to ultrarisc,dp1000-gmac.yaml.
Another is to keep maxItems: 1 here and allow two only for
qcom,sa8255p-ethqos in an allOf if/then block. That would also cover
bindings added later.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-qcom-sa8255p-emac-v15-0-e82f33720737%40oss.qualcomm.com
