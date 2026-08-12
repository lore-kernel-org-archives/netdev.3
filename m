Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360943712F;
	Wed, 12 Aug 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538923; cv=none; b=jSjSNrXB0cMzdcqTbm0IhHQi5V+EOo5YQ79W7f5U8hOWaE7SR7bXa0qlko5hlm5sMcE0J5R4YTNW7U6zlD8VI6FBmz2MxbgsC1hcqkr8rY3/dUcqpsYaa6TO3FddpuCc+txAIabibj/QDMa0WIIPAMWplPAQpfAQ1P2ff2DqRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538923; c=relaxed/simple;
	bh=d8MPE/1BHvgCd3w3v/a5N7SIFCOt2ZkcwWHNeUMC6mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/kciFkg6M028fxqEHpN7Ou8hNapy+E08EqhoXsZksQ2hJThEyU41/3/b6jzF8bhw2kWlt693MKhrt9JJt6MdFiaupO7w2dSD0g0tX8TjMOHP+Ds5Yh3xubGos3z51KakcmfexzpxbkCDGe018oUG/cbPBtqs19YwPIhMtltgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=UEmdjFF2; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="UEmdjFF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8902; q=dns/txt;
  s=iport01; t=1786538921; x=1787748521;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PWaiJra6NJQQ4DPlpT5f4CBJpIx7ahC9FG6qTiARk1E=;
  b=UEmdjFF2ehkNkqney9C6RuG3LPHxJu8mgZDk0+gz1hMC+c0kMBStE//2
   e9oDsImLNGBDaTNFYYxm0xkqJrv8uGNpO0IMoWhk1CUx14i+3NZUyZNnA
   l20ghnfepnkJKe/tIgAk20asKJyCbUG0dND8AIIqD5CrCmuJea8AEfS9h
   5tXX2Vm89EUVedPlDU4XytEht8aZkX6KYIonuueSPUUDBQPYGfyyIAcwO
   uIcBzFypjiILs4WAoP7/JP8KjrTYtsZg2n+sw9FoTWDifH72qujg0+yDA
   cf6N2M3CxuLeV6d3989kEDoYPIr75FgB1ji5VEYw3AiJqYSdPCrKjeRGW
   g==;
X-CSE-ConnectionGUID: ct4fnQo6T/OCk0ZzHnw7YQ==
X-CSE-MsgGUID: 90wOMAYvSIGeI0ZUoQmTjA==
X-IPAS-Result: =?us-ascii?q?A0AnAABhanxq/5EQJK1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBUkNJhFeIG4c3giGRTYxRFIFqDwEBAQ9RBAEBhQUCjWcCJjQJDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGXIZbAgEDIwQLATQSECUCJgICR?=
 =?us-ascii?q?hAGARKDAoJ1A8Msen8zgQGEfdlJgWYBCxQBgQouAYVwgmwBgXCECDuEQScbg?=
 =?us-ascii?q?UlEgRWDaYQFGoN/gmoEgxwSgkiQOAk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLE?=
 =?us-ascii?q?hIYFQIUHBMPBBYyHXAMEBcSLBc1WBsGBYEdfRQEE4Q2Ixk2fIEJYYErKmUBE?=
 =?us-ascii?q?heBCYIkAoJ2gSphAgEeCxgNSBEsNwYOGQQ9AW4HjggggVRqBz0OMBRCOTEBe?=
 =?us-ascii?q?wUwkwsdg36OSoE1n1qEKIFmoA8BMpdnjFWGMJkII6NeWYRpgWg8gVkzGggbF?=
 =?us-ascii?q?YMiUxkPji0WHM99JzI9AgcCBw4DC5F5gW0BAQ?=
IronPort-Data: A9a23:HYZy6qxcdsxqZMalr1F6t+flxyrEfRIJ4+MujC+fZmUNrF6WrkUOy
 jYbUWqGb6yMYmrye410aNjk8RhSv5bdnN5hQQZspVhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/VH1buSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 46aT/H3Ygf/hWYkazhMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJEoqYYMew+EpPSZp3
 v9AGiItaA/cttvjldpXSsE07igiBMDvOIVavjRryivUSK52B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNUidC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+Oi1bICEK4XSH625mG7J/
 n3h2k3IHCo7G9G+kQi49Uupuu3myHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0gZ+zYnqoA++UaqR9+7WAe3yFaJsgMZUshdD8U17waCzqeS6AGcbkAHUzRIQN8rrsk7QXotz
 FDht9rvCSZir/6TRG6R+6m8qS60P24eLQcqfSYOQA0Ey8PurIE6klTESdMLOKq0iMDlXDL92
 TaHqAAgiLgJy80GzaO2+RbAmT3Ejp7EUgI4+C3JUW+/qAB0foioY8qv81ez0BpbBI+dSl/Eu
 D0PnNKTqbheS5qMjyeKBu4KGdlF+sq4DdEVunY3d7FJythn0yfLkVx4iN2mGHpUDw==
IronPort-HdrOrdr: A9a23:b4EvsamgyjTz8fkaQTmZuVgX+5/pDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: 9a23:3yadW2OYAdvNMu5DUzU7+kgtHZ4ZNVr2zy/iMW++FjlYcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AE4/a+w8iwCed04PGJ6WPZsSQf5Yw/IOLIXETqrQ?=
 =?us-ascii?q?ptujcBxF3AjKhjh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="804299102"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 12:48:36 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 86B2118000475;
	Wed, 12 Aug 2026 12:48:35 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 12 Aug 2026 05:48:07 -0700
Subject: [PATCH net-next v13 07/11] enic: add MBOX PF handlers for VF
 register and capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-enic-sriov-v2-admin-channel-v2-v13-7-b3809e448aba@cisco.com>
References: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786538908; l=9260;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=d8MPE/1BHvgCd3w3v/a5N7SIFCOt2ZkcwWHNeUMC6mk=;
 b=y6/eAbE46S5ZcJGLLBPEZJtSztR9kICXNz56CjTnAhOUmHbDSUjUZB9cQ9+TIIZrsUjrzhedT
 KsyhAh6ozuxBxKuCseeWep51V5eSQrg7DSxmy5Y24ly5GcdQB6VkSQ8
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-08.cisco.com

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
state notifications.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   7 +-
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 190 +++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h |   1 +
 3 files changed, 194 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 525a67414e63..6261f3e8e4f8 100644
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
index c1680f77abac..d1b13737e77d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -142,10 +142,183 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
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
+	/* Registration succeeded; initial link state notification attempted
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
@@ -163,10 +336,23 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
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

