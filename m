Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7037F725;
	Sun, 19 Jul 2026 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450723; cv=none; b=h1XBjnTu9xzQAzhAFzRYoG/V6Rc5qn3FYhm7xwexfhNDQGDS0i5w9pIIezhWlsNhnE7zq1HuUD4u7DbctjIZmVezEdk4TYHkKzaoyo99EOFupjI3n2x2Qus28eBdXYxgjdyjhg+e0sG54MYViieA14tEHCp8NqjL8o3ePfbvy+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450723; c=relaxed/simple;
	bh=UVy3/H0RMuEKNl5Vs6NEqyAwXoJIsI4AzdpjTFTi9yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a28Si/492C2o8/iIazH+lrQevheZMS8L8zqRPCBcUFFIbVRqUV+FmxSaaZeRn70Pqdi8kitUAG0Kw5B4URH1apUG1Y+GsC0oSU4qnFJGWLIi+9V+11+InaZIeO+LB/GF/W3ocs0TXAP8OQ/UeXgMvrW2nX6dP4RR/ZBd7LWu12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=E4FPzQWH; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="E4FPzQWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8939; q=dns/txt;
  s=iport01; t=1784450721; x=1785660321;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CXMacmSzG4Vh/h4v1BbunYRM6XQpMQSp/sageLt5vm4=;
  b=E4FPzQWHQ4oPhds7HNoYb8eYBZlucz2T1wucOugyw9POmXLkQVp8hlKt
   MqnGmu5jPN6OlbXYIICNVnY8IivxRZx4LQ+BrCRpHDAdXrTHPQXyj9Uxp
   FXme/hj1XMo9oE470vOxOJfGzSPMPRzZjpya/8SXZyTwiJqCxAwAdKlY4
   MpvxK8f3rdLbmd3QQN5Y969sO6LMuJtVrn3cb5KJj71NW3zyZzALBooS0
   nG9m1C91VXJLf4Vkfzmk2FP0UGhaOSVjGLJTEQ7SFZDGIw3R7TBDgdL4M
   V9HvKnHYarCSkGzSr22vlkG2JTZJRhsr0aAJ1gAzmDhZgnH1PdCv4bB5t
   g==;
X-CSE-ConnectionGUID: VOvsOarnT9S5wK7MT/NeJA==
X-CSE-MsgGUID: dtLV9NNPScmk+WuWB+bsrg==
X-IPAS-Result: =?us-ascii?q?A0BHAgAEjVxq/5H/Ja1aglmCV4FSQ0mEV49SgiGRTYxRF?=
 =?us-ascii?q?IFqDwEBAQ9RBAEBhQUCjVMCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGXIZbAgEDIwQLATQSECUCJgICRhAGARKDAoJ1A70Len8zgQGEf?=
 =?us-ascii?q?dlIgWYBCxQBgQouhXGCawGBcIQHO4RBJxuBSUSBFYNphAUag3+CagSDHBKCS?=
 =?us-ascii?q?I8kCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQcEw8EFjIdcAwQFxIsF?=
 =?us-ascii?q?zRYGwcFgR1/FgQhgQKEdiMfAzl/gTB1SnctaQESF4EvghSBOgIHAwsYDUgRL?=
 =?us-ascii?q?DcGDhkEPQFuB41AI4FOagc9DjAUQjkxAXsFMJMLHYN+jkqBNZ9ahCeBZqAPA?=
 =?us-ascii?q?TKXZ4xVhjCZCCOjTBJZhGmBaDyBWTMaCBsVgyJTGQ+OLRYc0h4nMj0CBwIHD?=
 =?us-ascii?q?gMLkXmBbQEB?=
IronPort-Data: A9a23:Jx+1FKo6F/OZam/rvuEJ5av1GeVeBmLFZBIvgKrLsJaIsI4StFCzt
 garIBnVaa3cNmWgfoxwbY2x8hkOu5bSmtc2Hgc6qy1mFyIRp+PIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgLNNwJcaDpOtfrc8UI35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0thQH3pp/
 OYeFGE2Mw+g2MeKh5S2aMA506zPLOGzVG8ekmtrwTecCbMtRorOBv2ao9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LVfrSn8/w7pX7WyZRtFOOpak3y2PS1wd2lrPqNbI5f/TXHJ8NxBvJ+
 zquE2LRDg0+Co257wK++XevxdDSogm4UpkIG+jtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA2+U23R97VUxCyoXeC+BkGVLJ4HuEn7Qifx7b87AGeCWwJCDVGbbQOt9I8TBQp2
 0WPktevAiZg2JWcT36H+6jXqz6uNSULBWsfYylCRgtty8Hqqow1jzrVQ9pjGbLzhdrwcRn0w
 jaXvG09iq8VgMojyaq25xbEjiiqq5yPSRQ6ji3RU36p4x1ReoGofcqr5ELd4PIGK5yWJmRtp
 1AekMSYqeRLBpaXmWnVEKMGHaqi4LCONzi0bUNTIqTNPg+FoxaLFb28KhknTKu1Gq7ooQPUX
 XI=
IronPort-HdrOrdr: A9a23:C4Apnq1kTFylEiwCVDaZmQqjBEQkLtp133Aq2lEZdPWaSL39qy
 nIppUmPH7P5gr5N0tMpTntAsO9qDbnhPxICOoqUotKIjOHhILAFugLhrcKgQeQeBEWndQw6U
 4PSdkaNPTASXV3ksr+5hC1CJIDzMnvytHQuc7ui1pgUg1ubbht9ENCCgidGlBrXwUuP+teKH
 Pl3LshmxOQPVIKc8+8Gn4JG8LHp9HNidbaRCRuPW9e1OFL5gnYkoIT1HOjr2wjbw8=
X-Talos-CUID: =?us-ascii?q?9a23=3AJxnIZWua6D8CK0Q1fHksZ8Yf6IsbVWPG637KJXP?=
 =?us-ascii?q?pMjt2a+KwdRi29YFNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ayrn0bA57l5eIvgLSYD8LEPDPxoxk/4CQWWYrqa4?=
 =?us-ascii?q?NvsrHCjFPEXSXly64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; 
   d="scan'208";a="512025950"
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jul 2026 08:42:10 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 170D61800046B;
	Sun, 19 Jul 2026 08:42:10 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 19 Jul 2026 01:41:52 -0700
Subject: [PATCH net-next v12 08/12] enic: add MBOX PF handlers for VF
 register and capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260719-enic-sriov-v2-admin-channel-v2-v12-8-6ff2c617001d@cisco.com>
References: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
In-Reply-To: <20260719-enic-sriov-v2-admin-channel-v2-v12-0-6ff2c617001d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784450523; l=9297;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=UVy3/H0RMuEKNl5Vs6NEqyAwXoJIsI4AzdpjTFTi9yQ=;
 b=u6Vbx8Pd2m2dtavHAaRbp2YXq/WRA+eJjZykeqdQAjD3BLfIOK1p+L3xozKzR08XFFxbe4XRc
 RLdSas+9d+iDjZTesDu4OcJIbdSeesZg+e0KJo1S6PfMK1o8jlded5d
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-08.cisco.com

Implement PF-side mailbox message processing for SR-IOV V2
admin channel communication.

When the PF receives messages from VFs, the dispatch routes
them to type-specific handlers:
  - VF_CAPABILITY_REQUEST: reply with protocol version 1
  - VF_REGISTER_REQUEST: send the register reply, mark the
    VF registered on success, then send PF_LINK_STATE_NOTIF
    reflecting the PF's current carrier state
  - VF_UNREGISTER_REQUEST: mark VF unregistered, send reply
  - PF_LINK_STATE_ACK: log errors from VF acknowledgment

Per-VF state (struct enic_vf_state) is tracked via enic->vf_state
which will be allocated when SRIOV V2 is enabled.

Remove the CONFIG_PCI_IOV guard from num_vfs in struct enic. The
PF handlers reference enic->num_vfs for VF ID bounds checking in
enic_mbox.c, which is compiled unconditionally. The field must be
visible regardless of CONFIG_PCI_IOV to avoid build failures.

Add enic_mbox_send_link_state() helper for PF-initiated link
state notifications, also used later by ndo_set_vf_link_state.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   7 +-
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 190 +++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h |   1 +
 3 files changed, 194 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index b009d87da4bd..d459318c46fc 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -256,9 +256,7 @@ struct enic {
 	struct enic_rx_coal rx_coalesce_setting;
 	u32 rx_coalesce_usecs;
 	u32 tx_coalesce_usecs;
-#ifdef CONFIG_PCI_IOV
 	u16 num_vfs;
-#endif
 	enum enic_vf_type vf_type;
 	unsigned int enable_count;
 	spinlock_t enic_api_lock;
@@ -315,6 +313,11 @@ struct enic {
 	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
 	struct mutex mbox_lock;
 	u64 mbox_msg_num;
+
+	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
+	struct enic_vf_state {
+		bool registered;
+	} *vf_state;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 3709704bee02..b6f05b03ae26 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -135,10 +135,183 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 	return err;
 }
 
+int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
+{
+	struct enic_mbox_pf_link_state_notif_msg notif = {};
+
+	if (!enic->vf_state || vf_id >= enic->num_vfs ||
+	    !enic->vf_state[vf_id].registered) {
+		netdev_dbg(enic->netdev,
+			   "MBOX: skip link state to unregistered VF %u\n",
+			   vf_id);
+		return 0;
+	}
+
+	notif.link_state = cpu_to_le32(link_state);
+	return enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_NOTIF, vf_id,
+				  &notif, sizeof(notif));
+}
+
+static int enic_mbox_pf_handle_capability(struct enic *enic, void *msg,
+					  u16 vf_id, u64 msg_num)
+{
+	struct enic_mbox_vf_capability_reply_msg reply = {};
+
+	reply.reply.ret_major = cpu_to_le16(0);
+	reply.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
+
+	return enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REPLY, vf_id,
+				  &reply, sizeof(reply));
+}
+
+static int enic_mbox_pf_handle_register(struct enic *enic, void *msg,
+					u16 vf_id, u64 msg_num)
+{
+	struct enic_mbox_vf_register_reply_msg reply = {};
+	u32 link_state;
+	int err;
+
+	if (!enic->vf_state || vf_id >= enic->num_vfs) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: register from invalid VF %u\n",
+				    vf_id);
+		return -EINVAL;
+	}
+
+	/* VF re-registering (e.g. guest reboot without clean unregister):
+	 * mark the previous registration inactive before accepting the new one.
+	 */
+	if (enic->vf_state[vf_id].registered) {
+		netdev_dbg(enic->netdev,
+			   "MBOX: VF %u re-register, cleaning previous state\n",
+			   vf_id);
+		enic->vf_state[vf_id].registered = false;
+	}
+
+	reply.reply.ret_major = cpu_to_le16(0);
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REPLY, vf_id,
+				 &reply, sizeof(reply));
+	if (err)
+		return err;
+
+	enic->vf_state[vf_id].registered = true;
+	if (net_ratelimit())
+		netdev_info(enic->netdev, "VF %u registered via MBOX\n", vf_id);
+
+	link_state = netif_carrier_ok(enic->netdev) ?
+		ENIC_MBOX_LINK_STATE_ENABLE :
+		ENIC_MBOX_LINK_STATE_DISABLE;
+	err = enic_mbox_send_link_state(enic, vf_id, link_state);
+	if (err && net_ratelimit())
+		netdev_warn(enic->netdev,
+			    "VF %u: failed to send initial link state: %d\n",
+			    vf_id, err);
+	/* Registration succeeded; initial link state notification sent
+	 * above.  Subsequent link state changes are sent from the PF
+	 * when enic_link_check() detects carrier changes.
+	 */
+	return 0;
+}
+
+static int enic_mbox_pf_handle_unregister(struct enic *enic, void *msg,
+					  u16 vf_id, u64 msg_num)
+{
+	struct enic_mbox_vf_register_reply_msg reply = {};
+	int err;
+
+	if (!enic->vf_state || vf_id >= enic->num_vfs) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: unregister from invalid VF %u\n",
+				    vf_id);
+		return -EINVAL;
+	}
+
+	/* VF is unloading; clear local state regardless of whether
+	 * the reply is successfully delivered to avoid the PF treating
+	 * a dead VF as still registered.
+	 */
+	enic->vf_state[vf_id].registered = false;
+
+	reply.reply.ret_major = cpu_to_le16(0);
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REPLY, vf_id,
+				 &reply, sizeof(reply));
+
+	if (net_ratelimit())
+		netdev_info(enic->netdev,
+			    "VF %u unregistered via MBOX\n", vf_id);
+
+	return err;
+}
+
+static void enic_mbox_pf_process_msg(struct enic *enic,
+				     struct enic_mbox_hdr *hdr, void *payload)
+{
+	u16 vf_id = le16_to_cpu(hdr->src_vnic_id);
+	u16 msg_len = le16_to_cpu(hdr->msg_len);
+	int err = 0;
+
+	if (!enic->vf_state) {
+		netdev_dbg(enic->netdev,
+			   "MBOX: PF received msg but SRIOV not active\n");
+		return;
+	}
+
+	if (vf_id >= enic->num_vfs) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: PF received msg from invalid VF %u\n",
+				    vf_id);
+		return;
+	}
+
+	switch (hdr->msg_type) {
+	case ENIC_MBOX_VF_CAPABILITY_REQUEST:
+		err = enic_mbox_pf_handle_capability(enic, payload, vf_id,
+						     le64_to_cpu(hdr->msg_num));
+		break;
+	case ENIC_MBOX_VF_REGISTER_REQUEST:
+		err = enic_mbox_pf_handle_register(enic, payload, vf_id,
+						   le64_to_cpu(hdr->msg_num));
+		break;
+	case ENIC_MBOX_VF_UNREGISTER_REQUEST:
+		err = enic_mbox_pf_handle_unregister(enic, payload, vf_id,
+						     le64_to_cpu(hdr->msg_num));
+		break;
+	case ENIC_MBOX_PF_LINK_STATE_ACK: {
+		struct enic_mbox_pf_link_state_ack_msg *ack = payload;
+
+		if (msg_len < sizeof(*hdr) + sizeof(*ack))
+			break;
+		if (le16_to_cpu(ack->ack.ret_major) && net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: VF %u link state ACK error %u/%u\n",
+				    vf_id,
+				    le16_to_cpu(ack->ack.ret_major),
+				    le16_to_cpu(ack->ack.ret_minor));
+		break;
+	}
+	default:
+		netdev_dbg(enic->netdev,
+			   "MBOX: PF unhandled msg type %u from VF %u\n",
+			   hdr->msg_type, vf_id);
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	if (err && net_ratelimit())
+		netdev_warn(enic->netdev,
+			    "MBOX: PF handler for msg type %u from VF %u failed: %d\n",
+			    hdr->msg_type, vf_id, err);
+}
+
 static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 				   unsigned int len)
 {
 	struct enic_mbox_hdr *hdr = buf;
+	void *payload;
+	u16 msg_len;
 
 	if (len < sizeof(*hdr)) {
 		if (net_ratelimit())
@@ -156,10 +329,23 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 		return;
 	}
 
+	msg_len = le16_to_cpu(hdr->msg_len);
+	if (msg_len < sizeof(*hdr) || msg_len > len) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: invalid msg_len %u (buf len %u)\n",
+				    msg_len, len);
+		return;
+	}
+
 	netdev_dbg(enic->netdev,
 		   "MBOX recv: type %u from vnic %u len %u\n",
-		   hdr->msg_type, le16_to_cpu(hdr->src_vnic_id),
-		   le16_to_cpu(hdr->msg_len));
+		   hdr->msg_type, le16_to_cpu(hdr->src_vnic_id), msg_len);
+
+	payload = buf + sizeof(*hdr);
+
+	if (enic->vf_state)
+		enic_mbox_pf_process_msg(enic, hdr, payload);
 }
 
 void enic_mbox_init(struct enic *enic)
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index 73fd7f783ee2..f1de67db1273 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -87,5 +87,6 @@ struct enic;
 void enic_mbox_init(struct enic *enic);
 int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		       void *payload, u16 payload_len);
+int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state);
 
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0

