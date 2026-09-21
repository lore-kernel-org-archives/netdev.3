Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAD446853;
	Mon, 21 Sep 2026 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020899; cv=none; b=U6RUtNngZfpXgnM/oPwRZ1BIj4tCExiXg7m09kYbn/+pVHb7i/AUUNgK3yyve84b3eBLJK1Qm2jI0DUyCJ8dkBk5OVprj5LWABzifv7lW1yuAhi8xFqUaWrGJvmhBBHpIQqoAi95ajvv9fDkTHSiiLk6Rc/4RO91btGrD5/yezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020899; c=relaxed/simple;
	bh=yl4XoV0665vlNHq6lpOJ+AQRgE/loyqwM/3vx3YkqHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGwIs446wOHbD9GpPTOJ0Tb+h4gne9RjTNA5akXopjTYQO87TkV41v2Dbl+moOLH7SqbIfJF2sy6pILHhytGOVLGAuTKSiPjSl3Y3IbtVKzbr2FA4bWGVpNv9KjQjuenYX8jlgFr+mnIGUagL1e9wnz0wAlpgGW8XJb0LoE70ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=ds8przJL; arc=none smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="ds8przJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=26995; q=dns/txt;
  s=iport01; t=1790020895; x=1791230495;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=p500mn7UZLNyZQo01CgXTZQuRAXhdjLcX/kQ3vZ5y2Y=;
  b=ds8przJLaUAMfhtWFD9uQ5k0BESbe129VzuGvtSHYCwpQVNnZvofKcld
   3EQ/d+r+C2jjtlXjvbTanKnEyT0wrV3qNMXYJyFLSbnf/fTTfRXA0I8cH
   tHu7JaJk2ifb4Gs5quRcsO8kodtp1y2SHfzykjMhNTA9tvRAx5zIoDavU
   JJFVbmkGZdTaRMHa81uYpzOm6jrklOUX0ihJDfuktwbj3FcBLvDm70IQc
   RoHKCGcStEZEcExXNyh64Vq+6fB29ZKDC25M83SXaMq3eXZtgqtcjvHMR
   gZjVXZbNgepA9PV9bsvjv+xMtFDmqh/4IIBwmFNMaZELTzsHguSgSjpI5
   g==;
X-CSE-ConnectionGUID: QS23j9CmQ9q8SnRXo7V4dA==
X-CSE-MsgGUID: PVNqrqcrS1ygMhgtyJRmaA==
X-IPAS-Result: =?us-ascii?q?A0BHAgAnjLFq/47/Ja1aHgEBCxIMggULgleBVUNJhFePU?=
 =?us-ascii?q?oIhkU2MURSBag8BAQEPUQQBAYISgnMCjgcCJjQJDgECBAMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQoBAQUBAQECAQcFgQ4ThlyQEwIBAxoJBFIQJQImAgJGEAYBEoMCgnUDx?=
 =?us-ascii?q?Wx6fzOBAYR+2UqBaAELFAGBCi6FcYJtAYFwhAg7hEEnG4FJRIEVg2mEHwqDd?=
 =?us-ascii?q?YJqBIMcEoMwkSoJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFB0SDwQWM?=
 =?us-ascii?q?h1wDCcSLBcvWBsGBYEdfBQEE4IaIxk2eoEJXoErKWABEBeBB4IIAoJUgX8CA?=
 =?us-ascii?q?UlDDgdFUwknQQoSRykiCBIJARMaMAuBJxgNSBEsNwYPGQQ9AW4Hj14fgWpgC?=
 =?us-ascii?q?wYBBw9uC0I9AyoBZhoBAUqSaisBOIM8jV9rgTWfWoQogWaILJdkM5dnkwaZC?=
 =?us-ascii?q?COjSQYYUIRpgWg8gVkzGggbFYMiUxkPji4Wkx0BvHsnMj4BBwIHDwKBc5ACD?=
 =?us-ascii?q?xcHgU8BAQ?=
IronPort-Data: A9a23:2Bwr4a2chx3mqmNOxvbD5QFwkn2cJEfYwER7XKvMYLTBsI5bp2ZRy
 2pNXGmGM/vcNmPxLdx/bIq2px4P7MCEytdlHQU63Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yEzmE4Ej9atANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 rsen+WFYAX7g28uazpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGNXpsZo9J0eNOUHgez
 voiGDdSUEyPrrfjqF67YrEEasULNsLnOsYb/3pn1zycVatgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUiaC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+OW3boGEJYfWFa25mG6gm
 ETf5X3yGCpDJdO6yTWZ41CWg+bmyHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0EY5y8nv6Uu3EOsSdb5Uluzp3vslh4bQd9LO+438geAzuzT+QnxLmsZRDdpa9E8ssIyAzsw2
 TehltXlHzFw87uYVX6Q6J+QsDW0fyMVRUcabCUJSwot+dTvoIgvyBnIS75LFK+zk82wGjzqx
 T2OhDYxiq9VjsMR0ai/u1fdjFqEoJXVQgMrzhvYU3jj7Q5jYoOhIYuy5jDmAe1oNo2VSByF+
 XMDgcXbtL1IBpCWnyvLS+IIdF2028u43PTnqQYHN/EcG/6FohZPoag4DOlCGXpU
IronPort-HdrOrdr: A9a23:RZNWsKhi+MbgNrbiWXg8NP7wp3BQXiwji2hC6mlwRA09TyVXrb
 HLoB19737JYVcqNk3I9ursBEDtexnhHNtOkOss1NSZMzUOxlHJEGgK1+KLqAEIWReOldK1vp
 0NT0ERMqyUMXFKyev3/wW8Fc8t252k/LDAv5am815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 v72iM+nUvGRV0nKuKmG3ICQ+/P4/fPlJ7gfFo6IiRP0nj3sdttg4SKaSRxGXwlIkhy/Ys=
X-Talos-CUID: =?us-ascii?q?9a23=3ASGtYj2r/saqhs6zMc7BSpo/mUfkeKCbfnVzVGh6?=
 =?us-ascii?q?hWV1vco2SFmHM9Ioxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A/59hwgxasdmWyTCE0euGS6SceOKaqJyQLlkXiJ4?=
 =?us-ascii?q?cgJCVOglwNCuMrg6yS6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,115,1787011200"; 
   d="scan'208";a="526397348"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Sep 2026 20:00:24 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id CE93D1800035F;
	Mon, 21 Sep 2026 20:00:23 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 21 Sep 2026 12:59:47 -0700
Subject: [PATCH net-next 4/6] enic: validate V2 VF configuration replies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-4-67a0a6e08d43@cisco.com>
References: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
In-Reply-To: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790020820; l=27980;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=yl4XoV0665vlNHq6lpOJ+AQRgE/loyqwM/3vx3YkqHQ=;
 b=ukfsAXZER+YiAOGLXCOCfETcg4jVQOgYyT5yJcnMPS2wdaLJwdceuAqf7hUW178jP0Jr1cnfC
 82hIXX1Y5m3DU6yDvA/ZQQrKlZIqk++uQBBOypWFBhiwmGydjK0UEcz
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-05.cisco.com

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
operations that made no state change.

This patch adds only the VF side of these operations. The in-tree V2 PF
enable path remains dormant because enic_driver does not yet register
.sriov_configure. A future PF activation series must implement PF-side
handling for the MAC-address and packet-filter mailbox requests, including
the VF policy checks, before wiring that callback.

Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   9 +
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 492 +++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h |  82 +++++
 3 files changed, 565 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 782b8b1843ab..45992b355501 100644
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
@@ -360,6 +362,13 @@ struct enic {
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
index 2d77d41577a3..3f73072170b9 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -6,6 +6,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/completion.h>
+#include <linux/etherdevice.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -376,6 +377,82 @@ static void enic_mbox_vf_request_finish(struct enic *enic)
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
@@ -551,23 +628,21 @@ static void enic_mbox_vf_handle_reply(struct enic *enic, u8 reply_type,
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
@@ -584,16 +659,168 @@ static void enic_mbox_vf_handle_reply(struct enic *enic, u8 reply_type,
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
+		if (status == -EIO)
+			recovery = ENIC_MBOX_VF_REPLY_RECONNECT;
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
@@ -679,6 +906,34 @@ static bool enic_mbox_vf_payload_ok(struct enic *enic, u8 msg_type,
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
@@ -690,8 +945,10 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
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
@@ -699,8 +956,10 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
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
@@ -708,8 +967,10 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
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
@@ -717,11 +978,21 @@ static void enic_mbox_vf_process_msg(struct enic *enic,
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
@@ -761,6 +1032,10 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 			netdev_warn(enic->netdev,
 				    "MBOX: invalid msg_len %u (buf len %u)\n",
 				    msg_len, len);
+		if (!enic->vf_state &&
+		    le16_to_cpu(hdr->src_vnic_id) == ENIC_MBOX_DST_PF)
+			enic_mbox_vf_malformed_msg(enic, hdr->msg_type,
+						   le64_to_cpu(hdr->msg_num));
 		return;
 	}
 
@@ -791,10 +1066,12 @@ int enic_mbox_vf_capability_check(struct enic *enic)
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
@@ -808,12 +1085,15 @@ int enic_mbox_vf_capability_check(struct enic *enic)
 
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
@@ -828,10 +1108,12 @@ int enic_mbox_vf_capability_check(struct enic *enic)
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
@@ -842,12 +1124,15 @@ int enic_mbox_vf_register(struct enic *enic)
 
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
@@ -858,15 +1143,18 @@ int enic_mbox_vf_register(struct enic *enic)
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
@@ -879,14 +1167,182 @@ int enic_mbox_vf_unregister(struct enic *enic)
 
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

