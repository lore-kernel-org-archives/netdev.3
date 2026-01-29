Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE56156236;
	Thu, 29 Jan 2026 05:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663404; cv=none; b=YnRrSuDd1VJsJl6y/iIBZebRU3Jbg3RyTvj16vayfxgfFoiMdE+02XU3lI3k+AFDCz4gHqC7IxJN65d4wvqJlRU50/SqZxesVK62weNXb7PEltfnDZIWOoMI07+VE/tzZV3ekfY5g8oWg8YfW2PT3SNj+351Zx279QZPQsFWGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663404; c=relaxed/simple;
	bh=MEKmakKxwgOmIdbsb7SgejjAQhwjoaOqNpBcOcihee4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P14M7DA1Oe6J/DrlAKnOVqFgc/HH96UMEye3hEEPx/U6cQd4WLC8R2yz9cy9GR3euwnXHBxHC7pYoTePvXT9k7ZVssFEtn2BjVh8b7kr/sX7Uf2aPq9M+O21F61rj4EoBsp8jBNmbtw97pXm+skXPIcOc3s7MOYCTqa7aRLdv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTqdfYgo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTqdfYgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE81C116D0;
	Thu, 29 Jan 2026 05:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663403;
	bh=MEKmakKxwgOmIdbsb7SgejjAQhwjoaOqNpBcOcihee4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTqdfYgoSCk9iPbjkAjUMrfRPXimW0a4VCa9JpDyxDl3bawyEwF+0ZQIN+Ou1Wwb4
	 K9gzLmicFDJ2Fj+/5fHBoviWKsIue4fRuKRncSlwZ7Qf0ezGoQ+ssbmHK8ZdEw20mu
	 Yk/PAeABpRn849LSVP7fulNiBh1RTCvIpDSNhecJNKVOGmYM1lELsX7G+AOIiKiuuP
	 /EqGiVCCXRSkheayBOSMXzThHs0bQ0eC24Xo53glVd2nqaqJMK3PkjFFXjWrHWCD+b
	 aCxLyACMuY//EGfI5MbdygHLisM7zH2AHvJMylthRz3byVCmYD6JNE24HvUv/6SqCN
	 +ruVTsBFv+hVw==
From: Jakub Kicinski <kuba@kernel.org>
To: jan.petrous@oss.nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	shawnguo@kernel.org,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andrew+netdev@lunn.ch,
	mbrugger@suse.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	s32@nxp.com,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	s.hauer@pengutronix.de,
	conor+dt@kernel.org,
	chester62515@gmail.com,
	festevam@gmail.com,
	mcoquelin.stm32@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	devicetree@vger.kernel.org,
	alexandre.torgue@foss.st.com
Subject: Re: [v4,1/4] net: stmmac: platform: read channels irq
Date: Wed, 28 Jan 2026 21:09:59 -0800
Message-ID: <20260129050959.375635-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128-dwmac_multi_irq-v4-1-82fa34fcf2f2@oss.nxp.com>
References: <20260128-dwmac_multi_irq-v4-1-82fa34fcf2f2@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: platform: read channels irq

This patch reads IRQ resources for all rx/tx channels to allow Multi-IRQ
mode for platform glue drivers.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 8979a50b5507..94854bfb6e0d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

[ ... ]

> +	/* RX channels irq */
> +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		scnprintf(name, sizeof(name), "rx-queue-%d", i);
> +		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev,
> +									 name);
> +		if (stmmac_res->rx_irq[i] <= 0) {
> +			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			dev_dbg(&pdev->dev, "IRQ rx-queue-%d not found\n", i);
> +
> +			/* Stop on first unset rx-queue-%i property member */
> +			break;
> +		}
> +	}

When platform_get_irq_byname_optional() returns a negative error like
-ENXIO, that value is stored in stmmac_res->rx_irq[i] before the break.

In stmmac_request_irq_multi_msi(), the check is:

    if (priv->rx_irq[i] == 0)
        continue;
    ret = request_irq(priv->rx_irq[i], ...);

Should the negative value be cleared before the break? Otherwise if
rx_queues_to_use exceeds the number of defined IRQs, the negative error
code could be passed to request_irq().

> +
> +	/* TX channels irq */
> +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> +		scnprintf(name, sizeof(name), "tx-queue-%d", i);
> +		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev,
> +									 name);
> +		if (stmmac_res->tx_irq[i] <= 0) {
> +			if (stmmac_res->tx_irq[i] == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			dev_dbg(&pdev->dev, "IRQ tx-queue-%d not found\n", i);
> +
> +			/* Stop on first unset tx-queue-%i property member */
> +			break;
> +		}
> +	}

Same question here for tx_irq[i].
-- 
pw-bot: cr
