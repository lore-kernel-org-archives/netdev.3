Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415F5616DD;
	Tue, 29 Sep 2026 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708395; cv=none; b=mmEk5GrZ56YZfJvxVAejKgoeAqc9D01JRd11f9mmzOHhieBZcNP/e0HK0N1mv19j3+PYx4PXrTD/V+7ejBpKgCDomLgNTmhpTa1yali6JoiyJgYFKo1xDOCTmILbOmblDLW/8nauUw5K6avl/kG+7kgaaCN2wcHy9yiyXi2uKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708395; c=relaxed/simple;
	bh=KrW3Lh97Aq5afQZMepa2zbYhhdQ5Cxyr+9JxwyNWnk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdfJBgoeOIEEDecB+AQ8O0eqAaCPOwBULRWe40o4d3urm8gBqRey4CQ+noLxsy5yvCouA7FV6AZ2ufUnjErbJQMRDGTAiC6h4mr6Ue1zPHOVjGsqp8R87OkhyHX+aOhRD0+3S8EXb9jNVrIazVGSRm/tIvPDYw/ybSQ/MqjdUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=YAaX7DG8; arc=none smtp.client-ip=173.37.86.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="YAaX7DG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=27089; q=dns/txt;
  s=iport01; t=1790708388; x=1791917988;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XfhZNdCZlIZIW2vokIKnBcGE86Ap58xaFqLkyAfmef8=;
  b=YAaX7DG8N9MBYeBQtAikIJwkhhwwKwrRn1jkc5EtDIPdUj5v0DBa6jo6
   OwIj+I4X8cq3GfjxpZpd0ZFNlLgh0PngEuv7qhg7/ojiNoKJXg8xBOPuS
   20sKAZEm2uDS0VILQyRRFkoYBLiahLQOe4SKVEXafjEtqaXiMtaRy0XPX
   jzqutT037UeitXhbb5sR4GLIjR4DAb+JzwuwrQ92lx7aRGSLhd6N3fjW4
   pKb7zgizX+9LR6msK5x6/F+F1AYqy5sHAB4SqKh1xgMymLSTY5ixlhyPf
   LXJEilqJ+QgRTQoFrSb9YaFcX0xiduq61RqQqUecCRzk6DSGZC+Y0/v6u
   Q==;
X-CSE-ConnectionGUID: PCjlcQnEQt+dkX1puWVboA==
X-CSE-MsgGUID: 0JjDLxT9Rf6gpFIGs+LDkQ==
X-IPAS-Result: =?us-ascii?q?A0AaAADCCbxq/4v/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBglaBVUNJhFeIG4c3giGRTIxRFIFqDwEBAQ9RBAEBghKCcwKOCAImN?=
 =?us-ascii?q?AkOAQIEAwIDAQEBAQEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGXJATAgEDGgkEU?=
 =?us-ascii?q?hAlAiYCAkYQBgESgwKCdQPBQXp/M4EBhH7ZSoFoAQsUAYEKLgGFcYJtAYFxh?=
 =?us-ascii?q?Ag7hEEnG4FJRIEVg2mEHwqDdYJqBIMcEoMnkgEJP4ECHANZLAFVEw0KCwcFY?=
 =?us-ascii?q?VIzAyAKCxISGBUCFB0SDwQWMh1wDCcSLBcvWBsGBYEddRQEE4IZIxk2eoEJX?=
 =?us-ascii?q?oErKWABEBeBB4IHAoJUggACAUlBDgdFUwklRRJHJiIIEgkBExowC4EbOD4JK?=
 =?us-ascii?q?D0YDUgRLDcGDxkEPQFuB5A3HoFuYAsGAQcPZQkLQj0DKgFmGgEBSpJqKwE4g?=
 =?us-ascii?q?zyNX2uBNZ9ahCiBZogsl2Qzl2eTCJkII6NJBhhQhGmBaDyBWTMaCBsVgyJTG?=
 =?us-ascii?q?Q+OLhaTHQG8eycyPgEHAgcPAoFzkAIPFweBTwEB?=
IronPort-Data: A9a23:hc1+S6KL1XQ64ifrFE+RA5QlxSXFcZb7ZxGr2PjKsXjdYENS1WMAy
 mZLUWiHOKmINzChKIpwO9ix8B4G7ZXXy4Q3SAEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea+Uf1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH9imQlajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1WJ0MyNrQe199rQm1Nx
 aUANQ8zZBeq0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBV7AtQIvIROPB4towMDUY358VW62BI
 ZBENHw2N0Wojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjeK8bIOMKoDWLSlTth66p
 E7i71ioOB9EO8Sx6BWesVaAhdaayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa+0usQd3wGRa/pRasvhkGXsF4EOAg7gyJjK3O7G6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5aJ4qfC13Et
 38elo3GtqYFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz0k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:efNuP6t9KGjbt//yXn5dEYPo7skDgNV00zEX/kB9WHVpmwKj5q
 STdZMgtCMc6Qx+ZJhOo7290cW7K080sKQFg7X5Xo3MYOCZgguVxehZhOOI/9SjIVycygc378
 tdmsZFebjNJGk/oMrk7Ay/Cto6hPuK4MmT9J7j5kYoYA10Z6Rn9gtjTjyaHEp/WRVcCfMCZf
 yhD7J81l2dUEVSSNinDX8YWOWGjdjKmJX6JSMiPXccmXGzZffC0s+BL/BetS1uKA9y/Q==
X-Talos-CUID: 9a23:xJk3K2GAZStAhzbvqmJf30wQEfkjX0TBj3vTExagFFlXQrq8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AEr3TGQ/P8WNEHQGOuzQ1zteQf59K4YiKGHxcq5t?=
 =?us-ascii?q?YtNGqFANreBOxjw3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,130,1787011200"; 
   d="scan'208";a="529411844"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Sep 2026 18:58:38 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 9852A180000F5;
	Tue, 29 Sep 2026 18:58:37 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 29 Sep 2026 11:58:07 -0700
Subject: [PATCH net-next v2 4/6] enic: validate V2 VF configuration replies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-4-5962c10061b2@cisco.com>
References: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
In-Reply-To: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790708314; l=28071;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=KrW3Lh97Aq5afQZMepa2zbYhhdQ5Cxyr+9JxwyNWnk0=;
 b=6B0AQOATi3t9+FU+nnYCZL7/d6wyofQE9iGW48crk2BWlK+4nQ2bxXEe2d/lUqyCyxfj1yCpA
 8Vuck59ntktCFSOKPPrfZMk98lRBMcPuWucs0doFskhgYdUn+nNOT/z
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-02.cisco.com

Add the established V2 mailbox operations for MAC filters,
administrative-MAC notifications, and packet-filter settings. Keep request
buffers alive until the VF request completes so detailed replies can be
checked entry by entry.

Validate message framing, echoed operations, result counts,
operation-specific idempotent results, and applied packet-filter flags
before publishing a reply. If a reply is malformed or contradictory, or
the PF reports that the VF is no longer registered, the VF can no longer
trust that its state matches the PF. Require a new VF registration before
accepting traffic again.

The protocol's ret_minor field counts non-SKIPPED per-entry result codes,
including the idempotent DUPLICATE and NOT_FOUND outcomes. SKIPPED remains
an operation-specific policy result but is not part of that aggregate
count.

Return stable policy errors to callers while retaining retry semantics for
operations that made no state change. A coherent top-level MAC-operation
failure remains an ordinary error. Reserve reconnect for malformed or
indeterminate replies and explicit registration loss.

This patch adds only the VF side of these operations. The in-tree V2 PF
enable path remains dormant because enic_driver does not yet register
.sriov_configure. A future PF activation series must implement PF-side
handling for the MAC-address and packet-filter mailbox requests, including
the VF policy checks, before wiring that callback.

Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   9 +
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 490 +++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h |  82 +++++
 3 files changed, 563 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 4285b63083cc..ef8332138c5a 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -239,6 +239,8 @@ enum enic_vf_type {
 };
 
 /* Per-instance private data structure */
+struct enic_mac_addr;
+
 struct enic {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -365,6 +367,13 @@ struct enic {
 	unsigned int vf_ack_count;
 	u64 mbox_expected_msg_num;
 	u8 mbox_expected_reply;
+	int mbox_reply_status;
+	u16 mbox_reply_filter_flags;
+	/* The request mutex keeps this caller-owned reply array alive until the
+	 * matching reply handler has copied all per-address result flags.
+	 */
+	struct enic_mac_addr *mbox_reply_mac_addrs;
+	u16 mbox_reply_mac_count;
 	bool mbox_initialized;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 30a5f6fda676..265b58cd39be 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -6,6 +6,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/completion.h>
+#include <linux/etherdevice.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -377,6 +378,82 @@ static void enic_mbox_vf_request_finish(struct enic *enic)
 	mutex_unlock(&enic->vf_mbox_request_lock);
 }
 
+/* Return with mbox_state_lock held when this handler owns the reply. */
+static bool enic_mbox_vf_reply_claim(struct enic *enic, u8 reply_type,
+				     u64 msg_num, u8 *expected)
+{
+	spin_lock_bh(&enic->mbox_state_lock);
+	*expected = enic->mbox_expected_reply;
+	if (*expected == reply_type &&
+	    enic->mbox_expected_msg_num == msg_num)
+		return true;
+	spin_unlock_bh(&enic->mbox_state_lock);
+
+	return false;
+}
+
+enum enic_mbox_vf_reply_recovery {
+	ENIC_MBOX_VF_REPLY_OK,
+	ENIC_MBOX_VF_REPLY_RECONNECT,
+	ENIC_MBOX_VF_REPLY_REGISTRATION_LOST,
+};
+
+static int
+enic_mbox_vf_classify_reply(bool malformed, u16 ret_major,
+			    enum enic_mbox_vf_reply_recovery *recovery)
+{
+	*recovery = ENIC_MBOX_VF_REPLY_OK;
+	if (malformed) {
+		*recovery = ENIC_MBOX_VF_REPLY_RECONNECT;
+		return -EIO;
+	}
+	/* Some deployed peers return a negative errno in this 16-bit field.
+	 * Interpret protocol bits only when no unknown bits are present; otherwise
+	 * an errno such as -EINVAL could accidentally look like registration loss.
+	 */
+	if (!(ret_major & ~ENIC_MBOX_ERR_MASK) &&
+	    (ret_major & ENIC_MBOX_ERR_VF_NOT_REGISTERED)) {
+		*recovery = ENIC_MBOX_VF_REPLY_REGISTRATION_LOST;
+		return -ENODEV;
+	}
+	if (!(ret_major & ~ENIC_MBOX_ERR_MASK) &&
+	    (ret_major & ENIC_MBOX_ERR_MSG_NOT_SUPPORTED))
+		return -EOPNOTSUPP;
+	if (ret_major)
+		return -EIO;
+
+	return 0;
+}
+
+static void
+enic_mbox_vf_recover_reply_locked(struct enic *enic,
+				  enum enic_mbox_vf_reply_recovery recovery)
+{
+	bool registration_lost;
+
+	lockdep_assert_held(&enic->mbox_state_lock);
+
+	if (recovery != ENIC_MBOX_VF_REPLY_OK) {
+		registration_lost =
+			recovery == ENIC_MBOX_VF_REPLY_REGISTRATION_LOST;
+		enic_mbox_vf_mark_reconnect_locked(enic, registration_lost);
+	}
+}
+
+static void enic_mbox_vf_reply_complete(struct enic *enic)
+{
+	lockdep_assert_held(&enic->mbox_state_lock);
+	enic->mbox_expected_reply = 0;
+	enic->mbox_expected_msg_num = 0;
+	/* Publish completion before releasing the state lock.  A waiter that
+	 * hit the timeout boundary may otherwise see the claimed state, finish the
+	 * request, and let a new request reinitialize this completion before the
+	 * old handler signals it.
+	 */
+	complete(&enic->mbox_comp);
+	spin_unlock_bh(&enic->mbox_state_lock);
+}
+
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
 {
 	struct enic_mbox_pf_link_state_notif_msg notif = {};
@@ -552,23 +629,21 @@ static void enic_mbox_vf_handle_reply(struct enic *enic, u8 reply_type,
 				      void *payload, u64 msg_num)
 {
 	struct enic_mbox_generic_reply *reply = payload;
+	enum enic_mbox_vf_reply_recovery recovery;
 	u16 ret_major = le16_to_cpu(reply->ret_major);
-	u64 expected_msg_num;
-	u8 expected_type;
+	u8 expected;
+	int status;
 
-	spin_lock_bh(&enic->mbox_state_lock);
-	expected_type = enic->mbox_expected_reply;
-	expected_msg_num = enic->mbox_expected_msg_num;
-	if (expected_type != reply_type || expected_msg_num != msg_num) {
-		spin_unlock_bh(&enic->mbox_state_lock);
+	status = enic_mbox_vf_classify_reply(false, ret_major, &recovery);
+	if (!enic_mbox_vf_reply_claim(enic, reply_type, msg_num, &expected)) {
 		netdev_warn(enic->netdev,
-			    "MBOX: stale reply %u/%llu (expected %u/%llu), drop\n",
+			    "MBOX: stale reply %u/%llu (expected %u), drop\n",
 			    reply_type, (unsigned long long)msg_num,
-			    expected_type, (unsigned long long)expected_msg_num);
+			    expected);
 		return;
 	}
 
-	if (!ret_major) {
+	if (!status) {
 		switch (reply_type) {
 		case ENIC_MBOX_VF_CAPABILITY_REPLY: {
 			struct enic_mbox_vf_capability_reply_msg *cap = payload;
@@ -585,16 +660,166 @@ static void enic_mbox_vf_handle_reply(struct enic *enic, u8 reply_type,
 			break;
 		}
 	}
-	enic->mbox_expected_reply = 0;
-	enic->mbox_expected_msg_num = 0;
-	complete(&enic->mbox_comp);
-	spin_unlock_bh(&enic->mbox_state_lock);
+	enic_mbox_vf_recover_reply_locked(enic, recovery);
+	WRITE_ONCE(enic->mbox_reply_status, status);
+	enic_mbox_vf_reply_complete(enic);
 
 	if (ret_major)
 		netdev_warn(enic->netdev,
 			    "MBOX: PF rejected reply type %u: %u/%u\n",
 			    reply_type, ret_major,
 			    le16_to_cpu(reply->ret_minor));
+	if (recovery != ENIC_MBOX_VF_REPLY_OK)
+		enic_mbox_vf_kick_recovery(enic);
+}
+
+static bool enic_mbox_vf_mac_reply_matches(const struct enic_mac_addr *request,
+					   const struct enic_mac_addr *reply)
+{
+	u16 request_flags = le16_to_cpu(request->flags);
+	u16 reply_flags = le16_to_cpu(reply->flags);
+	u16 idempotent_result = reply_flags &
+		(ENIC_MAC_ADDR_FLAG_DUPLICATE |
+		 ENIC_MAC_ADDR_FLAG_NOT_FOUND);
+	u16 result = reply_flags & ENIC_MAC_ADDR_FLAG_REPLY_MASK;
+	u16 expected_result;
+
+	if (!ether_addr_equal(request->addr, reply->addr) ||
+	    (request_flags & ENIC_MAC_ADDR_FLAG_REQUEST_MASK) !=
+	    (reply_flags & ENIC_MAC_ADDR_FLAG_REQUEST_MASK))
+		return false;
+	if (hweight16(result) > 1)
+		return false;
+
+	/* DUPLICATE is a successful ADD result and NOT_FOUND is a successful
+	 * DELETE result.  Neither is valid for the opposite operation, and a
+	 * reply cannot report both outcomes for one entry.
+	 */
+	expected_result = request_flags & ENIC_MAC_ADDR_FLAG_ADD ?
+		ENIC_MAC_ADDR_FLAG_DUPLICATE :
+		ENIC_MAC_ADDR_FLAG_NOT_FOUND;
+
+	return !idempotent_result || idempotent_result == expected_result;
+}
+
+static void enic_mbox_vf_handle_add_del_mac_reply(struct enic *enic,
+						  void *payload, u16 msg_len,
+						  u64 msg_num)
+{
+	struct enic_mbox_vf_add_del_mac_reply_msg *reply = payload;
+	enum enic_mbox_vf_reply_recovery recovery;
+	u16 reported_errors = 0;
+	u16 num_addrs = 0;
+	u16 ret_minor = 0;
+	u16 ret_major = 0;
+	u8 expected;
+	unsigned int i;
+	int status;
+
+	if (msg_len < sizeof(*reply)) {
+		status = enic_mbox_vf_classify_reply(true, 0, &recovery);
+	} else {
+		ret_major = le16_to_cpu(reply->reply.ret_major);
+		ret_minor = le16_to_cpu(reply->reply.ret_minor);
+		status = enic_mbox_vf_classify_reply(false, ret_major,
+						     &recovery);
+	}
+	if (status)
+		goto claim;
+
+	num_addrs = le16_to_cpu(reply->num_addrs);
+	if (!num_addrs || num_addrs > ENIC_MBOX_MAX_MAC_OPS ||
+	    struct_size(reply, mac_addr, num_addrs) > msg_len) {
+		status = enic_mbox_vf_classify_reply(true, 0, &recovery);
+		goto claim;
+	}
+
+claim:
+	if (!enic_mbox_vf_reply_claim(enic, ENIC_MBOX_VF_ADD_DEL_MAC_REPLY,
+				      msg_num, &expected))
+		return;
+	if (!status &&
+	    (num_addrs != enic->mbox_reply_mac_count ||
+	     !enic->mbox_reply_mac_addrs)) {
+		status = enic_mbox_vf_classify_reply(true, 0, &recovery);
+	} else if (!status) {
+		/* A detailed reply corresponds entry-for-entry with the request.
+		 * Validate the echoed request fields and operation-specific results
+		 * before exposing result flags to the waiting caller.
+		 */
+		for (i = 0; i < num_addrs; i++) {
+			struct enic_mac_addr *request =
+				&enic->mbox_reply_mac_addrs[i];
+			u16 flags = le16_to_cpu(reply->mac_addr[i].flags);
+
+			if (!enic_mbox_vf_mac_reply_matches(request,
+							    &reply->mac_addr[i])) {
+				status = enic_mbox_vf_classify_reply(true, 0,
+								     &recovery);
+				break;
+			}
+			if (flags & ENIC_MAC_ADDR_FLAG_INDETERMINATE_MASK) {
+				status = -EIO;
+				recovery = ENIC_MBOX_VF_REPLY_RECONNECT;
+				break;
+			}
+			if ((flags & ENIC_MAC_ADDR_FLAG_REPLY_MASK) &&
+			    !(flags & ENIC_MAC_ADDR_FLAG_SKIPPED))
+				reported_errors++;
+		}
+		if (!status && reported_errors != ret_minor)
+			status = enic_mbox_vf_classify_reply(true, 0,
+							     &recovery);
+
+		if (!status)
+			for (i = 0; i < num_addrs; i++)
+				enic->mbox_reply_mac_addrs[i].flags =
+					reply->mac_addr[i].flags;
+	}
+	/* After a malformed reply, the VF cannot trust that its state matches the
+	 * PF. VF_NOT_REGISTERED means the PF removed all VF state. Both require a
+	 * new registration; an ordinary policy rejection does not.
+	 */
+	enic_mbox_vf_recover_reply_locked(enic, recovery);
+	WRITE_ONCE(enic->mbox_reply_status, status);
+	enic_mbox_vf_reply_complete(enic);
+	if (recovery != ENIC_MBOX_VF_REPLY_OK)
+		enic_mbox_vf_kick_recovery(enic);
+}
+
+static void enic_mbox_vf_handle_set_pkt_filter_reply(struct enic *enic,
+						     void *payload, u16 msg_len,
+						     u64 msg_num)
+{
+	struct enic_mbox_vf_set_pkt_filter_reply_msg *reply = payload;
+	enum enic_mbox_vf_reply_recovery recovery;
+	u16 applied = 0;
+	u16 ret_major = 0;
+	u8 expected;
+	int status;
+
+	if (msg_len < sizeof(*reply)) {
+		status = enic_mbox_vf_classify_reply(true, 0, &recovery);
+	} else {
+		ret_major = le16_to_cpu(reply->reply.ret_major);
+		status = enic_mbox_vf_classify_reply(false, ret_major,
+						     &recovery);
+		if (status && (ret_major & ~ENIC_MBOX_ERR_MASK))
+			recovery = ENIC_MBOX_VF_REPLY_RECONNECT;
+	}
+	if (!status)
+		applied = le16_to_cpu(reply->reply.ret_minor);
+
+	if (!enic_mbox_vf_reply_claim(enic,
+				      ENIC_MBOX_VF_SET_PKT_FILTER_REPLY,
+				      msg_num, &expected))
+		return;
+	enic_mbox_vf_recover_reply_locked(enic, recovery);
+	WRITE_ONCE(enic->mbox_reply_status, status);
+	WRITE_ONCE(enic->mbox_reply_filter_flags, applied);
+	enic_mbox_vf_reply_complete(enic);
+	if (recovery != ENIC_MBOX_VF_REPLY_OK)
+		enic_mbox_vf_kick_recovery(enic);
 }
 
 static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload,
@@ -680,6 +905,34 @@ static bool enic_mbox_vf_payload_ok(struct enic *enic, u8 msg_type,
 	return true;
 }
 
+static void enic_mbox_vf_malformed_msg(struct enic *enic, u8 msg_type,
+				       u64 msg_num)
+{
+	u8 expected;
+
+	switch (msg_type) {
+	case ENIC_MBOX_PF_LINK_STATE_NOTIF:
+	case ENIC_MBOX_PF_SET_ADMIN_MAC_NOTIF:
+		enic_mbox_vf_require_reconnect(enic);
+		return;
+	case ENIC_MBOX_VF_CAPABILITY_REPLY:
+	case ENIC_MBOX_VF_REGISTER_REPLY:
+	case ENIC_MBOX_VF_UNREGISTER_REPLY:
+	case ENIC_MBOX_VF_ADD_DEL_MAC_REPLY:
+	case ENIC_MBOX_VF_SET_PKT_FILTER_REPLY:
+		break;
+	default:
+		return;
+	}
+
+	if (!enic_mbox_vf_reply_claim(enic, msg_type, msg_num, &expected))
+		return;
+	enic_mbox_vf_mark_reconnect_locked(enic, false);
+	WRITE_ONCE(enic->mbox_reply_status, -EIO);
+	enic_mbox_vf_reply_complete(enic);
+	enic_mbox_vf_kick_recovery(enic);
+}
+
 static void enic_mbox_vf_process_msg(struct enic *enic,
 				     struct enic_mbox_hdr *hdr, void *payload,
 				     u16 payload_len)
@@ -691,8 +944,10 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 		size_t exp = sizeof(struct enic_mbox_vf_capability_reply_msg);
 
 		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
-					     payload_len, exp))
+					     payload_len, exp)) {
+			enic_mbox_vf_malformed_msg(enic, hdr->msg_type, msg_num);
 			return;
+		}
 		enic_mbox_vf_handle_reply(enic, hdr->msg_type, payload, msg_num);
 		break;
 	}
@@ -700,8 +955,10 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
 
 		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
-					     payload_len, exp))
+					     payload_len, exp)) {
+			enic_mbox_vf_malformed_msg(enic, hdr->msg_type, msg_num);
 			return;
+		}
 		enic_mbox_vf_handle_reply(enic, hdr->msg_type, payload, msg_num);
 		break;
 	}
@@ -709,8 +966,10 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
 
 		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
-					     payload_len, exp))
+					     payload_len, exp)) {
+			enic_mbox_vf_malformed_msg(enic, hdr->msg_type, msg_num);
 			return;
+		}
 		enic_mbox_vf_handle_reply(enic, hdr->msg_type, payload, msg_num);
 		break;
 	}
@@ -718,11 +977,21 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
 		size_t exp = sizeof(struct enic_mbox_pf_link_state_notif_msg);
 
 		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
-					     payload_len, exp))
+					     payload_len, exp)) {
+			enic_mbox_vf_malformed_msg(enic, hdr->msg_type, msg_num);
 			return;
+		}
 		enic_mbox_vf_handle_link_state(enic, payload, msg_num);
 		break;
 	}
+	case ENIC_MBOX_VF_ADD_DEL_MAC_REPLY:
+		enic_mbox_vf_handle_add_del_mac_reply(enic, payload,
+						      payload_len, msg_num);
+		break;
+	case ENIC_MBOX_VF_SET_PKT_FILTER_REPLY:
+		enic_mbox_vf_handle_set_pkt_filter_reply(enic, payload,
+							 payload_len, msg_num);
+		break;
 	default:
 		netdev_dbg(enic->netdev,
 			   "MBOX: VF unhandled msg type %u\n",
@@ -762,6 +1031,10 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 			netdev_warn(enic->netdev,
 				    "MBOX: invalid msg_len %u (buf len %u)\n",
 				    msg_len, len);
+		if (!enic->vf_state &&
+		    le16_to_cpu(hdr->src_vnic_id) == ENIC_MBOX_DST_PF)
+			enic_mbox_vf_malformed_msg(enic, hdr->msg_type,
+						   le64_to_cpu(hdr->msg_num));
 		return;
 	}
 
@@ -792,10 +1065,12 @@ int enic_mbox_vf_capability_check(struct enic *enic)
 {
 	struct enic_mbox_vf_capability_msg req = {};
 	u32 version;
+	int status;
 	int err;
 
 	enic_mbox_vf_request_start(enic);
 	WRITE_ONCE(enic->pf_cap_version, 0);
+	WRITE_ONCE(enic->mbox_reply_status, 0);
 	req.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
 
 	err = enic_mbox_vf_send_request(enic,
@@ -809,12 +1084,15 @@ int enic_mbox_vf_capability_check(struct enic *enic)
 
 	err = enic_mbox_wait_reply(enic, 3000);
 	version = READ_ONCE(enic->pf_cap_version);
+	status = READ_ONCE(enic->mbox_reply_status);
 	enic_mbox_vf_request_finish(enic);
 	if (err) {
 		netdev_warn(enic->netdev,
 			    "MBOX: no capability reply from PF\n");
 		return err;
 	}
+	if (status)
+		return status;
 
 	if (version < ENIC_MBOX_CAP_VERSION_1) {
 		netdev_warn(enic->netdev,
@@ -829,10 +1107,12 @@ int enic_mbox_vf_capability_check(struct enic *enic)
 int enic_mbox_vf_register(struct enic *enic)
 {
 	bool registered;
+	int status;
 	int err;
 
 	enic_mbox_vf_request_start(enic);
 	WRITE_ONCE(enic->vf_registered, false);
+	WRITE_ONCE(enic->mbox_reply_status, 0);
 
 	err = enic_mbox_vf_send_request(enic, ENIC_MBOX_VF_REGISTER_REQUEST,
 					ENIC_MBOX_VF_REGISTER_REPLY, NULL, 0);
@@ -843,12 +1123,15 @@ int enic_mbox_vf_register(struct enic *enic)
 
 	err = enic_mbox_wait_reply(enic, 3000);
 	registered = READ_ONCE(enic->vf_registered);
+	status = READ_ONCE(enic->mbox_reply_status);
 	enic_mbox_vf_request_finish(enic);
 	if (err) {
 		netdev_warn(enic->netdev,
 			    "MBOX: VF registration with PF timed out\n");
 		return err;
 	}
+	if (status)
+		return status;
 
 	if (!registered)
 		return -ENODEV;
@@ -859,15 +1142,18 @@ int enic_mbox_vf_register(struct enic *enic)
 int enic_mbox_vf_unregister(struct enic *enic)
 {
 	bool registered;
+	int status;
 	int err;
 
 	if (!READ_ONCE(enic->vf_registered))
 		return 0;
+
 	enic_mbox_vf_request_start(enic);
 	if (!READ_ONCE(enic->vf_registered)) {
 		enic_mbox_vf_request_finish(enic);
 		return 0;
 	}
+	WRITE_ONCE(enic->mbox_reply_status, 0);
 
 	err = enic_mbox_vf_send_request(enic,
 					ENIC_MBOX_VF_UNREGISTER_REQUEST,
@@ -880,14 +1166,182 @@ int enic_mbox_vf_unregister(struct enic *enic)
 
 	err = enic_mbox_wait_reply(enic, 3000);
 	registered = READ_ONCE(enic->vf_registered);
+	status = READ_ONCE(enic->mbox_reply_status);
 	enic_mbox_vf_request_finish(enic);
 	if (err)
 		return err;
+	if (status)
+		return status;
 	if (registered)
 		return -EACCES;
 	return 0;
 }
 
+int enic_mbox_vf_add_del_macs(struct enic *enic,
+			      struct enic_mac_addr *macs, u16 num_macs)
+{
+	struct enic_mbox_vf_add_del_mac_msg *req;
+	unsigned int i;
+	int status;
+	int err;
+
+	if (!READ_ONCE(enic->vf_registered) || !enic->has_admin_channel)
+		return -ENODEV;
+	if (!num_macs || num_macs > ENIC_MBOX_MAX_MAC_OPS)
+		return -EINVAL;
+
+	req = kzalloc_flex(*req, mac_addr, num_macs);
+	if (!req)
+		return -ENOMEM;
+
+	req->num_addrs = cpu_to_le16(num_macs);
+	for (i = 0; i < num_macs; i++)
+		req->mac_addr[i] = macs[i];
+
+	enic_mbox_vf_request_start(enic);
+	if (!READ_ONCE(enic->vf_registered) || !enic->has_admin_channel) {
+		err = -ENODEV;
+	} else {
+		spin_lock_bh(&enic->mbox_state_lock);
+		enic->mbox_reply_mac_addrs = macs;
+		enic->mbox_reply_mac_count = num_macs;
+		spin_unlock_bh(&enic->mbox_state_lock);
+		WRITE_ONCE(enic->mbox_reply_status, 0);
+		err = enic_mbox_vf_send_request(enic,
+						ENIC_MBOX_VF_ADD_DEL_MAC_REQUEST,
+						ENIC_MBOX_VF_ADD_DEL_MAC_REPLY,
+						req,
+						struct_size(req, mac_addr,
+							    num_macs));
+	}
+	kfree(req);
+	if (err) {
+		spin_lock_bh(&enic->mbox_state_lock);
+		enic->mbox_reply_mac_addrs = NULL;
+		enic->mbox_reply_mac_count = 0;
+		spin_unlock_bh(&enic->mbox_state_lock);
+		enic_mbox_vf_request_abort(enic);
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	status = READ_ONCE(enic->mbox_reply_status);
+	spin_lock_bh(&enic->mbox_state_lock);
+	enic->mbox_reply_mac_addrs = NULL;
+	enic->mbox_reply_mac_count = 0;
+	spin_unlock_bh(&enic->mbox_state_lock);
+	if (err) {
+		/* The PF may have updated its software ledger before a hardware
+		 * failure whose reply was lost. A repeated idempotent operation could
+		 * then appear converged while hardware state is stale, so replay from
+		 * a fresh registration generation.
+		 */
+		enic_mbox_vf_require_reconnect(enic);
+		enic_mbox_vf_request_finish(enic);
+		return err;
+	}
+	enic_mbox_vf_request_finish(enic);
+
+	return status;
+}
+
+int enic_mbox_vf_add_del_mac(struct enic *enic, const u8 *addr, bool add,
+			     bool station)
+{
+	struct enic_mac_addr mac = {};
+	u16 flags = 0;
+	int err;
+
+	ether_addr_copy(mac.addr, addr);
+	if (add)
+		flags |= ENIC_MAC_ADDR_FLAG_ADD;
+	if (station)
+		flags |= ENIC_MAC_ADDR_FLAG_STATION;
+	mac.flags = cpu_to_le16(flags);
+
+	err = enic_mbox_vf_add_del_macs(enic, &mac, 1);
+	if (err)
+		return err;
+	if (le16_to_cpu(mac.flags) & ENIC_MAC_ADDR_FLAG_ERROR_MASK)
+		return -EACCES;
+
+	return 0;
+}
+
+int enic_mbox_vf_set_pkt_filter(struct enic *enic, int directed,
+				int multicast, int broadcast,
+				int promisc, int allmulti, u16 *applied_flags)
+{
+	struct enic_mbox_vf_set_pkt_filter_msg req = {};
+	u16 applied;
+	u16 flags = 0;
+	u16 required;
+	int status;
+	int err;
+
+	if (!READ_ONCE(enic->vf_registered) || !enic->has_admin_channel)
+		return -ENODEV;
+
+	if (directed)
+		flags |= CMD_PFILTER_DIRECTED;
+	if (multicast)
+		flags |= CMD_PFILTER_MULTICAST;
+	if (broadcast)
+		flags |= CMD_PFILTER_BROADCAST;
+	if (promisc)
+		flags |= CMD_PFILTER_PROMISCUOUS;
+	if (allmulti)
+		flags |= CMD_PFILTER_ALL_MULTICAST;
+	req.flags = cpu_to_le16(flags);
+
+	enic_mbox_vf_request_start(enic);
+	if (!READ_ONCE(enic->vf_registered) || !enic->has_admin_channel) {
+		enic_mbox_vf_request_abort(enic);
+		return -ENODEV;
+	}
+	WRITE_ONCE(enic->mbox_reply_status, 0);
+	WRITE_ONCE(enic->mbox_reply_filter_flags, 0);
+
+	err = enic_mbox_vf_send_request(enic,
+					ENIC_MBOX_VF_SET_PKT_FILTER_REQUEST,
+					ENIC_MBOX_VF_SET_PKT_FILTER_REPLY,
+					&req, sizeof(req));
+	if (err) {
+		enic_mbox_vf_request_abort(enic);
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	status = READ_ONCE(enic->mbox_reply_status);
+	if (!err && !status) {
+		applied = READ_ONCE(enic->mbox_reply_filter_flags);
+		/* Directed, multicast, and broadcast are not policy-gated.  The PF
+		 * may only withhold the two broad receive modes, and may add directed
+		 * reception because it is mandatory for a usable VF.
+		 */
+		required = (flags | CMD_PFILTER_DIRECTED) &
+			   ~(CMD_PFILTER_PROMISCUOUS |
+			     CMD_PFILTER_ALL_MULTICAST);
+		if ((applied & ~(flags | CMD_PFILTER_DIRECTED)) ||
+		    (applied & required) != required) {
+			netdev_warn(enic->netdev,
+				    "MBOX: invalid packet filter reply %#x for request %#x\n",
+				    applied, flags);
+			enic_mbox_vf_require_reconnect(enic);
+			status = -EIO;
+		} else if (applied_flags) {
+			*applied_flags = applied;
+		}
+	}
+	if (err)
+		enic_mbox_vf_require_reconnect(enic);
+	enic_mbox_vf_request_finish(enic);
+	if (err)
+		return err;
+
+	return status;
+}
+
 void enic_mbox_init(struct enic *enic)
 {
 	bool reinit = enic->mbox_initialized;
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index 37bc41a900f4..5eca3a25671e 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -5,6 +5,7 @@
 #define _ENIC_MBOX_H_
 
 #include <linux/bits.h>
+#include <linux/if_ether.h>
 #include <linux/types.h>
 
 /*
@@ -22,6 +23,12 @@ enum enic_mbox_msg_type {
 	ENIC_MBOX_VF_UNREGISTER_REPLY		= 5,
 	ENIC_MBOX_PF_LINK_STATE_NOTIF		= 6,
 	ENIC_MBOX_PF_LINK_STATE_ACK		= 7,
+	ENIC_MBOX_VF_ADD_DEL_MAC_REQUEST	= 10,
+	ENIC_MBOX_VF_ADD_DEL_MAC_REPLY		= 11,
+	ENIC_MBOX_PF_SET_ADMIN_MAC_NOTIF	= 12,
+	ENIC_MBOX_PF_SET_ADMIN_MAC_ACK		= 13,
+	ENIC_MBOX_VF_SET_PKT_FILTER_REQUEST	= 14,
+	ENIC_MBOX_VF_SET_PKT_FILTER_REPLY	= 15,
 	ENIC_MBOX_MAX
 };
 
@@ -42,6 +49,9 @@ struct enic_mbox_generic_reply {
 #define ENIC_MBOX_ERR_GENERIC		BIT(0)
 #define ENIC_MBOX_ERR_VF_NOT_REGISTERED	BIT(1)
 #define ENIC_MBOX_ERR_MSG_NOT_SUPPORTED	BIT(2)
+#define ENIC_MBOX_ERR_MASK		(ENIC_MBOX_ERR_GENERIC | \
+					 ENIC_MBOX_ERR_VF_NOT_REGISTERED | \
+					 ENIC_MBOX_ERR_MSG_NOT_SUPPORTED)
 
 /* ENIC_MBOX_VF_CAPABILITY_REQUEST / _REPLY */
 #define ENIC_MBOX_CAP_VERSION_0		0
@@ -80,6 +90,71 @@ struct enic_mbox_pf_link_state_ack_msg {
 	struct enic_mbox_generic_reply ack;
 };
 
+/* ENIC_MBOX_PF_SET_ADMIN_MAC_NOTIF / _ACK */
+struct enic_mbox_pf_set_admin_mac_notif_msg {
+	u8 mac_addr[ETH_ALEN];
+	__le16 pad;
+};
+
+/* ENIC_MBOX_VF_ADD_DEL_MAC_REQUEST / _REPLY */
+#define ENIC_MAC_ADDR_FLAG_ADD		BIT(0)
+#define ENIC_MAC_ADDR_FLAG_STATION	BIT(1)
+#define ENIC_MAC_ADDR_FLAG_OVERFLOW	BIT(8)
+#define ENIC_MAC_ADDR_FLAG_DUPLICATE	BIT(9)
+#define ENIC_MAC_ADDR_FLAG_FAILED	BIT(10)
+#define ENIC_MAC_ADDR_FLAG_NOT_FOUND	BIT(11)
+#define ENIC_MAC_ADDR_FLAG_ERROR	BIT(12)
+#define ENIC_MAC_ADDR_FLAG_NOT_PERMITTED BIT(13)
+#define ENIC_MAC_ADDR_FLAG_INVALID	BIT(14)
+#define ENIC_MAC_ADDR_FLAG_SKIPPED	BIT(15)
+
+#define ENIC_MAC_ADDR_FLAG_REQUEST_MASK	GENMASK(7, 0)
+#define ENIC_MAC_ADDR_FLAG_REPLY_MASK	GENMASK(15, 8)
+#define ENIC_MAC_ADDR_FLAG_INDETERMINATE_MASK \
+	(ENIC_MAC_ADDR_FLAG_FAILED | ENIC_MAC_ADDR_FLAG_ERROR)
+#define ENIC_MAC_ADDR_FLAG_PERMANENT_MASK \
+	(ENIC_MAC_ADDR_FLAG_OVERFLOW | ENIC_MAC_ADDR_FLAG_NOT_PERMITTED | \
+	 ENIC_MAC_ADDR_FLAG_INVALID)
+#define ENIC_MAC_ADDR_FLAG_ERROR_MASK	(ENIC_MAC_ADDR_FLAG_OVERFLOW | \
+					 ENIC_MAC_ADDR_FLAG_FAILED | \
+					 ENIC_MAC_ADDR_FLAG_ERROR | \
+					 ENIC_MAC_ADDR_FLAG_NOT_PERMITTED | \
+					 ENIC_MAC_ADDR_FLAG_INVALID | \
+					 ENIC_MAC_ADDR_FLAG_SKIPPED)
+
+/* The protocol permits replacing all perfect filters and the station address
+ * in one request: one delete and one add operation for each address.
+ */
+#define ENIC_MBOX_MAX_MAC_OPS		130
+
+struct enic_mac_addr {
+	u8 addr[ETH_ALEN];
+	__le16 flags;
+};
+
+struct enic_mbox_vf_add_del_mac_msg {
+	__le16 num_addrs;
+	__le16 pad;
+	struct enic_mac_addr mac_addr[];
+};
+
+struct enic_mbox_vf_add_del_mac_reply_msg {
+	struct enic_mbox_generic_reply reply;
+	__le16 num_addrs;
+	__le16 pad;
+	struct enic_mac_addr mac_addr[];
+};
+
+/* ENIC_MBOX_VF_SET_PKT_FILTER_REQUEST / _REPLY */
+struct enic_mbox_vf_set_pkt_filter_msg {
+	__le16 flags;
+	__le16 pad;
+};
+
+struct enic_mbox_vf_set_pkt_filter_reply_msg {
+	struct enic_mbox_generic_reply reply;
+};
+
 #define ENIC_MBOX_DST_PF	0xFFFF
 
 struct enic;
@@ -95,5 +170,12 @@ void enic_mbox_vf_require_reconnect(struct enic *enic);
 int enic_mbox_vf_capability_check(struct enic *enic);
 int enic_mbox_vf_register(struct enic *enic);
 int enic_mbox_vf_unregister(struct enic *enic);
+int enic_mbox_vf_add_del_macs(struct enic *enic,
+			      struct enic_mac_addr *macs, u16 num_macs);
+int enic_mbox_vf_add_del_mac(struct enic *enic, const u8 *addr, bool add,
+			     bool station);
+int enic_mbox_vf_set_pkt_filter(struct enic *enic, int directed, int multicast,
+				int broadcast, int promisc, int allmulti,
+				u16 *applied_flags);
 
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0

