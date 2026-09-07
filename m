Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE523E49FE;
	Mon,  7 Sep 2026 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767257; cv=none; b=D8M576PwwMnQ0BQJ0KNKrhhJtz5L3YuXT0sBEKLJMAAi3Rk/x4+RAzPeDKUQL+Bg0oFxtOgBHI+Bs8QN3UTrLMnpbn2MHq3rcsBGrCL8c6NMpZLfIFhFMtc6OuYpQofbpYtKPTGuaQl1EGjcVIHxq0n0uFRiD4nuaJoFvF8DdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767257; c=relaxed/simple;
	bh=8JFbeS+Py36rOhLIgvUhB9mAaPmVG/RndlIsx1DgsiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgkI9rN0aRv739f4aB04hxTVrQ8a3JTVp4AHS8wjcvEcAS9u15Uhisc4XXeJVJZsb2fhsnX2QiS4fqkFXuCH7pLrhSvl6+Kh55A3lRexmsY+/FnsUvwsToqssRFuQjbjx8QwyecfoJ3bn3OzdRLOVQFwXuf30Za+YABJgf4rJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=i4Wk9lQT; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="i4Wk9lQT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=826tG4CJ8qXFpoWs+M4CKnCE0V6wdTg
	DiM5l8QR/xC0=; b=i4Wk9lQTV1c8cUxckKQbwikaLXzLidwHd907Qxwqs3rCjJj
	F1uxUjuR7SEMN6wDILp40V+kF/MTAUcloEc6WNADj8Mi6UJT3X0MpVk+qQRvf+6w
	7FaazqjFKoNeheg1I12blBhVmSQoPeObmMaAqrnlng1eF2nQG8hpMm9GOsIc=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAf_a55qnlUAAA--.364S3;
	Mon, 07 Sep 2026 15:47:18 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Mon, 07 Sep 2026 15:46:50 +0800
Subject: [PATCH net-next v2 1/5] net: stmmac: Add common internal RGMII
 delay handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-dwmac-ultrarisc-v2-1-9a39bf8db313@ultrarisc.com>
References: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
In-Reply-To: <20260907-dwmac-ultrarisc-v2-0-9a39bf8db313@ultrarisc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Jia Wang <wangjia@ultrarisc.com>, 
 sophgo@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788767221; l=2291;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=8JFbeS+Py36rOhLIgvUhB9mAaPmVG/RndlIsx1DgsiM=;
 b=U54wAoUOL/UPMsjC/20nyWiakLD/fkZD8+RhaL3RFCDl5C7EBqSc173xsMTwiaWma0ybZQDE7
 N5lKAYPGMB6BQV4hsQWg/jNQc6rSZJOGZsOPakAP94oi0ZDMnC4/rQx
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwDHQAf_a55qnlUAAA--.364S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWDGw15Kr1rZrW8JF1xGrg_yoW8Kr13pa
	yDCa43Xr1kGr17KwnxCa1UZFyY9ay7KrW2k34UW393Zay7tr9Iqrn0qrWjyFnxCrZxW3W7
	tr12ka98ua98ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUU9N3UUUUU=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQACEWqdDaQAAQANsA

Some DWMAC integrations add fixed RGMII clock delays internally.
Glue drivers need to account for these delays before passing the
interface mode to the PHY.

Add TX and RX delay capability flags to the common platform data.
Apply phy_fix_phy_mode_for_mac_delays() in stmmac_pltfr_probe() when
either capability is present.

This lets glue drivers describe the MAC capabilities without
duplicating the interface-mode validation and conversion.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++++
 include/linux/stmmac.h                                |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 6128ed1bd521..93b9af203a18 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
+#include <linux/phy.h>
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
@@ -847,6 +848,16 @@ int stmmac_pltfr_probe(struct platform_device *pdev,
 		       struct plat_stmmacenet_data *plat,
 		       struct stmmac_resources *res)
 {
+	if (plat->has_internal_tx_delay || plat->has_internal_rx_delay) {
+		plat->phy_interface =
+			phy_fix_phy_mode_for_mac_delays(plat->phy_interface,
+							plat->has_internal_tx_delay,
+							plat->has_internal_rx_delay);
+		if (plat->phy_interface == PHY_INTERFACE_MODE_NA)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "unsupported phy interface mode\n");
+	}
+
 	if (!plat->suspend && plat->exit)
 		plat->suspend = stmmac_plat_suspend;
 	if (!plat->resume && plat->init)
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4430b967abde..00be2df63d22 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -242,6 +242,8 @@ struct plat_stmmacenet_data {
 	 * that phylink uses.
 	 */
 	phy_interface_t phy_interface;
+	bool has_internal_tx_delay;
+	bool has_internal_rx_delay;
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	struct device_node *phy_node;
 	struct device_node *mdio_node;

-- 
2.34.1

