Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4F3E3D90;
	Mon, 21 Sep 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020894; cv=none; b=dQpa21pcSf3h5cPxRp8Xv7ogL1BjyK5C+P7nNUcB2aVlyvehos+T//5opFoNn8sv9LrYVqmz9CiUaaRTf/+zIvruDpDmlE6VJFvIr/v31LVxfaZPhXzdzsFCkdMcfTMIajyBjeqxPuLEvukOthO+WYrZM+5Cbvf+8DD6Yh8k69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020894; c=relaxed/simple;
	bh=sFh0aQamfTAjvNlnNEhb6wt7vj2SCLsQOvGzBgc1wfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOekSfaPnDedkh2MqPiIxdp/mKTgMX1nga27FwB69dxAWlgOPL8wU+cBCJOvNUe0l7xg8/7u84ZkPdpzYch3PKneDUILXhGs/z9Fyyxlt8DSFo10IyItG0YNp2dih42I+xNn/IUKwLz6QQiGHrjg6mWDg3TSPMF4ggcCaBt8hvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=PyhmwhHJ; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="PyhmwhHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4854; q=dns/txt;
  s=iport01; t=1790020892; x=1791230492;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SMC6SgLhwngWg/peGv5/1lQgClaqRttLnJ85Qw8EPrU=;
  b=PyhmwhHJ8W8jOxPt1kM3ax6RK8t9FfqGfXoIf1BOZosr/MWp7zc3nyV3
   pe+hYYKcUkat5t8VVzO3hc/7Whb2Lxq6TmFC4I1puFtBa4f6mXyE6XOjg
   RmBdRCmfQzrn5naskZBk6V7gTjGhvqzxZ3KV85AEF1ABNpGI5zEOgEP0K
   VWNEaGPx97UeKJZFzhEA3gRIByaIe94DFTZeLRYeWXvyqA/N/Yz/MJuT0
   6EuVTLGDLHmctkrXJBBXRT3cIixky4nRqgcVzUSSMI5td1JtMbZ2jCGXZ
   DkHcIZeKBA+16BwtcXK96BpWFGSrPB9pqUOKUbh4DmXVf08gwH5uxZALW
   A==;
X-CSE-ConnectionGUID: iwYid21+Qy+PBPty+d1JgQ==
X-CSE-MsgGUID: dXnpGvi8SjCoMvlR4+JdJQ==
X-IPAS-Result: =?us-ascii?q?A0AnAAAnjLFq/47/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBVUNJhFeIG4c3giGeHoF+DwEBAQ9RBAEBhQUCjgcCJjQJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQoBAQUBAQECAQcFgQ4ThlyQEwIBAyMEUhAlAiYCAkUBEAYBE?=
 =?us-ascii?q?oMCgnUDxWx6fzOBAYR+2UqBaAELFAGBCi4BhXCCbQGBcIQIO4RBJxuBSUSBF?=
 =?us-ascii?q?YNpgQUBgxmDf4JqBIMcEpRaCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVA?=
 =?us-ascii?q?hQdEg8EFjIdcAwnEiwXL1gbBgWBHXwUBBOCGiMZNnqBCV6BKylgARAXgQeCC?=
 =?us-ascii?q?AKCVIF/AgFJQw4HRVMJJ0EKEkcpIggSCQETGjALgScYDUgRLBQjBg8ZBD0Bb?=
 =?us-ascii?q?gePXh+CXIEECyUmYQGBADCXJo1fa6EPhCiBZqAQM5dnkwaZCCOjZ1CEaYFoP?=
 =?us-ascii?q?IFZMxoIGxWDIlMZD44uCwuTHQG8eycyPQEBBwIHDgMLgWiQEYFtAQE?=
IronPort-Data: A9a23:Su6s6q0f/1VaQuofjPbD5QFwkn2cJEfYwER7XKvMYLTBsI5bpzYFx
 2seXz/VPPeCa2ugL9kiPo/i8EgOuJCEnIA3SAFo3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yEzmE4Ej9atANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 rsen+WFYAX7g28uazpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGDV4HPIFCo6VOECJ23
 8QEOXMBNzKMvrfjqF67YrEEasULNsLnOsYb/3pn1zycVatgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUiaC/FMEg9/5JYWh+60h2L/cD1wo1OOrq1x6G/WpOB0+OW0aYSEIYTbFa25mG6Ul
 mTe0Hr4UioYH9u61z6/rjGOis32yHaTtIU6UefQGuRRqFGa2GEWIBEfS1a+pf63lgi4Vs43A
 0EY5y8nv6Uu3EOsSdb5Uluzp3vslh4bQd9LO+438geAzuzT+QnxLmsZRDdpa9E8ssIyAzsw2
 TehltXlHzFw87uYVX6Q6J+QsDW0fyMVRUcabCUJSwot+dTvoIgvyBnIS75LFK+zk82wGjzqx
 T2OhDYxiq9VjsMR0ai/u1fdjFqEoJXVQgMrzhvYU3jj7Q5jYoOhIYuy5jDmAe1oNo2VSByF+
 XMDgcXbtL1IBpCWnyvLS+IIdF2028u43PTnqQYHN/EcG/6FohZPoag4DOlCGXpU
IronPort-HdrOrdr: A9a23:K3fxH6gkRVxat1Eh99mz8RiMZXBQXiwji2hC6mlwRA09TyVXrb
 HLoB19737JYVcqNk3I9ursBEDtexnhHNtOkOss1NSZMzUOxlHJEGgK1+KLqAEIWReOldK1vp
 0NT0ERMqyUMXFKyev3/wW8Fc8t252k/LDAv5am815dCSxndK1k6R50EUKgEkNwTBRbHpZRLu
 v72iM+nUvGRV0nKuKmG3ICQ+/P4/fPlJ7gfFo6IiRP0nj3sdttg4SKaSRxGXwlIkhy/Ys=
X-Talos-CUID: =?us-ascii?q?9a23=3ATpe8y2lwmfUyvcBJ+MB6EPNdXQvXOXzC/XbceRb?=
 =?us-ascii?q?7MHcqcJetVU7T9PpGnPM7zg=3D=3D?=
X-Talos-MUID: 9a23:6rMEjAandgh1r+BTuw/qnB58NZdT4Y+pLV4Jq8lFmcWmDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,115,1787011200"; 
   d="scan'208";a="511693098"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Sep 2026 20:00:23 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id 3921C18000353;
	Mon, 21 Sep 2026 20:00:22 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 21 Sep 2026 12:59:45 -0700
Subject: [PATCH net-next 2/6] enic: serialize V2 VF mailbox requests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-2-67a0a6e08d43@cisco.com>
References: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
In-Reply-To: <20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790020820; l=4981;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=sFh0aQamfTAjvNlnNEhb6wt7vj2SCLsQOvGzBgc1wfU=;
 b=Uw6mZWTvaSZRZFk5/kNI3TN7V6NTBiHnXnWZHjli5SvjZ4PjlcoOOzWcrZ1dTLkh045/T+CAd
 2t+eHUQxsnZD2kkhQZVsyoxhlVDagiwZmKAD/mr7w24wg5XOlWdOEYn
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-05.cisco.com

The VF stores one expected reply and uses one completion for mailbox
requests. If two VF control paths issue requests at the same time, the
second request can replace the reply state for the first.

Add a request mutex used only by the VF. Hold it from before a request is
armed until its reply or timeout has been consumed. Recheck VF registration
after taking the mutex and clear pending state on send failure so a later
request cannot inherit it.

PF-side request processing is unchanged. Unsolicited PF notifications and
their acknowledgments remain asynchronous.

Assisted-by: LLM
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  1 +
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 49 +++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 7a509a056990..3945fe28f199 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -335,6 +335,7 @@ struct enic {
 	 * the requester.
 	 */
 	struct completion mbox_comp;
+	struct mutex vf_mbox_request_lock; /* serializes VF request lifetimes */
 	spinlock_t mbox_state_lock;	/* protects expected reply state */
 	u64 mbox_expected_msg_num;
 	u8 mbox_expected_reply;
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 5c93ca49552a..b8a18d9682b2 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -218,6 +218,32 @@ static int enic_mbox_wait_reply(struct enic *enic, unsigned long timeout_ms)
 	return err;
 }
 
+static void enic_mbox_vf_request_start(struct enic *enic)
+{
+	mutex_lock(&enic->vf_mbox_request_lock);
+	reinit_completion(&enic->mbox_comp);
+	spin_lock_bh(&enic->mbox_state_lock);
+	enic->mbox_expected_msg_num = 0;
+	enic->mbox_expected_reply = 0;
+	spin_unlock_bh(&enic->mbox_state_lock);
+}
+
+static void enic_mbox_vf_request_abort(struct enic *enic)
+{
+	lockdep_assert_held(&enic->vf_mbox_request_lock);
+	spin_lock_bh(&enic->mbox_state_lock);
+	enic->mbox_expected_reply = 0;
+	enic->mbox_expected_msg_num = 0;
+	spin_unlock_bh(&enic->mbox_state_lock);
+	mutex_unlock(&enic->vf_mbox_request_lock);
+}
+
+static void enic_mbox_vf_request_finish(struct enic *enic)
+{
+	lockdep_assert_held(&enic->vf_mbox_request_lock);
+	mutex_unlock(&enic->vf_mbox_request_lock);
+}
+
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
 {
 	struct enic_mbox_pf_link_state_notif_msg notif = {};
@@ -623,6 +649,7 @@ int enic_mbox_vf_capability_check(struct enic *enic)
 	u32 version;
 	int err;
 
+	enic_mbox_vf_request_start(enic);
 	WRITE_ONCE(enic->pf_cap_version, 0);
 	req.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
 
@@ -630,11 +657,14 @@ int enic_mbox_vf_capability_check(struct enic *enic)
 					ENIC_MBOX_VF_CAPABILITY_REQUEST,
 					ENIC_MBOX_VF_CAPABILITY_REPLY,
 					&req, sizeof(req));
-	if (err)
+	if (err) {
+		enic_mbox_vf_request_abort(enic);
 		return err;
+	}
 
 	err = enic_mbox_wait_reply(enic, 3000);
 	version = READ_ONCE(enic->pf_cap_version);
+	enic_mbox_vf_request_finish(enic);
 	if (err) {
 		netdev_warn(enic->netdev,
 			    "MBOX: no capability reply from PF\n");
@@ -656,15 +686,19 @@ int enic_mbox_vf_register(struct enic *enic)
 	bool registered;
 	int err;
 
+	enic_mbox_vf_request_start(enic);
 	WRITE_ONCE(enic->vf_registered, false);
 
 	err = enic_mbox_vf_send_request(enic, ENIC_MBOX_VF_REGISTER_REQUEST,
 					ENIC_MBOX_VF_REGISTER_REPLY, NULL, 0);
-	if (err)
+	if (err) {
+		enic_mbox_vf_request_abort(enic);
 		return err;
+	}
 
 	err = enic_mbox_wait_reply(enic, 3000);
 	registered = READ_ONCE(enic->vf_registered);
+	enic_mbox_vf_request_finish(enic);
 	if (err) {
 		netdev_warn(enic->netdev,
 			    "MBOX: VF registration with PF timed out\n");
@@ -684,16 +718,24 @@ int enic_mbox_vf_unregister(struct enic *enic)
 
 	if (!READ_ONCE(enic->vf_registered))
 		return 0;
+	enic_mbox_vf_request_start(enic);
+	if (!READ_ONCE(enic->vf_registered)) {
+		enic_mbox_vf_request_finish(enic);
+		return 0;
+	}
 
 	err = enic_mbox_vf_send_request(enic,
 					ENIC_MBOX_VF_UNREGISTER_REQUEST,
 					ENIC_MBOX_VF_UNREGISTER_REPLY,
 					NULL, 0);
-	if (err)
+	if (err) {
+		enic_mbox_vf_request_abort(enic);
 		return err;
+	}
 
 	err = enic_mbox_wait_reply(enic, 3000);
 	registered = READ_ONCE(enic->vf_registered);
+	enic_mbox_vf_request_finish(enic);
 	if (err)
 		return err;
 	if (registered)
@@ -711,6 +753,7 @@ void enic_mbox_init(struct enic *enic)
 	 */
 	if (!reinit) {
 		mutex_init(&enic->mbox_lock);
+		mutex_init(&enic->vf_mbox_request_lock);
 		init_completion(&enic->mbox_comp);
 		spin_lock_init(&enic->mbox_state_lock);
 		enic->mbox_msg_num = 0;

-- 
2.43.0

