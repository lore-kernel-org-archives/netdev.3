Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA001346E44
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284684; cv=none; b=qjnGDhAkB2t7O0lYoM6+sBelGK8G7bTOfS0lAl/Dn4W2Dzb7k/PYJ6JFNMlMQpoqdMeo4bZqc1HUyYBw0fO00yu1zfMw37ER0F2RjIOsFPFfcWVH4erDm5LHHv38ysK6z+KoRhaFFaiiMmoC6jPfbAmpvUUPCOJgd47YRs6Fid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284684; c=relaxed/simple;
	bh=8HtYQbLwSHu0vvZioxwuFV+w4PACxh4MHe5ggKRq6JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAaFLxQqqJPeGbUL+sQsmLKf7RROJhm6pkh3gMiOPg/ME6FlV6Vr/GARvbHuqkXA+FiIW6oGTmT+Zqd7n/Gyie2s1Ec02tw9Ugk9bX+/TBBPIQJzZEkWu2Wtk8In+IxKgeBQbVNrcfL8nzSnUEC4hs0VClXBqClTZbTeid0m/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hc9PMpuK; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hc9PMpuK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Td
	uXEGuI8rglixuupP6nljvhDg88wl/fl1yjoxvhIJA=; b=Hc9PMpuKRIKQnJt8bP
	9qOfKEG1KFWFAhZ3Vnn2aEftRQ48BLN+GjocJAPgEaCzsQ+tTRpRP5OasJfHki8d
	Yo1bAbiSRtb+xpZTtpaVaKkC8rAIfjOSIzp7ORLtqeP9GiHQeXD7ZyqBkBnddZIr
	QZ/Al0G9laaYzVr2omKli2lf4=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnVWDlBVpqguBEKA--.5251S4;
	Fri, 17 Jul 2026 18:37:26 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH 02/13] 8139cp: handle cp_init_rings() failure in cp_tx_timeout()
Date: Fri, 17 Jul 2026 18:37:24 +0800
Message-ID: <20260717103724.13971-3-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717103724.13971-1-luyun_611@163.com>
References: <20260717103724.13971-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnVWDlBVpqguBEKA--.5251S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy3Gw1xtrWUKF1furykKrg_yoW8XF48pa
	yFkay2krn5W34jga1xG397XF90q3WktrZ5WryfCwn5Aw1rAa43Kr1rtayjgrWUKFW8XF4f
	Ar4Yvr4xCan5W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFD73UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6warempaBeZjZAAA3o

From: Yun Lu <luyun@kylinos.cn>

cp_tx_timeout() ignores the return value of cp_init_rings(). If the
RX buffer refill fails there, cp_clean_rings() has already dropped
all rx_skb entries, yet the driver restarts the hardware and
schedules NAPI unconditionally. cp_rx_poll() then dereferences a
NULL rx_skb slot and hits BUG_ON(!skb), crashing the kernel; the RX
ring also stays empty until the next close/open cycle.

On refill failure, keep the queue stopped and leave the device down
until the next open instead of restarting into a guaranteed BUG.

Fixes: 9030c0d24dbb ("8139cp: implement the missing dev->tx_timeout")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 drivers/net/ethernet/realtek/8139cp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 03929bb0bd79..968bc0a2086e 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -1273,7 +1273,13 @@ static void cp_tx_timeout(struct net_device *dev, unsigned int txqueue)
 
 	cp_stop_hw(cp);
 	cp_clean_rings(cp);
-	cp_init_rings(cp);
+	if (cp_init_rings(cp)) {
+		netif_err(cp, tx_err, dev,
+			  "Failed to allocate RX buffers, not restarting\n");
+		netif_stop_queue(dev);
+		spin_unlock_irqrestore(&cp->lock, flags);
+		return;
+	}
 	cp_start_hw(cp);
 	__cp_set_rx_mode(dev);
 	cpw16_f(IntrMask, cp_norx_intr_mask);
-- 
2.25.1

