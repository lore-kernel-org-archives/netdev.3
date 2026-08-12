Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C543F087;
	Wed, 12 Aug 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539002; cv=none; b=JFpvu76gpM9S3LtUVpUNVxIPnlHnlZpTz430yYmuBFtKqEJDk9nn1SRjNLH0yDaNPy6n09e7QVUuJqZqPVZNN6WVS6BhXgqHxBR1RJIx9Vm5gKqyzxMzW2XDuBENC6Uj+h3m3/IMlWRxqlIn5MJrlM5EWNCB5h9qyPlXMQ6V4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539002; c=relaxed/simple;
	bh=WxsYFih6wYOLKVJQoFvVetI73w4pCI+AZNE5J1qA8QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JsXF9QwV0/uRXuQpkROvr2SzkNOHjw17GHSrRKf14wRt1vHRlRicOkr6082o8KzVHe/nI3LZxU8lGX5Vrt+V8HAddPo6gICLlKV+h/7OpnBZ6iBG4XAebRrMw9VPp2w87BAIOyONr9hW0AHG55sPYiMdSQN2vUCOTKN4VRJgNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=H3siqBl4; arc=none smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="H3siqBl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7780; q=dns/txt;
  s=iport01; t=1786538997; x=1787748597;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wOXI+ODlXPqHFlA7dILifHkt/mTTBOFtD6/BJ+CaDXw=;
  b=H3siqBl4h3tCzslBy56RK5ftkaDFJ3wvQFO2W3ad9qyYVqtYySNsAQAW
   Oc1hZC03DW911RaiRXf4uRImwVyad/vcO5zeOUHnqjO1tVPAObKFXp+vh
   1poL4XVDU8FD2Cd6Qm0o8Lm0njBZexkqCpvzYp+YxvRrTgC8VjLDfCqY/
   WJnGyFpatj88tj0lZ0uI9ZbdbepiynzMVeBDSnclwqNm4sBLns+YQqSgX
   Kn111RZNBddeCdXRU1G06+Q3thoGW/a+LdyQRk8njQh0kbRQjQbi1NvOn
   RRUzA/96I64vj9myVNA7h5wwmO7AwiBJjnFU32+BX4aysGDHUPQuMibjy
   g==;
X-CSE-ConnectionGUID: MlLNaoOBTjKG0pYgniE8yg==
X-CSE-MsgGUID: Z0kONBk3QmO1+tN2Bye58A==
X-IPAS-Result: =?us-ascii?q?A0AaAADWanxq/5EQJK1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBglaBUkNJhFeIG4c3giGeHhSBag8BAQEPUQQBAYUFAo1nAiY0CQ4BA?=
 =?us-ascii?q?gQDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCA?=
 =?us-ascii?q?kYQBgESgwKCdQPDK3p/M4EBhH3ZSYFmAQsUAYEKLgGFcIJsAYFwhAg7hEEnG?=
 =?us-ascii?q?4FJRIEUAYNphAUlg3SCagSCDYEPEogmgz6HHAk/gQIcA1ksAVUTDQoLBwVhU?=
 =?us-ascii?q?jMDIAoLEhIYFQIUHBMPBBYyHXAMJxIsFzVYGwYFgR19FAQThDYjGTZ8gQlhg?=
 =?us-ascii?q?SsqZQESF4EJgiQCgnaBKmECAR4LGA1IESw3Bg4ZBD0BbgeOCCCBUwFREAkHA?=
 =?us-ascii?q?VkhFEI5BC4BAgwyJRUILQk6ApJjg36NX2uBNZ9ahCiBZqAPATKXZ5MFmQgjo?=
 =?us-ascii?q?15ZhGmBaDyBWTMaCBsVgyJTGQ+OLRYcz30nMj8HAgcPApFzBIF6AQE?=
IronPort-Data: A9a23:K5MuRqJtMu0Dzv5SFE+RA5QlxSXFcZb7ZxGr2PjKsXjdYENS0DVVn
 2pLD2qGOKzea2LzeYt1Po+39UJUsJbQm99lGVEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnQ0
 T/Oi5eHYgH9i2cuajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1LCGUQNIo/0Np1Ik4W7
 c0XLjEgPgGM0rfeLLKTEoGAh+wqKM3teYdasXZ6wHSBXbAtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzMXwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQhiOawbISOJ4DiqcN9rB6bg
 UTs/D/ABzZDd8C5kxCU/y/8r7qa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pbJ
 k0I8y0GoaU49UWtCN7nUHWQrXKZuxcOVsZ4HOo95wWAjKHT5m6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5JKIKfC13Et
 38elo3GvKYFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz0k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:kxYzdK9/vBZUk+nHmb1uk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: 9a23:qvyJCWOJPDurtu5DfS1D0kcTPeoZcF7ylG/hLEm5JDZ4R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AQk5Y0g4R4ibhKk2pxbhgs6+Axoxau6eJLmoOyqw?=
 =?us-ascii?q?DnJDHKQoqESaQ0WSeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="806546354"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 12:48:39 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 7CC6A1800075A;
	Wed, 12 Aug 2026 12:48:38 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 12 Aug 2026 05:48:10 -0700
Subject: [PATCH net-next v13 10/11] enic: add V2 VF probe with admin
 channel and PF registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-enic-sriov-v2-admin-channel-v2-v13-10-b3809e448aba@cisco.com>
References: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786538908; l=8016;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=WxsYFih6wYOLKVJQoFvVetI73w4pCI+AZNE5J1qA8QU=;
 b=Vu7fAf3+B2oFocI0i4PH0u2V/gPLkWpMBZxoSEYmjcLcv/x5AtfH2O6DJSMKi3rqbVmKvFoOt
 wTM0ZGLc8MZB4tTrq5aVht0QxxBzDnJqEiv0pVd7+RmcUIR02Qwv3L9
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-08.cisco.com

When a V2 SR-IOV VF probes, initialize the MBOX protocol, open the
admin channel, perform the capability check with the PF, and register
with the PF. This establishes the PF-VF communication path that the PF
uses to send link state notifications.

The admin channel and MBOX registration happen after enic_dev_init()
(which discovers admin channel resources) and before register_netdev()
so the VF is fully initialized before the interface is visible to
userspace.

A V2 VF whose firmware did not provision admin WQ/RQ/CQ resources
fails probe with -ENODEV from enic_admin_channel_open(); the admin
channel is a hard requirement for V2 VFs.

enic_mbox_init() installs the receive handler and resets the message
sequence number before enic_admin_channel_open() unmasks the admin
interrupt, so a completion can never arrive before the handler is in
place.

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
 drivers/net/ethernet/cisco/enic/enic_main.c | 94 ++++++++++++++++++++++++++---
 drivers/net/ethernet/cisco/enic/enic_res.c  |  3 +-
 2 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 27b31d5a95dd..537ed5ad7800 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2414,15 +2414,19 @@ static int enic_adjust_resources(struct enic *enic)
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
@@ -3128,6 +3132,42 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
+	 * enic_mbox_init() installs the receive handler and resets the
+	 * sequence number; it must run before enic_admin_channel_open()
+	 * unmasks the admin interrupt so an early completion is not dropped.
+	 */
+	if (enic_is_sriov_vf_v2(enic)) {
+		enic_mbox_init(enic);
+		err = enic_admin_channel_open(enic);
+		if (err) {
+			dev_err(dev,
+				"Failed to open admin channel: %d\n", err);
+			goto err_out_dev_deinit;
+		}
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
 
@@ -3140,7 +3180,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
-	INIT_WORK(&enic->link_notify_work, enic_link_notify_work_handler);
 
 	for (i = 0; i < enic->wq_count; i++)
 		spin_lock_init(&enic->wq[i].lock);
@@ -3153,7 +3192,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = enic_set_mac_addr(netdev, enic->mac_addr);
 	if (err) {
 		dev_err(dev, "Invalid MAC address, aborting\n");
-		goto err_out_dev_deinit;
+		goto err_out_admin_close;
 	}
 
 	enic->tx_coalesce_usecs = enic->config.intr_timer_usec;
@@ -3251,11 +3290,23 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -3293,7 +3344,30 @@ static void enic_remove(struct pci_dev *pdev)
 		disable_work_sync(&enic->reset);
 		disable_work_sync(&enic->tx_hang_reset);
 		disable_work_sync(&enic->change_mtu_work);
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

