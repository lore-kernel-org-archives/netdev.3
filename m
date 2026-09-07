Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C9641D223;
	Mon,  7 Sep 2026 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767256; cv=none; b=V8DG4NbKcebWSUoSWFXgWOEk463+MXD/jU+0i4OplYiVAxiYHM9U2uvAM0ZFN0OCWP2LOIBHxStCLPodnaDGHBuvyTz5nxbDF2mDpNUiJQJLBfpi4rnAcNK2l5/GdQ3d0tairDOrPbg5fJtkGKJZs1jVQP9dpFq8d0cMJp2fG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767256; c=relaxed/simple;
	bh=SuFGe/sSDEWhlUQ1aJzOHS5LIgzsemZW8aQnnH1+XXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhPFfcBVvNEF00Yjl/mPyC2HIcRWFDjdWTik9vpCe/+NFN2BoPi5opYb2U4JffFE81Trb7k8U5XOt4tXQvbnsFfTbt7dCGlP9BGoO1X8abPCNSqgO4wy8rD2XwRcrcGj8khRiXgv0hchd1HH1z3ZgDu+sM74lTJ96e08RbLn5tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=WZwdspzX; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="WZwdspzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=5jENh/0l0LNZVmFEg64Ol7Bta4qDRru
	PwnuCrL/AhvE=; b=WZwdspzXtkOcZ7PR7yp8U1UB6WxWdjMV+aZPaNwheDmwmiA
	+knZyK7tqruTFu1XbGeatR+m21DWadNGV8pIEFQuo2Agf16J/ui9/j/pXyMPxiw4
	Kr2Y0lRc42nWrvbSVmb7cR3cDqEimL7EBUViJn9u+a9I8L/5C/7uoGj4/2wE=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAf_a55qnlUAAA--.364S5;
	Mon, 07 Sep 2026 15:47:20 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Mon, 07 Sep 2026 15:46:52 +0800
Subject: [PATCH net-next v2 3/5] net: stmmac: eic7700: Use common RGMII
 delay handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-dwmac-ultrarisc-v2-3-9a39bf8db313@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788767221; l=1620;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=SuFGe/sSDEWhlUQ1aJzOHS5LIgzsemZW8aQnnH1+XXk=;
 b=fBYf/2wtekR69urD4J+/hhkDuxjZTH0yE1cyaNs3FaCAO4Ncs7lX53uqv1OXmg0nYdP/txVOh
 m5ZKSVEU8cdBbsYwLLSdthhHNOMelWdOR8fehVrqO7lqGK5bruR6tTk
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwDHQAf_a55qnlUAAA--.364S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5AF4xGr1UKF17WF4DArb_yoW8WF4xpF
	Z3GFW3Arn7tr1ft3WDJF48ZryFgF47tF1S9392ywn3ZFs5trZ0q3yYyay0qFWkCrWkXF12
	qr4jkFyUZas0krJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUUl1kUUUUU=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQACEWqdDaQAAQARsc

Describe the EIC7700 inherent TX delay through the common stmmac
platform data and let stmmac_pltfr_probe() adjust the PHY interface
mode.

Keep the existing programmable TX and RX delay configuration in the
EIC7700 glue driver.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
index eab8c13fbdcc..0d654ec07f33 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -198,18 +198,9 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 	/*
 	 * The MAC silicon unconditionally adds ~2 ns TX delay; prevent
 	 * the PHY from also adding TX delay to avoid doubling it.
-	 *
-	 * DT specifies rgmii-id (TX from MAC silicon, RX from PHY);
-	 * override to rgmii-rxid so the PHY only adds its RX delay.
+	 * The common platform code adjusts the PHY interface accordingly.
 	 */
-	if (data->has_internal_tx_delay) {
-		plat_dat->phy_interface =
-				 phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
-								 true, false);
-		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
-			return dev_err_probe(&pdev->dev, -EINVAL,
-				"phy interface mode is NA\n");
-	}
+	plat_dat->has_internal_tx_delay = data->has_internal_tx_delay;
 
 	/* Read rx-internal-delay-ps and update rx_clk delay */
 	if (!of_property_read_u32(pdev->dev.of_node,

-- 
2.34.1

