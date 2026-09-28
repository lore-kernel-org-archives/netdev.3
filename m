Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF241835B
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576058; cv=none; b=sNtDmsHM+Cd5gJrrr9xKopthHwitIExc7NgDoZunQBl7+1MMu5Hcx0O57QTnJQ+s24QvVOzReEjP/mA/ZKkuC+BSYXkxNkk8DiI3if7v2jI8IVeMTeKvprzLLuQ6wbPJGImiZOLPKd3r+0TUgshMdAwrLIbvE1Mx/OWWWrnckRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576058; c=relaxed/simple;
	bh=WlX+dozufc02FZe4Hc0+mplEsajiiRwOJwckqJVpHtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqajKSUfJasj1rYB2IOAURGDyImvLoHvQKnIhRwU2DZbr2pS0G04SM9Ss95rltwFX30Rpj5LjPCu4+lalcyht5DUv9xLrNx7/c/8n89jmL4naArvx7/H0PqDYEfQKG6rJ7gs56I1kswcu8PR/9aBNZlqe12RwTFl4uXvALXx4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FGjRBvyl; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FGjRBvyl"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1082558a91.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576049; x=1791180849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYPHLxRCoCRJm3Z+J7edTwjlfU47slzdeJKhcKt1zeQ=;
        b=dvg+Fyc5GQmnb3XQ/Hmwx+5X8O6ncaNB9tG32F1c3+CiWQxwIGUImK9/Z9BCcGsiaM
         JqpCqloHt1rb952JxfqnHdwxJpAiGvEEbYsUI8HM4dEmtN7XNXeCWloEH3Q8DsGVtLcC
         8z755pi/cEF51ddqK4kboltHE6SVC6grND4py7ioGxfBBrZv6fpt6LSy+wgoGH2NQyGY
         al1ZAcToryA1qccoVELv730Tn/F244Z4T1AzMCMPI/yDOErvShrERCImyovNwrKXP8w1
         75tbCoSD6NqC/6VE70j0wR2gDGxA/wu2cRiQOz3FSukCEUFm3xmb8IT12jGhWOseUTvZ
         AxDQ==
X-Gm-Message-State: AFq9FYIeCJ7+czcH+YyEv64JClErHZir2/0xfE+I9c9eE7KlAWbdKgO/
	6SIvMpG3cbK/l3xDXteclO5z+4PEBBgK5NnUZ+fnzte9dR3dxABMqOHEVq12zhDOCM1fIg5UpUj
	EpCGp+rH0IC6PY0WSFtDntO/BOq0NpXFK5SRO6PvJxSWrb175FoA3EYYvU2064y5OB+oE9iLaiH
	fYFabIm9FjCw5NnghkVTfEDckUCr0DCa2OF3KOSKlaKU5Akq+ZD2ua67aD+7h6xVLRcu8j9fQLv
	VS+aE13cQ==
X-Gm-Gg: AYBFou1wmhgSDN2j+KuxOGH+KOeEt0rY2Cuf9VUH9pD8kdZzHLZhtRjSafxAMTK60y5
	R85bACw7pBSoHwsMb/NQgQjQ9tzPfjeeW5SoT9LLNy0QyqNZS02jiMDI817bIyhj7hGSPYoJ0Y6
	c4Iea317DSWaXp9pGnX/WuAYWXvGaTaSv3aw7QbniHuacAJebmJzIr6C9SduypjwYRpr4EplG5I
	NHNoyY8UWgLyA33siJBBqhb6DOvdNArZTZzyY1rxtNn4F9/rPK2HGAb1XcdLVmyaIdTLLcR6qgi
	IV89BxFyxaKrbhjJWjftTdq3zLWOceztMllfDtpZtn5J9lYhfC3eh2Lo8uDl5DEhtwiJGXH2j1b
	7b9qJhDXyEeGfsPPXzumTj9qjDHC1tTqMbizOgl0L/at91XEV/nYME32OXRVu+y124dk/15K8qW
	373vGdI2lAU4ISp7Zj2KLDCyTl+CAO7woZ6QHH
X-Received: by 2002:a17:90b:35c4:b0:3a2:aebf:9211 with SMTP id 98e67ed59e1d1-3a2aebf93a6mr1653896a91.15.1790576049275;
        Sun, 27 Sep 2026 23:14:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a0f55a3abcsm266949a91.2.2026.09.27.23.14.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 23:14:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-342217d8d53so8712696eec.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790576047; x=1791180847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYPHLxRCoCRJm3Z+J7edTwjlfU47slzdeJKhcKt1zeQ=;
        b=FGjRBvylGMv47uUwv4qWdmM7iS/WAGtYCBUZZYuBsSTUZW3DcdUswQMRwNGIcAoBUQ
         qNFlc5eXMJaCG3ot1RtqjAVx7PZrIRYN9lpIpTif07g5O3VaCEXauJuWtQoU7m66PSHt
         +JxMp+uFXzdoIg+84esucq88o01dp77mzV7/U=
X-Received: by 2002:a05:701b:4287:20b0:144:c127:dd1b with SMTP id a92af1059eb24-146d04985a0mr9454974c88.39.1790576046747;
        Sun, 27 Sep 2026 23:14:06 -0700 (PDT)
X-Received: by 2002:a05:701b:4287:20b0:144:c127:dd1b with SMTP id a92af1059eb24-146d04985a0mr9454927c88.39.1790576046027;
        Sun, 27 Sep 2026 23:14:06 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm17355561c88.17.2026.09.27.23.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:14:05 -0700 (PDT)
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
Subject: [net-next, v4 09/10] bnge: add aRFS flow steering ndo support
Date: Mon, 28 Sep 2026 11:43:06 +0530
Message-ID: <20260928061307.1172344-10-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

Note that, If the L2 filter is freed before sp_task programs the rule,
the captured firmware id is stale, the NTUPLE alloc either
fails (id gone) or binds to a recycled id for a different filter.
Either way the rule is dropped or aged out by rps_may_expire_flow()
and recreated -- best-effort aRFS self-heals, and no filter object
is dereferenced (only the id is copied).

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_filter.c  |  53 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |   2 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 127 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   1 +
 5 files changed, 180 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index 8e9cfbad98e0..08db761e4ca6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -1189,7 +1189,7 @@ static u32 bnge_get_all_fltr_ids_rcu(struct bnge_net *bn,
 
 		head = &tbl[i];
 		hlist_for_each_entry_rcu(fltr, head, hlist) {
-			if (!fltr->flags ||
+			if (!bnge_is_usr_fltr(fltr) ||
 			    test_bit(BNGE_FLTR_FW_DELETED, &fltr->state))
 				continue;
 			ids[j++] = fltr->sw_id + offset;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index 764c967c6457..17a837fea79d 100644
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
@@ -531,7 +531,7 @@ int bnge_insert_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *fltr,
 	hlist_add_head_rcu(&fltr->base.hlist, head);
 
 	bnge_insert_usr_fltr(bn, &fltr->base);
-	bn->ntp_fltr_count++;
+	WRITE_ONCE(bn->ntp_fltr_count, bn->ntp_fltr_count + 1);
 
 	spin_unlock_bh(&bn->ntp_fltr_lock);
 
@@ -637,3 +637,48 @@ void bnge_clear_usr_fltrs(struct bnge_net *bn)
 		}
 	}
 }
+
+void bnge_cfg_ntp_filters(struct bnge_net *bn)
+{
+#ifdef CONFIG_RFS_ACCEL
+	struct bnge_ntuple_filter *fltr, *tmp;
+	LIST_HEAD(install_list);
+	LIST_HEAD(expire_list);
+	int i, rc;
+
+	rcu_read_lock();
+	for (i = 0; i < BNGE_NTP_FLTR_HASH_SIZE; i++) {
+		hlist_for_each_entry_rcu(fltr, &bn->ntp_fltr_hash_tbl[i],
+					 base.hlist) {
+			if (test_bit(BNGE_FLTR_VALID, &fltr->base.state)) {
+				if (fltr->base.flags & BNGE_ACT_NO_AGING)
+					continue;
+				if (rps_may_expire_flow(bn->netdev,
+							fltr->base.rxq,
+							fltr->flow_id,
+							fltr->base.sw_id))
+					list_add(&fltr->base.list_node,
+						 &expire_list);
+			} else {
+				list_add(&fltr->base.list_node, &install_list);
+			}
+		}
+	}
+	rcu_read_unlock();
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
+		bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr);
+		bnge_del_ntp_filter_rcu(bn, fltr);
+	}
+#endif
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
index a0d961a01847..4b302c02dd19 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -96,6 +96,7 @@ struct bnge_ntuple_filter {
 #define BNGE_FLTR_ID_INVALID	cpu_to_le64(0xffffffffffffffffULL)
 
 void bnge_free_ntp_fltrs(struct bnge_net *bn, bool skip_user_filters);
+bool bnge_is_usr_fltr(struct bnge_filter_base *fltr);
 u32 bnge_get_ntp_filter_idx(struct bnge_net *bn, struct flow_keys *fkeys,
 			    const struct sk_buff *skb);
 int bnge_insert_ntp_filter(struct bnge_net *bn, struct bnge_ntuple_filter *fltr,
@@ -121,4 +122,5 @@ void bnge_del_ntp_filter_rcu(struct bnge_net *bn,
 			     struct bnge_ntuple_filter *fltr);
 void bnge_cfg_usr_fltrs(struct bnge_net *bn);
 void bnge_clear_usr_fltrs(struct bnge_net *bn);
+void bnge_cfg_ntp_filters(struct bnge_net *bn);
 #endif /* _BNGE_FILTER_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 19ec36b08765..de7818d2c2af 100644
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
 
@@ -3176,6 +3185,121 @@ static int bnge_set_features(struct net_device *dev, netdev_features_t features)
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
+	/* Filter already exists; return its id.  A stale filter (queue
+	 * changed) is freed later via rps_may_expire_flow() and recreated.
+	 */
+	if (fltr) {
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
@@ -3185,6 +3309,9 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_features_check	= bnge_features_check,
 	.ndo_fix_features	= bnge_fix_features,
 	.ndo_set_features	= bnge_set_features,
+#ifdef CONFIG_RFS_ACCEL
+	.ndo_rx_flow_steer	= bnge_rx_flow_steer,
+#endif
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 221dfcd81e78..bb68762f62a8 100644
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

