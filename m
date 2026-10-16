Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F643E49B;
	Fri, 16 Oct 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137562; cv=none; b=Wx5rM83U5kN3+aszzwdhsGrXlWwYn4Jszu+dr8G7wPfF6IyO4XOxF/EuVLB9c7Y+pli9Vte9gGB0Uxzwb8uAUyIdZB7lvIWlXd+Et3P7g1GUoQa6vbJcvxiew+FqdNDbJPGmrfdrlQQ5I/5L+4oiY6UnKZUiq3j4SrkikuXf70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137562; c=relaxed/simple;
	bh=dlkj/ngXxaTXTu3E94fCRCP+tPwPWfFLzaLbPAtshfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcE6A3VDI/IaaLO3ck7NxC6wZLx786v5Viv7U6XpzJGB0N0ML4X0kov8jzMbEb1gWiLl8mmA5JfNWRXxEb5A0JOC+wSmku9O9wa5p4U1ZTb9XYqiSwaGOYi9wV4KKxTPmFS2tx7T20pqlLP65IFFAuCQ5XmGGg3OmCbl/aUTdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=lAEhTmYH; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="lAEhTmYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=17598; q=dns/txt;
  s=iport01; t=1792137560; x=1793347160;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kxovuOn9+BMWXE1Av05xqNKygUq2wHnFnOBHFcPLQ/0=;
  b=lAEhTmYHWyJJr1teoDxH/oh7k0hy0AARX0H3fmvB7+R0gGqTvBOl8Qe2
   /CUIZXJPCjfC7C8fxQALnyHzi9WDMR8gosk/U0eP3/gk99hsswkYxOM1U
   5SbT3C1nAYmnk72eQ0mJ1S41TILEWavAuAklNOTPMhBzSpaX78NGd2PYs
   QgadnjFzUoAg/mKb1Xkd4bKgDZbBFizrcTea3YRh1sEZIgRLiL8Eky7Ey
   HbJTgpEO5oHD8v40STttBAA7j9CYZUa0DyuIgkE7LK9ADopili/qWHAO9
   qKvGJ5mxzMjBTBo6L29Z2RFEJGtdB5JJ9xJcdA2ZEPiDGCblGRGkjxgoz
   Q==;
X-CSE-ConnectionGUID: sXnXB+vNTWmE6EeULuFzCw==
X-CSE-MsgGUID: 5Txm2RsxRK2BSgaKN/IONg==
X-IPAS-Result: =?us-ascii?q?A0BIAgCT19Fq/4z/Ja1RCYJZgleBVUNJhFePUoIhgRaQN?=
 =?us-ascii?q?4xSgX4PAQEBD1EEAQGEBAGBAAKOFQImNAkOAQIEAwIDAQEBAQEBAQEBAQEBC?=
 =?us-ascii?q?gEBBQEBAQIBBwWBDhOGXJATAgEDIwRSECUCJgICRhAGARKDAoJ1A70uen8zg?=
 =?us-ascii?q?QGEftlKgWgBCxQBgQouhXKCbQGBcYQIO4RBJxuBSUSBFYJzdoQXCIN/gmoEg?=
 =?us-ascii?q?g2BDxKGaJA5CT+BAhwDWSwBVRMNCgsHBWNSMwMgCgsSEhgVAhQcARIPBBYyH?=
 =?us-ascii?q?XAMJxIsFy9YGwYFgR11FAQTghYjGTZ6gQlegSspYAEQF4EJggcCglSCAAIBS?=
 =?us-ascii?q?UEOB0VTCSVDEkcmIggSCQETGjALgRs4PAkoQRcMcQIJAx0FTgIiCAINCQcpG?=
 =?us-ascii?q?A1IESw3Bg8ZBD0BbgeSFB6BcwFxFhkOHAEhFEIKMz0JThsCDx4BCAIRLJALg?=
 =?us-ascii?q?lWDfo1ea4E1n1qEKIFmoBAzl2eTCJkII6NIBhgDTYRpgWg8gVkzGggbFYMiU?=
 =?us-ascii?q?xkPji4Wkx0BvxwnMj0CBwIHDgMLkWoPFweBTwEB?=
IronPort-Data: A9a23:liN3bKsegUN0SfR/Z4jS9MkOYOfnVIRfMUV32f8akzHdYApBsoF/q
 tZmKWiGaaqOMGehKNAgb4iy8kgEuZ/dytdrTgVlpS49FioTgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrb/656yYsjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZzdJ5xYuajhKsvra9ks21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw4dZxMUsN6
 9okFzUgMD2Ousar7qCQVbw57igjBJGD0II3oHpsy3TdSP0hW52GG/6M7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtPYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoHRGJ4KzxvJ/
 goq+UykPgEfbuaE2QCmqFiXiebsu2Taf6QdQejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdx61uniJulgbQdU4O+098gSW4qnZ+QCUAi4DVDEpQN87vsYeRjEw0
 FKN2dTzClRHubuZU3+CtbGZsT+/JwARMGkEIyQEJSMd6tPupoAblB/DTt9/VqWyi7XdHTD23
 iDPryUkgbgXpdAE2r/9/l3dhT+o4J/TQWYd4AjLUm+7xh12aZTjZIGy71Xfq/FaI+6kokKpp
 nMInY2aqesJF5zIzHfLS+QWF7bv7PGAWNHBvWNS81Aa32zF0xaekUp4vVmS+G8B3h44RALU
IronPort-HdrOrdr: A9a23:1w13O6GQUoo+QNA/pLqEHseALOsnbusQ8zAXPo5KOHhom6uj9v
 xG/c506faaslsssR0b8+xofZPwI080lqQb3WBuB9eftWDd0QPCEGgh1/qA/9SKIUHDH4BmpM
 JdWpk7JdHuAV19lMrgpCu1A78bsaC62ZHtqOvAw3JqVA1wL5th4QBwFxqBHiRNNW977OICZf
 2hz/sCgSa8cnIKacn+LHwEU+/f4+DvrvvdEGY779pN0nj1sdtug4SKaCSl4g==
X-Talos-CUID: =?us-ascii?q?9a23=3A6LuiqGrfIPIPBQn9X3rCJcbmUdsVdE33j2n2H3C?=
 =?us-ascii?q?9JDhERYCxVHGC07wxxg=3D=3D?=
X-Talos-MUID: 9a23:lBEJpwY19lrMYeBT6gP8gWtYL9dSwP6EM08EsrNBmu6iOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,161,1787011200"; 
   d="scan'208";a="535379590"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 16 Oct 2026 07:58:11 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 61DFA18000629;
	Fri, 16 Oct 2026 07:58:10 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 16 Oct 2026 00:57:53 -0700
Subject: [PATCH net 3/3] enic: require DEVCMD2 and set the V2 VF mailbox
 source
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-3-d27b55f69883@cisco.com>
References: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com>
In-Reply-To: <20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792137487; l=18011;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=dlkj/ngXxaTXTu3E94fCRCP+tPwPWfFLzaLbPAtshfk=;
 b=FTzwqOKGCjoF4Es8tKRqgeO7KuyX2/0Y1WJVpU2jkFD5X/ycrh6/hrP7/nP9sMblGoqwQIkLy
 PHWN0Whm8NAA+YH8SWdj31IzQ86odmfTVTSyAuYZzjf6UDENfVm3ptf
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-03.cisco.com

enic_mbox_fill_hdr() clears the mailbox header, leaving src_vnic_id zero.
That is correct only for VF index zero.

The deployed async PF compares the mailbox source with sender identity from
CQ metadata and rejects mismatches. A nonzero VF therefore cannot complete
mailbox registration when the in-tree VF always sends source zero.

CMD_SRIOV_STATS_GET is part of the deployed V2 contract and returns this
function's logical VF index. Query it after opening the admin channel but
before the first outbound mailbox request. If the command is unavailable
or fails, fail probe cleanly rather than sending an ambiguous source.
Annotate its multibyte DMA fields as little endian, order reads after
command completion, convert and snapshot the version and VF index once,
validate version 1, and reject the PF sentinel.

Require DEVCMD2 for SR-IOV V2. A V2 VF without DEVCMD2 fails probe before
opening its admin channel. A PF which has fallen back to DEVCMD1 keeps its
normal Ethernet function but does not expose V2 SR-IOV. Legacy V1 and USNIC
operation retain their existing DEVCMD1 fallback.

DEVCMD2 returns -ENODEV only while checking the command queue, before it
posts a descriptor. A timeout after posting is therefore the only error
which leaves ownership of the statistics-command DMA target uncertain.
DEVCMD2 runs one command at a time for a vNIC, and the statistics command
is completed only after the DMA write to its target finishes. Completion
of a later blocking command for the same vNIC therefore fences that target.
In the current probe unwind, QP_TYPE_SET during admin-channel teardown is
that fence. This is separate from WQ/RQ ownership: queue resources still
require their own RUNNING == 0 observations.

Keep the persistent target allocated while its ownership is uncertain. If
no later command establishes the completion fence, retain the target and
the shared vNIC lifetime envelope until reboot. Clearing bus mastering
contains the function but does not itself prove that already-issued DMA
has completed.

Use the firmware VF index as the little-endian source of subsequent VF
messages. Initialize the stored index to the protocol PF sentinel so an
unexpected message before the statistics command completes cannot use zero
as an apparently valid VF0 identity. PF and non-V2 senders use the protocol
PF sentinel directly rather than the old implicit zero.

The defect was found during interoperability testing of the in-tree V2 VF
against the deployed async PF: VF0 could register, while a nonzero VF's
source field disagreed with the sender index derived by the PF from CQ
metadata.

The statistics-command identity, nonzero-VF registration, and mailbox
interoperability were exercised against the deployed async PF. The composed
driver also passed the no-reboot SR-IOV receive-control and stress suite.

Fixes: 1f0c856b5963 ("enic: add MBOX core send and receive for admin channel")
Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Reviewed-by: Aravind Dhanasekaran <aradhana@cisco.com>
Reviewed-by: Reese Faucette <rfaucett@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h        |  5 +++
 drivers/net/ethernet/cisco/enic/enic_admin.c  | 11 +++++++
 drivers/net/ethernet/cisco/enic/enic_dev.c    | 15 +++++++++
 drivers/net/ethernet/cisco/enic/enic_dev.h    |  2 ++
 drivers/net/ethernet/cisco/enic/enic_main.c   | 47 ++++++++++++++++++++++++---
 drivers/net/ethernet/cisco/enic/enic_mbox.c   | 12 +++++--
 drivers/net/ethernet/cisco/enic/vnic_dev.c    | 42 ++++++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/vnic_dev.h    |  5 +++
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h | 34 +++++++++++++++++++
 9 files changed, 167 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index cf2dee8fa78f..886f3cba543d 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -273,6 +273,11 @@ struct enic {
 	u16 num_vfs;
 	enum enic_vf_type vf_type;
 	bool vf_registered;
+	u16 vf_id;
+	/* A CMD_SRIOV_STATS_GET timeout leaves its persistent coherent target
+	 * device-owned until a later serialized command completes.
+	 */
+	bool sriov_stats_dma_unresolved;
 	u32 pf_cap_version;
 	unsigned int enable_count;
 	spinlock_t enic_api_lock;
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index a5c08cbcb339..2f6688a73b41 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -406,6 +406,12 @@ static int enic_admin_qp_type_set(struct enic *enic, u32 enable)
 
 	spin_lock_bh(&enic->devcmd_lock);
 	err = vnic_dev_cmd(enic->vdev, CMD_QP_TYPE_SET, &a0, &a1, wait);
+	/* DEVCMD2 runs one command at a time for a vNIC. Completion of this
+	 * blocking command proves that earlier statistics-command DMA has
+	 * finished. Admin WQ/RQ ownership still requires RUNNING == 0.
+	 */
+	if (!err)
+		WRITE_ONCE(enic->sriov_stats_dma_unresolved, false);
 	spin_unlock_bh(&enic->devcmd_lock);
 
 	return err;
@@ -546,6 +552,11 @@ int enic_admin_channel_open(struct enic *enic)
 			   "Refusing to reopen poisoned admin channel\n");
 		return -EIO;
 	}
+	if (READ_ONCE(enic->sriov_stats_dma_unresolved)) {
+		netdev_err(enic->netdev,
+			   "Refusing to reopen admin channel before SR-IOV statistics-command DMA is fenced\n");
+		return -EIO;
+	}
 	/* Keep MBOX sends disabled for the entire open sequence.  It is
 	 * cleared only after every resource is allocated and enabled below,
 	 * so any early error return here leaves sends disabled and a
diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.c b/drivers/net/ethernet/cisco/enic/enic_dev.c
index 659787f73cf1..695e1db625c0 100644
--- a/drivers/net/ethernet/cisco/enic/enic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/enic_dev.c
@@ -171,6 +171,21 @@ int enic_dev_intr_coal_timer_info(struct enic *enic)
 	return err;
 }
 
+int enic_dev_sriov_stats(struct enic *enic,
+			 struct vnic_sriov_stats **stats)
+{
+	int err;
+
+	*stats = NULL;
+	spin_lock_bh(&enic->devcmd_lock);
+	err = vnic_dev_sriov_stats(enic->vdev, stats);
+	if (err == -ETIMEDOUT)
+		WRITE_ONCE(enic->sriov_stats_dma_unresolved, true);
+	spin_unlock_bh(&enic->devcmd_lock);
+
+	return err;
+}
+
 /* rtnl lock is held */
 int enic_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 {
diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.h b/drivers/net/ethernet/cisco/enic/enic_dev.h
index 698d0cb02064..4bd67578801f 100644
--- a/drivers/net/ethernet/cisco/enic/enic_dev.h
+++ b/drivers/net/ethernet/cisco/enic/enic_dev.h
@@ -40,6 +40,8 @@ int enic_dev_set_ig_vlan_rewrite_mode(struct enic *enic);
 int enic_dev_enable(struct enic *enic);
 int enic_dev_disable(struct enic *enic);
 int enic_dev_intr_coal_timer_info(struct enic *enic);
+int enic_dev_sriov_stats(struct enic *enic,
+			 struct vnic_sriov_stats **stats);
 int enic_dev_status_to_errno(int devcmd_status);
 
 #endif /* _ENIC_DEV_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 06d76648b420..5574d71aa9a5 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -3024,6 +3024,12 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 
 	if (enic->vf_type != ENIC_VF_TYPE_V2)
 		return;
+	if (!vnic_dev_uses_devcmd2(enic->vdev)) {
+		dev_warn(&pdev->dev,
+			 "SR-IOV V2 requires DEVCMD2; disabling V2 support\n");
+		enic->vf_type = ENIC_VF_TYPE_NONE;
+		return;
+	}
 
 	/* A successful command means firmware recognizes
 	 * VIC_FEATURE_SRIOV; supported_versions is available
@@ -3199,6 +3205,7 @@ enic_sriov_configure(struct pci_dev *pdev, int num_vfs)
 
 static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	struct vnic_sriov_stats *sriov_stats;
 	struct device *dev = &pdev->dev;
 	struct net_device *netdev;
 	struct enic *enic;
@@ -3226,6 +3233,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	enic = netdev_priv(netdev);
 	enic->netdev = netdev;
 	enic->pdev = pdev;
+	WRITE_ONCE(enic->vf_id, ENIC_MBOX_DST_PF);
 	spin_lock_init(&enic->vf_link_state_lock);
 
 	/* Setup PCI resources
@@ -3295,6 +3303,12 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (err)
 		goto err_out_vnic_unregister;
+	if (enic_is_sriov_vf_v2(enic) &&
+	    !vnic_dev_uses_devcmd2(enic->vdev)) {
+		dev_err(dev, "SR-IOV V2 VF requires DEVCMD2\n");
+		err = -EOPNOTSUPP;
+		goto err_out_vnic_unregister;
+	}
 
 #ifdef CONFIG_PCI_IOV
 	enic_sriov_detect_vf_type(enic);
@@ -3404,6 +3418,9 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * unmasks the admin interrupt so an early completion is not dropped.
 	 */
 	if (enic_is_sriov_vf_v2(enic)) {
+		u32 stats_ver;
+		u16 vf_id;
+
 		enic_mbox_init(enic);
 		err = enic_admin_channel_open(enic);
 		if (err) {
@@ -3411,6 +3428,27 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				"Failed to open admin channel: %d\n", err);
 			goto err_out_admin_fence;
 		}
+
+		err = enic_dev_sriov_stats(enic, &sriov_stats);
+		if (err) {
+			dev_err(dev, "Failed to get SR-IOV statistics: %d\n",
+				err);
+			goto err_out_admin_close;
+		}
+		/* enic_dev_sriov_stats() orders reads from the coherent target.
+		 * Snapshot each multibyte field once.
+		 */
+		stats_ver = le32_to_cpu(sriov_stats->ver);
+		vf_id = le16_to_cpu(sriov_stats->vf_index);
+		if (stats_ver != VNIC_SRIOV_STATS_VERSION ||
+		    vf_id == ENIC_MBOX_DST_PF) {
+			dev_err(dev,
+				"Invalid SR-IOV statistics version %u VF index %#x\n",
+				stats_ver, vf_id);
+			err = -EINVAL;
+			goto err_out_admin_close;
+		}
+		WRITE_ONCE(enic->vf_id, vf_id);
 		err = enic_mbox_vf_capability_check(enic);
 		if (err) {
 			dev_err(dev,
@@ -3573,7 +3611,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_admin_fence:
 	if (enic_dma_quarantined(enic)) {
 		dev_err(dev,
-			"Queue DMA ownership unresolved; retaining probe resources until reboot\n");
+			"DMA ownership unresolved; retaining probe resources until reboot\n");
 		enic_terminal_dma_quarantine(enic);
 		pci_disable_device(pdev);
 		return err;
@@ -3608,7 +3646,8 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 static bool enic_dma_quarantined(struct enic *enic)
 {
 	return enic_datapath_is_quarantined(enic) ||
-	       enic_admin_channel_is_quarantined(enic);
+	       enic_admin_channel_is_quarantined(enic) ||
+	       READ_ONCE(enic->sriov_stats_dma_unresolved);
 }
 
 static int enic_datapath_recheck_on_remove(struct enic *enic)
@@ -3667,7 +3706,7 @@ static void enic_terminal_dma_quarantine(struct enic *enic)
 	enic_free_affinity_hint(enic);
 
 	/* Preserve netdev, vdev, BAR mappings, regions, rings, and their buffer
-	 * metadata because queue ownership remains unresolved until reboot.
+	 * metadata because DMA ownership remains unresolved until reboot.
 	 */
 	pci_clear_master(enic->pdev);
 }
@@ -3727,7 +3766,7 @@ static void enic_remove(struct pci_dev *pdev)
 			enic_datapath_recheck_on_remove(enic);
 		if (enic_dma_quarantined(enic)) {
 			dev_err(&pdev->dev,
-				"Queue DMA ownership unresolved; retaining resources until reboot\n");
+				"DMA ownership unresolved; retaining resources until reboot\n");
 			enic_terminal_dma_quarantine(enic);
 			retain_dma = true;
 			goto disable_device;
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index e106ee7d411d..1716da29eee7 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -18,10 +18,17 @@
 #define ENIC_MBOX_POLL_TIMEOUT_US	5000000
 #define ENIC_MBOX_POLL_INTERVAL_US	100
 
-static void enic_mbox_fill_hdr(struct enic_mbox_hdr *hdr, u8 msg_type,
+static void enic_mbox_fill_hdr(struct enic *enic, struct enic_mbox_hdr *hdr,
+			       u8 msg_type,
 			       u16 dst_vnic_id, u16 msg_len, u64 msg_num)
 {
+	u16 src_vnic_id = ENIC_MBOX_DST_PF;
+
+	if (enic_is_sriov_vf_v2(enic))
+		src_vnic_id = READ_ONCE(enic->vf_id);
+
 	memset(hdr, 0, sizeof(*hdr));
+	hdr->src_vnic_id = cpu_to_le16(src_vnic_id);
 	hdr->dst_vnic_id = cpu_to_le16(dst_vnic_id);
 	hdr->msg_type = msg_type;
 	hdr->msg_len = cpu_to_le16(msg_len);
@@ -85,7 +92,8 @@ static int enic_mbox_send_msg_id(struct enic *enic, u8 msg_type,
 		reply_expected = true;
 	}
 
-	enic_mbox_fill_hdr(buf, msg_type, dst_vnic_id, total_len, msg_num);
+	enic_mbox_fill_hdr(enic, buf, msg_type, dst_vnic_id, total_len,
+			   msg_num);
 	if (payload_len) {
 		void *dst = buf + sizeof(struct enic_mbox_hdr);
 
diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
index c8d657e97094..1a00f55658d4 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c
@@ -1046,6 +1046,11 @@ void vnic_dev_unregister(struct vnic_dev *vdev)
 			dma_free_coherent(&vdev->pdev->dev,
 					  sizeof(struct vnic_stats),
 					  vdev->stats, vdev->stats_pa);
+		if (vdev->sriov_stats)
+			dma_free_coherent(&vdev->pdev->dev,
+					  sizeof(struct vnic_sriov_stats),
+					  vdev->sriov_stats,
+					  vdev->sriov_stats_pa);
 		if (vdev->fw_info)
 			dma_free_coherent(&vdev->pdev->dev,
 					  sizeof(struct vnic_devcmd_fw_info),
@@ -1088,6 +1093,11 @@ struct pci_dev *vnic_dev_get_pdev(struct vnic_dev *vdev)
 }
 EXPORT_SYMBOL(vnic_dev_get_pdev);
 
+bool vnic_dev_uses_devcmd2(struct vnic_dev *vdev)
+{
+	return vdev->devcmd2;
+}
+
 int vnic_devcmd_init(struct vnic_dev *vdev)
 {
 	void __iomem *res;
@@ -1295,3 +1305,35 @@ int vnic_dev_capable_rss_hash_type(struct vnic_dev *vdev, u8 *rss_hash_type)
 
 	return 0;
 }
+
+int vnic_dev_sriov_stats(struct vnic_dev *vdev,
+			 struct vnic_sriov_stats **stats)
+{
+	u64 a0, a1;
+	int err;
+
+	*stats = NULL;
+	if (!vdev->sriov_stats) {
+		vdev->sriov_stats =
+			dma_alloc_coherent(&vdev->pdev->dev,
+					   sizeof(*vdev->sriov_stats),
+					   &vdev->sriov_stats_pa,
+					   GFP_ATOMIC);
+		if (!vdev->sriov_stats)
+			return -ENOMEM;
+	}
+
+	memset(vdev->sriov_stats, 0, sizeof(*vdev->sriov_stats));
+	a0 = vdev->sriov_stats_pa;
+	a1 = sizeof(*vdev->sriov_stats);
+	err = vnic_dev_cmd(vdev, CMD_SRIOV_STATS_GET, &a0, &a1, 1000);
+	if (!err) {
+		/* Order CPU reads from the coherent target after command
+		 * completion.
+		 */
+		dma_rmb();
+		*stats = vdev->sriov_stats;
+	}
+
+	return err;
+}
diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.h b/drivers/net/ethernet/cisco/enic/vnic_dev.h
index 7fdd8c661c99..467435f57b92 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.h
@@ -93,6 +93,8 @@ struct vnic_dev {
 	dma_addr_t linkstatus_pa;
 	struct vnic_stats *stats;
 	dma_addr_t stats_pa;
+	struct vnic_sriov_stats *sriov_stats;
+	dma_addr_t sriov_stats_pa;
 	struct vnic_devcmd_fw_info *fw_info;
 	dma_addr_t fw_info_pa;
 	enum vnic_proxy_type proxy;
@@ -163,6 +165,7 @@ struct vnic_dev *vnic_dev_register(struct vnic_dev *vdev,
 	void *priv, struct pci_dev *pdev, struct vnic_dev_bar *bar,
 	unsigned int num_bars);
 struct pci_dev *vnic_dev_get_pdev(struct vnic_dev *vdev);
+bool vnic_dev_uses_devcmd2(struct vnic_dev *vdev);
 int vnic_dev_init_prov2(struct vnic_dev *vdev, u8 *buf, u32 len);
 int vnic_dev_enable2(struct vnic_dev *vdev, int active);
 int vnic_dev_enable2_done(struct vnic_dev *vdev, int *status);
@@ -177,5 +180,7 @@ int vnic_dev_overlay_offload_cfg(struct vnic_dev *vdev, u8 overlay,
 int vnic_dev_get_supported_feature_ver(struct vnic_dev *vdev, u8 feature,
 				       u64 *supported_versions, u64 *a1);
 int vnic_dev_capable_rss_hash_type(struct vnic_dev *vdev, u8 *rss_hash_type);
+int vnic_dev_sriov_stats(struct vnic_dev *vdev,
+			 struct vnic_sriov_stats **stats);
 
 #endif /* _VNIC_DEV_H_ */
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 90ca06691ebd..9f397df88c50 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -461,6 +461,14 @@ enum vnic_devcmd_cmd {
 	 * in: (u32) a1 = enable (1) / disable (0)
 	 */
 	CMD_QP_TYPE_SET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 97),
+
+	/*
+	 * Get SR-IOV capabilities, resource usage, and this function's logical
+	 * VF index.
+	 * in: (u64) a0 = DMA address of struct vnic_sriov_stats
+	 * in: (u32) a1 = length of the buffer
+	 */
+	CMD_SRIOV_STATS_GET = _CMDC(_CMD_DIR_WRITE, _CMD_VTYPE_ENET, 98),
 };
 
 #define QP_TYPE_ADMIN	0
@@ -468,6 +476,32 @@ enum vnic_devcmd_cmd {
 #define QP_ENABLE	1
 #define QP_DISABLE	0
 
+#define VNIC_SRIOV_STATS_VERSION	1
+
+struct vnic_sriov_stats {
+	__le32 ver;
+	u8 sriov_vlan_membership_cap;
+	u8 sriov_vlan_membership_enabled;
+	u8 sriov_rss_vf_full_cap;
+	u8 sriov_host_rx_stats;
+	__le32 ig_classifier0_tcam_cfg;
+	__le32 ig_classifier0_tcam_free;
+	__le32 eg_classifier0_tcam_cfg;
+	__le32 eg_classifier0_tcam_free;
+	__le32 ig_classifier1_tcam_cfg;
+	__le32 ig_classifier1_tcam_free;
+	__le32 eg_classifier1_tcam_cfg;
+	__le32 eg_classifier1_tcam_free;
+	__le32 sriov_ig_flow_table_cfg;
+	__le32 sriov_ig_flow_table_free;
+	__le32 sriov_eg_flow_table_cfg;
+	__le32 sriov_eg_flow_table_free;
+	u8 admin_qp_ready[32];
+	__le16 vf_index;
+	__le16 reserved1;
+	__le32 reserved2[256 - 23];
+};
+
 /* CMD_ENABLE2 flags */
 #define CMD_ENABLE2_STANDBY 0x0
 #define CMD_ENABLE2_ACTIVE  0x1

-- 
2.43.0

