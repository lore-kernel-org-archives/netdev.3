Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2D32B127
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793005; cv=none; b=N41/9MpfPe2S8ZKKvzB/FnPnQSTELmnnJkkpgrXnvuo5ZxhbKBgmrSDNiJF/I0fHhqe9jeS8mLTvGN4M64Rr+2KK29uKCGOT8CEG7O3L6IX75DuR9F7GVepOC5jpkg6yTYUM1SiYudhRznltAVNAo4S5mAykC+YSX11m+OHGCJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793005; c=relaxed/simple;
	bh=fAE/Yewa3SEx/YXCLqWkzo3ukPRxfK2v9eAkdxfVFss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+mGdHszyNFN9QNwHu9CYlllGAwR2xaNhNgqUIZW+yY/UsKESzu5xhF+maaxHKXID+0gqRJn4aF8mfMwPB35t1LVc8FRLzvLG2D5cINzDyGgyPyDUDw1aENds6F93Uhol4vbdx6yz2+04QI6PYRoFmilR8n8Hj0oFHBXGDXTE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddWppg6u; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddWppg6u"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8ff15af279so2244328a12.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793003; x=1783397803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nTeOTK7sT3w/yJG7JB2mC3o0CF3LaN7DeafntRCirY=;
        b=ddWppg6utQnm7p2iS/LHQ39U1NtWIaO4VCk5tCKK4fJyD8DU6mS56uzCSQKI9H2NG6
         iQcJaLkSVuT3eSTGHtgQvbYEpdsjl39LlwU8kPG+tXXhQTfTk1wbL+BZ5CdsAwuFugO+
         oRk6Fuz0QLD5ydOCKpmXTXXjNmC0WoIeYPZXGBOil4jPxGK6mEt1k5suZQ5iDmZRZpO/
         +g6mQsZul3qRgRSdPIbgsTFamOxUYFNrPfcrOwAAYXFMnueEqAmG04I5Il480l2o/RL4
         gfP9mnRH7d2ruLyljEfpYRIumTCRwAJIvm1vBD+QZGG6F5vxDfgLi8g9l6JpRMGIF0sE
         Au7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793003; x=1783397803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nTeOTK7sT3w/yJG7JB2mC3o0CF3LaN7DeafntRCirY=;
        b=QI03m2xrTWt1XG+fZ4NQ3gG8ZNrE7j/awZwpnFbd4F8ueFx2IimZODVlxTSmUL9uwB
         AGQPmKMIbQIU80ISmFGE+lGWBTVM7gn0q+Ez/EiEx6UmKwpepvT7nyOqagJxyGGwlm3O
         dMQE29NL7XR7F18Kz7nllQEkkbWu/gStuWI1uR1OogUDe548qKRNxH+5bZGjNHV/6EFs
         JET8H2L51r3k/gC5H7CyEToY5Mmlm2Pd734jbNRaz4jpWUNRBEXEKCPNFNNIzhFm0Epa
         PudNE0zohzLRQI08qhq7txQXzSCoZKH7JaJFO6L7ied+1STmIoIQdEMuFf6zt2ChYmCc
         u4iA==
X-Gm-Message-State: AOJu0Yz8jkztAqhC/YrNKq4x4BANWEe7MV37Hn+POIpCvaCwnyhA4flZ
	vylEsOc49Y37NWqeqxksb3lAgM1qGXw4NNPVOcbfiv7gTALYYRf6n/XnZxi+38NU
X-Gm-Gg: AfdE7cn3dqryYuaXgXZhcPdxQpGr7lyA+YPBXNMS0zzi03C+nDDrqL3kUSJykQ9YFdt
	CwjsDfIwbaWUoUiBADxrH/5FNN0LsFWAu3P66lGcWi3IjC6v6iDzStXRtH9q1czd1gIGiFQDQn0
	jExHMYDK/SHi4TkTGaD7wQNyxa/4e8BfuKcCM50EB0laRS5BgyliIK6OG7yv6uu5kPcneZrkVZ+
	vpCvJWbl2SobrOPQ722Qv3kBNjLK7IH6a+NAa5yWS9yZ6NWq1Z3ejSheBZ7jv0i/ERaWi68iP5P
	qz3uWXo+BpO8IVix01C1fFV9HCmJBlYllEynW4riqy4T8rkLMBtv8KgaUbszFy8uv4K2L31CxGx
	aYtzNwZ4VceBZ3cWpPv5GAXzkj8sc4+5FxG830XMq1b0szOoMhtTnmjivBseYQ/Xmcm1SmhEWFq
	ydEq60uOy8sYPNPwSVCDDuPp8HAGj+wDeYFZ6WvpJS6Sv3AfU5J0ebUF4E+pxSNFJ+l3C41YD9/
	se1C4ZbgQ==
X-Received: by 2002:a05:6a21:4584:b0:3bf:6c08:fb9a with SMTP id adf61e73a8af0-3bfc547ed4emr2110881637.60.1782793003241;
        Mon, 29 Jun 2026 21:16:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/10] net: emac: mal: replace busy-wait in mal_poll_disable with wait_event
Date: Mon, 29 Jun 2026 21:16:29 -0700
Message-ID: <20260630041634.284127-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630041634.284127-1-rosenp@gmail.com>
References: <20260630041634.284127-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the msleep(1) busy-wait loop in mal_poll_disable() with
a proper wait_event/wake_up mechanism. Add wait_queue_head_t to
struct mal_commac, initialize it in mal_poll_add(), and wake
waiters in mal_poll_enable().

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 7 +++++--
 drivers/net/ethernet/ibm/emac/mal.h | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 82d502d576ee..d12a376f69fd 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -176,6 +176,8 @@ void mal_poll_add(struct mal_instance *mal, struct mal_commac *commac)
 
 	MAL_DBG(mal, "poll_add(%p)" NL, commac);
 
+	init_waitqueue_head(&commac->poll_wait);
+
 	/* starts disabled */
 	set_bit(MAL_COMMAC_POLL_DISABLED, &commac->flags);
 
@@ -371,8 +373,8 @@ static irqreturn_t mal_int(int irq, void *dev_instance)
 void mal_poll_disable(struct mal_instance *mal, struct mal_commac *commac)
 {
 	/* Spinlock-type semantics: only one caller disable poll at a time */
-	while (test_and_set_bit(MAL_COMMAC_POLL_DISABLED, &commac->flags))
-		msleep(1);
+	wait_event(commac->poll_wait,
+		   !test_and_set_bit(MAL_COMMAC_POLL_DISABLED, &commac->flags));
 
 	/* Synchronize with the MAL NAPI poller */
 	napi_synchronize(&mal->napi);
@@ -382,6 +384,7 @@ void mal_poll_enable(struct mal_instance *mal, struct mal_commac *commac)
 {
 	smp_wmb();
 	clear_bit(MAL_COMMAC_POLL_DISABLED, &commac->flags);
+	wake_up(&commac->poll_wait);
 
 	/* Feels better to trigger a poll here to catch up with events that
 	 * may have happened on this channel while disabled. It will most
diff --git a/drivers/net/ethernet/ibm/emac/mal.h b/drivers/net/ethernet/ibm/emac/mal.h
index e0ddc41186a2..bd52bb41adee 100644
--- a/drivers/net/ethernet/ibm/emac/mal.h
+++ b/drivers/net/ethernet/ibm/emac/mal.h
@@ -19,6 +19,8 @@
 #ifndef __IBM_NEWEMAC_MAL_H
 #define __IBM_NEWEMAC_MAL_H
 
+#include <linux/wait.h>
+
 /*
  * There are some variations on the MAL, we express them in this driver as
  * MAL Version 1 and 2 though that doesn't match any IBM terminology.
@@ -172,6 +174,7 @@ struct mal_commac {
 	void			*dev;
 	struct list_head	poll_list;
 	long       		flags;
+	wait_queue_head_t	poll_wait;
 #define MAL_COMMAC_RX_STOPPED		0
 #define MAL_COMMAC_POLL_DISABLED	1
 	u32			tx_chan_mask;
-- 
2.54.0

