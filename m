Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BA40BCD4
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274093; cv=none; b=ej+os2IsUdzGWqxAhfjNj1wYpoek7FUfhXR05TlTL7/yqpUzg1/snk5/r6/ID83+yJaPBYTNzuamECc5iXK5tB0RJ0DjgjFwZOPTG2G1ac0aOtf09PTyFLfCFF9gZv1JUkItpxoKYIURB2PIoRTRkj87h/RvRdB+kqcWJITH3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274093; c=relaxed/simple;
	bh=j3uHM/6H/fgm8xmqoNWtzSL20lTN4CywQZbVN29SU8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRymxV/GVLPfxPLoDv9cPdg3d0d/+aEQLeLmEeWoAd8JyFmM9Ti6G5JM1wCGQLhNwcA4f6UIIhHEW1T2Siltu57VxuKGhD87bhAGHLrOXh2pmhyIogFQLx/BBfQ97B/G9TlX7fNOrpmMvZR8UY/nolInV/txnjlnDIwFiOl9ThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=DWZeqLVB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="DWZeqLVB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d715f4a587so14391135ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788274091; x=1788878891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nR329y2qYaW8xSmiCVlnh+xdrzEvbAOOkk663gQinG0=;
        b=DWZeqLVBPnaDDnhwR23oC3yT67EPQUuoFii/Lt9nZg1fDOrDgxeOkFJpDUtAlFJezi
         0mw3+jPPSTCSMhn5Iia4G4yI7zNX+TVYP73LwZ3urFbwUm1jNB8bmq9VZLqs4Oa9Y4gt
         5xomsGK9K5UEIF6ig8DjYeg0HfADoU6HcsDIxZPmbvElv6C/y2AcNHgysUIo3iVV8MtC
         BL0Gydvukj/JRVm2cVN7gJ6s8PRhWep0v5Ch81YPWmFgtYvpvlaRD2LqkTspmziN7CMi
         9RQ5rlQrJrLNY+uGRzG0fYMBdmup6iovohoIH8gAhUVnZCP5EnYO957C1SwSKlarcNvf
         DqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274091; x=1788878891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nR329y2qYaW8xSmiCVlnh+xdrzEvbAOOkk663gQinG0=;
        b=SmFXqBUI9XdUEz/HvyC6oc3pc36t03Sueo2tQHlxo+ycwbSmCv/Y1C9/d+FC/2hMqA
         YmgPPcp/rwqhx2U2AljktzNE+F9+M+2UtqXkGg+4RyyWFC7XRn59Ka/qz3h3jJgcOfap
         bxi5FKFInHl9RdjnAvGs6bElNo7hSm4pDlkzfEaqeyLCs14U3NFuXBVSgvWdDe9++ANC
         yiNzREFpYJvLe+hVoB2pGIFNu0i6j8HKjx4qRTd4YB3ywDJ3lvO+QcCkKhMmKR+bfl0g
         kNcT/Xu9joEycXXOGSWpEYv8oVEEWVolGGn/Zq0uuOPyv/HCLGkBJZGZD3gfa9fp1v/S
         HKCQ==
X-Forwarded-Encrypted: i=1; AKwUvByVYibqRoQhCfOXnOFUrBmrCvSYb3oHS7bht3ltEHvmZfKgnb6BsrP7rMn4tReFpoiRpu1/H6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lAKcpdrQNncm5t9TGEEdzJGziAbmy/RiREOby33cBOvBlkhKNl
	N4UsTtIO6XbYIc+gUlsd2XteQRel4Wvsz32KVd4daVQma2UINky+SKqthKzCC59pHcN/
X-Gm-Gg: AYBFou087R9UQPOjY+tKNufSg+nMzhmOpiLj953bq6mLEYe6KhnrI/8kSm4ndKXe5Do
	m240xaBbnvolos17bECLPA2PO99mjSAtHgvjiq0qH+4/Xg/UsuRZVz71q/MrAT1A3914odSxmax
	F28ZVmi2QP+tqxZksddrTs8jqNT1CRbcOQtaIHIM70VZN0wblzGkDfG2sybKVUI3TuPj7qm+HWr
	/D7S+MFyaMTRrLoaJ/42XVLdCW3mrJfdqssd2ZMSwUiogdkVdLGN50kuhb2d+FARBoaeiv4IUpP
	LqNGgY3OcijPAjPruzicsbPTTSvhV+i8di4dcDn2bpq2worbRp2NKtrBRoB0J+UIof3jBuTXxHT
	ZSxzNNZ/DckCkhctFUGT6OUZEOCSMuWMtepoV8de52Bnl5IELjl1v3BZQOjf3FDiBmHasvq8qa7
	zQ2BhImczPr9MLQetkNaRgMougTYqrvzUZSDMbMqUBxvEgIg/p0Okfyd71hpZWiwiHV8peRXw=
X-Received: by 2002:a17:902:e74c:b0:2d8:d4cc:5bb2 with SMTP id d9443c01a7336-2d8d4cc5dacmr359430675ad.18.1788274091064;
        Tue, 01 Sep 2026 07:48:11 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd35da91sm245975ad.15.2026.09.01.07.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:48:09 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	horms@kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	error27@gmail.com,
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
Subject: [PATCH net v2 1/1] net: nfc: fix use-after-free in nfc_get_local_general_bytes
Date: Tue,  1 Sep 2026 22:47:32 +0800
Message-ID: <7023ed1e8d7522917d699222d9d5db7135184abb.1788157546.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788157545.git.rakukuip@gmail.com>
References: <cover.1788157545.git.rakukuip@gmail.com>
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
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 drivers/nfc/microread/microread.c |  6 +++---
 drivers/nfc/pn533/pn533.c         | 14 ++++++++------
 drivers/nfc/pn533/pn533.h         |  2 +-
 drivers/nfc/pn544/pn544.c         |  7 +++----
 drivers/nfc/st21nfca/core.c       |  8 ++++----
 include/net/nfc/hci.h             |  2 +-
 include/net/nfc/nfc.h             |  3 ++-
 net/nfc/core.c                    | 15 +++++++--------
 net/nfc/digital_dep.c             |  8 ++++----
 net/nfc/llcp_core.c               | 17 +++++++++++++----
 net/nfc/nci/core.c                | 16 +++++++---------
 net/nfc/nfc.h                     |  3 ++-
 12 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index dfa2490db545..2bfafa94e83d 100644
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
index f5a6a7c20d5a..b0133e51dce9 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1357,10 +1357,11 @@ static int pn533_poll_dep(struct nfc_dev *nfc_dev)
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
@@ -1658,8 +1659,9 @@ static int pn533_start_poll(struct nfc_dev *nfc_dev,
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
index 09e35b8693f5..d3425fcfd557 100644
--- a/drivers/nfc/pn533/pn533.h
+++ b/drivers/nfc/pn533/pn533.h
@@ -166,7 +166,7 @@ struct pn533 {
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
index cac1b5487064..260e4972083e 100644
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
index 5f46c4b5720f..e1893ae41808 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -780,26 +780,24 @@ static int nci_set_local_general_bytes(struct nfc_dev *nfc_dev)
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
 
-	rc = nci_request(ndev, nci_set_config_req, &param,
-			 msecs_to_jiffies(NCI_SET_CONFIG_TIMEOUT));
+	rc = nci_set_config(ndev, param.id, param.len, param.val);
 	if (rc)
 		return rc;
 
 	param.id = NCI_LN_ATR_RES_GEN_BYTES;
 
-	return nci_request(ndev, nci_set_config_req, &param,
-			   msecs_to_jiffies(NCI_SET_CONFIG_TIMEOUT));
+	return nci_set_config(ndev, param.id, param.len, param.val);
 }
 
 static int nci_set_listen_parameters(struct nfc_dev *nfc_dev)
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
