Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF117431A5F;
	Wed, 12 Aug 2026 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538995; cv=none; b=GmM+nIP9wwtnD/oyNUVNIRpWiPylNgr0q2RucGl2oR8CAXbUmTo1XFMrFTQZbQEeOVKulj1aNpRxaY6RfXnTfD53+UzQWaSoN/YZACXvlx8+QegmgWKFlD1VYYnM6pHhO+dX0QhcMPW4AYbzMQwV2OeYbSKZ+jUbhi9V9+Oaz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538995; c=relaxed/simple;
	bh=SzI6XHOEWVKHI5BbHHjITkEI54qFmqXeXpZEaj1AG3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvr+Oz75fHiMz/cYjnCIOaWBpGUZW2/iS/20CUCJ6ZUBXOhq9RWgXu7LMrM3iftZ0Hvid/mWT7HEkBv+ikXnMAPhe1Ef/DgNbQ2fhTE/9WVjpf0KUJnd3rsTpkUREMdZxmYVs7klOwjeNIveG8Jzsqfl41L6wdhJsUfb1ZclroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=WTxnQiGe; arc=none smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="WTxnQiGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=22489; q=dns/txt;
  s=iport01; t=1786538991; x=1787748591;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ZF131x1m+iOzK7pAX5MoW8+M4VB5z4azwK3J+RSDaMo=;
  b=WTxnQiGedfrEYqxp4WGbRZJJhKFGI7x9Ew1losBnCBO386NNhTC1u4LY
   NwbBeyvd/FklEJod4vUn7rDeCktmeyo2h78W6aO3/r0aAsyc1ipet1vuI
   EAYS7WAJy52R8Wh29vCYbxLWD+VW43CHXVb4jUvVHBvM/mDb1MZzwMVhN
   rZ9le73EQBYPnR5Nx6PlcHUylGCgr19/YZ0S3Ndv1BouWZtPTi4m31GvS
   ozykNrgs766ek55ZkZXsDP7KIgp6Yc/5vSt5WIsepuyXMTyCiiwAADjTf
   oQ1cOkQvlwCsJvlCpPSzJZ/ijfOuq+F5XOQIpQo00XoQdSIKNcse7kRg6
   Q==;
X-CSE-ConnectionGUID: 7xuP7gloROKTY4vDV8jpzg==
X-CSE-MsgGUID: bDz6iissRxm1oFQ/2w/ohg==
X-IPAS-Result: =?us-ascii?q?A0AaAADWanxq/5EQJK1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBghc/gVJDSYRXiBuHN4IhgRadCBSBag8BAQEPUQQBAYUFAo1nAiY0C?=
 =?us-ascii?q?Q4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAxoJBEASE?=
 =?us-ascii?q?CUCJgICRhAGARKDAoJ1A8Mren8zgQGEfdlJgWYBCxQBgQouAYVwgmwBgXCEC?=
 =?us-ascii?q?DuDRnsnG4FJRIEUAYJYG3aBKIMCg3SCagSDHBKLZIccCT+BAhwDWSwBVRMNC?=
 =?us-ascii?q?gsHBWFSMwMgCgsSEhgVAhQvDwQWMh1wDCcSLBc1WBsGBYEdfRQEE4Q2Ixk2f?=
 =?us-ascii?q?IEJYYErKmUBEheBCYIkAoJ2gSphAgEeCxgNSBEsNwYOGQQ9AW4HjggggUsCB?=
 =?us-ascii?q?2oHATwcARsaBwxoBC4BAgw8AwUPBBsCFBkLOAKSYwcWg2GNX2uBNZ9ahCiBZ?=
 =?us-ascii?q?qAPATKEBJNjkwWZCCOCNqEoWYRpgWg8gVkzGggbFYMiUxkPji0WHHgBAs8CJ?=
 =?us-ascii?q?zI/BwIHDwKRcwSBegEB?=
IronPort-Data: A9a23:E2FLUqKA33tIyrsHFE+RA5QlxSXFcZb7ZxGr2PjKsXjdYENS3mQGx
 zNOXTyCPK6NZGrwe95zO4Sx90pV6MfVxtA3HQsd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnQ0
 T/Oi5eHYgH9i2cuajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN0xHFwOYoIc/dxQIl1/q
 eI0FmAPdgKM0rfeLLKTEoGAh+wqKM3teYdasXZ6wHSBXbAtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzMXwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQhiOawbISOJoTiqcN9lGqK+
 GPH5H/DEhRDM/KmjmCatXWsibqa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pbJ
 k0I8y0GoaU49UWtCN7nUHWQrXKZuxcOVsZ4HOo95wWAjKHT5m6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5JKIKfC13Et
 38elo3GvKYFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz0k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:6VKmB6FOs0L03p/JpLqEHseALOsnbusQ8zAXPo5KOHhom6uj9v
 xG/c506faaslsssR0b8+xofZPwI080lqQb3WBuB9eftWDd0QPCEGgh1/qA/9SKIUHDH4BmpM
 JdWpk7JdHuAV19lMrgpCu1A78bsaC62ZHtqOvAw3JqVA1wL5th4QBwFxqBHiRNNW977OICZf
 2hz/sCgSa8cnIKacn+LHwEU+/f4+DvrvvdEGY779pN0nj1sdtug4SKaCSl4g==
X-Talos-CUID: 9a23:XL/DFWNngiYA9O5DBzl6zBEbHscfVV7h/SvOD3HoC357R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A/DHcpg+Up9meUPX7KIOjHT+Qf81E8fqvCVsWq4U?=
 =?us-ascii?q?D4s6qDGsqJHCajDviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="806546340"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 12:48:38 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 502C01800046D;
	Wed, 12 Aug 2026 12:48:37 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 12 Aug 2026 05:48:09 -0700
Subject: [PATCH net-next v13 09/11] enic: wire V2 SR-IOV enable with admin
 channel and MBOX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-enic-sriov-v2-admin-channel-v2-v13-9-b3809e448aba@cisco.com>
References: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786538908; l=23048;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=SzI6XHOEWVKHI5BbHHjITkEI54qFmqXeXpZEaj1AG3Q=;
 b=LMDrPmMB81VoXUMvRROZq5Ryjp5AAIS2Dt8qkgrpaUUKumtqQ2mEphMG4PKI4Qo2ceL1qIUKZ
 lhAOLzxV2jkCRVaULnaAFsUjh3lQYLQIyiAQKZwfcBXTJ0XZf5Q2saa
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-08.cisco.com

Extend enic_sriov_configure() to handle V2 SR-IOV VFs. When the PF
detects V2 VF device IDs, the enable path allocates per-VF MBOX state,
initializes the MBOX protocol, opens the admin channel, and then calls
pci_enable_sriov(). The admin channel must be ready before VFs are
created so that VF drivers can immediately begin the MBOX capability
and registration handshake during their probe.

The enic_sriov_configure() dispatcher and its V2 helpers
(enic_sriov_v2_enable, enic_sriov_v2_disable) are defined here but
intentionally not yet wired into struct pci_driver via
.sriov_configure -- hence the __maybe_unused annotations.  This
series introduces only the admin channel and MBOX infrastructure;
sysfs-driven V2 enable/disable will be activated in a follow-up
patch by adding ".sriov_configure = enic_sriov_configure," to
enic_driver.

Because .sriov_configure is not registered yet, enic_sriov_configure()
cannot run concurrently with the rtnl-protected reset paths
(enic_reset(), enic_tx_hang_reset()) in this series, so there is no
reachable locking race between SR-IOV enable/disable and reset.  The
follow-up patch that wires the callback will add the necessary
serialization against those paths.  Note that simply taking rtnl_lock()
around the enable path is not viable, because pci_enable_sriov()
triggers VF probe and register_netdev(), which themselves acquire rtnl;
the wiring patch therefore uses finer-grained serialization.

The disable path first clears ENIC_SRIOV_ENABLED and flushes the
link-notify work, so no further VF link-state broadcast can run, then
calls pci_disable_sriov() (VF drivers unregister via MBOX), closes the
admin channel, and frees per-VF state.  Clearing the flag and flushing
the work before vf_state is freed closes a use-after-free window
against the link-notify path.

Notify registered VFs of PF link transitions: enic_link_check()
schedules link_notify_work on each carrier up/down edge, and the work
handler sends PF_LINK_STATE_NOTIF to the VFs from process context.
The broadcast cannot run directly in enic_link_check() because the
MBOX send path may sleep and link check runs in the notify timer/ISR
context.

On a V2 VF the admin-channel (PF) link-state notification is the sole
authority for carrier state, so enic_link_check() returns early for
such VFs.  As a side effect the VF retains the firmware-provided static
Rx interrupt coalescing (config.intr_timer_usec) rather than PF-driven
speed-adaptive coalescing; this is intentional, as adaptive Rx
coalescing is a PF-only responsibility for V2 VFs.

Re-establish the admin/MBOX channel across a PF reset.  enic_reset()
and enic_tx_hang_reset() fully close the admin channel before the
soft/hang reset (which wipes all hardware queues, including the admin
WQ/RQ), then reopen it and re-run enic_mbox_init() after the data path
is back up, and re-push the current link state to registered VFs.

Reject VF port profile requests when V2 SR-IOV is active
(enic_is_valid_pp_vf), since enic->pp is not reallocated for V2 VFs
and the V2 protocol uses MBOX instead of port profiles.

Update enic_remove() to run enic_dev_deinit() and vnic_dev_close()
after SR-IOV teardown, so the PF device remains functional while VFs
are being cleaned up.  This ordering applies to both V1 and V2 SR-IOV
paths.

Restrict the probe-time SR-IOV auto-enable to the legacy VF types (V1
and usNIC).  A V2-capable adapter whose firmware lacks V2 support is
downgraded to ENIC_VF_TYPE_NONE, and V2 VFs require the admin channel
which is only brought up via sysfs enic_sriov_configure(); neither
must be auto-enabled through the legacy pci_enable_sriov() path at
probe.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |   3 +
 drivers/net/ethernet/cisco/enic/enic_admin.c |   3 +
 drivers/net/ethernet/cisco/enic/enic_main.c  | 288 +++++++++++++++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_mbox.c  |  13 +-
 drivers/net/ethernet/cisco/enic/enic_pp.c    |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c   |   1 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h  |   4 +-
 7 files changed, 301 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index db4d52a4158f..4a67947cfb9f 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -305,6 +305,7 @@ struct enic {
 	struct vnic_intr admin_intr;
 	struct delayed_work admin_poll_work;
 	unsigned int admin_intr_index;
+	struct work_struct link_notify_work;
 	struct work_struct admin_msg_work;
 	spinlock_t admin_msg_lock;	/* protects admin_msg_list */
 	struct list_head admin_msg_list;
@@ -325,6 +326,7 @@ struct enic {
 	 */
 	struct completion mbox_comp;
 	u8 mbox_expected_reply;
+	bool mbox_initialized;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
 	struct enic_vf_state {
@@ -451,6 +453,7 @@ void enic_reset_addr_lists(struct enic *enic);
 int enic_sriov_enabled(struct enic *enic);
 int enic_is_valid_vf(struct enic *enic, int vf);
 int enic_is_dynamic(struct enic *enic);
+int enic_is_sriov_vf_v2(struct enic *enic);
 void enic_set_ethtool_ops(struct net_device *netdev);
 int __enic_set_rsskey(struct enic *enic);
 void enic_ext_cq(struct enic *enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index f4a409fec983..7188f1b81c04 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -639,6 +639,7 @@ void enic_admin_channel_close(struct enic *enic)
 
 	vnic_intr_mask(&enic->admin_intr);
 	enic_admin_teardown_intr(enic);
+	cancel_work_sync(&enic->link_notify_work);
 	cancel_work_sync(&enic->admin_msg_work);
 	enic_admin_msg_drain(enic);
 
@@ -658,6 +659,8 @@ void enic_admin_channel_close(struct enic *enic)
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
 	vnic_intr_clean(&enic->admin_intr);
+
+	enic->admin_rq_handler = NULL;
 	enic_admin_free_resources(enic);
 
 	enic->admin_chan_up = false;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index b56e5c75ade3..27b31d5a95dd 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -60,6 +60,8 @@
 #include "enic_clsf.h"
 #include "enic_rq.h"
 #include "enic_wq.h"
+#include "enic_admin.h"
+#include "enic_mbox.h"
 
 #define ENIC_NOTIFY_TIMER_PERIOD	(2 * HZ)
 
@@ -314,6 +316,11 @@ static int enic_is_sriov_vf(struct enic *enic)
 	       enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2;
 }
 
+int enic_is_sriov_vf_v2(struct enic *enic)
+{
+	return enic->pdev->device == PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2;
+}
+
 int enic_is_valid_vf(struct enic *enic, int vf)
 {
 #ifdef CONFIG_PCI_IOV
@@ -411,18 +418,50 @@ static void enic_set_rx_coal_setting(struct enic *enic)
 	rx_coal->use_adaptive_rx_coalesce = 1;
 }
 
+static void enic_link_notify_work_handler(struct work_struct *work)
+{
+	struct enic *enic = container_of(work, struct enic,
+					 link_notify_work);
+	u32 state;
+	u16 i;
+
+	if (!enic_sriov_enabled(enic) || !enic->vf_state)
+		return;
+
+	state = netif_carrier_ok(enic->netdev) ?
+		ENIC_MBOX_LINK_STATE_ENABLE :
+		ENIC_MBOX_LINK_STATE_DISABLE;
+
+	for (i = 0; i < enic->num_vfs; i++)
+		enic_mbox_send_link_state(enic, i, state);
+}
+
 static void enic_link_check(struct enic *enic)
 {
-	int link_status = vnic_dev_link_status(enic->vdev);
-	int carrier_ok = netif_carrier_ok(enic->netdev);
+	int link_status;
+	int carrier_ok;
+
+	/* A V2 SR-IOV VF's carrier is driven by PF link-state MBOX
+	 * notifications, not by its own vnic link status; skip the
+	 * autonomous check so it cannot flap the VF carrier.
+	 */
+	if (enic_is_sriov_vf_v2(enic))
+		return;
+
+	link_status = vnic_dev_link_status(enic->vdev);
+	carrier_ok = netif_carrier_ok(enic->netdev);
 
 	if (link_status && !carrier_ok) {
 		netdev_info(enic->netdev, "Link UP\n");
 		netif_carrier_on(enic->netdev);
 		enic_set_rx_coal_setting(enic);
+		if (enic_sriov_enabled(enic) && enic->vf_state)
+			schedule_work(&enic->link_notify_work);
 	} else if (!link_status && carrier_ok) {
 		netdev_info(enic->netdev, "Link DOWN\n");
 		netif_carrier_off(enic->netdev);
+		if (enic_sriov_enabled(enic) && enic->vf_state)
+			schedule_work(&enic->link_notify_work);
 	}
 }
 
@@ -2154,15 +2193,47 @@ static void enic_reset(struct work_struct *work)
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
+	/* Fully tear down the V2 admin/MBOX channel before the soft reset.
+	 * The reset wipes all hardware queues including the admin WQ/RQ;
+	 * closing first tells firmware to stop the admin QP (so it no longer
+	 * DMAs from the about-to-be-reset rings) and frees the admin resources
+	 * so they are cleanly re-allocated afterwards.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2)
+		enic_admin_channel_close(enic);
+
 	enic_stop(enic->netdev);
+
 	enic_dev_soft_reset(enic);
 	enic_reset_addr_lists(enic);
 	enic_init_vnic_resources(enic);
 	enic_set_rss_nic_cfg(enic);
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
+
 	enic_open(enic->netdev);
 
+	/* Re-establish the admin/MBOX channel after the data path is back up,
+	 * mirroring the SR-IOV enable path (channel open + mbox init).  The
+	 * channel was fully torn down by enic_admin_channel_close() above.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2) {
+		if (enic_admin_channel_open(enic)) {
+			netdev_err(enic->netdev,
+				   "admin channel reopen after reset failed\n");
+		} else {
+			enic_mbox_init(enic);
+			/* The link came back up during enic_open() above
+			 * while MBOX sends were still disabled (channel not
+			 * yet reopened), so that link-notify was dropped.
+			 * Re-push current link state to registered VFs now.
+			 */
+			schedule_work(&enic->link_notify_work);
+		}
+	}
+
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
@@ -2180,16 +2251,46 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
+	/* Fully tear down the V2 admin/MBOX channel before the hang reset, for
+	 * the same reason as the soft reset path: stop the admin QP and free
+	 * the admin resources before the hardware queues are wiped.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2)
+		enic_admin_channel_close(enic);
+
 	enic_dev_hang_notify(enic);
 	enic_stop(enic->netdev);
+
 	enic_dev_hang_reset(enic);
 	enic_reset_addr_lists(enic);
 	enic_init_vnic_resources(enic);
 	enic_set_rss_nic_cfg(enic);
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
+
 	enic_open(enic->netdev);
 
+	/* Re-establish the admin/MBOX channel after the data path is back up,
+	 * mirroring the SR-IOV enable path (channel open + mbox init).  The
+	 * channel was fully torn down by enic_admin_channel_close() above.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2) {
+		if (enic_admin_channel_open(enic)) {
+			netdev_err(enic->netdev,
+				   "admin channel reopen after reset failed\n");
+		} else {
+			enic_mbox_init(enic);
+			/* The link came back up during enic_open() above
+			 * while MBOX sends were still disabled (channel not
+			 * yet reopened), so that link-notify was dropped.
+			 * Re-push current link state to registered VFs now.
+			 */
+			schedule_work(&enic->link_notify_work);
+		}
+	}
+
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
@@ -2200,6 +2301,8 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
 static int enic_set_intr_mode(struct enic *enic)
 {
+	unsigned int admin_reserve = enic->has_admin_channel ? 1 : 0;
+	unsigned int min_intr = ENIC_MSIX_MIN_INTR + admin_reserve;
 	unsigned int i;
 	int num_intr;
 
@@ -2210,12 +2313,12 @@ static int enic_set_intr_mode(struct enic *enic)
 	 */
 
 	if (enic->config.intr_mode < 1 &&
-	    enic->intr_avail >= ENIC_MSIX_MIN_INTR) {
+	    enic->intr_avail >= min_intr) {
 		for (i = 0; i < enic->intr_avail; i++)
 			enic->msix_entry[i].entry = i;
 
 		num_intr = pci_enable_msix_range(enic->pdev, enic->msix_entry,
-						 ENIC_MSIX_MIN_INTR,
+						 min_intr,
 						 enic->intr_avail);
 		if (num_intr > 0) {
 			vnic_dev_set_intr_mode(enic->vdev,
@@ -2310,7 +2413,13 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->cq_count = 2;
 		enic->intr_count = enic->intr_avail;
 		break;
-	case VNIC_DEV_INTR_MODE_MSIX:
+	case VNIC_DEV_INTR_MODE_MSIX: {
+		/* Reserve one MSI-X slot for the admin channel interrupt
+		 * when V2 SR-IOV admin channel resources are present.
+		 */
+		unsigned int admin_reserve =
+			enic->has_admin_channel ? 1 : 0;
+
 		/* Adjust the number of wqs/rqs/cqs/interrupts that will be
 		 * used based on which resource is the most constrained
 		 */
@@ -2319,7 +2428,8 @@ static int enic_adjust_resources(struct enic *enic)
 				 ENIC_RQ_MIN_DEFAULT);
 		rq_avail = min3(enic->rq_avail, ENIC_RQ_MAX, rq_default);
 		max_queues = min(enic->cq_avail,
-				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
+				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR -
+				 admin_reserve);
 		if (wq_avail + rq_avail <= max_queues) {
 			enic->rq_count = rq_avail;
 			enic->wq_count = wq_avail;
@@ -2337,6 +2447,7 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->intr_count = enic->cq_count + ENIC_MSIX_RESERVED_INTR;
 
 		break;
+	}
 	default:
 		dev_err(enic_get_dev(enic), "Unknown interrupt mode\n");
 		return -EINVAL;
@@ -2689,6 +2800,144 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 		enic->vf_type = ENIC_VF_TYPE_NONE;
 	}
 }
+
+static int __maybe_unused
+enic_sriov_v2_enable(struct enic *enic, int num_vfs)
+{
+	int err;
+
+	if (!enic->has_admin_channel) {
+		netdev_err(enic->netdev,
+			   "V2 SR-IOV requires admin channel resources\n");
+		return -EOPNOTSUPP;
+	}
+
+	enic->vf_state = kcalloc(num_vfs, sizeof(*enic->vf_state), GFP_KERNEL);
+	if (!enic->vf_state)
+		return -ENOMEM;
+
+	/* Install the MBOX receive handler before the admin interrupt is
+	 * unmasked in enic_admin_channel_open(), so no early completion is
+	 * dropped.
+	 */
+	enic_mbox_init(enic);
+
+	err = enic_admin_channel_open(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to open admin channel: %d\n", err);
+		goto free_vf_state;
+	}
+
+	enic->num_vfs = num_vfs;
+
+	err = pci_enable_sriov(enic->pdev, num_vfs);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "pci_enable_sriov failed: %d\n", err);
+		goto close_admin;
+	}
+
+	enic->priv_flags |= ENIC_SRIOV_ENABLED;
+	return num_vfs;
+
+close_admin:
+	enic->num_vfs = 0;
+	enic_admin_channel_close(enic);
+free_vf_state:
+	kfree(enic->vf_state);
+	enic->vf_state = NULL;
+	return err;
+}
+
+static void enic_sriov_v2_disable(struct enic *enic)
+{
+	/* Stop new VF link-state broadcasts before tearing down vf_state.
+	 * Clearing ENIC_SRIOV_ENABLED makes enic_link_check() (called from
+	 * the notify timer/ISR) skip the VF notify path, and cancelling
+	 * link_notify_work ensures any already-queued broadcast has finished
+	 * before vf_state is freed, closing a use-after-free window.
+	 */
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+	cancel_work_sync(&enic->link_notify_work);
+
+	pci_disable_sriov(enic->pdev);
+	enic_admin_channel_close(enic);
+	kfree(enic->vf_state);
+	enic->vf_state = NULL;
+	enic->num_vfs = 0;
+}
+
+/*
+ * enic_sriov_configure() and its V2 helpers are defined but not yet wired
+ * into enic_driver via .sriov_configure (see the __maybe_unused annotations);
+ * V2 enable/disable is activated in a follow-up series.  Because the callback
+ * is not registered, it cannot run concurrently with the rtnl-protected reset
+ * paths (enic_reset(), enic_tx_hang_reset()) yet.  Serialization against those
+ * paths is added together with the .sriov_configure wiring in that series.
+ */
+static int __maybe_unused
+enic_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct enic *enic = netdev_priv(netdev);
+	struct enic_port_profile *pp;
+	int err;
+
+	if (num_vfs > 0) {
+		if (enic->config.mq_subvnic_count) {
+			netdev_err(netdev,
+				   "SR-IOV not supported with multi-queue sub-vnics\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (enic->vf_type == ENIC_VF_TYPE_NONE) {
+			netdev_err(netdev,
+				   "SR-IOV not supported on this firmware version\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (enic->vf_type == ENIC_VF_TYPE_V2)
+			return enic_sriov_v2_enable(enic, num_vfs);
+
+		pp = kcalloc(num_vfs, sizeof(*pp), GFP_KERNEL);
+		if (!pp)
+			return -ENOMEM;
+
+		err = pci_enable_sriov(pdev, num_vfs);
+		if (err) {
+			kfree(pp);
+			return err;
+		}
+
+		kfree(enic->pp);
+		enic->pp = pp;
+		enic->num_vfs = num_vfs;
+		enic->priv_flags |= ENIC_SRIOV_ENABLED;
+		return num_vfs;
+	}
+
+	if (!enic_sriov_enabled(enic))
+		return 0;
+
+	if (enic->vf_type == ENIC_VF_TYPE_V2) {
+		enic_sriov_v2_disable(enic);
+		return 0;
+	}
+
+	pp = kzalloc_obj(*enic->pp, GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+
+	pci_disable_sriov(pdev);
+	enic->num_vfs = 0;
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+
+	kfree(enic->pp);
+	enic->pp = pp;
+
+	return 0;
+}
 #endif
 
 static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -2787,12 +3036,23 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_vnic_unregister;
 
 #ifdef CONFIG_PCI_IOV
-	/* Get number of subvnics */
+	enic_sriov_detect_vf_type(enic);
+
+	/* Auto-enable SR-IOV only for the legacy VF types.  V2 VFs require
+	 * the admin channel, which is not yet set up at probe time (V2 SR-IOV
+	 * will be enabled through the sysfs .sriov_configure callback once a
+	 * follow-up series wires it up); and a V2-capable device whose
+	 * firmware lacks V2 support is downgraded to ENIC_VF_TYPE_NONE by
+	 * enic_sriov_detect_vf_type() and must not be brought up through the
+	 * legacy pci_enable_sriov() path either.
+	 */
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
 	if (pos) {
 		pci_read_config_word(pdev, pos + PCI_SRIOV_TOTAL_VF,
 			&enic->num_vfs);
-		if (enic->num_vfs) {
+		if (enic->num_vfs &&
+		    (enic->vf_type == ENIC_VF_TYPE_V1 ||
+		     enic->vf_type == ENIC_VF_TYPE_USNIC)) {
 			err = pci_enable_sriov(pdev, enic->num_vfs);
 			if (err) {
 				dev_err(dev, "SRIOV enable failed, aborting."
@@ -2804,7 +3064,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			num_pps = enic->num_vfs;
 		}
 	}
-	enic_sriov_detect_vf_type(enic);
 #endif
 
 	/* Allocate structure for port profiles */
@@ -2881,6 +3140,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
+	INIT_WORK(&enic->link_notify_work, enic_link_notify_work_handler);
 
 	for (i = 0; i < enic->wq_count; i++)
 		spin_lock_init(&enic->wq[i].lock);
@@ -3034,14 +3294,16 @@ static void enic_remove(struct pci_dev *pdev)
 		disable_work_sync(&enic->tx_hang_reset);
 		disable_work_sync(&enic->change_mtu_work);
 		unregister_netdev(netdev);
-		enic_dev_deinit(enic);
-		vnic_dev_close(enic->vdev);
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
-			pci_disable_sriov(pdev);
-			enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+			if (enic->vf_type == ENIC_VF_TYPE_V2)
+				enic_sriov_v2_disable(enic);
+			else
+				pci_disable_sriov(pdev);
 		}
 #endif
+		enic_dev_deinit(enic);
+		vnic_dev_close(enic->vdev);
 		kfree(enic->pp);
 		vnic_dev_unregister(enic->vdev);
 		enic_iounmap(enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 6b8b44c4d96e..2fb0f1e2ff50 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -631,8 +631,17 @@ int enic_mbox_vf_unregister(struct enic *enic)
 
 void enic_mbox_init(struct enic *enic)
 {
+	/* mbox_lock and mbox_comp must be initialized exactly once per
+	 * device lifetime; the PF sriov_configure path can re-enter this
+	 * on each enable cycle where these primitives are already set up.
+	 */
+	if (!enic->mbox_initialized) {
+		mutex_init(&enic->mbox_lock);
+		init_completion(&enic->mbox_comp);
+		enic->mbox_initialized = true;
+	} else {
+		reinit_completion(&enic->mbox_comp);
+	}
 	enic->mbox_msg_num = 0;
-	mutex_init(&enic->mbox_lock);
-	init_completion(&enic->mbox_comp);
 	enic->admin_rq_handler = enic_mbox_recv_handler;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_pp.c b/drivers/net/ethernet/cisco/enic/enic_pp.c
index 4720a952725d..3f611e240c25 100644
--- a/drivers/net/ethernet/cisco/enic/enic_pp.c
+++ b/drivers/net/ethernet/cisco/enic/enic_pp.c
@@ -25,6 +25,11 @@ int enic_is_valid_pp_vf(struct enic *enic, int vf, int *err)
 	if (vf != PORT_SELF_VF) {
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
+			/* V2 SR-IOV uses MBOX, not port profiles */
+			if (enic->vf_type == ENIC_VF_TYPE_V2) {
+				*err = -EOPNOTSUPP;
+				goto err_out;
+			}
 			if (vf < 0 || vf >= enic->num_vfs) {
 				*err = -EINVAL;
 				goto err_out;
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 2b7545d6a67f..436326ace049 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -59,6 +59,7 @@ int enic_get_vnic_config(struct enic *enic)
 	GET_CONFIG(intr_timer_usec);
 	GET_CONFIG(loop_tag);
 	GET_CONFIG(num_arfs);
+	GET_CONFIG(mq_subvnic_count);
 	GET_CONFIG(max_rq_ring);
 	GET_CONFIG(max_wq_ring);
 	GET_CONFIG(max_cq_ring);
diff --git a/drivers/net/ethernet/cisco/enic/vnic_enet.h b/drivers/net/ethernet/cisco/enic/vnic_enet.h
index 9e8e86262a3f..519d2969990b 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_enet.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_enet.h
@@ -21,7 +21,9 @@ struct vnic_enet_config {
 	u16 loop_tag;
 	u16 vf_rq_count;
 	u16 num_arfs;
-	u8 reserved[66];
+	u8 reserved1[32];
+	u16 mq_subvnic_count;
+	u8 reserved2[32];
 	u32 max_rq_ring;	// MAX RQ ring size
 	u32 max_wq_ring;	// MAX WQ ring size
 	u32 max_cq_ring;	// MAX CQ ring size

-- 
2.43.0

