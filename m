Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467213;
	b=F+QH+IsGELokQL8+LkRSd+EwgUBfwa0JjI3M+MKPJhPr2/sO1q2Ehjp1Vfl7zGPJaQLl
	 as1l0AAlhyZYvywDsfpQaw5yZ3eskY0TZN5tOQYfHRiePoTnIwOAsZTOL2xI+bv1efVpm
	 8inUsxbhKnBoJ7u9udgUHgVhjP3t5M3TPpw9RKLYTJg5NBwAAGByItZWHQiQJYJc61vuV
	 6fqfRoRmR52XNFIGAifS0HcOe773WF3qzPqrby6T3Jm0bU7Kq4LSzj96LdlWqvtYpYpCN
	 VAgA1bKnEDTkgy9AGbWJeeJtH5lQBR1Gv/RUw4qVJJe8ucA9ZnXLfZwQx3J4Ca7gaLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467213;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CjIRWE6TQ7/W5lfKi5fjb7V3GBfojCU+K/Wrc9kZoRQ=;
	b=Dxsg8OqU/xiazM4t8UHl1MWRbMUcroU0xHU8KnknKMlyIZZYUfwUPf2BV0T7NvUZVNtW
	 Iou1yDaqoFKnrlJnR8KqQtOjm8d3xbaNFXLHNY876ArtYVQPYwHkmDkZTC5mLZbUM1nNc
	 XkATL3U3YAFhSOJwhkFOc7gT+UZZLymZZ/E2oN1XAGt7w+vuIntxdGAPI5oYBda/U+y6g
	 9yy3ScFtdkcsm/VkXlBS3jj5LMxI1pI5ddimzVdxrhbYtE8qgy0X3UHTaOKDDkcp9t3g/
	 kVS9etSRtIir+8PJXpBC+cVuu+4ClWDPk1mH1cNvaIs09n7KwnQxsoQaS11EqFJ2TkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=l2lzkRTc;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847D606A319;
	Tue, 20 Oct 2026 03:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6847D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=l2lzkRTc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Cj
	IRWE6TQ7/W5lfKi5fjb7V3GBfojCU+K/Wrc9kZoRQ=; b=l2lzkRTcny7+zz7Yf9
	hTLQEO1Bwfz61xOa0No0liA/QKoRJdQD+pOmtNPj8Oq9UsHkNi34Ws9Hr2VUK7kK
	ugYQ63csDii267OLpy1VsXhJ6caqQG8cFOVvGh2uCuPB1MUA2eR32ebZ98cWvY4f
	0CHS3C5+KOIaELUWcthHjcWmg=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA39Xji4NZqukytAw--.48022S2;
	Tue, 20 Oct 2026 11:32:52 +0800 (CST)
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
Subject: [PATCH v1] ice: Lock TC flower filter list operations
Date: Tue, 20 Oct 2026 11:32:48 +0800
Message-ID: <20261020033248.522973-1-18983559317@163.com>
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
X-CM-TRANSID:PygvCgA39Xji4NZqukytAw--.48022S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw4UXr13KFWrKw4ruw45Jrb_yoW7tw1xpF
	Z8J34j9r18Jw15WasrXa17Zrs0gwnYkr43WF95C3Z8Zr4DJF4qgFnrtay5trs5GrW3GFW3
	tF17Zw15A3WDGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC+wTBpWrW4OQbLQAA3V

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
of hardware infrastructureThe issue was not observed at runtime.
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

