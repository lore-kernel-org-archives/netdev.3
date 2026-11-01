Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.37.86.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560050;
	b=MX7pYq5fzph92Eugqk+K8MDJJUDZh45eJwSsLQJfXN/tL/w5Dc4Xq9LyV8iNx9TsqXy5
	 fT/Hd7Kr912+350qtXXPWlLuOHBjcuxyx7cEwE69/93VWSGlHfvjzjHBSnx4xo3Zrm3Yu
	 HZ9IrZ91Uo6r/I8KiDaUgP492v9YrnRr1xo8+cSV/D1nr4/pBAORwAJd1NtRsqHMyNWJY
	 kJshSotio+8Ze8i3BOOV4n4s6dkEYRDK54GGrN0QJ/6Mh/+PBfWQHeIfHQmpX9QFSxMhW
	 rogL4lWIrVceycaQYCuDf2B6FDB6hn3C3Ee3svpWAC9fVPrWJV0P2b6JGJnz0+kPRPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560050;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IPAS-Result:IronPort-Data:IronPort-HdrOrdr:X-Talos-CUID:
	 X-Talos-MUID:X-IronPort-Anti-Spam-Filtered:X-IronPort-AV:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Outbound-Client-TLS:
	 X-Outbound-SMTP-Client:X-Outbound-Node;
	bh=gh6nibI0Gq90XbxJJYpqiqBOL2quiNmHK7TAojYW66M=;
	b=rcHF6ZKl9VK+M45TmMzhfZ1Wq3iX+4Z6IPQ8BXicOenEyHtg4H/5EM6KyybX6uNpFqn6
	 V2PebX1ZlmV/Pok5QeRhcPZz1qrLrml2tcxSJ+V/vQ2Q77Ef8OtniPk2GflBaPFiwIZMZ
	 GdT3xr2gpbR5AmUt5MtmeR+++D8ArHzLV9Hg1fU1dU5xng1h4JpdWaA29i2PHRJNBYozA
	 c1w5LD9jMwL5tCrsmoTbfwvnQLq1JtKuol9hOJXQPVZzLtXxOfqhbl9voz+JpNDP0hyf9
	 dj8LZGP1iC8Ge9vJ5gMRCZ9XnewTFkAjE7a77qTBN5DQvIYxttnEdmCuk1IOm+bwUdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cisco.com;
	spf=pass smtp.mailfrom=cisco.com;
	dkim=pass header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b="de9/H0DG";
	arc=none smtp.remote-ip=173.37.86.72
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E29606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73E29606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport01 header.b=de9/H0DG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=20829; q=dns/txt;
  s=iport01; t=1793560049; x=1794769649;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gh6nibI0Gq90XbxJJYpqiqBOL2quiNmHK7TAojYW66M=;
  b=de9/H0DGrkZ+IT/KQ8ePqpWG0xKCNTHy1wVCcqkQg0BCmCy7BN+mE3W9
   /udYNf28VGHzdlZTD1NW8nNaTeou+lUYqntsRwlp7j8tHypiTmxbpGNb0
   kA+84JuxwlJE2zOklKSlnQ23kD88qXu/IO0nrOtXjv41TAYPE00QI6uuY
   f8lY+M3kJrZSDM2h7fvrf90kVVnRMqv2NAgmm/5Kbgcd7xLG9zmTsu6YG
   0vXkLSn6S+Iyu06yz2Wo5gohUmbvGoJRQMr6RgKd3OyYZvd2BIT7l/aOr
   YBTGbicgIp1xcC9pnzX0tWBGmOLxXprcda6516mt77I6pXdQaga905cP1
   w==;
X-CSE-ConnectionGUID: yqrelebrTceTKA/D2g47Fg==
X-CSE-MsgGUID: 0VD+LsCLTU+xG4Pm29LnCw==
X-IPAS-Result: =?us-ascii?q?A0AcAADUjOdq/5X/Ja1aHAECAgEHARQBBAQBgX0HAQwBg?=
 =?us-ascii?q?laBUQRDSYRXiBuHOIIhkU6MVBSBag8BAQEPUQQBAYUFAo4cAiY0CQ4BAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHBYEOE4ZckBMCAQMjBFIQJQImAgJGE?=
 =?us-ascii?q?BmDAoJ1A7tTen8zgQGEftlLgWgBCxQBgQouAYVxgm0BgXGECIR9JxuBSUSBF?=
 =?us-ascii?q?YNphCqDdYJqBIMcEoJmhUOOYgk/gQIcA1ksAVUTDQoLBwVjgQUDNRIqFW4yH?=
 =?us-ascii?q?YEjPhcvWBsGBYEdgQcEE4EZgQddgSspYAEhgQiBdgKCUYIAAgFJQQ4HRVMJJ?=
 =?us-ascii?q?UMSRyQiCBIJARMaLAuBGjU8CSZBFQxkCAMaBUACIAgCDQx2ORAwICYwBR0mH?=
 =?us-ascii?q?RgNSBEsNxUZBD0BbgeSAYIYBy0kIAENCBcrAQEhCQsTElYEPQgBBiMlFQUFK?=
 =?us-ascii?q?xwpkmODf4wogTZrgTWBGZ5BhCmBZ6AQM5dokwiZCKNzDwkDhTaBaDyBWTMaC?=
 =?us-ascii?q?BsVgyJTGQ+OLhbSOyYyPwcCBw8CkXMEgRpgAQE?=
IronPort-Data: A9a23:HV3FWKuJVIK0LN3j3qJxfmmRLefnVHRfMUV32f8akzHdYApBsoF/q
 tZmKTqPOvyPYDfxc95wYNm+oUwAvJSAyd5mQVY5+SFkRCMRgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrb/656yYsjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZzdJ5xYuajhKsvvb8Us11BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw6/9tDGVD/
 +YkIz0xTTnEq7i5nO2VRbw57igjBJGD0II3oHpsy3TdSP0hW52GGv+M7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtGYH49tL/Aan3XaDREqUmVpqof6GnIxws327/oWDbQUoHWH5oPzxzE/
 woq+UyhPD1ZEMe07Qa4sWKD2tfKx3LfXqkNQejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdx61uniJulgbQdU4O+4n4gilyafO5QudQG8eQVZpYdoqrsIpBjony
 lOEgfvtGDpp9raVIVqF/72ZqzKaIyUZLWYeIyQDSGMt5dT/rIwtpgzAQ8wlE6OviNDxXzbqz
 Fi3QDMWnb4fi4sPkq68512C2mjqrZnSRQlz7QLSNo640j5EiEeeT9TAwTDmATxode51knHpU
 KA4pvWj
IronPort-HdrOrdr: A9a23:5q+OPaCFwzvy5AblHela55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTnEAtjjfZq+z/FICPcqXYtKNTOO0ACVxcNZnOjfKlbbdxEWmNQtsJ
 tIQuxSBML9CF5igd2/wgWpeuxQueWvweSEifjTynF1QRovUaFv6A9lFh2We3cGIjWufaBJc6
 a0145guyeqf2gRY4CQA3kIWPWGmvjw/aiWGSLvw3UcmXOzZfTC0s+ALySl
X-Talos-CUID: 9a23:oO8jfWNhcFKR2u5DSTB9+UoZENoZeXDh716XDxW3VTlHR+jA
X-Talos-MUID: 9a23:jjIiGwranZwc+0Ft+d0ez2lcGIRM+I+KNH1Ogbpag8zeZAh2ECjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,190,1787011200"; 
   d="scan'208";a="542729241"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 01 Nov 2026 19:07:28 +0000
Received: from [127.0.0.1] (unknown [10.25.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-12.cisco.com (Postfix) with ESMTPS id 7E9C81800033D;
	Sun,  1 Nov 2026 19:07:27 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 01 Nov 2026 11:07:23 -0800
Subject: [PATCH net v4 1/2] enic: retain admin-channel DMA until queues
 stop
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v4-1-a7e209210453@cisco.com>
References: <20261101-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v4-0-a7e209210453@cisco.com>
In-Reply-To: <20261101-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v4-0-a7e209210453@cisco.com>
To: netdev@vger.kernel.org
Cc: Sesidhar Baddela <sebaddel@cisco.com>, 
 Aravind Dhanasekaran <aradhana@cisco.com>, 
 Reese Faucette <rfaucett@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793560046; l=21319;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=9V5cOoFvlPGhsx5k8mOtwsolLXcca/UVI4yXy1YaE4c=;
 b=UoVevoNx8a+4kdIxznZryV5uDD2/OZewyGn6+bYBkUaXf9hVSS85DQzM2uvGCQkMng10sveWH
 HoEzAyx6pdOD+Jc6zztZYD8Ek1F6IXQUGoGpDfStiMYouYP5PgJIJAf
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.52];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.52, [10.25.129.52]
X-Outbound-Node: rcdn-l-core-12.cisco.com

Admin close and the partial-open unwind currently free the admin
WQ/RQ/CQ allocation even when disabling one of the queues times out. A
posted WQ message or an RQ buffer can then remain reachable by the
device after its mapping and allocation have been released.

Track the channel as DOWN, LIVE or QUARANTINED. Stop its IRQ and work,
block new sends and join an in-flight sender before queue shutdown. Give
both queues a first disable attempt, then retry only a complete helper
that timed out. Poll for up to 500 ms per pass locally to the admin
path, preserving the RQ's two disable/check passes. Ordinary datapath
and DEVCMD2 queue timeouts are unchanged.

RUNNING == 0 proves that queue DMA has stopped. A nonzero value leaves
ownership unresolved; it does not establish that DMA is active. Release
the admin graph only when both complete disable helpers succeed. Retain
the graph otherwise and refuse to reopen it. Keep bus mastering enabled
at runtime so command transport and ordinary teardown can continue. A V2
VF with a quarantined control channel is closed and cannot reopen. Reset
callers must not reset or reopen a retained admin graph, or reopen admin
queues after a failed datapath open. Clear local VF registration after
draining channel replies, including when recovery exits early. Clear it
again after a failed re-registration closes the channel because a late
REGISTER_REPLY may have set it before the WQ completion timed out.

Check that an internal datapath open still has a present device. Recheck
the running state under RTNL in reset workers. During removal, detach the
netdev under RTNL and then release RTNL before the VF unregister handshake
and admin close. The detach and present-device checks exclude a concurrent
new open without holding the global lock across protocol and queue waits.

Removal makes a final direct admin queue check. If that still fails,
finish ordinary generic teardown and attempt CMD_CLOSE before clearing
bus mastering and disabling the PCI function. Keep the inert netdev,
vnic_dev, admin allocations and control targets rather than freeing
device-owned memory. Admin buffers use driver-owned mappings, never page
pools or pages returned later from sockets. This patch does not repair
the separate generic datapath queue-disable error path.

Keep the BAR reservation to block an ordinary rebind while the PCI
device remains enumerated. Use the PCI device name for the reservation
and hold a PCI-device reference so the owner-name pointer remains valid
after module unload. That reference does not preserve the IOMMU
attachment or prove DMA stopped. No IRQ, work or other CPU callback may
use the retained objects. DMA debugging can report the deliberately
pending allocations; reboot is the supported terminal recovery.

Fixes: 3258931d4052 ("enic: add admin channel open and close for SR-IOV")
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |  17 ++-
 drivers/net/ethernet/cisco/enic/enic_admin.c | 196 +++++++++++++++++++++------
 drivers/net/ethernet/cisco/enic/enic_admin.h |   4 +-
 drivers/net/ethernet/cisco/enic/enic_main.c  |  88 +++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.c  |   1 +
 5 files changed, 252 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 7a509a056990..35127c549e64 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -238,6 +238,12 @@ enum enic_vf_type {
 	ENIC_VF_TYPE_V2,
 };
 
+enum enic_admin_chan_state {
+	ENIC_ADMIN_CHAN_DOWN,
+	ENIC_ADMIN_CHAN_LIVE,
+	ENIC_ADMIN_CHAN_QUARANTINED,
+};
+
 /* Per-instance private data structure */
 struct enic {
 	struct net_device *netdev;
@@ -298,13 +304,12 @@ struct enic {
 
 	/* Admin channel resources for SR-IOV MBOX */
 	bool has_admin_channel;
-	/* true only while the admin WQ/RQ/CQ are allocated and enabled; gates
-	 * enic_admin_channel_close() so it is a no-op after a failed (re)open
-	 * left the resources freed.
-	 */
-	bool admin_chan_up;
-	/* set on send timeout; cleared on channel re-open */
+	/* QUARANTINED retains admin DMA until the final remove-time recheck. */
+	enum enic_admin_chan_state admin_chan_state;
+	/* Blocks sends throughout close, partial open and timeout recovery. */
 	bool mbox_send_disabled;
+	/* A send timed out or channel shutdown left queue ownership unresolved. */
+	bool mbox_tx_poisoned;
 	struct vnic_wq admin_wq;
 	struct vnic_rq admin_rq;
 	struct vnic_cq admin_cq[2];
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 61c82b48044d..4325c6d9c30e 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -5,6 +5,7 @@
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -530,11 +531,22 @@ static void enic_admin_msg_drain(struct enic *enic)
 
 int enic_admin_channel_open(struct enic *enic)
 {
+	int close_err;
 	int err;
 
 	if (!enic->has_admin_channel)
 		return -ENODEV;
-
+	if (READ_ONCE(enic->admin_chan_state) != ENIC_ADMIN_CHAN_DOWN) {
+		netdev_err(enic->netdev,
+			   "Refusing to open non-down admin channel (%u)\n",
+			   READ_ONCE(enic->admin_chan_state));
+		return -EBUSY;
+	}
+	if (READ_ONCE(enic->mbox_tx_poisoned)) {
+		netdev_err(enic->netdev,
+			   "Refusing to reopen poisoned admin channel\n");
+		return -EIO;
+	}
 	/* Keep MBOX sends disabled for the entire open sequence.  It is
 	 * cleared only after every resource is allocated and enabled below,
 	 * so any early error return here leaves sends disabled and a
@@ -567,6 +579,7 @@ int enic_admin_channel_open(struct enic *enic)
 
 	vnic_wq_enable(&enic->admin_wq);
 	vnic_rq_enable(&enic->admin_rq);
+	WRITE_ONCE(enic->admin_chan_state, ENIC_ADMIN_CHAN_LIVE);
 
 	err = enic_admin_rq_fill(enic, GFP_KERNEL);
 	if (err) {
@@ -600,60 +613,51 @@ int enic_admin_channel_open(struct enic *enic)
 		   enic->admin_cq[0].last_color,
 		   enic->admin_cq[1].last_color);
 
-	enic->admin_chan_up = true;
-
 	return 0;
 
 disable_queues:
-	enic_admin_teardown_intr(enic);
-	enic_admin_qp_type_set(enic, QP_DISABLE);
-	if (vnic_wq_disable(&enic->admin_wq))
-		netdev_warn(enic->netdev, "Failed to disable admin WQ\n");
-	if (vnic_rq_disable(&enic->admin_rq))
-		netdev_warn(enic->netdev, "Failed to disable admin RQ\n");
-	cancel_work_sync(&enic->admin_msg_work);
-	enic_admin_msg_drain(enic);
-	enic_admin_rq_drain(enic);
+	close_err = enic_admin_channel_close(enic);
+	if (close_err)
+		netdev_err(enic->netdev,
+			   "Failed to close partial admin channel: %d\n",
+			   close_err);
+	return err;
 free_resources:
 	enic_admin_free_resources(enic);
 	return err;
 }
 
-void enic_admin_channel_close(struct enic *enic)
+static int enic_admin_wq_disable(struct enic *enic)
 {
-	int err;
-
-	if (!enic->has_admin_channel)
-		return;
-
-	/* Nothing to tear down if the channel was never (re)opened, e.g. a
-	 * failed enic_admin_channel_open() in probe or in the reset path;
-	 * otherwise the disable/clean calls below dereference freed resources.
-	 */
-	if (!enic->admin_chan_up)
-		return;
-
-	WRITE_ONCE(enic->mbox_send_disabled, true);
+	struct vnic_wq *wq = &enic->admin_wq;
+	u32 running;
 
-	netdev_dbg(enic->netdev, "admin channel close\n");
+	iowrite32(0, &wq->ctrl->enable);
+	return read_poll_timeout(ioread32, running, !running, 10, 500000,
+				 false, &wq->ctrl->running);
+}
 
-	vnic_intr_mask(&enic->admin_intr);
-	enic_admin_teardown_intr(enic);
-	cancel_work_sync(&enic->link_notify_work);
-	cancel_work_sync(&enic->admin_msg_work);
-	enic_admin_msg_drain(enic);
+static int enic_admin_rq_disable(struct enic *enic)
+{
+	struct vnic_rq *rq = &enic->admin_rq;
+	u32 running;
+	int err;
+	int i;
 
-	enic_admin_qp_type_set(enic, QP_DISABLE);
+	/* Preserve the two disable/check passes used for the RQ mini-cache. */
+	for (i = 0; i < 2; i++) {
+		iowrite32(0, &rq->ctrl->enable);
+		err = read_poll_timeout(ioread32, running, !running, 10, 500000,
+					false, &rq->ctrl->running);
+		if (err)
+			return err;
+	}
 
-	err = vnic_wq_disable(&enic->admin_wq);
-	if (err)
-		netdev_warn(enic->netdev,
-			    "Failed to disable admin WQ: %d\n", err);
-	err = vnic_rq_disable(&enic->admin_rq);
-	if (err)
-		netdev_warn(enic->netdev,
-			    "Failed to disable admin RQ: %d\n", err);
+	return 0;
+}
 
+static void enic_admin_channel_release(struct enic *enic)
+{
 	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
 	enic_admin_rq_drain(enic);
 	vnic_cq_clean(&enic->admin_cq[0]);
@@ -662,6 +666,114 @@ void enic_admin_channel_close(struct enic *enic)
 
 	enic->admin_rq_handler = NULL;
 	enic_admin_free_resources(enic);
+	WRITE_ONCE(enic->admin_chan_state, ENIC_ADMIN_CHAN_DOWN);
+}
+
+int enic_admin_channel_close(struct enic *enic)
+{
+	int qp_err;
+	int rq_err;
+	int wq_err;
+
+	if (!enic->has_admin_channel)
+		return 0;
+	if (READ_ONCE(enic->admin_chan_state) == ENIC_ADMIN_CHAN_DOWN)
+		return 0;
+	if (READ_ONCE(enic->admin_chan_state) == ENIC_ADMIN_CHAN_QUARANTINED)
+		return -EBUSY;
+
+	WRITE_ONCE(enic->mbox_send_disabled, true);
+
+	if (READ_ONCE(enic->admin_chan_state) == ENIC_ADMIN_CHAN_LIVE) {
+		netdev_dbg(enic->netdev, "admin channel quiesce\n");
+
+		vnic_intr_mask(&enic->admin_intr);
+		enic_admin_teardown_intr(enic);
+		cancel_work_sync(&enic->link_notify_work);
+		cancel_work_sync(&enic->admin_msg_work);
+		enic_admin_msg_drain(enic);
+	}
+
+	/* A sender may have passed the gate before it was raised.  Wait only
+	 * after cancelling workers which can themselves wait for mbox_lock.
+	 */
+	mutex_lock(&enic->mbox_lock);
+	qp_err = enic_admin_qp_type_set(enic, QP_DISABLE);
+	if (qp_err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin QP type: %d\n", qp_err);
+
+	wq_err = enic_admin_wq_disable(enic);
+	rq_err = enic_admin_rq_disable(enic);
+
+	/* Run both complete disable helpers once before retrying only a helper
+	 * which timed out.
+	 */
+	if (wq_err == -ETIMEDOUT)
+		wq_err = enic_admin_wq_disable(enic);
+	if (rq_err == -ETIMEDOUT)
+		rq_err = enic_admin_rq_disable(enic);
 
-	enic->admin_chan_up = false;
+	if (wq_err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin WQ after retry: %d\n",
+			    wq_err);
+	if (rq_err)
+		netdev_warn(enic->netdev,
+			    "Failed to disable admin RQ after retry: %d\n",
+			    rq_err);
+
+	/* QP_DISABLE does not report every low-level stop failure.  The direct
+	 * WQ/RQ RUNNING observations own the admin allocation graph.
+	 */
+	if (wq_err || rq_err) {
+		WRITE_ONCE(enic->admin_chan_state, ENIC_ADMIN_CHAN_QUARANTINED);
+		WRITE_ONCE(enic->mbox_tx_poisoned, true);
+		mutex_unlock(&enic->mbox_lock);
+		/* Retained targets remain valid for late DMA. Keep bus mastering
+		 * enabled for the independent datapath and command transport.
+		 */
+		return wq_err ?: rq_err;
+	}
+
+	enic_admin_channel_release(enic);
+	WRITE_ONCE(enic->mbox_tx_poisoned, false);
+	mutex_unlock(&enic->mbox_lock);
+
+	/* Firmware rejection does not undermine the WQ/RQ proof. */
+	return qp_err;
+}
+
+int enic_admin_channel_recheck_on_remove(struct enic *enic)
+{
+	int rq_err;
+	int wq_err;
+
+	if (READ_ONCE(enic->admin_chan_state) != ENIC_ADMIN_CHAN_QUARANTINED)
+		return 0;
+
+	/* Channel close already detached every CPU entry point and attempted
+	 * QP_DISABLE.  Removal is the last direct check of queue ownership.
+	 */
+	mutex_lock(&enic->mbox_lock);
+	wq_err = enic_admin_wq_disable(enic);
+	rq_err = enic_admin_rq_disable(enic);
+	if (wq_err || rq_err) {
+		mutex_unlock(&enic->mbox_lock);
+		return wq_err ?: rq_err;
+	}
+
+	enic_admin_channel_release(enic);
+	WRITE_ONCE(enic->mbox_tx_poisoned, false);
+	mutex_unlock(&enic->mbox_lock);
+	netdev_info(enic->netdev,
+		    "Admin queues stopped at remove; releasing DMA graph\n");
+
+	return 0;
+}
+
+bool enic_admin_channel_is_quarantined(const struct enic *enic)
+{
+	return READ_ONCE(enic->admin_chan_state) ==
+		ENIC_ADMIN_CHAN_QUARANTINED;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.h b/drivers/net/ethernet/cisco/enic/enic_admin.h
index 62c80220b0ca..5945bbb2e6d4 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.h
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.h
@@ -20,7 +20,9 @@ struct enic_admin_msg {
 };
 
 int enic_admin_channel_open(struct enic *enic);
-void enic_admin_channel_close(struct enic *enic);
+int enic_admin_channel_close(struct enic *enic);
+int enic_admin_channel_recheck_on_remove(struct enic *enic);
+bool enic_admin_channel_is_quarantined(const struct enic *enic);
 unsigned int enic_admin_wq_cq_service(struct enic *enic);
 unsigned int enic_admin_rq_cq_service(struct enic *enic);
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 6b5824f45a14..04e4248d4872 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1736,6 +1736,13 @@ static int enic_open(struct net_device *netdev)
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 	};
 
+	/* Internal reopen paths also bypass the networking core's presence check. */
+	if (!netif_device_present(netdev))
+		return -ENODEV;
+	if (enic_is_sriov_vf_v2(enic) &&
+	    enic_admin_channel_is_quarantined(enic))
+		return -EBUSY;
+
 	err = enic_request_intr(enic);
 	if (err) {
 		netdev_err(netdev, "Unable to request irq.\n");
@@ -2206,6 +2213,9 @@ static void enic_admin_chan_reopen(struct enic *enic)
 {
 	int err;
 
+	if (enic_admin_channel_is_quarantined(enic))
+		return;
+
 	/* Install the MBOX receive handler and clear pending reply state before
 	 * opening the channel, so the handler is in place before the admin
 	 * interrupt is unmasked and no early completion is dropped.  Keep the
@@ -2237,6 +2247,7 @@ static void enic_admin_chan_reopen(struct enic *enic)
 				   "MBOX capability check after reset failed: %d\n",
 				   err);
 			enic_admin_channel_close(enic);
+			WRITE_ONCE(enic->vf_registered, false);
 			return;
 		}
 		err = enic_mbox_vf_register(enic);
@@ -2245,6 +2256,7 @@ static void enic_admin_chan_reopen(struct enic *enic)
 				   "MBOX VF re-registration after reset failed: %d\n",
 				   err);
 			enic_admin_channel_close(enic);
+			WRITE_ONCE(enic->vf_registered, false);
 		}
 	} else {
 		/* The link came back up during enic_open() above while MBOX
@@ -2264,6 +2276,9 @@ static void enic_reset(struct work_struct *work)
 
 	rtnl_lock();
 
+	if (!netif_running(enic->netdev))
+		goto unlock;
+
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
@@ -2273,8 +2288,17 @@ static void enic_reset(struct work_struct *work)
 	 * DMAs from the about-to-be-reset rings) and frees the admin resources
 	 * so they are cleanly re-allocated afterwards.
 	 */
-	if (enic_has_admin_chan(enic))
+	if (enic_has_admin_chan(enic)) {
 		enic_admin_channel_close(enic);
+		/* Channel close has drained registration replies. */
+		if (enic_is_sriov_vf_v2(enic))
+			WRITE_ONCE(enic->vf_registered, false);
+	}
+	if (enic_admin_channel_is_quarantined(enic)) {
+		/* Core close excludes netpoll and clears __LINK_STATE_START first. */
+		dev_close(enic->netdev);
+		goto reset_out;
+	}
 
 	enic_stop(enic->netdev);
 	if (enic_is_sriov_vf_v2(enic))
@@ -2287,7 +2311,8 @@ static void enic_reset(struct work_struct *work)
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
 
-	enic_open(enic->netdev);
+	if (enic_open(enic->netdev))
+		goto reset_out;
 
 	/* Re-establish the admin/MBOX channel after the data path is back up.
 	 * It was fully torn down by enic_admin_channel_close() above;
@@ -2296,12 +2321,17 @@ static void enic_reset(struct work_struct *work)
 	 */
 	if (enic_has_admin_chan(enic))
 		enic_admin_chan_reopen(enic);
+	if (enic_is_sriov_vf_v2(enic) &&
+	    enic_admin_channel_is_quarantined(enic))
+		dev_close(enic->netdev);
 
+reset_out:
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
 	call_netdevice_notifiers(NETDEV_REBOOT, enic->netdev);
 
+unlock:
 	rtnl_unlock();
 }
 
@@ -2311,6 +2341,9 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
 	rtnl_lock();
 
+	if (!netif_running(enic->netdev))
+		goto unlock;
+
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
@@ -2318,8 +2351,16 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	 * the same reason as the soft reset path: stop the admin QP and free
 	 * the admin resources before the hardware queues are wiped.
 	 */
-	if (enic_has_admin_chan(enic))
+	if (enic_has_admin_chan(enic)) {
 		enic_admin_channel_close(enic);
+		/* Channel close has drained registration replies. */
+		if (enic_is_sriov_vf_v2(enic))
+			WRITE_ONCE(enic->vf_registered, false);
+	}
+	if (enic_admin_channel_is_quarantined(enic)) {
+		dev_close(enic->netdev);
+		goto reset_out;
+	}
 
 	enic_dev_hang_notify(enic);
 	enic_stop(enic->netdev);
@@ -2333,7 +2374,8 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
 
-	enic_open(enic->netdev);
+	if (enic_open(enic->netdev))
+		goto reset_out;
 
 	/* Re-establish the admin/MBOX channel after the data path is back up.
 	 * It was fully torn down by enic_admin_channel_close() above;
@@ -2342,12 +2384,17 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	 */
 	if (enic_has_admin_chan(enic))
 		enic_admin_chan_reopen(enic);
+	if (enic_is_sriov_vf_v2(enic) &&
+	    enic_admin_channel_is_quarantined(enic))
+		dev_close(enic->netdev);
 
+reset_out:
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
 	call_netdevice_notifiers(NETDEV_REBOOT, enic->netdev);
 
+unlock:
 	rtnl_unlock();
 }
 
@@ -3036,7 +3083,8 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_free_netdev;
 	}
 
-	err = pci_request_regions(pdev, DRV_NAME);
+	/* A terminal admin allocation keeps the reservation after module unload. */
+	err = pci_request_regions(pdev, dev_name(dev));
 	if (err) {
 		dev_err(dev, "Cannot request PCI regions, aborting\n");
 		goto err_out_disable_device;
@@ -3374,6 +3422,17 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 #endif
 err_out_vnic_unregister:
+	if (enic_admin_channel_is_quarantined(enic)) {
+		/* Normal generic cleanup and CMD_CLOSE have already run. Retain
+		 * only the inert admin/control owners and their PCI reservation.
+		 */
+		pci_dev_get(pdev);
+		pci_clear_master(pdev);
+		pci_disable_device(pdev);
+		pci_set_drvdata(pdev, NULL);
+		dev_err(dev, "Control DMA unresolved; retaining resources until reboot\n");
+		return err;
+	}
 	vnic_dev_unregister(enic->vdev);
 err_out_iounmap:
 	enic_iounmap(enic);
@@ -3397,6 +3456,9 @@ static void enic_remove(struct pci_dev *pdev)
 		disable_work_sync(&enic->reset);
 		disable_work_sync(&enic->tx_hang_reset);
 		disable_work_sync(&enic->change_mtu_work);
+		rtnl_lock();
+		netif_device_detach(netdev);
+		rtnl_unlock();
 
 		/* Close the admin channel and unregister from the PF before
 		 * unregister_netdev() to prevent a late PF notification from
@@ -3429,9 +3491,25 @@ static void enic_remove(struct pci_dev *pdev)
 				pci_disable_sriov(pdev);
 		}
 #endif
+		if (enic_admin_channel_is_quarantined(enic))
+			enic_admin_channel_recheck_on_remove(enic);
 		enic_dev_deinit(enic);
 		vnic_dev_close(enic->vdev);
 		kfree(enic->pp);
+		if (enic_admin_channel_is_quarantined(enic)) {
+			/* All generic queues and CPU entry points followed ordinary
+			 * teardown. No admin buffer can return from the network stack.
+			 * Pin the PCI object for the reservation's owner-name pointer;
+			 * this reference does not fence DMA or preserve IOMMU state.
+			 */
+			pci_dev_get(pdev);
+			pci_clear_master(pdev);
+			pci_disable_device(pdev);
+			pci_set_drvdata(pdev, NULL);
+			dev_err(&pdev->dev,
+				"Control DMA unresolved; retaining resources until reboot\n");
+			return;
+		}
 		vnic_dev_unregister(enic->vdev);
 		enic_iounmap(enic);
 		pci_release_regions(pdev);
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 5c93ca49552a..e106ee7d411d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -150,6 +150,7 @@ static int enic_mbox_send_msg_id(struct enic *enic, u8 msg_type,
 		 * Mark the channel unusable so no further sends are attempted.
 		 */
 		WRITE_ONCE(enic->mbox_send_disabled, true);
+		WRITE_ONCE(enic->mbox_tx_poisoned, true);
 	}
 
 	netdev_dbg(enic->netdev,

-- 
2.43.0

