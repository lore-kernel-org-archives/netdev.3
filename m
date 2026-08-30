Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD15282F16;
	Sun, 30 Aug 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128596; cv=none; b=bwfWuEaedUNG46QbKWs3OS4ATjwzgK083MRVMJIV3Gmt5Ys+7Ppod2kKsc4hrE6X1ibjKRwXGDinZJZRkmz7ACZWVkqBZR64MXXawOoFnnFN0NVPjwydEO+tXA0lNdCnQaaU9BUMONTHroD+lbxNNTRUkXAGWTjyhVX9DfvBX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128596; c=relaxed/simple;
	bh=ylmL8zjlyszfYlTmGfDsRSpmY6H9vGIcJUJbLupDUfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbxYShaZVGSxgSFlGorcCVj5SIFUE7IP83z/9aKFGEohqBt5mXunIvNbGjMPTfY4iNfgnTAfJrgT3md2PB0bResPxOUYbuD1w/mTrjpkqjipPDbTiVLif+F+0AzdZ78v/zb+ECGjUeUWzb8efikOVqfrPM2O0dNfIoerKsHm9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=UzdOKHvi; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="UzdOKHvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=19982; q=dns/txt;
  s=iport01; t=1788128594; x=1789338194;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QRAmTjSLgw3C5qt0tCS5PMC4PKXLn0kuxtWHH8XndmM=;
  b=UzdOKHvij114r2WZwKdtNsnUr9qaw0KWiWDVyc4X+RBI7aX3DrqT7afo
   aU57WCKyk8PtI6mvsSVasDBWfSfgVtLO7kHF+Jzgvp76lU3Co4OiIiHxE
   IaQfokBOBCqUwnLyO23Z9ccY7sKS43LDp+OSYk2jCm1rKK4iLbBDkxMdP
   iq3Op+gDvSKjLm27Sx1P19TvlZxrA3lI5Hti2EHQ88EHLDFoIZtfkdiVZ
   LbcKXR0q1b0gOd2g6iGGMhc9db/kcg0LaAPylltFKgpEYMY3A+YfToh3V
   3jxXohsOHs6G4QY33Y+OhLCIOrsAtNV4e4kgMr1ckE/nmeVZB1LZ2boXW
   w==;
X-CSE-ConnectionGUID: sUTQ7ugzR+alzvvD8CqU5Q==
X-CSE-MsgGUID: rlJk6mPwSAuU7OOnIJuK5g==
X-IPAS-Result: =?us-ascii?q?A0AnAAB0rJRq/5IQJK1SCB0BAQEBCQESAQUFAYF8CAELA?=
 =?us-ascii?q?YJWgVJDSYRXiBuHN4IhkU2MURSBag8BAQEPUQQBAYUFAo1zAiY0CQ4BAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMECwFGECUCJgICR?=
 =?us-ascii?q?QEQBgESgwKCdQPCJXp/M4EBhH3ZSoFmAQsUAYEKLgGFcIJtAYFwhAg7hEEnG?=
 =?us-ascii?q?4FJRIEVg2lrGgGDFgMLg3SCagSDHBKTeQk/gQIcA1ksAVUTDQoLBwVhUjMDI?=
 =?us-ascii?q?AoLEhIYFQIULw8EFjIdcAwnEiwXNVgbBgWBHX0UBBOEDyMZNnqBCV6BKylgA?=
 =?us-ascii?q?RIXgQmCCAKCWoIFAgFJQw4HR1MJBAsYDUgRLBQjBg8ZBD0BbgeOeh+BWmoHF?=
 =?us-ascii?q?l8aTC8ELQEDSAcUBBEFAS+QU4JVETGDPI5KgTWfWoQogWagEDOEBJNjNJJRm?=
 =?us-ascii?q?Qgjo08YUIRpgWg8gVkzGggbFYMiUxkPji0LC9AZJzI+AQcCBw8CgXOQEYFtA?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:KN2sFqnE0TCl8TL/N30Ln8/o5gxAJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIeDWuPPPuLYjPyL99yaYyz9R8EsZaEx9FgHFFr+SpjEVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZC31GONgWYubDpEsPrb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FZYlxt8oHG5cz
 78RLCITcDzTrPuLnYvuH4GAhux7RCXqFIobvnclyXTSCuwrBMiSBa7L/tRfmjw3g6iiH96HO
 JFfMmQpNUqGOkERUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIqPIYbVHpQEwi50o
 Erc+0b6XBQiK+e21Afa1VWqp83Svn70Ddd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSQoD/smmo4wpiB/LZshsHbTzjdDvHzz0h
 TeQo0AWgbgPgcMV/7u08EqBgD+2oJXNCAkv6W3qsnmN5wd9YsuhIoev81WetacGJ4eCRV7Ht
 38B8ySD0N0z4Vi2vHTlaI0w8HuBvp5p7BW0bYZTIqQc
IronPort-HdrOrdr: A9a23:wZ5Lh6vGBhMLPSw5jyx/jAVR7skDgNV00zEX/kB9WHVpmwKj5q
 STdZMgtCMc6Qx+ZJhOo7290cW7K080sKQFg7X5Xo3MYOCZgguVxehZhOOI/9SjIVycygc378
 tdmsZFebjNJGk/oMrk7Ay/Cto6hPuK4MmT9J7j5kYoYA10Z6Rn9gtjTjyaHEp/WRVcCfMCZf
 yhD7J81l2dUEVSSNinDX8YWOWGjdjKmJX6JSMiPXccmXGzZffC0s+BL/BetS1uKA9y/Q==
X-Talos-CUID: =?us-ascii?q?9a23=3AyFAk0WgyV1sh6L4MWFHiDkccEjJuaUDh9SjNLF2?=
 =?us-ascii?q?CSm9tWqOLZQ+74Z45qp87?=
X-Talos-MUID: 9a23:V0rWvQTdhBPX8QbkRXT2gBNhasJQ/J+HFX1StrIAmuuZFnF/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,252,1779148800"; 
   d="scan'208";a="823273994"
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 30 Aug 2026 22:23:07 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-09.cisco.com (Postfix) with ESMTPS id 3524A18000475;
	Sun, 30 Aug 2026 22:23:06 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 30 Aug 2026 15:22:53 -0700
Subject: [PATCH net 2/2] enic: match mailbox replies to request numbers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260830-b4-enic-v2-mbox-fixes-net-v1-2-23adf9bfd426@cisco.com>
References: <20260830-b4-enic-v2-mbox-fixes-net-v1-0-23adf9bfd426@cisco.com>
In-Reply-To: <20260830-b4-enic-v2-mbox-fixes-net-v1-0-23adf9bfd426@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Sesidhar Baddela <sebaddel@cisco.com>, 
 linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788128581; l=20799;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ylmL8zjlyszfYlTmGfDsRSpmY6H9vGIcJUJbLupDUfs=;
 b=xhgs8Q6XZAq953PaKarQqtR6XwqTMQjCzw41BmV8oeKj/4Lcgziil91ZLB/9NmrHn1DY5xbbw
 f4qFDvUlOKAAb5PdgAaQpptktwsQZ/mekeBu6H2mM0eo09WWFtJhjHE
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-09.cisco.com

The version-1 VF mailbox protocol identifies every message with a message
number, and a reply or acknowledgment echoes the number of the message it
answers.  ENIC instead generates a new number for outgoing replies and
accepts a VF reply by message type alone.

If a request times out, a delayed reply can therefore satisfy a subsequent
request of the same type and cause the VF to consume the result of the old
request.

Allow replies to reuse the initiating message number. Make the in-tree PF
handlers and the VF link-state acknowledgment echo that number. Record the
expected reply type and message number on the VF, and require both values
to match before accepting a reply.

Protect expected-reply state with a lock so reply acceptance and timeout
invalidation cannot race. Keep message numbers monotonic across an admin-
channel reopen so a delayed reply from an earlier channel generation cannot
match a new request.

Reply-number echo is part of the established version-1 protocol, so this
remains compatible with deployed V2-capable PF implementations that already
echo msg_num.

Fixes: 72b65c94058e ("enic: add MBOX VF handlers for capability, register and link state")
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  13 +-
 drivers/net/ethernet/cisco/enic/enic_main.c |  13 +-
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 272 ++++++++++++++++------------
 3 files changed, 174 insertions(+), 124 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 2822fbfb6474..7a509a056990 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -329,15 +329,14 @@ struct enic {
 	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
 	struct mutex mbox_lock;
 	u64 mbox_msg_num;
-	/* MBOX request-reply state.  mbox_expected_reply is written and
-	 * cleared by the process-context request helpers (capability/register/
-	 * unregister) and only read by the admin_msg_work receive handlers, so
-	 * it is annotated with READ_ONCE()/WRITE_ONCE() rather than locked:
-	 * only one request is in flight at a time (requesters run under RTNL or
-	 * single-threaded probe/remove), so each request is serialized and its
-	 * reply completes mbox_comp before the next request is issued.
+	/* MBOX request-reply state.  Existing request callers allow only one
+	 * request in flight.  The state lock arbitrates reply acceptance against
+	 * timeout invalidation, while mbox_comp publishes the accepted result to
+	 * the requester.
 	 */
 	struct completion mbox_comp;
+	spinlock_t mbox_state_lock;	/* protects expected reply state */
+	u64 mbox_expected_msg_num;
 	u8 mbox_expected_reply;
 	bool mbox_initialized;
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 48d16ef18c49..14d1637a4342 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2206,9 +2206,10 @@ static void enic_admin_chan_reopen(struct enic *enic)
 {
 	int err;
 
-	/* Install the MBOX receive handler and reset the sequence number
-	 * before opening the channel, so the handler is in place before the
-	 * admin interrupt is unmasked and no early completion is dropped.
+	/* Install the MBOX receive handler and clear pending reply state before
+	 * opening the channel, so the handler is in place before the admin
+	 * interrupt is unmasked and no early completion is dropped.  Keep the
+	 * sequence number monotonic across channel generations.
 	 */
 	enic_mbox_init(enic);
 
@@ -2220,7 +2221,7 @@ static void enic_admin_chan_reopen(struct enic *enic)
 	 * registration over a dead channel.
 	 */
 	if (enic_is_sriov_vf_v2(enic))
-		enic->vf_registered = false;
+		WRITE_ONCE(enic->vf_registered, false);
 
 	err = enic_admin_channel_open(enic);
 	if (err) {
@@ -3349,7 +3350,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_out_admin_close:
 	if (enic_is_sriov_vf_v2(enic)) {
-		if (enic->vf_registered) {
+		if (READ_ONCE(enic->vf_registered)) {
 			int unreg_err = enic_mbox_vf_unregister(enic);
 
 			if (unreg_err)
@@ -3402,7 +3403,7 @@ static void enic_remove(struct pci_dev *pdev)
 		 * touching a netdev that is being torn down.
 		 */
 		if (enic_is_sriov_vf_v2(enic)) {
-			if (enic->vf_registered) {
+			if (READ_ONCE(enic->vf_registered)) {
 				int unreg_err = enic_mbox_vf_unregister(enic);
 
 				if (unreg_err)
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index ad79d3951f3d..5c93ca49552a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -18,22 +18,25 @@
 #define ENIC_MBOX_POLL_TIMEOUT_US	5000000
 #define ENIC_MBOX_POLL_INTERVAL_US	100
 
-static void enic_mbox_fill_hdr(struct enic *enic, struct enic_mbox_hdr *hdr,
-			       u8 msg_type, u16 dst_vnic_id, u16 msg_len)
+static void enic_mbox_fill_hdr(struct enic_mbox_hdr *hdr, u8 msg_type,
+			       u16 dst_vnic_id, u16 msg_len, u64 msg_num)
 {
 	memset(hdr, 0, sizeof(*hdr));
 	hdr->dst_vnic_id = cpu_to_le16(dst_vnic_id);
 	hdr->msg_type = msg_type;
 	hdr->msg_len = cpu_to_le16(msg_len);
-	hdr->msg_num = cpu_to_le64(++enic->mbox_msg_num);
+	hdr->msg_num = cpu_to_le64(msg_num);
 }
 
-int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
-		       void *payload, u16 payload_len)
+static int enic_mbox_send_msg_id(struct enic *enic, u8 msg_type,
+				 u16 dst_vnic_id, void *payload,
+				 u16 payload_len, u64 msg_num, bool reuse_msg_num,
+				 u8 expected_reply)
 {
 	size_t total_len = sizeof(struct enic_mbox_hdr) + payload_len;
 	struct vnic_wq *wq = &enic->admin_wq;
 	struct wq_enet_desc *desc;
+	bool reply_expected = false;
 	unsigned long timeout;
 	dma_addr_t dma_addr;
 	u16 vlan_tag;
@@ -68,7 +71,21 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		goto unlock;
 	}
 
-	enic_mbox_fill_hdr(enic, buf, msg_type, dst_vnic_id, total_len);
+	/* Replies reuse the initiating message number.  Requests and
+	 * notifications allocate a new one.
+	 */
+	if (!reuse_msg_num)
+		msg_num = ++enic->mbox_msg_num;
+	if (expected_reply) {
+		reinit_completion(&enic->mbox_comp);
+		spin_lock_bh(&enic->mbox_state_lock);
+		enic->mbox_expected_reply = expected_reply;
+		enic->mbox_expected_msg_num = msg_num;
+		spin_unlock_bh(&enic->mbox_state_lock);
+		reply_expected = true;
+	}
+
+	enic_mbox_fill_hdr(buf, msg_type, dst_vnic_id, total_len, msg_num);
 	if (payload_len) {
 		void *dst = buf + sizeof(struct enic_mbox_hdr);
 
@@ -139,18 +156,66 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		   "MBOX send msg_type %u dst %u vlan %u err %d\n",
 		   msg_type, dst_vnic_id, vlan_tag, err);
 unlock:
+	if (err && reply_expected) {
+		spin_lock_bh(&enic->mbox_state_lock);
+		if (enic->mbox_expected_reply == expected_reply &&
+		    enic->mbox_expected_msg_num == msg_num) {
+			enic->mbox_expected_reply = 0;
+			enic->mbox_expected_msg_num = 0;
+		}
+		spin_unlock_bh(&enic->mbox_state_lock);
+	}
 	mutex_unlock(&enic->mbox_lock);
 	return err;
 }
 
+int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
+		       void *payload, u16 payload_len)
+{
+	return enic_mbox_send_msg_id(enic, msg_type, dst_vnic_id, payload,
+				     payload_len, 0, false, 0);
+}
+
+static int enic_mbox_send_reply(struct enic *enic, u8 msg_type,
+				u16 dst_vnic_id, void *payload, u16 payload_len,
+				u64 msg_num)
+{
+	return enic_mbox_send_msg_id(enic, msg_type, dst_vnic_id, payload,
+				     payload_len, msg_num, true, 0);
+}
+
+static int enic_mbox_vf_send_request(struct enic *enic, u8 request_type,
+				     u8 expected_reply, void *payload,
+				     u16 payload_len)
+{
+	return enic_mbox_send_msg_id(enic, request_type, ENIC_MBOX_DST_PF,
+				     payload, payload_len, 0, false,
+				     expected_reply);
+}
+
 static int enic_mbox_wait_reply(struct enic *enic, unsigned long timeout_ms)
 {
 	unsigned long left;
+	int err = 0;
 
 	left = wait_for_completion_timeout(&enic->mbox_comp,
 					   msecs_to_jiffies(timeout_ms));
+	if (left)
+		return 0;
+
+	/* Invalidate a request that the handler has not already accepted.  A
+	 * delayed reply cannot match a later request because message numbers are
+	 * monotonic across channel reopen.
+	 */
+	spin_lock_bh(&enic->mbox_state_lock);
+	if (enic->mbox_expected_reply) {
+		enic->mbox_expected_reply = 0;
+		enic->mbox_expected_msg_num = 0;
+		err = -ETIMEDOUT;
+	}
+	spin_unlock_bh(&enic->mbox_state_lock);
 
-	return left ? 0 : -ETIMEDOUT;
+	return err;
 }
 
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
@@ -178,8 +243,8 @@ static int enic_mbox_pf_handle_capability(struct enic *enic, void *msg,
 	reply.reply.ret_major = cpu_to_le16(0);
 	reply.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
 
-	return enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REPLY, vf_id,
-				  &reply, sizeof(reply));
+	return enic_mbox_send_reply(enic, ENIC_MBOX_VF_CAPABILITY_REPLY, vf_id,
+				    &reply, sizeof(reply), msg_num);
 }
 
 static int enic_mbox_pf_handle_register(struct enic *enic, void *msg,
@@ -208,8 +273,8 @@ static int enic_mbox_pf_handle_register(struct enic *enic, void *msg,
 	}
 
 	reply.reply.ret_major = cpu_to_le16(0);
-	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REPLY, vf_id,
-				 &reply, sizeof(reply));
+	err = enic_mbox_send_reply(enic, ENIC_MBOX_VF_REGISTER_REPLY, vf_id,
+				   &reply, sizeof(reply), msg_num);
 	if (err)
 		return err;
 
@@ -253,8 +318,8 @@ static int enic_mbox_pf_handle_unregister(struct enic *enic, void *msg,
 	enic->vf_state[vf_id].registered = false;
 
 	reply.reply.ret_major = cpu_to_le16(0);
-	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REPLY, vf_id,
-				 &reply, sizeof(reply));
+	err = enic_mbox_send_reply(enic, ENIC_MBOX_VF_UNREGISTER_REPLY, vf_id,
+				   &reply, sizeof(reply), msg_num);
 
 	if (net_ratelimit())
 		netdev_info(enic->netdev,
@@ -324,75 +389,57 @@ static void enic_mbox_pf_process_msg(struct enic *enic,
 			    hdr->msg_type, vf_id, err);
 }
 
-static void enic_mbox_vf_handle_capability_reply(struct enic *enic,
-						 void *payload)
+static void enic_mbox_vf_handle_reply(struct enic *enic, u8 reply_type,
+				      void *payload, u64 msg_num)
 {
-	struct enic_mbox_vf_capability_reply_msg *reply = payload;
-
-	if (READ_ONCE(enic->mbox_expected_reply) != ENIC_MBOX_VF_CAPABILITY_REPLY) {
+	struct enic_mbox_generic_reply *reply = payload;
+	u16 ret_major = le16_to_cpu(reply->ret_major);
+	u64 expected_msg_num;
+	u8 expected_type;
+
+	spin_lock_bh(&enic->mbox_state_lock);
+	expected_type = enic->mbox_expected_reply;
+	expected_msg_num = enic->mbox_expected_msg_num;
+	if (expected_type != reply_type || expected_msg_num != msg_num) {
+		spin_unlock_bh(&enic->mbox_state_lock);
 		netdev_warn(enic->netdev,
-			    "MBOX: stale capability reply (expected %u), drop\n",
-			    READ_ONCE(enic->mbox_expected_reply));
+			    "MBOX: stale reply %u/%llu (expected %u/%llu), drop\n",
+			    reply_type, (unsigned long long)msg_num,
+			    expected_type, (unsigned long long)expected_msg_num);
 		return;
 	}
 
-	if (le16_to_cpu(reply->reply.ret_major) == 0)
-		enic->pf_cap_version = le32_to_cpu(reply->version);
-	else
-		netdev_warn(enic->netdev,
-			    "MBOX: PF rejected capability request: %u/%u\n",
-			    le16_to_cpu(reply->reply.ret_major),
-			    le16_to_cpu(reply->reply.ret_minor));
-	complete(&enic->mbox_comp);
-}
-
-static void enic_mbox_vf_handle_register_reply(struct enic *enic,
-					       void *payload)
-{
-	struct enic_mbox_vf_register_reply_msg *reply = payload;
-
-	if (READ_ONCE(enic->mbox_expected_reply) != ENIC_MBOX_VF_REGISTER_REPLY) {
-		netdev_warn(enic->netdev,
-			    "MBOX: stale register reply (expected %u), drop\n",
-			    READ_ONCE(enic->mbox_expected_reply));
-		return;
-	}
+	if (!ret_major) {
+		switch (reply_type) {
+		case ENIC_MBOX_VF_CAPABILITY_REPLY: {
+			struct enic_mbox_vf_capability_reply_msg *cap = payload;
 
-	if (le16_to_cpu(reply->reply.ret_major)) {
-		netdev_warn(enic->netdev,
-			    "MBOX: VF register rejected by PF: %u/%u\n",
-			    le16_to_cpu(reply->reply.ret_major),
-			    le16_to_cpu(reply->reply.ret_minor));
-	} else {
-		enic->vf_registered = true;
+			WRITE_ONCE(enic->pf_cap_version,
+				   le32_to_cpu(cap->version));
+			break;
+		}
+		case ENIC_MBOX_VF_REGISTER_REPLY:
+			WRITE_ONCE(enic->vf_registered, true);
+			break;
+		case ENIC_MBOX_VF_UNREGISTER_REPLY:
+			WRITE_ONCE(enic->vf_registered, false);
+			break;
+		}
 	}
+	enic->mbox_expected_reply = 0;
+	enic->mbox_expected_msg_num = 0;
 	complete(&enic->mbox_comp);
-}
-
-static void enic_mbox_vf_handle_unregister_reply(struct enic *enic,
-						 void *payload)
-{
-	struct enic_mbox_vf_register_reply_msg *reply = payload;
+	spin_unlock_bh(&enic->mbox_state_lock);
 
-	if (READ_ONCE(enic->mbox_expected_reply) != ENIC_MBOX_VF_UNREGISTER_REPLY) {
+	if (ret_major)
 		netdev_warn(enic->netdev,
-			    "MBOX: stale unregister reply (expected %u), drop\n",
-			    READ_ONCE(enic->mbox_expected_reply));
-		return;
-	}
-
-	if (le16_to_cpu(reply->reply.ret_major)) {
-		netdev_warn(enic->netdev,
-			    "MBOX: VF unregister rejected by PF: %u/%u\n",
-			    le16_to_cpu(reply->reply.ret_major),
-			    le16_to_cpu(reply->reply.ret_minor));
-	} else {
-		enic->vf_registered = false;
-	}
-	complete(&enic->mbox_comp);
+			    "MBOX: PF rejected reply type %u: %u/%u\n",
+			    reply_type, ret_major,
+			    le16_to_cpu(reply->ret_minor));
 }
 
-static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload)
+static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload,
+					   u64 msg_num)
 {
 	struct enic_mbox_pf_link_state_notif_msg *notif = payload;
 	struct enic_mbox_pf_link_state_ack_msg ack = {};
@@ -423,8 +470,8 @@ static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload)
 	}
 	spin_unlock_bh(&enic->vf_link_state_lock);
 
-	err = enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_ACK,
-				 ENIC_MBOX_DST_PF, &ack, sizeof(ack));
+	err = enic_mbox_send_reply(enic, ENIC_MBOX_PF_LINK_STATE_ACK,
+				   ENIC_MBOX_DST_PF, &ack, sizeof(ack), msg_num);
 	if (err && net_ratelimit())
 		netdev_warn(enic->netdev,
 			    "MBOX: failed to send link state ACK: %d\n", err);
@@ -468,6 +515,8 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 				     struct enic_mbox_hdr *hdr, void *payload,
 				     u16 payload_len)
 {
+	u64 msg_num = le64_to_cpu(hdr->msg_num);
+
 	switch (hdr->msg_type) {
 	case ENIC_MBOX_VF_CAPABILITY_REPLY: {
 		size_t exp = sizeof(struct enic_mbox_vf_capability_reply_msg);
@@ -475,7 +524,7 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
 					     payload_len, exp))
 			return;
-		enic_mbox_vf_handle_capability_reply(enic, payload);
+		enic_mbox_vf_handle_reply(enic, hdr->msg_type, payload, msg_num);
 		break;
 	}
 	case ENIC_MBOX_VF_REGISTER_REPLY: {
@@ -484,7 +533,7 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
 					     payload_len, exp))
 			return;
-		enic_mbox_vf_handle_register_reply(enic, payload);
+		enic_mbox_vf_handle_reply(enic, hdr->msg_type, payload, msg_num);
 		break;
 	}
 	case ENIC_MBOX_VF_UNREGISTER_REPLY: {
@@ -493,7 +542,7 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
 					     payload_len, exp))
 			return;
-		enic_mbox_vf_handle_unregister_reply(enic, payload);
+		enic_mbox_vf_handle_reply(enic, hdr->msg_type, payload, msg_num);
 		break;
 	}
 	case ENIC_MBOX_PF_LINK_STATE_NOTIF: {
@@ -502,7 +551,7 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
 					     payload_len, exp))
 			return;
-		enic_mbox_vf_handle_link_state(enic, payload);
+		enic_mbox_vf_handle_link_state(enic, payload, msg_num);
 		break;
 	}
 	default:
@@ -571,32 +620,31 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 int enic_mbox_vf_capability_check(struct enic *enic)
 {
 	struct enic_mbox_vf_capability_msg req = {};
+	u32 version;
 	int err;
 
-	enic->pf_cap_version = 0;
-	reinit_completion(&enic->mbox_comp);
-	WRITE_ONCE(enic->mbox_expected_reply, ENIC_MBOX_VF_CAPABILITY_REPLY);
+	WRITE_ONCE(enic->pf_cap_version, 0);
 	req.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
 
-	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REQUEST,
-				 ENIC_MBOX_DST_PF, &req, sizeof(req));
-	if (err) {
-		WRITE_ONCE(enic->mbox_expected_reply, 0);
+	err = enic_mbox_vf_send_request(enic,
+					ENIC_MBOX_VF_CAPABILITY_REQUEST,
+					ENIC_MBOX_VF_CAPABILITY_REPLY,
+					&req, sizeof(req));
+	if (err)
 		return err;
-	}
 
 	err = enic_mbox_wait_reply(enic, 3000);
-	WRITE_ONCE(enic->mbox_expected_reply, 0);
+	version = READ_ONCE(enic->pf_cap_version);
 	if (err) {
 		netdev_warn(enic->netdev,
 			    "MBOX: no capability reply from PF\n");
 		return err;
 	}
 
-	if (enic->pf_cap_version < ENIC_MBOX_CAP_VERSION_1) {
+	if (version < ENIC_MBOX_CAP_VERSION_1) {
 		netdev_warn(enic->netdev,
 			    "MBOX: PF rejected capability request or reported unsupported version %u\n",
-			    enic->pf_cap_version);
+			    version);
 		return -EOPNOTSUPP;
 	}
 
@@ -605,28 +653,25 @@ int enic_mbox_vf_capability_check(struct enic *enic)
 
 int enic_mbox_vf_register(struct enic *enic)
 {
+	bool registered;
 	int err;
 
-	enic->vf_registered = false;
-	reinit_completion(&enic->mbox_comp);
-	WRITE_ONCE(enic->mbox_expected_reply, ENIC_MBOX_VF_REGISTER_REPLY);
+	WRITE_ONCE(enic->vf_registered, false);
 
-	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REQUEST,
-				 ENIC_MBOX_DST_PF, NULL, 0);
-	if (err) {
-		WRITE_ONCE(enic->mbox_expected_reply, 0);
+	err = enic_mbox_vf_send_request(enic, ENIC_MBOX_VF_REGISTER_REQUEST,
+					ENIC_MBOX_VF_REGISTER_REPLY, NULL, 0);
+	if (err)
 		return err;
-	}
 
 	err = enic_mbox_wait_reply(enic, 3000);
-	WRITE_ONCE(enic->mbox_expected_reply, 0);
+	registered = READ_ONCE(enic->vf_registered);
 	if (err) {
 		netdev_warn(enic->netdev,
 			    "MBOX: VF registration with PF timed out\n");
 		return err;
 	}
 
-	if (!enic->vf_registered)
+	if (!registered)
 		return -ENODEV;
 
 	return 0;
@@ -634,43 +679,48 @@ int enic_mbox_vf_register(struct enic *enic)
 
 int enic_mbox_vf_unregister(struct enic *enic)
 {
+	bool registered;
 	int err;
 
-	if (!enic->vf_registered)
+	if (!READ_ONCE(enic->vf_registered))
 		return 0;
 
-	reinit_completion(&enic->mbox_comp);
-	WRITE_ONCE(enic->mbox_expected_reply, ENIC_MBOX_VF_UNREGISTER_REPLY);
-
-	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REQUEST,
-				 ENIC_MBOX_DST_PF, NULL, 0);
-	if (err) {
-		WRITE_ONCE(enic->mbox_expected_reply, 0);
+	err = enic_mbox_vf_send_request(enic,
+					ENIC_MBOX_VF_UNREGISTER_REQUEST,
+					ENIC_MBOX_VF_UNREGISTER_REPLY,
+					NULL, 0);
+	if (err)
 		return err;
-	}
 
 	err = enic_mbox_wait_reply(enic, 3000);
-	WRITE_ONCE(enic->mbox_expected_reply, 0);
+	registered = READ_ONCE(enic->vf_registered);
 	if (err)
 		return err;
-	if (enic->vf_registered)
+	if (registered)
 		return -EACCES;
 	return 0;
 }
 
 void enic_mbox_init(struct enic *enic)
 {
-	/* mbox_lock and mbox_comp must be initialized exactly once per
+	bool reinit = enic->mbox_initialized;
+
+	/* MBOX locks and mbox_comp must be initialized exactly once per
 	 * device lifetime; the PF sriov_configure path can re-enter this
 	 * on each enable cycle where these primitives are already set up.
 	 */
-	if (!enic->mbox_initialized) {
+	if (!reinit) {
 		mutex_init(&enic->mbox_lock);
 		init_completion(&enic->mbox_comp);
+		spin_lock_init(&enic->mbox_state_lock);
+		enic->mbox_msg_num = 0;
 		enic->mbox_initialized = true;
 	} else {
 		reinit_completion(&enic->mbox_comp);
 	}
-	enic->mbox_msg_num = 0;
+	spin_lock_bh(&enic->mbox_state_lock);
+	enic->mbox_expected_reply = 0;
+	enic->mbox_expected_msg_num = 0;
+	spin_unlock_bh(&enic->mbox_state_lock);
 	enic->admin_rq_handler = enic_mbox_recv_handler;
 }

-- 
2.43.0

