Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D77474250;
	Fri, 24 Jul 2026 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933166; cv=none; b=aDWiun7La8ORsztu+fP9L5kzqggsaUqV2Je0NTnZUPaX6h8AoG8MTOBNgOTGF4XpkvE9hcfnMh5RhUywn3bLEHmJD30meQQQS9EI+WzSzaVj/WPglobfJnAT4hG50g/+3KtrI9+kKdAyWqibwYh5fVyOeWe24CTKXysLo+f5Me8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933166; c=relaxed/simple;
	bh=e4Q33RAXNj4uJS5ISuZOeLCNZsLtSpbzoOGnqL3oT+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjzU32uJFAqnHdZs6rxpxCnAOc3PsyvvqkRTK9cC3i5I4B4B3VntR4c2PZKDZ+MgtGNfLmCoki81i6KGOp+ZjUj2ijeR23BnJAFRZpmyuC1yVxx6IF+fTzArbkyP+9QcHvc30UGHSjP2tVneaJyJ56+itNiYja8GdMM6C30NcXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezEc5WAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezEc5WAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7801F000E9;
	Fri, 24 Jul 2026 22:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784933155;
	bh=+Js/I4/QcWnb0zbX3gJ/7hcd5ufvSHyxR3nJSzCYliA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ezEc5WAtQmjF1QNZEepG+PeGNUSM1i0ETfgxrcmRp2dFbxVSIBg5Ug2rt2jfXSA/J
	 /BJ8Q7Q8fJGb/Fy06yCqKiRQD6fukqeCaNl+KEz+xTWvMe74o/PDAZ1cOPXC2klD1l
	 CdT2J1YMHvMXMZovWR/n65Im1ZcZLRVhAL52YiF55A8NElc5hGew7qh1bcT/QdhDYC
	 8JConp1P0raofTTt2KatNTEbDBNoUctVg2yhjzeIDngIzInOwIGh7DAleTGovW1TFH
	 VWi+Ae3CHAb/7wh4nSQnZkyyC4s2uq4Zv0pO0d6folIFc8CXTpntfDy+CznQO/i3SV
	 k/19l+KNqw3Jg==
From: Jakub Kicinski <kuba@kernel.org>
To: bartosz.golaszewski@oss.qualcomm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	vkoul@kernel.org,
	peppe.cavallaro@st.com,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	shawnguo@kernel.org,
	festevam@gmail.com,
	jan.petrous@oss.nxp.com,
	s32@nxp.com,
	mohd.anwar@oss.qualcomm.com,
	romain.gantois@bootlin.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mripard@kernel.org,
	christophe.roullier@foss.st.com,
	brgl@kernel.org,
	radu@rendec.net,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	dfustini@tenstorrent.com,
	linux-sunxi@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-mips@vger.kernel.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	bartosz.golaszewski@linaro.org
Subject: Re: [PATCH net-next v13 02/10] dt-bindings: phy: document the serdes PHY on sa8255p
Date: Fri, 24 Jul 2026 15:45:48 -0700
Message-ID: <20260724224548.1648931-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713-qcom-sa8255p-emac-v13-2-119f8699ef8e@oss.qualcomm.com>
References: <20260713-qcom-sa8255p-emac-v13-2-119f8699ef8e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dt-bindings: phy: document the serdes PHY on sa8255p

This patch adds a YAML binding describing the SGMII/SerDes PHY present on
Qualcomm sa8255p platforms, where the same hardware as on sa8775p rev3 is
managed by firmware over SCMI.

> diff --git a/Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgmii-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgmii-phy.yaml
> new file mode 100644
> index 000000000000..9e846e381555
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgmii-phy.yaml
> @@ -0,0 +1,50 @@

[ ... ]

> +  power-domains:
> +    maxItems: 1
> +
> +  power-domain-names:
> +    maxItems: 1

[Low]
This isn't a bug, but would it be worth tightening the power-domain-names
schema to constrain the actual string value, along the lines of:

  power-domain-names:
    items:
      - const: serdes

As written, only the number of entries is constrained and any arbitrary
string would pass validation, whereas the example uses "serdes":

    power-domains = <&scmi7_dvfs 0>;
    power-domain-names = "serdes";

Would matching the example with a const also help keep naming consistent
across DTs using this binding?

[ ... ]
-- 
pw-bot: cr
