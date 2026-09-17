Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com [209.85.167.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5E440A19
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627576; cv=none; b=D+4V5oXcyD8mslrKu3MWtpY/axFohDg+WFJhjcex625zKO+NXDLLxsFHp7JgPdw2jbUKSfNRnSIv11e9pk1d43y7aklVJAb0no4E55gu+K5EU8I0EiY4rWZAJ+SnZfDx6CYwUPvi0DHbJ7eyGXFzW9wiNAvD1ntpyH0OYzEMkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627576; c=relaxed/simple;
	bh=+neVQHy/a/XpTpeXkgvVEjnXSohEwN5Mxj/PeYy6YL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYH6/LDOrqkQIivhHHgJt02gnDH052EgiV7ZqKatEwTL4wl2PUg/LW+5Qc2MlEcHQl8UNwr3Jhd0Bs/QeCEUgRhvq5+N3GfmXCpDWs4pHt1twThZ+ZcjXxCfq8Irv762dL7qtVz8HpJsj81sOqINk2iUa9khqbxsACkiztRVXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GXWnxi9o; arc=none smtp.client-ip=209.85.167.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GXWnxi9o"
Received: by mail-oi1-f225.google.com with SMTP id 5614622812f47-4c6006e2428so190182b6e.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627573; x=1790232373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OdtHI0n4iqvwr04IuorftxO7ZjIWxdozmmIlywJMFHA=;
        b=cDTUqjOJSB0Hj1JI4TGpM5vvNk70dnSTmRsnCswLOQ4GleCmA9CE5vBU09yrW7KHqG
         xDKGwdJDzc8KYMrSJcA7hstfYBhI/wC4ZQGS8Asgg6KaulWUUEcoYBLczy2ozRHKUfjx
         +cBhvQxaJpLhOojz7sgAj/IUxWppAY1gqmGEzjtLlJ84vQ+g51dxkcFuO35KCOaw+GXH
         8XxIhlK13ml5JQIUWuNmMznFLef/pvpc40QLnixTArt15UgeFHUmE881ZSZsbm1KEDp5
         gaXTuZDF1hOnymNVN7bMu9TjStjt/e9qeR5kRzOQnCclXYxODVgPhba630ZQrXIu+tuP
         9jEA==
X-Gm-Message-State: AFuF++nE5gwj18SJn0XFPS0qztg/4P0uUP2eRZA3PxrwlHe/ycQ1JV0g
	P7Fmu/h8K9IHq5sdNvOt8xIbDI6ZXrDif4hvlj6c00QBwQFv9bw0a681vXygEqgzgXDPCkylSKB
	8e0N83IDQjAoQA/M/tg6VIWGw18syUsI7jLdyHy6wXcpaf0aid/BP+1tJCnuU9ubOnYa2lo9MKq
	bQ4tmBvn4vn0EUWVSBrRIC/dtX3agZBSAEejjwCHQfEqr4wth/b0Vl3RbGIIGKAMtu+NMD1wnWw
	OIiz6Zvig==
X-Gm-Gg: AYBFou32tC2e65eUnw9tyzR7bj7NDWSpz5/Z2pWC3gGv4XzJO6WzNjzlK0J+vcrEVw8
	tgdA/xpfbfb8ktRunuS6xuY3tuM175bLPE9kEiTSWCngELYD7xdAPs6N9US7elw6ELytfiG1yzx
	iJJxojPJNuAj49HZ7h18VzZK5IpqQfyTR+SYP1pTrs06pJpkBfsmuE7lArRbOdn1budd/CPUcNu
	u/zQxbQUajznAkE65rHljq3tXHkjl0EpLcqXh2U6RhC77AC+Lv5Tcxtacp64hYX7PwVw4yiOmQ0
	nlEvTam0i+TQ0Byirwf1zUfGEC6Vn7YWEoA4/MM24EtPEX48UeQeIDq9bMrvaWHOTnOMY74Ulew
	eY+HdHeLRBXeXIWi3m+6zdUvbKuIli75JeR0WAroBP/4ngzPhcjtXUFgMkT6KSd3kNAOeX6DsXJ
	c0El3K6W8Xa+GuEaiSgdguIPriVZdw95JRdg==
X-Received: by 2002:a05:6808:1204:b0:4b9:e6ab:d07c with SMTP id 5614622812f47-4ca4bc76895mr6019559b6e.28.1789627572558;
        Wed, 16 Sep 2026 23:46:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-80c43e5d5e1sm1089174a34.1.2026.09.16.23.46.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 23:46:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8538a72b430so679688b3a.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789627571; x=1790232371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OdtHI0n4iqvwr04IuorftxO7ZjIWxdozmmIlywJMFHA=;
        b=GXWnxi9ocu/J/RAvOUve9oZhK25LVylluLNwghsX9h4Nny9KXOtBMqsSNCZW48YqFr
         408RIPxLSwuFj0EhWBAj3J4zmWU+aLXYHnKefaxI0jyjBWapdTdghrMJIfpX0s7q0whz
         Ufzv8ryzjeMdH5fmZFbwdCzMEmES5ZzRUBEvA=
X-Received: by 2002:a05:6a00:ad84:b0:869:c368:3675 with SMTP id d2e1a72fcca58-87238f94fb7mr12002181b3a.17.1789627570524;
        Wed, 16 Sep 2026 23:46:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:ad84:b0:869:c368:3675 with SMTP id d2e1a72fcca58-87238f94fb7mr12002138b3a.17.1789627569971;
        Wed, 16 Sep 2026 23:46:09 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm2754293a12.20.2026.09.16.23.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:46:09 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [net-next, v3 02/11] bnge: restructure VNIC and filter code
Date: Thu, 17 Sep 2026 12:15:39 +0530
Message-ID: <20260917064548.773334-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917064548.773334-1-vikas.gupta@broadcom.com>
References: <20260917064548.773334-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Move VNIC and L2 filter code out of bnge_netdev.c into dedicated
bnge_vnic.c/h and bnge_filter.c/h files in preparation for multi-VNIC,
RSS context, and NTUPLE filter support.

This is a code reorganization with no functional change, which helps
centralize the functions into their respective modules.

Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   4 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   7 -
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 113 ++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  54 ++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   2 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 170 +-----------------
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  72 --------
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  31 +---
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    | 100 +++++++++++
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  62 +++++++
 11 files changed, 345 insertions(+), 272 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index 8e07cb307d21..d0a3cb24dc1d 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -12,4 +12,6 @@ bng_en-y := bnge_core.o \
 	    bnge_ethtool.o \
 	    bnge_auxr.o \
 	    bnge_txrx.o \
-	    bnge_link.o
+	    bnge_link.o \
+	    bnge_vnic.o \
+	    bnge_filter.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 4479ccd071f5..bde54ba5d50f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -163,13 +163,6 @@ struct bnge_dev {
 #define BNGE_L2_FLTR_MAX_FLTR	1024
 
 	u32			*rss_indir_tbl;
-#define BNGE_RSS_TABLE_ENTRIES	64
-#define BNGE_RSS_TABLE_SIZE		(BNGE_RSS_TABLE_ENTRIES * 4)
-#define BNGE_RSS_TABLE_MAX_TBL	8
-#define BNGE_MAX_RSS_TABLE_SIZE				\
-	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
-#define BNGE_MAX_RSS_TABLE_ENTRIES				\
-	(BNGE_RSS_TABLE_ENTRIES * BNGE_RSS_TABLE_MAX_TBL)
 	u16			rss_indir_tbl_entries;
 
 	u32			rss_cap;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
new file mode 100644
index 000000000000..d1279a4babcd
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2026 Broadcom.
+
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/jhash.h>
+
+#include "bnge.h"
+#include "bnge_netdev.h"
+#include "bnge_vnic.h"
+#include "bnge_hwrm_lib.h"
+#include "bnge_filter.h"
+
+void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
+{
+	if (!refcount_dec_and_test(&fltr->refcnt))
+		return;
+	hlist_del_rcu(&fltr->base.hlist);
+	kfree_rcu(fltr, base.rcu);
+}
+
+static void bnge_init_l2_filter(struct bnge_net *bn,
+				struct bnge_l2_filter *fltr,
+				struct bnge_l2_key *key, u32 idx)
+{
+	struct hlist_head *head;
+
+	ether_addr_copy(fltr->l2_key.dst_mac_addr, key->dst_mac_addr);
+	fltr->l2_key.vlan = key->vlan;
+	fltr->base.type = BNGE_FLTR_TYPE_L2;
+
+	head = &bn->l2_fltr_hash_tbl[idx];
+	hlist_add_head_rcu(&fltr->base.hlist, head);
+	refcount_set(&fltr->refcnt, 1);
+}
+
+static struct bnge_l2_filter *__bnge_lookup_l2_filter(struct bnge_net *bn,
+						      struct bnge_l2_key *key,
+						      u32 idx)
+{
+	struct bnge_l2_filter *fltr;
+	struct hlist_head *head;
+
+	head = &bn->l2_fltr_hash_tbl[idx];
+	hlist_for_each_entry_rcu(fltr, head, base.hlist) {
+		struct bnge_l2_key *l2_key = &fltr->l2_key;
+
+		if (ether_addr_equal(l2_key->dst_mac_addr, key->dst_mac_addr) &&
+		    l2_key->vlan == key->vlan)
+			return fltr;
+	}
+	return NULL;
+}
+
+struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
+					     struct bnge_l2_key *key,
+					     u32 idx)
+{
+	struct bnge_l2_filter *fltr;
+
+	rcu_read_lock();
+	fltr = __bnge_lookup_l2_filter(bn, key, idx);
+	if (fltr)
+		refcount_inc(&fltr->refcnt);
+	rcu_read_unlock();
+	return fltr;
+}
+
+static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
+						   struct bnge_l2_key *key,
+						   gfp_t gfp)
+{
+	struct bnge_l2_filter *fltr;
+	u32 idx;
+
+	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
+	      BNGE_L2_FLTR_HASH_MASK;
+	fltr = bnge_lookup_l2_filter(bn, key, idx);
+	if (fltr)
+		return fltr;
+
+	fltr = kzalloc_obj(*fltr, gfp);
+	if (!fltr)
+		return ERR_PTR(-ENOMEM);
+
+	bnge_init_l2_filter(bn, fltr, key, idx);
+	return fltr;
+}
+
+int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
+			      const u8 *mac_addr)
+{
+	struct bnge_l2_filter *fltr;
+	struct bnge_l2_key key;
+	int rc;
+
+	ether_addr_copy(key.dst_mac_addr, mac_addr);
+	key.vlan = 0;
+	fltr = bnge_alloc_l2_filter(bn, &key, GFP_KERNEL);
+	if (IS_ERR(fltr))
+		return PTR_ERR(fltr);
+
+	fltr->base.fw_vnic_id = bn->vnic_info[vnic_id].fw_vnic_id;
+	rc = bnge_hwrm_l2_filter_alloc(bn->bd, fltr);
+	if (rc)
+		goto err_del_l2_filter;
+	bn->vnic_info[vnic_id].l2_filters[idx] = fltr;
+	return rc;
+
+err_del_l2_filter:
+	bnge_del_l2_filter(bn, fltr);
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
new file mode 100644
index 000000000000..44ee1357a0ff
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Broadcom */
+
+#ifndef _BNGE_FILTER_H_
+#define _BNGE_FILTER_H_
+
+enum {
+	BNGE_FLTR_TYPE_L2	= 1
+};
+
+enum {
+	BNGE_FLTR_VALID,
+	BNGE_FLTR_FW_DELETED
+};
+
+struct bnge_filter_base {
+	struct hlist_node	hlist;
+	struct list_head	list_node;
+	__le64			filter_id;
+	u8			type;
+	u8			flags;
+	u16			rxq;
+	u16			fw_vnic_id;
+	u16			vf_idx;
+	unsigned long		state;
+
+	struct rcu_head		rcu;
+};
+
+struct bnge_l2_key {
+	union {
+		struct {
+			u8	dst_mac_addr[ETH_ALEN];
+			u16	vlan;
+		};
+		u32	filter_key;
+	};
+};
+
+#define BNGE_L2_KEY_SIZE	(sizeof(struct bnge_l2_key) / 4)
+struct bnge_l2_filter {
+	/* base filter must be the first member */
+	struct bnge_filter_base	base;
+	struct bnge_l2_key	l2_key;
+	refcount_t		refcnt;
+};
+
+void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr);
+struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
+					     struct bnge_l2_key *key,
+					     u32 idx);
+int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
+			      const u8 *mac_addr);
+#endif /* _BNGE_FILTER_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 651c5e783516..91d246c8dcf2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -15,6 +15,8 @@
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
 #include "bnge_netdev.h"
+#include "bnge_vnic.h"
+#include "bnge_filter.h"
 
 static const u16 bnge_async_events_arr[] = {
 	ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE,
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index bf452e390d5b..ae03041c36ac 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -4,6 +4,8 @@
 #ifndef _BNGE_HWRM_LIB_H_
 #define _BNGE_HWRM_LIB_H_
 
+struct bnge_l2_filter;
+
 #define BNGE_PLC_EN_JUMBO_THRES_VALID		\
 	VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_THRESH_VALID
 #define BNGE_PLC_EN_HDS_THRES_VALID		\
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a4288f0258f8..9e64b1933c02 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -25,6 +25,8 @@
 #include "bnge_ethtool.h"
 #include "bnge_rmem.h"
 #include "bnge_txrx.h"
+#include "bnge_vnic.h"
+#include "bnge_filter.h"
 
 #define BNGE_RING_TO_TC_OFF(bd, tx)	\
 	((tx) % (bd)->tx_nr_rings_per_tc)
@@ -1977,174 +1979,6 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 	return rc;
 }
 
-void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic)
-{
-	__le16 *ring_tbl = vnic->rss_table;
-	struct bnge_rx_ring_info *rxr;
-	struct bnge_dev *bd = bn->bd;
-	u16 tbl_size, i;
-
-	tbl_size = bnge_get_rxfh_indir_size(bd);
-
-	for (i = 0; i < tbl_size; i++) {
-		u32 j;
-
-		j = bd->rss_indir_tbl[i];
-		rxr = &bn->rx_ring[j];
-
-		*ring_tbl++ = cpu_to_le16(rxr->rx_ring_struct.fw_ring_id);
-		*ring_tbl++ = cpu_to_le16(bnge_cp_ring_for_rx(rxr));
-	}
-}
-
-static int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
-				  struct bnge_vnic_info *vnic)
-{
-	int rc;
-
-	rc = bnge_hwrm_vnic_set_rss(bn, vnic, true);
-	if (rc) {
-		netdev_err(bn->netdev, "hwrm vnic %d set rss failure rc: %d\n",
-			   vnic->vnic_id, rc);
-		return rc;
-	}
-	rc = bnge_hwrm_vnic_cfg(bn, vnic);
-	if (rc)
-		netdev_err(bn->netdev, "hwrm vnic %d cfg failure rc: %d\n",
-			   vnic->vnic_id, rc);
-	return rc;
-}
-
-static int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
-{
-	struct bnge_dev *bd = bn->bd;
-	int rc, i, nr_ctxs;
-
-	nr_ctxs = bnge_cal_nr_rss_ctxs(bd->rx_nr_rings);
-	for (i = 0; i < nr_ctxs; i++) {
-		rc = bnge_hwrm_vnic_ctx_alloc(bd, vnic, i);
-		if (rc) {
-			netdev_err(bn->netdev, "hwrm vnic %d ctx %d alloc failure rc: %d\n",
-				   vnic->vnic_id, i, rc);
-			return -ENOMEM;
-		}
-		bn->rsscos_nr_ctxs++;
-	}
-
-	rc = bnge_hwrm_vnic_rss_cfg(bn, vnic);
-	if (rc)
-		return rc;
-
-	if (bnge_is_agg_reqd(bd)) {
-		rc = bnge_hwrm_vnic_set_hds(bn, vnic);
-		if (rc)
-			netdev_err(bn->netdev, "hwrm vnic %d set hds failure rc: %d\n",
-				   vnic->vnic_id, rc);
-	}
-	return rc;
-}
-
-static void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
-{
-	if (!refcount_dec_and_test(&fltr->refcnt))
-		return;
-	hlist_del_rcu(&fltr->base.hash);
-	kfree_rcu(fltr, base.rcu);
-}
-
-static void bnge_init_l2_filter(struct bnge_net *bn,
-				struct bnge_l2_filter *fltr,
-				struct bnge_l2_key *key, u32 idx)
-{
-	struct hlist_head *head;
-
-	ether_addr_copy(fltr->l2_key.dst_mac_addr, key->dst_mac_addr);
-	fltr->l2_key.vlan = key->vlan;
-	fltr->base.type = BNGE_FLTR_TYPE_L2;
-
-	head = &bn->l2_fltr_hash_tbl[idx];
-	hlist_add_head_rcu(&fltr->base.hash, head);
-	refcount_set(&fltr->refcnt, 1);
-}
-
-static struct bnge_l2_filter *__bnge_lookup_l2_filter(struct bnge_net *bn,
-						      struct bnge_l2_key *key,
-						      u32 idx)
-{
-	struct bnge_l2_filter *fltr;
-	struct hlist_head *head;
-
-	head = &bn->l2_fltr_hash_tbl[idx];
-	hlist_for_each_entry_rcu(fltr, head, base.hash) {
-		struct bnge_l2_key *l2_key = &fltr->l2_key;
-
-		if (ether_addr_equal(l2_key->dst_mac_addr, key->dst_mac_addr) &&
-		    l2_key->vlan == key->vlan)
-			return fltr;
-	}
-	return NULL;
-}
-
-static struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
-						    struct bnge_l2_key *key,
-						    u32 idx)
-{
-	struct bnge_l2_filter *fltr;
-
-	rcu_read_lock();
-	fltr = __bnge_lookup_l2_filter(bn, key, idx);
-	if (fltr)
-		refcount_inc(&fltr->refcnt);
-	rcu_read_unlock();
-	return fltr;
-}
-
-static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
-						   struct bnge_l2_key *key,
-						   gfp_t gfp)
-{
-	struct bnge_l2_filter *fltr;
-	u32 idx;
-
-	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
-	      BNGE_L2_FLTR_HASH_MASK;
-	fltr = bnge_lookup_l2_filter(bn, key, idx);
-	if (fltr)
-		return fltr;
-
-	fltr = kzalloc_obj(*fltr, gfp);
-	if (!fltr)
-		return ERR_PTR(-ENOMEM);
-
-	bnge_init_l2_filter(bn, fltr, key, idx);
-	return fltr;
-}
-
-static int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
-				     const u8 *mac_addr)
-{
-	struct bnge_l2_filter *fltr;
-	struct bnge_l2_key key;
-	int rc;
-
-	ether_addr_copy(key.dst_mac_addr, mac_addr);
-	key.vlan = 0;
-	fltr = bnge_alloc_l2_filter(bn, &key, GFP_KERNEL);
-	if (IS_ERR(fltr))
-		return PTR_ERR(fltr);
-
-	fltr->base.fw_vnic_id = bn->vnic_info[vnic_id].fw_vnic_id;
-	rc = bnge_hwrm_l2_filter_alloc(bn->bd, fltr);
-	if (rc)
-		goto err_del_l2_filter;
-	bn->vnic_info[vnic_id].l2_filters[idx] = fltr;
-	return rc;
-
-err_del_l2_filter:
-	bnge_del_l2_filter(bn, fltr);
-	return rc;
-}
-
 static bool bnge_mc_list_updated(struct bnge_net *bn, u32 *rx_mask,
 				 const struct netdev_hw_addr_list *mc)
 {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 476b5bab96fe..ee649cc644db 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -558,8 +558,6 @@ struct bnge_napi {
 };
 
 #define INVALID_STATS_CTX_ID	-1
-#define BNGE_VNIC_DEFAULT	0
-#define BNGE_MAX_UC_ADDRS	4
 
 #define BNGE_RX_MASK_CFG_FLAGS				\
 	(CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS |	\
@@ -567,78 +565,8 @@ struct bnge_napi {
 	 CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST |	\
 	 CFA_L2_SET_RX_MASK_REQ_MASK_BCAST)
 
-struct bnge_vnic_info {
-	u16		fw_vnic_id;
-#define BNGE_MAX_CTX_PER_VNIC	8
-	u16		fw_rss_cos_lb_ctx[BNGE_MAX_CTX_PER_VNIC];
-	u16		mru;
-	/* index 0 always dev_addr */
-	struct bnge_l2_filter *l2_filters[BNGE_MAX_UC_ADDRS];
-	u16		uc_filter_count;
-	u8		*uc_list;
-	dma_addr_t	rss_table_dma_addr;
-	__le16		*rss_table;
-	dma_addr_t	rss_hash_key_dma_addr;
-	u64		*rss_hash_key;
-	int		rss_table_size;
-#define BNGE_RSS_TABLE_ENTRIES		64
-#define BNGE_RSS_TABLE_SIZE		(BNGE_RSS_TABLE_ENTRIES * 4)
-#define BNGE_RSS_TABLE_MAX_TBL		8
-#define BNGE_MAX_RSS_TABLE_SIZE			\
-	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
-	u32		rx_mask;
-
-	u8		*mc_list;
-	int		mc_list_size;
-	int		mc_list_count;
-	dma_addr_t	mc_list_mapping;
-#define BNGE_MAX_MC_ADDRS	16
-
-	u32		flags;
-#define BNGE_VNIC_RSS_FLAG	1
-#define BNGE_VNIC_MCAST_FLAG	4
-#define BNGE_VNIC_UCAST_FLAG	8
-	u32		vnic_id;
-};
-
-struct bnge_filter_base {
-	struct hlist_node	hash;
-	struct list_head	list;
-	__le64			filter_id;
-	u8			type;
-#define BNGE_FLTR_TYPE_L2	2
-	u8			flags;
-	u16			rxq;
-	u16			fw_vnic_id;
-	u16			vf_idx;
-	unsigned long		state;
-#define BNGE_FLTR_VALID		0
-#define BNGE_FLTR_FW_DELETED	2
-
-	struct rcu_head         rcu;
-};
-
-struct bnge_l2_key {
-	union {
-		struct {
-			u8	dst_mac_addr[ETH_ALEN];
-			u16	vlan;
-		};
-		u32	filter_key;
-	};
-};
-
-#define BNGE_L2_KEY_SIZE	(sizeof(struct bnge_l2_key) / 4)
-struct bnge_l2_filter {
-	/* base filter must be the first member */
-	struct bnge_filter_base	base;
-	struct bnge_l2_key	l2_key;
-	refcount_t		refcnt;
-};
-
 u32 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
 u32 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
-void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
 int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 		       u16 prod, gfp_t gfp);
 u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 4711dd4945ff..69a894b52485 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -11,6 +11,7 @@
 #include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_resc.h"
+#include "bnge_vnic.h"
 
 static u16 bnge_num_tx_to_cp(struct bnge_dev *bd, u16 tx)
 {
@@ -186,13 +187,13 @@ int bnge_cal_nr_rss_ctxs(u16 rx_rings)
 				   BNGE_RSS_TABLE_ENTRIES);
 }
 
-static u16 bnge_rss_ctxs_in_use(struct bnge_dev *bd,
-				struct bnge_hw_rings *hwr)
+static u16 bnge_get_total_rss_ctxs(struct bnge_dev *bd,
+				   struct bnge_hw_rings *hwr)
 {
 	return bnge_cal_nr_rss_ctxs(hwr->grp);
 }
 
-static u16 bnge_get_total_vnics(struct bnge_dev *bd, u16 rx_rings)
+static u16 bnge_get_total_vnics(struct bnge_dev *bd)
 {
 	return 1;
 }
@@ -203,24 +204,6 @@ u32 bnge_get_rxfh_indir_size(struct bnge_dev *bd)
 	       BNGE_RSS_TABLE_ENTRIES;
 }
 
-static void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd)
-{
-	u16 max_entries, pad;
-	u32 *rss_indir_tbl;
-	int i;
-
-	max_entries = bnge_get_rxfh_indir_size(bd);
-	rss_indir_tbl = &bd->rss_indir_tbl[0];
-
-	for (i = 0; i < max_entries; i++)
-		rss_indir_tbl[i] = ethtool_rxfh_indir_default(i,
-							      bd->rx_nr_rings);
-
-	pad = bd->rss_indir_tbl_entries - max_entries;
-	if (pad)
-		memset(&rss_indir_tbl[i], 0, pad * sizeof(*rss_indir_tbl));
-}
-
 static void bnge_copy_reserved_rings(struct bnge_dev *bd,
 				     struct bnge_hw_rings *hwr)
 {
@@ -253,7 +236,7 @@ static bool bnge_need_reserve_rings(struct bnge_dev *bd)
 	if (hw_resc->resv_tx_rings != bd->tx_nr_rings)
 		return true;
 
-	vnic = bnge_get_total_vnics(bd, rx);
+	vnic = bnge_get_total_vnics(bd);
 
 	if (bnge_is_agg_reqd(bd))
 		rx <<= 1;
@@ -299,12 +282,12 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 		sh = true;
 	hwr.cmpl = hwr.rx + hwr.tx;
 
-	hwr.vnic = bnge_get_total_vnics(bd, hwr.rx);
+	hwr.vnic = bnge_get_total_vnics(bd);
 
 	if (bnge_is_agg_reqd(bd))
 		hwr.rx <<= 1;
 	hwr.grp = bd->rx_nr_rings;
-	hwr.rss_ctx = bnge_rss_ctxs_in_use(bd, &hwr);
+	hwr.rss_ctx = bnge_get_total_rss_ctxs(bd, &hwr);
 	hwr.stat = bnge_func_stat_ctxs_demand(bd);
 	old_rx_rings = bd->hw_resc.resv_rx_rings;
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
new file mode 100644
index 000000000000..80b4ad77c659
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2026 Broadcom.
+
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/ethtool.h>
+
+#include "bnge.h"
+#include "bnge_netdev.h"
+#include "bnge_vnic.h"
+#include "bnge_hwrm_lib.h"
+#include "bnge_filter.h"
+#include "bnge_ethtool.h"
+
+void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd)
+{
+	u16 max_entries, pad;
+	u32 *rss_indir_tbl;
+	u16 i;
+
+	max_entries = bnge_get_rxfh_indir_size(bd);
+	rss_indir_tbl = &bd->rss_indir_tbl[0];
+
+	for (i = 0; i < max_entries; i++)
+		rss_indir_tbl[i] = ethtool_rxfh_indir_default(i,
+							      bd->rx_nr_rings);
+
+	pad = bd->rss_indir_tbl_entries - max_entries;
+	if (pad)
+		memset(&rss_indir_tbl[i], 0, pad * sizeof(*rss_indir_tbl));
+}
+
+void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic)
+{
+	__le16 *ring_tbl = vnic->rss_table;
+	struct bnge_rx_ring_info *rxr;
+	struct bnge_dev *bd = bn->bd;
+	u16 tbl_size, i;
+
+	tbl_size = bnge_get_rxfh_indir_size(bd);
+
+	for (i = 0; i < tbl_size; i++) {
+		u16 ring_id, j;
+
+		j = bd->rss_indir_tbl[i];
+		rxr = &bn->rx_ring[j];
+
+		ring_id = rxr->rx_ring_struct.fw_ring_id;
+		*ring_tbl++ = cpu_to_le16(ring_id);
+		ring_id = bnge_cp_ring_for_rx(rxr);
+		*ring_tbl++ = cpu_to_le16(ring_id);
+	}
+}
+
+int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
+			   struct bnge_vnic_info *vnic)
+{
+	int rc;
+
+	rc = bnge_hwrm_vnic_set_rss(bn, vnic, true);
+	if (rc) {
+		netdev_err(bn->netdev, "hwrm vnic %d set rss failure rc: %d\n",
+			   vnic->vnic_id, rc);
+		return rc;
+	}
+	rc = bnge_hwrm_vnic_cfg(bn, vnic);
+	if (rc)
+		netdev_err(bn->netdev, "hwrm vnic %d cfg failure rc: %d\n",
+			   vnic->vnic_id, rc);
+	return rc;
+}
+
+int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic)
+{
+	struct bnge_dev *bd = bn->bd;
+	int rc, i, nr_ctxs;
+
+	nr_ctxs = bnge_cal_nr_rss_ctxs(bd->rx_nr_rings);
+	for (i = 0; i < nr_ctxs; i++) {
+		rc = bnge_hwrm_vnic_ctx_alloc(bd, vnic, i);
+		if (rc) {
+			netdev_err(bn->netdev, "hwrm vnic %d ctx %d alloc failure rc: %d\n",
+				   vnic->vnic_id, i, rc);
+			return -ENOMEM;
+		}
+		bn->rsscos_nr_ctxs++;
+	}
+
+	rc = bnge_hwrm_vnic_rss_cfg(bn, vnic);
+	if (rc)
+		return rc;
+
+	if (bnge_is_agg_reqd(bd)) {
+		rc = bnge_hwrm_vnic_set_hds(bn, vnic);
+		if (rc)
+			netdev_err(bn->netdev, "hwrm vnic %d set hds failure rc: %d\n",
+				   vnic->vnic_id, rc);
+	}
+	return rc;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
new file mode 100644
index 000000000000..30281e26f39f
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Broadcom */
+
+#ifndef _BNGE_VNIC_H_
+#define _BNGE_VNIC_H_
+
+struct bnge_net;
+struct bnge_l2_filter;
+
+#define BNGE_RSS_TABLE_ENTRIES		64
+#define BNGE_RSS_TABLE_SIZE		(BNGE_RSS_TABLE_ENTRIES * 4)
+#define BNGE_RSS_TABLE_MAX_TBL		8
+#define BNGE_MAX_RSS_TABLE_SIZE			\
+	(BNGE_RSS_TABLE_SIZE * BNGE_RSS_TABLE_MAX_TBL)
+#define BNGE_MAX_RSS_TABLE_ENTRIES				\
+	(BNGE_RSS_TABLE_ENTRIES * BNGE_RSS_TABLE_MAX_TBL)
+
+#define BNGE_MAX_CTX_PER_VNIC	8
+
+#define BNGE_MAX_MC_ADDRS	16
+#define BNGE_MAX_UC_ADDRS	4
+
+enum {
+	BNGE_VNIC_DEFAULT	= 0
+};
+
+enum {
+	BNGE_VNIC_RSS_FLAG	= BIT(0),
+	BNGE_VNIC_MCAST_FLAG	= BIT(1),
+	BNGE_VNIC_UCAST_FLAG	= BIT(2)
+};
+
+struct bnge_vnic_info {
+	u16		fw_vnic_id;
+	u16		fw_rss_cos_lb_ctx[BNGE_MAX_CTX_PER_VNIC];
+	u16		mru;
+	/* index 0 always dev_addr */
+	struct bnge_l2_filter *l2_filters[BNGE_MAX_UC_ADDRS];
+	u16		uc_filter_count;
+	u8		*uc_list;
+	dma_addr_t	rss_table_dma_addr;
+	__le16		*rss_table;
+	dma_addr_t	rss_hash_key_dma_addr;
+	u64		*rss_hash_key;
+	int		rss_table_size;
+	u32		rx_mask;
+
+	u8		*mc_list;
+	int		mc_list_size;
+	int		mc_list_count;
+	dma_addr_t	mc_list_mapping;
+
+	u32		flags;
+	u32		vnic_id;
+};
+
+void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
+int bnge_hwrm_vnic_rss_cfg(struct bnge_net *bn,
+			   struct bnge_vnic_info *vnic);
+int bnge_setup_vnic(struct bnge_net *bn, struct bnge_vnic_info *vnic);
+void bnge_set_dflt_rss_indir_tbl(struct bnge_dev *bd);
+#endif /* _BNGE_VNIC_H_ */
-- 
2.52.0

