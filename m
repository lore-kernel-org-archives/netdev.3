Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8684A3857
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550124; cv=none; b=V/DWP6rsiB3P0QNWJaVxmq0R+rDFtI9OvA6CbBi8Mis9aJ2HW1F589rGyVqAt//XLs2WSh/LpVvqgnRWjRz6dlYkOYWpooq0IQYWdxjC+xg69JCOSO1rJhoKWWuX8uqtcIpkjjJBPV0BsKVLwH5tDewFSGrb2gu10VbPK/c9ciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550124; c=relaxed/simple;
	bh=pBeiJ4AlOcIIa9PKTUIXPyWGASwQB61+Y/D7zx29PbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izpsqIyGA3yzTEP8ikpTdJlF3+0Yz8AIjA6cmnJk4DvQ15guunaHzvg3MpJrfWIcUQ6gTfc3HIRZSl3mUHNtl9VXQLjPxjAFQIaIOqf7ttDLCeKWDB+RSlrNi9w8+Oik/gL/7JDPDDDr5JpdLcbvNsGvZ4uPIuZsrJbv3j5GtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OrTo8nU6; arc=none smtp.client-ip=91.218.175.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OrTo8nU6"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pBeiJ4AlOcIIa9PKTUIXPyWGASwQB61+Y/D7zx29PbA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789550093; v=1; x=1790154893;
 b=OrTo8nU6tftEmZbwJ2OKKBItGQVDagyY3ISMxrM5s6S1KCNjbf1TmJSU0OWu8gIkmzW+oTZe
 mm5NkDKidLZJNQJYq5BZPbS/lDGQghAFhwz0S5uoofMfc/Tek8e+QdGb+gKvw35bQVkhAHaK42f
 /i8fyKQmCA+kdgoXziI4mEQE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea7a2d69a42c64a9;
	Wed, 16 Sep 2026 09:14:53 +0000
X-Mizu-Trace-ID: ea7a2d69a42c64a9
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	David Ahern <dsahern@kernel.org>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] net: gro_cells: add drop reasons to gro_cells_receive()
Date: Wed, 16 Sep 2026 17:14:20 +0800
Message-ID: <20260916091420.138170-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

gro_cells_receive() reports SKB_DROP_REASON_NOT_SPECIFIED when the device
is down or the GRO cell queue length exceeds max_backlog.

Pass SKB_DROP_REASON_DEV_READY and SKB_DROP_REASON_CPU_BACKLOG to
kfree_skb_reason() for these two cases, respectively.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
This patch is based entirely on Eric Dumazet's suggestion in the
discussion below:
https://lore.kernel.org/all/CANn89i+d4ny7K0QV-v+ZY6Kj735tPVrrzd0AzwRqe4vvu5r=aw@mail.gmail.com/

 net/core/gro_cells.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index d8c0a28671201..1d64207bf960f 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -14,11 +14,13 @@ struct gro_cell {
 int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
+	enum skb_drop_reason reason;
 	bool have_bh_lock = false;
 	struct gro_cell *cell;
 	int res;
 
 	rcu_read_lock();
+	reason = SKB_DROP_REASON_DEV_READY;
 	if (unlikely(!(dev->flags & IFF_UP)))
 		goto drop;
 
@@ -34,9 +36,10 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 	cell = this_cpu_ptr(gcells->cells);
 
 	if (skb_queue_len(&cell->napi_skbs) > READ_ONCE(net_hotdata.max_backlog)) {
+		reason = SKB_DROP_REASON_CPU_BACKLOG;
 drop:
 		dev_core_stats_rx_dropped_inc(dev);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, reason);
 		res = NET_RX_DROP;
 		goto unlock;
 	}

base-commit: 87b80c2f6b05cad9f0ff9136709c62a0f59923e3
-- 
2.43.0

