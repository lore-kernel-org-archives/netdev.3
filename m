Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608304B1D19
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544323; cv=none; b=QoA9Wl6KUtvnwKkuNXuW7yflfoUI6w2ESFhVupuiwTsGfxQtYjMSTyyowEN/3EiZ1cRCpLX4tShjCxztJRNaubHhq4bYXD2xYdnO1S4/l54SAzQ6Sz599tTSa5SlD8aK98Tj+gwL5Hh5KEUUROci82/DNxFc+1YmJT91AonlOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544323; c=relaxed/simple;
	bh=6RFQ88waLnY/Bpu2cL3BDqD5uUezWvE9DEE2Q6Et8DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VANYYdoriZV5CudHCfpAr6olt+yqgHW/fcVhICeDPBsYSFlXfDjdCkoM2//kVpcDWDRMrDXtElyoWKJAJPpglR+Tw3I31x6z0rPV7VxExZ3IrLM2mixCzFzTrUH3SCuudOF+ugZn4PJeIVNBjbkxF9WGKbmzYBvujrH77iTNH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a25EA/fO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a25EA/fO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e82462a3f1so8378395ad.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791544314; x=1792149114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ToVjaLw2QkDyxt21XUlKuHYlfWlGfRLzYFmO7NKSmk=;
        b=a25EA/fO8o3k6x7QoHnbF4t4GpjdukrrlbfkpH7SiNuidp0i1psqxMx+KMjhAH2O0p
         lGGXG2IrFbYpgMf2qlIk1dZiimOv1DvDk4vQ2DIJ6ABb8P8KVXn5M0Crxm8/NqMIoKQt
         keWCycX++QRnIDFHyrTsO2yoqzm0eK+Sxiqg0V1EVN0b9CLfHrTkDMqYbo5L32HuQYrX
         BoWlXuIgb4sAfcchADSOF4/4FmkNxNg8tro/TALe0HHGQ/7YS4seYDnNtVCilGjgvixa
         njnKKvIc/hmpG77ChRarACR9WPUhpN2ZOHYZayHrIRHOsI5bnZE1nD+EiaIHNb1sNQaK
         /rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544314; x=1792149114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ToVjaLw2QkDyxt21XUlKuHYlfWlGfRLzYFmO7NKSmk=;
        b=WJh2MOUl8Qy6fGZydn+zxZm5aCma3uFXUBOPG3ltXYQHPhnHJPJdkxFBx8eYsOuGEx
         3u7ZgHq0/4jGvfucdZDf0Tq8GMpfjozvJk2dVkZqaChJs8PDcvAPUrwBh6WqNo3y0WVr
         /UlkTORt3bbBMQphzTCjVkw+PhqwNJis+J/ufMox7QBPX8SIbgu2u+h+xsQ3yhCILvkQ
         zRTYyj94OlmP21HUkX15twlSS1P3aQN2lPbboA7uykQGXXjPIcU/B5ZruDh5VywtIgI7
         YE/d7PQBcKdGKQvgiB2wJUpV+uSIUn2fdjhQT65HhJgPuea/3mxeKCvYC2nNn/ALuuAE
         7Osg==
X-Forwarded-Encrypted: i=1; AKwUvBw4zoAy738YSVoXLd1vbUgzRf3RoOX9/UyqcwvfUnvtDv8bZyCT+w5yZVvZAFX0EOVW/f/12Kw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJFjEIGEuTQ1jaPs32uTfElZnYfusNISX26w68F5Q2jGgkeAlM
	6LJUt7ycVX7megO2s6/tLm/Pf1h5fRyEru3vLdu4Rhi354bA9kk7945k
X-Gm-Gg: AYBFou191pfeEscbW1kuxSr72fvDwoZY057e/tcffCZ1Vt78HFMvgeuQQ4RrV7qjch/
	TfIupuWENR8vry+52KD8RgnWzn6P0d4AFfWz8VN/wDNtRjnHrc3GWuyPS+Jk+kDBi9dYwrqCA/Q
	FTu/nxNrckEzPFjpB6Y/aQO/fn42waxq+Un2oL86YFD9q+sYltHWPqA25ee6U4XEK801maPIz1M
	+RvKeDVG9sxDlQCLs+scc6hG+TaiJJwtynJdW/J8OmVpEoZAWPNZx4AywaQTsrkCdyUf1rl9+yO
	VT2O8Zou9pyGTf0YBhoYiRPOurphKRvm7xc72EfkMYGXO27qGOwwDGnmCWm9kYxYpvyvCwtK+Tg
	2Abz7q2fuJqEPGY4L212Jtl1Xdk368CXEDHT1d1Af/diiJWXnmUUtgvOm4aB9sR2vsJq5gjWAWo
	cJBb2fx9vvvhFITIb5YKG1j6RWUa6zpZ8pY6B5PHTOHdGMs8HwOzVIh9z/P1uVMKEKb/QldpSOX
	or8HSOY9QrY
X-Received: by 2002:a17:903:1905:b0:2dd:8e5:28d with SMTP id d9443c01a7336-2e84280a518mr12154275ad.8.1791544313701;
        Fri, 09 Oct 2026 04:11:53 -0700 (PDT)
Received: from online.mioffice.cn ([2408:8607:1b00:8:13b6:ac86:6bdd:a8cf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e4ebfsm6823245ad.78.2026.10.09.04.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:11:52 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	zhangpengfei16@xiaomi.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: stmmac: fix RX coalesce frames counter
Date: Fri,  9 Oct 2026 19:11:37 +0800
Message-ID: <20261009111138.320089-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RX refill path should set the IC bit once every rx_coal_frames
descriptors and leave the rest to the RX watchdog (RIWT), as done by
commit d429b66e2ebc ("net: stmmac: Implement RX Coalesce Frames
setting").

Since commit 6fa9d691b91a ("net: stmmac: Prevent divide-by-zero") the
counter is increased by N+1 for each descriptor and then compared
against N, so it is always reset to 0. With a non-zero rx-frames, IC is
therefore set on every descriptor and every frame raises an interrupt.

Fix this by counting one descriptor at a time in a helper used by both
stmmac_rx_refill() and stmmac_rx_refill_zc(). Platforms without RIWT
(IC on every descriptor) are unaffected.

Fixes: 6fa9d691b91a ("net: stmmac: Prevent divide-by-zero")
Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
---
The default rx-frames is 0 (watchdog only) since commit da2024510031
("net: stmmac: Tune-up default coalesce settings"), so this is only hit
when rx-frames is set explicitly.

Verified with "ethtool -C eth0 rx-frames 16" under UDP load: without
this patch almost every received frame raised an RX interrupt, about
twice as many interrupts as with rx-frames 0.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b837e8e27..72678760e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5071,6 +5071,22 @@ static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
 	}
 }
 
+static bool stmmac_rx_need_ic(struct stmmac_priv *priv,
+			      struct stmmac_rx_queue *rx_q, u32 queue)
+{
+	u32 frames = priv->rx_coal_frames[queue];
+
+	/* without the RX watchdog every descriptor needs IC */
+	if (!priv->use_riwt)
+		return true;
+
+	if (!frames || ++rx_q->rx_count_frames < frames)
+		return false;
+
+	rx_q->rx_count_frames = 0;
+	return true;
+}
+
 /**
  * stmmac_rx_refill - refill used skb preallocated buffers
  * @priv: driver private structure
@@ -5116,15 +5132,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 					 stmmac_rx_check_buf2_cap(priv));
 		stmmac_refill_desc3(priv, rx_q, p);
 
-		rx_q->rx_count_frames++;
-		rx_q->rx_count_frames += priv->rx_coal_frames[queue];
-		if (rx_q->rx_count_frames > priv->rx_coal_frames[queue])
-			rx_q->rx_count_frames = 0;
-
-		use_rx_wd = !priv->rx_coal_frames[queue];
-		use_rx_wd |= rx_q->rx_count_frames > 0;
-		if (!priv->use_riwt)
-			use_rx_wd = false;
+		use_rx_wd = !stmmac_rx_need_ic(priv, rx_q, queue);
 
 		dma_wmb();
 		stmmac_set_rx_owner(priv, p, use_rx_wd);
@@ -5492,15 +5500,7 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		stmmac_set_desc_sec_addr(priv, rx_desc, 0, false);
 		stmmac_refill_desc3(priv, rx_q, rx_desc);
 
-		rx_q->rx_count_frames++;
-		rx_q->rx_count_frames += priv->rx_coal_frames[queue];
-		if (rx_q->rx_count_frames > priv->rx_coal_frames[queue])
-			rx_q->rx_count_frames = 0;
-
-		use_rx_wd = !priv->rx_coal_frames[queue];
-		use_rx_wd |= rx_q->rx_count_frames > 0;
-		if (!priv->use_riwt)
-			use_rx_wd = false;
+		use_rx_wd = !stmmac_rx_need_ic(priv, rx_q, queue);
 
 		dma_wmb();
 		stmmac_set_rx_owner(priv, rx_desc, use_rx_wd);
-- 
2.54.0

