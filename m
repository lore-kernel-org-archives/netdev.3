Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F864B2713
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474578; cv=none; b=qotc0bpYggplDCgOAqawjj02jm/Rm8k4sdBMe69YtPjhtU4FrYtlMQWS2ua/fhU2BExqyfPAIzciwu+lnnBDtHXdB9s+NRe2XPdMociGGzNL1y1OnB2Q7sNbyiD9RT0a17h8QIJ1Jv74CJuLzZ6l/VvFV+yPCFUK9D/n+8XdxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474578; c=relaxed/simple;
	bh=/2de0qT3tE2DvWbC8/sdd91Bn+tqbAupthlzsqErbMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCFzqSnzLLTBl0g6nWP8UjRyImy6ZmTofkLo4a/P27nqXSvyBiNE0ht3LNYQJr/IS1DVe6blW0SAT0DjCUyiv4/trzY63bW4ots2i+ds61OvJe5si/mOc6H4PA5DajnmX//xmX7EKaBBlxcHXKmFRqrUdOYY64JRYYjyxAeBvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RHfh1Xap; arc=none smtp.client-ip=91.218.175.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RHfh1Xap"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/2de0qT3tE2DvWbC8/sdd91Bn+tqbAupthlzsqErbMs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789474573; v=1; x=1790079373;
 b=RHfh1XapC8buEnfJLZUICSjUZS8FA3UScB6AhM9MUxsnNnqEj5G0yWobgofN03miacVFVo5q
 KauSLakBTcEKb0mc9R7ztxR6pL8oVSgESEGbez18rCm1S2EIpacJ1zCNLHDklCJEGl5/2KKh1e/
 MdJC3lPlW/89WpqjyuKphPyg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 13a02cce9c9514ee;
	Tue, 15 Sep 2026 12:16:13 +0000
X-Mizu-Trace-ID: 13a02cce9c9514ee
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	David Ahern <dsahern@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1] net: gro_cells: move backlog drop handling outside the local lock
Date: Tue, 15 Sep 2026 20:14:58 +0800
Message-ID: <20260915121458.214961-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

When the GRO cell queue length exceeds max_backlog, gro_cells_receive()
holds bh_lock while updating the RX drop counter and freeing the rejected
skb. The skb has not been queued, and the counter is updated with
this_cpu_inc(), so neither operation requires the queue lock.

Release bh_lock before accounting for and freeing the dropped skb to
shorten the critical section.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/core/gro_cells.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index d8c0a28671201..f46cecd246aab 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -14,7 +14,6 @@ struct gro_cell {
 int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
-	bool have_bh_lock = false;
 	struct gro_cell *cell;
 	int res;
 
@@ -26,32 +25,33 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 
 	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
 		res = netif_rx(skb);
-		goto unlock;
+		goto out_rcu;
 	}
 
 	local_lock_nested_bh(&gcells->cells->bh_lock);
-	have_bh_lock = true;
 	cell = this_cpu_ptr(gcells->cells);
 
-	if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog)) {
-drop:
-		dev_core_stats_rx_dropped_inc(dev);
-		kfree_skb(skb);
-		res = NET_RX_DROP;
+	if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog))
 		goto unlock;
-	}
 
 	__skb_queue_tail(&cell->napi_skbs, skb);
 	if (skb_queue_len(&cell->napi_skbs) == 1)
 		napi_schedule(&cell->napi);
 
+	local_unlock_nested_bh(&gcells->cells->bh_lock);
 	res = NET_RX_SUCCESS;
 
-unlock:
-	if (have_bh_lock)
-		local_unlock_nested_bh(&gcells->cells->bh_lock);
+out_rcu:
 	rcu_read_unlock();
 	return res;
+
+unlock:
+	local_unlock_nested_bh(&gcells->cells->bh_lock);
+drop:
+	dev_core_stats_rx_dropped_inc(dev);
+	kfree_skb(skb);
+	res = NET_RX_DROP;
+	goto out_rcu;
 }
 EXPORT_SYMBOL(gro_cells_receive);
 

base-commit: 1142eb185b05db61a78130890fc4ed268f4cb4e6
-- 
2.43.0

