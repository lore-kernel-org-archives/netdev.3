Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784E4477E5;
	Mon, 21 Sep 2026 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020899; cv=none; b=jLrtiCQfWcTcygAk1/UNSASMSpPlFCYtRk6FIsus0JUcnFLL3Xyrlm+qOpwWPfSN0nAVyTGvrmXam7Aqdg/oYfZNNuxM2k3i/ulwv8h/B2noK06UNBY9B3mhf1IkGYP1z5IVY43/Vp1LPH6LmbCuDGppvHc30+cLfOr0PChPIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020899; c=relaxed/simple;
	bh=97AQflgcrISq9kq6KIsEFL3PJhF/AZZXOndehlbI310=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aDzV0A8Ku8LZ62N2yf8h9bgLfGf9brWUr3nD0BBYTrDgZ+KcGF9tBLyUQa2zUpJLZlxLav5w+HW3w52zKq4A+Z1rcTplSm14uOpElJNNQnhHSSD39dPqXxM8b9CieZL3bLj+3Wh/89vFd0z8meh8EUNH3ljFTL9ZmpKn3ZLhNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=RPeIxWpk; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="RPeIxWpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=21904; q=dns/txt;
  s=iport01; t=1790020895; x=1791230495;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4bJqR62WhhlN4A4Mw0qPqB+p2WmSAOX2OVh36VPQe8A=;
  b=RPeIxWpkv18VkWr9Bl1rzg3kx0NPdNaPVJ7lF61GFjKpvDap1oKvmc0X
   fqBiePuTeusgvk0R40jwGeumF6WJ4b/9QCcO2DcYQGKQHfgyTnl7Mky1y
   jtfFRvirV0nLERVCbo+upwuRlRp1ql5eCCVx2ywlizhieZ3wpPYsV3wTF
   PBC8NK3PV9MwiFva+LevQRO8h1g13Vr2RGQF6dap3ik3cFUCeGN3RZEod
   ksziQREoBsmh2gBRhBSXAZaSFbyg0XmrwX4Bnww5n7EfooynvltgO59/0
   VijFQfD/ZgtobYZG4M5uWioeRweoKFLRNefgjUXQn6KLQA1UM8KXE2F2Y
   g==;
X-CSE-ConnectionGUID: 6eRiGjFbTVS0cJq5R4KoTw==
X-CSE-MsgGUID: 2MbnUD+4RQ6K9LwvdkwxRA==
X-IPAS-Result: =?us-ascii?q?A0A9AAAnjLFq/47/Ja1aHQEBAQEJARIBBQUBgX0HAQsBg?=
 =?us-ascii?q?laBVUNJhFePUoIhkU2MURSBag8BAQEPUQQBAYUFAo4HAiY1CA4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZckBMCAQMaCQRAEhAlAiYCAkYQB?=
 =?us-ascii?q?gESgwKCdQPFbHp/M4EBhH7ZSoFoAQsUAYEKLgGFcIJtAYFwhAg7hEEnG4FJR?=
 =?us-ascii?q?IEVg2mEGwQLg3SCagSDHBKCZoczikEJP4ECHANZLAFVEw0KCwcFYVIzAyAKC?=
 =?us-ascii?q?xISGBUCFB0SDwQWMh1wDCcSLBcvWBsGBYEdfBQEE4IaIxk2eoEJXoErKWABE?=
 =?us-ascii?q?BeBB4IIAoJUgX8CAUlDDgdFUwknQQoSRykiCBIJARMaMAuBJxgNSBEsNwYPG?=
 =?us-ascii?q?QQ9AW4Hj14fgWoBUR8BAQ0fLRsPC3tBHRUOFxUFAQEtAUWSVwwdJYM8jV9rg?=
 =?us-ascii?q?TWfWoQogWagEDOEBJNjkwaZCCOCNqETBg8JAQJNhGmBagE5gVkzGggbFTuCZ?=
 =?us-ascii?q?1MZD44uFpMdAbx7JzI9AQEHAgcOAwuBaJAAAQQMF4FWAQE?=
IronPort-Data: A9a23:BtUcRari4ThduIyGt2OuH24XJd5eBmLKZBIvgKrLsJaIsI4StFCzt
 garIBmBPKzZZDfzLowgaYW28hkB75XXm9ViSwJp+Hw8Qi5A+OPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOWn9T8jhfngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgDNNwJcaDpOtfrS8ko35pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0rh6O2Bh9
 9ISFA42Nhuhnr+MnJG8dvY506zPLOGzVG8ekmtrwTecCbMtRorOBv2Xo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LUvrSn8/w7pX7WyZRtFOOpak3y2PS1wd2lrPqNbI5f/TXHJwLzx3B/
 TquE2LRWDQQMuGzima/yyyP18vQgy/4R5IoPejtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW3p3mLuhNaUN1Ve8U67xuI0YLX7hyfC2xCSSROAPQlqcU/bT8nz
 FmEm5XuHzMHmLSTRWiQ6fSSoC++NDY9KXIEY2kPTWMt+9DprYcypgjCQtZqDOi+ididMTXxx
 S2a6SsznbMeieYV2Kihu1PKmTShot7OVAFdzgPaQm6o8Ctna4O/IY+l817W6bBHNonxc7Wal
 GIPl87b6KUFCouA0XTQBu4MB7quof2CNVUwnGJSInXozBz1k1bLQGyayGsWyJtBWircRQLUX
 Q==
IronPort-HdrOrdr: A9a23:iWt0Y66y8Yn/ZfCucwPXwD7XdLJyesId70hD6qm+c20wTiX+ra
 GTdZUguyMc5wx9ZJhNo7q90ey7MBHhHP1OjrX5Q43DYOCOggLBR72Kr7GSoAEIcBeTygcy79
 YET4FOTPD9ElR+i9/3+02bH8ZI+qj/zImYwcrT0HtpSxhncOVb7wl/AhuGCUEefnghOXNALu
 v62uN34xy9ZH8QcsO3QlMBX+TFupn3saiOW29/O/bigzP+9w9BL9XBYmOl4is=
X-Talos-CUID: 9a23:IWqeVWz4wtcD/Gd0pXaRBgVKF/okXX/zxkvuGBezK380cuG2TmOPrfY=
X-Talos-MUID: 9a23:DfhvKQoR359KdX0+6Ukez2tHPsFVz+fyMnlTssQipNeINjNgAR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,115,1787011200"; 
   d="scan'208";a="511693130"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Sep 2026 20:00:26 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id 7B3421800035F;
	Mon, 21 Sep 2026 20:00:25 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 21 Sep 2026 12:59:49 -0700
Subject: [PATCH net-next 6/6] enic: configure V2 VF receive mode over
 mailbox
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-6-67a0a6e08d43@cisco.com>
References: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
In-Reply-To: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790020820; l=22763;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=97AQflgcrISq9kq6KIsEFL3PJhF/AZZXOndehlbI310=;
 b=A94ebD6OsA/IJG7Zk310tz0ubS469eyk/XJ9EsGYDeLxnzQE+8qq7YKXzFyPKrxjSkDJB368k
 tq4beHfEiCmAwZSFz/oyiIecKy3zbRLMypWDywp6v/dkR36vHoTLCWL
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-05.cisco.com

V2 VFs cannot program receive filters directly. Add an asynchronous
receive-mode callback that sends individual unicast and multicast address
changes and packet-filter settings through the VF's one-request-at-a-time
mailbox path.

Keep each callback to at most one VF mailbox request. Enable newly required
broad receive coverage before changing individual-address filters, remove
stale broad coverage before replaying a finite address list, and schedule a
fresh callback for the second half of a successful two-step transition.

Use the netdev address-list synchronization state to batch operations:
sync_cnt == 0 identifies a new entry, refcount > sync_cnt identifies an
address that is still requested, and refcount == sync_cnt identifies an
installed entry which has become stale. The asynchronous netdev core
reconciles the resulting sync_cnt changes from the snapshot back to the
live list.

Track detailed per-address results so idempotent outcomes converge, stable
policy denials do not consume the retry budget, and failed deletes or
contradictory replies require a new VF registration. Keep the station
address out of the secondary-unicast list.

Select the asynchronous netdev operations only for V2 VFs and detach the
device before mailbox teardown so no receive-mode callback can race
removal.

Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   4 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 499 +++++++++++++++++++++++++++-
 2 files changed, 490 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 0f0ef68130f2..a20ca8fa7927 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -382,6 +382,10 @@ struct enic {
 	 */
 	struct enic_mac_addr *mbox_reply_mac_addrs;
 	u16 mbox_reply_mac_count;
+	u16 vf_pkt_filter_requested;
+	u16 vf_pkt_filter_applied;
+	bool vf_pkt_filter_valid;
+	bool vf_pkt_filter_update_pending;
 	bool mbox_initialized;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 16412c29e932..1cc1935ee5c2 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1051,6 +1051,8 @@ void enic_reset_addr_lists(struct enic *enic)
 	enic->mc_count = 0;
 	enic->uc_count = 0;
 	enic->flags = 0;
+	enic->vf_pkt_filter_valid = false;
+	enic->vf_pkt_filter_update_pending = false;
 }
 
 static int enic_set_mac_addr(struct net_device *netdev, char *addr)
@@ -1348,8 +1350,12 @@ static void enic_vf_admin_mac_work(struct work_struct *work)
 	if (station_installed)
 		enic_vf_station_addr_set(enic, selected);
 	enic_vf_station_sync_reset(enic);
-	if (enic->netdev->reg_state == NETREG_REGISTERED && changed)
-		call_netdevice_notifiers(NETDEV_CHANGEADDR, enic->netdev);
+	if (enic->netdev->reg_state == NETREG_REGISTERED) {
+		if (changed)
+			call_netdevice_notifiers(NETDEV_CHANGEADDR,
+						 enic->netdev);
+		netif_rx_mode_schedule_fresh(enic->netdev);
+	}
 	netdev_info(enic->netdev, "MBOX: admin MAC set to %pM\n", selected);
 
 unlock:
@@ -1561,6 +1567,7 @@ static int enic_set_mac_address_dynamic(struct net_device *netdev, void *p)
 			enic_vf_station_addr_set(enic, addr);
 			enic_vf_station_sync_reset(enic);
 			enic_vf_admin_mac_cache_selected(enic, addr);
+			netif_rx_mode_schedule_fresh(netdev);
 		}
 
 		return err;
@@ -1603,17 +1610,412 @@ static int enic_set_mac_address(struct net_device *netdev, void *p)
 	return enic_dev_add_station_addr(enic);
 }
 
+static u16 enic_rx_mode_to_pkt_filter(struct net_device *netdev,
+				      unsigned int uc_count,
+				      unsigned int mc_count)
+{
+	u16 flags = CMD_PFILTER_DIRECTED;
+
+	if (netdev->flags & IFF_MULTICAST)
+		flags |= CMD_PFILTER_MULTICAST;
+	if (netdev->flags & IFF_BROADCAST)
+		flags |= CMD_PFILTER_BROADCAST;
+	if ((netdev->flags & IFF_PROMISC) ||
+	    uc_count > ENIC_UNICAST_PERFECT_FILTERS)
+		flags |= CMD_PFILTER_PROMISCUOUS;
+	if ((netdev->flags & IFF_ALLMULTI) ||
+	    mc_count > ENIC_MULTICAST_PERFECT_FILTERS)
+		flags |= CMD_PFILTER_ALL_MULTICAST;
+
+	return flags;
+}
+
+static int enic_vf_set_pkt_filter(struct enic *enic, u16 flags,
+				  u16 *applied_flags)
+{
+	u16 applied;
+	int err;
+
+	/* The PF can change trust policy independently and thereby withdraw
+	 * broad modes. Always refresh those requests so the returned applied
+	 * flags remain authoritative. The other modes are not trust-gated and
+	 * can be reused for ordinary address-list churn.
+	 */
+	if (!(flags & (CMD_PFILTER_PROMISCUOUS |
+		       CMD_PFILTER_ALL_MULTICAST)) &&
+	    enic->vf_pkt_filter_valid &&
+	    enic->vf_pkt_filter_requested == flags) {
+		if (applied_flags)
+			*applied_flags = enic->vf_pkt_filter_applied;
+		return 0;
+	}
+
+	err = enic_mbox_vf_set_pkt_filter(enic,
+					  !!(flags & CMD_PFILTER_DIRECTED),
+					  !!(flags & CMD_PFILTER_MULTICAST),
+					  !!(flags & CMD_PFILTER_BROADCAST),
+					  !!(flags & CMD_PFILTER_PROMISCUOUS),
+					  !!(flags & CMD_PFILTER_ALL_MULTICAST),
+					  &applied);
+	if (err)
+		return err;
+
+	enic->vf_pkt_filter_requested = flags;
+	enic->vf_pkt_filter_applied = applied;
+	enic->vf_pkt_filter_valid = true;
+	if (applied_flags)
+		*applied_flags = applied;
+
+	return 0;
+}
+
+static void enic_vf_report_pkt_filter_denial(struct net_device *netdev,
+					     u16 requested, u16 applied)
+{
+	if ((requested & CMD_PFILTER_PROMISCUOUS) &&
+	    !(applied & CMD_PFILTER_PROMISCUOUS))
+		netdev_dbg(netdev, "PF policy denied promiscuous receive mode\n");
+	if ((requested & CMD_PFILTER_ALL_MULTICAST) &&
+	    !(applied & CMD_PFILTER_ALL_MULTICAST))
+		netdev_dbg(netdev,
+			   "PF policy denied all-multicast receive mode\n");
+}
+
+struct enic_vf_mac_op {
+	struct netdev_hw_addr *ha;
+	unsigned int *filter_count;
+};
+
+static unsigned int
+enic_vf_addr_list_count(const struct enic *enic,
+			const struct netdev_hw_addr_list *list,
+			bool unicast)
+{
+	const struct netdev_hw_addr *ha;
+	unsigned int count = 0;
+
+	netdev_hw_addr_list_for_each(ha, list)
+		if (ha->refcount > ha->sync_cnt &&
+		    !(unicast && enic->vf_station_addr_valid &&
+		      ether_addr_equal(ha->addr, enic->vf_station_addr)))
+			count++;
+
+	return count;
+}
+
+static int enic_vf_collect_mac_ops(struct enic *enic,
+				   struct netdev_hw_addr_list *list,
+				   bool unicast,
+				   bool install_new,
+				   unsigned int *filter_count,
+				   struct enic_mac_addr *macs,
+				   struct enic_vf_mac_op *ops,
+				   u16 *num_ops)
+{
+	struct netdev_hw_addr *ha;
+	u16 pos = *num_ops;
+
+	/* Deletes precede adds so a full perfect-filter table has room for a
+	 * replacement address in the same transaction.
+	 */
+	netdev_hw_addr_list_for_each(ha, list) {
+		if (unicast && enic->vf_station_addr_valid &&
+		    ether_addr_equal(ha->addr, enic->vf_station_addr))
+			continue;
+		if (!ha->sync_cnt ||
+		    ha->refcount != ha->sync_cnt)
+			continue;
+		if (pos == ENIC_MBOX_MAX_MAC_OPS)
+			return -E2BIG;
+
+		ether_addr_copy(macs[pos].addr, ha->addr);
+		macs[pos].flags = 0;
+		ops[pos].ha = ha;
+		ops[pos].filter_count = filter_count;
+		pos++;
+	}
+
+	if (!install_new)
+		goto done;
+
+	netdev_hw_addr_list_for_each(ha, list) {
+		if (unicast && enic->vf_station_addr_valid &&
+		    ether_addr_equal(ha->addr, enic->vf_station_addr))
+			continue;
+		if (ha->sync_cnt)
+			continue;
+		if (pos == ENIC_MBOX_MAX_MAC_OPS)
+			return -E2BIG;
+
+		ether_addr_copy(macs[pos].addr, ha->addr);
+		macs[pos].flags = cpu_to_le16(ENIC_MAC_ADDR_FLAG_ADD);
+		ops[pos].ha = ha;
+		ops[pos].filter_count = filter_count;
+		pos++;
+	}
+
+done:
+	*num_ops = pos;
+	return 0;
+}
+
+static int enic_vf_sync_mac_filters(struct enic *enic,
+				    struct netdev_hw_addr_list *uc,
+				    struct netdev_hw_addr_list *mc,
+				    bool install_uc, bool install_mc,
+				    bool *sent)
+{
+	struct enic_vf_mac_op *ops;
+	struct enic_mac_addr *macs;
+	bool permanent_add = false;
+	bool reconnect = false;
+	bool retryable_add = false;
+	u16 num_ops = 0;
+	unsigned int i;
+	int err = 0;
+
+	/* A class can contribute at most its installed perfect filters as
+	 * deletes and its finite perfect-filter limit as adds. Keep the wire
+	 * batch large enough for both classes so an update always fits in one
+	 * transaction and -E2BIG remains only a defensive state-corruption
+	 * check.
+	 */
+	BUILD_BUG_ON(ENIC_MBOX_MAX_MAC_OPS <
+		     2 * (ENIC_UNICAST_PERFECT_FILTERS +
+			  ENIC_MULTICAST_PERFECT_FILTERS));
+
+	*sent = false;
+	macs = kcalloc(ENIC_MBOX_MAX_MAC_OPS, sizeof(*macs), GFP_KERNEL);
+	if (!macs)
+		return -ENOMEM;
+	ops = kcalloc(ENIC_MBOX_MAX_MAC_OPS, sizeof(*ops), GFP_KERNEL);
+	if (!ops) {
+		err = -ENOMEM;
+		goto free_macs;
+	}
+
+	err = enic_vf_collect_mac_ops(enic, uc, true, install_uc,
+				      &enic->uc_count,
+				      macs, ops, &num_ops);
+	if (err)
+		goto free_ops;
+	err = enic_vf_collect_mac_ops(enic, mc, false, install_mc,
+				      &enic->mc_count,
+				      macs, ops, &num_ops);
+	if (err || !num_ops)
+		goto free_ops;
+
+	/* The protocol carries all changed unicast and multicast addresses in
+	 * one request.  Besides matching the native ABI, this bounds time spent
+	 * in the RTNL-held asynchronous receive-mode callback to one MAC reply.
+	 */
+	err = enic_mbox_vf_add_del_macs(enic, macs, num_ops);
+	if (err)
+		goto free_ops;
+	*sent = true;
+
+	for (i = 0; i < num_ops; i++) {
+		u16 flags = le16_to_cpu(macs[i].flags);
+		bool add = flags & ENIC_MAC_ADDR_FLAG_ADD;
+
+		if (flags & ENIC_MAC_ADDR_FLAG_SKIPPED) {
+			if (add)
+				retryable_add = true;
+			else
+				reconnect = true;
+			continue;
+		}
+		if (flags & ENIC_MAC_ADDR_FLAG_PERMANENT_MASK) {
+			if (add)
+				permanent_add = true;
+			else
+				reconnect = true;
+			continue;
+		}
+
+		if (add) {
+			ops[i].ha->sync_cnt++;
+			ops[i].ha->refcount++;
+			(*ops[i].filter_count)++;
+		} else {
+			ops[i].ha->sync_cnt--;
+			ops[i].ha->refcount--;
+			if (WARN_ON_ONCE(!*ops[i].filter_count))
+				err = -EIO;
+			else
+				(*ops[i].filter_count)--;
+		}
+	}
+
+	/* A failed DELETE can leave hardware accepting an address no longer in
+	 * the requested list.  Registration is the fail-closed cleanup boundary.
+	 * A skipped ADD changes no acceptance state and can use the bounded core
+	 * retry path.  Permanent ADD denials remain stable policy results.
+	 */
+	if (reconnect) {
+		enic_mbox_vf_require_reconnect(enic);
+		err = -EIO;
+	} else if (retryable_add) {
+		err = -EAGAIN;
+	} else if (permanent_add) {
+		err = -EACCES;
+	}
+
+free_ops:
+	kfree(ops);
+free_macs:
+	kfree(macs);
+	return err;
+}
+
+static int enic_set_vf_rx_mode(struct net_device *netdev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
+{
+	struct enic *enic = netdev_priv(netdev);
+	unsigned int uc_count = enic_vf_addr_list_count(enic, uc, true);
+	unsigned int mc_count = enic_vf_addr_list_count(enic, mc, false);
+	u16 flags = enic_rx_mode_to_pkt_filter(netdev, uc_count, mc_count);
+	bool uc_overflow = uc_count > ENIC_UNICAST_PERFECT_FILTERS;
+	bool mc_overflow = mc_count > ENIC_MULTICAST_PERFECT_FILTERS;
+	u16 broad_modes = CMD_PFILTER_PROMISCUOUS |
+			  CMD_PFILTER_ALL_MULTICAST;
+	bool broad_enable_needed;
+	bool broad_withdrawal;
+	bool filter_needed;
+	bool sent;
+	u16 prefilter_flags;
+	u16 applied_flags;
+	int err;
+
+	if (!READ_ONCE(enic->vf_registered))
+		return -ENODEV;
+
+	filter_needed = !enic->vf_pkt_filter_valid ||
+			 enic->vf_pkt_filter_requested != flags ||
+			 (flags & broad_modes);
+	broad_enable_needed =
+		(!enic->vf_pkt_filter_valid && (flags & broad_modes)) ||
+		(flags & broad_modes & ~enic->vf_pkt_filter_requested);
+	broad_withdrawal = enic->vf_pkt_filter_valid &&
+		(enic->vf_pkt_filter_applied & broad_modes & ~flags);
+	if (broad_enable_needed) {
+		/* Establish newly required broad coverage before an independent
+		 * exact-address rejection can block it. Retain any broad mode that
+		 * is currently applied until its finite replacement is installed.
+		 */
+		prefilter_flags = flags;
+		if (enic->vf_pkt_filter_valid)
+			prefilter_flags |= enic->vf_pkt_filter_applied & broad_modes;
+		err = enic_vf_set_pkt_filter(enic, prefilter_flags,
+					     &applied_flags);
+		if (err)
+			return err;
+		enic->vf_pkt_filter_update_pending = false;
+		enic_vf_report_pkt_filter_denial(netdev, flags, applied_flags);
+		netif_rx_mode_schedule_fresh(netdev);
+		return 0;
+	}
+
+	/* A permanent exact-address rejection can leave an independent packet
+	 * filter update pending. Give that update the next mailbox transaction,
+	 * unless it would withdraw broad coverage before finite replacements are
+	 * installed. A later receive-mode change can retry the rejected address.
+	 */
+	if (enic->vf_pkt_filter_update_pending) {
+		if (!filter_needed || broad_withdrawal) {
+			enic->vf_pkt_filter_update_pending = false;
+		} else {
+			err = enic_vf_set_pkt_filter(enic, flags, &applied_flags);
+			if (err)
+				return err;
+			enic->vf_pkt_filter_update_pending = false;
+			enic_vf_report_pkt_filter_denial(netdev, flags, applied_flags);
+			return 0;
+		}
+	}
+
+	if (broad_withdrawal) {
+		/* Withdraw stale broad acceptance before installing its finite
+		 * replacement.  Keep this callback to one mailbox transaction and
+		 * queue exact-filter reconciliation as fresh work.  If that later
+		 * reconciliation exhausts its retry budget, traffic may be dropped
+		 * but PROMISC/ALLMULTI cannot remain enabled beyond the requested
+		 * policy.
+		 */
+		err = enic_vf_set_pkt_filter(enic, flags, &applied_flags);
+		if (err) {
+			/* The previously applied broad mode may still be active.  Do
+			 * not rely on the core's bounded retry budget to narrow it.
+			 * Fresh registration is the fail-closed policy boundary.  A
+			 * local send timeout is already terminal and cannot use ordinary
+			 * reconnect recovery.
+			 */
+			if (!READ_ONCE(enic->mbox_tx_poisoned) &&
+			    !READ_ONCE(enic->vf_mbox_reconnect_required))
+				enic_mbox_vf_require_reconnect(enic);
+			return err;
+		}
+		enic_vf_report_pkt_filter_denial(netdev, flags, applied_flags);
+		netif_rx_mode_schedule_fresh(netdev);
+		return 0;
+	}
+
+	/* Keep the finite subset of exact filters already installed for an
+	 * overflowing class. Broad mode covers the remaining addresses when PF
+	 * policy permits it, while the independent finite class can still make
+	 * progress. When a class becomes finite again, withdraw stale broad
+	 * acceptance first, then schedule its exact-filter reconciliation.
+	 */
+	err = enic_vf_sync_mac_filters(enic, uc, mc, !uc_overflow,
+				       !mc_overflow, &sent);
+	if (err == -EACCES) {
+		/* Do not spend the core retry budget repeating an exact operation
+		 * that the PF rejected permanently.  If the independent packet
+		 * policy still needs an update, queue one fresh callback for it.
+		 */
+		if (filter_needed) {
+			enic->vf_pkt_filter_update_pending = true;
+			netif_rx_mode_schedule_fresh(netdev);
+		}
+		return 0;
+	}
+	if (err)
+		return err;
+
+	if (sent && filter_needed) {
+		/* The address transaction succeeded. Queue the policy half as a
+		 * fresh update rather than consuming the failure-retry budget.
+		 */
+		netif_rx_mode_schedule_fresh(netdev);
+		return 0;
+	}
+
+	if (filter_needed) {
+		err = enic_vf_set_pkt_filter(enic, flags, &applied_flags);
+		if (err)
+			return err;
+	} else {
+		applied_flags = enic->vf_pkt_filter_applied;
+	}
+
+	enic_vf_report_pkt_filter_denial(netdev, flags, applied_flags);
+
+	return 0;
+}
+
 /* netif_tx_lock held, BHs disabled */
 static void enic_set_rx_mode(struct net_device *netdev)
 {
 	struct enic *enic = netdev_priv(netdev);
-	int directed = 1;
-	int multicast = (netdev->flags & IFF_MULTICAST) ? 1 : 0;
-	int broadcast = (netdev->flags & IFF_BROADCAST) ? 1 : 0;
-	int promisc = (netdev->flags & IFF_PROMISC) ||
-		netdev_uc_count(netdev) > ENIC_UNICAST_PERFECT_FILTERS;
-	int allmulti = (netdev->flags & IFF_ALLMULTI) ||
-		netdev_mc_count(netdev) > ENIC_MULTICAST_PERFECT_FILTERS;
+	u16 filter_flags = enic_rx_mode_to_pkt_filter(netdev,
+					       netdev_uc_count(netdev),
+					       netdev_mc_count(netdev));
+	int directed = !!(filter_flags & CMD_PFILTER_DIRECTED);
+	int multicast = !!(filter_flags & CMD_PFILTER_MULTICAST);
+	int broadcast = !!(filter_flags & CMD_PFILTER_BROADCAST);
+	int promisc = !!(filter_flags & CMD_PFILTER_PROMISCUOUS);
+	int allmulti = !!(filter_flags & CMD_PFILTER_ALL_MULTICAST);
 	unsigned int flags = netdev->flags |
 		(allmulti ? IFF_ALLMULTI : 0) |
 		(promisc ? IFF_PROMISC : 0);
@@ -2221,6 +2623,10 @@ static int enic_open(struct net_device *netdev)
 {
 	struct enic *enic = netdev_priv(netdev);
 	bool vf_mac_added = false;
+	u16 vf_filter_applied;
+	u16 vf_filter_flags;
+	unsigned int vf_mc_count;
+	unsigned int vf_uc_count;
 	unsigned int i;
 	int err, ret;
 	unsigned int max_pkt_len = netdev->mtu + VLAN_ETH_HLEN;
@@ -2301,7 +2707,6 @@ static int enic_open(struct net_device *netdev)
 
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_add_station_addr(enic);
-
 	if (enic_is_sriov_vf_v2(enic)) {
 		if (!READ_ONCE(enic->vf_registered)) {
 			netdev_err(netdev, "VF is not registered with its PF\n");
@@ -2319,9 +2724,36 @@ static int enic_open(struct net_device *netdev)
 		enic_vf_station_addr_set(enic, netdev->dev_addr);
 		enic_vf_station_sync_reset(enic);
 		vf_mac_added = true;
+
+		netif_addr_lock_bh(netdev);
+		vf_uc_count = enic_vf_addr_list_count(enic, &netdev->uc, true);
+		vf_mc_count = enic_vf_addr_list_count(enic, &netdev->mc, false);
+		netif_addr_unlock_bh(netdev);
+
+		vf_filter_flags = enic_rx_mode_to_pkt_filter(netdev,
+							     vf_uc_count,
+							     vf_mc_count);
+		err = enic_vf_set_pkt_filter(enic, vf_filter_flags,
+					     &vf_filter_applied);
+		if (err) {
+			netdev_err(netdev,
+				   "Failed to configure VF packet filter: %d\n",
+				   err);
+			goto err_out_disable_wq;
+		}
+		if ((vf_uc_count > ENIC_UNICAST_PERFECT_FILTERS &&
+		     !(vf_filter_applied & CMD_PFILTER_PROMISCUOUS)) ||
+		    (vf_mc_count > ENIC_MULTICAST_PERFECT_FILTERS &&
+		     !(vf_filter_applied & CMD_PFILTER_ALL_MULTICAST))) {
+			netdev_err(netdev,
+				   "PF denied receive mode required by VF address lists\n");
+			err = -EACCES;
+			goto err_out_disable_wq;
+		}
 	}
 
-	enic_set_rx_mode(netdev);
+	if (!enic_is_sriov_vf_v2(enic))
+		enic_set_rx_mode(netdev);
 
 	netif_tx_wake_all_queues(netdev);
 
@@ -2956,6 +3388,13 @@ static void enic_reset(struct work_struct *work)
 	if (err)
 		netdev_err(enic->netdev,
 			   "Failed to reopen datapath after reset: %d\n", err);
+	else if (enic_is_sriov_vf_v2(enic)) {
+		/* Internal reset bypasses __dev_open(), which normally schedules the
+		 * asynchronous receive-mode upload after ndo_open. Schedule the same
+		 * core replay for lists cleared by enic_reset_addr_lists().
+		 */
+		netif_rx_mode_schedule_fresh(enic->netdev);
+	}
 
 	/* A PF reopens its admin channel after the datapath and re-pushes link
 	 * state.  The VF handshake, which open depends on, completed above.
@@ -3017,6 +3456,8 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	if (err)
 		netdev_err(enic->netdev,
 			   "Failed to reopen datapath after hang reset: %d\n", err);
+	else if (enic_is_sriov_vf_v2(enic))
+		netif_rx_mode_schedule_fresh(enic->netdev);
 
 	/* A PF reopens its admin channel after the datapath and re-pushes link
 	 * state.  The VF handshake, which open depends on, completed above.
@@ -3269,6 +3710,30 @@ static const struct net_device_ops enic_netdev_dynamic_ops = {
 	.ndo_features_check	= enic_features_check,
 };
 
+static const struct net_device_ops enic_netdev_vf_v2_ops = {
+	.ndo_open		= enic_open,
+	.ndo_stop		= enic_stop,
+	.ndo_start_xmit		= enic_hard_start_xmit,
+	.ndo_get_stats64	= enic_get_stats,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_rx_mode_async	= enic_set_vf_rx_mode,
+	.ndo_set_mac_address	= enic_set_mac_address_dynamic,
+	.ndo_change_mtu		= enic_change_mtu,
+	.ndo_vlan_rx_add_vid	= enic_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= enic_vlan_rx_kill_vid,
+	.ndo_tx_timeout		= enic_tx_timeout,
+	.ndo_set_vf_port	= enic_set_vf_port,
+	.ndo_get_vf_port	= enic_get_vf_port,
+	.ndo_set_vf_mac		= enic_set_vf_mac,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= enic_poll_controller,
+#endif
+#ifdef CONFIG_RFS_ACCEL
+	.ndo_rx_flow_steer	= enic_rx_flow_steer,
+#endif
+	.ndo_features_check	= enic_features_check,
+};
+
 static const struct net_device_ops enic_netdev_ops = {
 	.ndo_open		= enic_open,
 	.ndo_stop		= enic_stop,
@@ -3936,7 +4401,9 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	enic->rx_coalesce_usecs = enic->tx_coalesce_usecs;
 
-	if (enic_is_dynamic(enic) || enic_is_sriov_vf(enic))
+	if (enic_is_sriov_vf_v2(enic))
+		netdev->netdev_ops = &enic_netdev_vf_v2_ops;
+	else if (enic_is_dynamic(enic) || enic_is_sriov_vf(enic))
 		netdev->netdev_ops = &enic_netdev_dynamic_ops;
 	else
 		netdev->netdev_ops = &enic_netdev_ops;
@@ -4083,12 +4550,18 @@ static void enic_remove(struct pci_dev *pdev)
 
 		/* Close the admin channel and unregister from the PF before
 		 * unregister_netdev() to prevent a late PF notification from
-		 * touching a netdev that is being torn down. VF_UNREGISTER is the
+		 * touching a netdev that is being torn down.  VF_UNREGISTER is the
 		 * protocol teardown operation: the PF removes all VF-requested
 		 * configuration, including the station address, before replying.
+		 * Detach first while holding RTNL so any running asynchronous
+		 * receive-mode update has completed and queued updates cannot enter
+		 * the mailbox callback.
 		 */
 		if (enic_is_sriov_vf_v2(enic)) {
 			enic_vf_admin_mac_quiesce(enic);
+			rtnl_lock();
+			netif_device_detach(netdev);
+			rtnl_unlock();
 
 			if (READ_ONCE(enic->vf_registered)) {
 				int unreg_err = enic_mbox_vf_unregister(enic);

-- 
2.43.0

