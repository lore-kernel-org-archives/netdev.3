Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392862;
	b=S/svvoLU4FxyLVMEJXhzao4xtZd/40yUIXpVwhuKWTsapeUIjfKmGwt79lftXGdc5Vjg
	 vCrMDEw4LJEAK3c3PHIrc1Zc5wMnlzQKLDbzl9Rr1ChUFmqexaFByevos/4DDnfipsWAM
	 HGlv+9Wmj8vHmtuUVmecETXQHEFdRpPT4aVwo/TdVTcz8IgtAZ/YFk9ktHI2tK/7CPTSV
	 WutIouNa0v5Nr4LvnHQrHPDFfuyuQBBpTdkRfKlu2tlQ8S82dKQvYM+fMx7W6nsVvBfCv
	 r6m+qnfL8MZ2vETIf7gzsaFWov45xoY/7GhfdQsaJ+fz+OIgKTW8lKBzyz13JrSLToQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392862;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w9zFH06fEtJge9QM/CiLbfVi79PwZvBhoxCVWpR4J3Q=;
	b=L6JlXgXuJG+hPlkzkkl+582KihIO2E2m2Kd5gPlfUGHTUU6QqT8kOxYdHbEJ2dyKM5Bd
	 eao7hJwAwmYW98EzCsjK4zmhJ8QymNlHE4PF+7f6Kc09aw4PyfzC45IDnz33WtHcdzf16
	 AmBB+Za5VGJxKdiYv5nCarVFilKiEM5Qk4D1a9FL2P9O+sXEqN0HEpl6yTeBHivNZwhRD
	 2/Wy+dcPeVq235tta3isWTKeb0eQKJ+5923rHGpeNC8ps0RpSiD0TwVuXecJtpL5daFYr
	 DkJahg9VhcyiNFT6SQlqwW+6ZiTouT7a4tEMbCP2LCc290nk2gec9ZwSZ1nY1W6LbQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=roXxJRjd;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 079AD606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 079AD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=roXxJRjd
Received: from kero.packetmixer.de (p200300C59740ded843Be7e4a980e9C65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 5C778FA156;
	Wed, 11 Nov 2026 11:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9zFH06fEtJge9QM/CiLbfVi79PwZvBhoxCVWpR4J3Q=;
	b=roXxJRjdiLI5Xe4NJnZYAct5/NLsQfKc4Lo4Jr6xvU9QLh1J/vpsQxWJ6UM4dD3yUk6BmU
	9OfUlRziUAhfvlhKv610y6UsMLDCZEqUSBOnE1jPGWPuEWydtK8ylgNww+8f6pXAxWjFCa
	qlwaurqk5IZiJns5YJNVb0+aK1Ud7FAsO2V93TTcYViGi8QDL0CnHc9h11N7wzZAA5jQEW
	bbHepONhRuEgx9EwtjkLAgzL3ZHuHs+pWkxPo8d1FZ3rqiTffdVejnljVltZhB4nnJWrlO
	tQYWL79qL3YZbpwd/aznTV0ZBHhh91OFi+zppqZdRyFq/LqEXWVkA/AjYytMBA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 04/15] batman-adv: avoid torn u64 counter reads on 32-bit systems
Date: Wed, 11 Nov 2026 11:27:18 +0100
Message-ID: <20261111102729.2096241-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

On a 32-bit architecture, concurrent updates and reads of the 64-bit
per-CPU counters result in torn reads. It is necessary to share a
sync-point with the batadv_add_counter() and batadv_sum_counter() to ensure
that a potential write (which modifies the upper u32 too) can be retried by
batadv_sum_counter().

The counters are switched to u64_stats_t to also get properly annotated
(local64) accesses on 64 bit systems.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-34735281-9ca5-437f-9539-e7cd553e3b18
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h           | 15 +++++++++++++--
 net/batman-adv/mesh-interface.c | 23 +++++++++++++++++++----
 net/batman-adv/types.h          | 21 ++++++++++++++++-----
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e738758ee4a7a..fb938e08a3eb2 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -199,6 +199,7 @@ enum batadv_uev_type {
 /* Kernel headers */
 
 #include <linux/atomic.h>
+#include <linux/bottom_half.h>
 #include <linux/compiler.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
@@ -207,6 +208,7 @@ enum batadv_uev_type {
 #include <linux/percpu.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <uapi/linux/batadv_packet.h>
 
 #include "types.h"
@@ -339,12 +341,21 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
  * @idx: counter index which should be modified
  * @count: value to increase counter by
  *
- * Stop preemption on local cpu while incrementing the counter
+ * Stop bottom halves on local cpu while incrementing the counter. The 64 bit
+ * update is additionally guarded by the u64_stats_sync to allow (for 32 bit)
+ * readers on other CPUs to detect torn reads.
  */
 static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
 				      size_t count)
 {
-	this_cpu_add(bat_priv->bat_counters[idx], count);
+	struct batadv_pcpu_counters *counters;
+
+	local_bh_disable();
+	counters = this_cpu_ptr(bat_priv->bat_counters);
+	u64_stats_update_begin(&counters->syncp);
+	u64_stats_add(&counters->cnt[idx], count);
+	u64_stats_update_end(&counters->syncp);
+	local_bh_enable();
 }
 
 /**
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 6ffc505ce2aba..16b681e10b33d 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -37,6 +37,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/utsname.h>
 #include <net/netlink.h>
 #include <net/rtnetlink.h>
@@ -92,13 +93,21 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
  */
 static u64 batadv_sum_counter(struct batadv_priv *bat_priv,  size_t idx)
 {
-	u64 *counters;
+	struct batadv_pcpu_counters *counters;
+	unsigned int start;
 	u64 sum = 0;
+	u64 val;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
 		counters = per_cpu_ptr(bat_priv->bat_counters, cpu);
-		sum += counters[idx];
+
+		do {
+			start = u64_stats_fetch_begin(&counters->syncp);
+			val = u64_stats_read(&counters->cnt[idx]);
+		} while (u64_stats_fetch_retry(&counters->syncp, start));
+
+		sum += val;
 	}
 
 	return sum;
@@ -802,9 +811,10 @@ static void batadv_set_lockdep_class(struct net_device *dev)
  */
 static int batadv_meshif_init_late(struct net_device *dev)
 {
-	size_t cnt_len = sizeof(u64) * BATADV_CNT_NUM;
+	struct batadv_pcpu_counters *counters;
 	struct batadv_priv *bat_priv;
 	u32 random_seqno;
+	int cpu;
 	int ret;
 
 	batadv_set_lockdep_class(dev);
@@ -815,10 +825,15 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	/* batadv_interface_stats() needs to be available as soon as
 	 * register_netdevice() has been called
 	 */
-	bat_priv->bat_counters = __alloc_percpu(cnt_len, __alignof__(u64));
+	bat_priv->bat_counters = alloc_percpu(struct batadv_pcpu_counters);
 	if (!bat_priv->bat_counters)
 		return -ENOMEM;
 
+	for_each_possible_cpu(cpu) {
+		counters = per_cpu_ptr(bat_priv->bat_counters, cpu);
+		u64_stats_init(&counters->syncp);
+	}
+
 	WRITE_ONCE(bat_priv->aggregated_ogms, 1);
 	WRITE_ONCE(bat_priv->bonding, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b3e6dbb360dae..0fece14c7e7f8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/batadv_packet.h>
@@ -986,6 +987,19 @@ enum batadv_counters {
 	BATADV_CNT_NUM,
 };
 
+/**
+ * struct batadv_pcpu_counters - per cpu traffic counters
+ */
+struct batadv_pcpu_counters {
+	/** @cnt: traffic counters (see batadv_counters) */
+	u64_stats_t cnt[BATADV_CNT_NUM];
+
+	/**
+	 * @syncp: synchronization for 64 bit counter access on 32 bit systems
+	 */
+	struct u64_stats_sync syncp;
+};
+
 /**
  * struct batadv_priv_tt - per mesh interface translation table data
  */
@@ -1564,11 +1578,8 @@ struct batadv_priv {
 	 */
 	int mtu_set_by_user;
 
-	/**
-	 * @bat_counters: mesh internal traffic statistic counters (see
-	 *  batadv_counters)
-	 */
-	u64 __percpu *bat_counters; /* Per cpu counters */
+	/** @bat_counters: mesh internal traffic statistic counters */
+	struct batadv_pcpu_counters __percpu *bat_counters;
 
 	/**
 	 * @aggregated_ogms: bool indicating whether OGM aggregation is enabled
-- 
2.47.3

