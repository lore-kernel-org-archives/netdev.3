Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3B3B0AD8;
	Wed, 27 May 2026 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890085; cv=none; b=fxfZUOjV4LaaFRDgYja5VjSEAvccgmEQsx280xxQF+LH0g+GP5eMs/AeVcgWZ4XT36BgEOmmtHFoPLOSFxq+9W4DL9nOtD8a4oVK3PjhkYYz78+hJapBu3qL3gcHl48qIiChxcGYoKA7N4u/BU+XXFIyjpBXaHvWp/SvAt2qCnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890085; c=relaxed/simple;
	bh=je7sEz0p4MqkHs90NZCMO+H6Sjsw25H6OMRla/EspNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VC8LrIa6dbKSJLGm56rAdv9WhmmByIG14GHgZ5ELcptVchmA+wZLAAtwPbRy7g0NVf10rv3FfBKBr5ZO1NBZDGp9CbaoUxy4nhTFu+jxuxQKivQRjAHtzOPBd5ZXvhPkNw7C7Mj8/4jNuCCCAHZU0wFKl+X2OetnQzSyurRhvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2a/iY0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2a/iY0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF531F00A3E;
	Wed, 27 May 2026 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890083;
	bh=bOcyZykV5nLviKzBUpr7AsYsRzwuO94vzCyI85xMDHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2a/iY0Cq7diIAeYNuqn/W6FKGwo/u/MfA8fOFwgOx46s3V3kyKoxmgqqKKScZYyg
	 wghbOw4R6vFbbHVnLACKgfPJJBukbhGvP3ouBT8FaQwsPmTd9A7wLCNjv8vSunsHA/
	 trd8R4ub/0noK4ZiajQDxxaGyiqt4aV6Co99k8o4xOeZne1ryLyzy7MPn5DRx3OhDG
	 q8xwUfrF3um9eRCLykgbzsKBuRpRXJtljNAcFNsj80Cz2yOyIXAl/4O8dSTe+GBIr+
	 blb/RdtZkZ4MIQeOWGQruLzed9r+T1jHdf2rQeblN/3oIAxNw4K/hZxUGozbbVkwQv
	 nmyrL4ilaJ0dA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 4/5] net: sched: add timeout count to NETDEV WATCHDOG message
Date: Wed, 27 May 2026 15:54:15 +0200
Message-ID: <20260527135418.1166665-5-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527135418.1166665-1-hawk@kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jesper Dangaard Brouer <hawk@kernel.org>

Add the per-queue timeout counter (trans_timeout) to the core NETDEV
WATCHDOG log message.  This makes it easy to determine how frequently
a particular queue is stalling from a single log line, without having
to search through and correlate spaced-out log entries.

Useful for production monitoring where timeouts are spaced by the
watchdog interval, making frequency hard to judge.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20251107175445.58eba452@kernel.org/
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 net/sched/sch_generic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 237ee1cd0136..2aebab985c00 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -533,13 +533,12 @@ static void dev_watchdog(struct timer_list *t)
 		    netif_running(dev) &&
 		    netif_carrier_ok(dev)) {
 			unsigned int timedout_ms = 0;
+			struct netdev_queue *txq;
 			unsigned int i;
 			unsigned long trans_start;
 			unsigned long oldest_start = jiffies;
 
 			for (i = 0; i < dev->num_tx_queues; i++) {
-				struct netdev_queue *txq;
-
 				txq = netdev_get_tx_queue(dev, i);
 				if (!netif_xmit_stopped(txq))
 					continue;
@@ -561,9 +560,10 @@ static void dev_watchdog(struct timer_list *t)
 
 			if (unlikely(timedout_ms)) {
 				trace_net_dev_xmit_timeout(dev, i);
-				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms\n",
+				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms (n:%ld)\n",
 					    raw_smp_processor_id(),
-					    i, timedout_ms);
+					    i, timedout_ms,
+					    atomic_long_read(&txq->trans_timeout));
 				netif_freeze_queues(dev);
 				dev->netdev_ops->ndo_tx_timeout(dev, i);
 				netif_unfreeze_queues(dev);
-- 
2.43.0

