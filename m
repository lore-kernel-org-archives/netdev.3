Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC002AD0C
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737688734; cv=none; b=rPECmJIdTQgKAbzkZ6VqWT9kSQYohdu1L/Qj60btE+n92x2Qea3H1uugbL8QYWc2Zv1o+Pfb3zHkg3MsHIYZFOmA0x1djJ8INgxjBjYMnPfyjpvqDTTQB/UNCqDW87wbWMOMp4keRUxLPO7Syhb+Uivl0pypJxOq2cV6CMh0vbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737688734; c=relaxed/simple;
	bh=d2RC60fwk0NxRVGeqxg9QQRCO+wmDGkRXCJeKv/cb4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3OjivlWYhkAPpm6j+zHOcFSL1N7lillpD0aGHwHrOzLwvbKM1g19TKvNix2HFp3iIjpfhOT8mQ3xgaMlISxHoSNUyCkmLow92z7E3w8hAFBWBk9Ab+/h4AHa0YuQfKQrjSR/kbDf5PtZ/Y+dtS+35/QFkXebyUsBXqY4T1VelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhLwVwlw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhLwVwlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B8DC4CEE8;
	Fri, 24 Jan 2025 03:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737688734;
	bh=d2RC60fwk0NxRVGeqxg9QQRCO+wmDGkRXCJeKv/cb4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhLwVwlwNkvuoKTDU3ZHwplwcXMskQS6lV5y9VVjEu6pBw1MVy7j9kZOPK9dpLO+i
	 L9tcTMgyMKSIXyTO3t1XB+6epkyLvaSDAWJgvYVPVXvFqJc0jZoPNminZT2t8iE/dc
	 wiq5vdAaYc2/JZw+Qv2aMH5dThkC1ZXa/NZBvZ8Hmy+zer3Tz54j+7sjhPo0ahUqeL
	 yxS7C0HgV7/iv3YHXhX5iBFm0OyXEAzZ5Ou/7lEcFlj9yuI8IknSQdd3/ZiDjuClkK
	 VQ+C6Tq3DLzambIZ9Je2R69tFLAoS/zfcnufN96NmNQM/zSB7UroyzPtyhFgD9dbK+
	 zsW6qiNmy/xLg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	Francois Romieu <romieu@fr.zoreil.com>,
	kuniyu@amazon.com
Subject: [PATCH net v3 4/7] eth: 8139too: fix calling napi_enable() in atomic context
Date: Thu, 23 Jan 2025 19:18:38 -0800
Message-ID: <20250124031841.1179756-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124031841.1179756-1-kuba@kernel.org>
References: <20250124031841.1179756-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_enable() may sleep now, take netdev_lock() before tp->lock and
tp->rx_lock.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: romieu@fr.zoreil.com
CC: kuniyu@amazon.com
---
 drivers/net/ethernet/realtek/8139too.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index 9ce0e8a64ba8..a73dcaffa8c5 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -1684,6 +1684,7 @@ static void rtl8139_tx_timeout_task (struct work_struct *work)
 	if (tmp8 & CmdTxEnb)
 		RTL_W8 (ChipCmd, CmdRxEnb);
 
+	netdev_lock(dev);
 	spin_lock_bh(&tp->rx_lock);
 	/* Disable interrupts by clearing the interrupt mask. */
 	RTL_W16 (IntrMask, 0x0000);
@@ -1694,11 +1695,12 @@ static void rtl8139_tx_timeout_task (struct work_struct *work)
 	spin_unlock_irq(&tp->lock);
 
 	/* ...and finally, reset everything */
-	napi_enable(&tp->napi);
+	napi_enable_locked(&tp->napi);
 	rtl8139_hw_start(dev);
 	netif_wake_queue(dev);
 
 	spin_unlock_bh(&tp->rx_lock);
+	netdev_unlock(dev);
 }
 
 static void rtl8139_tx_timeout(struct net_device *dev, unsigned int txqueue)
-- 
2.48.1

