Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E330AAD8
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670138; cv=none; b=te04HFmQbNmnRSCjxOdOeFCZYv8vsEfcsb8VC1hCehfLvI8EHJuDrja5Wr22j1HMD57gYZj508LcM/Whv/ZOdJ8XEiaSrOCKqIHsR6/fYncb+owlnPgWp35OU3v4WgDN3uwP2w7YJQ5BDc3EHdgKOyjT+cG3sFoIGAOrEmOtDFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670138; c=relaxed/simple;
	bh=tjId4RcqEvjTSnfgQm6K9XQz4SxS/yQvdAt5fI3cn+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvsqZZtGTgXouviUFl7B+feXGfDONPQ6NOzdyHJUVzLM9tMMPThjHumTKtLaqaq5q5El4FuolCH5D+/Rn7Lucnqe/MG8yHiqHfMOU6Vs6TyMmATAKImSZIb5sHwOXgE1WNq0cttSkc/rDVkO4Mub80uqb3iVWmt8Sih/BvbiiXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bI0PWfgw; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bI0PWfgw"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso340635a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670136; x=1787274936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4ucAbk0XiEMbZfP6OfXQBqNyBmgu0nDujyqzUaMTeo=;
        b=DL5ZCeOGl5ReTQx0aWsjyO0mtVmlPnlBHEU3Rt0GPy4vhbm1v0kydatIcD85wFZ5T1
         OBY1+7ELNIucp441OiFfxU7igb3/ksxbLTEYGSIRKxXIHzh2PmxYnmbveewq6CcXfxb+
         Bf2t72nzIgBUKsrPIIigmqRoqM1WO/KhJLyebWl7KqnM/fPNR9UR0f3F7ekiEuN5qKz4
         PVtURDkAXXGhlP+qxHuGHXSdxSFkN7A4tmHvDsytFcNFXUYvzXpO9fQ20bnAHqinrEtu
         cDYvF3ToEtkLHiC98XZqPlaeVFhcjq6QhsioAafBRcc+vdUX5UqsBvBCUW+l5sklYAnC
         b1sw==
X-Gm-Message-State: AOJu0Yz5OsgRzEGJd5FgGuvNGVIThmcLmXx/N6W9vxErRpr44/6ljRNS
	YRqEs41GE79/GikgssnAmWU+8nN4+aH0qjzKFVxGmBXq+lBlDO0CIZX/fV66RV4M8CYhiwajuW/
	yISvPZEeoCMxHrr5Sojdelfykhv9pMdBFNit+3XRo/2JlP3R0iJSyVsw5wS1yUpcAru37G+lxYy
	H2r2mLM1+OqoIybBN+SRwNudHu2lhCqdZSGT6sFEQlvQsa4ilbmonHiR4K9A/IZwGced3oj4wAq
	b03zdUhnw==
X-Gm-Gg: AR+sD12irRdyVzPkJvz6kqiqUaxrBGRZFZs7wa6b5UqbBZdlmtX3Zmu32VYSxPa7IRB
	2OyAvfYMew3Rh+b621IYIbWkFugD/Reokfi83G0TW2FiLpkV9w4opZaYdEM5GFVxi+0/KrmEvcX
	55VkKDVH8MZXviD7MbzBS7fRT3f1oNXesG9PNzonNEcHStWSJd8qX0pmW8MvvnS9NsJ57mUla30
	kngTsV9NhGgKz0g5wsgoUDdN2wV4mJ1/LhKlj/eQBHGBLjzfkAgeT8OioRBc/L/sbuylE6tA9Ip
	bAy1FrPg8hoe4rSn8sw8GIk0YySSMUlkTjKauvv5v0UqHiUZ5vgLuKNYSX610YPmDBklyO2vSTg
	6V0b3xE52G/r4V/4BiYylEfT1OBzlW5e5wRUxtfzwJeYJjkVcIjv4UlFhLvTajdjeyePxGQzeir
	4LAwenVd8S19gZTfQXIqxQ3RDwY/DEd28=
X-Received: by 2002:a17:90b:2810:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-3933b8f4527mr2225828a91.15.1786670136209;
        Thu, 13 Aug 2026 18:15:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-394eab91cd3sm112360a91.6.2026.08.13.18.15.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 18:15:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso304543a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786670134; x=1787274934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4ucAbk0XiEMbZfP6OfXQBqNyBmgu0nDujyqzUaMTeo=;
        b=bI0PWfgw6Y/kA5H/yQ2eaLK/GfuATOS0cbVFMoAeR7au3V818ulNh73Gejw+WQ2HK2
         exB5VofzLlSmu4GPWtSgr1Fs54RfDUIbtAv1GdTq8151O+VZUGRFtGjg5W9mTFWFxCKW
         JPH54nT1eX2NqVZGFICLE4f52TJlUhpkFxrGk=
X-Received: by 2002:a05:6a21:3398:b0:3b3:2703:110 with SMTP id adf61e73a8af0-3cc719fd454mr2166005637.4.1786670134157;
        Thu, 13 Aug 2026 18:15:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:3398:b0:3b3:2703:110 with SMTP id adf61e73a8af0-3cc719fd454mr2165929637.4.1786670133464;
        Thu, 13 Aug 2026 18:15:33 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm12174177eec.11.2026.08.13.18.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:15:33 -0700 (PDT)
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
Subject: [PATCH net-next 10/11] bnge: add aRFS flow steering ndo support
Date: Fri, 14 Aug 2026 06:44:34 +0530
Message-ID: <20260814011435.194631-11-vikas.gupta@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 101 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   1 +
 4 files changed, 148 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index f239ec686405..6f75e08a4996 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
@@ -586,3 +586,48 @@ void bnge_cfg_usr_fltrs(struct bnge_net *bn)
 	list_for_each_entry_safe(usr_fltr, tmp, &bn->usr_fltr_list, list_node)
 		bnge_cfg_one_usr_fltr(bn, usr_fltr);
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
+			bnge_del_ntp_filter(bn, fltr);
+		else
+			set_bit(BNGE_FLTR_VALID, &fltr->base.state);
+	}
+
+	list_for_each_entry_safe(fltr, tmp, &expire_list, base.list_node) {
+		list_del_init(&fltr->base.list_node);
+		bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr);
+		bnge_del_ntp_filter(bn, fltr);
+	}
+#endif
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
index bbe50d404d70..c2f2f754452c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -118,4 +118,5 @@ void bnge_del_ntp_filter(struct bnge_net *bn,
 void bnge_del_ntp_filter_rcu(struct bnge_net *bn,
 			     struct bnge_ntuple_filter *fltr);
 void bnge_cfg_usr_fltrs(struct bnge_net *bn);
+void bnge_cfg_ntp_filters(struct bnge_net *bn);
 #endif /* _BNGE_FILTER_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 0b0358e30220..fc752fe879b6 100644
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
 
@@ -3123,6 +3131,96 @@ static const struct netdev_stat_ops bnge_stat_ops = {
 	.get_base_stats		= bnge_get_base_stats,
 };
 
+#ifdef CONFIG_RFS_ACCEL
+static u32 bnge_lookup_l2_filter_from_key(struct bnge_net *bn,
+					  struct bnge_l2_key *key)
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
+	u32 flags, idx, filter_id;
+	struct flow_keys *fkeys;
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
+	    ((fkeys->basic.ip_proto != IPPROTO_TCP) &&
+	     (fkeys->basic.ip_proto != IPPROTO_UDP))) {
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
@@ -3130,6 +3228,9 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_set_rx_mode_async	= bnge_set_rx_mode,
 	.ndo_features_check	= bnge_features_check,
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
2.47.1

