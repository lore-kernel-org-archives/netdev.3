Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285894;
	b=qBS3j3rz5PcNXW7C+5yHZt8A3eT0BoZd33XD9eFoEaaQ2vlqtOAYlz9gb1nJ090QatLw
	 YbuCVsMHoc6VZidzneDilkTRxB7Ic5vijh6aNdySUC2W0EfDcTb+X7bmAEEV0gI0FspVU
	 MpeTiT9Swhij5IlOxy9qoUx+kWTDkVemAAVYY56nONZhiWc5jzUXn+v/S5QQQfVRevPev
	 9wrsfqq3GLJ91BIa+e8kKtBNFkJ8v1QLq4Wda0AEcRWDYIyGSLc2UpzE4x2zSBI8NoZz9
	 OEIp3gG6redsiFvNNpCD14MjSpzpUvAe8BXLZEdZgUQorsjr2H1RZqGoceO7pfhaZUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GdSjMsCITlSqE8vgApaYl4U5QfVkIMv+UvZLtzoWlOw=;
	b=y6o+m0V9v9mP9Uwa1nraJz/edAt6Xdom7+vU1uLfleCg8N7IBJ7Nw3FOw25Z/HrL1Xdo
	 j6jIdZUY8etZ+J3sUmTbbH9gxrCpivWtgbVC8bHrBDhcCoD68d07ncd4mK/phPQGHIDUx
	 t2POVVT03gLvE5DSoio0Ng0nSBHhJmt0GFDHgbudM5xwAbEMmkAwzp8DS31qmmtlRIEU/
	 eRGvVbfw255JcSg8vf/pXL/mlauyNewEsvcR30DTv4fOEzl3GdoOj/wX5zsz8BIFS6jr2
	 DNsfNRxxfXyydFEtp5Ma9QoHQdIBVzpMmz5Ps/SLWzZ1WhzFLz6YzNahGyNsDhCjO3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=IyceX664;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED578606A330
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED578606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=IyceX664
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8470d7d430fso875775a34.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794285893; x=1794890693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GdSjMsCITlSqE8vgApaYl4U5QfVkIMv+UvZLtzoWlOw=;
        b=IyceX664QnWk7MxnS6KTjpYCGYqeVNPtzWoxQPzJUlPcqeheb3eIVRjM5VhSiJzbPq
         CiR4M58pOstIzq6FGIGIjFgOGVvRMcMQp0QTzlgLpIhrqu6C0DSQkcjw96rn//ijzuow
         ERgw1P1n/IQMz1zO4C/BDgScvQDj3roafwqDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285893; x=1794890693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdSjMsCITlSqE8vgApaYl4U5QfVkIMv+UvZLtzoWlOw=;
        b=aQRl1j50xiumOGfERqKIMg5nY6kOgpUqqXODsuM1AdbIxG0MzJzZ+NTNijOgeqPo6S
         kJxNpB+gtzC0sWAWNvk6rdzj6cv3oBd+tLzZniOwA6isuGCUHsyLoUXMeDvsYN7SQDSV
         2jSD2G3YCkyq+EMhN4SKfJqPLC3ZMX0bFl4EkrdjZhN1ozmaRF/PsnVh17gI8mlrZbQi
         zyJJs++eQdE2205qss4ui3X4Kc7Voc6hhgISDiSdweRku71AG6dbSjH1xn8RF+6D85Gp
         jxAF1AdR1N/TNBWH7d3bFj53YLjNFy52XFGVOE8OQd2kL9FQEbu/TU2KMXrM5HeXPmg4
         r+NA==
X-Gm-Message-State: APuU4Z+GTDdglaYnJXpsSn7s8QDk1FPEobypy6oUs/HqJzGrnkHp9qAg
	332RYNXJDkd0l+yDGr/sTNUkd3u57D9buXYYmLaJVIPhkuMuPypeXQ35q/gciGKNfVXe+z4A/JA
	g6QQCop8=
X-Gm-Gg: AYBFou35HkpQ2Z5euRr/TE/VsGwJNjnUaMhW21oQbHRx2CBkMXs1UeZgJ+C7yOCeJBk
	Qoi1Iyv5cJr9E/+0U9FWngB2LkyY8hWIpl6yZJTmMh4PamIhRX5KQkKmihOZGeHdDy6h8gBOJk4
	QdaqhptFbKNAOUDS5OE5RqzmxDieZ+Kqf88ypIXz5hv7T6OwkpIb3bac6aIvUiJMZyIjlfTZU2L
	axTgktD0CZaf014Xcx978OxebHnzkySjBz7ef93l5YjKQkCpLc/cWOsldNy2L9gBvXlqXORoIo/
	+0BGCwEb2swnRxQA6eA9VFiB56X8EE/20/Jwa9woUyt5ulelTos0C2gEa/vX/+NJm5O18Grnnze
	8kLQSaw0JGdZj9X4RI+4H/JLQIGcMnVoMr863Fom96aKrXH9+0OtpUq9pXCg3ZYnBRLhYTygMFp
	whZyZM9uNo2tQkDN6dauUlAnul4ULcGI8dnvUNMA16pBA2oLXpCmskw6jCJZ0l5jeeMc52e3XyA
	GcJcJTJPo8Q/48y1smUG1tNcDXd23VTSSexEhspoosp6AEZw8OsTVA2qBq0il1zguchdccrY+pW
	2VFYr2CKZuD3pY8/YgtsJbnzdofIHFfya4jh+3uxYmUPNCs/TgP9EvEMoboPEwenEzaSRHrUOhM
	ABFw6xnuJU064ptKqyrsnoFMuqgL/8g==
X-Received: by 2002:a05:6830:3d8f:b0:846:5d82:8b69 with SMTP id 46e09a7af769-860dc819839mr929680a34.20.1794285892757;
        Mon, 09 Nov 2026 20:44:52 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb5f847sm1084109a34.8.2026.11.09.20.44.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:44:52 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/sched: serialize autonomous timers with qdisc resets
Date: Mon,  9 Nov 2026 20:44:50 -0800
Message-ID: <20261110044450.51921-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Autonomous qdisc timers can race with queue resets during graft and
destruction. A timer can read qdisc_sleeping before a graft, acquire
that root's lock after the graft, and modify queues protected by the
replacement root's lock. __qdisc_destroy() also resets detached qdiscs
without the tree lock before their destroy callbacks stop the timers.
In SFQ, either race can corrupt skb lists and flow-slot state.

Add a helper that acquires the sleeping-root lock under RCU and retries
if the root changed. Use it in the SFQ, RED, PIE, FQ-PIE and DualPI2
timers. Route default-qdisc attachment and scheduler shutdown through
dev_graft_qdisc(), so all live root replacements hold the previous
root's lock. A validated root then remains current until the timer
unlocks.

Hold the tree lock across the final qdisc reset and release it before
calling the destroy callback so synchronous timer cancellation can
complete. Detached TAPRIO children can have different sleeping roots,
so defer their final resets to taprio_destroy() and lock each subtree
separately. Keep those resets before hardware offload is disabled.

The issue was found by an LLM.

Fixes: 225d9b89c937 ("sch_sfq: rehash queues in perturb timer")
Fixes: 47e8dbb6e763 ("net/sched: do not reset queues in graft operations")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v2:
- Serialize the final qdisc reset with autonomous timers, addressing
  the remaining destruction race identified in review.
- Reset detached TAPRIO children under their individual root locks.
- Add the two Fixes tags.

v1: https://lore.kernel.org/netdev/20261030042312.74363-1-kylebot@openai.com/
Review: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030042312.74363-1-kylebot@openai.com

I have a reproducer for this issue and can share via DM

 include/net/sch_generic.h | 20 ++++++++++++++++++++
 net/sched/sch_dualpi2.c   |  3 +--
 net/sched/sch_fq_pie.c    |  3 +--
 net/sched/sch_generic.c   | 11 +++++++----
 net/sched/sch_pie.c       |  3 +--
 net/sched/sch_red.c       |  3 +--
 net/sched/sch_sfq.c       |  3 +--
 net/sched/sch_taprio.c    | 16 ++++++++++++++++
 8 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 1acaadb3e2cf..e234256e6ae8 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -608,6 +608,26 @@ static inline spinlock_t *qdisc_root_sleeping_lock(const struct Qdisc *qdisc)
 	return qdisc_lock(root);
 }
 
+/* The caller must hold rcu_read_lock().  dev_graft_qdisc() changes the
+ * sleeping root under the old root's lock, so retry if it changed while
+ * we were waiting for that lock.
+ */
+static inline spinlock_t *qdisc_lock_root_sleeping(const struct Qdisc *qdisc)
+{
+	struct Qdisc *root;
+	/* Lock of the sleeping root observed under RCU. */
+	spinlock_t *lock;
+
+	for (;;) {
+		root = qdisc_root_sleeping(qdisc);
+		lock = qdisc_lock(root);
+		spin_lock(lock);
+		if (root == qdisc_root_sleeping(qdisc))
+			return lock;
+		spin_unlock(lock);
+	}
+}
+
 static inline struct net_device *qdisc_dev(const struct Qdisc *qdisc)
 {
 	return qdisc->dev_queue->dev;
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4947def7c49e..8a74ceaab29d 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -750,8 +750,7 @@ static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
 	spinlock_t *root_lock; /* to lock qdisc for probability calculations */
 
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 
 	WRITE_ONCE(q->pi2_prob, calculate_probability(sch));
 	hrtimer_set_expires(&q->pi2_timer, next_pi2_timeout(q));
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5982847df8f8..a1b5126db640 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -394,8 +394,7 @@ static void fq_pie_timer(struct timer_list *t)
 	int max_cnt, i;
 
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 
 	/* Limit this expensive loop to 2048 flows per round. */
 	max_cnt = min_t(int, q->flows_cnt - q->flows_cursor, 2048);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index d2e0d20f3ba1..fbbc07700160 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1106,7 +1106,7 @@ struct Qdisc *qdisc_create_dflt(struct netdev_queue *dev_queue,
 }
 EXPORT_SYMBOL(qdisc_create_dflt);
 
-/* Under qdisc_lock(qdisc) and BH! */
+/* Under sch_tree_lock(qdisc) and BH! */
 
 void qdisc_reset(struct Qdisc *qdisc)
 {
@@ -1154,8 +1154,10 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 #endif
 	gen_kill_estimator(&qdisc->rate_est);
 
+	/* Autonomous timers can still run after the qdisc was detached. */
+	sch_tree_lock(qdisc);
 	qdisc_reset(qdisc);
-
+	sch_tree_unlock(qdisc);
 
 	if (ops->destroy)
 		ops->destroy(qdisc);
@@ -1213,6 +1215,7 @@ struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 	struct Qdisc *oqdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	spinlock_t *root_lock;
 
+	/* Pairs with qdisc_lock_root_sleeping() in asynchronous callbacks. */
 	root_lock = qdisc_lock(oqdisc);
 	spin_lock_bh(root_lock);
 
@@ -1236,8 +1239,8 @@ static void shutdown_scheduler_queue(struct net_device *dev,
 	struct Qdisc *qdisc_default = _qdisc_default;
 
 	if (qdisc) {
+		qdisc = dev_graft_qdisc(dev_queue, qdisc_default);
 		rcu_assign_pointer(dev_queue->qdisc, qdisc_default);
-		rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc_default);
 
 		qdisc_put(qdisc);
 	}
@@ -1261,7 +1264,7 @@ static void attach_one_default_qdisc(struct net_device *dev,
 
 	if (!netif_is_multiqueue(dev))
 		qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
-	rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc);
+	dev_graft_qdisc(dev_queue, qdisc);
 }
 
 static void attach_default_qdiscs(struct net_device *dev)
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3b7863ffd284..9367065db4b1 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -429,8 +429,7 @@ static void pie_timer(struct timer_list *t)
 	spinlock_t *root_lock;
 
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 	pie_calculate_probability(&q->params, &q->vars, sch->qstats.backlog);
 
 	/* reset the timer to fire after 'tupdate'. tupdate is in jiffies. */
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index d7598214270b..a7601b879092 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -333,8 +333,7 @@ static inline void red_adaptative_timer(struct timer_list *t)
 	spinlock_t *root_lock;
 
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 	red_adaptative_algo(&q->parms, &q->vars);
 	mod_timer(&q->adapt_timer, jiffies + HZ/2);
 	spin_unlock(root_lock);
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 8bbcfc9e85d9..2bd3fc65053a 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -611,8 +611,7 @@ static void sfq_perturbation(struct timer_list *t)
 
 	get_random_bytes(&nkey, sizeof(nkey));
 	rcu_read_lock();
-	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
-	spin_lock(root_lock);
+	root_lock = qdisc_lock_root_sleeping(sch);
 	q->perturbation = nkey;
 	if (!q->filter_list && q->tail)
 		sfq_rehash(sch);
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 4f69ef3d847a..b7489cf4bba9 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2041,6 +2041,10 @@ static void taprio_reset(struct Qdisc *sch)
 
 	hrtimer_cancel(&q->advance_timer);
 
+	/* Destroy resets each detached subtree under its own root lock. */
+	if (!refcount_read(&sch->refcnt))
+		return;
+
 	if (q->qdiscs) {
 		for (i = 0; i < dev->num_tx_queues; i++)
 			if (q->qdiscs[i])
@@ -2063,6 +2067,18 @@ static void taprio_destroy(struct Qdisc *sch)
 	hrtimer_cancel(&q->advance_timer);
 	qdisc_synchronize(sch);
 
+	if (q->qdiscs) {
+		for (i = 0; i < dev->num_tx_queues; i++) {
+			struct Qdisc *child = q->qdiscs[i];
+
+			if (!child)
+				continue;
+			sch_tree_lock(child);
+			qdisc_reset(child);
+			sch_tree_unlock(child);
+		}
+	}
+
 	taprio_disable_offload(dev, q, NULL);
 
 	if (q->qdiscs) {

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.55.0.openai.911.g06873a30d2f3

