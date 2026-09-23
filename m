Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3375218A4
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168605; cv=none; b=gCSQ1Nx6itILXRV6r5Y/U0JgiDYbj+tTinXQGXL7d86FVZG1H8ZOxTDqxs7mGuRlA6DKolbDCb6nfL/1E180JwXjwRkcowVnL2Qh5QPlxhwBHSBj89MMLPFn32cBjdHvsWU+1V4StTTkb8EXSkmsTT0a5MaIP0hz0Hcxe82Ip90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168605; c=relaxed/simple;
	bh=L5CmY1szttrcYAaFx1iCLTmoqHT3U6j7c1dOxBTBYCg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d+7u4DzScSuOh3RiK4sja690uca/L+pELJW7eVOIBk7ODArjjxUAiMDodwms4/zOeNTYWLp2w08gsmbu+vfE9qzA3HVXmM+whos5OgXEYVp/hNS1CCr3CePYpgxV7IYDf79wWxc2bjXXKfOeN+tIenqLXYaOrtEkZnnS1KMgZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMl1BSli; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMl1BSli"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a05d645acso197332185a.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790168602; x=1790773402; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kZoKRPe1CEIvnjmik1LxvxZ5CT+nTVOlEnxMZZNA/yo=;
        b=oMl1BSli750Mu6xC33ATPjScbF+sXcKLCtk/rqKtFjLh5NcAad80eVDCmhjW5LAn79
         5nGCwkjam6glkdK0Nq84A3NSJTM1yY+eWT1Gepogd0jrVqfkT0BBJP8OiQ420aWSNfU7
         RleNXXfp+oUaU0gZkIJPsknEPz3JMyCMigW6inzrTmcUNDRgGsE26NAwdmWSURRwSwVf
         ph45B6sYhUjzGGBZFixQvC4nQzEkwsc3Yf3y2zgZwNdZ3rpaezfZPwiGboqSsv8ycgZL
         /ZkmjKm48RaxE/JWbG48VHhe8eLEy5YMjt+29x4iDJZSFjCiT6QKs5frUSva6zWPc1dp
         SAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168602; x=1790773402;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kZoKRPe1CEIvnjmik1LxvxZ5CT+nTVOlEnxMZZNA/yo=;
        b=D0cMRu8Wx7S1ccrTZeYi4iFcxeDNQcv2DSX/t9U+HjICbiZaAIJI2wKIAcKWkMm0jN
         hpQ7F7HLZRhBmVr0CmJF2ZNPwgt69/VaPaxbnpENxpD6vfgy3IoV+0tCk5g5WlKwWOIM
         saHoDgiMC0JxCPfToirYaVkjdvf8iI2Qd45kXt2JrFZWI/vc7hePNfKVpSuXqcCiiEsv
         GDWps2JH5VhZL3OwAKulWX7Jd6yEY4gxqsYaHPnfC5cj2dwTtxzETbdAfy/PCfiiPrz3
         VYR8juWmi6CU5uP1HWCt278L9hr8e9wTf1vnbv9MN4U/NBPngyTzXNz1fdjBwwFbnj1G
         pzlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJLWusGDOOteUNR80lo+AdiUJdU+Erx5/d9Me9VspDdBQXSJZB8HanSru9R6kWp2I0AHg9HWw=@vger.kernel.org
X-Gm-Message-State: AFuF++n6rtuT8/UXNJ4qlOUbNZ4TDkZ+Z69mmbTbYCVMKXPhdNSlvxer
	EI+MWM/OckZL9V3mCfqRBRG5rswJcsSqeQ4KlExa6ZAju9qjgUUAk6EoSL5VRrWKiFqoImZETgH
	IbQyu/Bc9DQrytw==
X-Received: from qknva26.prod.google.com ([2002:a05:620a:3f9a:b0:93a:c66:a431])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1b91:b0:93b:d79b:9a59 with SMTP id af79cd13be357-93c25236c31mr353098185a.58.1790168602089;
 Wed, 23 Sep 2026 06:03:22 -0700 (PDT)
Date: Wed, 23 Sep 2026 13:03:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923130318.607255-1-edumazet@google.com>
Subject: [PATCH v2 net] net: flush skb_defer_nodes in dev_cpu_dead()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	edumazet@kernel.org, Eric Dumazet <edumazet@google.com>, Kris Pan <kris.pan@intel.com>
Content-Type: text/plain; charset="UTF-8"

When a CPU goes offline, dev_cpu_dead() drains its softnet queues
(completion_queue, output_queue, poll_list, process_queue, and
input_pkt_queue), but leaves net_hotdata.skb_defer_nodes untouched.

If oldcpu goes offline while holding pending skbs in its
skb_defer_nodes lists (e.g. below the sysctl_skb_defer_max >> 1 IPI
threshold, or if the IPI races with CPU teardown), those skbs remain
stranded until oldcpu is brought back online. If any of these skbs
hold page_pool fragments, page_pool_destroy() will stall indefinitely
waiting for inflight pages to be returned when a netdev or driver is
torn down while oldcpu is offline.

Additionally, if smp_call_function_single_async() fails in
kick_defer_list_purge() because the target CPU went offline, reset
defer_ipi_scheduled to 0 so future IPI kicks are not blocked when the
CPU comes back online.

Also, if oldcpu was the last online CPU on its NUMA node, drain that
node's slot across all CPUs so no skbs deferred from that node remain
stranded on idle remote CPUs (or if the node itself is subsequently
offlined).

Finally, in skb_attempt_defer_free(), re-check cpu_online(cpu) and
whether the caller migrated CPUs after llist_add(), flushing the node
list if so, to close the preemption TOCTOU race against CPU/node
teardown.

Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
Fixes: 5628f3fe3b16 ("net: add NUMA awareness to skb_attempt_defer_free()")
Closes: https://lore.kernel.org/netdev/20260916003430.3612956-1-kris.pan@intel.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kris Pan <kris.pan@intel.com>
---
v2: Addressed [High] concern (Sashiko)
v1: https://lore.kernel.org/netdev/20260921182700.1796214-1-edumazet@google.com/

 net/core/dev.c    | 47 +++++++++++++++++++++++++++++++++++------------
 net/core/dev.h    |  2 ++
 net/core/skbuff.c | 12 +++++++++---
 3 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c67900354fa64b73de0623112366f485fedeb87b..2d06d3d615e2b235e4cf5e246f5db5ec355a094d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5376,7 +5376,8 @@ void kick_defer_list_purge(unsigned int cpu)
 		backlog_unlock_irq_restore(sd, flags);
 
 	} else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
-		smp_call_function_single_async(cpu, &sd->defer_csd);
+		if (smp_call_function_single_async(cpu, &sd->defer_csd))
+			WRITE_ONCE(sd->defer_ipi_scheduled, 0);
 	}
 }
 
@@ -6900,25 +6901,35 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 }
 EXPORT_SYMBOL(napi_complete_done);
 
-static void skb_defer_free_flush(void)
+static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
 {
 	struct llist_node *free_list;
 	struct sk_buff *skb, *next;
+
+	if (llist_empty(&sdn->defer_list))
+		return;
+	atomic_long_set(&sdn->defer_count, 0);
+	free_list = llist_del_all(&sdn->defer_list);
+
+	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
+		prefetch(next);
+		napi_consume_skb(skb, budget);
+	}
+}
+
+void skb_defer_node_flush(struct skb_defer_node *sdn)
+{
+	__skb_defer_free_flush(sdn, 0);
+}
+
+static void skb_defer_free_flush(void)
+{
 	struct skb_defer_node *sdn;
 	int node;
 
 	for_each_node(node) {
 		sdn = this_cpu_ptr(net_hotdata.skb_defer_nodes) + node;
-
-		if (llist_empty(&sdn->defer_list))
-			continue;
-		atomic_long_set(&sdn->defer_count, 0);
-		free_list = llist_del_all(&sdn->defer_list);
-
-		llist_for_each_entry_safe(skb, next, free_list, ll_node) {
-			prefetch(next);
-			napi_consume_skb(skb, 1);
-		}
+		__skb_defer_free_flush(sdn, 1);
 	}
 }
 
@@ -12897,6 +12908,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
 	struct sk_buff **list_skb;
 	struct sk_buff *skb;
 	unsigned int cpu;
+	int node;
 	struct softnet_data *sd, *oldsd, *remsd = NULL;
 
 	local_irq_disable();
@@ -12957,6 +12969,17 @@ static int dev_cpu_dead(unsigned int oldcpu)
 		rps_input_queue_head_incr(oldsd);
 	}
 
+	for_each_node(node)
+		skb_defer_node_flush(per_cpu_ptr(net_hotdata.skb_defer_nodes,
+						 oldcpu) + node);
+	node = cpu_to_node(oldcpu);
+	if (node_possible(node) &&
+	    !cpumask_intersects(cpumask_of_node(node), cpu_online_mask)) {
+		for_each_possible_cpu(cpu)
+			skb_defer_node_flush(per_cpu_ptr(net_hotdata.skb_defer_nodes,
+							 cpu) + node);
+	}
+
 	return 0;
 }
 
diff --git a/net/core/dev.h b/net/core/dev.h
index b757faead4d1a3e445e54d2f468c38c9e09b6762..04fb0e9a571e03f41cac110a0d1dd864d110b339 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -399,6 +399,8 @@ static inline void napi_assert_will_not_race(const struct napi_struct *napi)
 	WARN_ON(READ_ONCE(napi->list_owner) != -1);
 }
 
+struct skb_defer_node;
+void skb_defer_node_flush(struct skb_defer_node *sdn);
 void kick_defer_list_purge(unsigned int cpu);
 
 int dev_set_hwtstamp_phylib(struct net_device *dev,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b4edbd06655e2ac46fdccc74979295f4a938078f..c3042d822afa7aaaae7cad6aba4d647af0732aeb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7360,8 +7360,8 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 	struct skb_defer_node *sdn;
 	unsigned long defer_count;
 	unsigned int defer_max;
+	int cpu, my_cpu;
 	bool kick;
-	int cpu;
 
 	if (static_branch_unlikely(&skb_defer_disable_key))
 		goto nodefer;
@@ -7371,7 +7371,8 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 		goto nodefer;
 
 	cpu = skb->alloc_cpu;
-	if (cpu == raw_smp_processor_id() ||
+	my_cpu = raw_smp_processor_id();
+	if (cpu == my_cpu ||
 	    WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
 	    !cpu_online(cpu)) {
 nodefer:	kfree_skb_napi_cache(skb);
@@ -7382,7 +7383,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
 	DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
 
-	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + numa_node_id();
+	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);
 
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
 	defer_count = atomic_long_inc_return(&sdn->defer_count);
@@ -7392,6 +7393,11 @@ nodefer:	kfree_skb_napi_cache(skb);
 
 	llist_add(&skb->ll_node, &sdn->defer_list);
 
+	if (unlikely(!cpu_online(cpu) || my_cpu != raw_smp_processor_id())) {
+		skb_defer_node_flush(sdn);
+		return;
+	}
+
 	/* Send an IPI every time queue reaches half capacity. */
 	kick = (defer_count - 1) == (defer_max >> 1);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

