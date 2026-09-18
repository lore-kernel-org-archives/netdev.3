Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF93033E1;
	Fri, 18 Sep 2026 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690578; cv=none; b=cHleujX91bhH4QN5W8aOVGGZW2Oc9JtC4FsSBXqZjum2dM/rS/VfTIjaYz6BMUKxPYmwUGHtJrKBthpxnNF+f4eSdRtcYDOlcIaM54QQnapyLG0ed7njXtcDnajMJOyuaQyOCjmSZ6X4EuIH/ndsiAa3J4lUKzGa/eLn9bLp5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690578; c=relaxed/simple;
	bh=SFwBTmAFjRx28AmNVjEg2GSfw/YyRzh3aFVaWsP2jr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOiZlwjE3EpMMB3r0k6ABjGz53DrP8ENfBf+4LlIWlLTm34ao833ENusu636V/2AfH1/uQs+M2XKA5sKFvuONw9Tf7QC0JQ4qIrLJh8fMibde9xbcEklGwuRxzyh2Lmw4EmhzhaCfKNg+rc4Lc3yf2ZorErL83HIWpm5uiag6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b8tDPlNE; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b8tDPlNE"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6F086C0C3BCA;
	Thu, 17 Sep 2026 17:07:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6F086C0C3BCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1789690061;
	bh=SFwBTmAFjRx28AmNVjEg2GSfw/YyRzh3aFVaWsP2jr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8tDPlNEecd13MfPXEQhzlH5wuT9RZtobsVnqKhtcZBaGG6Hiba7bjrZWbZW9pDov
	 DSw4nkVkSSLX7wEf7y+NgU8/M1m/VZ5SVS+O67XubehKmF2/D1DDTf/d4u6xyyhNTE
	 x3q1t62OqWo3ezn97v18V/qb7yYWPBiYvW/RiYFs=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 4718CAD9;
	Thu, 17 Sep 2026 17:07:41 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Cursor <cursoragent@cursor.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 5/8] net: bcmgenet: acquire ring lock with BH disabled in bcmgenet_dump_tx_queue
Date: Thu, 17 Sep 2026 17:07:29 -0700
Message-Id: <20260918000732.276506-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918000732.276506-1-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcmgenet_dump_tx_queue() is called from bcmgenet_timeout() in process or
timer context and acquires ring->lock using spin_lock(). If a softirq
such as TX NAPI (bcmgenet_tx_poll()) fires on the same CPU while the lock
is held, it will deadlock trying to acquire ring->lock.

Use spin_lock_bh() and spin_unlock_bh() in bcmgenet_dump_tx_queue(),
matching bcmgenet_tx_reclaim().

Fixes: 13ea657806cf ("net: bcmgenet: improve TX timeout")
Assisted-by: LLM
Co-authored-by: Cursor <cursoragent@cursor.com>
Change-Id: I0c4c6392590b2d16abd44f75d3f6974f3e1b874b
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index ef155a170fa6..799da63e3a4e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3508,14 +3508,14 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
 
 	txq = netdev_get_tx_queue(priv->dev, ring->index);
 
-	spin_lock(&ring->lock);
+	spin_lock_bh(&ring->lock);
 	intsts = ~bcmgenet_intrl2_1_readl(priv, INTRL2_CPU_MASK_STATUS);
 	intmsk = 1 << ring->index;
 	c_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_CONS_INDEX);
 	p_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_PROD_INDEX);
 	txq_stopped = netif_tx_queue_stopped(txq);
 	free_bds = ring->free_bds;
-	spin_unlock(&ring->lock);
+	spin_unlock_bh(&ring->lock);
 
 	netif_err(priv, tx_err, priv->dev, "Ring %d queue %d status summary\n"
 		  "TX queue status: %s, interrupts: %s\n"
-- 
2.34.1

