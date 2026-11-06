Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957785;
	b=a559wasMt997NlIevzy57wa2NPAQTWNQSplPsd+0z4LtKr8OE+Fb3xU5Hxj3z8phJRuF
	 uiMjVwovzBcXmdm++DTGfXc9jHa5aQUs57MT6K63JGi5MWFF+DF83YmiZTHZ/Nvzibhcn
	 8+23/Lu+TzDVaQ++IR90A1VwyRmhWx1S+yoDT1E2fOwMJdu3hoajxJ7pdyZfbAZCs3HdC
	 Xs7+lWVSr84UL7vFR8s0m7xBSpIjw+SKwYENRVhAGCcDjr3dH89WX7xQkQyFTFCoJ60YA
	 OLwWdiSX6PEHHDOlbX+jKIKX1oW3+31/h5K7vERZtUuuDwSC/HZoCYRKtfd1+bleP/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957785;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=j9kh7vUZQyvUjZW3HYIBQs/m58THhOgym6wQsE4/qN4=;
	b=MNkMfrs2FK2KcchOFEzRrPrQZD1fqP20Nml9rKyRHoavxR2WqpLtWQPplwiW3nJAa4Ch
	 bAMEyUHT35TZgLhdVn3b56CVnZ+B9kVw6Bi1WVM/HlBey4lh/FsU0tQgj4d3VneL1wgJY
	 nIX6hlQOCgnCAdptiyeC923TJEbMQJdTdXwuGw/n9ai0z9floBIqjyI+NTiDVLaeMfbgn
	 wg6pKs4dpeTCudxUjGK/vT76fGQd3W+7dqi1lbM0xuunIxunAAufG9G6J2MmXcGp+8KL7
	 12CniO5BqYGL+Fcp+Le0gQv7zn331Igiv1SeoCT9s+uVwluRdswGZsesXVWri4g/I3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EtQs3AYC;
	arc=none smtp.remote-ip=209.85.160.226
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E34606A917
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3E34606A917
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EtQs3AYC
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-537548b811aso2702851cf.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957784; x=1794562584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9kh7vUZQyvUjZW3HYIBQs/m58THhOgym6wQsE4/qN4=;
        b=ICn9kxHHciLKgqFzDy4BKVO8zM/sivXT/15kIaIotFZv9kMHEV3mfTcx51bvqz1VKg
         HiHVjRSaTkHuFOuK+BJaGQU3wwrb3XeQux/oQYXrLh2Sh+WgEfOkGc7DwfTyiKnrN/vZ
         GDgW7fZZ/h9i0i1jvAaiPyrVLPdS8bNtFvr9k5Cro6KlTbrJV/yPB3WP0CIAWe29g+0O
         3ug9RN+HHaehYZqGNcKAyUQYTGXmLfiXhkmSQoTeJfA9MvJp803K5xSBhc8s5Ee9QF3X
         7H1NUnUHkn5Vn2PhWdfUDpr7gomFY8rVjTSGOBSV2SSser+tI+KCPcMUSJYV/qXl55TI
         HWLQ==
X-Gm-Message-State: APuU4Z/nQ2VF02L4nhvWXUaPD831QCZR0vLIY6D4Q8guAnP4ynpVKGyZ
	NPakTF5YQiHqxTCOJUh+Ukp+LUsGPBx7PxG2bVb2ABCIiUlOeTS4aLX8mgQB0ogpvLq6gbLjBF8
	Y/nIWezL3Dt8UYMdzLdse7Y8vsyrDk7G7IfSmP7BAT26mDm+U0ra7ITOLR3OT8zuCTbJfM6MxN8
	F+XtzsaH+83egCxhK/Er89yeOHRfK9SYJWggqQZS0Mgox/EJDeWW8SoikmmIzNUHypx0SQwZXFx
	zOBjzcJ5g==
X-Gm-Gg: AYBFou05FZexJIN/IMHIT90iqB7zruELW7BHXJqrEBJ1MD5hciJwlwMS3tre7AGoORw
	UpTGGa7+35eCVC95v9l8B8DQcjh+MH4Mxn3ejDz3zPWLKytdYfj+XKN9iZMVqkPM7OsCsFiQ1gJ
	VWinDIOV4/6YHHCYNUZaLT1eFZyentbJZMvGPaCulNgdHMVVP/VJPeMbaqF1BTuEFb1LwOQckJ1
	mjBDMQjO5/zjBiKkwncstXRg+7kHdxw7cVllHN8+02ZYfxg99Rgb/xR5DXTM2DDE1MKHvccHyJd
	03EwgFomqt8IeCsfm3O/dtFv2EtQtHShIcftk1CPmHecrXURmrI2n0c9/RP3UO9OsWT+77acT96
	iChp6tYSp7JJinc6y8WOi4whaztlkQTOjleMHEBTryyUfjqZlRF2MekakR2TNaG+KUyIWUMGpTr
	c5PxF6KTraJz2cGxy5yi7Rnaxj9oiwbqrXMg==
X-Received: by 2002:a05:622a:558a:b0:536:79aa:de1f with SMTP id d75a77b69052e-54e15766d6dmr30585901cf.59.1793957783471;
        Fri, 06 Nov 2026 01:36:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-54e26b2d3a7sm145751cf.44.2026.11.06.01.36.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:36:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36d1353fdcdso1823228eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793957782; x=1794562582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9kh7vUZQyvUjZW3HYIBQs/m58THhOgym6wQsE4/qN4=;
        b=EtQs3AYCfX6br4LYsxLNk42yzH/Xvp6zKzzxiSEI7j/OtVJRDpX0ri3ydpiW6ZrjHI
         wOARPgDxjWqlz2zj/QvjpThyuhA1tSHDDVCC4KTcIpF3//SfPafMR0G6aMP8IIn9eWnW
         WZmNs5GSeZ5nT8c0iRgQu23++hdA9mu5O2OC8=
X-Received: by 2002:a05:7301:f8e:b0:36d:394d:e696 with SMTP id 5a478bee46e88-36f7671c5b6mr2855087eec.29.1793957781901;
        Fri, 06 Nov 2026 01:36:21 -0800 (PST)
X-Received: by 2002:a05:7301:f8e:b0:36d:394d:e696 with SMTP id 5a478bee46e88-36f7671c5b6mr2855046eec.29.1793957781207;
        Fri, 06 Nov 2026 01:36:21 -0800 (PST)
Received: from H5-S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fc92fasm6447726eec.19.2026.11.06.01.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:36:20 -0800 (PST)
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
Subject: [PATCH net-next v6 09/10] bnge: add aRFS flow steering ndo support
Date: Fri,  6 Nov 2026 15:05:23 +0530
Message-ID: <20261106093524.838341-10-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261106093524.838341-1-vikas.gupta@broadcom.com>
References: <20261106093524.838341-1-vikas.gupta@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Introduce the ndo_rx_flow_steer callback (bnge_rx_flow_steer) to
support aRFS.

This callback creates an NTUPLE filter that steers matching packets
to the appropriate RX queue. The implementation dissects flow keys
from the SKB, creates an NTUPLE filter with the associated L2 filter,
inserts it into the NTUPLE hash table, and schedules the sp_task
workqueue via BNGE_RX_NTP_FLTR_SP_EVENT to program the filter
in the firmware.

Add bnge_cfg_ntp_filters() called from the periodic timer via sp_task
to handle deferred filter programming and expiration via
rps_may_expire_flow().

bnge_timer() queues aRFS aging only while NTUPLE is enabled. NTUPLE
can only be turned off with the interface closed, and
bnge_close_core() then deletes the timer and purges dynamic
aRFS filters.

Note that, if the L2 filter is freed before sp_task programs the rule,
the captured firmware id is stale. The NTUPLE alloc either fails (id
gone) or binds to a recycled id for a different filter. The rule is
then dropped, or it stays until it ages out.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |   5 +-
 .../net/ethernet/broadcom/bnge/bnge_filter.c  |  85 ++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |   5 +-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 138 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   1 +
 6 files changed, 228 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 440e0c206aec..81f6f82b49ef 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -1273,7 +1273,7 @@ static int bnge_get_all_fltr_ids_rcu(struct bnge_net *bn,
 
 		head = &tbl[i];
 		hlist_for_each_entry_rcu(fltr, head, hlist) {
-			if (!fltr->flags ||
+			if (!bnge_is_usr_fltr(fltr) ||
 			    test_bit(BNGE_FLTR_FW_DELETED, &fltr->state))
 				continue;
 			if (j == id_cnt)
@@ -1297,7 +1297,8 @@ static struct bnge_filter_base *bnge_get_one_fltr_rcu(struct bnge_net *bn,
 
 		head = &tbl[i];
 		hlist_for_each_entry_rcu(fltr, head, hlist) {
-			if (fltr->flags && fltr->sw_id + offset == id)
+			if (bnge_is_usr_fltr(fltr) &&
+			    fltr->sw_id + offset == id)
 				return fltr;
 		}
 	}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index 6cf6531a2723..579eca2b7aee 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
@@ -56,7 +56,7 @@ const struct bnge_flow_masks BNGE_FLOW_IPV4_MASK_ALL = {
 	},
 };
 
-static bool bnge_is_usr_fltr(struct bnge_filter_base *fltr)
+bool bnge_is_usr_fltr(struct bnge_filter_base *fltr)
 {
 	return (fltr->type == BNGE_FLTR_TYPE_L2 &&
 		fltr->flags & BNGE_ACT_RING_DST) ||
@@ -116,7 +116,7 @@ void bnge_del_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *nfltr)
 	hlist_del(&fltr->hlist);
 	bnge_del_usr_fltr_node(bn, fltr);
 	clear_bit(fltr->sw_id, bn->ntp_fltr_bmap);
-	bn->ntp_fltr_count--;
+	WRITE_ONCE(bn->ntp_fltr_count, bn->ntp_fltr_count - 1);
 	kfree(fltr);
 }
 
@@ -127,7 +127,7 @@ void bnge_del_ntp_filter_rcu(struct bnge_net *bn,
 	hlist_del_rcu(&fltr->base.hlist);
 	bnge_del_usr_fltr_node(bn, &fltr->base);
 	clear_bit(fltr->base.sw_id, bn->ntp_fltr_bmap);
-	bn->ntp_fltr_count--;
+	WRITE_ONCE(bn->ntp_fltr_count, bn->ntp_fltr_count - 1);
 	spin_unlock_bh(&bn->ntp_fltr_lock);
 
 	kfree_rcu(fltr, base.rcu);
@@ -538,7 +538,7 @@ int bnge_insert_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *fltr,
 	hlist_add_head_rcu(&fltr->base.hlist, head);
 
 	bnge_insert_usr_fltr(bn, &fltr->base);
-	bn->ntp_fltr_count++;
+	WRITE_ONCE(bn->ntp_fltr_count, bn->ntp_fltr_count + 1);
 
 	spin_unlock_bh(&bn->ntp_fltr_lock);
 
@@ -711,3 +711,80 @@ void bnge_clear_usr_fltrs(struct bnge_net *bn)
 		}
 	}
 }
+
+void bnge_cfg_ntp_filters(struct bnge_net *bn)
+{
+#ifdef CONFIG_RFS_ACCEL
+	struct bnge_ntuple_filter *fltr, *tmp;
+	LIST_HEAD(install_list);
+	LIST_HEAD(update_list);
+	LIST_HEAD(expire_list);
+	u32 flow_id;
+	int i, rc;
+	u16 rxq;
+
+	rcu_read_lock();
+	for (i = 0; i < BNGE_NTP_FLTR_HASH_SIZE; i++) {
+		hlist_for_each_entry_rcu(fltr, &bn->ntp_fltr_hash_tbl[i],
+					 base.hlist) {
+			if (test_bit(BNGE_FLTR_VALID, &fltr->base.state)) {
+				if (fltr->base.flags & BNGE_ACT_NO_AGING)
+					continue;
+				if (test_and_clear_bit(BNGE_FLTR_RXQ_UPDATE,
+						       &fltr->base.state)) {
+					list_add(&fltr->base.list_node,
+						 &update_list);
+					continue;
+				}
+				rxq = READ_ONCE(fltr->base.rxq);
+				flow_id = READ_ONCE(fltr->flow_id);
+				if (rps_may_expire_flow(bn->netdev, rxq,
+							flow_id,
+							fltr->base.sw_id))
+					list_add(&fltr->base.list_node,
+						 &expire_list);
+			} else {
+				clear_bit(BNGE_FLTR_RXQ_UPDATE,
+					  &fltr->base.state);
+				/* Order the clear before the rxq read in
+				 * the install below.
+				 */
+				smp_mb__after_atomic();
+				list_add(&fltr->base.list_node, &install_list);
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	/* Free the old HW rule; reinstall it below on the new queue. */
+	list_for_each_entry_safe(fltr, tmp, &update_list, base.list_node) {
+		list_del_init(&fltr->base.list_node);
+		/* If the free fails the rule stays on the old queue. It is not
+		 * retried, so a firmware that keeps failing is not hit on every
+		 * tick.
+		 */
+		if (bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr))
+			continue;
+		clear_bit(BNGE_FLTR_FW_DELETED, &fltr->base.state);
+		list_add(&fltr->base.list_node, &install_list);
+	}
+
+	list_for_each_entry_safe(fltr, tmp, &install_list, base.list_node) {
+		list_del_init(&fltr->base.list_node);
+		rc = bnge_hwrm_cfa_ntuple_filter_alloc(bn->bd, fltr);
+		if (rc)
+			bnge_del_ntp_filter_rcu(bn, fltr);
+		else
+			set_bit(BNGE_FLTR_VALID, &fltr->base.state);
+	}
+
+	list_for_each_entry_safe(fltr, tmp, &expire_list, base.list_node) {
+		list_del_init(&fltr->base.list_node);
+		/* Retargeted by bnge_rx_flow_steer() after the scan */
+		if (test_bit(BNGE_FLTR_RXQ_UPDATE, &fltr->base.state))
+			continue;
+		bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr);
+		bnge_del_ntp_filter_rcu(bn, fltr);
+	}
+#endif
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
index 27fab050565e..ce446fa67158 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -19,7 +19,8 @@ enum {
 
 enum {
 	BNGE_FLTR_VALID,
-	BNGE_FLTR_FW_DELETED
+	BNGE_FLTR_FW_DELETED,
+	BNGE_FLTR_RXQ_UPDATE
 };
 
 enum {
@@ -97,6 +98,7 @@ struct bnge_ntuple_filter {
 #define BNGE_FLTR_ID_INVALID	cpu_to_le64(0xffffffffffffffffULL)
 
 void bnge_free_ntp_fltrs(struct bnge_net *bn, bool skip_user_filters);
+bool bnge_is_usr_fltr(struct bnge_filter_base *fltr);
 u32 bnge_get_ntp_filter_idx(struct bnge_net *bn, struct flow_keys *fkeys,
 			    const struct sk_buff *skb);
 int bnge_insert_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *fltr,
@@ -124,4 +126,5 @@ void bnge_del_ntp_filter_rcu(struct bnge_net *bn,
 void bnge_cfg_usr_fltrs(struct bnge_net *bn);
 void bnge_clear_usr_fltrs(struct bnge_net *bn);
 bool bnge_has_usr_ntp_fltr(struct bnge_net *bn);
+void bnge_cfg_ntp_filters(struct bnge_net *bn);
 #endif /* _BNGE_FILTER_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index bb6233351484..ce41d94838e6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -1007,8 +1007,8 @@ bnge_cfg_rfs_ring_tbl_idx(struct bnge_dev *bd,
 			  struct bnge_ntuple_filter *fltr)
 {
 	struct bnge_net *bn = netdev_priv(bd->netdev);
+	u32 rxq = READ_ONCE(fltr->base.rxq);
 	struct bnge_vnic_info *def_vnic;
-	u32 rxq = fltr->base.rxq;
 	u32 enables;
 
 	if (fltr->base.flags & BNGE_ACT_RSS_CTX) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 94406d5ecb71..dcc3f85b2405 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -303,6 +303,12 @@ static void bnge_timer(struct timer_list *t)
 	if (BNGE_LINK_IS_UP(bd) && bn->stats_coal_ticks)
 		bnge_queue_sp_work(bn, BNGE_PERIODIC_STATS_SP_EVENT);
 
+#ifdef CONFIG_RFS_ACCEL
+	if ((bn->priv_flags & BNGE_NET_EN_NTUPLE) &&
+	    READ_ONCE(bn->ntp_fltr_count))
+		bnge_queue_sp_work(bn, BNGE_RX_NTP_FLTR_SP_EVENT);
+#endif
+
 	mod_timer(&bn->timer, jiffies + bn->current_interval);
 }
 
@@ -444,6 +450,9 @@ static void bnge_sp_task(struct work_struct *work)
 			bnge_init_ethtool_link_settings(bn);
 	}
 
+	if (test_and_clear_bit(BNGE_RX_NTP_FLTR_SP_EVENT, &bn->sp_event))
+		bnge_cfg_ntp_filters(bn);
+
 	netdev_unlock(bn->netdev);
 }
 
@@ -3222,6 +3231,132 @@ static int bnge_set_features(struct net_device *dev, netdev_features_t features)
 	return 0;
 }
 
+#ifdef CONFIG_RFS_ACCEL
+static __le64 bnge_lookup_l2_filter_from_key(struct bnge_net *bn,
+					     struct bnge_l2_key *key)
+{
+	u32 idx;
+
+	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
+	      BNGE_L2_FLTR_HASH_MASK;
+	return bnge_lookup_l2_filter_rcu(bn, key, idx);
+}
+
+static int bnge_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
+			      u16 rxq_index, u32 flow_id)
+{
+	struct ethhdr *eth = (struct ethhdr *)skb_mac_header(skb);
+	struct bnge_ntuple_filter *fltr, *new_fltr;
+	struct bnge_net *bn = netdev_priv(dev);
+	struct flow_keys *fkeys;
+	__le64 filter_id;
+	u32 flags, idx;
+	int rc = 0;
+
+	/* Hold rcu_read_lock() across the L2 filter lookup and check
+	 * BNGE_STATE_OPEN inside it. bnge_close_core() clears the
+	 * flag before bnge_shutdown_nic() frees the L2 filters via
+	 * kfree_rcu(), so if we observe the device open here the
+	 * filter cannot be freed under us for the duration of
+	 * this critical section.
+	 */
+	rcu_read_lock();
+	if (!test_bit(BNGE_STATE_OPEN, &bn->bd->state)) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
+	if (ether_addr_equal(dev->dev_addr, eth->h_dest)) {
+		struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+		struct bnge_l2_filter *l2_filter;
+
+		if (!vnic->uc_filter_count) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+		l2_filter = vnic->l2_filters[0];
+		filter_id = l2_filter->base.filter_id;
+	} else {
+		struct bnge_l2_key key;
+
+		ether_addr_copy(key.dst_mac_addr, eth->h_dest);
+		key.vlan = 0;
+
+		filter_id = bnge_lookup_l2_filter_from_key(bn, &key);
+		if (filter_id == BNGE_FLTR_ID_INVALID) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+	}
+	rcu_read_unlock();
+
+	new_fltr = kzalloc_obj(*new_fltr, GFP_ATOMIC);
+	if (!new_fltr)
+		return -ENOMEM;
+
+	fkeys = &new_fltr->fkeys;
+	if (!skb_flow_dissect_flow_keys(skb, fkeys, 0)) {
+		rc = -EPROTONOSUPPORT;
+		goto err_free;
+	}
+
+	if ((fkeys->basic.n_proto != htons(ETH_P_IP) &&
+	     fkeys->basic.n_proto != htons(ETH_P_IPV6)) ||
+	    (fkeys->basic.ip_proto != IPPROTO_TCP &&
+	     fkeys->basic.ip_proto != IPPROTO_UDP)) {
+		rc = -EPROTONOSUPPORT;
+		goto err_free;
+	}
+	new_fltr->fmasks = BNGE_FLOW_IPV4_MASK_ALL;
+	if (fkeys->basic.n_proto == htons(ETH_P_IPV6))
+		new_fltr->fmasks = BNGE_FLOW_IPV6_MASK_ALL;
+
+	flags = fkeys->control.flags;
+	if (flags & FLOW_DIS_IS_FRAGMENT) {
+		rc = -EPROTONOSUPPORT;
+		goto err_free;
+	}
+
+	new_fltr->l2_filter_id = filter_id;
+
+	idx = bnge_get_ntp_filter_idx(bn, fkeys, skb);
+	rcu_read_lock();
+	fltr = bnge_lookup_ntp_filter_from_idx(bn, new_fltr, idx);
+	/* Filter already exists. If the flow moved to another queue,
+	 * retarget it, sp_task reprograms it in hardware.
+	 */
+	if (fltr) {
+		if (!(fltr->base.flags & BNGE_ACT_NO_AGING) &&
+		    READ_ONCE(fltr->base.rxq) != rxq_index) {
+			spin_lock_bh(&bn->ntp_fltr_lock);
+			WRITE_ONCE(fltr->base.rxq, rxq_index);
+			WRITE_ONCE(fltr->flow_id, flow_id);
+			/* Pairs with test_and_clear_bit() in sp_task */
+			smp_mb__before_atomic();
+			set_bit(BNGE_FLTR_RXQ_UPDATE, &fltr->base.state);
+			spin_unlock_bh(&bn->ntp_fltr_lock);
+			bnge_queue_sp_work(bn, BNGE_RX_NTP_FLTR_SP_EVENT);
+		}
+		rc = fltr->base.sw_id;
+		rcu_read_unlock();
+		goto err_free;
+	}
+	rcu_read_unlock();
+
+	new_fltr->flow_id = flow_id;
+	new_fltr->base.rxq = rxq_index;
+	rc = bnge_insert_ntp_filter(bn, new_fltr, idx);
+	if (!rc) {
+		bnge_queue_sp_work(bn, BNGE_RX_NTP_FLTR_SP_EVENT);
+		return new_fltr->base.sw_id;
+	}
+
+err_free:
+	kfree(new_fltr);
+	return rc;
+}
+#endif
+
 static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
@@ -3231,6 +3366,9 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_features_check	= bnge_features_check,
 	.ndo_fix_features	= bnge_fix_features,
 	.ndo_set_features	= bnge_set_features,
+#ifdef CONFIG_RFS_ACCEL
+	.ndo_rx_flow_steer	= bnge_rx_flow_steer,
+#endif
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 2a1ec811de01..74dbca600cbe 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -282,6 +282,7 @@ enum bnge_sp_event {
 	BNGE_LINK_CFG_CHANGE_SP_EVENT,
 	BNGE_UPDATE_PHY_SP_EVENT,
 	BNGE_PERIODIC_STATS_SP_EVENT,
+	BNGE_RX_NTP_FLTR_SP_EVENT,
 };
 
 #define BNGE_NTP_FLTR_HASH_SIZE	512
-- 
2.52.0

