Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F543F23DB
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064490; cv=none; b=DL7mqGMExksM43pDlNFC5XxJe+9PV7PK1alcxWefmVzJbdYc4GDWlvAGBavYkXxJxnLT1fA5xEeaqleJ80Wmq+1Kax0jfiHw+rLltiGOSfh085HQY1CCm/zsj6nPCkZQqDHPF2X9qSTTW7bGHSO1/jWSI0VzAfH0aWR0Tx77QX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064490; c=relaxed/simple;
	bh=PB10iJXwaQiQpgWMplLuUrRqupycNcSJ1CXoBYEhb+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGZygFDcZuaSgTyYzKx6/5+kJNOgPeD4wxJ8Oht5e3u1RAHWSUNCjTuebdjJzyF4PVBrn5bD+Yo267pmhfn9LL5PdLs5Q+0aH2ynCyPwFKWFTtDEhvVOwIAQpuY6lGFD4uopA2HmOBSus+aolAUUYmYhwPTrzBt+KzRJNL/ioOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW7eogJm; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW7eogJm"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f01363so31202475ad.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790064480; x=1790669280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRPMgMOIc56QBWBupM6kM1mJ5Xh3d/f5V1FOIpaRUQI=;
        b=hW7eogJmi7wBX3TS/82OiMHwtUW0ANzbNAl3SmwRZXM5okmjtgIzaTORE1dKhbwvTv
         yFzG42GKPXoldCbk/lgv2AXNFIfNZrousO0Hvotz6Th5CvhvKsuwzpSW9nPxLnpee4El
         ZLSrIyzEuYg2tKZy6BM+AiUx6cdcUwWIJtkwqxMD4EEIj5O0djeK9lKn5h7flJO/tFWN
         dStcUlPEkC/b8cEbzejgYQjdfbbn28vP0SWc3XJiUYuP5YrqpcB85WbnS9GVPd2QkBxX
         +j8atyVlQXTau5dp+ee9IhodZKL3GWmFGGoF+wdXUumbRJNMSk7paDnRhXdHef55oYaG
         M/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064480; x=1790669280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qRPMgMOIc56QBWBupM6kM1mJ5Xh3d/f5V1FOIpaRUQI=;
        b=nga00VxSR57gdSEKCCKePdMEfugaeM/0KSOCIINfxoQmuprnW4jT3evYwJEfRqlMwI
         XYlOFm3aUIg0w5ATTl5u4cbtU5JXTVZ2k9VqkCyXFs6uV0cHPhSHezSYu42kKaszcGP+
         2PH+OF8ZMyh7Q4f6VXWzkrV4HKDCnyyQiMRWDeJ04jns2r5EVpYHhRUa9ybwfbyZSlRG
         m/js0DRTmWWL6Ic4ofNPquIzxisuwoe4nrrIgNq5XgSauC9YwycnbuLtrx72kHek6++6
         faMIo4wPRVflUkmQwIrhSAOQBFQ8smGfa7VrcPmOALjbnbGXQJ/kWcJC76Th7oTzjCum
         C0pA==
X-Forwarded-Encrypted: i=1; AKwUvBxjt6rPBeB9lUUbOHxiWzS1ilJsbpoWOUlbsb7vqHM5NQ8RrbvcqXInz2zaOOXtLSiKfCTPlNo=@vger.kernel.org
X-Gm-Message-State: AFuF++llpifHrpNxGN6L1adRwWPiNjFJgKptUrcFjUJD791ba6qaGi6x
	f9nFqy9OtT8DgnfpLPg1mqT4mb5VsBNQs47/9jDz9t7jaR22rGmPVbuF
X-Gm-Gg: AYBFou3h6tULdy2APROl2gbKBohVZDP55+bxchDFRaxiRn+vIavBhVzjymPGQ2Chqtq
	OvuGXUBRCkhautmP4zrRc0gY7bRTczSfA6iSB/zRYvS3ZcceK3IbaBcu6z49z16Gei4g59U6fKU
	Doej9Pjr+9pKsboXWsekn06uBdvbtACYKzJcpR9Qp+CxJo4LFp7cwKpNBFHtmPkuo0bIi6jMzE/
	7hwlbJsED16elNw3yf7/0N0MBHtEHflkG10XIDInVzIbtdlMvocoYioOb5WYsK1Y4ypGUkjAIUn
	+Zna+WajZnCxgAp8SurikvqPL7SWOo4wnSBuk0cVmOgiPDGDDknf70VLfPcSEY1eSx8GHPZBjZs
	+pDCcxY/RASQttdIenp0z6sjFQyXDcCYimfb8P8c+YjZPZITFExlTZU5be/MKQcmlATbDgasic8
	OCl6/BErfGxc63vk4DWlDqmIYfQHCGd3d3uVuw0fQGWEY0nREmyNS0+QlI9EfzQOeya6RtknPQt
	l/vWlJ2JXsMNnPgLmiKHm+AgsmR0saFE8iaZSQ=
X-Received: by 2002:a17:903:19cf:b0:2d9:484:861d with SMTP id d9443c01a7336-2df609ad034mr4138015ad.10.1790064479957;
        Tue, 22 Sep 2026 01:07:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:c92a:4bc0:f68c:8fc1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0581f0sm5584365ad.74.2026.09.22.01.07.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 01:07:59 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH v2] nfc: nci: ignore unexpected CORE_RESET_NTF and CORE_RESET_RSP
Date: Tue, 22 Sep 2026 16:07:50 +0800
Message-ID: <20260922080750.35929-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260921125805.224979-1-horms@kernel.org>
References: <20260921125805.224979-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
added handling of CORE_RESET_NTF in nci_core_reset_ntf_packet(). When
received, it updates ndev->nci_ver, ndev->manufact_id, and
ndev->manufact_specific_info, and calls nci_req_complete(ndev,
NCI_STATUS_OK) to finish the pending reset request.

However, unlike other notification handlers in ntf.c (which validate
ndev->state before completing requests), nci_core_reset_ntf_packet()
does not check whether a core reset request is actually pending.
If an unsolicited or delayed CORE_RESET_NTF arrives (e.g. after a reset
command times out or from a misbehaving NFCC), it unconditionally:
1. Completes whatever request is currently in-flight (such as CORE_INIT,
   RF_DISCOVER, or CONN_CREATE) with NCI_STATUS_OK, leading to kernel
   state desynchronization.
2. Overwrites ndev->nci_ver and manufacturer info. Because
   ndev->nci_ver is used as a selector for subsequent packet formats
   and parsers (e.g., in nci_open_device() and nci_core_init_rsp_packet()),
   unexpectedly modifying it can cause protocol format confusion.

A similar issue exists in nci_core_reset_rsp_packet(): an unexpected or
delayed response packet can prematurely complete an unrelated in-flight
request.

Fix this by ensuring CORE_RESET_NTF and CORE_RESET_RSP are only processed
by the core layer when a reset command is actively awaiting them:
- Set NCI_RESET_PENDING in nci_reset_req() when sending CORE_RESET_CMD.
- In nci_core_reset_rsp_packet(), ignore the response if NCI_RESET_PENDING
  is not set. If set, clear the flag and complete the request on failure
  or for NCI 1.x (checking skb->len >= sizeof(*rsp)).
- In __nci_request(), ensure NCI_RESET_PENDING is cleared upon request
  completion, cancellation, or timeout.
- In nci_core_reset_ntf_packet(), skip power-on notifications (trigger
  0x01, identical in NCI 1.0 and 2.0), then check and clear
  NCI_RESET_PENDING before updating device fields and completing the
  request. The CORE_RESET_CMD trigger value is revision-dependent
  (0x00 in NCI 1.0, 0x02 in NCI 2.0), so both are accepted and gated
  on NCI_RESET_PENDING alone. If unexpected, log a warning and return
  0 so driver-specific handlers (such as fdp firmware patch handling)
  still receive the notification.

Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
v2:
 - Do not abort the notification pipeline on unexpected CORE_RESET_NTF (return 0
   instead of -EINVAL), preserving driver-level hooks (e.g. fdp firmware
   patching) per Simon Horman.
 - Skip power-on notifications (trigger 0x01, identical in NCI 1.0 and 2.0)
   while gating both NCI 1.0 (0x00) and NCI 2.0 (0x02) command-triggered resets
   on NCI_RESET_PENDING alone.
 - Check NCI_RESET_PENDING in nci_core_reset_rsp_packet() to avoid completing
   unrelated requests on unexpected responses.
 - Explicitly check skb->len >= sizeof(*rsp) in nci_core_reset_rsp_packet()
   for NCI 1.x handling.

 include/net/nfc/nci.h      |  5 +++++
 include/net/nfc/nci_core.h |  1 +
 net/nfc/nci/core.c         |  3 +++
 net/nfc/nci/ntf.c          | 17 ++++++++++++++++-
 net/nfc/nci/rsp.c          | 24 ++++++++++++++++++------
 5 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/net/nfc/nci.h b/include/net/nfc/nci.h
index 09efcaed7c3f..2ac45adba088 100644
--- a/include/net/nfc/nci.h
+++ b/include/net/nfc/nci.h
@@ -140,6 +140,11 @@
 #define NCI_RESET_TYPE_KEEP_CONFIG				0x00
 #define NCI_RESET_TYPE_RESET_CONFIG				0x01
 
+/* NCI Reset Triggers */
+#define NCI_RESET_TRIGGER_ERROR					0x00
+#define NCI_RESET_TRIGGER_POWER_ON				0x01
+#define NCI_RESET_TRIGGER_RESET_CMD				0x02
+
 /* NCI Static RF connection ID */
 #define NCI_STATIC_RF_CONN_ID					0x00
 
diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e66e..504ea91ddf27 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -31,6 +31,7 @@ enum nci_flag {
 	NCI_DATA_EXCHANGE,
 	NCI_DATA_EXCHANGE_TO,
 	NCI_UNREG,
+	NCI_RESET_PENDING,
 };
 
 /* NCI device states */
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5f46c4b5720f..5a90591cd9af 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -134,6 +134,7 @@ static int __nci_request(struct nci_dev *ndev,
 	}
 
 	ndev->req_status = ndev->req_result = 0;
+	clear_bit(NCI_RESET_PENDING, &ndev->flags);
 
 	return rc;
 }
@@ -163,6 +164,8 @@ static void nci_reset_req(struct nci_dev *ndev, const void *opt)
 {
 	struct nci_core_reset_cmd cmd;
 
+	set_bit(NCI_RESET_PENDING, &ndev->flags);
+
 	cmd.reset_type = NCI_RESET_TYPE_RESET_CONFIG;
 	nci_send_cmd(ndev, NCI_OP_CORE_RESET_CMD, 1, &cmd);
 }
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index f5c9a8ab7ec1..57f99bf46a22 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -36,7 +36,22 @@ static int nci_core_reset_ntf_packet(struct nci_dev *ndev,
 	if (skb->len < sizeof(struct nci_core_reset_ntf))
 		return -EINVAL;
 
-	ntf = (struct nci_core_reset_ntf *)skb->data;
+	ntf = (const struct nci_core_reset_ntf *)skb->data;
+
+	/*
+	 * A power-on notification must not update core protocol state nor
+	 * complete a pending request.  The CORE_RESET_CMD trigger value is
+	 * revision-dependent (0x00 in NCI 1.0, 0x02 in NCI 2.0), so both
+	 * are let through to the reset-pending gate below instead.
+	 * Return 0 so driver-specific notification hooks can still run.
+	 */
+	if (ntf->reset_trigger == NCI_RESET_TRIGGER_POWER_ON)
+		return 0;
+
+	if (!test_and_clear_bit(NCI_RESET_PENDING, &ndev->flags)) {
+		pr_warn_ratelimited("unexpected CORE_RESET_NTF\n");
+		return 0;
+	}
 
 	ndev->nci_ver = ntf->nci_ver;
 	pr_debug("nci_ver 0x%x, config_status 0x%x\n",
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ab4f5acbce..3a2491497e4b 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -32,14 +32,26 @@ static void nci_core_reset_rsp_packet(struct nci_dev *ndev,
 
 	pr_debug("status 0x%x\n", rsp->status);
 
+	/*
+	 * If no reset request is pending, ignore unexpected responses to avoid
+	 * prematurely completing an unrelated request.
+	 */
+	if (!test_bit(NCI_RESET_PENDING, &ndev->flags))
+		return;
+
+	if (rsp->status != NCI_STATUS_OK) {
+		clear_bit(NCI_RESET_PENDING, &ndev->flags);
+		nci_req_complete(ndev, rsp->status);
+		return;
+	}
+
 	/* Handle NCI 1.x ver */
-	if (skb->len != 1) {
-		if (rsp->status == NCI_STATUS_OK) {
-			ndev->nci_ver = rsp->nci_ver;
-			pr_debug("nci_ver 0x%x, config_status 0x%x\n",
-				 rsp->nci_ver, rsp->config_status);
-		}
+	if (skb->len >= sizeof(*rsp)) {
+		ndev->nci_ver = rsp->nci_ver;
+		pr_debug("nci_ver 0x%x, config_status 0x%x\n",
+			 rsp->nci_ver, rsp->config_status);
 
+		clear_bit(NCI_RESET_PENDING, &ndev->flags);
 		nci_req_complete(ndev, rsp->status);
 	}
 }
-- 
2.53.0

