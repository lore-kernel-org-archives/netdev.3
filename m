Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D9560AD4;
	Tue, 29 Sep 2026 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708387; cv=none; b=EQLP+sWOpsDAMxsv504l0vXvy6IC+nCqyzTxlqO6TCdC94xZ+gO1z/hZKy+h3KQjhqZGbsBfkp3F0lY9cbfR2IJQ72V2z8oMb8Gje8zOOAvEy6eU+Xcbq0+CXvHcNsdXzDfOkzSGO8gylKiv+uxAdirkZsd1MYAMLpns0UtmiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708387; c=relaxed/simple;
	bh=sFh0aQamfTAjvNlnNEhb6wt7vj2SCLsQOvGzBgc1wfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5ufw5iaMMTKoHtAuDZ0jl08cbCbQ0xeIy1Q0Aw/vZI8POMm043K6Enppdn8Y4gl+eAJ8xpDK9jDdcPYjhPhdrHznhHfTB7/nvtJv16FIQwQ4O5xCNkKWhHfoytgeNSEUAxdSIT1a6L1otIjr70gdpQhFcDodG6pbzBfv4I79As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=CP4QBLq2; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="CP4QBLq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4854; q=dns/txt;
  s=iport01; t=1790708385; x=1791917985;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SMC6SgLhwngWg/peGv5/1lQgClaqRttLnJ85Qw8EPrU=;
  b=CP4QBLq2NuuL60P84vaL030ccfkASG9vmY1vni1LmcONaNu6CopGVybs
   kwTRzGXqBZAiXvDyz01KwdeZkw6nYfGyo5S8Uw6w8kunu42KnX4YiTqRm
   a9jYb/X44tLsYB6FP3/ktkp21HhexFhkme6yBm7OIWra5z4k1YDBjocwm
   JS7xjwrf/w9r8v3ki3PiB+hONxw8bmtiKMk8RQzrlIEAb1dWf/ALEkUYP
   RBcQldgb9C+vfaoxuF5Db2TPc3tcOrBnuOcQqJw7PenKgNRla0ncnV2eK
   rbYlKCSMH6lNsfPwhElxiuQvu/zgtfXNzU4irWliF8CHG7Hg2Qs3qM/cH
   g==;
X-CSE-ConnectionGUID: 1dQ047lPSk2zw6W3Ms7diw==
X-CSE-MsgGUID: SP6ivtapSqOmAs3xx7gtGw==
X-IPAS-Result: =?us-ascii?q?A0AaAADCCbxq/4v/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBglaBVUNJhFeIG4c3giGeHYF+DwEBAQ9RBAEBhQUCjggCJjQJDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBAQoBAQUBAQECAQcFgQ4ThlyQEwIBAyMEUhAlAiYCA?=
 =?us-ascii?q?kUBEAYBEoMCgnUDwUF6fzOBAYR+2UqBaAELFAGBCi4BhXGCbQGBcYQIO4RBJ?=
 =?us-ascii?q?xuBSUSBFYNpgQUBgxmDf4JqBIMcEpUoCT+BAhwDWSwBVRMNCgsHBWFSMwMgC?=
 =?us-ascii?q?gsSEhgVAhQdEg8EFjIdcAwnEiwXL1gbBgWBHXUUBBOCGSMZNnqBCV6BKylgA?=
 =?us-ascii?q?RAXgQeCBwKCVIIAAgFJQQ4HRVMJJUUSRyYiCBIJARMaMAuBGzg+CSg9GA1IE?=
 =?us-ascii?q?SwUIwYPGQQ9AW4HkDcegmCBBAslJmEBgQAwlyaNX2uhD4QogWagEDOXZ5MIm?=
 =?us-ascii?q?Qgjo2dQhGmBaDyBWTMaCBsVgyJTGQ+OLgsLkx0BvHsnMj0BAQcCBw4DC4Fok?=
 =?us-ascii?q?BGBbQEB?=
IronPort-Data: A9a23:IbD/86LX2Mc74iLNFE+RA5QlxSXFcZb7ZxGr2PjKsXjdYENS0zIFy
 DYZWmuDO/aCNGGmLdhya46+9R8PuJPXn4RjHlMd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea+Uf1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH9imQlajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN03AHhuYdIcwt10W3NRq
 8NDDStSYhGc0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBV7AtQIvIROPB4towMDUY358VW62BI
 ZBENHw2N0Wojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjeK8aYGKI4XXLSlTtn2g+
 GPY423hOQg9MfWEkiqVrX2wqfCayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa+0usQd3wGRa/pRasvhkGXsF4EOAg7gyJjK3O7G6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5aJ4qfC13Et
 38elo3GtqYFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz0k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:5rQA0aFBD0EyP7dEpLqEHseALOsnbusQ8zAXPo5KOHhom6uj9v
 xG/c506faaslsssR0b8+xofZPwI080lqQb3WBuB9eftWDd0QPCEGgh1/qA/9SKIUHDH4BmpM
 JdWpk7JdHuAV19lMrgpCu1A78bsaC62ZHtqOvAw3JqVA1wL5th4QBwFxqBHiRNNW977OICZf
 2hz/sCgSa8cnIKacn+LHwEU+/f4+DvrvvdEGY779pN0nj1sdtug4SKaCSl4g==
X-Talos-CUID: =?us-ascii?q?9a23=3AWUPFiWrwAf4asbeO/2cR7yrmUZkpSyWBk3PoGEz?=
 =?us-ascii?q?iG3k3d+awUgCc+bwxxg=3D=3D?=
X-Talos-MUID: 9a23:HR+fzgt5MeSczRZ+ns2nvwk8Ndl06ryVEWcIuI5dq9nbOjBfJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,130,1787011200"; 
   d="scan'208";a="529137115"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Sep 2026 18:58:36 +0000
Received: from [127.0.0.1] (unknown [10.25.128.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 05D0A1800037C;
	Tue, 29 Sep 2026 18:58:35 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 29 Sep 2026 11:58:05 -0700
Subject: [PATCH net-next v2 2/6] enic: serialize V2 VF mailbox requests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-2-5962c10061b2@cisco.com>
References: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
In-Reply-To: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, sebaddel@cisco.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790708314; l=4981;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=sFh0aQamfTAjvNlnNEhb6wt7vj2SCLsQOvGzBgc1wfU=;
 b=hiyFt3aRJ4IxeSG/x3/aQ2oO1Q5X+FSQpUKTTLEGn+eNLsjRhSzXTYm5rCFIZm/SBOltWPm7M
 7zZVIpt/z1KCg5qxvBX9zB8o+ctSaliTAyawmhG8TYXnI2bkHr1GCHF
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.208];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.208, [10.25.128.208]
X-Outbound-Node: rcdn-l-core-02.cisco.com

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

