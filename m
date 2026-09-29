Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11DE5616C5;
	Tue, 29 Sep 2026 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708398; cv=none; b=jjIRMYZAg+FawzJkZhALJRTrilpkqI0arF28ygVhwEXrSbWHD+TgRH8H6JnDR39+MzzGQPehefdZz8Vvzix2JCJGywMwXiRR3gqF0iXQOKAJquIsf+qODzfb8YQbbYVIpDewONkdU5ifCYWXWdmhkYOfkpfrub+bD0iif6t61EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708398; c=relaxed/simple;
	bh=kiwcPwn+nAl/1mlGv/rFR90QnkfXIzUfuUsPu3HVzIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1qiicB6mfHebhuyg1r5jZeccdchZSgFRU+FmoewQm1vRxcW90gwiXOGfherSakWSyfV+Whjkuwchzph66NtWvGSfzaKuH9S1UTp6g7BkJbmavYWWx6nh6plNR14idB5lpftpGRC3RTicpz68rMwGp2JMhd4VNjP9VGiGCZydns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=XRsUe1vz; arc=none smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="XRsUe1vz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=21093; q=dns/txt;
  s=iport01; t=1790708391; x=1791917991;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=C4fo672G5kakYyBBoWzAdpbjFI5C+uogp3NSi5IPuiI=;
  b=XRsUe1vzJagTl8LStqVYshz8NqkaakL+WlA8EGqhkDYl7V/9qn4TFVSX
   UeQ9UFOSUlVVmujHAuflvM6ElKTyPpQJaJqF3YB91WetCBBfvv+ql8JIw
   CB+vKHPpoJS8Y3rOILhj8BdESr8Wh1EthfXKcMFVyHSTOaG/ChWmRCYze
   ylt6yxxEDwfnJJZuknsieXewSQ2KaFz9jT6X2r4kf7qn6eyeOVYpGs0y1
   lMc9dVQIqmbkiqcVv0GIKdV4zSrDXwLqMQrjueXV5PsIEjNcLe0l3bPSv
   RL9N5UjE7N/7iX00yT8HAsHtvrgrXHwM9WdJZQHuVgOMaCyg8rEhLS0eN
   g==;
X-CSE-ConnectionGUID: fcySWMRAQxWe8nKKtET7+w==
X-CSE-MsgGUID: KJ/2UKVrRK27F5vzJI+O0w==
X-IPAS-Result: =?us-ascii?q?A0BHAgA3Cbxq/4v/Ja1aHgEBCxIMggULgleBVUNJhFePU?=
 =?us-ascii?q?oIhkUyMURSBag8BAQEPUQQBAYUFAo4IAiY0CQ4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEKAQEFAQEBAgEHBYEOE4ZckBMCAQMjBEASECUCJgICRhAGARKDAoJ1A8FTe?=
 =?us-ascii?q?n8zgQGEftlKgWgBCxQBgQouhXKCbQGBcYQIO4RBJxuBSUSBFYNphBsEC4N0g?=
 =?us-ascii?q?moEgxwSgl2HNIsXCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQdEg8EF?=
 =?us-ascii?q?jIdcAwnEiwXL1gbBgWBHXUUBBOCGSMZNnqBCV6BKylgARAXgQeCBwKCVIIAA?=
 =?us-ascii?q?gFJQQ4HRVMJJUUSRyYiCBIJARMaMAuBGzg+CSg9GA1IESw3Bg8ZBD0BbgeQN?=
 =?us-ascii?q?x6BbgFRHwEBDQgXLRsae0EdFQ4XGgEBLQFFklcMHSWDPI1fa4E1n1qEKIFmo?=
 =?us-ascii?q?BAzhASTY5MImQgjgjahEwYPCQECTYRpgWg8gVkzGggbFTuCZ1MZD44uFpMdA?=
 =?us-ascii?q?bx7JzI9AQEHAgcOAwuBaJAAAQQMF4FWAQE?=
IronPort-Data: A9a23:XyayvKL1Rqa6kfQ0FE+RA5QlxSXFcZb7ZxGr2PjKsXjdYENS1jIPz
 GUeDGyBaKqCZDCkKoh/Po7l/E8OsZHRyNQwHlEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea+Uf1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH9imQlajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1gB1ANAqgi099nPmwe8
 987NB0xMVOc0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBV7AtQIvIROPB4towMDUY358VW62BI
 ZBENHw2N0Wojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjeK8boCOIYXXLSlTtmW64
 Tj73FrjODJAa/LC1yin0zGL3vCayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa+0usQd3wGRa/pRasvhkGXsF4EOAg7gyJjK3O7G6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5aJ4qfC13Et
 38elo3GtqYFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz2k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:SPGx/qn4Zt13RtR4wsuU+J7/UvfpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: 9a23:l4Gw0GHzhtUGHpc7qmJp/18vJeUfW0TN83qAJWybFUtVF/6KHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AkbnYzw+ADHHRu36VMDIfqdqQf+RKpP6TK34Xq7Z?=
 =?us-ascii?q?c5OfZKz5SGnS61CviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,130,1787011200"; 
   d="scan'208";a="529623315"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Sep 2026 18:58:40 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 3F56F180007CB;
	Tue, 29 Sep 2026 18:58:39 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 29 Sep 2026 11:58:09 -0700
Subject: [PATCH net-next v2 6/6] enic: configure V2 VF receive mode over
 mailbox
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-6-5962c10061b2@cisco.com>
References: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
In-Reply-To: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790708314; l=21894;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=kiwcPwn+nAl/1mlGv/rFR90QnkfXIzUfuUsPu3HVzIQ=;
 b=LcYJstdC1pLGvwtJYtCuUwt9UHCgXhPTtMToZ50JsIUmHtofQJv2DC+GG4hMDLU1qx1eOtfGh
 scPb5U8vIwCBBNLsg125QqAm/G80cga/xmMRFxmg/GZQePVTpKWkU7N
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-02.cisco.com

V2 VFs cannot program receive filters directly. Add an asynchronous
receive-mode callback that sends individual unicast and multicast address
changes and packet-filter settings through the VF's one-request-at-a-time
mailbox path.

Complete all phases required for one address-list snapshot before returning
from the callback. Enable newly required broad receive coverage before
changing individual-address filters. Withdraw stale broad coverage before
installing its finite replacement. This preserves synchronous completion
when the netdev core executes the sleepable callback inline.

Use the netdev address-list synchronization state to batch operations:
sync_cnt == 0 identifies a new entry, refcount > sync_cnt identifies an
address that is still requested, and refcount == sync_cnt identifies an
installed entry which has become stale. The asynchronous netdev core
reconciles the resulting sync_cnt changes from the snapshot back to the
live list.

Track detailed per-address results so idempotent outcomes converge, stable
policy denials do not consume the retry budget, and failed deletes or
contradictory replies require a new VF registration. Keep the station
address out of both secondary address lists.

Deployed async PFs count the station address in the same 32-entry unicast
table used for secondary addresses. Request broad coverage at 32 secondary
unicast addresses so those PFs do not silently lose the final address.

Select the asynchronous netdev operations only for V2 VFs and detach the
device before mailbox teardown so no receive-mode callback can race
removal.

Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   3 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 468 +++++++++++++++++++++++++++-
 2 files changed, 458 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 1e369e6704e1..80056b5f4124 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -387,6 +387,9 @@ struct enic {
 	 */
 	struct enic_mac_addr *mbox_reply_mac_addrs;
 	u16 mbox_reply_mac_count;
+	u16 vf_pkt_filter_requested;
+	u16 vf_pkt_filter_applied;
+	bool vf_pkt_filter_valid;
 	bool mbox_initialized;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 2132bfa9c8d3..382bac6669bf 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1051,6 +1051,7 @@ void enic_reset_addr_lists(struct enic *enic)
 	enic->mc_count = 0;
 	enic->uc_count = 0;
 	enic->flags = 0;
+	enic->vf_pkt_filter_valid = false;
 }
 
 static int enic_set_mac_addr(struct net_device *netdev, char *addr)
@@ -1352,8 +1353,12 @@ static void enic_vf_admin_mac_work(struct work_struct *work)
 	if (station_installed)
 		enic_vf_station_addr_set(enic, selected);
 	enic_vf_station_sync_reset(enic);
-	if (enic->netdev->reg_state == NETREG_REGISTERED && changed)
-		call_netdevice_notifiers(NETDEV_CHANGEADDR, enic->netdev);
+	if (enic->netdev->reg_state == NETREG_REGISTERED) {
+		if (changed)
+			call_netdevice_notifiers(NETDEV_CHANGEADDR,
+						 enic->netdev);
+		netif_rx_mode_schedule_update(enic->netdev);
+	}
 	netdev_info(enic->netdev, "MBOX: admin MAC set to %pM\n", selected);
 
 unlock:
@@ -1573,6 +1578,7 @@ static int enic_set_mac_address_dynamic(struct net_device *netdev, void *p)
 			enic_vf_station_addr_set(enic, addr);
 			enic_vf_station_sync_reset(enic);
 			enic_vf_admin_mac_cache_selected(enic, addr);
+			netif_rx_mode_schedule_update(netdev);
 		}
 
 		return err;
@@ -1615,17 +1621,380 @@ static int enic_set_mac_address(struct net_device *netdev, void *p)
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
+/* Deployed async PFs count the station MAC in the 32-entry UC table. */
+static bool enic_vf_uc_needs_promisc(unsigned int uc_count)
+{
+	return uc_count >= ENIC_UNICAST_PERFECT_FILTERS;
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
+			const struct netdev_hw_addr_list *list)
+{
+	const struct netdev_hw_addr *ha;
+	unsigned int count = 0;
+
+	netdev_hw_addr_list_for_each(ha, list)
+		if (ha->refcount > ha->sync_cnt &&
+		    !(enic->vf_station_addr_valid &&
+		      ether_addr_equal(ha->addr, enic->vf_station_addr)))
+			count++;
+
+	return count;
+}
+
+static int enic_vf_collect_mac_ops(struct enic *enic,
+				   struct netdev_hw_addr_list *list,
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
+		if (enic->vf_station_addr_valid &&
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
+		if (enic->vf_station_addr_valid &&
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
+				    bool install_uc, bool install_mc)
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
+	macs = kcalloc(ENIC_MBOX_MAX_MAC_OPS, sizeof(*macs), GFP_KERNEL);
+	if (!macs)
+		return -ENOMEM;
+	ops = kcalloc(ENIC_MBOX_MAX_MAC_OPS, sizeof(*ops), GFP_KERNEL);
+	if (!ops) {
+		err = -ENOMEM;
+		goto free_macs;
+	}
+
+	err = enic_vf_collect_mac_ops(enic, uc, install_uc,
+				      &enic->uc_count,
+				      macs, ops, &num_ops);
+	if (err)
+		goto free_ops;
+	err = enic_vf_collect_mac_ops(enic, mc, install_mc,
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
+	unsigned int uc_count = enic_vf_addr_list_count(enic, uc);
+	unsigned int mc_count = enic_vf_addr_list_count(enic, mc);
+	u16 flags = enic_rx_mode_to_pkt_filter(netdev, uc_count, mc_count);
+	bool uc_overflow = enic_vf_uc_needs_promisc(uc_count);
+	bool mc_overflow = mc_count > ENIC_MULTICAST_PERFECT_FILTERS;
+	u16 broad_modes = CMD_PFILTER_PROMISCUOUS |
+			  CMD_PFILTER_ALL_MULTICAST;
+	bool broad_enable_needed;
+	bool broad_withdrawal;
+	bool filter_needed;
+	bool target_filter_updated = false;
+	u16 prefilter_flags;
+	u16 applied_flags;
+	int err;
+
+	if (uc_overflow)
+		flags |= CMD_PFILTER_PROMISCUOUS;
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
+		target_filter_updated = prefilter_flags == flags;
+		enic_vf_report_pkt_filter_denial(netdev, flags, applied_flags);
+	}
+
+	if (broad_withdrawal) {
+		/* Withdraw stale broad acceptance before installing its finite
+		 * replacement. Complete both phases in this callback so a synchronous
+		 * receive-mode operation cannot return between them.
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
+		target_filter_updated = true;
+		enic_vf_report_pkt_filter_denial(netdev, flags, applied_flags);
+	}
+
+	/* Keep the finite subset of exact filters already installed for an
+	 * overflowing class. Broad mode covers the remaining addresses when PF
+	 * policy permits it, while the independent finite class can still make
+	 * progress. When a class becomes finite again, stale broad acceptance was
+	 * withdrawn above before this exact-filter reconciliation.
+	 */
+	err = enic_vf_sync_mac_filters(enic, uc, mc, !uc_overflow,
+				       !mc_overflow);
+	if (err == -EACCES) {
+		/* Do not spend the core retry budget repeating an exact operation
+		 * that the PF rejected permanently. Finish any independent packet
+		 * policy change below before returning success.
+		 */
+		err = 0;
+	}
+	if (err)
+		return err;
+
+	if (!target_filter_updated && filter_needed) {
+		err = enic_vf_set_pkt_filter(enic, flags, &applied_flags);
+		if (err)
+			return err;
+	} else if (!target_filter_updated) {
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
@@ -2233,6 +2602,10 @@ static int enic_open(struct net_device *netdev)
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
@@ -2313,7 +2686,6 @@ static int enic_open(struct net_device *netdev)
 
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_add_station_addr(enic);
-
 	if (enic_is_sriov_vf_v2(enic)) {
 		if (!READ_ONCE(enic->vf_registered)) {
 			netdev_err(netdev, "VF is not registered with its PF\n");
@@ -2331,9 +2703,38 @@ static int enic_open(struct net_device *netdev)
 		enic_vf_station_addr_set(enic, netdev->dev_addr);
 		enic_vf_station_sync_reset(enic);
 		vf_mac_added = true;
+
+		netif_addr_lock_bh(netdev);
+		vf_uc_count = enic_vf_addr_list_count(enic, &netdev->uc);
+		vf_mc_count = enic_vf_addr_list_count(enic, &netdev->mc);
+		netif_addr_unlock_bh(netdev);
+
+		vf_filter_flags = enic_rx_mode_to_pkt_filter(netdev,
+							     vf_uc_count,
+							     vf_mc_count);
+		if (enic_vf_uc_needs_promisc(vf_uc_count))
+			vf_filter_flags |= CMD_PFILTER_PROMISCUOUS;
+		err = enic_vf_set_pkt_filter(enic, vf_filter_flags,
+					     &vf_filter_applied);
+		if (err) {
+			netdev_err(netdev,
+				   "Failed to configure VF packet filter: %d\n",
+				   err);
+			goto err_out_disable_wq;
+		}
+		if ((enic_vf_uc_needs_promisc(vf_uc_count) &&
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
 
@@ -2971,6 +3372,13 @@ static void enic_reset(struct work_struct *work)
 	if (err)
 		netdev_err(enic->netdev,
 			   "Failed to reopen datapath after reset: %d\n", err);
+	else if (enic_is_sriov_vf_v2(enic)) {
+		/* Internal reset bypasses __dev_open(), which normally schedules the
+		 * asynchronous receive-mode upload after ndo_open. Schedule an update
+		 * after enic_reset_addr_lists() marked the lists unsynchronized.
+		 */
+		netif_rx_mode_schedule_update(enic->netdev);
+	}
 
 	/* A PF reopens its admin channel after the datapath and re-pushes link
 	 * state.  The VF handshake, which open depends on, completed above.
@@ -3038,6 +3446,8 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	if (err)
 		netdev_err(enic->netdev,
 			   "Failed to reopen datapath after hang reset: %d\n", err);
+	else if (enic_is_sriov_vf_v2(enic))
+		netif_rx_mode_schedule_update(enic->netdev);
 
 	/* A PF reopens its admin channel after the datapath and re-pushes link
 	 * state.  The VF handshake, which open depends on, completed above.
@@ -3292,6 +3702,30 @@ static const struct net_device_ops enic_netdev_dynamic_ops = {
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
@@ -3959,7 +4393,9 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	enic->rx_coalesce_usecs = enic->tx_coalesce_usecs;
 
-	if (enic_is_dynamic(enic) || enic_is_sriov_vf(enic))
+	if (enic_is_sriov_vf_v2(enic))
+		netdev->netdev_ops = &enic_netdev_vf_v2_ops;
+	else if (enic_is_dynamic(enic) || enic_is_sriov_vf(enic))
 		netdev->netdev_ops = &enic_netdev_dynamic_ops;
 	else
 		netdev->netdev_ops = &enic_netdev_ops;
@@ -4106,12 +4542,18 @@ static void enic_remove(struct pci_dev *pdev)
 
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

