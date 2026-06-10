Received: from mail.eswincomputing.com (mail.eswincomputing.com [123.124.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0325392A;
	Wed, 10 Jun 2026 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.124.195.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055067; cv=none; b=S2GE/9EzQ7QMS3MpIUAw1iqtIzh5BeBPdxOgBP7jiRK8kXRHZCUf5VinzGEKOL+s56PEkmWgIGfg4UNX44FGJHV033grGtu8Qt0xPkPbYTs1aAIzzKFMYNcRO7aQTX1s9Jky+E1Uota0hQwfnZCOWbNLCGY+0Dy6PnHfZMPuRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055067; c=relaxed/simple;
	bh=M8DcNB1oRP1N+K/EhND2ua3BUW7ikd7HXngLRl8spPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWjtQ7wGsGlRGFZ9+4LVVVjIqErM6EWdRJlh/cZ3v1JeI6Ld3Fz505w5q+SR5l1q3xENCmkn3PlcEL5lSk3mvMKnhRAAIRRaVRyhiRU5Ifp/iZJMevkNuj3Sa5CNcz1OHV52Tz1BRcCHLMsEf/Tgm23aeH04D4qrlKliMzoeK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=123.124.195.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app1 (Coremail) with SMTP id TAJkCgC3WXMCvihq9pMlAA--.3157S2;
	Wed, 10 Jun 2026 09:29:40 +0800 (CST)
From: lizhi2@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	horms@kernel.org,
	lee@kernel.org,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net-next v8 3/6] net: stmmac: eic7700: make RGMII delay properties optional
Date: Wed, 10 Jun 2026 09:29:37 +0800
Message-ID: <20260610012937.911-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260610012727.848-1-lizhi2@eswincomputing.com>
References: <20260610012727.848-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgC3WXMCvihq9pMlAA--.3157S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DCrWfXw1UZry8tFyfCrg_yoW8ZrWrpF
	W5JF1Yv3srtr1xK3Z8Aa1v9a4rta1jgF1xKryrtwn3Za90kF9Yqa43Ka4YkF1jgrWkZF1a
	y3yDJFWxu3WjkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWx
	Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRMrWrDUUUU
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/

From: Zhi Li <lizhi2@eswincomputing.com>

Make rx-internal-delay-ps and tx-internal-delay-ps optional in the
EIC7700 DWMAC driver.

The driver previously required both properties to be present and would
fail probe when they were missing. This restricts valid hardware
configurations where RGMII timing is instead provided by the PHY or
board design.

Update the driver to treat missing delay properties as zero delay,
allowing systems without explicit MAC-side delay tuning to operate
correctly.

This aligns the driver behavior with the updated device tree binding
and provides a safe default configuration when MAC-side delay
programming is not required.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
index 4ac979d874d6..ec99b597aeaf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -165,9 +165,6 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
 		dwc_priv->eth_clk_dly_param |=
 				 FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
-	} else {
-		return dev_err_probe(&pdev->dev, -EINVAL,
-			"missing required property rx-internal-delay-ps\n");
 	}
 
 	/* Read tx-internal-delay-ps and update tx_clk delay */
@@ -187,9 +184,6 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_TX_ADJ_DELAY;
 		dwc_priv->eth_clk_dly_param |=
 				 FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
-	} else {
-		return dev_err_probe(&pdev->dev, -EINVAL,
-			"missing required property tx-internal-delay-ps\n");
 	}
 
 	dwc_priv->eic7700_hsp_regmap =
-- 
2.25.1

