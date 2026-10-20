Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467342;
	b=0tJZCQHN81K3y0Fszw1TC59fHGGz3VuJMUivIL8pxfncGPJfkO2uYw4SpNhKr1J4vxWK
	 gkk3NnclyAtv+vp4ZGu3xa3tjmOQP72SZLGowzkcOe0vHA7Ux0SBy1hhazyYN0Pe1ugie
	 /9M4fT9a8uBY9tS7dvk1uta311GUVHXbUBcbhE/KPj9QpWYrfsgJL9yYWG4stLCPC2MRj
	 YdXukiksLnNv9f2FZ4nOn7Do33u6sjlybhCbjByyLiLZac0gV/ZU5rQ6WNrSDQiKC5CVy
	 NvXf2CVhqEsk7qUxCJoCBRJO7ychw+46AQ3WDxUEBTG9VSX9Pt9DAc90mnwZ7mum82Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467342;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=mDMtfasMIDRqx9JZ0G661KrJEHlSs89jiaCe7dgEIRI=;
	b=d46IbyeDfLkcrDfpZFZ17YcYCcp0vVKrWGLAZ6UKZ91aYwtHIDG8qM3WpcMVxC18W5MU
	 esrNkfmKUihIorDLE7smsP5FAqVLRt35tlnQDCOUhK3MDqbLqma1tZo5TGkSFrDdhw9cc
	 nGIX8nagia+nH4aC++ZG0RZJF9ElITJzL48odAhj1iKx8+vhbFFCZs8QYI0n0xEMy6CBa
	 GBpoMgav9NPKUu+ZUIf4L9nXiJJK8lQ3XkNAz1z5w8akKLXslJ5vfVE+RHCdKZS/zpQFU
	 TJK/b+tpv+cSY9Xud9saKz05jMG6Fz7mhM6IEPYHU2bC2olpBUcuQqeK/ncsLnv8NNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qA1XkcNx;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6A606A319;
	Tue, 20 Oct 2026 03:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC6A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qA1XkcNx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mD
	MtfasMIDRqx9JZ0G661KrJEHlSs89jiaCe7dgEIRI=; b=qA1XkcNx1h082dRCOK
	WQv4Qc/UbDH11GqF/w0b9139Sl7bosyj8JKHQZRtE9PDuQRqVTs4nET1W2CXaFf9
	MUm8Z7vHpUzQhFhq4QUFt0+4UoHImO8jcaVCIB81J2mB+HouOkRxwn0uVaJj1Tqz
	+7oDVf0MLp/cDsHmfnWhfQ/hA=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3l4Bj4dZqigSKBQ--.21731S2;
	Tue, 20 Oct 2026 11:35:00 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v2] ice: Lock TC flower filter list operations
Date: Tue, 20 Oct 2026 11:34:57 +0800
Message-ID: <20261020033457.523151-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wD3l4Bj4dZqigSKBQ--.21731S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw4UXr13KFW7Jr17tr4fKrg_yoW7tw13pF
	Z8J34j9r18Jw15WasrXa17Zrs0gwnYkr43WF95C3Z8Zr4DJF4qgFnrtay5trs5GrW3GFW3
	tF17Zw15A3WDGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3wXhxWrW4WW2FQAA3l

The per-PF TC flower filter list is used without a common lock.  TC flower
add and delete paths traverse the list, send firmware commands, and then
insert or remove and free nodes.  The reset path can concurrently walk the
same list in ice_rem_all_chnl_fltrs() while removing queue-channel filters,
and ice_replay_tc_fltrs() replays the same list after reset.  The reset
state check in the flower handlers is not a synchronization primitive.

The race is reachable by creating or deleting a TC flower filter while
service work handles a reset and removes queue channels.  A flower
operation can obtain a filter node before reset teardown removes and frees
it, or reset/replay can traverse a list concurrently modified by flower
control operations.

This can produce a KASAN use-after-free, hlist corruption, stale filter
state after replay, or a panic.  Firmware commands are slow-path
operations, so mutual exclusion is appropriate here.

Add a per-PF mutex and hold it across each list lookup, firmware operation,
list update, and free.  This keeps every reader of the filter list stable
while an entry is being added, removed, or replayed.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection. Due to a lack
of hardware infrastructure. The issue was not observed at runtime.
It is identified by code inspection only.

Fixes: 9fea749856d1 ("ice: Add tc-flower filter support for channel")
Assisted-by: GLM-5.3 coccinelle
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 drivers/net/ethernet/intel/ice/ice.h        |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c   |  3 +++
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 26 +++++++++++++++++----
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c..dac14c97bcbc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -643,6 +643,7 @@ struct ice_pf {
 	 */
 	u16 num_dmac_chnl_fltrs;
 	struct hlist_head tc_flower_fltr_list;
+	struct mutex tc_flower_fltr_lock; /* Protect TC flower filters */
 
 	u64 supported_rxdids;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..90031ba17b06 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3877,6 +3877,7 @@ void ice_deinit_pf(struct ice_pf *pf)
 	mutex_destroy(&pf->adev_mutex);
 	mutex_destroy(&pf->sw_mutex);
 	mutex_destroy(&pf->tc_mutex);
+	mutex_destroy(&pf->tc_flower_fltr_lock);
 	mutex_destroy(&pf->avail_q_mutex);
 	mutex_destroy(&pf->vfs.table_lock);
 
@@ -3976,6 +3977,7 @@ int ice_init_pf(struct ice_pf *pf)
 
 	mutex_init(&pf->sw_mutex);
 	mutex_init(&pf->tc_mutex);
+	mutex_init(&pf->tc_flower_fltr_lock);
 	mutex_init(&pf->adev_mutex);
 	mutex_init(&pf->lag_mutex);
 
@@ -8882,6 +8884,7 @@ static void ice_rem_all_chnl_fltrs(struct ice_pf *pf)
 		hlist_del(&fltr->tc_flower_node);
 		kfree(fltr);
 	}
+	mutex_lock(&pf->tc_flower_fltr_lock);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index d20357c04127..955ad3cc5417 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -2276,21 +2276,29 @@ int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 		return -EINVAL;
 	}
 
+	mutex_lock(&pf->tc_flower_fltr_lock);
+
 	/* avoid duplicate entries, if exists - return error */
 	fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
 	if (fltr) {
 		NL_SET_ERR_MSG_MOD(extack, "filter cookie already exists, ignoring");
+		mutex_unlock(&pf->tc_flower_fltr_lock);
 		return -EEXIST;
 	}
 
 	/* prep and add TC-flower filter in HW */
 	err = ice_add_tc_fltr(netdev, vsi, cls_flower, &fltr, ingress);
 	if (err)
-		return err;
+		goto unlock;
 
 	/* add filter into an ordered list */
 	hlist_add_head(&fltr->tc_flower_node, &pf->tc_flower_fltr_list);
+	mutex_unlock(&pf->tc_flower_fltr_lock);
 	return 0;
+
+unlock:
+	mutex_unlock(&pf->tc_flower_fltr_lock);
+	return err;
 }
 
 /**
@@ -2305,28 +2313,36 @@ ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower)
 	struct ice_pf *pf = vsi->back;
 	int err;
 
+	mutex_lock(&pf->tc_flower_fltr_lock);
+
 	/* find filter */
 	fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
 	if (!fltr) {
 		if (!test_bit(ICE_FLAG_TC_MQPRIO, pf->flags) &&
-		    hlist_empty(&pf->tc_flower_fltr_list))
-			return 0;
+		    hlist_empty(&pf->tc_flower_fltr_list)) {
+				mutex_unlock(&pf->tc_flower_fltr_lock);
+				return 0;
+		}
 
 		NL_SET_ERR_MSG_MOD(cls_flower->common.extack, "failed to delete TC flower filter because unable to find it");
+		mutex_unlock(&pf->tc_flower_fltr_lock);
 		return -EINVAL;
 	}
 
 	fltr->extack = cls_flower->common.extack;
 	/* delete filter from HW */
 	err = ice_del_tc_fltr(vsi, fltr);
-	if (err)
+	if (err) {
+		mutex_unlock(&pf->tc_flower_fltr_lock);
 		return err;
+	}
 
 	/* delete filter from an ordered list */
 	hlist_del(&fltr->tc_flower_node);
 
 	/* free the filter node */
 	kfree(fltr);
+	mutex_unlock(&pf->tc_flower_fltr_lock);
 
 	return 0;
 }
@@ -2340,10 +2356,12 @@ void ice_replay_tc_fltrs(struct ice_pf *pf)
 	struct ice_tc_flower_fltr *fltr;
 	struct hlist_node *node;
 
+	mutex_lock(&pf->tc_flower_fltr_lock);
 	hlist_for_each_entry_safe(fltr, node,
 				  &pf->tc_flower_fltr_list,
 				  tc_flower_node) {
 		fltr->extack = NULL;
 		ice_add_switch_fltr(fltr->src_vsi, fltr);
 	}
+	mutex_unlock(&pf->tc_flower_fltr_lock);
 }
-- 
2.43.0

