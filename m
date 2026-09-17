Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD1446067
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627611; cv=none; b=r3sP8oVzqxXGzO+sXj1Hb37DBuPR532LgmEUjGblXQCPjAYiLQ03LjJf4T8NXFIhEmW806ruP2GPKUCoDBIkQoXM+ablZB8/3Ah5Pl32c+HgIyj7duX8fhQsxGUz2xiMIJ07ZmPAoU++6cHnJnQ8jEB/8pUJCA1kvb/1FInX4RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627611; c=relaxed/simple;
	bh=3W4A1WGZzmmZnJxZlLxKrhwBYDySMqG32fM22CFYFh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJFIM0aMpXz818W0lcqzvL9M96Swg3yqfhkhVEPHN3h+qa1BSnkdEQpoc9N1uMpfLhVi7vojljlzbHGdzpKdf7CMrGaJHJOCfB/Yu/B9Q4tqGFMr8M0lar/sIYZfiHsUMOW5KALXf0EhWceSTs9IsRKtV04gVPrilrdhmNLAeJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SOqASV5+; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SOqASV5+"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so141202a91.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627609; x=1790232409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n8P48uP3wBqQG/cmhh+LqVY7vEt5BbPlgj0d2GBHfbo=;
        b=gU/TlKQR0R9xsoV+Ooph88Dw4XmqeT/8JBHeGEQg+DxQQKctIPpseVIKwuThVNMoQE
         vFmo7OOlQhWbDNp5GBZxRk2Qs88v8bCujGJP2gnmScQxYHX2gdkmwLlcNwrumLSu2APi
         /tuL3qarUWwEuOABGbfD7uOjRQ901t4R6skcVnOaMViyDQiRiQhlxarbLZ0sYLpS1Z9a
         bfkUuh6rqoxZ4tMEbV3TwIh/r1md+APUP8Gy9CsPRj7t6LPPJ0V3xWO2CKcRlJ3gBGcK
         Ajb1q80BOqt4bYvEBsQiE2o1H9SdL7t31OHZGOgcp4ma+XoduRRX5CxKDzmadTBuC39P
         ldQg==
X-Gm-Message-State: AFuF++lz3P9UT3324begxLjes69iP+5Vrt3guyiKmG5ZRDIHYd5kzFmT
	JVuHL/eA+qRuc+dsses8BeZxaGAFbmfsbzX6tdaUkS7a/xI68EGWIdo1nvcixxvV581R9ernAkw
	txILQXqZHfSKEptpGaf+n7FHOj1+miuhrvEkiK619bXKUxLaBgSqgeiPZ0Su2zSmwcuTLkS99Gz
	hh7YRKBNctmNOZcBs3+SlvTVt4ho4PRu6ZMwHf+BRhvlyJDhxvMh3H1yU8aHg7ySOmchnjXAKe7
	0bX+IWvHQ==
X-Gm-Gg: AYBFou1pcwi2UkEkoXV9uincR37GaLP8480aKtiZvvcL6jO13L1amDz2PRwjMKQgZIZ
	fqSjXLBaYejBohQ4LagkX88MBNoOxAkAWiwoQqlQQnIzMfy+rzdsxY9nuFJ4h7OZOhGo/3bJqhg
	n8uas4Wi5/qiyQvu+vPy0mBRgVvCYMdt55kwNPqR/d+0zfCLN2hf2cr4TT/Wzx+KlYWZLTEvENp
	U7XsX7/TaRIzxcs6E7/plB3tS6RJaCBmG17E3mPiyXhmMK7dl8nvInU+BD86w7Ds5DRGeYt1E6/
	q56be7pMaeh65sRV2CBV6/nGaJgOSZKYWjRvZqWH1hQlU/1ftJWuR3h9pDriTtfatoJQQDkZLF8
	Z/vpEMc3Vn/LMn0Aa7SFHqb2q2/VWOtOcG4vluepZcwQ+3CLJpXzoxnWIDXOmyDZ51zwgjH0ZIn
	C+BeJ7Pm/TESx3yuZWQU2knz0uDkIvVQA1VA==
X-Received: by 2002:a17:90b:4a51:b0:39d:ecb6:8d40 with SMTP id 98e67ed59e1d1-39e1e277458mr11987851a91.4.1789627608533;
        Wed, 16 Sep 2026 23:46:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e35e28e4asm1057072a91.6.2026.09.16.23.46.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 23:46:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so506330a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789627607; x=1790232407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8P48uP3wBqQG/cmhh+LqVY7vEt5BbPlgj0d2GBHfbo=;
        b=SOqASV5+Jj+lX3SumlRrus0ZzhwLOQDDw88i35UFx74lSeu7EQ3sq4bX0+3NWkmkth
         +bJYwPNzARtv65ZNcFEL58B3Pw0wN4PFQmMK8GommNaG27c7fs2YbnPHGh+0k+K3oNuR
         fnrVAyxSfglYuCKEOBNc1+vOeWBDmpmwABs7w=
X-Received: by 2002:a05:6a20:3d02:b0:3da:15a9:a18e with SMTP id adf61e73a8af0-3dd5f74d9bfmr15642958637.23.1789627606390;
        Wed, 16 Sep 2026 23:46:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d02:b0:3da:15a9:a18e with SMTP id adf61e73a8af0-3dd5f74d9bfmr15642878637.23.1789627605760;
        Wed, 16 Sep 2026 23:46:45 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm2754293a12.20.2026.09.16.23.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:46:45 -0700 (PDT)
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
Subject: [net-next, v3 08/11] bnge: add NTUPLE filter infrastructure
Date: Thu, 17 Sep 2026 12:15:45 +0530
Message-ID: <20260917064548.773334-9-vikas.gupta@broadcom.com>
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

Add the core NTUPLE filter data structures and firmware command
wrappers needed for flow rule management.

This helps further patches implement user-created NTUPLE rules
as well as rules via kernel flow steering.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   1 -
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 494 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  69 ++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 143 ++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   7 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  14 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  13 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   6 +-
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    |  17 +
 9 files changed, 751 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index f0b152e6a43a..b7aef5c39b28 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -161,7 +161,6 @@ struct bnge_dev {
 	u16			tso_max_segs;
 
 	int			max_fltr;
-#define BNGE_L2_FLTR_MAX_FLTR	1024
 
 	u32			*rss_indir_tbl;
 	u16			rss_indir_tbl_entries;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index e10a774c3033..698bd3967c27 100644
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
@@ -11,24 +13,150 @@
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
+static bool bnge_is_usr_fltr(struct bnge_filter_base *fltr)
+{
+	return (fltr->type == BNGE_FLTR_TYPE_L2 &&
+		fltr->flags & BNGE_ACT_RING_DST) ||
+	       (fltr->type == BNGE_FLTR_TYPE_NTUPLE &&
+		fltr->flags & BNGE_ACT_NO_AGING);
+}
+
+static void bnge_insert_usr_fltr(struct bnge_net *bn,
+				 struct bnge_filter_base *fltr)
+{
+	if (!bnge_is_usr_fltr(fltr))
+		return;
+
+	INIT_LIST_HEAD(&fltr->list_node);
+	list_add_tail(&fltr->list_node, &bn->usr_fltr_list);
+	bn->user_fltr_count++;
+}
+
+static void bnge_del_usr_fltr_node(struct bnge_net *bn,
+				   struct bnge_filter_base *fltr)
 {
+	if (!bnge_is_usr_fltr(fltr))
+		return;
+
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
+{
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
+	clear_bit(fltr->base.sw_id, bn->ntp_fltr_bmap);
+	bn->ntp_fltr_count--;
+	spin_unlock_bh(&bn->ntp_fltr_lock);
+
 	kfree_rcu(fltr, base.rcu);
 }
 
-static void bnge_init_l2_filter(struct bnge_net *bn,
-				struct bnge_l2_filter *fltr,
-				struct bnge_l2_key *key, u32 idx)
+static int bnge_init_l2_filter(struct bnge_net *bn,
+			       struct bnge_l2_filter *fltr,
+			       struct bnge_l2_key *key, u32 idx)
 {
 	struct hlist_head *head;
+	int bit_id;
 
 	ether_addr_copy(fltr->l2_key.dst_mac_addr, key->dst_mac_addr);
 	fltr->l2_key.vlan = key->vlan;
 	fltr->base.type = BNGE_FLTR_TYPE_L2;
+	fltr->base.filter_id = BNGE_FLTR_ID_INVALID;
+
+	bit_id = bitmap_find_free_region(bn->l2_fltr_bmap,
+					 BNGE_MAX_L2_FLTRS, 0);
+	if (bit_id < 0)
+		return -ENOMEM;
+	fltr->base.sw_id = (u16)bit_id;
+
+	bn->l2_fltr_count++;
 
 	head = &bn->l2_fltr_hash_tbl[idx];
 	hlist_add_head_rcu(&fltr->base.hlist, head);
+	bnge_insert_usr_fltr(bn, &fltr->base);
+	return 0;
 }
 
 struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
@@ -49,12 +177,38 @@ struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
 	return NULL;
 }
 
+__le64 bnge_lookup_l2_filter_rcu(struct bnge_net *bn,
+				 struct bnge_l2_key *key,
+				 u32 idx)
+{
+	__le64 id = BNGE_FLTR_ID_INVALID;
+	struct bnge_l2_filter *fltr;
+	struct hlist_head *head;
+
+	rcu_read_lock();
+
+	head = &bn->l2_fltr_hash_tbl[idx];
+	hlist_for_each_entry_rcu(fltr, head, base.hlist) {
+		struct bnge_l2_key *l2_key = &fltr->l2_key;
+
+		if (ether_addr_equal(l2_key->dst_mac_addr, key->dst_mac_addr) &&
+		    l2_key->vlan == key->vlan) {
+			id = fltr->base.filter_id;
+			break;
+		}
+	}
+
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
@@ -67,10 +221,338 @@ static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
 	if (!fltr)
 		return ERR_PTR(-ENOMEM);
 
-	bnge_init_l2_filter(bn, fltr, key, idx);
+	rc = bnge_init_l2_filter(bn, fltr, key, idx);
+	if (rc) {
+		kfree(fltr);
+		fltr = ERR_PTR(rc);
+	}
+
+	return fltr;
+}
+
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
 	return fltr;
 }
 
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
+			if (skip_user && bnge_is_usr_fltr(&fltr->base))
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
+	bool ntp_alloced = !bn->ntp_fltr_bmap;
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
+	if (ntp_alloced) {
+		bitmap_free(bn->ntp_fltr_bmap);
+		bn->ntp_fltr_bmap = NULL;
+	}
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
+int bnge_insert_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *fltr,
+			   u32 idx)
+{
+	struct bnge_ntuple_filter *f;
+	struct hlist_head *head;
+	int bit_id;
+
+	spin_lock_bh(&bn->ntp_fltr_lock);
+
+	head = &bn->ntp_fltr_hash_tbl[idx];
+	hlist_for_each_entry(f, head, base.hlist) {
+		if (bnge_fltr_match(f, fltr)) {
+			spin_unlock_bh(&bn->ntp_fltr_lock);
+			return -EEXIST;
+		}
+	}
+
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
@@ -92,6 +574,6 @@ int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
 	return rc;
 
 err_del_l2_filter:
-	bnge_del_l2_filter(bn, fltr);
+	bnge_del_l2_filter_rcu(bn, fltr);
 	return rc;
 }
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
index 16a5d91517c9..2ffd68ed32b7 100644
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
+#define BNGE_FLTR_ID_INVALID	cpu_to_le64(0xffffffffffffffffULL)
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
+__le64 bnge_lookup_l2_filter_rcu(struct bnge_net *bn,
+				 struct bnge_l2_key *key,
+				 u32 idx);
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
index 86edb70d323e..e611d365db4f 100644
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
+	req->rfs_ring_tbl_idx = cpu_to_le16(rxq);
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
index 3dcab0370bdf..6d0e6f587396 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1214,6 +1214,10 @@ static void bnge_free_core(struct bnge_net *bn)
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
@@ -1302,6 +1306,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 
 	bnge_init_stats(bn);
 
+	rc = bnge_fltrs_mem(bn);
+	if (rc)
+		goto err_free_core;
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -3428,6 +3436,9 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 		goto err_free_workq;
 	spin_lock_init(&bn->stats_lock);
 
+	spin_lock_init(&bn->ntp_fltr_lock);
+	INIT_LIST_HEAD(&bn->usr_fltr_list);
+
 	netdev->request_ops_lock = true;
 	rc = register_netdev(netdev);
 	if (rc) {
@@ -3455,6 +3466,9 @@ void bnge_netdev_free(struct bnge_dev *bd)
 
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
index 0a4c4cf5eabf..89c16fdb08a4 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -12,6 +12,7 @@
 #include "bnge_hwrm_lib.h"
 #include "bnge_resc.h"
 #include "bnge_vnic.h"
+#include "bnge_filter.h"
 
 static u16 bnge_num_tx_to_cp(struct bnge_dev *bd, u16 tx)
 {
@@ -634,7 +635,6 @@ bool bnge_arfs_capable(struct bnge_dev *bd, bool new_rss_ctx)
 
 int bnge_net_init_dflt_config(struct bnge_dev *bd)
 {
-	struct bnge_hw_resc *hw_resc;
 	int rc;
 
 	rc = bnge_alloc_rss_indir_tbl(bd);
@@ -648,9 +648,7 @@ int bnge_net_init_dflt_config(struct bnge_dev *bd)
 	if (bnge_arfs_capable(bd, false))
 		bd->flags |= BNGE_EN_ARFS_CAP;
 
-	hw_resc = &bd->hw_resc;
-	bd->max_fltr = hw_resc->max_rx_em_flows + hw_resc->max_rx_wm_flows +
-		       BNGE_L2_FLTR_MAX_FLTR;
+	bd->max_fltr = BNGE_MAX_NTUPLE_FLTRS;
 
 	return 0;
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
index 3aa89bcd96b9..bbcd5d0126ca 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
@@ -171,8 +171,13 @@ void bnge_del_one_rss_ctx(struct bnge_net *bn, struct bnge_rss_ctx *rss_ctx,
 			  bool all)
 {
 	struct bnge_vnic_info *vnic = &rss_ctx->vnic;
+	struct bnge_filter_base *usr_fltr, *tmp;
+	struct bnge_ntuple_filter *ntp_fltr;
 	int i;
 
+	/* freeing the VNIC first is fine, the other HW resources
+	 * can be freed independently.
+	 */
 	bnge_hwrm_vnic_free_one(bn->bd, &rss_ctx->vnic);
 	for (i = 0; i < BNGE_MAX_CTX_PER_VNIC; i++) {
 		if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
@@ -182,6 +187,18 @@ void bnge_del_one_rss_ctx(struct bnge_net *bn, struct bnge_rss_ctx *rss_ctx,
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
+			bnge_del_ntp_filter_rcu(bn, ntp_fltr);
+		}
+	}
+
 	if (vnic->rss_table)
 		dma_free_coherent(bn->bd->dev, vnic->rss_table_size,
 				  vnic->rss_table,
-- 
2.52.0

