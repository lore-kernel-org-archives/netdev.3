Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843181FC8;
	Tue, 28 Jul 2026 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214652; cv=none; b=TaIgJaxs8+m52ZoCCm/4sVtoYsa0N3Yv4M/b0ld71NpHLDfRISWGOj16PJ4G6tIFANx0LProHOQV6GEeZ8RYkPqdXBQOLNdBUD3f8K/t7Opfrh93bldRlspTt7LQEWjpYLyGOEqA+D/cm3ni1IpRNYE/CfbWoGPzq1ui7ded2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214652; c=relaxed/simple;
	bh=T28bYaCW2TvFwH1TLQ+0KEU/3/UUEJS+WltKD75lnrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMdiCiP3AZkaOXPhijOxm1CHtMHkxHp/KFPOO1/FY6SVOX+fAennJtHqcIreJNjlzlp+CwYeaifaXqHlYKgEDWcD8ehJJKVDq9jy8hURLANABVCa+2mGtAxTEbFwwIck6o0CMbD47N+O75pLXabgQxmwCdkqR9JoMZihVdjaGBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=MKKikwyB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KQCGRJdO; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="MKKikwyB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQCGRJdO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 74B831380030;
	Tue, 28 Jul 2026 00:57:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jul 2026 00:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1785214648; x=1785218248; bh=nmqKYkeeTJ
	dy4Tyz21cCGiv7E7ftaKMODWAO4uEbYg8=; b=MKKikwyBbabT4HO4LGe8inyV82
	1KBUk3AOAkFoXQ5ZMlAY4BtzXNSHO/c3p+pAiwYioWcDPBmw1KoA7kdpqZxcanR4
	uPX7Ac3S+G9+tnvfFcNWcR3asoS1uQYxXrkQLhn4qsAPK6Q2TGsK7kGhs5LGK6Zl
	3xRcA9XptwvCJgOc5XCxDwK57GhjjXmuaYXmKs3ykgBGM2/WuaJfOkTG7ymdIJTt
	ea0u5fttCPHj5NT9rJKyKoUEViSW8MrVq5RuFtfTdps57szAwMXSaBq1AymjXQP5
	Eh1Y/Wo1nZIYalGp9xCpP2z6cw3s5K6Ot1weZS581gA/Fw+eEkev3lsrQZnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785214648; x=1785218248; bh=nmqKYkeeTJdy4Tyz21cCGiv7E7ftaKMODWA
	O4uEbYg8=; b=KQCGRJdOS2VBFizEH8Gi1aMPAwbyMPdPVK0UGD9ngl+afPUfufb
	AR9d+hti7iq8mAaQZc3tWfGjGaooYKYo0DWKflaLAr4HmA6DrIbrNR/7+HbG9EfO
	5JTNKW+vI3L9MtsQRtf4thi3KXea1ZCum4t7MUgFHNLcdG7EQPo3OmOBYIVTk20k
	AE8YMmbctHnO8DlTcOmPlnGi7WFhrT1R1z35RE6lF4dICYeZ2BfVGSMkmrZAMCPk
	JZQaWKwz+rrIXWVr3oipKJcwb33dbIKyYFEQvbp7chvHorpND6ae4YEoiwwAqV+Y
	q2G3pQyQUd4RntRLLEZf5SioQfnWsVML7dg==
X-ME-Sender: <xms:tzZoarfwLv1neuiWCo9MwV5EU2DUCVpT8bvTeghfWSqDhjJMQTNt-A>
    <xme:tzZoavsle3PAudOLCb_hZPOhhrMyO8o5EyHXjzyCE4Uwn6Vj5CwuT56wtU8meJ6-f
    6hIDRDqme_WK_uERxCCVS8P3BBgbOxPqWThZr-o-skLTWIKwNTzlg>
X-ME-Received: <xmr:tzZoarXJ7vIgZLxs_uxXK53Zc5IJxLAxaTllXvG7TecaaFHmluftiQRh5O_1LFnetWK2nNZOMg>
X-ME-Proxy-Cause: dmFkZTGxl/dIk/bI7s2WkLCl+k4BWJMCdd8Ns8cl6WteBj4yJYmPpKcsniUBHobop3kUl/
    eIpBVFskgBDY+II5p2mvpfybTbEj1EZGnsD2yXI/TJXXSyjtjHj60BC8h5GgpKOI30HKsT
    gmggJ39J8HBZ9BipCTsAfFKHAbOfcTxkD+l3be5hIRdFMXsqHAReSY3960OXLeEmovTkt6
    yB54RqBWjXFwSUecw0SeRubB10EBzoB7/U0oJxdQ+pQ7oF5UwfzlIPH/sdKAbVxsNkShFW
    qGsG7D3B5AZ7Bm2xvAH5CK8i1sR0bgGPznaHdzqieQTO1Mja3KiqviC1s3xnLvxsureoMM
    j/qWE+iGm6FBkWblGli5UruXUdyoE3PBJNd5FhphIvwor56klHvtv8s94mjtsNlAvMXl9Z
    xg4Z/XCYsp0ydCAE8QU0F9L2ZVb5BfNX26BoDIkpq3wr9DjasNn2VGnmdJfmLpWB1NyhT8
    Jf57seAXI57E82sxBjxTYqzeuxOvOKpRp5XLx3RoXNhagcmLk2GbrWQE/Md/mBcITlRGaa
    qmZgflDKvH2FAPeUF70VGpZyMHRVVv31DpbMNWxKXLioBrTeCCYehd8hWKM2+6fK29xBRd
    jFiTrpdCgyp8pOuLQUTmFkKVxwBJzI7Lkrg0/D6aWTQse0VBMT4qT2JIoNkQ
X-ME-Proxy: <xmx:tzZoas_LJrOfRoUZ04V4v897H_AYdLmRUNiqypK7KfgDUVj9SQEGKA>
    <xmx:tzZoav7-c1f5zAB2svcowR8uGKQqVhm9OGUnAglC64XbDIcgzk4CwA>
    <xmx:tzZoal1E3AWfwvaZ9JxH_uQSRe7Uma8eVleIr1Z2JG8AfcAV1dbREA>
    <xmx:tzZoamyvne5lLNzd5iXLo6ifUGV-OMG2Z_jdTrGCtWwGX9OUpH9YmQ>
    <xmx:uDZoak9kL_K3snKBjXLC1qXXdIyVmsIHvQi561gYBDfZVJul_TK42dbd>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 00:57:21 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	attinagaoxu@gmail.com,
	alchark@gmail.com
Subject: [PATCH net-next v3] net: phy: motorcomm: enable the reference clock for YT8521 and YT8531
Date: Tue, 28 Jul 2026 17:56:59 +1200
Message-ID: <20260728055659.1211459-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These PHYs need a 25 MHz reference. On boards without a local crystal
it is fed from the SoC and described as a clock on the PHY node. Get and
enable it in probe, in both yt8521_probe and yt8531_probe, so the PHY is
clocked before its registers are accessed. The clock is optional, so
crystal-clocked boards are unaffected.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Gavin Gao <attinagaoxu@gmail.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---

Changes in v3:
- Open-code the clock enable in yt8521_probe and yt8531_probe instead of
  a helper; the block is short and self-explanatory inline (Alexey
  Charkov). No functional change, so Andrew's Reviewed-by and Gavin's
  Tested-by are carried over.

Changes in v2:
- Also enable the reference clock for the YT8521, not only the YT8531.

v1: https://lore.kernel.org/all/20260719034555.3623003-1-gahing@gahingwoo.com/
v2: https://lore.kernel.org/all/20260727205602.1188008-1-gahing@gahingwoo.com/

The DTS that consumes the clock (rk3576-armsom-cm5) goes to the rockchip
tree separately; the clock is optional so this patch stands alone. Tested
on an ArmSoM CM5-IO (YT8531) and a PicoCOM RK3576 board (YT8521).
 drivers/net/phy/motorcomm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 708491bc1..bb2e9f4f5 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -6,6 +6,7 @@
  * Author: Frank <Frank.Sae@motor-comm.com>
  */
 
+#include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1053,6 +1054,7 @@ static int yt8521_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct yt8521_priv *priv;
+	struct clk *clk;
 	int chip_config;
 	u16 mask, val;
 	u32 freq;
@@ -1064,6 +1066,12 @@ static int yt8521_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	/* A crystal-less PHY is fed its 25 MHz reference from the SoC. */
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get and enable the reference clock\n");
+
 	chip_config = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
 	if (chip_config < 0)
 		return chip_config;
@@ -1169,9 +1177,16 @@ static int yt8521_probe(struct phy_device *phydev)
 static int yt8531_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
+	struct clk *clk;
 	u16 mask, val;
 	u32 freq;
 
+	/* A crystal-less PHY is fed its 25 MHz reference from the SoC. */
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get and enable the reference clock\n");
+
 	if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz", &freq))
 		freq = YTPHY_DTS_OUTPUT_CLK_DIS;
 
-- 
2.43.0

