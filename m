Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870534F483
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931233; cv=none; b=sK4dPXq3QL20ReG+KxIo88Uqsv3Z64JPLrM/SU+j1iZ2yBV8Ky0jKlXorKp4Mrt+woDq22yPp9cpf0OqyX9X+oAmYmJVU5mKcsojLWgPMF3jZfwFtj6BCORCy2byQvaAmbOutEskJoKfHr2+EMU9STmrNw9VIBjJHOZ97q+H4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931233; c=relaxed/simple;
	bh=beQsm+kN2AynC2ag3H231JUDEi9QJVG3CgEzhaCHK0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co5uGoR47RUPKOPV5pog0D4Gws2q/8naBqA76jAjUFqwCpIQKJvbyHCyO7cPuE81IYHY10+VuYU8d94Tfe/iNvvex8jH/uFuSp81jVdG0VAmlgza5x0XHGXE+bxK/Wt7sHYbQ4BBU6ayisRksOYTk4XxyVGNnOT8GujMDoCMKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Ljrjr7hx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Ljrjr7hx"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9aea40d799so3082315a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 22:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788931231; x=1789536031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s8uuW9xzh0OfZUmX+ssxhvC5ZxVkL/aeqk5/TeQ23pc=;
        b=Ljrjr7hxSRgbNcRszYXMO84ugiEprYslqyyesbbC9ZnK1QoUIGJG7oPaWJQ/5zeM9k
         YEPhathi2ucELhfwbHem1xUOgr4BeuxYYz5gObc9fb06NwnqiD6qmS/LIzt0ajTp2GJP
         uFqsogdvBnuhL4YuU1gKeAlK05CqfXnlsqQZ6iJd0t4TAw84j8uEA/k0dGCriNooGn4k
         voaEWpfY591eqVIiZ7kmZ/NcrbE1UgrrMiqHllWe2LVFNCnwlrHdCMa41rzcm/f36y9A
         pp37w4zySTaMpCE4gN4TD12YN7PTJN8WWalc6QIR8J3v6aWz/a/tb0ErvQnGpF3LRtT/
         mhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788931231; x=1789536031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s8uuW9xzh0OfZUmX+ssxhvC5ZxVkL/aeqk5/TeQ23pc=;
        b=ZSkkiSauDhHMQU+EsY453xQG10HJkat0MTZL6F7jut5c9LjePAFy7NgQDUAtTHsgBH
         CFuIyPEFYvKFTsuPbwA6cph+eEtdoFWjw+3aWqBEhAyMgneQL3GSjVqA9wty+KmU91n5
         wuJm74LU2Guevw7R8AlhvTssWbZpBEQExbXILy4hEm6PuYpFGcRuMHReOknVz7T885hi
         n9XevB532cXSKfhVsyU9yCZtVIHucDD0gpS5u759oGzbTqxP4Wf9TcRdHeB0K83LACRy
         bLfNJmsHZSGj0Gic4d9LSC3zXokb1jnrrAKQI0ahD3imzvMMJL7EYtEHK4a60UMJ+kuH
         gQHQ==
X-Forwarded-Encrypted: i=1; AKwUvByDlOMXEnZyArUIYcIc/LLLKKaTP2Suo33lEFRmGuslwrq1O2SugDs5e9YhstWVJ3XlY3K/6oM=@vger.kernel.org
X-Gm-Message-State: AFuF++l6C2sB9iOjpEJRXPkf37bZP7F65wBh7Og1eUe1ltX/scpC6tCX
	DvQ2l/qMZ9/KcKRgKZqxGJteiGrrnBRFm8ngErjizukkvn3mjPquNmBvVk01hT+8p4sX
X-Gm-Gg: AYBFou0yeNArErom/8LQR/8J3teA6A4Vb2ZbK8cJLYzf58Do33cdmTZm9Hf/iBfU6c3
	bOSuHjoSi2wZaLzDRSpe5n1y5brWQuQpdE0b6c5NmBvLYSN+NPWBVHFzLruHxKGP9tud7HJa8Sc
	Ki4klgXu18zeDF19S1N34vK4P6t3/bXmCRcxefFuho0c81K7a1YGwqb7rHbuQFmG9sRalNYE+RK
	pwpkT1Nf7374AuEnLb5vs+WnzdToh9JVj+xZV2SOfuVJsmLAt9/ifFrLNi9ZSbzL0ILXET8EpMp
	hDn3p5A3o8qn3oXd9O78Yuiath5oKaB+tg4BdRlJ0ydXmQLbDfMNllJl4YPXyS7BtyTMcGJIMlH
	PrXMFd/O6NMSa3BoY4byeNvdZmJ389wy4+1afeyal0qSFbP/GVJJdcwUxFaStTltX3iHcvf5US1
	OtUXDNvGCFZLdMRkHzs+L5v5bN6DPFJLiGZxjwy9qb+ZJmqmS+sOFc9gb/C6FiXtGNTY5p/Zsj/
	WxjC6Of62K8RXoIwoE=
X-Received: by 2002:a17:90b:4d06:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-39b2614df74mr47126361a91.1.1788931230748;
        Tue, 08 Sep 2026 22:20:30 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm40920142eec.19.2026.09.08.22.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 22:20:30 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	horms@kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	pengpeng@iscas.ac.cn,
	raoxu@uniontech.com,
	rosenp@gmail.com,
	dddddd@hust.edu.cn,
	joe@dama.to,
	ian.ray@gehealthcare.com,
	kuniyu@google.com,
	linma@zju.edu.cn,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH v3 1/1] net: nfc: fix use-after-free in nfc_get_local_general_bytes
Date: Wed,  9 Sep 2026 13:19:24 +0800
Message-ID: <3cbaac3bee23f8ff3a3284ed32d347696eb1d208.1788841683.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788841682.git.rakukuip@gmail.com>
References: <cover.1788841682.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Commit 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
nfc_llcp_find_local") attempted to fix a use-after-free (UAF) issue by
invoking nfc_llcp_local_put(local) after accessing local->gb. However,
if the reference count drops to zero, local is freed immediately,
leading to a use-after-free when callers access the returned pointer.
Alternative approaches using dynamic allocation (e.g. kmemdup) introduced
memory leaks because callers consistently treat the returned pointer as
borrowed memory.

Fix this properly by refactoring nfc_llcp_general_bytes() and
nfc_get_local_general_bytes() to accept a caller-provided output buffer
(out_gb) and its maximum length (gb_max_len). The general bytes are
safely copied into out_gb before calling nfc_llcp_local_put(local),
ensuring safe lifetime management without ownership transfer complications.

Update all callers across drivers (microread, pn533, pn544, st21nfca,
digital_dep, and nci) to provide their own destination buffers and pass
them to nfc_get_local_general_bytes().

Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
v3:
 - Include <net/nfc/nfc.h> in pn533.h to fix build error in uart.c
   caused by undefined NFC_MAX_GT_LEN.
 - Restore nci_request() in nci_set_local_general_bytes() to preserve
   ndev->req_lock synchronization (avoid unlocked __nci_request() via
   nci_set_config()).
v2:
 - Use caller-provided output buffers to fix UAF instead of dynamic
   allocation (kmemdup), avoiding memory leaks.
---
 drivers/nfc/microread/microread.c |  6 +++---
 drivers/nfc/pn533/pn533.c         | 14 ++++++++------
 drivers/nfc/pn533/pn533.h         |  4 +++-
 drivers/nfc/pn544/pn544.c         |  7 +++----
 drivers/nfc/st21nfca/core.c       |  8 ++++----
 include/net/nfc/hci.h             |  2 +-
 include/net/nfc/nfc.h             |  3 ++-
 net/nfc/core.c                    | 15 +++++++--------
 net/nfc/digital_dep.c             |  8 ++++----
 net/nfc/llcp_core.c               | 17 +++++++++++++----
 net/nfc/nci/core.c                | 10 +++++-----
 net/nfc/nfc.h                     |  3 ++-
 12 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 4149c5d735bd..620562c3333f 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -251,9 +251,9 @@ static int microread_start_poll(struct nfc_hci_dev *hdev,
 		param[1] |= (1 << 1);
 
 	if ((im_protocols | tm_protocols) & NFC_PROTO_NFC_DEP_MASK) {
-		hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
-						       &hdev->gb_len);
-		if (hdev->gb == NULL || hdev->gb_len == 0) {
+		nfc_get_local_general_bytes(hdev->ndev, hdev->gb,
+					    sizeof(hdev->gb), &hdev->gb_len);
+		if (hdev->gb_len == 0) {
 			im_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 			tm_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 		}
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index d7bdbc82e2ba..777cfb7f8b13 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1346,10 +1346,11 @@ static int pn533_poll_dep(struct nfc_dev *nfc_dev)
 	u8 *next, nfcid3[NFC_NFCID3_MAXSIZE];
 	u8 passive_data[PASSIVE_DATA_LEN] = {0x00, 0xff, 0xff, 0x00, 0x3};
 
-	if (!dev->gb) {
-		dev->gb = nfc_get_local_general_bytes(nfc_dev, &dev->gb_len);
-
-		if (!dev->gb || !dev->gb_len) {
+	if (!dev->gb_len) {
+		nfc_get_local_general_bytes(nfc_dev, dev->gb,
+					    sizeof(dev->gb),
+					    &dev->gb_len);
+		if (!dev->gb_len) {
 			dev->poll_dep = 0;
 			queue_work(dev->wq, &dev->rf_work);
 		}
@@ -1647,8 +1648,9 @@ static int pn533_start_poll(struct nfc_dev *nfc_dev,
 	}
 
 	if (tm_protocols) {
-		dev->gb = nfc_get_local_general_bytes(nfc_dev, &dev->gb_len);
-		if (dev->gb == NULL)
+		nfc_get_local_general_bytes(nfc_dev, dev->gb,
+					    sizeof(dev->gb), &dev->gb_len);
+		if (dev->gb_len == 0)
 			tm_protocols = 0;
 	}
 
diff --git a/drivers/nfc/pn533/pn533.h b/drivers/nfc/pn533/pn533.h
index 09e35b8693f5..5ab668e05121 100644
--- a/drivers/nfc/pn533/pn533.h
+++ b/drivers/nfc/pn533/pn533.h
@@ -6,6 +6,8 @@
  * Copyright (C) 2012-2013 Tieto Poland
  */
 
+#include <net/nfc/nfc.h>
+
 #define PN533_DEVICE_STD		0x1
 #define PN533_DEVICE_PASORI		0x2
 #define PN533_DEVICE_ACR122U		0x3
@@ -166,7 +168,7 @@ struct pn533 {
 	struct timer_list listen_timer;
 	int cancel_listen;
 
-	u8 *gb;
+	u8 gb[NFC_MAX_GT_LEN];
 	size_t gb_len;
 
 	u8 tgt_available_prots;
diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index 9d0a16ac465e..c4fa70e45c14 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -377,10 +377,9 @@ static int pn544_hci_start_poll(struct nfc_hci_dev *hdev,
 		return r;
 
 	if ((im_protocols | tm_protocols) & NFC_PROTO_NFC_DEP_MASK) {
-		hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
-							&hdev->gb_len);
-		pr_debug("generate local bytes %p\n", hdev->gb);
-		if (hdev->gb == NULL || hdev->gb_len == 0) {
+		nfc_get_local_general_bytes(hdev->ndev, hdev->gb,
+					    sizeof(hdev->gb), &hdev->gb_len);
+		if (hdev->gb_len == 0) {
 			im_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 			tm_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 		}
diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index fd39a05c9622..6bfeb8e7ed89 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -351,10 +351,10 @@ static int st21nfca_hci_start_poll(struct nfc_hci_dev *hdev,
 			if (r < 0)
 				return r;
 		} else {
-			hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
-							       &hdev->gb_len);
-
-			if (hdev->gb == NULL || hdev->gb_len == 0) {
+			nfc_get_local_general_bytes(hdev->ndev, hdev->gb,
+						    sizeof(hdev->gb),
+						    &hdev->gb_len);
+			if (hdev->gb_len == 0) {
 				im_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 				tm_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 			}
diff --git a/include/net/nfc/hci.h b/include/net/nfc/hci.h
index 756c11084f65..86ed63e5d533 100644
--- a/include/net/nfc/hci.h
+++ b/include/net/nfc/hci.h
@@ -144,7 +144,7 @@ struct nfc_hci_dev {
 	data_exchange_cb_t async_cb;
 	void *async_cb_context;
 
-	u8 *gb;
+	u8 gb[NFC_MAX_GT_LEN];
 	size_t gb_len;
 
 	unsigned long quirks;
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index c54df042db6b..bcafab5c53e5 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -273,7 +273,8 @@ struct sk_buff *nfc_alloc_recv_skb(unsigned int size, gfp_t gfp);
 
 int nfc_set_remote_general_bytes(struct nfc_dev *dev,
 				 const u8 *gt, u8 gt_len);
-u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, size_t *gb_len);
+u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, u8 *out_gb,
+				size_t gb_max_len, size_t *gb_len);
 
 int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
 			 u32 result);
diff --git a/net/nfc/core.c b/net/nfc/core.c
index a92a6566e6a0..f521669293f0 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -279,10 +279,10 @@ static struct nfc_target *nfc_find_target(struct nfc_dev *dev, u32 target_idx)
 
 int nfc_dep_link_up(struct nfc_dev *dev, int target_index, u8 comm_mode)
 {
-	int rc = 0;
-	u8 *gb;
-	size_t gb_len;
 	struct nfc_target *target;
+	u8 gb[NFC_MAX_GT_LEN];
+	size_t gb_len = 0;
+	int rc = 0;
 
 	pr_debug("dev_name=%s comm %d\n", dev_name(&dev->dev), comm_mode);
 
@@ -301,7 +301,7 @@ int nfc_dep_link_up(struct nfc_dev *dev, int target_index, u8 comm_mode)
 		goto error;
 	}
 
-	gb = nfc_llcp_general_bytes(dev, &gb_len);
+	nfc_get_local_general_bytes(dev, gb, sizeof(gb), &gb_len);
 	if (gb_len > NFC_MAX_GT_LEN) {
 		rc = -EINVAL;
 		goto error;
@@ -644,11 +644,10 @@ int nfc_set_remote_general_bytes(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 }
 EXPORT_SYMBOL(nfc_set_remote_general_bytes);
 
-u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, size_t *gb_len)
+u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, u8 *out_gb,
+				size_t gb_max_len, size_t *gb_len)
 {
-	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
-
-	return nfc_llcp_general_bytes(dev, gb_len);
+	return nfc_llcp_general_bytes(dev, out_gb, gb_max_len, gb_len);
 }
 EXPORT_SYMBOL(nfc_get_local_general_bytes);
 
diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index 3982fa084737..968547c306a5 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -1490,14 +1490,14 @@ static int digital_tg_send_atr_res(struct nfc_digital_dev *ddev,
 				   struct digital_atr_req *atr_req)
 {
 	struct digital_atr_res *atr_res;
+	u8 gb[NFC_MAX_GT_LEN];
 	struct sk_buff *skb;
-	u8 *gb, payload_bits;
+	u8 payload_bits;
 	size_t gb_len;
 	int rc;
 
-	gb = nfc_get_local_general_bytes(ddev->nfc_dev, &gb_len);
-	if (!gb)
-		gb_len = 0;
+	nfc_get_local_general_bytes(ddev->nfc_dev, gb, sizeof(gb),
+				    &gb_len);
 
 	skb = digital_skb_alloc(ddev, sizeof(struct digital_atr_res) + gb_len);
 	if (!skb)
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index dc65c719f35f..24cf212bf3f8 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -635,23 +635,32 @@ static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
 	return ret;
 }
 
-u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
+u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len,
+			   size_t *general_bytes_len)
 {
 	struct nfc_llcp_local *local;
 
+	if (!out_gb || !general_bytes_len)
+		return NULL;
+
 	local = nfc_llcp_find_local(dev);
-	if (local == NULL) {
+	if (!local) {
 		*general_bytes_len = 0;
 		return NULL;
 	}
 
 	nfc_llcp_build_gb(local);
 
-	*general_bytes_len = local->gb_len;
+	if (local->gb_len) {
+		*general_bytes_len = min_t(size_t, local->gb_len, gb_max_len);
+		memcpy(out_gb, local->gb, *general_bytes_len);
+	} else {
+		*general_bytes_len = 0;
+	}
 
 	nfc_llcp_local_put(local);
 
-	return local->gb;
+	return out_gb;
 }
 
 int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5f46c4b5720f..73e3a96470ac 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -780,15 +780,15 @@ static int nci_set_local_general_bytes(struct nfc_dev *nfc_dev)
 {
 	struct nci_dev *ndev = nfc_get_drvdata(nfc_dev);
 	struct nci_set_config_param param;
+	u8 gb[NFC_MAX_GT_LEN];
 	int rc;
 
-	param.val = nfc_get_local_general_bytes(nfc_dev, &param.len);
-	if ((param.val == NULL) || (param.len == 0))
+	nfc_get_local_general_bytes(nfc_dev, gb, sizeof(gb),
+				    &param.len);
+	if (param.len == 0)
 		return 0;
 
-	if (param.len > NFC_MAX_GT_LEN)
-		return -EINVAL;
-
+	param.val = gb;
 	param.id = NCI_PN_ATR_REQ_GEN_BYTES;
 
 	rc = nci_request(ndev, nci_set_config_req, &param,
diff --git a/net/nfc/nfc.h b/net/nfc/nfc.h
index 0b1e6466f4fb..82c5dfdad10e 100644
--- a/net/nfc/nfc.h
+++ b/net/nfc/nfc.h
@@ -49,7 +49,8 @@ void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
 int nfc_llcp_register_device(struct nfc_dev *dev);
 void nfc_llcp_unregister_device(struct nfc_dev *dev);
 int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len);
-u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len);
+u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len,
+			   size_t *general_bytes_len);
 int nfc_llcp_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev);
 int nfc_llcp_local_put(struct nfc_llcp_local *local);
-- 
2.43.0
