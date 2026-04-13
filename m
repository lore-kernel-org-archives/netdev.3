Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F339391517;
	Mon, 13 Apr 2026 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073536; cv=none; b=CodZhSS2hGTxM23DjIT9jE6dsq/IIh2TMjh0dvC6KavBwOk0TKFgbxo/TQ+aJePNoyxrwDAH5ZaSz1OQNE32okY2l3OLeFtNSuKEFUasQyny/CkOxEQMmVHTw/o7Pv2e7pTYpC7LC4BSOYnGhERFJa2r0kELSfj4LRl68el6Ipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073536; c=relaxed/simple;
	bh=XPcRTdbWwomJwXrQ4r6B2U9JVjj7QGAmxhRjGzNSS7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PymP6HusmdoQ1u8N9xWw+oyXwWrjGcUPppXCXAgcPM/kYFkSAE053f8RoeC4OsUHTLwr/arD2dVNFUrqZIrM/7ruk/CVVlXo7Q1FswgyGtN6PXPhQgJNUWfHBDlIhJWJtTu7jqmNUleQ05Ffo7Yad7dA/5bsGNkiykl6OJXvVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s62Do7oq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s62Do7oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A467BC116C6;
	Mon, 13 Apr 2026 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073536;
	bh=XPcRTdbWwomJwXrQ4r6B2U9JVjj7QGAmxhRjGzNSS7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s62Do7oq4V4Z24jSOPbstA6Q54hpYo46uZO0HKwmk6WBWX64/hqSjix/xYx1UKmJH
	 m5ZvdcKUEApHOUkk8M3jL0QviENCdggDDHyzNiiScZT3MifMMpgqIMuhbhfIsUBJF9
	 MwtT9iUHZJh8ayicKj8lPDa6YptL0ba5lsICgW2csDHmvna6qqEADpEUuLLpSmr+3Q
	 jOc8dhqzqAfdhFkb2zNWXar8ixKez7AMTSKaPtrbCOMqL3JLQq6WkRMMLIf4yEKZ7g
	 thxCmT4m5z5SU53+tqVkkRl3bkRWdxkm8oPr9TNSxE/QyAZihhY8/DnjolBXngnr4S
	 J59+el2XsQb3A==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/5] net: sched: add timeout count to NETDEV WATCHDOG message
Date: Mon, 13 Apr 2026 11:44:37 +0200
Message-ID: <20260413094442.1376022-5-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413094442.1376022-1-hawk@kernel.org>
References: <20260413094442.1376022-1-hawk@kernel.org>
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
index a93321db8fd7..3e2e2e887a86 100644
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

