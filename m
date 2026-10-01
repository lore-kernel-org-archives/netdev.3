Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904F2848BE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 05:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790831398; cv=none; b=QfWtzn8cPBZW4zCC2UXURelotlxWHc66XC9zF+3EfGon4ha/pdhDOZvaKha+TLsHf3C1jvckfhTTwqWEq1sdCOT+ctj7aK1wAlpT9aa0iNX+1O9zO4HObpC/JhdcpFARmCS8zUqt/832GHlLLLeFG5ahWwlDyiDQXdAvQEpSsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790831398; c=relaxed/simple;
	bh=sPjVdw1f77ips9Nv6NBG0khCAgJAVWi3BPUZ+Zq/VB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ghJQp7M1lns1TtmpXsTFMejdG4pz5T2i2gNH5scZfNPLB78gDdPF/9iSj08wShVi8mZbYeVPcvKwPNsynpqtFcKXXA46t2QbDuQRKYblPWL+SxTIRnzifdIDcVtqxclZj+mX8OPiSJJnclAdgVJdQe6ul2G+xXqeeb0yQS4oKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6C7fC5x; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6C7fC5x"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-805c194bc92so7141791a34.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790831395; x=1791436195; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mqnzs/KFgxAQZBlRueuZBHGS1PFSBmZsF4oNkvqm8Dc=;
        b=e6C7fC5xlMALjezIka3j4b0qNbz6zPC5e6KdyBrOHRquapWMsdNTuF6IVg+Wjihn4z
         +mODX1q9KyQtcj6Ebr76rMpHGmGuj4H3nGBNUAYTl7s4OrPbSRWiyMiC2dxHk1GjxY4z
         QyuFTpBUWD/jgcofVcXjSQyKgGbZ3ZiynMO/nv/NpEVoC78Mi2ESwFUzkVV3EUua38ly
         hC0WRpGkNsfcBOqZ82kcuD6TDLqM2HO9DIUsEdl+f5hKSo0aEhLFu3TMcCVX7j2/79D9
         xRLq2/XtXfB9eWEVzb7uDsY9TGI6MVcwbFhse25ZDq6nmOvAVqI4Fg+TSP4Z4+xLnZQj
         X3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790831395; x=1791436195;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mqnzs/KFgxAQZBlRueuZBHGS1PFSBmZsF4oNkvqm8Dc=;
        b=hIFIwIyr5xC7XUDI1xpRDqzhqj7dtSL9b2OsZbhl3S1I6ENEnhZXdEdJSsAFQZQfYX
         j2IuaPSUaESMzT9EhRKGodh/dMfov3fB7zXIX+Zigw0+QfONVCrHC5m2i7k9iZbvhWdz
         f9eexkUn/Kfkglt0CHdsXlLv/vtBNgSFLGPiGh4142D/mFOcR3wYFoAz+U63nAMNhulQ
         YdxWm9YIkPaxT92R7Dg5TVQRNmuyKuCQTtA5fMTyn/iwHTliI4La4yVdUxI21ROc3uYz
         4iV0BjkawNvOHMVCwRwKZrUpctiX1CAgIkeyXBvtbcn+bm+BLu1PT5aMUosOQjFYHr65
         yjYQ==
X-Gm-Message-State: AFuF++nhtgelJk5NWZ3PUdlkdI7mZoxuHZLc0DzooaBWkeChDujRVOCB
	2akLiTD46cakfo+oK5q7/ZcteWfS4G77Wjrr60MWZKF++HzwCqDxGtaY
X-Gm-Gg: AYBFou2oWyIKyoV5FfN7vgnKVEMAFXPp0ed2fiNQT1QDdmw3HSMD9cG10l6QmWWyt/u
	OKisY5l7G6pItPd+6YoBQlB3k4C/oFen6sWM95xVRP4yCvLoU564ACtJ1oQ5KCP2PM6cp8I8yWC
	7wj4dpMxl65TLREm3jpGe4F0nI7NnIHnQn4obiJM5FAQ4N+HNsuG1ROl8U7OhPnT9lVunrioe9v
	Qlnqym248NC1ZtDvLrM3qkYE0f096vkk71QV1l7XLHstDsJWBhiPltJpmzrp0WiQ3Yyv48LsQTS
	A5aSLoPQbkgfok10FR258YUMuwLKepnTdoX3OvGdIZWjoyB2z7vOAZnXHTSNm+w2IgcERcEwBxA
	SDm/llsnEUBoGnNrlVWkA6HUA4CrtduKlI/lASTWkJJNxixYwpJ59R60FbnPjHTK3nWqrxr7Z71
	bqETxaqm77ey2pxiLSw308Yk3M8oYt3XQjIEtcYVkLFenWHIgkFbZ8XorNLwbNdz4WXjTawddf3
	iU4bOXfS8Bdc1wmLpJ0ls+Sk7Kw3YNcuw6m6Ks1V3wM6jKL7MJ5Gn85JVxlEwui1X4vJ3Hw8glb
	b+0N4qyklulhbI3+hxenzuhz+PTvweORES67kN4vcrzkURlwW3o+DOCodCkDDuA5mjqOIz7DioU
	z6LsUSGy3RLUj9ilJuoY4zw==
X-Received: by 2002:a05:6830:3915:b0:812:3ec6:58a2 with SMTP id 46e09a7af769-8204980b242mr4353460a34.12.1790831395157;
        Wed, 30 Sep 2026 22:09:55 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212a4139c7sm1821296a34.7.2026.09.30.22.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 22:09:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 23:09:50 -0600
Subject: [PATCH net] xsk: freeze deferred pool teardown without blocking
 unregister
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ7CIBREr9L8tSS/gFC8iukC6EeJKa1AtUnTu
 9uoyzeTN7NBoRypwKXZINMrljilA9pTA/5u041YHA4GjlyhEcjW8mBlKTOlgVWyeZjeiRnkwXQ
 SO28EHOqcKcT1O3uFRBX6X5jpuRwX9d84W4j5aRxjvTRWu2CdlR0XJHyrzs5xROm1pBC0R6OU5
 s5r6Pf9A6Z5Mmm3AAAA
X-Change-ID: 20260930-xsk-suspend-teardown-902f98408c93
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Deferred pool destruction calls ndo_bpf() under RTNL. system_wq is
not frozen during system sleep, so that callback can run after a
device has suspended and gated its clocks. Use system_freezable_wq
so running destruction finishes before device suspend and new work
waits until process thaw.

Keep assigned pools visible to NETDEV_UNREGISTER independently of
the socket list. A released socket has already left that list, but
its final pool put can queue destruction after workqueues freeze.
A resume-time unregister would then wait for a device reference
whose release cannot run until the resume completes.

Track assigned pools under RTNL and detach remaining pools after the
notifier socket walk, including copy-mode pools. Remove the entry on
assignment failure and normal teardown. The deferred worker still
owns the pool and later observes the cleared device pointer, avoiding
a second driver detach or device put.

Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from umem")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 include/net/xsk_buff_pool.h |  3 +++
 net/xdp/xsk.c               |  4 ++++
 net/xdp/xsk_buff_pool.c     | 25 ++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index a7df573784fd..cea6e883f7cd 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -48,6 +48,8 @@ struct xsk_buff_pool {
 	struct device *dev;
 	struct net_device *netdev;
 	struct list_head xsk_tx_list;
+	/* Assigned pools, including deferred releases; protected by RTNL. */
+	struct list_head dev_list;
 	/* Protects modifications to the xsk_tx_list */
 	spinlock_t xsk_tx_list_lock;
 	refcount_t users;
@@ -119,6 +121,7 @@ bool xp_put_pool(struct xsk_buff_pool *pool);
 void xp_clear_dev(struct xsk_buff_pool *pool);
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
 void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
+void xp_clear_dev_all(struct net_device *dev);
 
 /* AF_XDP, and XDP core. */
 void xp_free(struct xdp_buff_xsk *xskb);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..a2ae0e10d893 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -2145,6 +2145,10 @@ static int xsk_notifier(struct notifier_block *this,
 			mutex_unlock(&xs->mutex);
 		}
 		mutex_unlock(&net->xdp.lock);
+		/* A released socket is no longer on xdp.list. Its pool can still
+		 * hold a device reference on the frozen release workqueue.
+		 */
+		xp_clear_dev_all(dev);
 		break;
 	}
 	return NOTIFY_DONE;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 9d2d94f1fb75..b5fd0850db5b 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -12,6 +12,11 @@
 
 #define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
 
+/* Socket removal precedes the final pool put. Keep assigned pools visible to
+ * NETDEV_UNREGISTER even while their release work is waiting for process thaw.
+ */
+static LIST_HEAD(xsk_dev_pools);
+
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
 	if (!xs->tx)
@@ -204,6 +209,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	pool->cached_need_wakeup = XDP_WAKEUP_TX;
 
 	dev_hold(netdev);
+	list_add_tail(&pool->dev_list, &xsk_dev_pools);
 
 	if (force_copy)
 		/* For copy-mode, we are done. */
@@ -265,6 +271,8 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		err = 0; /* fallback to copy mode */
 	if (err) {
 		xsk_clear_pool_at_qid(netdev, queue_id);
+		list_del(&pool->dev_list);
+		pool->netdev = NULL;
 		dev_put(netdev);
 	}
 	return err;
@@ -291,17 +299,29 @@ void xp_clear_dev(struct xsk_buff_pool *pool)
 {
 	struct net_device *netdev = pool->netdev;
 
+	ASSERT_RTNL();
 	if (!pool->netdev)
 		return;
 
 	netdev_lock_ops(netdev);
 	xp_disable_drv_zc(pool);
 	xsk_clear_pool_at_qid(pool->netdev, pool->queue_id);
+	list_del(&pool->dev_list);
 	pool->netdev = NULL;
 	netdev_unlock_ops(netdev);
 	dev_put(netdev);
 }
 
+void xp_clear_dev_all(struct net_device *dev)
+{
+	struct xsk_buff_pool *pool, *next;
+
+	ASSERT_RTNL();
+	list_for_each_entry_safe(pool, next, &xsk_dev_pools, dev_list)
+		if (pool->netdev == dev)
+			xp_clear_dev(pool);
+}
+
 static void xp_release_deferred(struct work_struct *work)
 {
 	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
@@ -337,7 +357,10 @@ bool xp_put_pool(struct xsk_buff_pool *pool)
 
 	if (refcount_dec_and_test(&pool->users)) {
 		INIT_WORK(&pool->work, xp_release_deferred);
-		schedule_work(&pool->work);
+		/* Teardown calls ndo_bpf(), which may need powered hardware.
+		 * RTNL alone does not exclude the device's system PM callbacks.
+		 */
+		queue_work(system_freezable_wq, &pool->work);
 		return true;
 	}
 

---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20260930-xsk-suspend-teardown-902f98408c93

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

