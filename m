Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BE2F7EE3
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670129; cv=none; b=WMqPtpYYKSKVbgBxtfi5bYwyZ/rdR/b+CdWCh290crd8aMKbfayA1+PYrm1mSxUPzke4rhYejvnd9HvTw6N9Wn6OeCx3AUn4ff2WxaGWBjQKuxPF8QsrjtiQO33+bLBwYYW5jWWsEndWDhJcxWIFgF41xnn6gCxO/j8O8XpHLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670129; c=relaxed/simple;
	bh=zToOyEl7fSqpCqWFhtkwYWo6G2YAH6bRAumrXRAAwNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYA3CL94RSN/E7LD4sGAfaOpQljeNJ0BQSmoSoe8ATBI9RjqV1O4N8BF1GEBeM0+9jzkSuzSNn4UVtuXmJWCuI0CH/pf0TrMPm0fa2xZ6Rlu4Da1Wt+gUYfedQFjLYfP80USDpQuLwDh7kRdVPbnA7g3LXnfrsxIHmo3fP8sgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UK806bJE; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UK806bJE"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso130264e0c.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670126; x=1787274926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T4fgohWXCnHlHKV5AHj2LwGzXAOEDxoFGIjpIELgQAk=;
        b=CTSU3ur/lldjl+/DgOkKGPO6WSjaQbYJ9iiK2dcKPJCbgXXn+TX3ESPLzob8x5SHPx
         azzOj+LT3HBdoCc5mvLj8la/uXQsTzJtF1EhtDdFKHUyMBmt5pn2DBcLMbXH7FZ5thjA
         0ljJs2qAyWWViN1/+1VlYtXGdwfOqsxV5UmasquWZE0qrpM8l9VVFc2c81d5o3ElfNTT
         5VDSPnt8WgC4BweW6jktdPQSUqvwrt28entqID1QF/KvvqMeGa2oSjXareRl+lC5IgP4
         NUc5kSQWQl1PbuEBTqYeQYFFGwWn0atvCrOTYO5KMkRKEQVTuVHoNMBTrY1o/H2XSp29
         1dng==
X-Gm-Message-State: AOJu0YxgJGIrgC+h8cOhKHfixjHT0PiI11eOocNLUo9jhlOw5c3lr5k5
	09A8HX2ta1Hb6jxcg15jkTaIVgGHSRQMBDZaY8/lD99oOso8+SOcaOnUvE+o4UdtWxnSdFTd4If
	6xSArwsSU4j5YANxVrwXsPWBk/yT0ox+RLisWtXPwktuU3aVa6UVUq6NDz8A5kxQYr+G10K4Ibw
	wKsRIdjMvzjn0N/XIiqLBuhqusgf2+jSTi6HTS03k7XVrhG6RoaMQkQy6Us1Xj0GGYdJbsnyHah
	Bmk8tDwLg==
X-Gm-Gg: AR+sD13kPtDocCOSQvvphOgXTc1ET/Zlf4s4i2YCtJeLi2anAI7++XjG1vqUz4O0DYy
	tngHfa8ocGvZ70Fkh/ahbT51DrSVFbGXvuZvK8TDJW3QDJy3LxlWldHyETnupCywqDjAA1wBDG+
	GRg2mQu1MZVMYFVQ4VXv+a6819T2DbW7ZVETc+Zrz9JD7KY7r8/4zwUAJ4t0s4xFhEabuyN7mOI
	S61RiUMDLMf2VI+MGekXYga4SeLOKzHAX0VMZgCs1MBjDI1OFHkWEfX6263vAGeycUIwN8c6SlQ
	Kv5RTZwmXOyYgH9BFdhkkE7oNEktgUWp92kTte44Zl1z1dW0DXFh9iJgEvJljJg3+HmflJpwh3Y
	9GlHIArGZmridsEgEFwz+Br5K9aYYPvRo6R6HB0diYd2Bbh0OHmy1lTjDK+cAryNOUvNaxyf0jV
	keSvgU3md0hVhgDUQQEp1QBKpctT89O7c=
X-Received: by 2002:a05:6122:c91:b0:5c1:2150:9de7 with SMTP id 71dfb90a1353d-5c591f6c8a7mr402432e0c.12.1786670125915;
        Thu, 13 Aug 2026 18:15:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c597bcc31fsm71858e0c.5.2026.08.13.18.15.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 18:15:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so497513a12.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786670125; x=1787274925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4fgohWXCnHlHKV5AHj2LwGzXAOEDxoFGIjpIELgQAk=;
        b=UK806bJEsWouSNq0QxGI5EBjYnotmqxFwl9blVcXYQRv7zgKBI0k3pAlMC/X8d4hhW
         TOxmi+sso8FS5Ozg0aHdm7/MZkXRc0GGgv+z91nRIElMQzQAa3eO1VZNVl8fLY0o55Tu
         swgK1Mdr6jVgAxSLkvp80/yX4dMOjx+PSX0Ps=
X-Received: by 2002:a05:6a21:6e8e:b0:3c3:64cc:311a with SMTP id adf61e73a8af0-3cc71d7a211mr2239976637.22.1786670124210;
        Thu, 13 Aug 2026 18:15:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e8e:b0:3c3:64cc:311a with SMTP id adf61e73a8af0-3cc71d7a211mr2239888637.22.1786670123600;
        Thu, 13 Aug 2026 18:15:23 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm12174177eec.11.2026.08.13.18.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:15:23 -0700 (PDT)
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
Subject: [PATCH net-next 08/11] bnge: add NTUPLE filter infrastructure
Date: Fri, 14 Aug 2026 06:44:32 +0530
Message-ID: <20260814011435.194631-9-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260814011435.194631-1-vikas.gupta@broadcom.com>
References: <20260814011435.194631-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add the core NTUPLE filter data structures and firmware command
wrappers needed for flow rule management.
This helps further patches implement user-created NTUPLE rules
as well as rules via kernel flow steering.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   1 -
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 464 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  69 ++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 143 +++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   7 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  14 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  13 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   4 +-
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    |  14 +
 9 files changed, 719 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index d058737fe2b0..5a1a9186c2cb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -162,7 +162,6 @@ struct bnge_dev {
 	u16			tso_max_segs;
 
 	int			max_fltr;
-#define BNGE_L2_FLTR_MAX_FLTR	1024
 
 	u32			*rss_indir_tbl;
 	u16			rss_indir_tbl_entries;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index 33b75d8fcdeb..47e42033739a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
@@ -4,6 +4,8 @@
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
 #include <linux/jhash.h>
+#include <net/netdev_lock.h>
+#include <net/ipv6.h>
 
 #include "bnge.h"
 #include "bnge_netdev.h"
@@ -11,24 +13,141 @@
 #include "bnge_hwrm_lib.h"
 #include "bnge_filter.h"
 
-void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
+#define BNGE_IPV6_MASK_ALL {{{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, \
+			       0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff }}}
+#define BNGE_IPV6_MASK_NONE {{{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }}}
+
+const struct bnge_flow_masks BNGE_FLOW_MASK_NONE = {
+	.ports = {
+		.src = 0,
+		.dst = 0,
+	},
+	.addrs = {
+		.v6addrs = {
+			.src = BNGE_IPV6_MASK_NONE,
+			.dst = BNGE_IPV6_MASK_NONE,
+		},
+	},
+};
+
+const struct bnge_flow_masks BNGE_FLOW_IPV6_MASK_ALL = {
+	.ports = {
+		.src = cpu_to_be16(0xffff),
+		.dst = cpu_to_be16(0xffff),
+	},
+	.addrs = {
+		.v6addrs = {
+			.src = BNGE_IPV6_MASK_ALL,
+			.dst = BNGE_IPV6_MASK_ALL,
+		},
+	},
+};
+
+const struct bnge_flow_masks BNGE_FLOW_IPV4_MASK_ALL = {
+	.ports = {
+		.src = cpu_to_be16(0xffff),
+		.dst = cpu_to_be16(0xffff),
+	},
+	.addrs = {
+		.v4addrs = {
+			.src = cpu_to_be32(0xffffffff),
+			.dst = cpu_to_be32(0xffffffff),
+		},
+	},
+};
+
+static void bnge_insert_usr_fltr(struct bnge_net *bn,
+				 struct bnge_filter_base *fltr)
+{
+	u8 type = fltr->type, flags = fltr->flags;
+
+	INIT_LIST_HEAD(&fltr->list_node);
+	if ((type == BNGE_FLTR_TYPE_L2 && flags & BNGE_ACT_RING_DST) ||
+	    (type == BNGE_FLTR_TYPE_NTUPLE && flags & BNGE_ACT_NO_AGING)) {
+		list_add_tail(&fltr->list_node, &bn->usr_fltr_list);
+		bn->user_fltr_count++;
+	}
+}
+
+static void bnge_del_usr_fltr_node(struct bnge_net *bn,
+				   struct bnge_filter_base *fltr)
+{
+	if (!list_empty(&fltr->list_node)) {
+		list_del_init(&fltr->list_node);
+		bn->user_fltr_count--;
+	}
+}
+
+void bnge_del_l2_filter_rcu(struct bnge_net *bn, struct bnge_l2_filter *lfltr)
+{
+	struct bnge_filter_base *fltr = &lfltr->base;
+
+	hlist_del_rcu(&fltr->hlist);
+	bnge_del_usr_fltr_node(bn, fltr);
+	clear_bit(fltr->sw_id, bn->l2_fltr_bmap);
+	bn->l2_fltr_count--;
+	kfree_rcu(lfltr, base.rcu);
+}
+
+void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *lfltr)
 {
+	struct bnge_filter_base *fltr = &lfltr->base;
+
+	hlist_del(&fltr->hlist);
+	bnge_del_usr_fltr_node(bn, fltr);
+	clear_bit(fltr->sw_id, bn->l2_fltr_bmap);
+	bn->l2_fltr_count--;
+	kfree(fltr);
+}
+
+void bnge_del_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *nfltr)
+{
+	struct bnge_filter_base *fltr = &nfltr->base;
+
+	hlist_del(&fltr->hlist);
+	bnge_del_usr_fltr_node(bn, fltr);
+	clear_bit(fltr->sw_id, bn->ntp_fltr_bmap);
+	bn->ntp_fltr_count--;
+	kfree(fltr);
+}
+
+void bnge_del_ntp_filter_rcu(struct bnge_net *bn,
+			     struct bnge_ntuple_filter *fltr)
+{
+	spin_lock_bh(&bn->ntp_fltr_lock);
 	hlist_del_rcu(&fltr->base.hlist);
+	bnge_del_usr_fltr_node(bn, &fltr->base);
+	bn->ntp_fltr_count--;
+	spin_unlock_bh(&bn->ntp_fltr_lock);
+
+	clear_bit(fltr->base.sw_id, bn->ntp_fltr_bmap);
 	kfree_rcu(fltr, base.rcu);
 }
 
-static void bnge_init_l2_filter(struct bnge_net *bn,
-				struct bnge_l2_filter *fltr,
-				struct bnge_l2_key *key, u32 idx)
+
+static int bnge_init_l2_filter(struct bnge_net *bn,
+			       struct bnge_l2_filter *fltr,
+			       struct bnge_l2_key *key, u32 idx)
 {
 	struct hlist_head *head;
+	int bit_id;
 
 	ether_addr_copy(fltr->l2_key.dst_mac_addr, key->dst_mac_addr);
 	fltr->l2_key.vlan = key->vlan;
 	fltr->base.type = BNGE_FLTR_TYPE_L2;
 
+	bit_id = bitmap_find_free_region(bn->l2_fltr_bmap,
+					 BNGE_MAX_L2_FLTRS, 0);
+	if (bit_id < 0)
+		return -ENOMEM;
+	fltr->base.sw_id = (u16)bit_id;
+
+	bn->l2_fltr_count++;
+
 	head = &bn->l2_fltr_hash_tbl[idx];
 	hlist_add_head_rcu(&fltr->base.hlist, head);
+	bnge_insert_usr_fltr(bn, &fltr->base);
+	return 0;
 }
 
 struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
@@ -49,12 +168,32 @@ struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
 	return NULL;
 }
 
+u64 bnge_lookup_l2_filter_rcu(struct bnge_net *bn,
+			      struct bnge_l2_key *key,
+			      u32 idx)
+{
+	u64 id = BNGE_FLTR_ID_INVALID;
+	struct bnge_l2_filter *fltr;
+
+	rcu_read_lock();
+	fltr = bnge_lookup_l2_filter(bn, key, idx);
+	if (!fltr)
+		goto exit;
+
+	id = fltr->base.filter_id;
+
+exit:
+	rcu_read_unlock();
+	return id;
+}
+
 static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
 						   struct bnge_l2_key *key,
 						   gfp_t gfp)
 {
 	struct bnge_l2_filter *fltr;
 	u32 idx;
+	int rc;
 
 	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
 	      BNGE_L2_FLTR_HASH_MASK;
@@ -66,10 +205,325 @@ static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
 	if (!fltr)
 		return ERR_PTR(-ENOMEM);
 
-	bnge_init_l2_filter(bn, fltr, key, idx);
+	rc = bnge_init_l2_filter(bn, fltr, key, idx);
+	if (rc) {
+		kfree(fltr);
+		fltr = ERR_PTR(rc);
+	}
+
 	return fltr;
 }
 
+struct bnge_l2_filter *bnge_alloc_user_l2_filter(struct bnge_net *bn,
+						 struct bnge_l2_key *key,
+						 u8 flags)
+{
+	struct bnge_l2_filter *fltr;
+	u32 idx;
+	int rc;
+
+	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
+	      BNGE_L2_FLTR_HASH_MASK;
+	fltr = bnge_lookup_l2_filter(bn, key, idx);
+	if (fltr) {
+		fltr = ERR_PTR(-EEXIST);
+		goto l2_filter_exit;
+	}
+	fltr = kzalloc_obj(*fltr, GFP_ATOMIC);
+	if (!fltr) {
+		fltr = ERR_PTR(-ENOMEM);
+		goto l2_filter_exit;
+	}
+	fltr->base.flags = flags;
+	rc = bnge_init_l2_filter(bn, fltr, key, idx);
+	if (rc) {
+		kfree(fltr);
+		return ERR_PTR(rc);
+	}
+
+l2_filter_exit:
+	return fltr;
+}
+
+void bnge_free_l2_filters(struct bnge_net *bn)
+{
+	int i;
+
+	netdev_assert_locked_or_invisible(bn->netdev);
+
+	for (i = 0; i < BNGE_L2_FLTR_HASH_SIZE; i++) {
+		struct bnge_l2_filter *fltr;
+		struct hlist_head *head;
+		struct hlist_node *tmp;
+
+		head = &bn->l2_fltr_hash_tbl[i];
+		hlist_for_each_entry_safe(fltr, tmp, head, base.hlist)
+			bnge_del_l2_filter(bn, fltr);
+	}
+
+	bitmap_free(bn->l2_fltr_bmap);
+	bn->l2_fltr_bmap = NULL;
+	bn->l2_fltr_count = 0;
+}
+
+void bnge_free_ntp_fltrs(struct bnge_net *bn, bool skip_user)
+{
+	int i;
+
+	netdev_assert_locked_or_invisible(bn->netdev);
+
+	/* Under netdev instance lock and all our NAPIs have been disabled.
+	 * It's safe to delete the hash table.
+	 */
+	for (i = 0; i < BNGE_NTP_FLTR_HASH_SIZE; i++) {
+		struct bnge_ntuple_filter *fltr;
+		struct hlist_head *head;
+		struct hlist_node *tmp;
+
+		head = &bn->ntp_fltr_hash_tbl[i];
+		hlist_for_each_entry_safe(fltr, tmp, head, base.hlist) {
+			if (skip_user && !list_empty(&fltr->base.list_node))
+				continue;
+			bnge_del_ntp_filter(bn, fltr);
+		}
+	}
+
+	if (skip_user)
+		return;
+
+	bitmap_free(bn->ntp_fltr_bmap);
+	bn->ntp_fltr_bmap = NULL;
+	bn->ntp_fltr_count = 0;
+}
+
+static int bnge_alloc_l2_fltrs_mem(struct bnge_net *bn)
+{
+	int i, rc = 0;
+
+	if (bn->l2_fltr_bmap)
+		return 0;
+
+	for (i = 0; i < BNGE_L2_FLTR_HASH_SIZE; i++)
+		INIT_HLIST_HEAD(&bn->l2_fltr_hash_tbl[i]);
+
+	bn->l2_fltr_count = 0;
+	bn->l2_fltr_bmap = bitmap_zalloc(BNGE_MAX_L2_FLTRS, GFP_KERNEL);
+
+	if (!bn->l2_fltr_bmap)
+		rc = -ENOMEM;
+
+	return rc;
+}
+
+static int bnge_alloc_ntp_fltrs_mem(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, rc = 0;
+
+	if (!(bn->priv_flags & BNGE_NET_EN_NTUPLE) || bn->ntp_fltr_bmap)
+		return 0;
+
+	for (i = 0; i < BNGE_NTP_FLTR_HASH_SIZE; i++)
+		INIT_HLIST_HEAD(&bn->ntp_fltr_hash_tbl[i]);
+
+	bn->ntp_fltr_count = 0;
+	bn->ntp_fltr_bmap = bitmap_zalloc(bd->max_fltr, GFP_KERNEL);
+
+	if (!bn->ntp_fltr_bmap)
+		rc = -ENOMEM;
+
+	return rc;
+}
+
+int bnge_fltrs_mem(struct bnge_net *bn)
+{
+	int rc;
+
+	rc = bnge_alloc_ntp_fltrs_mem(bn);
+	if (rc)
+		return rc;
+
+	rc = bnge_alloc_l2_fltrs_mem(bn);
+	if (rc)
+		goto err_free_ntp_mem;
+
+	return 0;
+
+err_free_ntp_mem:
+	bitmap_free(bn->ntp_fltr_bmap);
+	bn->ntp_fltr_bmap = NULL;
+	return rc;
+}
+
+#define BNGE_IPV4_4TUPLE(bd, fkeys)					\
+	(((fkeys)->basic.ip_proto == IPPROTO_TCP &&			\
+	  (bd)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4) ||	\
+	 ((fkeys)->basic.ip_proto == IPPROTO_UDP &&			\
+	  (bd)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV4))
+
+#define BNGE_IPV6_4TUPLE(bd, fkeys)					\
+	(((fkeys)->basic.ip_proto == IPPROTO_TCP &&			\
+	  (bd)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV6) ||	\
+	 ((fkeys)->basic.ip_proto == IPPROTO_UDP &&			\
+	  (bd)->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_UDP_IPV6))
+
+static u32 bnge_get_rss_flow_tuple_len(struct bnge_dev *bd,
+				       struct flow_keys *fkeys)
+{
+	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
+		if (BNGE_IPV4_4TUPLE(bd, fkeys))
+			return sizeof(fkeys->addrs.v4addrs) +
+			       sizeof(fkeys->ports);
+
+		if (bd->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV4)
+			return sizeof(fkeys->addrs.v4addrs);
+	}
+
+	if (fkeys->basic.n_proto == htons(ETH_P_IPV6)) {
+		if (BNGE_IPV6_4TUPLE(bd, fkeys))
+			return sizeof(fkeys->addrs.v6addrs) +
+			       sizeof(fkeys->ports);
+
+		if (bd->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6)
+			return sizeof(fkeys->addrs.v6addrs);
+	}
+
+	return 0;
+}
+
+static u32 bnge_toeplitz(struct bnge_net *bn, struct flow_keys *fkeys,
+			 const unsigned char *key)
+{
+	u64 prefix = bn->toeplitz_prefix, hash = 0;
+	struct bnge_ipv4_tuple tuple4;
+	struct bnge_ipv6_tuple tuple6;
+	struct bnge_dev *bd = bn->bd;
+	u8 *four_tuple;
+	int i, j, len;
+
+	len = bnge_get_rss_flow_tuple_len(bd, fkeys);
+	if (!len)
+		return 0;
+
+	if (fkeys->basic.n_proto == htons(ETH_P_IP)) {
+		tuple4.v4addrs = fkeys->addrs.v4addrs;
+		tuple4.ports = fkeys->ports;
+		four_tuple = (u8 *)&tuple4;
+	} else {
+		tuple6.v6addrs = fkeys->addrs.v6addrs;
+		tuple6.ports = fkeys->ports;
+		four_tuple = (u8 *)&tuple6;
+	}
+
+	for (i = 0, j = 8; i < len; i++, j++) {
+		u8 byte = four_tuple[i];
+		int bit;
+
+		for (bit = 0; bit < 8; bit++, prefix <<= 1, byte <<= 1) {
+			if (byte & 0x80)
+				hash ^= prefix;
+		}
+		prefix |= (j < HW_HASH_KEY_SIZE) ? key[j] : 0;
+	}
+
+	/* The valid part of the hash is in the upper 32 bits. */
+	return (hash >> 32) & BNGE_NTP_FLTR_HASH_MASK;
+}
+
+u32 bnge_get_ntp_filter_idx(struct bnge_net *bn, struct flow_keys *fkeys,
+			    const struct sk_buff *skb)
+{
+	struct bnge_vnic_info *vnic;
+
+	if (skb)
+		return skb_get_hash_raw(skb) & BNGE_NTP_FLTR_HASH_MASK;
+
+	vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	return bnge_toeplitz(bn, fkeys, (void *)vnic->rss_hash_key);
+}
+
+int bnge_insert_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *fltr,
+			   u32 idx)
+{
+	struct hlist_head *head;
+	int bit_id;
+
+	spin_lock_bh(&bn->ntp_fltr_lock);
+	bit_id = bitmap_find_free_region(bn->ntp_fltr_bmap,
+					 bn->bd->max_fltr, 0);
+	if (bit_id < 0) {
+		spin_unlock_bh(&bn->ntp_fltr_lock);
+		return -ENOMEM;
+	}
+
+	fltr->base.sw_id = (u16)bit_id;
+	fltr->base.type = BNGE_FLTR_TYPE_NTUPLE;
+	fltr->base.flags |= BNGE_ACT_RING_DST;
+
+	head = &bn->ntp_fltr_hash_tbl[idx];
+	hlist_add_head_rcu(&fltr->base.hlist, head);
+
+	bnge_insert_usr_fltr(bn, &fltr->base);
+	bn->ntp_fltr_count++;
+
+	spin_unlock_bh(&bn->ntp_fltr_lock);
+
+	return 0;
+}
+
+static bool bnge_fltr_match(struct bnge_ntuple_filter *f1,
+			    struct bnge_ntuple_filter *f2)
+{
+	struct bnge_flow_masks *masks1 = &f1->fmasks;
+	struct bnge_flow_masks *masks2 = &f2->fmasks;
+	struct flow_keys *keys1 = &f1->fkeys;
+	struct flow_keys *keys2 = &f2->fkeys;
+
+	if (keys1->basic.n_proto != keys2->basic.n_proto ||
+	    keys1->basic.ip_proto != keys2->basic.ip_proto)
+		return false;
+
+	if (keys1->basic.n_proto == htons(ETH_P_IP)) {
+		if (keys1->addrs.v4addrs.src != keys2->addrs.v4addrs.src ||
+		    masks1->addrs.v4addrs.src != masks2->addrs.v4addrs.src ||
+		    keys1->addrs.v4addrs.dst != keys2->addrs.v4addrs.dst ||
+		    masks1->addrs.v4addrs.dst != masks2->addrs.v4addrs.dst)
+			return false;
+	} else {
+		if (!ipv6_addr_equal(&keys1->addrs.v6addrs.src,
+				     &keys2->addrs.v6addrs.src) ||
+		    !ipv6_addr_equal(&masks1->addrs.v6addrs.src,
+				     &masks2->addrs.v6addrs.src) ||
+		    !ipv6_addr_equal(&keys1->addrs.v6addrs.dst,
+				     &keys2->addrs.v6addrs.dst) ||
+		    !ipv6_addr_equal(&masks1->addrs.v6addrs.dst,
+				     &masks2->addrs.v6addrs.dst))
+			return false;
+	}
+
+	return keys1->ports.src == keys2->ports.src &&
+	       masks1->ports.src == masks2->ports.src &&
+	       keys1->ports.dst == keys2->ports.dst &&
+	       masks1->ports.dst == masks2->ports.dst &&
+	       keys1->control.flags == keys2->control.flags &&
+	       f1->l2_filter_id == f2->l2_filter_id;
+}
+
+struct bnge_ntuple_filter *
+bnge_lookup_ntp_filter_from_idx(struct bnge_net *bn,
+				struct bnge_ntuple_filter *fltr, u32 idx)
+{
+	struct bnge_ntuple_filter *f;
+	struct hlist_head *head;
+
+	head = &bn->ntp_fltr_hash_tbl[idx];
+	hlist_for_each_entry_rcu(f, head, base.hlist) {
+		if (bnge_fltr_match(f, fltr))
+			return f;
+	}
+	return NULL;
+}
+
 int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
 			      const u8 *mac_addr)
 {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
index 16a5d91517c9..57105e69f95c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -4,8 +4,11 @@
 #ifndef _BNGE_FILTER_H_
 #define _BNGE_FILTER_H_
 
+#include <linux/jhash.h>
+
 enum {
-	BNGE_FLTR_TYPE_L2	= 1
+	BNGE_FLTR_TYPE_L2	= 1,
+	BNGE_FLTR_TYPE_NTUPLE	= 2
 };
 
 enum {
@@ -13,12 +16,23 @@ enum {
 	BNGE_FLTR_FW_DELETED
 };
 
+enum {
+	BNGE_ACT_DROP		= 0x1,
+	BNGE_ACT_RING_DST	= 0x2,
+	BNGE_ACT_NO_AGING	= 0x4,
+	BNGE_ACT_RSS_CTX	= 0x8
+};
+
+#define BNGE_MAX_L2_FLTRS	128
+#define BNGE_MAX_NTUPLE_FLTRS	(8 << 10)
+
 struct bnge_filter_base {
 	struct hlist_node	hlist;
 	struct list_head	list_node;
 	__le64			filter_id;
 	u8			type;
 	u8			flags;
+	u16			sw_id;
 	u16			rxq;
 	u16			fw_vnic_id;
 	u16			vf_idx;
@@ -44,10 +58,63 @@ struct bnge_l2_filter {
 	struct bnge_l2_key	l2_key;
 };
 
+struct bnge_ipv4_tuple {
+	struct flow_dissector_key_ipv4_addrs v4addrs;
+	struct flow_dissector_key_ports ports;
+};
+
+struct bnge_ipv6_tuple {
+	struct flow_dissector_key_ipv6_addrs v6addrs;
+	struct flow_dissector_key_ports ports;
+};
+
+struct bnge_flow_masks {
+	struct flow_dissector_key_ports ports;
+	struct flow_dissector_key_addrs addrs;
+};
+
+extern const struct bnge_flow_masks BNGE_FLOW_MASK_NONE;
+extern const struct bnge_flow_masks BNGE_FLOW_IPV6_MASK_ALL;
+extern const struct bnge_flow_masks BNGE_FLOW_IPV4_MASK_ALL;
+
+struct bnge_ntuple_filter {
+	/* base filter must be the first member */
+	struct bnge_filter_base	base;
+	struct flow_keys	fkeys;
+	struct bnge_flow_masks	fmasks;
+	__le64			l2_filter_id;
+	u32			flow_id;
+};
+
+#define BNGE_L2_FLTR_IS_NTP_MAC(fltr)   ((fltr)->base.flags)
+
+#define BNGE_FLTR_ID_INVALID	0xffffffffffffffffULL
+
+void bnge_free_ntp_fltrs(struct bnge_net *bn, bool skip_user_filters);
+u32 bnge_get_ntp_filter_idx(struct bnge_net *bn, struct flow_keys *fkeys,
+			    const struct sk_buff *skb);
+int bnge_insert_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *fltr,
+			   u32 idx);
+struct bnge_ntuple_filter *
+bnge_lookup_ntp_filter_from_idx(struct bnge_net *bn,
+				struct bnge_ntuple_filter *fltr, u32 idx);
 void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr);
+void bnge_del_l2_filter_rcu(struct bnge_net *bn, struct bnge_l2_filter *fltr);
 struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
 					     struct bnge_l2_key *key,
 					     u32 idx);
+u64 bnge_lookup_l2_filter_rcu(struct bnge_net *bn,
+			      struct bnge_l2_key *key,
+			      u32 idx);
+void bnge_free_l2_filters(struct bnge_net *bn);
 int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
 			      const u8 *mac_addr);
+struct bnge_l2_filter *bnge_alloc_user_l2_filter(struct bnge_net *bn,
+						 struct bnge_l2_key *key,
+						 u8 flags);
+int bnge_fltrs_mem(struct bnge_net *bn);
+void bnge_del_ntp_filter(struct bnge_net *bn,
+			 struct bnge_ntuple_filter *nfltr);
+void bnge_del_ntp_filter_rcu(struct bnge_net *bn,
+			     struct bnge_ntuple_filter *fltr);
 #endif /* _BNGE_FILTER_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 68a93d9f8d64..100b4daf8d60 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -8,6 +8,7 @@
 #include <linux/bnge/hsi.h>
 #include <linux/if_vlan.h>
 #include <net/netdev_queues.h>
+#include <linux/ethtool.h>
 
 #include "bnge.h"
 #include "bnge_hwrm.h"
@@ -932,11 +933,151 @@ int bnge_hwrm_l2_filter_alloc(struct bnge_dev *bd, struct bnge_l2_filter *fltr)
 		req->l2_ivlan_mask = cpu_to_le16(0xfff);
 	}
 
+	if (BNGE_L2_FLTR_IS_NTP_MAC(fltr)) {
+		req->enables |= cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_RFS_RING_TBL_IDX);
+		req->rfs_ring_tbl_idx = cpu_to_le16(fltr->base.rxq);
+	}
+
 	resp = bnge_hwrm_req_hold(bd, req);
 	rc = bnge_hwrm_req_send(bd, req);
-	if (!rc)
+	if (!rc) {
 		fltr->base.filter_id = resp->l2_filter_id;
+		set_bit(BNGE_FLTR_VALID, &fltr->base.state);
+	}
+
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_cfa_ntuple_filter_free(struct bnge_dev *bd,
+				     struct bnge_ntuple_filter *fltr)
+{
+	struct hwrm_cfa_ntuple_filter_free_input *req;
+	int rc;
+
+	set_bit(BNGE_FLTR_FW_DELETED, &fltr->base.state);
+	if (!test_bit(BNGE_STATE_OPEN, &bd->state))
+		return 0;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_NTUPLE_FILTER_FREE);
+	if (rc)
+		return rc;
+
+	req->ntuple_filter_id = fltr->base.filter_id;
+	return bnge_hwrm_req_send(bd, req);
+}
+
+#define BNGE_NTP_FLTR_FLAGS					\
+	(CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_L2_FILTER_ID |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_ETHERTYPE |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_IPADDR_TYPE |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_IPADDR |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_IPADDR_MASK |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_IPADDR |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_IPADDR_MASK |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_IP_PROTOCOL |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_PORT |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_SRC_PORT_MASK |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_PORT |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_PORT_MASK |	\
+	 CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_DST_ID)
+
+#define BNGE_NTP_TUNNEL_FLTR_FLAG				\
+		CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_TUNNEL_TYPE
+
+static void
+bnge_cfg_rfs_ring_tbl_idx(struct bnge_dev *bd,
+			  struct hwrm_cfa_ntuple_filter_alloc_input *req,
+			  struct bnge_ntuple_filter *fltr)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct bnge_vnic_info *def_vnic;
+	u32 rxq = fltr->base.rxq;
+	u32 enables;
+
+	if (fltr->base.flags & BNGE_ACT_RSS_CTX) {
+		struct ethtool_rxfh_context *ctx;
+		struct bnge_rss_ctx *rss_ctx;
+		struct bnge_vnic_info *vnic;
+
+		ctx = xa_load(&bd->netdev->ethtool->rss_ctx,
+			      fltr->base.fw_vnic_id);
+		if (ctx) {
+			rss_ctx = ethtool_rxfh_context_priv(ctx);
+			vnic = &rss_ctx->vnic;
+
+			req->dst_id = cpu_to_le16(vnic->fw_vnic_id);
+		}
+		return;
+	}
+
+	def_vnic = &bn->vnic_info[BNGE_VNIC_NTUPLE];
+	req->dst_id = cpu_to_le16(def_vnic->fw_vnic_id);
+	enables = CFA_NTUPLE_FILTER_ALLOC_REQ_ENABLES_RFS_RING_TBL_IDX;
+	req->enables |= cpu_to_le32(enables);
+	req->rfs_ring_tbl_idx = cpu_to_le32(rxq);
+}
+
+int bnge_hwrm_cfa_ntuple_filter_alloc(struct bnge_dev *bd,
+				      struct bnge_ntuple_filter *fltr)
+{
+	struct hwrm_cfa_ntuple_filter_alloc_output *resp;
+	struct hwrm_cfa_ntuple_filter_alloc_input *req;
+	struct bnge_flow_masks *masks = &fltr->fmasks;
+	struct flow_keys *keys = &fltr->fkeys;
+	int rc;
 
+	rc = bnge_hwrm_req_init(bd, req, HWRM_CFA_NTUPLE_FILTER_ALLOC);
+	if (rc)
+		return rc;
+
+	req->l2_filter_id = fltr->l2_filter_id;
+
+	if (fltr->base.flags & BNGE_ACT_DROP)
+		req->flags =
+			cpu_to_le32(CFA_NTUPLE_FILTER_ALLOC_REQ_FLAGS_DROP);
+	else
+		bnge_cfg_rfs_ring_tbl_idx(bd, req, fltr);
+
+	req->enables |= cpu_to_le32(BNGE_NTP_FLTR_FLAGS);
+
+	req->ethertype = htons(ETH_P_IP);
+	req->ip_addr_type = CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_IPV4;
+	req->ip_protocol = keys->basic.ip_proto;
+
+	if (keys->basic.n_proto == htons(ETH_P_IPV6)) {
+		req->ethertype = htons(ETH_P_IPV6);
+		req->ip_addr_type =
+			CFA_NTUPLE_FILTER_ALLOC_REQ_IP_ADDR_TYPE_IPV6;
+		memcpy(&req->src_ipaddr, &keys->addrs.v6addrs.src,
+		       sizeof(struct in6_addr));
+		memcpy(&req->src_ipaddr_mask, &masks->addrs.v6addrs.src,
+		       sizeof(struct in6_addr));
+		memcpy(&req->dst_ipaddr, &keys->addrs.v6addrs.dst,
+		       sizeof(struct in6_addr));
+		memcpy(&req->dst_ipaddr_mask, &masks->addrs.v6addrs.dst,
+		       sizeof(struct in6_addr));
+	} else {
+		req->src_ipaddr[0] = keys->addrs.v4addrs.src;
+		req->src_ipaddr_mask[0] = masks->addrs.v4addrs.src;
+		req->dst_ipaddr[0] = keys->addrs.v4addrs.dst;
+		req->dst_ipaddr_mask[0] = masks->addrs.v4addrs.dst;
+	}
+	if (keys->control.flags & FLOW_DIS_ENCAPSULATION) {
+		req->enables |= cpu_to_le32(BNGE_NTP_TUNNEL_FLTR_FLAG);
+		req->tunnel_type =
+			CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_ANYTUNNEL;
+	}
+
+	req->src_port = keys->ports.src;
+	req->src_port_mask = masks->ports.src;
+	req->dst_port = keys->ports.dst;
+	req->dst_port_mask = masks->ports.dst;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc)
+		fltr->base.filter_id = resp->ntuple_filter_id;
 	bnge_hwrm_req_drop(bd, req);
 	return rc;
 }
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 2ae8ec9f33d3..5c5bb864fc4d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -13,6 +13,8 @@ struct bnge_l2_filter;
 #define BNGE_VNIC_CFG_ROCE_DUAL_MODE		\
 	VNIC_CFG_REQ_FLAGS_ROCE_DUAL_VNIC_MODE
 
+struct bnge_ntuple_filter;
+
 int bnge_hwrm_ver_get(struct bnge_dev *bd);
 int bnge_hwrm_func_reset(struct bnge_dev *bd);
 int bnge_hwrm_fw_set_time(struct bnge_dev *bd);
@@ -68,4 +70,9 @@ int bnge_hwrm_port_qstats(struct bnge_dev *bd, u8 flags);
 int bnge_hwrm_port_qstats_ext(struct bnge_dev *bd, u8 flags);
 int bnge_hwrm_func_qstat_ext(struct bnge_dev *bd, struct bnge_stats_mem *stats);
 int bnge_hwrm_cfa_adv_flow_mgnt_qcaps(struct bnge_dev *bd);
+
+int bnge_hwrm_cfa_ntuple_filter_alloc(struct bnge_dev *bd,
+				      struct bnge_ntuple_filter *fltr);
+int bnge_hwrm_cfa_ntuple_filter_free(struct bnge_dev *bd,
+				     struct bnge_ntuple_filter *fltr);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 3c2cb9571af1..6c33dc6d95bd 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1205,6 +1205,10 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
+
+	/* Free non-user filters only */
+	bnge_free_ntp_fltrs(bn, true);
+
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
 	kfree(bn->tx_ring);
@@ -1293,6 +1297,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 
 	bnge_init_stats(bn);
 
+	rc = bnge_fltrs_mem(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -3376,6 +3384,9 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 		goto err_free_workq;
 	spin_lock_init(&bn->stats_lock);
 
+	spin_lock_init(&bn->ntp_fltr_lock);
+	INIT_LIST_HEAD(&bn->usr_fltr_list);
+
 	netdev->request_ops_lock = true;
 	rc = register_netdev(netdev);
 	if (rc) {
@@ -3403,6 +3414,9 @@ void bnge_netdev_free(struct bnge_dev *bd)
 
 	unregister_netdev(netdev);
 
+	bnge_free_ntp_fltrs(bn, false);
+	bnge_free_l2_filters(bn);
+
 	timer_shutdown_sync(&bn->timer);
 	cancel_work_sync(&bn->sp_task);
 	bn->sp_event = 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index d68eaa78d4e0..bfd0d9cb871f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -284,6 +284,9 @@ enum bnge_sp_event {
 	BNGE_PERIODIC_STATS_SP_EVENT,
 };
 
+#define BNGE_NTP_FLTR_HASH_SIZE	512
+#define BNGE_NTP_FLTR_HASH_MASK	(BNGE_NTP_FLTR_HASH_SIZE - 1)
+
 struct bnge_net {
 	struct bnge_dev		*bd;
 	struct net_device	*netdev;
@@ -373,6 +376,16 @@ struct bnge_net {
 	bool			pri2cos_valid;
 
 	u16			num_rss_ctx;
+
+	struct list_head	usr_fltr_list;
+	unsigned long		*ntp_fltr_bmap;
+	unsigned long		*l2_fltr_bmap;
+	int			ntp_fltr_count;
+	int			l2_fltr_count;
+	int			user_fltr_count;
+
+	struct hlist_head	ntp_fltr_hash_tbl[BNGE_NTP_FLTR_HASH_SIZE];
+	spinlock_t		ntp_fltr_lock;	/* for hash table add, del */
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 2fa7e829eef2..d2e21f76909c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -12,6 +12,7 @@
 #include "bnge_hwrm_lib.h"
 #include "bnge_resc.h"
 #include "bnge_vnic.h"
+#include "bnge_filter.h"
 
 static u16 bnge_num_tx_to_cp(struct bnge_dev *bd, u16 tx)
 {
@@ -644,8 +645,7 @@ int bnge_net_init_dflt_config(struct bnge_dev *bd)
 		goto err_free_tbl;
 
 	hw_resc = &bd->hw_resc;
-	bd->max_fltr = hw_resc->max_rx_em_flows + hw_resc->max_rx_wm_flows +
-		       BNGE_L2_FLTR_MAX_FLTR;
+	bd->max_fltr = BNGE_MAX_NTUPLE_FLTRS;
 
 	return 0;
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
index 40a6abcafce8..d738233f0bc9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
@@ -167,6 +167,8 @@ void bnge_del_one_rss_ctx(struct bnge_net *bn, struct bnge_rss_ctx *rss_ctx,
 			  bool all)
 {
 	struct bnge_vnic_info *vnic = &rss_ctx->vnic;
+	struct bnge_filter_base *usr_fltr, *tmp;
+	struct bnge_ntuple_filter *ntp_fltr;
 	int i;
 
 	bnge_hwrm_vnic_free_one(bn->bd, &rss_ctx->vnic);
@@ -178,6 +180,18 @@ void bnge_del_one_rss_ctx(struct bnge_net *bn, struct bnge_rss_ctx *rss_ctx,
 	if (!all)
 		return;
 
+	/* Delete all filters associated with this user RSS context */
+	list_for_each_entry_safe(usr_fltr, tmp, &bn->usr_fltr_list, list_node) {
+		if ((usr_fltr->flags & BNGE_ACT_RSS_CTX) &&
+		    usr_fltr->fw_vnic_id == rss_ctx->index) {
+			ntp_fltr = container_of(usr_fltr,
+						struct bnge_ntuple_filter,
+						base);
+			bnge_hwrm_cfa_ntuple_filter_free(bn->bd, ntp_fltr);
+			bnge_del_ntp_filter(bn, ntp_fltr);
+		}
+	}
+
 	if (vnic->rss_table)
 		dma_free_coherent(bn->bd->dev, vnic->rss_table_size,
 				  vnic->rss_table,
-- 
2.47.1

