Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9137FF62;
	Sun, 19 Jul 2026 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450727; cv=none; b=n9aNDFO7JnFuOa2iEkMD7b/huQcxC6MemjvfgwIm8hyGhZKodGvXpk6hwGJgwXoYPvo1Kr8XtLXpt2mZdM5hDV+CIqA4bT0XgWLhEEkg7/3o2n2Fxihbdfxqjuk9pUihG2YodeLl4t3ECcpkQACnXYAtcB2pEf1MqkT9E3uRlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450727; c=relaxed/simple;
	bh=l+MNFaxJJCGeJOFAoZUQpeH9erfLp/sDcUqUDHy6R10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kZ3+pdoAvE6+/N7QpOqjDJ/56EmecsgqIFU4xL6kqEl2ERTaNZeczMk6B7Dncf7KH3/JlsJS64+vLyVcHOVDlxvWAYasXcCPIxE+bPBxXumY/Gy0SyNJhABFZ9Aw6DGZb57kz7r8tcUsT2HPqM02F+SqT4X85Ll7L+lVSFEJv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Sv+ChjPf; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="Sv+ChjPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11953; q=dns/txt;
  s=iport01; t=1784450721; x=1785660321;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=t+rBiyTTK+1KBTgzqcDhjSivs5NNiPe+BvzYr1LOUY4=;
  b=Sv+ChjPfi9ZMdlTY4azkMfdGDDL9hPMieAWnbAFEJx+wk8z25y4MQ8Mj
   vIWOHzr3CVfjDyqWmmjlYohLcOjc2NsNtqQgDTqQR1lSj0MNIwJLjQoXI
   wrUZ40EAU5riGtahqiuq8UnYL3Tj816cQb5md0MxRoenGg63ZINY5g/Me
   G/tWcaveZVPgJWnW8Rj7tKE4SdvaxxlUwhOYdnN/stzcAPDQaeZfjN4cA
   9WYcaDsx6fvGLkgXMHMOl4WOVuwThuqxZn7ffXGLqwn1k4YkNwFoIcktt
   7oaGvqj2GLkPO35hKbG7nJU/56yAPZHZEHBmiare4AwqhJu54fYbFNU6+
   A==;
X-CSE-ConnectionGUID: FUqKGzTOQQy+R3ukLmXaLw==
X-CSE-MsgGUID: kb0sv3U2QI+euu0lWD2z9w==
X-IPAS-Result: =?us-ascii?q?A0BHAgAEjVxq/5H/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?oIhkU2MURSBag8BAQEPUQQBAYUFAo1TAiY0CQ4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQUBAQECAQcFgQ4ThlyGWwIBAyMECwE0EhAlAiYCAkYQBgESgwKCdQO9C?=
 =?us-ascii?q?3p/M4EB3kWBZgELFAGBCi6FcYJrAYFwhAc7g0Z7JxuBSUSBFYJYgRGEBQUVg?=
 =?us-ascii?q?3+CagSCInoSgVuDdYwcCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQvD?=
 =?us-ascii?q?wQWMh1wDBAXEiwXNFgbBwWBHX8WBCGBAoR2Ix8DOX+BMHVKdy1pARIXgS+CF?=
 =?us-ascii?q?IE6AgcDCxgNSBEsNwYOGQQ9AW4HjUAjgU5qBxZ5TC8ELUwbFQUwLJJ8QoM8j?=
 =?us-ascii?q?kqBNZ9ahCeBZqAPATKEBJNjNJJRmQgjgjahKAlQhGmBaDyBWTMaCBsVgyJTG?=
 =?us-ascii?q?Q+OLRYc0h4nMj0CBwIHDgMLkWgRF4FWAQE?=
IronPort-Data: A9a23:00BR/6Dn3nrkDhVW//Tiw5YqxClBgxIJ4kV8jS/XYbTApDwi1z0Oy
 2QbCGjXOKvYYTejeYp/boSx8UJXvseDnNYwOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYAD8imYtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE7ch3L24kAaohw/c0OzpT9
 tgdGDkpcUXW7w626OrTpuhEnM8vKozveYgYoHwllWGfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYyBPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FEoiuC3bYuIJ7RmQ+1WlB6Du
 Dn7pV3YQRwHKYSb9hbf4COz07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc9ZSK
 lAd/QIioKIz/UrtScPyNzW1rGOBtwwRR/JfFOo17AzLwa3Riy6aG2INZj1MctorsIkxXzNC/
 laPk8nkGn9pvaGZRGy18qqSq3W5OUA9NWYIaCkFZREI79nqvMc4iRenZtJiFrOly974Azf9x
 xiUoyUkwbYel8gG0+O851+vqzShupTEUCYr6QjNGGGo9AV0YMiifYPA1LTAxexLIIDcShyKu
 2IJ3pDOqusPFpqK0ieKRY3hAY2U2hpMCxWE6XYHInXr323FF6KLFWyI3AxDGQ==
IronPort-HdrOrdr: A9a23:qZm8jaxwFvnP3U9XG6AsKrPw2r1zdoMgy1knxilNoNJuA6ilfq
 eV/cjztCWbtN9/YhwdcLy7UpVoBEmsl6KdgrN/AV7dZmnbUQKTRekI0WKh+UyCJ8SUzIJgPM
 lbAs1DIey1IFRkgcP9+QWiV/Qt0LC8gdmVrNab4ntzQQRtcq16qz14BAGSD1FsSGB9dPwE/e
 Knl616jgvlX2gLZcKmAXRAde3Cq9rX0K/CW3c9dmYaAM3kt0LT1FY8eCLopSsjbw==
X-Talos-CUID: =?us-ascii?q?9a23=3ADRtDcWjpOqdn+J0+FlprMK+iqjJuXEDE71jCH2i?=
 =?us-ascii?q?BMHcqcuaISnuVyKpAjJ87?=
X-Talos-MUID: 9a23:YWVhaAg6Gi9dhNHqv2kEcsMpN80w+Lr1NRo0sNYLptTcMRNcYSXMk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="512025955"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:12 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id D1F4518000475;
	Sun, 19 Jul 2026 08:42:10 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 19 Jul 2026 01:41:53 -0700
Subject: [PATCH net-next v12 09/12] enic: add MBOX VF handlers for
 capability, register and link state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-9-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=12397;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=l+MNFaxJJCGeJOFAoZUQpeH9erfLp/sDcUqUDHy6R10=;
 b=TGQRHdIkkLui2rcW1o+l9LGzgNvdI/MnMWnyhiDV6mBLDQZDeEK4D+vGmHfvhkmQbork7EXiC
 4uaNTamu17CCyzYjJzOIQewZQiDhCdt5SvojuWMsLqXwHNkLdI5Uwnb
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

Implement VF-side mailbox message processing for SR-IOV V2
admin channel communication.

VF receive handlers:
  - VF_CAPABILITY_REPLY: store PF protocol version, signal
    completion
  - VF_REGISTER_REPLY: mark VF as registered, signal completion
  - VF_UNREGISTER_REPLY: mark VF as unregistered, signal
    completion
  - PF_LINK_STATE_NOTIF: update carrier state via
    netif_carrier_on/off, send ACK back to PF

VF initiation functions for the probe-time handshake:
  - enic_mbox_vf_capability_check: send capability request,
    wait for PF reply via completion
  - enic_mbox_vf_register: send register request, wait for
    PF confirmation via completion
  - enic_mbox_vf_unregister: send unregister request, wait
    for PF confirmation

The wait helper (enic_mbox_wait_reply) uses
wait_for_completion_timeout, signaled when the admin ISR and
CQ-poll/dispatch workqueue pipeline delivers the reply message.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  11 ++
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 277 +++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h |   3 +
 3 files changed, 290 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index d459318c46fc..a9a376d2cf0e 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -258,6 +258,8 @@ struct enic {
 	u32 tx_coalesce_usecs;
 	u16 num_vfs;
 	enum enic_vf_type vf_type;
+	bool vf_registered;
+	u32 pf_cap_version;
 	unsigned int enable_count;
 	spinlock_t enic_api_lock;
 	bool enic_api_busy;
@@ -313,6 +315,15 @@ struct enic {
 	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
 	struct mutex mbox_lock;
 	u64 mbox_msg_num;
+	/* MBOX request-reply state.  Written by the process-context request
+	 * helpers (capability/register/unregister) and read/cleared by the
+	 * admin_msg_work receive handlers.  No explicit lock is needed because
+	 * only one request is in flight at a time: requesters run under RTNL or
+	 * single-threaded probe/remove, so each request is serialized and its
+	 * reply completes mbox_comp before the next request is issued.
+	 */
+	struct completion mbox_comp;
+	u8 mbox_expected_reply;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
 	struct enic_vf_state {
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index b6f05b03ae26..701972f90627 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -5,6 +5,7 @@
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/completion.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -135,6 +136,16 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 	return err;
 }
 
+static int enic_mbox_wait_reply(struct enic *enic, unsigned long timeout_ms)
+{
+	unsigned long left;
+
+	left = wait_for_completion_timeout(&enic->mbox_comp,
+					   msecs_to_jiffies(timeout_ms));
+
+	return left ? 0 : -ETIMEDOUT;
+}
+
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
 {
 	struct enic_mbox_pf_link_state_notif_msg notif = {};
@@ -306,6 +317,166 @@ static void enic_mbox_pf_process_msg(struct enic *enic,
 			    hdr->msg_type, vf_id, err);
 }
 
+static void enic_mbox_vf_handle_capability_reply(struct enic *enic,
+						 void *payload)
+{
+	struct enic_mbox_vf_capability_reply_msg *reply = payload;
+
+	if (enic->mbox_expected_reply != ENIC_MBOX_VF_CAPABILITY_REPLY) {
+		netdev_warn(enic->netdev,
+			    "MBOX: stale capability reply (expected %u), drop\n",
+			    enic->mbox_expected_reply);
+		return;
+	}
+
+	if (le16_to_cpu(reply->reply.ret_major) == 0)
+		enic->pf_cap_version = le32_to_cpu(reply->version);
+	else
+		netdev_warn(enic->netdev,
+			    "MBOX: PF rejected capability request: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_register_reply(struct enic *enic,
+					       void *payload)
+{
+	struct enic_mbox_vf_register_reply_msg *reply = payload;
+
+	if (enic->mbox_expected_reply != ENIC_MBOX_VF_REGISTER_REPLY) {
+		netdev_warn(enic->netdev,
+			    "MBOX: stale register reply (expected %u), drop\n",
+			    enic->mbox_expected_reply);
+		return;
+	}
+
+	if (le16_to_cpu(reply->reply.ret_major)) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF register rejected by PF: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	} else {
+		enic->vf_registered = true;
+	}
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_unregister_reply(struct enic *enic,
+						 void *payload)
+{
+	struct enic_mbox_vf_register_reply_msg *reply = payload;
+
+	if (enic->mbox_expected_reply != ENIC_MBOX_VF_UNREGISTER_REPLY) {
+		netdev_warn(enic->netdev,
+			    "MBOX: stale unregister reply (expected %u), drop\n",
+			    enic->mbox_expected_reply);
+		return;
+	}
+
+	if (le16_to_cpu(reply->reply.ret_major)) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF unregister rejected by PF: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	} else {
+		enic->vf_registered = false;
+	}
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload)
+{
+	struct enic_mbox_pf_link_state_notif_msg *notif = payload;
+	struct enic_mbox_pf_link_state_ack_msg ack = {};
+	int err;
+
+	switch (le32_to_cpu(notif->link_state)) {
+	case ENIC_MBOX_LINK_STATE_ENABLE:
+		if (!netif_carrier_ok(enic->netdev))
+			netif_carrier_on(enic->netdev);
+		netdev_dbg(enic->netdev, "MBOX: link state -> UP\n");
+		break;
+	case ENIC_MBOX_LINK_STATE_DISABLE:
+		if (netif_carrier_ok(enic->netdev))
+			netif_carrier_off(enic->netdev);
+		netdev_dbg(enic->netdev, "MBOX: link state -> DOWN\n");
+		break;
+	default:
+		netdev_warn(enic->netdev, "MBOX: unknown link state %u\n",
+			    le32_to_cpu(notif->link_state));
+		ack.ack.ret_major = cpu_to_le16(ENIC_MBOX_ERR_GENERIC);
+		break;
+	}
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_ACK,
+				 ENIC_MBOX_DST_PF, &ack, sizeof(ack));
+	if (err && net_ratelimit())
+		netdev_warn(enic->netdev,
+			    "MBOX: failed to send link state ACK: %d\n", err);
+}
+
+static bool enic_mbox_vf_payload_ok(struct enic *enic, u8 msg_type,
+				    u16 payload_len, size_t min_len)
+{
+	if (payload_len < min_len) {
+		netdev_warn(enic->netdev,
+			    "MBOX: short payload for type %u (%u < %zu)\n",
+			    msg_type, payload_len, min_len);
+		return false;
+	}
+	return true;
+}
+
+static void enic_mbox_vf_process_msg(struct enic *enic,
+				     struct enic_mbox_hdr *hdr, void *payload,
+				     u16 payload_len)
+{
+	switch (hdr->msg_type) {
+	case ENIC_MBOX_VF_CAPABILITY_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_capability_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_capability_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_VF_REGISTER_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_register_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_VF_UNREGISTER_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_unregister_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_PF_LINK_STATE_NOTIF: {
+		size_t exp = sizeof(struct enic_mbox_pf_link_state_notif_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_link_state(enic, payload);
+		break;
+	}
+	default:
+		netdev_dbg(enic->netdev,
+			   "MBOX: VF unhandled msg type %u\n",
+			   hdr->msg_type);
+		break;
+	}
+}
+
 static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 				   unsigned int len)
 {
@@ -344,13 +515,117 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 
 	payload = buf + sizeof(*hdr);
 
-	if (enic->vf_state)
+	if (enic->vf_state) {
 		enic_mbox_pf_process_msg(enic, hdr, payload);
+	} else if (le16_to_cpu(hdr->src_vnic_id) == ENIC_MBOX_DST_PF) {
+		/* src_vnic_id was overwritten from the hardware-verified CQ
+		 * VLAN sender field, so a VF only accepts messages that the
+		 * adapter attributes to the PF.  Its sole admin-channel peer is
+		 * the PF; drop anything else as a spoofed notification.
+		 */
+		enic_mbox_vf_process_msg(enic, hdr, payload,
+					 msg_len - (u16)sizeof(*hdr));
+	} else if (net_ratelimit()) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF dropping non-PF message from vnic %u\n",
+			    le16_to_cpu(hdr->src_vnic_id));
+	}
+}
+
+int enic_mbox_vf_capability_check(struct enic *enic)
+{
+	struct enic_mbox_vf_capability_msg req = {};
+	int err;
+
+	enic->pf_cap_version = 0;
+	reinit_completion(&enic->mbox_comp);
+	enic->mbox_expected_reply = ENIC_MBOX_VF_CAPABILITY_REPLY;
+	req.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REQUEST,
+				 ENIC_MBOX_DST_PF, &req, sizeof(req));
+	if (err) {
+		enic->mbox_expected_reply = 0;
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	enic->mbox_expected_reply = 0;
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "MBOX: no capability reply from PF\n");
+		return err;
+	}
+
+	if (enic->pf_cap_version < ENIC_MBOX_CAP_VERSION_1) {
+		netdev_warn(enic->netdev,
+			    "MBOX: PF rejected capability request or reported unsupported version %u\n",
+			    enic->pf_cap_version);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int enic_mbox_vf_register(struct enic *enic)
+{
+	int err;
+
+	enic->vf_registered = false;
+	reinit_completion(&enic->mbox_comp);
+	enic->mbox_expected_reply = ENIC_MBOX_VF_REGISTER_REPLY;
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REQUEST,
+				 ENIC_MBOX_DST_PF, NULL, 0);
+	if (err) {
+		enic->mbox_expected_reply = 0;
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	enic->mbox_expected_reply = 0;
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF registration with PF timed out\n");
+		return err;
+	}
+
+	if (!enic->vf_registered)
+		return -ENODEV;
+
+	return 0;
+}
+
+int enic_mbox_vf_unregister(struct enic *enic)
+{
+	int err;
+
+	if (!enic->vf_registered)
+		return 0;
+
+	reinit_completion(&enic->mbox_comp);
+	enic->mbox_expected_reply = ENIC_MBOX_VF_UNREGISTER_REPLY;
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REQUEST,
+				 ENIC_MBOX_DST_PF, NULL, 0);
+	if (err) {
+		enic->mbox_expected_reply = 0;
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	enic->mbox_expected_reply = 0;
+	if (err)
+		return err;
+	if (enic->vf_registered)
+		return -EACCES;
+	return 0;
 }
 
 void enic_mbox_init(struct enic *enic)
 {
 	enic->mbox_msg_num = 0;
 	mutex_init(&enic->mbox_lock);
+	init_completion(&enic->mbox_comp);
 	enic->admin_rq_handler = enic_mbox_recv_handler;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index f1de67db1273..15e30ee2b0ed 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -88,5 +88,8 @@ void enic_mbox_init(struct enic *enic);
 int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		       void *payload, u16 payload_len);
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state);
+int enic_mbox_vf_capability_check(struct enic *enic);
+int enic_mbox_vf_register(struct enic *enic);
+int enic_mbox_vf_unregister(struct enic *enic);
 
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0

