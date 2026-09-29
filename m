Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC15616D0;
	Tue, 29 Sep 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708399; cv=none; b=URWgoG40rFLUO4/o5f7V8Zn1FdES5zVAqbp8x+viA0fxjkBXa8wC0dBRTrqHrb4Qm4F72SNJqayJktnUUlqJppHGBIrmwdY9cET30vd3w+u1QUyederqaBqQ4JjrYn7+r8YRfkHf8lRG3YAgxD1vRD7KU3dKmS/Zn+9g5bbOxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708399; c=relaxed/simple;
	bh=zkamJO3YxFjZbrrskjrrKvqbelbL71UscnMFe4M/11s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MlMZsJkxjs7htjK2r3C4ZNkPSB46Xxgec4hEapFMXP0uaL4kDRMwjcJHUNUwxRXWpjP0iIroENuGgx4FMGFuvw6SR04uk/Xh84QIy4w2og9VYyGldSylqKAw8bNsZpKt5vr97FkUB5BSXJGuBnpyUbI6emqX1FU3cutgjXfjo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=DUxKTP86; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="DUxKTP86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=29703; q=dns/txt;
  s=iport01; t=1790708396; x=1791917996;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ux7h55hqarA9uLIYQdiU7XVgRv5tsRFhBZYsLDZiyso=;
  b=DUxKTP86Q3V8olofeKsLcAEEEKjomsFxwAcrcaRIVS7YMAFN/6iueYxL
   QLHzMx0UKHC7IA80RXl850AfZEUqU473L4Whum1YgzjTJy74IGM1s80zM
   e7nQqwTmyhTIpqos3xJlYh/MgBk01gXUrz2iM5BqJrzDFnytszuZHGKUJ
   mMBsK6QIeWUTNDEfneIfLgMMGSUkubHzcEmV3mBA6e3nl17N15bLZdQGw
   5U8njPsw085vOO6qOJw+NNzsWK2bDGdxVltldjYO9XG6M1t3oMSmZnjUF
   XxOsGmHFAZjJ1P6TVn2lxfrB6macp3jr0ng+rg20ozT2JiciqyBqF3E/n
   w==;
X-CSE-ConnectionGUID: M8vgPAeQROq45RO3EuV06g==
X-CSE-MsgGUID: xvbUtGDHQIalrRqYTaFHRA==
X-IPAS-Result: =?us-ascii?q?A0AaAADCCbxq/4v/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBglaBVUNJhFeIG4c3giGRTIxRFIFqDwEBAQ9RBAEBghKCcwKOCAImN?=
 =?us-ascii?q?AkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGXJATAgEDGgkEU?=
 =?us-ascii?q?hAlAiYCAkYQBgESgwKCdQPBQXp/M4EBhH7ZSoFoAQsUAYEKLgGFcYJtAYFxh?=
 =?us-ascii?q?Ag7hEEnG4FJRIEVg2mBGYMGC4N0gmoEgxwSgQ2JBIsXCT+BAhwDWSwBVRMNC?=
 =?us-ascii?q?gsHBWFSMwMgCgsSEhgVAhQdEg8EFjIdcAwnEiwXL1gbBgWBHXUUBBOCGSMZN?=
 =?us-ascii?q?nqBCV6BKylgARAXgQeCBwKCVIIAAgFJQQ4HRVMJJUUSRyYiCBIJARMaMAuBG?=
 =?us-ascii?q?zg+CSg9GA1IESw3Bg8ZBD0BbgeQNx6BbgFRGQYBDggXEB01exAhAQ8IKgoHF?=
 =?us-ascii?q?AQRBi4XL5JjCQE4gzyNX2uBNZ9ahCiBZqAQM4QEk2M0klSZCCOCNqEZDwkBA?=
 =?us-ascii?q?k2EaYFoPIFZMxoIGxWDIlMZD44uFpMdAbx7JzI+AQcCBw8CgXOQAAQNF4FWA?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:+z9DLapkJl9FlTKI+SdXmbAH6kdeBmLKZBIvgKrLsJaIsI4StFCzt
 garIBmPPPmKY2emLt4lOY6y8BsF6pHRnYc2QAI/rXg1ECtH9uPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOWn9T8jhfngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgDNNwJcaDpOtfrS8kI35pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0sMnH2523
 PEhEhcUMk25oLmb3YzjFOY506zPLOGzVG8ekmtrwTecCbMtRorOBv2Qo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5MWfrSn8/w7pX7WyZRtFOOpak3y2PS1wd2lrPqNbI5f/TXH5UEwxjD+
 zuuE2LREg8QCcCw5Rq803uonNXWrB/ydqIoPejtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW3p3mLuhNaUN1Ve8U67xuI0YLX7hyfC2xCSSROAPQlqcU/bT8nz
 FmEm5XuHzMHmLSTRWiQ6fSSoC++NDY9KXIEY2kPTWMt+9DprYcypgjCQtZqDOi+ididMTXxx
 S2a6SsznbMeieYV2Kihu1PKmTShot7OVAFdzgPaQm6o8Ctna4O/IY+l817W6bBHNonxc7Wal
 GIPl87b6KUFCouA0XTXBu4MB7quof2CNVUwnGJSInXozBz1k1bLQGyayG0WyJtBWircRQLUX
 Q==
IronPort-HdrOrdr: A9a23:MOL8banhdn7XQu+eyXuPFgKhsWTpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: =?us-ascii?q?9a23=3Apt2YuGpMzYglX524a+sqIZ3mUeV1bHLl5XrpGWi?=
 =?us-ascii?q?hVTtTb+a4VGHIpqwxxg=3D=3D?=
X-Talos-MUID: 9a23:mQ/7cgXPrlnrX3Hq/C/yjgx+G+tI2oWnDFo3iKQ6suekDwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,130,1787011200"; 
   d="scan'208";a="528956351"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Sep 2026 18:58:39 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 6BC891800037C;
	Tue, 29 Sep 2026 18:58:38 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 29 Sep 2026 11:58:08 -0700
Subject: [PATCH net-next v2 5/6] enic: manage V2 VF station and
 administrative MAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-5-5962c10061b2@cisco.com>
References: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
In-Reply-To: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790708314; l=30575;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=zkamJO3YxFjZbrrskjrrKvqbelbL71UscnMFe4M/11s=;
 b=z9VgfYDNRhMbiNlSKHdzcYVqhCXEp50BsZE8489aNqlJgrFJNgoSmAZ3MEke7UZcPeNXQ4RZu
 AWrnVKwzbXlCiW9eG1mZFVx0m0gatHTsm7TWp7gOorAVkNM0E5lBr/j
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-02.cisco.com

Use the V2 mailbox MAC operation for the VF station address and keep that
address separate from netdev secondary-unicast synchronization. Replace a
station address with one mailbox request containing a delete followed by an
add. If the PF reports that only part of the replacement was applied,
require the VF to register again before accepting traffic.

Treat the PF administrative MAC as authoritative. Process notifications
outside receive dispatch, preserve a delegated VF-selected address, refresh
the policy after every registration, and protect VF worker shutdown and
restart against teardown and recovery.

Reject a VF MAC change which conflicts with a cached nonzero administrative
MAC even while the datapath is down. During registration, repair an actual
device-address mismatch even when the administrative policy itself did not
change since the previous registration.

Install the station address during open and remove it during an ordinary
stop. At reset and removal boundaries, rely on VF_UNREGISTER or the next VF
registration to clear the old state.

Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |  17 +
 drivers/net/ethernet/cisco/enic/enic_admin.c |   2 +
 drivers/net/ethernet/cisco/enic/enic_dev.c   |  11 +
 drivers/net/ethernet/cisco/enic/enic_dev.h   |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c  | 578 ++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c  |  30 ++
 6 files changed, 635 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index ef8332138c5a..1e369e6704e1 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -345,6 +345,9 @@ struct enic {
 	spinlock_t vf_link_state_lock;
 	enum enic_vf_link_state vf_link_state;
 	bool vf_link_running;
+	/* Last station address which may still be installed at the PF. */
+	u8 vf_station_addr[ETH_ALEN] __aligned(2);
+	bool vf_station_addr_valid;
 	/* Tracks a completely opened V2 VF datapath.  An internal reset can stop
 	 * it while netif_running() remains true, then fail before reopen.
 	 */
@@ -365,6 +368,16 @@ struct enic {
 	struct list_head vf_ack_list;
 	struct work_struct vf_ack_work;
 	unsigned int vf_ack_count;
+	struct delayed_work vf_admin_mac_work;
+	spinlock_t vf_admin_mac_lock;	/* protects pending admin MAC */
+	u8 vf_admin_mac[ETH_ALEN];
+	u8 vf_admin_mac_random_addr[ETH_ALEN];
+	bool vf_admin_mac_pending;
+	bool vf_admin_mac_random_valid;
+	bool vf_admin_mac_work_enabled;
+	bool vf_admin_mac_recovery_attempted;
+	u32 vf_admin_mac_generation;
+	u8 vf_admin_mac_retries;
 	u64 mbox_expected_msg_num;
 	u8 mbox_expected_reply;
 	int mbox_reply_status;
@@ -498,6 +511,10 @@ static inline int enic_dma_map_check(struct enic *enic, dma_addr_t dma_addr)
 }
 
 void enic_reset_addr_lists(struct enic *enic);
+void enic_vf_admin_mac_notify(struct enic *enic, const u8 *addr);
+void enic_vf_admin_mac_quiesce(struct enic *enic);
+void enic_vf_admin_mac_rearm(struct enic *enic);
+void enic_vf_admin_mac_purge(struct enic *enic);
 int enic_sriov_enabled(struct enic *enic);
 int enic_is_valid_vf(struct enic *enic, int vf);
 int enic_is_dynamic(struct enic *enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 30c0a5c89a2d..5e52d4da8d3c 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -641,6 +641,8 @@ void enic_admin_channel_close(struct enic *enic)
 {
 	int err;
 
+	if (enic_is_sriov_vf_v2(enic))
+		enic_vf_admin_mac_quiesce(enic);
 	if (!enic->has_admin_channel)
 		return;
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.c b/drivers/net/ethernet/cisco/enic/enic_dev.c
index 659787f73cf1..48c1ca9b40fb 100644
--- a/drivers/net/ethernet/cisco/enic/enic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/enic_dev.c
@@ -32,6 +32,17 @@ int enic_dev_stats_dump(struct enic *enic, struct vnic_stats **vstats)
 	return err;
 }
 
+int enic_dev_get_mac_addr(struct enic *enic, u8 *mac_addr)
+{
+	int err;
+
+	spin_lock_bh(&enic->devcmd_lock);
+	err = vnic_dev_get_mac_addr(enic->vdev, mac_addr);
+	spin_unlock_bh(&enic->devcmd_lock);
+
+	return err;
+}
+
 int enic_dev_add_station_addr(struct enic *enic)
 {
 	int err;
diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.h b/drivers/net/ethernet/cisco/enic/enic_dev.h
index 698d0cb02064..66d0e51681f5 100644
--- a/drivers/net/ethernet/cisco/enic/enic_dev.h
+++ b/drivers/net/ethernet/cisco/enic/enic_dev.h
@@ -26,6 +26,7 @@
 
 int enic_dev_fw_info(struct enic *enic, struct vnic_devcmd_fw_info **fw_info);
 int enic_dev_stats_dump(struct enic *enic, struct vnic_stats **vstats);
+int enic_dev_get_mac_addr(struct enic *enic, u8 *mac_addr);
 int enic_dev_add_station_addr(struct enic *enic);
 int enic_dev_del_station_addr(struct enic *enic);
 int enic_dev_packet_filter(struct enic *enic, int directed, int multicast,
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 28738bd14fa7..2132bfa9c8d3 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -89,6 +89,9 @@ MODULE_DEVICE_TABLE(pci, enic_id_table);
 
 #define ENIC_LARGE_PKT_THRESHOLD		1000
 #define ENIC_MAX_COALESCE_TIMERS		10
+#define ENIC_VF_ADMIN_MAC_MAX_RETRIES		4
+#define ENIC_VF_ADMIN_MAC_RETRY_MS		100
+#define ENIC_VF_ADMIN_MAC_REFRESH_RETRIES	3
 /*  Interrupt moderation table, which will be used to decide the
  *  coalescing timer values
  *  {rx_rate in Mbps, mapping percentage of the range}
@@ -1040,8 +1043,10 @@ void enic_reset_addr_lists(struct enic *enic)
 {
 	struct net_device *netdev = enic->netdev;
 
+	netif_addr_lock_bh(netdev);
 	__dev_uc_unsync(netdev, NULL);
 	__dev_mc_unsync(netdev, NULL);
+	netif_addr_unlock_bh(netdev);
 
 	enic->mc_count = 0;
 	enic->uc_count = 0;
@@ -1065,6 +1070,461 @@ static int enic_set_mac_addr(struct net_device *netdev, char *addr)
 	return 0;
 }
 
+static void enic_vf_station_recovery_required(struct enic *enic)
+{
+	enic_mbox_vf_require_reconnect(enic);
+}
+
+static void enic_vf_station_addr_set(struct enic *enic, const u8 *addr)
+{
+	ether_addr_copy(enic->vf_station_addr, addr);
+	enic->vf_station_addr_valid = true;
+}
+
+static int enic_vf_keep_nonstation_sync(struct net_device *netdev,
+					const u8 *addr)
+{
+	struct enic *enic = netdev_priv(netdev);
+
+	if (!ether_addr_equal(addr, enic->vf_station_addr))
+		return -ENOENT;
+	if (WARN_ON_ONCE(!enic->uc_count))
+		return 0;
+	enic->uc_count--;
+
+	return 0;
+}
+
+static void enic_vf_station_sync_reset(struct enic *enic)
+{
+	if (!enic->vf_station_addr_valid)
+		return;
+
+	/* The PF keys its MAC ledger by address. A station entry is also the
+	 * receive filter for that address and must not retain a second core
+	 * synchronization reference which could later delete the station.
+	 */
+	netif_addr_lock_bh(enic->netdev);
+	__dev_uc_unsync(enic->netdev, enic_vf_keep_nonstation_sync);
+	netif_addr_unlock_bh(enic->netdev);
+}
+
+static int enic_vf_station_addr_del(struct enic *enic)
+{
+	int err;
+
+	if (!enic->vf_station_addr_valid)
+		return 0;
+
+	err = enic_mbox_vf_add_del_mac(enic, enic->vf_station_addr,
+				       false, true);
+	if (!err) {
+		enic->vf_station_addr_valid = false;
+	} else if (READ_ONCE(enic->mbox_tx_poisoned)) {
+		enic_mbox_vf_link_state_set_running(enic, false);
+	} else if (err == -EACCES) {
+		/* A definitive rejected DELETE leaves an unrequested station
+		 * filter installed. Fresh registration is the cleanup boundary.
+		 */
+		enic_vf_station_recovery_required(enic);
+	}
+
+	return err;
+}
+
+/* End every replacement with an equal-address DEL+ADD pair. A bare ADD could
+ * report DUPLICATE for a secondary exact filter without applying the current
+ * station-address policy. If another station is tracked, delete it first in
+ * the same compound request.
+ */
+static int enic_vf_station_addr_replace(struct enic *enic, const u8 *addr)
+{
+	struct enic_mac_addr macs[3] = {};
+	bool all_deletes_skipped = true;
+	bool deletes_converged = true;
+	u16 num_macs = 0;
+	unsigned int i;
+	u16 result;
+	int err;
+
+	if (enic->vf_station_addr_valid &&
+	    !ether_addr_equal(enic->vf_station_addr, addr)) {
+		ether_addr_copy(macs[num_macs].addr, enic->vf_station_addr);
+		macs[num_macs++].flags =
+			cpu_to_le16(ENIC_MAC_ADDR_FLAG_STATION);
+	}
+	ether_addr_copy(macs[num_macs].addr, addr);
+	macs[num_macs++].flags = cpu_to_le16(ENIC_MAC_ADDR_FLAG_STATION);
+	ether_addr_copy(macs[num_macs].addr, addr);
+	macs[num_macs++].flags = cpu_to_le16(ENIC_MAC_ADDR_FLAG_ADD |
+					    ENIC_MAC_ADDR_FLAG_STATION);
+
+	err = enic_mbox_vf_add_del_macs(enic, macs, num_macs);
+	if (err) {
+		if (READ_ONCE(enic->mbox_tx_poisoned))
+			enic_mbox_vf_link_state_set_running(enic, false);
+		return err;
+	}
+
+	for (i = 0; i < num_macs - 1; i++) {
+		result = le16_to_cpu(macs[i].flags) &
+			 ENIC_MAC_ADDR_FLAG_REPLY_MASK;
+		if (result != ENIC_MAC_ADDR_FLAG_SKIPPED)
+			all_deletes_skipped = false;
+		if (result && result != ENIC_MAC_ADDR_FLAG_NOT_FOUND)
+			deletes_converged = false;
+	}
+	result = le16_to_cpu(macs[num_macs - 1].flags) &
+		 ENIC_MAC_ADDR_FLAG_REPLY_MASK;
+	if (deletes_converged && !result)
+		return 0;
+
+	/* A policy-rejected ADD can be reported with all preceding DELETEs
+	 * skipped. No operation changed state in that coherent result tuple.
+	 */
+	if (all_deletes_skipped && result) {
+		if (result & (ENIC_MAC_ADDR_FLAG_DUPLICATE |
+			      ENIC_MAC_ADDR_FLAG_PERMANENT_MASK))
+			return -EACCES;
+		return -EIO;
+	}
+
+	/* After any other partial or contradictory result, the VF does not know
+	 * which station address the PF kept. Re-register before accepting traffic.
+	 */
+	enic_vf_station_recovery_required(enic);
+	for (i = 0; i < num_macs; i++)
+		if (le16_to_cpu(macs[i].flags) &
+		    ENIC_MAC_ADDR_FLAG_PERMANENT_MASK)
+			return -EACCES;
+
+	return -EIO;
+}
+
+static void enic_vf_admin_mac_cache_selected(struct enic *enic,
+					     const u8 *addr)
+{
+	/* A zero administrative policy delegates the operational address to
+	 * the VF. Preserve a successful user selection across reconnects.
+	 */
+	spin_lock_bh(&enic->vf_admin_mac_lock);
+	if (is_zero_ether_addr(enic->vf_admin_mac)) {
+		ether_addr_copy(enic->vf_admin_mac_random_addr, addr);
+		enic->vf_admin_mac_random_valid = true;
+	}
+	spin_unlock_bh(&enic->vf_admin_mac_lock);
+}
+
+static void enic_vf_admin_mac_work(struct work_struct *work)
+{
+	struct enic *enic = container_of(to_delayed_work(work), struct enic,
+					 vf_admin_mac_work);
+	u8 policy[ETH_ALEN];
+	u8 selected[ETH_ALEN];
+	unsigned long delay = 0;
+	u32 generation = 0;
+	bool changed;
+	bool mutated = false;
+	bool reschedule = false;
+	bool station_installed = false;
+	bool stale = false;
+	bool zero_policy;
+	bool pending;
+	int err = 0;
+
+	spin_lock_bh(&enic->vf_admin_mac_lock);
+	pending = enic->vf_admin_mac_pending &&
+		enic->vf_admin_mac_work_enabled;
+	spin_unlock_bh(&enic->vf_admin_mac_lock);
+	if (!pending)
+		return;
+
+	/* Teardown owns RTNL while synchronously cancelling this work. Do not
+	 * block that owner.
+	 */
+	if (!rtnl_trylock()) {
+		spin_lock_bh(&enic->vf_admin_mac_lock);
+		if (enic->vf_admin_mac_pending &&
+		    enic->vf_admin_mac_work_enabled)
+			mod_delayed_work(system_wq, &enic->vf_admin_mac_work,
+					 msecs_to_jiffies(10));
+		spin_unlock_bh(&enic->vf_admin_mac_lock);
+		return;
+	}
+
+	spin_lock_bh(&enic->vf_admin_mac_lock);
+	pending = enic->vf_admin_mac_pending &&
+		enic->vf_admin_mac_work_enabled;
+	if (pending) {
+		ether_addr_copy(policy, enic->vf_admin_mac);
+		generation = enic->vf_admin_mac_generation;
+		zero_policy = is_zero_ether_addr(policy);
+		if (zero_policy && enic->vf_admin_mac_random_valid)
+			ether_addr_copy(selected,
+					enic->vf_admin_mac_random_addr);
+	}
+	spin_unlock_bh(&enic->vf_admin_mac_lock);
+	if (!pending)
+		goto unlock;
+
+	if (zero_policy && !READ_ONCE(enic->vf_admin_mac_random_valid)) {
+		eth_random_addr(selected);
+		spin_lock_bh(&enic->vf_admin_mac_lock);
+		if (!enic->vf_admin_mac_pending ||
+		    !enic->vf_admin_mac_work_enabled ||
+		    enic->vf_admin_mac_generation != generation ||
+		    !is_zero_ether_addr(enic->vf_admin_mac)) {
+			stale = true;
+		} else if (enic->vf_admin_mac_random_valid) {
+			ether_addr_copy(selected,
+					enic->vf_admin_mac_random_addr);
+		} else {
+			ether_addr_copy(enic->vf_admin_mac_random_addr, selected);
+			enic->vf_admin_mac_random_valid = true;
+		}
+		spin_unlock_bh(&enic->vf_admin_mac_lock);
+		if (stale)
+			goto unlock;
+	} else if (!zero_policy) {
+		ether_addr_copy(selected, policy);
+	}
+
+	if (!netif_device_present(enic->netdev) ||
+	    !READ_ONCE(enic->vf_registered)) {
+		err = -EAGAIN;
+		goto unlock;
+	}
+
+	/* A nonzero notification describes a station address the PF has already
+	 * installed. Zero delegates selection to the VF, which registers the
+	 * selected random address through the policy-safe replacement request.
+	 */
+	if (!READ_ONCE(enic->vf_datapath_open)) {
+		station_installed = !zero_policy &&
+			(!enic->vf_station_addr_valid ||
+			 ether_addr_equal(enic->vf_station_addr, selected));
+	} else if (zero_policy) {
+		mutated = true;
+		err = enic_vf_station_addr_replace(enic, selected);
+		station_installed = !err;
+	} else if (enic->vf_station_addr_valid &&
+		   !ether_addr_equal(enic->vf_station_addr, selected)) {
+		mutated = true;
+		err = enic_vf_station_addr_del(enic);
+		station_installed = !err;
+	} else {
+		station_installed = true;
+	}
+	if (err)
+		goto unlock;
+
+	spin_lock_bh(&enic->vf_admin_mac_lock);
+	if (!enic->vf_admin_mac_pending ||
+	    !enic->vf_admin_mac_work_enabled ||
+	    enic->vf_admin_mac_generation != generation) {
+		stale = true;
+		/* If policy changed while the request was running, the completed
+		 * station change may no longer match it. Record recovery while holding
+		 * vf_admin_mac_lock, which also protects VF worker shutdown. Teardown
+		 * therefore either suppresses the update or sees it first, and already
+		 * uses unregister/register to clear old state.
+		 */
+		if (mutated && enic->vf_admin_mac_work_enabled)
+			enic_vf_station_recovery_required(enic);
+	} else {
+		enic->vf_admin_mac_pending = false;
+		enic->vf_admin_mac_retries = 0;
+		enic->vf_admin_mac_recovery_attempted = false;
+		if (!zero_policy)
+			enic->vf_admin_mac_random_valid = false;
+	}
+	spin_unlock_bh(&enic->vf_admin_mac_lock);
+	if (stale)
+		goto unlock;
+
+	changed = !ether_addr_equal(enic->netdev->dev_addr, selected);
+	enic_vf_station_sync_reset(enic);
+	eth_hw_addr_set(enic->netdev, selected);
+	if (!zero_policy || changed)
+		enic->netdev->addr_assign_type = zero_policy ?
+			NET_ADDR_RANDOM : NET_ADDR_SET;
+	ether_addr_copy(enic->mac_addr, selected);
+	if (station_installed)
+		enic_vf_station_addr_set(enic, selected);
+	enic_vf_station_sync_reset(enic);
+	if (enic->netdev->reg_state == NETREG_REGISTERED && changed)
+		call_netdevice_notifiers(NETDEV_CHANGEADDR, enic->netdev);
+	netdev_info(enic->netdev, "MBOX: admin MAC set to %pM\n", selected);
+
+unlock:
+	rtnl_unlock();
+
+	spin_lock_bh(&enic->vf_admin_mac_lock);
+	if (err && enic->vf_admin_mac_pending &&
+	    enic->vf_admin_mac_work_enabled &&
+	    generation == enic->vf_admin_mac_generation &&
+	    !READ_ONCE(enic->mbox_send_disabled)) {
+		if (enic->vf_admin_mac_retries <
+		    ENIC_VF_ADMIN_MAC_MAX_RETRIES) {
+			enic->vf_admin_mac_retries++;
+			reschedule = true;
+			delay = msecs_to_jiffies(ENIC_VF_ADMIN_MAC_RETRY_MS);
+		} else if (!enic->vf_admin_mac_recovery_attempted) {
+			enic->vf_admin_mac_recovery_attempted = true;
+			/* vf_admin_mac_lock also protects VF worker shutdown. */
+			enic_vf_station_recovery_required(enic);
+		}
+	}
+	if (enic->vf_admin_mac_pending &&
+	    enic->vf_admin_mac_work_enabled &&
+	    generation != enic->vf_admin_mac_generation) {
+		reschedule = true;
+		delay = 0;
+	}
+	if (enic->vf_admin_mac_pending && reschedule)
+		mod_delayed_work(system_wq, &enic->vf_admin_mac_work, delay);
+	spin_unlock_bh(&enic->vf_admin_mac_lock);
+}
+
+void enic_vf_admin_mac_notify(struct enic *enic, const u8 *addr)
+{
+	bool new_policy;
+
+	spin_lock_bh(&enic->vf_admin_mac_lock);
+	new_policy = !enic->vf_admin_mac_pending ||
+		!ether_addr_equal(enic->vf_admin_mac, addr);
+	if (new_policy) {
+		ether_addr_copy(enic->vf_admin_mac, addr);
+		if (!is_zero_ether_addr(addr))
+			enic->vf_admin_mac_random_valid = false;
+		enic->vf_admin_mac_pending = true;
+		enic->vf_admin_mac_generation++;
+		enic->vf_admin_mac_retries = 0;
+		enic->vf_admin_mac_recovery_attempted = false;
+	}
+	if (new_policy && enic->vf_admin_mac_work_enabled)
+		mod_delayed_work(system_wq, &enic->vf_admin_mac_work, 0);
+	spin_unlock_bh(&enic->vf_admin_mac_lock);
+}
+
+void enic_vf_admin_mac_quiesce(struct enic *enic)
+{
+	spin_lock_bh(&enic->vf_admin_mac_lock);
+	enic->vf_admin_mac_work_enabled = false;
+	enic->vf_admin_mac_generation++;
+	spin_unlock_bh(&enic->vf_admin_mac_lock);
+	cancel_delayed_work_sync(&enic->vf_admin_mac_work);
+}
+
+void enic_vf_admin_mac_rearm(struct enic *enic)
+{
+	spin_lock_bh(&enic->vf_admin_mac_lock);
+	enic->vf_admin_mac_work_enabled = true;
+	if (enic->vf_admin_mac_pending)
+		mod_delayed_work(system_wq, &enic->vf_admin_mac_work, 0);
+	spin_unlock_bh(&enic->vf_admin_mac_lock);
+}
+
+void enic_vf_admin_mac_purge(struct enic *enic)
+{
+	enic_vf_admin_mac_quiesce(enic);
+	spin_lock_bh(&enic->vf_admin_mac_lock);
+	enic->vf_admin_mac_pending = false;
+	enic->vf_admin_mac_random_valid = false;
+	enic->vf_admin_mac_recovery_attempted = false;
+	enic->vf_admin_mac_retries = 0;
+	enic->vf_admin_mac_generation++;
+	spin_unlock_bh(&enic->vf_admin_mac_lock);
+}
+
+/* CMD_GET_MAC_ADDR is the PF-owned policy store. Re-read it after REGISTER so
+ * a lost notification cannot leave the VF using stale administrative policy.
+ */
+static int enic_vf_admin_mac_refresh(struct enic *enic)
+{
+	u8 previous_policy[ETH_ALEN];
+	u8 random_addr[ETH_ALEN];
+	u8 selected[ETH_ALEN];
+	u8 policy[ETH_ALEN];
+	u32 generation;
+	bool apply_policy;
+	bool changed;
+	bool pending;
+	bool policy_changed;
+	bool zero_policy;
+	unsigned int attempt;
+	int err;
+
+	for (attempt = 0; attempt < ENIC_VF_ADMIN_MAC_REFRESH_RETRIES;
+	     attempt++) {
+		spin_lock_bh(&enic->vf_admin_mac_lock);
+		generation = enic->vf_admin_mac_generation;
+		pending = enic->vf_admin_mac_pending;
+		ether_addr_copy(previous_policy, enic->vf_admin_mac);
+		spin_unlock_bh(&enic->vf_admin_mac_lock);
+
+		err = enic_dev_get_mac_addr(enic, policy);
+		if (err)
+			return err;
+		if (is_multicast_ether_addr(policy))
+			return -EADDRNOTAVAIL;
+
+		zero_policy = is_zero_ether_addr(policy);
+		if (zero_policy)
+			eth_random_addr(random_addr);
+
+		spin_lock_bh(&enic->vf_admin_mac_lock);
+		if (enic->vf_admin_mac_generation != generation) {
+			spin_unlock_bh(&enic->vf_admin_mac_lock);
+			continue;
+		}
+
+		policy_changed = !ether_addr_equal(previous_policy, policy);
+		apply_policy = pending || policy_changed ||
+			!is_valid_ether_addr(enic->netdev->dev_addr) ||
+			(!zero_policy &&
+			 !ether_addr_equal(enic->netdev->dev_addr, policy));
+		if (!apply_policy) {
+			ether_addr_copy(selected, enic->netdev->dev_addr);
+			if (zero_policy) {
+				ether_addr_copy(enic->vf_admin_mac_random_addr,
+						selected);
+				enic->vf_admin_mac_random_valid = true;
+			}
+		} else if (zero_policy && enic->vf_admin_mac_random_valid) {
+			ether_addr_copy(selected,
+					enic->vf_admin_mac_random_addr);
+		} else if (zero_policy) {
+			ether_addr_copy(selected, random_addr);
+			ether_addr_copy(enic->vf_admin_mac_random_addr, selected);
+			enic->vf_admin_mac_random_valid = true;
+		} else {
+			ether_addr_copy(selected, policy);
+			enic->vf_admin_mac_random_valid = false;
+		}
+		ether_addr_copy(enic->vf_admin_mac, policy);
+		enic->vf_admin_mac_pending = false;
+		enic->vf_admin_mac_recovery_attempted = false;
+		enic->vf_admin_mac_retries = 0;
+		enic->vf_admin_mac_generation++;
+		spin_unlock_bh(&enic->vf_admin_mac_lock);
+
+		changed = !ether_addr_equal(enic->netdev->dev_addr, selected);
+		eth_hw_addr_set(enic->netdev, selected);
+		if (!zero_policy || changed)
+			enic->netdev->addr_assign_type = zero_policy ?
+				NET_ADDR_RANDOM : NET_ADDR_SET;
+		ether_addr_copy(enic->mac_addr, selected);
+		if (changed && enic->netdev->reg_state == NETREG_REGISTERED)
+			call_netdevice_notifiers(NETDEV_CHANGEADDR,
+						 enic->netdev);
+
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+
 static int enic_set_mac_address_dynamic(struct net_device *netdev, void *p)
 {
 	struct enic *enic = netdev_priv(netdev);
@@ -1072,6 +1532,52 @@ static int enic_set_mac_address_dynamic(struct net_device *netdev, void *p)
 	char *addr = saddr->sa_data;
 	int err;
 
+	if (enic_is_sriov_vf_v2(enic)) {
+		if (!is_valid_ether_addr(addr))
+			return -EADDRNOTAVAIL;
+
+		spin_lock_bh(&enic->vf_admin_mac_lock);
+		err = is_valid_ether_addr(enic->vf_admin_mac) &&
+		      !ether_addr_equal(enic->vf_admin_mac, addr);
+		spin_unlock_bh(&enic->vf_admin_mac_lock);
+		if (err)
+			return -EPERM;
+		if (ether_addr_equal(addr, netdev->dev_addr))
+			return 0;
+
+		if (enic->vf_datapath_open &&
+		    !READ_ONCE(enic->vf_registered))
+			return -ENODEV;
+
+		/* An internal reset keeps IFF_UP set while its failed reopen leaves
+		 * the datapath closed. Cache the requested address in that state; the
+		 * next successful open installs it together with the datapath.
+		 */
+		if (!enic->vf_datapath_open) {
+			err = enic_set_mac_addr(netdev, addr);
+			if (!err)
+				enic_vf_admin_mac_cache_selected(enic, addr);
+			return err;
+		}
+
+		/* Keep the old software address visible until the complete station
+		 * replacement proves convergence.
+		 */
+		err = enic_vf_station_addr_replace(enic, addr);
+		if (err)
+			return err;
+
+		enic_vf_station_sync_reset(enic);
+		err = enic_set_mac_addr(netdev, addr);
+		if (!err) {
+			enic_vf_station_addr_set(enic, addr);
+			enic_vf_station_sync_reset(enic);
+			enic_vf_admin_mac_cache_selected(enic, addr);
+		}
+
+		return err;
+	}
+
 	if (netif_running(enic->netdev)) {
 		err = enic_dev_del_station_addr(enic);
 		if (err)
@@ -1726,6 +2232,7 @@ static int enic_admin_chan_reopen(struct enic *enic);
 static int enic_open(struct net_device *netdev)
 {
 	struct enic *enic = netdev_priv(netdev);
+	bool vf_mac_added = false;
 	unsigned int i;
 	int err, ret;
 	unsigned int max_pkt_len = netdev->mtu + VLAN_ETH_HLEN;
@@ -1807,6 +2314,25 @@ static int enic_open(struct net_device *netdev)
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_add_station_addr(enic);
 
+	if (enic_is_sriov_vf_v2(enic)) {
+		if (!READ_ONCE(enic->vf_registered)) {
+			netdev_err(netdev, "VF is not registered with its PF\n");
+			err = -ENODEV;
+			goto err_out_disable_wq;
+		}
+
+		err = enic_vf_station_addr_replace(enic, netdev->dev_addr);
+		if (err) {
+			netdev_err(netdev,
+				   "Failed to register VF station address: %d\n",
+				   err);
+			goto err_out_disable_wq;
+		}
+		enic_vf_station_addr_set(enic, netdev->dev_addr);
+		enic_vf_station_sync_reset(enic);
+		vf_mac_added = true;
+	}
+
 	enic_set_rx_mode(netdev);
 
 	netif_tx_wake_all_queues(netdev);
@@ -1864,6 +2390,15 @@ static int enic_open(struct net_device *netdev)
 		for (i = 0; i < enic->wq_count; i++)
 			napi_disable(&enic->napi[enic_cq_wq(enic, i)]);
 	netif_tx_disable(netdev);
+err_out_disable_wq:
+	if (vf_mac_added) {
+		ret = enic_vf_station_addr_del(enic);
+		if (ret) {
+			netdev_warn(netdev,
+				    "Failed to remove VF station address during open rollback: %d\n",
+				    ret);
+		}
+	}
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_del_station_addr(enic);
 	for (i = 0; i < enic->wq_count; i++)
@@ -1898,7 +2433,6 @@ static int __enic_stop(struct net_device *netdev, bool remove_vf_station)
 	 */
 	if (enic_is_sriov_vf_v2(enic) && !enic->vf_datapath_open)
 		return 0;
-	(void)remove_vf_station;
 
 	for (i = 0; i < enic->intr_count; i++) {
 		vnic_intr_mask(&enic->intr[i]);
@@ -1923,6 +2457,15 @@ static int __enic_stop(struct net_device *netdev, bool remove_vf_station)
 		for (i = 0; i < enic->wq_count; i++)
 			napi_disable(&enic->napi[enic_cq_wq(enic, i)]);
 	netif_tx_disable(netdev);
+	if (remove_vf_station && enic_is_sriov_vf_v2(enic) &&
+	    READ_ONCE(enic->vf_registered)) {
+		err = enic_vf_station_addr_del(enic);
+		if (err) {
+			netdev_warn(netdev,
+				    "Failed to remove VF station address: %d\n",
+				    err);
+		}
+	}
 
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_del_station_addr(enic);
@@ -2321,9 +2864,18 @@ static int enic_admin_chan_reopen(struct enic *enic)
 			return err;
 		}
 		enic_reset_addr_lists(enic);
+		enic->vf_station_addr_valid = false;
+		err = enic_vf_admin_mac_refresh(enic);
+		if (err) {
+			netdev_err(enic->netdev,
+				   "Failed to refresh VF admin MAC after reset: %d\n",
+				   err);
+			enic_admin_channel_close(enic);
+			return err;
+		}
 		/* Capability negotiation and registration establish a new protocol
-		 * generation. RX remains quarantined until enic_open() replays the
-		 * station and receive policy.
+		 * generation after authoritative MAC policy is refreshed. RX remains
+		 * quarantined until enic_open() replays station and receive policy.
 		 */
 		spin_lock_bh(&enic->mbox_state_lock);
 		if (enic->vf_mbox_fault_generation != recovery_generation ||
@@ -2339,6 +2891,7 @@ static int enic_admin_chan_reopen(struct enic *enic)
 			enic_admin_channel_close(enic);
 			return err;
 		}
+		enic_vf_admin_mac_rearm(enic);
 	} else {
 		/* The link came back up during enic_open() above while MBOX
 		 * sends were still disabled (channel not yet reopened), so that
@@ -3333,6 +3886,9 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * cancel_work_sync()) would otherwise act on an uninitialised work.
 	 */
 	INIT_WORK(&enic->link_notify_work, enic_link_notify_work_handler);
+	spin_lock_init(&enic->vf_admin_mac_lock);
+	INIT_DELAYED_WORK(&enic->vf_admin_mac_work,
+			  enic_vf_admin_mac_work);
 
 	/* V2 VF: open admin channel and register with PF.
 	 * Must happen before register_netdev so the VF is fully
@@ -3362,6 +3918,12 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				"MBOX VF registration failed: %d\n", err);
 			goto err_out_admin_close;
 		}
+		err = enic_vf_admin_mac_refresh(enic);
+		if (err) {
+			dev_err(dev,
+				"MBOX VF admin MAC refresh failed: %d\n", err);
+			goto err_out_admin_close;
+		}
 	}
 
 	netif_set_real_num_tx_queues(netdev, enic->wq_count);
@@ -3487,6 +4049,8 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(dev, "Cannot register net device, aborting\n");
 		goto err_out_admin_close;
 	}
+	if (enic_is_sriov_vf_v2(enic))
+		enic_vf_admin_mac_rearm(enic);
 
 	return 0;
 
@@ -3542,9 +4106,13 @@ static void enic_remove(struct pci_dev *pdev)
 
 		/* Close the admin channel and unregister from the PF before
 		 * unregister_netdev() to prevent a late PF notification from
-		 * touching a netdev that is being torn down.
+		 * touching a netdev that is being torn down. VF_UNREGISTER is the
+		 * protocol teardown operation: the PF removes all VF-requested
+		 * configuration, including the station address, before replying.
 		 */
 		if (enic_is_sriov_vf_v2(enic)) {
+			enic_vf_admin_mac_quiesce(enic);
+
 			if (READ_ONCE(enic->vf_registered)) {
 				int unreg_err = enic_mbox_vf_unregister(enic);
 
@@ -3563,6 +4131,8 @@ static void enic_remove(struct pci_dev *pdev)
 		 * enic_link_check() scheduled it just as SR-IOV was disabled.
 		 */
 		cancel_work_sync(&enic->link_notify_work);
+		if (enic_is_sriov_vf_v2(enic))
+			enic_vf_admin_mac_purge(enic);
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
 			if (enic->vf_type == ENIC_VF_TYPE_V2)
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 265b58cd39be..1fd2b23e2d8f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -860,6 +860,25 @@ static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload,
 			       ret_major);
 }
 
+static void enic_mbox_vf_handle_admin_mac(struct enic *enic, void *payload,
+					  u64 msg_num)
+{
+	struct enic_mbox_pf_set_admin_mac_notif_msg *notif = payload;
+	u16 ret_major = 0;
+
+	if (is_multicast_ether_addr(notif->mac_addr)) {
+		netdev_warn(enic->netdev,
+			    "MBOX: rejecting multicast admin MAC %pM\n",
+			    notif->mac_addr);
+		ret_major = ENIC_MBOX_ERR_GENERIC;
+	} else {
+		enic_vf_admin_mac_notify(enic, notif->mac_addr);
+	}
+
+	enic_mbox_vf_queue_ack(enic, ENIC_MBOX_PF_SET_ADMIN_MAC_ACK,
+			       msg_num, ret_major);
+}
+
 void enic_mbox_vf_link_state_reset(struct enic *enic)
 {
 	spin_lock_bh(&enic->vf_link_state_lock);
@@ -984,6 +1003,17 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 		enic_mbox_vf_handle_link_state(enic, payload, msg_num);
 		break;
 	}
+	case ENIC_MBOX_PF_SET_ADMIN_MAC_NOTIF: {
+		size_t exp = sizeof(struct enic_mbox_pf_set_admin_mac_notif_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp)) {
+			enic_mbox_vf_malformed_msg(enic, hdr->msg_type, msg_num);
+			return;
+		}
+		enic_mbox_vf_handle_admin_mac(enic, payload, msg_num);
+		break;
+	}
 	case ENIC_MBOX_VF_ADD_DEL_MAC_REPLY:
 		enic_mbox_vf_handle_add_del_mac_reply(enic, payload,
 						      payload_len, msg_num);

-- 
2.43.0

