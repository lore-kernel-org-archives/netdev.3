Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D24446F5
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627623; cv=none; b=upXreZLc9lw3He/Tz/oXDh24kO6S5qCo2Iqom5nCTq09W+si0chE418H+4OWqtqy9ia3IUcDenlAd92iXBwPKRnuNaG3Hnzut0J/Do/e/u4BL27PfuIJVkF2of7YPxkYOoQ3pmmhVAUdyyMEhNqZ5LejloIpZbc5exTqKvOKrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627623; c=relaxed/simple;
	bh=xWKtKjAimhawaEJZEncG7oDfMZ8jrMbCnP5wiXIdfnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emk1qdCP31v0V1IrzPjn0FxWg1J28vk86qlxFuXIc0y3PNeHitA+yUJzfrkoJeFzxM9VDltTp60eR7sjBtG/nNlSYacpPF/nR5oYCP+AIcXmyJJzYkrjBwU9EA7PVYxVulqTskuIjAuxqJhV+2icqma2IDHSB5xuBg/gaJwKNbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T85Pjcbk; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T85Pjcbk"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-398b3c37877so147025a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627621; x=1790232421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WnFkKlS5WARQKCpGuZojTqxptSVM2xGpYdtnYIiPoQU=;
        b=lo0X1gzEiOEGR2aeFh+zi6+0AMNJ//YhCEvS+ZCObmt2wywAaQnr5dNsBNuLAAJJSy
         x5WaWgIc3Vp7acSNWPSfkhdzGXBZbCwWfFPRddhq262paAtbd3qaic1QMUT6lS9G1tpm
         ZGi+wPdbD7LDBa3oFvQ0nTjwRFQ3Kt6aLOuc6ZJ4g3SNqgX5rv6wAsiKFsi/ob+NrZTe
         z186XYAe2k0mHPFsyvc0WWn/SDDNqJbcIWDjXTZ4jFlO8KMQIflryhmRPe6m8Q6Q7vNz
         NSxL0vV7joRrhkOsQt889tlURzT9Pa589DjXXhvUtlYtA2trzV3be2O/ntTEKTUK4gr1
         9p6Q==
X-Gm-Message-State: AFuF++lx/7tO1kWartcEruhZyiMTfcoPKalt3gZ6cT51yNfYOD89TFnM
	/CjHQJwMBA72RuPDKz+xDUgXsdp5uIHVHxie10yjQBzvoO4b3c8/Fedf/Ey2wIzlGdThSaZGyTp
	bpHdvXVEOSHNAERvOA/1vEYlfq2nYLeQSwrfOIjOLZfmUnk3aIKcwTG9bC1irC2pRKnN0MKVrNl
	9PIKAD8WWPVc0lWzFT+on6Xx/hqMh7/Fx2yi6j0q2XFwprO8iF4TXVaMUV8O+EZpW76e5foJLUp
	3N02BuQCA==
X-Gm-Gg: AYBFou1Q57PQd+yZnLEqsOLwo0lu904RqltzWCeT2zc67YgZH1rorMxonjzcRtlJrJW
	W6sS+aAaf5SFIC/RDHgNWUuVHwKNq1i09I45G5VOljccCvZXane9JJf9hI/UIbks5sWYyM3u0zE
	fbD02CgFlnkjbyJUn/GeDiKDYkvbiyXjuMQ6ljBg36pwvxD6Kf4ihE3H5EumpDucuNK5H4bKSAY
	NDLtexgtfC0CrZiBoCubjeCOHYLWnb6D+wN+4+/c2oiwCd2TSPbpEczP0/kFBda6J6JaA3aCw3L
	LOn6uxM2fxMAxCa+hMf9FdLmWZfA13tui53hAmuEibyXsCn56+SUvAvLrZiBu9Txr9ZpTeRtzm/
	sZ92GTuHXqzuscMbyzKw3LoOm2Yk63/iC6hOUU4g1wqDfIJHSmTHyhvF5zP4H6O7aCdAmAL4HlD
	zWdYryxS3tC7JH2Yle1pFAMFkxlunWzqrSGw==
X-Received: by 2002:a17:90a:d88b:b0:39e:3baa:bd3a with SMTP id 98e67ed59e1d1-39e3baae393mr3738580a91.12.1789627620359;
        Wed, 16 Sep 2026 23:47:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e362c655fsm1055180a91.7.2026.09.16.23.46.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 23:47:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso490685a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789627618; x=1790232418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WnFkKlS5WARQKCpGuZojTqxptSVM2xGpYdtnYIiPoQU=;
        b=T85PjcbkdWofpRFkdvxsujTymSMlNHen/ro05W7/kRevGu3z48S3sg/LpBym3pGg68
         586NWXC/X70jXyEeSuADitF0tEAKGtaISJUOu4YzWGOBXi7MksAJoZk+LS5HUAkCvyeC
         BLkifS71ShfCkYQwmUoqRH870Xh8WrE+h57Bc=
X-Received: by 2002:a05:6a21:4a81:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3dd5f3f8a8fmr13321653637.4.1789627618471;
        Wed, 16 Sep 2026 23:46:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:4a81:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3dd5f3f8a8fmr13321597637.4.1789627617989;
        Wed, 16 Sep 2026 23:46:57 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm2754293a12.20.2026.09.16.23.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:46:57 -0700 (PDT)
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
Subject: [net-next, v3 10/11] bnge: add aRFS flow steering ndo support
Date: Thu, 17 Sep 2026 12:15:47 +0530
Message-ID: <20260917064548.773334-11-vikas.gupta@broadcom.com>
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

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_filter.c  |  45 ++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |   1 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 105 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   1 +
 4 files changed, 152 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index 8d905252fe5e..2f9754450fbf 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
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
index f1f43537ab97..a7cd1fd01565 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -119,4 +119,5 @@ void bnge_del_ntp_filter_rcu(struct bnge_net *bn,
 			     struct bnge_ntuple_filter *fltr);
 void bnge_cfg_usr_fltrs(struct bnge_net *bn);
 void bnge_clear_usr_fltrs(struct bnge_net *bn);
+void bnge_cfg_ntp_filters(struct bnge_net *bn);
 #endif /* _BNGE_FILTER_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 091de9624db4..9021a73ae613 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -303,6 +303,11 @@ static void bnge_timer(struct timer_list *t)
 	if (BNGE_LINK_IS_UP(bd) && bn->stats_coal_ticks)
 		bnge_queue_sp_work(bn, BNGE_PERIODIC_STATS_SP_EVENT);
 
+#ifdef CONFIG_RFS_ACCEL
+	if ((bn->priv_flags & BNGE_NET_EN_NTUPLE) && bn->ntp_fltr_count)
+		bnge_queue_sp_work(bn, BNGE_RX_NTP_FLTR_SP_EVENT);
+#endif
+
 	mod_timer(&bn->timer, jiffies + bn->current_interval);
 }
 
@@ -444,6 +449,9 @@ static void bnge_sp_task(struct work_struct *work)
 			bnge_init_ethtool_link_settings(bn);
 	}
 
+	if (test_and_clear_bit(BNGE_RX_NTP_FLTR_SP_EVENT, &bn->sp_event))
+		bnge_cfg_ntp_filters(bn);
+
 	netdev_unlock(bn->netdev);
 }
 
@@ -3175,6 +3183,100 @@ static int bnge_set_features(struct net_device *dev, netdev_features_t features)
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
+	if (ether_addr_equal(dev->dev_addr, eth->h_dest)) {
+		struct bnge_l2_filter *l2_filter;
+
+		l2_filter = bn->vnic_info[BNGE_VNIC_DEFAULT].l2_filters[0];
+		filter_id = l2_filter->base.filter_id;
+
+	} else {
+		struct bnge_l2_key key;
+
+		ether_addr_copy(key.dst_mac_addr, eth->h_dest);
+		key.vlan = 0;
+
+		filter_id = bnge_lookup_l2_filter_from_key(bn, &key);
+		if (filter_id == BNGE_FLTR_ID_INVALID)
+			return -EINVAL;
+	}
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
@@ -3184,6 +3286,9 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_features_check	= bnge_features_check,
 	.ndo_fix_features	= bnge_fix_features,
 	.ndo_set_features	= bnge_set_features,
+#ifdef CONFIG_RFS_ACCEL
+	.ndo_rx_flow_steer	= bnge_rx_flow_steer,
+#endif
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index bfd0d9cb871f..3146023621a6 100644
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

