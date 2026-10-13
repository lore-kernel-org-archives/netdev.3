Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F45E5476F0
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922094; cv=none; b=aDHj6/joM8UGs39M6yPx0Dt2l5HY0P+O2UVVpL9MUHTaT8IDD7RQmrz9gIu7h9pcPz38a7Q7g7i8PHcN8IFNNxWVj/UHq/KRNuVE68qEw6DekwdcnwTbdx/cSu0Wp1MkHQe/yS3x+6G8pLYBmFGFyjO/qlQ43ChWTYq9XAkEXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922094; c=relaxed/simple;
	bh=nuj98LMHJV7YXMvZFP0mgsnkil3gxXP9Diu5IS6CATg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCtsylsBDM9JcLx9ijmVfkxoEW45+zqzUPcRx7kgotRmyetYiuMvAoKUDcxmLCklQddN5jI5sQEfbi4Tz4XXO980flP56STUzdo5PTOOzQ4UE8dsO7ZHNL8y0y3jMRBc6DTd2/U32rizMjcMv2N7bWo2hkD9p92NdSp/46RlePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z91HPY7z; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z91HPY7z"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso1624987a91.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922092; x=1792526892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UOX1fnqCCqvGPeGhBPtjplBZCMxVrAi4/APZ6zwxUvY=;
        b=sweqlQa9crtLMsts6ztiEvX6zs2bNZKQ2eVeKBIud2OrGP6msLexLafEb7piONYkQ/
         hToN8nGgBd3KUNZJOwKGFCvcktXLj6jEDb7Tcke7j6NxnESmq5EyyfZs+3y26acmfwY2
         SDhSkDY6yS5tXal103gn0IPviAbMTE7+M/zEQNjtpeZ3P1QDJ3R1FiD0lgZDRkl76MfW
         XB/e6LfRaTmAEgxS/Ee7jlggpx/3Fl7TkBDlqVM7lYn1iVj/dAXQT1J83Hp1AGW1B+Nc
         JGzqlLxDoNc4VAfBzTY6ikah9tJgIxHgqeV2Ev0EkGwQthHvwBOn8ODfq1KfsoYrYycr
         +0Pg==
X-Gm-Message-State: AFq9FYLDqPc7Z6cZF1qpomPWGsGos14y8RLxuPE65/3HERwDeAOEc4RS
	AHrLu2Uedi+748S+v4tzrUIPH9Kwu328XGq+8+tuCKldI5vlceU3gXdjM6BqQuSMnTPitk1swIX
	7QWxY8uwEHt1Cp9WbmA7lyDW8MkF0cLKQgIZYgU4C3jD2iTx+PMiiGBrArzTiFD8315j1wsLPfG
	yQJUARgU1DtyrrdE0/xpRAqcOjoyC/I+1/Zvlp8+UZWCyk/Xi1Z6OkLE0fSlTQnzQ9OBmKLUXWC
	Ze0jB/y7y/Fr3aktTeEk40=
X-Gm-Gg: AYBFou1SlgsIIZ4aYAds+kHat+S/pqsWPKXwBNTW1MwCQ7xnpGPXhi0WQAxGkD0QKPY
	V7DaTjytIKKw2fHfU9YBE4w9RDK9eNdW4IvVAypPfUJ5tcRo+SB9PFvVhPWXNaysfsQc6gTQXX8
	IPCRjfdlNUWiTfL3e/fn3za9P/cCq51cyKqSD21RLtsp5tk5fa7QRqxptylHdGqjT5EOPBgKCDT
	z9UjfeeulLBswIn/z/QlwbNAuJFltcET/rvLM+zHlumfuHnEaFx+jxsFZGVYDEyNapi/Yu3HHe5
	yuYbRwOwl2KuzfL4lEGIbdTe8Pg5qLBrbby6HbzPJFH1ZFW/czAxMeu577Iw9mXqqTLhNH3h7ch
	w84pdKBwq2AeEHR0i6wGu9ykv7rLP0yJeNdB+M7KjiDtp6suh9IG44UufEIKoHFbwjBoVEYcblC
	A/dJiVWVTyLUKAuZnHOMGuJ34dULHu0G/f1bngvQEq/7K8
X-Received: by 2002:a17:90b:390b:b0:3a0:aa65:2bb6 with SMTP id 98e67ed59e1d1-3ab3ab324efmr11351942a91.29.1791922092261;
        Tue, 13 Oct 2026 13:08:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac5f3d0b15sm329019a91.1.2026.10.13.13.08.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:08:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-152d1363a29so12558476c88.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791922091; x=1792526891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOX1fnqCCqvGPeGhBPtjplBZCMxVrAi4/APZ6zwxUvY=;
        b=Z91HPY7zRaFWXBohwshKSeOvqCw5QU0xXoYnVzee/XF3Ai2ERedjUDYHnTdhnpyEJz
         eObThpIIG/bG6Z9XWNwVCD2S5kGean0wUjpApvGjsX7W2rIXpCyeNhHnmhcIEmnnhW+d
         VJtaPWOc/hLOCd9h9fb7jNFPb/NIk659repFs=
X-Received: by 2002:a05:701b:2707:b0:144:c127:dd1b with SMTP id a92af1059eb24-16a5fe7c188mr20179188c88.39.1791922090250;
        Tue, 13 Oct 2026 13:08:10 -0700 (PDT)
X-Received: by 2002:a05:701b:2707:b0:144:c127:dd1b with SMTP id a92af1059eb24-16a5fe7c188mr20179129c88.39.1791922089345;
        Tue, 13 Oct 2026 13:08:09 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm39526585c88.11.2026.10.13.13.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:08:08 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Kumar Mudide <kumar.mudide@broadcom.com>,
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
Subject: [PATCH net-next v3 2/5] bnge: add bnge_err()/bnge_warn()/bnge_dbg() logging helpers
Date: Wed, 14 Oct 2026 01:36:42 +0530
Message-ID: <20261013200645.1346299-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
References: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

netdev_err() and netdev_warn() print "(unnamed net_device)
(uninitialized)" instead of the interface name while the netdev has not
been registered yet. Later patches in this series run NQ0 init before
register_netdev() in probe, so messages from the HWRM ring alloc/free
paths and from NQ0's NAPI would be logged that way.

Add bnge_err(), bnge_warn() and bnge_dbg(), which take a struct bnge_dev
and log through the netdev once it has been registered, including while
it is being unregistered and after, where it keeps its name. Before
that, fall back to dev_err()/dev_warn()/dev_dbg() on the PCI device.

Convert the HWRM ring alloc/free error messages, the IRQ affinity hint
warning and the async event debug message, which are reachable from
those paths. No other message is changed.

No functional change.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Kumar Mudide <kumar.mudide@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h      | 18 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_hwrm_lib.c |  8 +++++---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c   |  5 ++---
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c |  4 ++--
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 4479ccd071f5..e76ba4e063bb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -220,6 +220,24 @@ struct bnge_dev {
 	u32			phy_flags;
 };
 
+/* The netdev has no name until register_netdev(), so log through the PCI
+ * device before that (e.g. during probe).
+ */
+#define bnge_log(level, bd, fmt, ...)					\
+	do {								\
+		struct bnge_dev *__bd = (bd);				\
+									\
+		if (__bd->netdev &&					\
+		    READ_ONCE(__bd->netdev->reg_state) != NETREG_UNINITIALIZED)\
+			netdev_##level(__bd->netdev, fmt, ##__VA_ARGS__);\
+		else							\
+			dev_##level(__bd->dev, fmt, ##__VA_ARGS__);	\
+	} while (0)
+
+#define bnge_err(bd, fmt, ...)	bnge_log(err, bd, fmt, ##__VA_ARGS__)
+#define bnge_warn(bd, fmt, ...)	bnge_log(warn, bd, fmt, ##__VA_ARGS__)
+#define bnge_dbg(bd, fmt, ...)	bnge_log(dbg, bd, fmt, ##__VA_ARGS__)
+
 static inline bool bnge_is_roce_en(struct bnge_dev *bd)
 {
 	return bd->flags & BNGE_EN_ROCE;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 651c5e783516..fb960bff85fa 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -1302,7 +1302,8 @@ int hwrm_ring_free_send_msg(struct bnge_net *bn,
 	bnge_hwrm_req_drop(bd, req);
 exit:
 	if (rc) {
-		netdev_err(bd->netdev, "hwrm_ring_free type %d failed. rc:%d\n", ring_type, rc);
+		bnge_err(bd, "hwrm_ring_free type %d failed. rc:%d\n",
+			 ring_type, rc);
 		return -EIO;
 	}
 	return 0;
@@ -1395,7 +1396,7 @@ int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 		req->int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 		break;
 	default:
-		netdev_err(bn->netdev, "hwrm alloc invalid ring type %d\n", ring_type);
+		bnge_err(bd, "hwrm alloc invalid ring type %d\n", ring_type);
 		return -EINVAL;
 	}
 
@@ -1406,7 +1407,8 @@ int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 
 exit:
 	if (rc) {
-		netdev_err(bd->netdev, "hwrm_ring_alloc type %d failed. rc:%d\n", ring_type, rc);
+		bnge_err(bd, "hwrm_ring_alloc type %d failed. rc:%d\n",
+			 ring_type, rc);
 		return -EIO;
 	}
 	ring->fw_ring_id = ring_id;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 8cd0d8bd68c2..f8f81f3f7cd9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2696,9 +2696,8 @@ static int bnge_nq_request_irq(struct bnge_net *bn, struct bnge_napi *bnapi)
 		cpumask_set_cpu(cpumask_local_spread(bnapi->index, numa_node),
 				irq->cpu_mask);
 		if (irq_set_affinity_hint(irq->vector, irq->cpu_mask))
-			netdev_warn(bn->netdev,
-				    "Set affinity failed, IRQ = %d\n",
-				    irq->vector);
+			bnge_warn(bd, "Set affinity failed, IRQ = %d\n",
+				  irq->vector);
 	}
 	return 0;
 }
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 472b02cc43b3..2f382514c6ea 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1135,8 +1135,8 @@ static void bnge_async_event_process(struct bnge_net *bn,
 	u32 data1 = le32_to_cpu(cmpl->event_data1);
 	u32 data2 = le32_to_cpu(cmpl->event_data2);
 
-	netdev_dbg(bn->netdev, "hwrm event 0x%x {0x%x, 0x%x}\n",
-		   event_id, data1, data2);
+	bnge_dbg(bn->bd, "hwrm event 0x%x {0x%x, 0x%x}\n",
+		 event_id, data1, data2);
 
 	switch (event_id) {
 	case ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE:
-- 
2.47.3

