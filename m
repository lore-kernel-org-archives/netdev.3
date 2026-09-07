Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31741A926;
	Mon,  7 Sep 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767253; cv=none; b=V9TilFQSHMpqX3WhfBbgY2oxsFlcumeCOxzXugLCTHDGsFlthxbvhjjf7iT0aUKjIVwKkhoAGrRnIy7jDDpf1+nA4NOvDdYErE79QjEmVhIT26/Vc4hO+OmwbVBGz+sabq1zy7eihnsAtYtzVZD632Hq38S7rZEAMoMmqBoZp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767253; c=relaxed/simple;
	bh=CDI070e+NOZ/ruqicjlaZpPE25aCTxfliAy88qsKICo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaWl23jwEdr7IB7AQHbo8NeqLz1y84CVm5INSpMRUxdBQL99JHlItpm8RtV1spvfWWbXBrQV2MSQqlfdZJN2PYtJAyKi0e427WBo9640bGdfVcH3Vn/TiPFQgRCtdp6qhgvX4zq8RfRUhaQ4ouK+lk5Wyp+SN6j7TSwSI7XhCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=ZtJifY6q; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="ZtJifY6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=+nPO1TI6PhcIovZv4CegSlinuFtOw5S
	UcbsLM6dvhUU=; b=ZtJifY6qz+n1xQC7E8yC6YfAJhyMYlTTYA7SabGkgKkESMe
	+OXOG4Ya+3NmB88YK1kUKtxp6BddPG41Vhk/49qz9pbFWoJyOewsXzcYXqwUYGQa
	BxvJeG5QgPJAWx22z+ADXg6zz5gACOpX71WDs4SGyLlmVF9jjHBjLEFcCrGs=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAf_a55qnlUAAA--.364S4;
	Mon, 07 Sep 2026 15:47:19 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Mon, 07 Sep 2026 15:46:51 +0800
Subject: [PATCH net-next v2 2/5] net: stmmac: sophgo: Use common RGMII
 delay handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-dwmac-ultrarisc-v2-2-9a39bf8db313@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788767221; l=1357;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=CDI070e+NOZ/ruqicjlaZpPE25aCTxfliAy88qsKICo=;
 b=IQF3xUotir2QfLDg3r7ZgEAnMaIc0rhUw8Jyn+COg58zKlYEvAyzLQJcHMCEMeDMSQNy/Eym6
 SbxQS1Zz9uZBX9n3GyIwwcYaEumahXlVcDAx+Fav+0HlgAhVbHHcDMo
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwDHQAf_a55qnlUAAA--.364S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW8uw4UurW3CrWUJw1rtFb_yoW8GFy5pr
	ZrCa4a9rn7tr4aq3Z8Jr48ZFy5Wa47KFWj9a48tws3Zay0yFyaqwn0yFW0qFnrAFWUZry7
	tr4UZFy5ZF98Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
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
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRRCJPDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQACEWqdDaQAAQAPsC

Describe the SG2042 internal RX delay through the common stmmac
platform data and let stmmac_pltfr_probe() adjust the PHY interface
mode.

This removes the duplicated mode conversion without changing the
hardware behavior.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index e02ad3762b5f..f62c803665ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -55,14 +55,10 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 		return ret;
 
 	data = device_get_match_data(&pdev->dev);
-	if (data && data->has_internal_rx_delay) {
-		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
-									  false, true);
-		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
-			return -EINVAL;
-	}
-
-	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
+	if (data)
+		plat_dat->has_internal_rx_delay = data->has_internal_rx_delay;
+
+	return stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct sophgo_dwmac_data sg2042_dwmac_data = {

-- 
2.34.1

