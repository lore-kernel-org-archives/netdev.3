Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26441862;
	Sun, 19 Jul 2026 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784432766; cv=none; b=Q2Mmx8XTT3UrZw4ZxzcQ8s3MzWa3TO3jPp9vnyEG1PHmsU6GigvTtayMjIoNukx75qloIYaD32NF510O0kQ7s27r/hFC+Zcly1GQfVmK39amwsEACUmbQhBPaaHVmIRr3BPvyW+GKXC46OrrCIozQNEIChSLltbl5gSVUmTcXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784432766; c=relaxed/simple;
	bh=SHL/72weoscZE1Xy+mdpYE4oaRNp0b6WoEFohDwTQIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9VB2WFfLuN0OyUX6BEiNK9RHtycaliCjr8zrLwgrpcRSyALYL7G9AAeGxw128hq/NcVt4LCkrkK6rAaDPOAoYB78PJN4GW9EIvf51AoYw75DbjjvNvo/WCbz5rYPaZISzQ+uKaaj1mayYMFCqHHsMaGGWiL3XJmD948gApXlUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=CpuK4YOt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xv8ab6BY; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="CpuK4YOt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xv8ab6BY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id A0DE413001A6;
	Sat, 18 Jul 2026 23:46:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 18 Jul 2026 23:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1784432763; x=1784436363; bh=K71T5tGJ+6
	I/pIxNg5ggxdkC8btPjjIfP/2AA7E16Kw=; b=CpuK4YOtjH6ifPjbKchrKRaH7u
	bpsVQl30YvFKEW3AIsCdKDjAg/CuQiG9UBi+q09bDYnQGcmOQzv+aYUdYuy4d2sU
	XZjWN9x2w1C92akDpoGXHWQIikcHlhaynP/8WLxcYbE3y/L6Qv+zfRzzyVKZcKs+
	GTBQwr8ZuvkqRezLK3ieDjRKETNh13kSi9+KvsTTcASiM31hRQN75iZ7B+DU0I0a
	0CSsO5xZ/3MePwJak8lqPFSK2JmON4i6q0nW4to5bgYaI3dTKdwcDxfkJ59tptbI
	el4czpzavUtN77+TpZCM6RBtuOZdp4oKHefx7PuQKWThLSoCrJ72ZRagsHiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784432763; x=1784436363; bh=K71T5tGJ+6I/pIxNg5ggxdkC8btPjjIfP/2
	AA7E16Kw=; b=Xv8ab6BY4/xe6LwTVr6VIF4cNkdAkjXFcgMWtVACtC4A4gRTFSA
	44qYDlp1kMzox2xzwo99x8oY0fJd1BhBbscexPCWJDEWnlaDSXh1O4s8S/tb3Vjg
	2TYhNy7gWI1pWqTSGC5fwZS/pkGC4vTA4fntUBmLX72cHYtsyq7kDLRr+C8w08T6
	dc8yDquFOXV8KP7aod3EBFTv2T2ie4gNwROWYhl/WZSqnvZ1FzCmxWYO4Q4teqJ/
	zGpsSTgNETrFA3ybo7oPZulzpMgKxkbXJmlnWt/cP6ESRBhMt7PPjNzCukDdRTt0
	wEGJsUFsyvDaUEfkryeAhXY6lr/w/OTzGRA==
X-ME-Sender: <xms:eUhcatOKBJllc4xAaEKyiNrgVgdodbiw0dCEaqOGNTo3zuOeK_GeHg>
    <xme:eUhcasUtDXEBRXK_6wfIq3M0IoyrwXAyZK49tSO4xXivhRH1fJ5s4s6RlWF1xjFPF
    WYM19504FHu023i2LiJBX_RA0Je7X0oDFBfwIOs2mlqrsGpCiyHEIU>
X-ME-Received: <xmr:eUhcagsME0QVfQaaPt8vErgifBNZ_SlTdgE7abz7lajNulzzWcnJcf4eM4Qz6Sw5sdTAt-A61jOd010JbQA>
X-ME-Proxy-Cause: dmFkZTFZGFuxOOcuQdUk9nnoXSFAretSBDpA7bPHsxXnUye+fLvAaW/QjoaDurq3PAttm9
    a4QuFYl1x7Oxj4VfdlemzQxWNYFWbMg6eo8O6toy+0O6WJ0gmw5NR4wmgy/2SX7IbW4y0G
    Ej00Re0VIbKWZNiE57YBf4t86bHz36JYL00HMr3kD5GgDzjzG+n8QX02kRE5+RpEVWCih+
    a6T2Fkycgvzn+vFrBnKkQkR0yZTEPcMbg3Rk9wSpvQfvxaCR6UXJcheQ6Ryr4lGbQViCP+
    Po3+PZcvFLW0MueirC3YM2KVjHi8dm1NMTKJB84dF9qrsW/LnlDZgTK17yNQlWn+l2Qfkm
    GzqKVOmJRQPzKCxri3PUIR7FREbtFxI7TlmqSWlPaDyGRVn7GUtJ6tJn9e+LkuXQq3MJ2u
    EfScaCqH5HaJeiHk366wqNAIQD0xv3XAMPY6dBhKpknwLLCbfry9C5uSShJgcNPmNJztsI
    JnO7SKfChp8k2fGMckUar++LOWMdU5k0TzpmrVyECjXLIuP1iXESC4DQKDXzGt1ts8tHIf
    JB2051MspN2Im621cHKzL5w2RxyA4arkkyBbF0N+//YtOGXHx7WJTw+fTp29TwwQ1ornp9
    oLIjXXsX4Bc2rK2hwAmcP9VCwSKemDpq/v8RmtPZvr84QPtmEtdKdSBojDSA
X-ME-Proxy: <xmx:eUhcan0XR0TzPhrlkhoWC43rluGh0Dl1ouQF08A5yq1Jg112W9ILoA>
    <xmx:eUhcah7uYauRw3fwEsGMvdMzR4-hffXXKL7boHXpLURjHG9NzNaWCQ>
    <xmx:eUhcauV6sJc7UQrwvlBKEHhncHvSXJmJq9nSJJahVZxu6dQhHuNIsw>
    <xmx:eUhcapgW1ZkcAw1y55U1UizS38m1WbdBl7BYpipcXafytdDQaXd_UQ>
    <xmx:e0hcak3fvXjj1cV1pySBNjAMw6V70OWhlpuepLp4iu61VOYGD-Uo84Kr>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 23:45:57 -0400 (EDT)
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
	linux-rockchip@lists.infradead.org
Subject: [PATCH net-next] net: phy: motorcomm: enable the reference clock for YT8531
Date: Sun, 19 Jul 2026 15:45:55 +1200
Message-ID: <20260719034555.3623003-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YT8531 needs a 25 MHz reference. On boards without a local crystal
it is fed from the SoC, described as a clock on the PHY node. Get and
enable it in probe so the PHY is clocked before its registers are
accessed. The clock is optional, so crystal-clocked boards are
unaffected.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
This supersedes "[PATCH net-next v2] net: stmmac: dwmac-rk: ..." which
enabled the clock on the MAC side; Andrew and Maxime rightly pointed out
that the PHY is the consumer and should enable it. That series is dropped.

The DTS that consumes this (rk3576-armsom-cm5) goes to the rockchip tree
separately; the clock is optional so this patch stands alone. Tested on
an ArmSoM CM5-IO: the YT8531 links at 1000 Mbit/s.
 drivers/net/phy/motorcomm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 708491bc1..2f85974a3 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -6,6 +6,7 @@
  * Author: Frank <Frank.Sae@motor-comm.com>
  */
 
+#include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1169,9 +1170,20 @@ static int yt8521_probe(struct phy_device *phydev)
 static int yt8531_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
+	struct clk *clk;
 	u16 mask, val;
 	u32 freq;
 
+	/*
+	 * A crystal-less YT8531 takes its 25 MHz reference from the SoC. When
+	 * that reference is described as a clock, enable it for the life of the
+	 * device. It is optional, so crystal-clocked boards are unaffected.
+	 */
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get and enable the reference clock\n");
+
 	if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz", &freq))
 		freq = YTPHY_DTS_OUTPUT_CLK_DIS;
 
-- 
2.43.0

