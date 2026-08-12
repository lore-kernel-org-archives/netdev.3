Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A73434E4E;
	Wed, 12 Aug 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538923; cv=none; b=upc9RfuobncPMHx74Hwpw6qkqNmuiQb9BvhfAVprkTw0PphBEDcyMgamcGk58i+cXNrXfeIXsfJIADXM7Twgsl/DlQuv/fvrBw00BbSlnUn4m98GZ+aGz8wUwCr1TFTYYgdOvHfEjtK1kQM2Ltykp2gchD3r/XWi3+DyGUdVFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538923; c=relaxed/simple;
	bh=maiuBOOhoKrVsT9EDvOhOPcNH6loN3hKGPY+w8DU4ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEJsb+A5yFkzYCtQXdzlxBfkPtXzhk0D/rAM4MkbbHut5Oor6Jn+MMS/UXdK0N9VmS+q+pS16cZkANPpFxVRyMF9XQjgC7SFkq4wwRhjAUXtgLjVUSGLEwMCFTyroZJdW6nqzzo/BubiiRdijYQ1ZxLsQwJ+/WtU52Uh7Ffiht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=FraSH0iy; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="FraSH0iy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3218; q=dns/txt;
  s=iport01; t=1786538920; x=1787748520;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8sUDrWZ1x1kUKLSeVDsOjlq2lbZfCxcLEH2avjATtFU=;
  b=FraSH0iyZ4jj+WM7GtTqNLvX2B3oxix3V1sqMwsPIsKoo3bocOIxOCyv
   EHvRe/nJsiRbNdsV790y6CyhYl8sx4JvsXqQacNZelEndLWvozBY+hz9l
   3sI7dStX41sEPhU2nh3EJ6hcFPfLBezYwxzGJb1IU129P7R8DSshTIFfv
   xKUTLN9ZHEg6SMiLPbV7o1fSEFfDGzUPBHVdVQigAvzlpzlNDs1AcrySz
   xiSqlpG3IzJMEq8p4dKTer4N+nE1Pw9MjGvDkT6M5AuWJ7u64XrdlrGFs
   KG6mjT946B4vV8Ooy15/rmOIj8fuihkamwni2egCNm5e2zTbWINwGPjNY
   g==;
X-CSE-ConnectionGUID: ObDwUDm3SAulJe2XVupHKw==
X-CSE-MsgGUID: /+1qYgy0Ryq0JXFkM3tHiQ==
X-IPAS-Result: =?us-ascii?q?A0AnAABhanxq/5EQJK1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBhChDSYRXiBuHN4IhkU2MURSBag8BAQEPUQQBAYUFAo1nAiY0CQ4BA?=
 =?us-ascii?q?gQDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyNEEhAlAiYCA?=
 =?us-ascii?q?kYQBgESgwKCdQPDLHqBMoEBhH3ZSYFnCxQBgQouAYVwgmwBgXCECDuEQScbg?=
 =?us-ascii?q?UlEgRQBg2mEBQEZg3+CagSDHBKTAAk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLE?=
 =?us-ascii?q?hIYFQIUHBMPBBYyHXAMJxIsFzVYGwYFgR19FAQThDYjGTZ8gQlhgSsqZQESF?=
 =?us-ascii?q?4EJgiQCgnaBKmECAR4LGA1IESw3Bg4ZBD0BbgeOCCCBVHGBDnw1YxqXVo1fa?=
 =?us-ascii?q?6EPhCiBZqAPATKXZ5MFmQgjoxtDCVCEaYFoPIFZMxoIGxWDIlMZD45fz30nM?=
 =?us-ascii?q?j0CBwIHDgMLkXmBbQEB?=
IronPort-Data: A9a23:hn20kavshatA250U5BD3VfsaaOfnVIRfMUV32f8akzHdYApBsoF/q
 tZmKW+FPKmCazD8etggO42+8B8Pv8CAxtdrSwVuqS09HyMSgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZTdJ5xYuajhKs/La8ks21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw3exbHlxi8
 KcjAS0JTB3Zt9yr2JKYVbw57igjBJGD0II3s3Vky3TdSP0hW52GG/WM7t5D1zB2jcdLdRrcT
 5NGMnw0MlKZPVsWZgp/5JEWxI9EglHkeiFZs1KWpYI84nPYy0p6172F3N/9KoTWH5QExhnDz
 o7A1yO6WwgrO83H8yucqlCcqOzqxj/bWbtHQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGqaUz6EWsZtXwVRyxpjiDpBF0c9dcDugz+gyR4qXT5AmdCy4PSTspQN87vsYeRjEw0
 FKN2dTzClRHubuZU3+CtbGZsT+/JwARMGkEIyQEJSMd6tPupoAblB/DTt9/VqWyi7XdHTD23
 iDPryUkgbgXpdAE2r/9/l3dhT+o4J/TQWYd4AjLUm+7xh12aZTjZIGy71Xfq/FaI+6kokKpt
 XwAnY2aqesJF5zIzHzLS+QWF7bv7PGAWNHBvWNS81Aa32zF0xaekUp4uVmS+G8B3h44RALU
IronPort-HdrOrdr: A9a23:WYSjdKwV4kIh0UATAe2xKrPw2r1zdoMgy1knxilNoNJuA6ilfq
 eV/cjztCWbtN9/YhwdcLy7UpVoBEmsl6KdgrN/AV7dZmnbUQKTRekI0WKh+UyCJ8SUzIJgPM
 lbAs1DIey1IFRkgcP9+QWiV/Qt0LC8gdmVrNab4ntzQQRtcq16qz14BAGSD1FsSGB9dPwE/e
 Knl616jgvlX2gLZcKmAXRAde3Cq9rX0K/CW3c9dmYaAM3kt0LT1FY8eCLopSsjbw==
X-Talos-CUID: 9a23:WTs63m+3ckAKvEoqetaVv2keNt8YXniG917NJ221U1ZXVaW1akDFrQ==
X-Talos-MUID: 9a23:/6K3zQhefLGosX9EyhJxX8Mpc4Qx+pWhGRg3gIxemfmqNgkrJxectWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="804299073"
Received: from alln-l-core-08.cisco.com ([173.36.16.145])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 12 Aug 2026 12:48:34 +0000
Received: from [127.0.0.1] (unknown [10.25.129.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-08.cisco.com (Postfix) with ESMTPS id 7CAA918000453;
	Wed, 12 Aug 2026 12:48:33 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 12 Aug 2026 05:48:05 -0700
Subject: [PATCH net-next v13 05/11] enic: define MBOX message types and
 header structures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-enic-sriov-v2-admin-channel-v2-v13-5-b3809e448aba@cisco.com>
References: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
In-Reply-To: <20260812-enic-sriov-v2-admin-channel-v2-v13-0-b3809e448aba@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Sesidhar Baddela <sebaddel@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786538908; l=3233;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=maiuBOOhoKrVsT9EDvOhOPcNH6loN3hKGPY+w8DU4ro=;
 b=UAa1qIf4+RvjRZXEUkgFldR0+UNTaGJEUXkhab/fAwYYd1p9Mx0uLleVh6Qg/1oXEPcEaSzhJ
 9tBm8iOEcKaD/3rLYiBTZ496VQnuuWqTrSXc8lqk4AOCgv6nTlWQgQG
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.129.245];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.129.245, [10.25.129.245]
X-Outbound-Node: alln-l-core-08.cisco.com

Define the mailbox protocol structures for PF-VF communication:
message header, generic reply, and per-message-type payloads for
capability negotiation, VF registration/unregistration, and link
state notification/acknowledgment.

Include linux/types.h and linux/bits.h for __le16/__le32/__le64
and BIT() used in the header.

Message types use an even=request / odd=reply convention.  The
header carries source and destination VNIC IDs, a per-channel
message sequence number, and the total message length.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_mbox.h | 83 +++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
new file mode 100644
index 000000000000..a52f1d25cb21
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2025 Cisco Systems, Inc.  All rights reserved. */
+
+#ifndef _ENIC_MBOX_H_
+#define _ENIC_MBOX_H_
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/*
+ * Mailbox protocol for PF-VF communication over the admin channel.
+ *
+ * Even numbers are requests, odd numbers are replies/acks.
+ * The prefix indicates the initiator: VF_ = VF-initiated, PF_ = PF-initiated.
+ */
+enum enic_mbox_msg_type {
+	ENIC_MBOX_VF_CAPABILITY_REQUEST		= 0,
+	ENIC_MBOX_VF_CAPABILITY_REPLY		= 1,
+	ENIC_MBOX_VF_REGISTER_REQUEST		= 2,
+	ENIC_MBOX_VF_REGISTER_REPLY		= 3,
+	ENIC_MBOX_VF_UNREGISTER_REQUEST		= 4,
+	ENIC_MBOX_VF_UNREGISTER_REPLY		= 5,
+	ENIC_MBOX_PF_LINK_STATE_NOTIF		= 6,
+	ENIC_MBOX_PF_LINK_STATE_ACK		= 7,
+	ENIC_MBOX_MAX
+};
+
+struct enic_mbox_hdr {
+	__le16 src_vnic_id;
+	__le16 dst_vnic_id;
+	u8 msg_type;
+	u8 flags;
+	__le16 msg_len;
+	__le64 msg_num;
+};
+
+struct enic_mbox_generic_reply {
+	__le16 ret_major;
+	__le16 ret_minor;
+};
+
+#define ENIC_MBOX_ERR_GENERIC		BIT(0)
+#define ENIC_MBOX_ERR_VF_NOT_REGISTERED	BIT(1)
+#define ENIC_MBOX_ERR_MSG_NOT_SUPPORTED	BIT(2)
+
+/* ENIC_MBOX_VF_CAPABILITY_REQUEST / _REPLY */
+#define ENIC_MBOX_CAP_VERSION_0		0
+#define ENIC_MBOX_CAP_VERSION_1		1
+
+struct enic_mbox_vf_capability_msg {
+	__le32 version;
+	__le32 reserved[32];
+};
+
+/* The embedded enic_mbox_generic_reply has 2-byte alignment, but the
+ * __le32 members give this struct 4-byte natural alignment.  Receive
+ * buffers come from kmalloc (>= 8-byte aligned), so there is no
+ * misaligned access risk when casting from the receive buffer.
+ */
+struct enic_mbox_vf_capability_reply_msg {
+	struct enic_mbox_generic_reply reply;
+	__le32 version;
+	__le32 reserved[32];
+};
+
+/* ENIC_MBOX_VF_REGISTER / _UNREGISTER */
+struct enic_mbox_vf_register_reply_msg {
+	struct enic_mbox_generic_reply reply;
+};
+
+/* ENIC_MBOX_PF_LINK_STATE_NOTIF / _ACK */
+#define ENIC_MBOX_LINK_STATE_DISABLE	0
+#define ENIC_MBOX_LINK_STATE_ENABLE	1
+
+struct enic_mbox_pf_link_state_notif_msg {
+	__le32 link_state;
+};
+
+struct enic_mbox_pf_link_state_ack_msg {
+	struct enic_mbox_generic_reply ack;
+};
+
+#endif /* _ENIC_MBOX_H_ */

-- 
2.43.0

