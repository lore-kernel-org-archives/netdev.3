Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4535C68E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585029; cv=none; b=JV+m1F+IPElZrkCGWJAuLXsysvOVVo6Zmu84oMtF5LgDzqNJvoPmhLBS5VPB3Ai139hUW2WGpv0W1vvHIoaVeQQejOwHU92S0CI3ISpvJVZ+E7jVLrB4+XJDo4nsYsGkFhaRBY+/QeuBJS1KiuP74+Y7aqHAi6PSVCz8O1k6OeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585029; c=relaxed/simple;
	bh=WfFHfFYokkPeJf+HzqG7nznoZOAqYkqtJ9P+2TeW7I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/M0G/mcAcKoGyDNavIwN+Ox7TZ8AZzBYCM93R+ZL6lAOK65m8DR/mttYY5WYLl4sB2IKqHA+UdM6c0+SQaU7W0emvlGB3baCPMXEDSstXKjRbzaBpbbe2n+LV5NXtoJ0VTv6CqWpTHJrSiHzjCvFuJc1PxaKs0366mFwzCpek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF/8Zto2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF/8Zto2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-88b5f43cb8aso43009b3a.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791585027; x=1792189827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AdUD3bR52lZyeHl5yLgNlcni+itA1UGw8wbwa05XB4w=;
        b=aF/8Zto2vsttKxcG7OTsFmHOILbxEVDMOrYUJZTBWumBdO7YHvg8WdY0ZNLfWJ8Iyb
         xb//wJsd8xz1Q0XHoTPPWXRKi10RuEXq71tcoWr1rq7/DoPDceOrsvOCgVTUkxKcRRis
         4HyjMGoYe/F+ohBHqFLVvhnq++jPpvRTQG4eO5VW+48GcrkFwJIw6fxmJhFnxrSIqQG0
         5z5x9XBQXZumZvFyhvVDlPejLXj6mJP2zvIP6lP7PUJQTjIhpUi5gF+UzASxzwJNc1jH
         n5uLLqn3l47eBbkQfG3eoQtnmqpQZBjeyXSn6vEWwI4mqvkRqMFthFr1ZVf8pT9AJiXT
         nRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791585027; x=1792189827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdUD3bR52lZyeHl5yLgNlcni+itA1UGw8wbwa05XB4w=;
        b=oYWyReR4XS/cphYxYlM7TIQ9WSkDAVT1tsU5/zHVCalS0JOSiK+D+aaqeIflo4d9vM
         2Q5DAsvgINTc9yRIDXxL4W+ZMWWByqn83Kdp6ok3YTYKjWn1fn4IbA1FZaUXcYeQS4Xr
         c1oueF8U3ei9Fz2ygxhg0gkMMvRsVlM0R4erPMMM12z3i2rTfEnoAs09/C/9OofZqVTG
         /UB9iGsnUgjA/cPx26TKnGt4Jh3cQw2cRf9AhZY6xTaCEHpOAYkV1Y7rxi4b0fVubSYS
         0Scjm5ZK3ZXSPqz1u5tZOFs7bXJf3+qyB97jgHLgfQbI9UL9MEHkooJmZnjJ9r5ZGV7A
         S7FQ==
X-Gm-Message-State: AFq9FYImuwzzAF21pU0MUhTrYeOgUW8XrB81COTnRXbsYPjl+UaWYHiS
	tSjIpPqLvaObHuFLxJZhDTnWWph5UBpfYohJkjkhhz+G7HIwdadJEDFlYFumA3on
X-Gm-Gg: AYBFou3Fkwca/2EkizZd3PkR6lEbPWDEqc8Ycb2rN/ceRF+yYvBvoulNIl9cmoMRyOl
	A9V7lrhuAVCLHvFYVM5cON+WJFeg3ovpP3MV/P7Vd3iLz/QqblZaqZ0dGJMVK/Ib8SmddK4zpMR
	3s4QalfMKCgAPeBbuO47fny3BK+I1o4WvwwdgZ9qL3ApXvio0rsiBNzlUmBuQ2Mlo2DYwoElIfL
	1h+AsSqyEfoyAPFY8xrDiLVAlm4JtcKb8no4IozKx7TocW7TokLTUE5iBkBKsXUGVMc2015sRoZ
	fO6sEAsLHWi/lAYQWkQOrFZkifeVZsKIV+IHozsHFlZCvn2DgJ/vAh3Md+v8X4UtbtKIUuTcYm4
	xBB/RBSpK0RjTesrezJ6obi+CuIxqeGoNfEFPlJIa36mhAiJHJ/9TU7d+AUNtydrxqAaMoXFs7o
	3XzbxIqopyQdAPHfwIb2M/Iv5R8W7qsqCktn+y+Ru+kEsZowQSTigypAIbg4BV7tbYjHp+z8CLw
	y8+nGJRWQPqWNVXotxvBfTlkrYcrZ1jEGUwtTCJfbXCmiPfa5CWnEXWFr3vby070bG7uOSvXely
	vcn5jpfV1nI6pgLpFMVnvMxmcgxXkkBthJBKHYWBEIABU9Qp
X-Received: by 2002:a17:90b:5109:b0:3a8:80f4:98a7 with SMTP id 98e67ed59e1d1-3ab3a79df4dmr2984498a91.24.1791585026881;
        Fri, 09 Oct 2026 15:30:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm5472645a91.0.2026.10.09.15.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:30:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] net: ag71xx: align the IP header behind DSA tags
Date: Fri,  9 Oct 2026 15:30:24 -0700
Message-ID: <20261009223024.545607-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive buffer offset includes NET_IP_ALIGN to get the IP header
aligned behind a 14 byte Ethernet header. Most ag71xx devices use DSA
switches whose tag sits in front of the EtherType, which moves the IP
header by another 2 bytes. Every access to the IP and TCP headers then
traps and gets emulated by the unaligned access handler, around 6 times
per forwarded frame.

Take the headroom needed by the DSA tagger into account when choosing
the offset.

TP-Link Archer C7 v2 (qca8k), median of 3 runs, Mbit/s:

                       before   after
  routed up               743     855
  routed down             660     749
  local receive           554     572

The unaligned instruction counter no longer moves while forwarding.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 v2: rebase and ass Reviewed-by.
 drivers/net/ethernet/atheros/ag71xx.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 4e4794c4dfdc..ff30ebce448d 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -38,6 +38,7 @@
 #include <linux/reset.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <net/dsa.h>
 #include <net/selftests.h>
 
 /* For our NAPI weight bigger does *NOT* mean better - it means more
@@ -1401,6 +1402,24 @@ static void ag71xx_hw_disable(struct ag71xx *ag)
 	ag71xx_rings_cleanup(ag);
 }
 
+static unsigned int ag71xx_rx_offset(struct ag71xx *ag)
+{
+	unsigned int align = NET_IP_ALIGN;
+
+	if (ag71xx_is(ag, AR7100) || ag71xx_is(ag, AR9130))
+		return NET_SKB_PAD;
+
+#if IS_ENABLED(CONFIG_NET_DSA)
+	/* A tag inserted in front of the EtherType shifts the IP header,
+	 * compensate for it to avoid unaligned accesses in the stack.
+	 */
+	if (netdev_uses_dsa(ag->ndev))
+		align = (align - ag->ndev->dsa_ptr->tag_ops->needed_headroom) & 3;
+#endif
+
+	return NET_SKB_PAD + align;
+}
+
 static int ag71xx_open(struct net_device *ndev)
 {
 	struct ag71xx *ag = netdev_priv(ndev);
@@ -1415,6 +1434,7 @@ static int ag71xx_open(struct net_device *ndev)
 	}
 
 	max_frame_len = ag71xx_max_frame_len(ndev->mtu);
+	ag->rx_buf_offset = ag71xx_rx_offset(ag);
 	ag->rx_buf_size =
 		SKB_DATA_ALIGN(max_frame_len + NET_SKB_PAD + NET_IP_ALIGN);
 
@@ -1879,10 +1899,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 	ndev->min_mtu = 68;
 	ndev->max_mtu = dcfg->max_frame_len - ag71xx_max_frame_len(0);
 
-	ag->rx_buf_offset = NET_SKB_PAD;
-	if (!ag71xx_is(ag, AR7100) && !ag71xx_is(ag, AR9130))
-		ag->rx_buf_offset += NET_IP_ALIGN;
-
 	if (ag71xx_is(ag, AR7100)) {
 		ag->tx_ring.desc_split = AG71XX_TX_RING_SPLIT;
 		tx_size *= AG71XX_TX_RING_DS_PER_PKT;
-- 
2.56.0

