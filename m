Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A093F86E0
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120160; cv=none; b=cVVg11+sn+eKOcbxhqF3EF//7a3bUXuxpipzWB5FXycyrsHSwlSLENjjcnIPW+LdOl4AY3FkY7CML9e2k4lET375CV9T+ixLVFIbRrz98olseDnt2qzG7JcrMF6K2uXU6C7RUCyl6cUtFaSY7K5dnJExtXZCxIbxQXFbg6X9Iic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120160; c=relaxed/simple;
	bh=//rpAe3Qqwml6p7iioxSCtRJm4GnWGCuBG+pqN3Xff4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFvpTiermqpr3dxI8w/ugXixCutKp8ymJIsssrWWxmjwJVkOElAUHSOOslzIWlg9RJd0iuo/ryyMUjBLvB+jpmQ+AicKbIpqgXhfCrPWh+bBDTUQiZhq4Zp4kUN8D2oV97Yx/SWFHOQIl/qtF7T2On58Oa1kxSKq8XQ63noQiig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=SdvebITZ; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="SdvebITZ"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so1234549a91.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786120158; x=1786724958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxt2GxOrc+xCi8Pf5TPqmLwVbPShVG3kpwrPeAQtE40=;
        b=SdvebITZOqc+FIYRYjrLqAoaHvJpnSOQq9wMCo2ajNjJ7IqY771bhhltIw3Q5Lsv/c
         fKsNWtgtSeWEkB1EjZANwUs5ZmcUUfIsYkuEV+0sephdlMR4i0nhtzf3c5frXwn0IZjr
         hPDIyyHFJ6QavaKbtuGsNGhc70/t+obOYWe+U++3wla7QmvMMRt5Z0xLQv44aJw/auNJ
         Na2qSMibGX/qLNgC755EFYHIkibxx4cEGIF70zwthlsQgQwu++Ng2Ciw8EUYG2nJpHBO
         DM35xviqPMhm/2i/uiuiDXF59QV6NRSHNzpBWMl6NkjTjpRcEvhSZIBhZ9dLZQvmNaEj
         rl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786120158; x=1786724958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sxt2GxOrc+xCi8Pf5TPqmLwVbPShVG3kpwrPeAQtE40=;
        b=ioMVO1k3/oPMR9JR0GTZvuDgTDsubU9X0EOxe7PT1F6avHpTNQhx4QRTU+FVwwG+so
         w89WlYxH7b4YEm03FiRGBMuCg2ngzYaGpFQkyGxiqi0Ia6TGvr59hdFmAIKzdheJR2va
         7e6XkPyzrMKYkvRu7+YIugqBB0nmKC8zCCFrop607KQPgQneSpBuLIaSFips57VpMvnT
         d+UkXY9RD0zr9UE+paQE7Q8Woe3Nl7DAwgFUP6WLKRu80oDRdkdjRnoeBBps094DNIBH
         1OqIdlvs4UgXRgMFmn0c21PinXASNXi+3xmPC/Yc9HNhorE6y5/3CyVcqpBob7ew8+mx
         v8pA==
X-Forwarded-Encrypted: i=1; AHgh+RqOTcztHjx4n9U1OD5FY1Z47x3hkwY2CQT7vW1sd22ya+zpFfrVbU/aHVLA6mxOI+SIoasvFNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwESEzWj934mH9VwjVYqW26AYo5Hg63eVFN0txEkNlFxBvj+f0K
	8ZfwwasL1mIyIxa10oyGnv0dVhrQ/eZfSYMu06LkJplTipd7MzfgSTRw/Dz0/y5wCZdt
X-Gm-Gg: AR+sD11hGklgVQN4JULd08u6ZTZ5hB+r5aSklvSUFY6o0D/86pnLsxsHmvuPOdRnsFI
	KSECkiiu6Pfy9XZ1m6HGWqhDG0dTbjB0Hyv4WqmdXB45SoHg3iAWQPlef3eC+7E7zif+Pm9SZ6u
	IeX4hTYk4enUnKdwziiSSlcFnSW2pausvAO2J3ghBRYmCoWrH5i9GN+5O4Z6Yqz6WW/8xnjAuLp
	MWLpfamzJIE1W2EEiq92HdiyaDxR0c7fwDfIkeowIb00z708+Y5oXP9iy+AcDuJhbmIHvQNDQ4+
	qO6O/d5KtN0Zl9zll/2Ue4L52znRhimmNR9+31W/aUYNIq+kJ0hto89rj88ZSZoSsbpwVdx5lOB
	5V1kuQq8saeM74SRzSWU+3i+3n+fZwgMLdeUZkuU2+2ZyAzalwa33YCXKSSjxevMRXo8eqsqYSn
	MgM3Xmkvaee9vziNr9y2/5ZXCC4ta95VYWtUPyiphuA6rdWgBqwUquzxc=
X-Received: by 2002:a17:90a:ec8e:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-3903c53827bmr26399611a91.2.1786120157909;
        Fri, 07 Aug 2026 09:29:17 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6dfcdsm3179485a91.4.2026.08.07.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:29:17 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pengpeng@iscas.ac.cn,
	kees@kernel.org,
	error27@gmail.com,
	raoxu@uniontech.com,
	dddddd@hust.edu.cn,
	ian.ray@gehealthcare.com,
	joe@dama.to,
	kuniyu@google.com,
	linma@zju.edu.cn,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 1/1] nfc: llcp: Pass caller buffer to nfc_llcp_general_bytes to fix UAF and memory leaks
Date: Sat,  8 Aug 2026 00:28:51 +0800
Message-ID: <006437e618b55acc0df69d94255244a490b11461.1786029423.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1786029423.git.rakukuip@gmail.com>
References: <cover.1786029423.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

commit 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
attempted to fix a use-after-free (UAF) issue by
invoking nfc_llcp_local_put(local) after accessing local->gb. However,
if the reference count dropped to zero, local was freed prematurely,
leading to a Use-After-Free when the returned pointer was accessed.
Alternative approaches using dynamic allocation (such as kmemdup) introduced
severe memory leaks and state inconsistency because callers consistently
treated the returned pointer as borrowed memory.

Fix this properly by refactoring nfc_llcp_general_bytes() and
nfc_get_local_general_bytes() to accept a caller-provided output buffer
(out_gb) and its maximum length (gb_max_len). The general bytes are
safely copied into out_gb BEFORE calling nfc_llcp_local_put(local),
ensuring safe lifetime management without ownership transfer complications.

Update all callers across drivers (microread, pn533, pn544, st21nfca,
digital_dep, and nci) to allocate local stack buffers of size
NFC_MAX_GT_LEN and pass them to nfc_get_local_general_bytes().

Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 drivers/nfc/microread/microread.c |  5 ++---
 drivers/nfc/pn533/pn533.c         | 10 +++++-----
 drivers/nfc/pn533/pn533.h         |  2 +-
 drivers/nfc/pn544/pn544.c         |  7 +++----
 drivers/nfc/st21nfca/core.c       |  5 ++---
 include/net/nfc/hci.h             |  2 +-
 include/net/nfc/nfc.h             |  2 +-
 net/nfc/core.c                    | 10 +++++-----
 net/nfc/digital_dep.c             |  3 ++-
 net/nfc/llcp_core.c               | 18 ++++++++++++------
 net/nfc/nci/core.c                |  3 ++-
 net/nfc/nfc.h                     |  2 +-
 12 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 4149c5d735bd..0f0a03da9ff4 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -251,9 +251,8 @@ static int microread_start_poll(struct nfc_hci_dev *hdev,
 		param[1] |= (1 << 1);
 
 	if ((im_protocols | tm_protocols) & NFC_PROTO_NFC_DEP_MASK) {
-		hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
-						       &hdev->gb_len);
-		if (hdev->gb == NULL || hdev->gb_len == 0) {
+		nfc_get_local_general_bytes(hdev->ndev, hdev->gb, sizeof(hdev->gb), &hdev->gb_len);
+		if (hdev->gb_len == 0) {
 			im_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 			tm_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 		}
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index d7bdbc82e2ba..b3ac3f31518d 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1346,10 +1346,10 @@ static int pn533_poll_dep(struct nfc_dev *nfc_dev)
 	u8 *next, nfcid3[NFC_NFCID3_MAXSIZE];
 	u8 passive_data[PASSIVE_DATA_LEN] = {0x00, 0xff, 0xff, 0x00, 0x3};
 
-	if (!dev->gb) {
-		dev->gb = nfc_get_local_general_bytes(nfc_dev, &dev->gb_len);
+	if (!dev->gb_len) {
+		nfc_get_local_general_bytes(nfc_dev, dev->gb, sizeof(dev->gb), &dev->gb_len);
 
-		if (!dev->gb || !dev->gb_len) {
+		if (!dev->gb_len) {
 			dev->poll_dep = 0;
 			queue_work(dev->wq, &dev->rf_work);
 		}
@@ -1647,8 +1647,8 @@ static int pn533_start_poll(struct nfc_dev *nfc_dev,
 	}
 
 	if (tm_protocols) {
-		dev->gb = nfc_get_local_general_bytes(nfc_dev, &dev->gb_len);
-		if (dev->gb == NULL)
+		nfc_get_local_general_bytes(nfc_dev, dev->gb, sizeof(dev->gb), &dev->gb_len);
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
index 9d0a16ac465e..098b29d9a68e 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -377,10 +377,9 @@ static int pn544_hci_start_poll(struct nfc_hci_dev *hdev,
 		return r;
 
 	if ((im_protocols | tm_protocols) & NFC_PROTO_NFC_DEP_MASK) {
-		hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
-							&hdev->gb_len);
-		pr_debug("generate local bytes %p\n", hdev->gb);
-		if (hdev->gb == NULL || hdev->gb_len == 0) {
+		nfc_get_local_general_bytes(hdev->ndev, hdev->gb, sizeof(hdev->gb), &hdev->gb_len);
+		pr_debug("generate local bytes len %zu\n", hdev->gb_len);
+		if (hdev->gb_len == 0) {
 			im_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 			tm_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 		}
diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index fd39a05c9622..0f49bf6af522 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -351,10 +351,9 @@ static int st21nfca_hci_start_poll(struct nfc_hci_dev *hdev,
 			if (r < 0)
 				return r;
 		} else {
-			hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
-							       &hdev->gb_len);
+			nfc_get_local_general_bytes(hdev->ndev, hdev->gb, sizeof(hdev->gb), &hdev->gb_len);
 
-			if (hdev->gb == NULL || hdev->gb_len == 0) {
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
index c54df042db6b..cfb9111bdf4e 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -273,7 +273,7 @@ struct sk_buff *nfc_alloc_recv_skb(unsigned int size, gfp_t gfp);
 
 int nfc_set_remote_general_bytes(struct nfc_dev *dev,
 				 const u8 *gt, u8 gt_len);
-u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, size_t *gb_len);
+u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len, size_t *gb_len);
 
 int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
 			 u32 result);
diff --git a/net/nfc/core.c b/net/nfc/core.c
index a92a6566e6a0..af7edf2687ef 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -280,9 +280,9 @@ static struct nfc_target *nfc_find_target(struct nfc_dev *dev, u32 target_idx)
 int nfc_dep_link_up(struct nfc_dev *dev, int target_index, u8 comm_mode)
 {
 	int rc = 0;
-	u8 *gb;
-	size_t gb_len;
 	struct nfc_target *target;
+	u8 gb[NFC_MAX_GT_LEN];
+	size_t gb_len = 0;
 
 	pr_debug("dev_name=%s comm %d\n", dev_name(&dev->dev), comm_mode);
 
@@ -301,7 +301,7 @@ int nfc_dep_link_up(struct nfc_dev *dev, int target_index, u8 comm_mode)
 		goto error;
 	}
 
-	gb = nfc_llcp_general_bytes(dev, &gb_len);
+	nfc_get_local_general_bytes(dev, gb, sizeof(gb), &gb_len);
 	if (gb_len > NFC_MAX_GT_LEN) {
 		rc = -EINVAL;
 		goto error;
@@ -644,11 +644,11 @@ int nfc_set_remote_general_bytes(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 }
 EXPORT_SYMBOL(nfc_set_remote_general_bytes);
 
-u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, size_t *gb_len)
+u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len, size_t *gb_len)
 {
 	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
 
-	return nfc_llcp_general_bytes(dev, gb_len);
+	return nfc_llcp_general_bytes(dev, out_gb, gb_max_len, gb_len);
 }
 EXPORT_SYMBOL(nfc_get_local_general_bytes);
 
diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index 3982fa084737..a0218497e82d 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -1490,12 +1490,13 @@ static int digital_tg_send_atr_res(struct nfc_digital_dev *ddev,
 				   struct digital_atr_req *atr_req)
 {
 	struct digital_atr_res *atr_res;
+	u8 local_gb[NFC_MAX_GT_LEN];
 	struct sk_buff *skb;
 	u8 *gb, payload_bits;
 	size_t gb_len;
 	int rc;
 
-	gb = nfc_get_local_general_bytes(ddev->nfc_dev, &gb_len);
+	gb = nfc_get_local_general_bytes(ddev->nfc_dev, local_gb, sizeof(local_gb), &gb_len);
 	if (!gb)
 		gb_len = 0;
 
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index dc65c719f35f..1ed0ecde5872 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -635,23 +635,29 @@ static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
 	return ret;
 }
 
-u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
+u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len, size_t *general_bytes_len)
 {
 	struct nfc_llcp_local *local;
 
+	if (!out_gb || !general_bytes_len)
+		return NULL;
+
+	*general_bytes_len = 0;
+
 	local = nfc_llcp_find_local(dev);
-	if (local == NULL) {
-		*general_bytes_len = 0;
+	if (local == NULL)
 		return NULL;
-	}
 
 	nfc_llcp_build_gb(local);
 
-	*general_bytes_len = local->gb_len;
+	if (local->gb && local->gb_len) {
+		*general_bytes_len = min_t(size_t, local->gb_len, gb_max_len);
+		memcpy(out_gb, local->gb, *general_bytes_len);
+	}
 
 	nfc_llcp_local_put(local);
 
-	return local->gb;
+	return out_gb;
 }
 
 int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 5f46c4b5720f..d27fe4f8456a 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -780,9 +780,10 @@ static int nci_set_local_general_bytes(struct nfc_dev *nfc_dev)
 {
 	struct nci_dev *ndev = nfc_get_drvdata(nfc_dev);
 	struct nci_set_config_param param;
+	u8 local_gb[NFC_MAX_GT_LEN];
 	int rc;
 
-	param.val = nfc_get_local_general_bytes(nfc_dev, &param.len);
+	param.val = nfc_get_local_general_bytes(nfc_dev, local_gb, sizeof(local_gb), &param.len);
 	if ((param.val == NULL) || (param.len == 0))
 		return 0;
 
diff --git a/net/nfc/nfc.h b/net/nfc/nfc.h
index 0b1e6466f4fb..6caec88f7400 100644
--- a/net/nfc/nfc.h
+++ b/net/nfc/nfc.h
@@ -49,7 +49,7 @@ void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
 int nfc_llcp_register_device(struct nfc_dev *dev);
 void nfc_llcp_unregister_device(struct nfc_dev *dev);
 int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len);
-u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len);
+u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len, size_t *general_bytes_len);
 int nfc_llcp_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev);
 int nfc_llcp_local_put(struct nfc_llcp_local *local);
-- 
2.43.0
