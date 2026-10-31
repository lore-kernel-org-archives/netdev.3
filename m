Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793428751;
	b=hDmc5q0qmz9Ux5G8dYg4C+H0WYgdLKy6uawkTPFxkAUl+1E7fLZE+uohNE+Hdc22zw1+
	 iUGi2V/maRix3WKRLS+Dqk1E4U0gPEJfPiOKTZXkmj0h/79i0PWhbcVGt1EiA3FAkkALs
	 Ub025Pe++Y31PUpeM/hvOgSP4U7E1wVCnLDw9FKBTl4vUsZeAYR7K6GiFr6Lh8rJ2wwZR
	 7pMVAxwB1M9/J/F6tD1fl1ZKuLtrX4+5imHOcCNpdRDXa3OnRxQLa22jJDVjTPGmJJXqr
	 aS81tWD6Jtp4PnnMV6kmLXUV5KQ9IjLrDWqBL0KhNetWhYM0WXTMmqDxClB5+ovYwRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793428751;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Rnpig1zlxZjNgotjELSao0Ynr0qeeJqSNYpfwdvLn7E=;
	b=U09tuHQIx2x95Ppa9ElVFqYlBU/UUer3rwV/abmpgNdKvKSBUtC+cCFKlEcG7Q3ueVS7
	 O7LWJ23XV+dJxZx4IN7bTbLPztr4t0oQP9A7oSBo16zSHhHX0LtKAbSjg7G11Aw/3g+Xa
	 J9X/QMn9ys+RO4XSWmS1MEbMLflahsBWAngG+PKFxMc+nvmE/1/7ft+a1jxf+Z8hR+h+B
	 2RCjIcyYCxz6g3Hs/poqSKVZsCu8LLlAgPEXifUwkCMQSumoyaPqCX56xVJ1pnU4WOqy0
	 hD/i5Zt8UKPnJFbWqZjFMgQeHFZOaKhD2EcXbIPoXSG4j/6U92P986IneNCUjP3hRhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="fh/72Ft0";
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8952606A323;
	Sat, 31 Oct 2026 06:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8952606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fh/72Ft0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rn
	pig1zlxZjNgotjELSao0Ynr0qeeJqSNYpfwdvLn7E=; b=fh/72Ft0+4o9M1C9JG
	xtvWhAbBrWrNdG5jg/JGvRS1a8gmdK6PUsyJjI9FajYxsbszakKvjLN3RDhOjlMS
	/hb6Mc1FP2yQulAuMSKvgF+JgRpN2bZlTDAVXdVbGINJuUYu4Uea/70s2zG7B/wH
	23NK51H1EhzkXo+Tf8RT8yg+s=
Received: from flipped.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXv9jfjOVqDwKbDg--.29841S4;
	Sat, 31 Oct 2026 14:38:27 +0800 (CST)
From: Sicong Huang <congei42@163.com>
To: netdev@vger.kernel.org
Cc: ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/2] sfc: quiesce aRFS work before copying channels in efx_realloc_channels()
Date: Sat, 31 Oct 2026 14:38:23 +0800
Message-Id: <20261031063823.876645-3-congei42@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031063823.876645-1-congei42@163.com>
References: <20261031063823.876645-1-congei42@163.com>
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
X-CM-TRANSID:_____wDXv9jfjOVqDwKbDg--.29841S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3uFWkXFy5Kw4fJr1kCrWrAFb_yoW8JF1DKo
	Z7XrnxXFy8uryIqrWqgF1kGFyIqrn8WwsxXrWfWan8WFZ0qr1jgF47G39xAay8tw1ruF4U
	Za45J3Z5tF12qryrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsQJ5UUUUU
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/xtbC9QNvYmrljOPwpQAA3O

The aRFS insertion worker caches a channel pointer before calling the
sleepable filter_insert() operation. Ring reallocation can copy and
free that channel before the worker updates its flow IDs, filter count
and statistics. Holding a net_device reference does not pin the channel.

The expiry worker can also run between the channel copy and its eventual
cancellation. It then updates the shared rps_flow_id array but only the
old channel's filter count and expiry index, leaving the copy inconsistent.

Quiesce both kinds of work before copying channels. Stopping NAPI alone
does not prevent new insertion requests: efx_ptp_stop() does not wait
for the PTP worker, which can still deliver previously received packets
through netif_receive_skb(). PTP channel probe sets core_index to zero,
and the receive path records that queue on the skb before handing it to
PTP. With aRFS enabled, these packets can still cause insertion requests.

Reject aRFS requests while the net_device is detached, and use
synchronize_net() to wait for ndo_rx_flow_steer() callers that passed the
check before detach. The receive core invokes that callback under
rcu_read_lock().
The same check also rejects requests while the device is detached for
reset, instead of queuing insertion work during reset.

Then flush every insertion work item and synchronously cancel each
channel's expiry work. Initialise the insertion work items once during
NIC structure setup, so even unused slots can safely be flushed. Do not
use rps_slot_map as a completion test: its bits are cleared before the
worker returns, without a release/acquire protocol for copying its state.

The net_device remains detached throughout copying, swapping and cleanup.
The common exit restores expiry on the surviving channels before normal
operation resumes, including allocation failure and probe rollback.
Apply the same changes to Siena.

The insertion-work lifetime and expiry-copy races were reported by
Sashiko and examined by code inspection. Neither the issues nor the fix
has been tested on hardware. Compile-tested on x86_64 with
CONFIG_RFS_ACCEL enabled and disabled.

Fixes: 3af0f34290f6 ("sfc: replace asynchronous filter operations")
Link: https://lore.kernel.org/netdev/179302387159.3134.8640588618973558922@kernel.org/
Link: https://lore.kernel.org/netdev/179310908138.3134.11515982039281965575@kernel.org/
Signed-off-by: Sicong Huang <congei42@163.com>
---
 drivers/net/ethernet/sfc/efx_channels.c       | 12 ++++++++
 drivers/net/ethernet/sfc/efx_common.c         |  1 +
 drivers/net/ethernet/sfc/rx_common.c          | 30 ++++++++++++++++++-
 drivers/net/ethernet/sfc/rx_common.h          |  2 ++
 drivers/net/ethernet/sfc/siena/efx_channels.c | 12 ++++++++
 drivers/net/ethernet/sfc/siena/efx_common.c   |  1 +
 drivers/net/ethernet/sfc/siena/rx_common.c    | 30 ++++++++++++++++++-
 drivers/net/ethernet/sfc/siena/rx_common.h    |  2 ++
 8 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index 44943345fa87..da7903205c3a 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -866,6 +866,18 @@ int efx_realloc_channels(struct efx_nic *efx, u32 rxq_entries, u32 txq_entries)
 	efx_stop_all(efx);
 	efx_soft_disable_interrupts(efx);
 
+#ifdef CONFIG_RFS_ACCEL
+	/* efx_copy_channel() copies the aRFS state without rps_mutex, so
+	 * all aRFS work must be quiescent before the channels are copied,
+	 * not just before the old ones are freed.  The detached net_device
+	 * rejects new insertion requests, and NAPI is stopped so efx_poll()
+	 * cannot re-arm filter_work.
+	 */
+	efx_filter_rfs_flush(efx);
+	efx_for_each_channel(channel, efx)
+		cancel_delayed_work_sync(&channel->filter_work);
+#endif
+
 	/* Clone channels (where possible) */
 	memset(other_channel, 0, sizeof(other_channel));
 	for (i = 0; i < efx->n_channels; i++) {
diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 3afaec36642f..08532da706a6 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -995,6 +995,7 @@ int efx_init_struct(struct efx_nic *efx, struct pci_dev *pci_dev)
 #ifdef CONFIG_RFS_ACCEL
 	mutex_init(&efx->rps_mutex);
 	spin_lock_init(&efx->rps_hash_lock);
+	efx_filter_rfs_init(efx);
 	/* Failure to allocate is not fatal, but may degrade ARFS performance */
 	efx->rps_hash_table = kzalloc_objs(*efx->rps_hash_table,
 					   EFX_ARFS_HASH_TABLE_SIZE);
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index fd0a1a8ac2a1..62417c7e907c 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -895,6 +895,14 @@ static void efx_filter_rfs_work(struct work_struct *data)
 	netdev_put(req->net_dev, &req->net_dev_tracker);
 }
 
+void efx_filter_rfs_init(struct efx_nic *efx)
+{
+	int slot_idx;
+
+	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
+		INIT_WORK(&efx->rps_slot[slot_idx].work, efx_filter_rfs_work);
+}
+
 int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 		   u16 rxq_index, u32 flow_id)
 {
@@ -906,6 +914,10 @@ int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	bool new;
 	int rc;
 
+	/* Paired with synchronize_net() in efx_filter_rfs_flush(). */
+	if (!netif_device_present(net_dev))
+		return -ENETDOWN;
+
 	/* find a free slot */
 	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
 		if (!test_and_set_bit(slot_idx, &efx->rps_slot_map))
@@ -986,7 +998,6 @@ int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	/* Queue the request */
 	req->net_dev = net_dev;
 	netdev_hold(req->net_dev, &req->net_dev_tracker, GFP_ATOMIC);
-	INIT_WORK(&req->work, efx_filter_rfs_work);
 	req->rxq_index = rxq_index;
 	req->flow_id = flow_id;
 	schedule_work(&req->work);
@@ -998,6 +1009,23 @@ int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	return rc;
 }
 
+/* The caller must keep the net_device detached until the channels are safe
+ * for new aRFS requests.  Requests can also come from deferred PTP receive
+ * processing after NAPI has stopped.
+ */
+void efx_filter_rfs_flush(struct efx_nic *efx)
+{
+	int slot_idx;
+
+	/* ndo_rx_flow_steer() runs under rcu_read_lock().  Wait for callers
+	 * which saw the device before it was detached to finish queueing.
+	 */
+	synchronize_net();
+
+	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
+		flush_work(&efx->rps_slot[slot_idx].work);
+}
+
 bool __efx_filter_rfs_expire(struct efx_channel *channel, unsigned int quota)
 {
 	bool (*expire_one)(struct efx_nic *efx, u32 flow_id, unsigned int index);
diff --git a/drivers/net/ethernet/sfc/rx_common.h b/drivers/net/ethernet/sfc/rx_common.h
index 75fa84192362..ac4fe0ebab32 100644
--- a/drivers/net/ethernet/sfc/rx_common.h
+++ b/drivers/net/ethernet/sfc/rx_common.h
@@ -103,8 +103,10 @@ struct efx_arfs_rule *efx_rps_hash_add(struct efx_nic *efx,
 				       bool *new);
 void efx_rps_hash_del(struct efx_nic *efx, const struct efx_filter_spec *spec);
 
+void efx_filter_rfs_init(struct efx_nic *efx);
 int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 		   u16 rxq_index, u32 flow_id);
+void efx_filter_rfs_flush(struct efx_nic *efx);
 bool __efx_filter_rfs_expire(struct efx_channel *channel, unsigned int quota);
 #endif
 
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 388bef4be468..6c2f1492ca58 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -898,6 +898,18 @@ int efx_siena_realloc_channels(struct efx_nic *efx, u32 rxq_entries,
 	efx_siena_stop_all(efx);
 	efx_soft_disable_interrupts(efx);
 
+#ifdef CONFIG_RFS_ACCEL
+	/* efx_copy_channel() copies the aRFS state without rps_mutex, so
+	 * all aRFS work must be quiescent before the channels are copied,
+	 * not just before the old ones are freed.  The detached net_device
+	 * rejects new insertion requests, and NAPI is stopped so efx_poll()
+	 * cannot re-arm filter_work.
+	 */
+	efx_siena_filter_rfs_flush(efx);
+	efx_for_each_channel(channel, efx)
+		cancel_delayed_work_sync(&channel->filter_work);
+#endif
+
 	/* Clone channels (where possible) */
 	memset(other_channel, 0, sizeof(other_channel));
 	for (i = 0; i < efx->n_channels; i++) {
diff --git a/drivers/net/ethernet/sfc/siena/efx_common.c b/drivers/net/ethernet/sfc/siena/efx_common.c
index f91e5f8c0b35..d7615c2394e9 100644
--- a/drivers/net/ethernet/sfc/siena/efx_common.c
+++ b/drivers/net/ethernet/sfc/siena/efx_common.c
@@ -1022,6 +1022,7 @@ int efx_siena_init_struct(struct efx_nic *efx,
 #ifdef CONFIG_RFS_ACCEL
 	mutex_init(&efx->rps_mutex);
 	spin_lock_init(&efx->rps_hash_lock);
+	efx_siena_filter_rfs_init(efx);
 	/* Failure to allocate is not fatal, but may degrade ARFS performance */
 	efx->rps_hash_table = kzalloc_objs(*efx->rps_hash_table,
 					   EFX_ARFS_HASH_TABLE_SIZE);
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
index 4ceb108fad48..220778a597aa 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.c
+++ b/drivers/net/ethernet/sfc/siena/rx_common.c
@@ -886,6 +886,14 @@ static void efx_filter_rfs_work(struct work_struct *data)
 	netdev_put(req->net_dev, &req->net_dev_tracker);
 }
 
+void efx_siena_filter_rfs_init(struct efx_nic *efx)
+{
+	int slot_idx;
+
+	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
+		INIT_WORK(&efx->rps_slot[slot_idx].work, efx_filter_rfs_work);
+}
+
 int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 			 u16 rxq_index, u32 flow_id)
 {
@@ -897,6 +905,10 @@ int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	bool new;
 	int rc;
 
+	/* Paired with synchronize_net() in efx_siena_filter_rfs_flush(). */
+	if (!netif_device_present(net_dev))
+		return -ENETDOWN;
+
 	/* find a free slot */
 	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
 		if (!test_and_set_bit(slot_idx, &efx->rps_slot_map))
@@ -977,7 +989,6 @@ int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	/* Queue the request */
 	req->net_dev = net_dev;
 	netdev_hold(req->net_dev, &req->net_dev_tracker, GFP_ATOMIC);
-	INIT_WORK(&req->work, efx_filter_rfs_work);
 	req->rxq_index = rxq_index;
 	req->flow_id = flow_id;
 	schedule_work(&req->work);
@@ -989,6 +1000,23 @@ int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	return rc;
 }
 
+/* The caller must keep the net_device detached until the channels are safe
+ * for new aRFS requests.  Requests can also come from deferred PTP receive
+ * processing after NAPI has stopped.
+ */
+void efx_siena_filter_rfs_flush(struct efx_nic *efx)
+{
+	int slot_idx;
+
+	/* ndo_rx_flow_steer() runs under rcu_read_lock().  Wait for callers
+	 * which saw the device before it was detached to finish queueing.
+	 */
+	synchronize_net();
+
+	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
+		flush_work(&efx->rps_slot[slot_idx].work);
+}
+
 bool __efx_siena_filter_rfs_expire(struct efx_channel *channel,
 				   unsigned int quota)
 {
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.h b/drivers/net/ethernet/sfc/siena/rx_common.h
index f90a8320d396..2e0fe35c7eb9 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.h
+++ b/drivers/net/ethernet/sfc/siena/rx_common.h
@@ -94,8 +94,10 @@ struct efx_arfs_rule *efx_siena_rps_hash_find(struct efx_nic *efx,
 void efx_siena_rps_hash_del(struct efx_nic *efx,
 			    const struct efx_filter_spec *spec);
 
+void efx_siena_filter_rfs_init(struct efx_nic *efx);
 int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 			 u16 rxq_index, u32 flow_id);
+void efx_siena_filter_rfs_flush(struct efx_nic *efx);
 bool __efx_siena_filter_rfs_expire(struct efx_channel *channel,
 				   unsigned int quota);
 #endif
-- 
2.34.1

