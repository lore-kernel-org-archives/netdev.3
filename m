Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050E375F99;
	Sun, 19 Jul 2026 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450609; cv=none; b=RNumplWPV5aPpVPLfNK9kR5F5ZDJ/ko4c4T1w8XIVQxCLqoHuZwMiDoW0YESCynMvaf56ZOoZlWKse9iXA4caQBSIObWHCPvwsveUyztx4ZLEm0qw3rLTk6lau5/mK78Azv1w4nUbOXMTYAwboUF3IFE5lY3iKm5eOnT+enMAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450609; c=relaxed/simple;
	bh=B8hX+8NYlp4nvqpweTDRHzDB20zFjnemFDEBdx6UUaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RAQQIMpHv0e7qOO4asTxRFyh5B62x26muDU8cax2Hk9xO++TkVnd5FIszUq35jBdNhS0iKixyhlrmqpfVUAjUH0fESVMmKi+vnhHBOfIXFquIweeLVSPpti/OYhRMdMxA3l9tOv5Lu/oAVR7dZMSb0pX9YqYfZlQP4wFzIAHL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=GNLj2OFZ; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="GNLj2OFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8924; q=dns/txt;
  s=iport01; t=1784450607; x=1785660207;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4gwSJKlKJDUOeRYixBT9bOvQy8xbX+FlvXDjIciUTrw=;
  b=GNLj2OFZuASMfYlKjFal1JRuBrm7cdK1bGrmO2ho7mr5rbv5k4HcIzxl
   jOV7SEa4jnCJhqnNt4jwhxi6QBwb0CdBF8sZNtXQ7+vEaltppGVNS5QW4
   fvkDWS4YqzsJHXGDth+fthsLtpq8wWqqdIGBAabK4cW4sxs1eZR15p88f
   4pbEY3had+V9JGi0+Rf5O/RWES9XPzViIRH2VExxbqNaF2zjIigGTkv2m
   KFrKkVPnXxTlmC1VPPKXzC8fZcG2tvsayhjDFJnxuEAiZ0oPn7YELbjq1
   e7+CgXNaJ8jCv03LdCsSzUxy5/Z34hvwmdXdCCnjXY2/CGUwY6siWpdGW
   g==;
X-CSE-ConnectionGUID: MuXEb+sdRVS7u2vm84790A==
X-CSE-MsgGUID: JY6AlI69QpGFKIsdb3H2mg==
X-IPAS-Result: =?us-ascii?q?A0AmAAAEjVxq/5H/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBUkNJhFeIG4c3giGeHhSBag8BAQEPUQQBAYUFAo1TAiY0CQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESg?=
 =?us-ascii?q?wKCdQO9C3p/M4EBhH3ZSIFmAQsUAYEKLgGFcIJrAYFwhAc7hEEnG4FJRIEUA?=
 =?us-ascii?q?YNphAUlg3SCagSCDYEPEokdiE8JP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISG?=
 =?us-ascii?q?BUCFBwTDwQWMh1wDCcSLBc0WBsHBYEdfxYEIYEChHYjHwM5f4EwdUp3LWkBE?=
 =?us-ascii?q?heBL4IUgToCBwMLGA1IESw3Bg4ZBD0BbgeNQCOBTQFREAkHAVkhFEI5BC4BA?=
 =?us-ascii?q?gwyJRUILQk6ApJjg36NX2uBNZ9ahCeBZqAPATKXZ5MFmQgjo15ZhGmBaDyBW?=
 =?us-ascii?q?TMaCBsVgyJTGQ+OLRYc0h4nMj8HAgcPApFzBIF6AQE?=
IronPort-Data: A9a23:JCvtOaDfZF6+wRVW//Tiw5YqxClBgxIJ4kV8jS/XYbTApGx21GNUz
 2ceDT+OaamIZTfwe4skbY/k8xxXsZTdydE1OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYAD8imYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE5uheIUt1JoEixN0oHDtQ8
 KxEd2FVR0XW7w626OrTpuhEnM8vKozveYgYoHwllWGfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYyBPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FEoieSwboCJK7RmQ+13rxixo
 kOYrl3hLT85FceTw2GlqHej07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc9ZSK
 lAd/QIioKIz/UrtScPyNzW1rGOBtwwRR/JfFOo17AzLwa3Riy6aG2INZj1MctorsIkxXzNC/
 laPk8nkGn9pvaGZRGy18qqSq3W5OUA9NWYIaCkFZREI79nqvMc4iRenZtJiFrOly974Azf9x
 xiUoyUkwbYel8gG0+O851+vqzShupTEUCYr6QjNGGGo9AV0YMiifYPA1LTAxexLIIDcShyKu
 2IJ3pDOqusPFpqK0ieKRY3hAY2U2hpMCxWE6XYHInXr323FF6KLFWyI3AxDGQ==
IronPort-HdrOrdr: A9a23:oL76ZaDmjrVRy+flHela55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTnEAtjjfZq+z/FICPcqXYtKNTOO0ACVxcNZnOjfKlbbdxEWmNQtsJ
 tIQuxSBML9CF5igd2/wgWpeuxQueWvweSEifjTynF1QRovUaFv6A9lFh2We3cGIjWufaBJc6
 a0145guyeqf2gRY4CQA3kIWPWGmvjw/aiWGSLvw3UcmXOzZfTC0s+ALySl
X-Talos-CUID: 9a23:HLRqy25cBZrdacPzWdss0VMkN8pmaXHn8kyPPhWmDDY1F+zNYArF
X-Talos-MUID: 9a23:5BdvaQuBuR0+wjV8v82npgA8HcNJvfWXEG8jsrQdt8PfFXZ1NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="511456249"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:13 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id CC62018000475;
	Sun, 19 Jul 2026 08:42:12 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 19 Jul 2026 01:41:55 -0700
Subject: [PATCH net-next v12 11/12] enic: add V2 VF probe with admin
 channel and PF registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-11-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=9181;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=B8hX+8NYlp4nvqpweTDRHzDB20zFjnemFDEBdx6UUaY=;
 b=qiOHN06d82JLsijZp+IEdrLAfrvomRLnrlawwhcwQbsrVww/eAiFUrjdTCtZWUdwbz0IGu2z5
 8x6N5+k9xboAJEBjnURlUjsdE1Ej21g3vuATBZLGC85RBOCgfPHLYMV
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

When a V2 SR-IOV VF probes, open the admin channel, initialize the
MBOX protocol, perform the capability check with the PF, and register
with the PF. This establishes the PF-VF communication path that the PF
uses to send link state notifications.

The admin channel and MBOX registration happen after enic_dev_init()
(which discovers admin channel resources) and before register_netdev()
so the VF is fully initialized before the interface is visible to
userspace.

A V2 VF whose firmware did not provision admin WQ/RQ/CQ resources
fails probe with -ENODEV from enic_admin_channel_open(); the admin
channel is a hard requirement for V2 VFs.

The admin channel is opened before enic_mbox_init() installs the
receive handler.  This is safe because enic_admin_rq_cq_service()
checks admin_rq_handler before enqueuing received buffers, so any
interrupt that fires between open and mbox_init is harmlessly
discarded.

On remove, the VF unregisters from the PF and closes its admin channel
before tearing down data path resources.

V2 VFs are not provisioned with an RES_TYPE_SRIOV_INTR resource by
firmware, so bypass that check in the admin channel capability
detection for V2 VFs. The PF still requires this resource.

The admin MSI-X vector reserved by enic_set_intr_mode()
is used for the admin channel interrupt.
enic_adjust_resources() ensures the reserved slot is within
intr_avail bounds even at maximum queue configurations.  The
admin INTR uses a RES_TYPE_INTR_CTRL slot shared with the
data path.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 101 +++++++++++++++++++++++++---
 drivers/net/ethernet/cisco/enic/enic_res.c  |   3 +-
 3 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index b5a43fe04877..62b8941489d7 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -452,6 +452,7 @@ void enic_reset_addr_lists(struct enic *enic);
 int enic_sriov_enabled(struct enic *enic);
 int enic_is_valid_vf(struct enic *enic, int vf);
 int enic_is_dynamic(struct enic *enic);
+int enic_is_sriov_vf_v2(struct enic *enic);
 void enic_set_ethtool_ops(struct net_device *netdev);
 int __enic_set_rsskey(struct enic *enic);
 void enic_ext_cq(struct enic *enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 68a293d60ab8..99c06a049800 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -316,6 +316,11 @@ static int enic_is_sriov_vf(struct enic *enic)
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
@@ -2399,15 +2404,19 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->intr_count = enic->intr_avail;
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX: {
-		/* Reserve one MSI-X slot for the admin channel interrupt
-		 * when V2 SR-IOV admin channel resources are present.
-		 */
-		unsigned int admin_reserve =
-			enic->has_admin_channel ? 1 : 0;
-
 		/* Adjust the number of wqs/rqs/cqs/interrupts that will be
-		 * used based on which resource is the most constrained
+		 * used based on which resource is the most constrained.
+		 * Reserve one extra MSI-X slot for the admin channel INTR
+		 * when has_admin_channel is set so that
+		 * enic_admin_setup_intr() can allocate at intr_count
+		 * within the intr_avail bounds even when the data queue
+		 * count is maxed out.  intr_count counts only the data-path
+		 * IRQs (registered by enic_request_intr()); the admin INTR
+		 * lives at msix index intr_count and is set up later by
+		 * enic_admin_setup_intr().
 		 */
+		unsigned int admin_reserve = enic->has_admin_channel ? 1 : 0;
+
 		wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
 		rq_default = max(netif_get_num_default_rss_queues(),
 				 ENIC_RQ_MIN_DEFAULT);
@@ -3104,6 +3113,44 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_dev_close;
 	}
 
+	/* Initialise link_notify_work before the V2-VF admin-open block below:
+	 * its error path (err_out_admin_close -> enic_admin_channel_close() ->
+	 * cancel_work_sync()) would otherwise act on an uninitialised work.
+	 */
+	INIT_WORK(&enic->link_notify_work, enic_link_notify_work_handler);
+
+	/* V2 VF: open admin channel and register with PF.
+	 * Must happen before register_netdev so the VF is fully
+	 * initialized before the interface is visible to userspace.
+	 *
+	 * admin_channel_open() runs before enic_mbox_init() installs
+	 * the receive handler.  This is safe because
+	 * enic_admin_rq_cq_service() checks admin_rq_handler before
+	 * enqueuing any received buffer, so interrupts that fire
+	 * between open and mbox_init are harmlessly discarded.
+	 */
+	if (enic_is_sriov_vf_v2(enic)) {
+		err = enic_admin_channel_open(enic);
+		if (err) {
+			dev_err(dev,
+				"Failed to open admin channel: %d\n", err);
+			goto err_out_dev_deinit;
+		}
+		enic_mbox_init(enic);
+		err = enic_mbox_vf_capability_check(enic);
+		if (err) {
+			dev_err(dev,
+				"MBOX capability check failed: %d\n", err);
+			goto err_out_admin_close;
+		}
+		err = enic_mbox_vf_register(enic);
+		if (err) {
+			dev_err(dev,
+				"MBOX VF registration failed: %d\n", err);
+			goto err_out_admin_close;
+		}
+	}
+
 	netif_set_real_num_tx_queues(netdev, enic->wq_count);
 	netif_set_real_num_rx_queues(netdev, enic->rq_count);
 
@@ -3116,7 +3163,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
-	INIT_WORK(&enic->link_notify_work, enic_link_notify_work_handler);
 
 	for (i = 0; i < enic->wq_count; i++)
 		spin_lock_init(&enic->wq[i].lock);
@@ -3129,7 +3175,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = enic_set_mac_addr(netdev, enic->mac_addr);
 	if (err) {
 		dev_err(dev, "Invalid MAC address, aborting\n");
-		goto err_out_dev_deinit;
+		goto err_out_admin_close;
 	}
 
 	enic->tx_coalesce_usecs = enic->config.intr_timer_usec;
@@ -3227,11 +3273,23 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Cannot register net device, aborting\n");
-		goto err_out_dev_deinit;
+		goto err_out_admin_close;
 	}
 
 	return 0;
 
+err_out_admin_close:
+	if (enic_is_sriov_vf_v2(enic)) {
+		if (enic->vf_registered) {
+			int unreg_err = enic_mbox_vf_unregister(enic);
+
+			if (unreg_err)
+				netdev_warn(netdev,
+					    "Failed to unregister from PF: %d\n",
+					    unreg_err);
+		}
+		enic_admin_channel_close(enic);
+	}
 err_out_dev_deinit:
 	enic_dev_deinit(enic);
 err_out_dev_close:
@@ -3269,7 +3327,30 @@ static void enic_remove(struct pci_dev *pdev)
 		cancel_work_sync(&enic->reset);
 		cancel_work_sync(&enic->tx_hang_reset);
 		cancel_work_sync(&enic->change_mtu_work);
+
+		/* Close the admin channel and unregister from the PF before
+		 * unregister_netdev() to prevent a late PF notification from
+		 * touching a netdev that is being torn down.
+		 */
+		if (enic_is_sriov_vf_v2(enic)) {
+			if (enic->vf_registered) {
+				int unreg_err = enic_mbox_vf_unregister(enic);
+
+				if (unreg_err)
+					netdev_warn(netdev,
+						    "Failed to unregister from PF: %d\n",
+						    unreg_err);
+			}
+			enic_admin_channel_close(enic);
+		}
+
 		unregister_netdev(netdev);
+		/* unregister_netdev() -> enic_stop() stops the notify timer, so
+		 * no new link_notify_work can be queued past this point.  Cancel
+		 * unconditionally to cover the narrow window where
+		 * enic_link_check() scheduled it just as SR-IOV was disabled.
+		 */
+		cancel_work_sync(&enic->link_notify_work);
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
 			if (enic->vf_type == ENIC_VF_TYPE_V2)
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 436326ace049..74cd2ee3af5c 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -211,7 +211,8 @@ void enic_get_res_counts(struct enic *enic)
 		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_RQ) >= 1 &&
 		vnic_dev_get_res_count(enic->vdev, RES_TYPE_ADMIN_CQ) >=
 			ARRAY_SIZE(enic->admin_cq) &&
-		vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1;
+		(enic_is_sriov_vf_v2(enic) ||
+		 vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1);
 
 	dev_info(enic_get_dev(enic),
 		"vNIC resources avail: wq %d rq %d cq %d intr %d admin %s\n",

-- 
2.43.0

