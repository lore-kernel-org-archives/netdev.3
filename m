Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553104;
	b=fwP+nSkZ6CXpLkPJSbcFPYk17/GEcXrxZdz2FxU4rXeEahTxq8BaVGcB08POnuLaBVdm
	 EEPfEKzZratSR6KhX3oZiPbSCkh78jPe4+59ZbTXDUMY4T+GV3oJe64k2JVOq/vfzfSm+
	 +vrRdFwbZIdBSgRC9pkGN8SAt41cGB87gZ3Ej4BFP3IaXY6hyhhLZE9OiF01GP5uMyvZy
	 XIvaFBWZAyMg1c747D6iMToeRI0ecb783AcYfLK1ZNCwFXvIBSUVIfW7uT2vPG39VdRiR
	 7T90nN+6yfxIXqalit5VlNQn/HkFf4eInBo2ifszA3V+i51pGIejo8mKubLcjPMIc1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6rj9QUbsFJOA4qpafrOsme0S3/Ei7bet+9iObpPybeA=;
	b=Jg5sgr84cjowyI7UFvOyhlbkggOzJ4Y+B9Z2FEsnLnXJfTzFXtSmRqpPuqkJVOp1gfE3
	 LzVA/bO4JAT0OAV7w16qVTfbZ8KjDfZEAyDk5W6GNLbgXrbv0yHb16PwKIm6bV6oWWUaH
	 AQLaj6VlwlsjjN+LLKfAJ1PBdcwYA9SxKK3S2jfbHArsH3LDNwGsR8bFuHxFk+dPDWFvO
	 NINm7QjKKwtvzqCeiW5COxEyUOsWQtChojnuqmvpdkGSNgpJ8qEcVD2O03AqKWYbi9cah
	 FBeStc8XIbxfR2xjQi3UYQle8FP6pM1umyLLLuxbjjmzzxzi+zBBfD0AcZD2x1xMrhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b="M8Rg+d/V";
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035F606E86E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C035F606E86E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=M8Rg+d/V
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e987a2ba0cso1832595ad.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553103; x=1793157903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rj9QUbsFJOA4qpafrOsme0S3/Ei7bet+9iObpPybeA=;
        b=M8Rg+d/VBawbUZ0HoRivCr1nPxgmn11XW7v+6bKGO2yryMZD5+kXkq1zHUy8Nnp0Nu
         THIiJ6I+rH++EGYJRgVPwMtXJ1kRtzoeg/h+jltqffSHrCNh3nMk3pO0rW9u3+D8ELIM
         /gbWrwr6z32I8eO5ES3yPjDZ2iH0UtThWAABm78rle1JR183AQhsHzDxVMDDSMuUHGQn
         d1QrUIQlerCgoC+/ZtDHz54cKduSG5f3Kq/j5RuXMJjyPQ51AhvLHF3yHAMhzt+ozLAK
         KVrPY68955VWdLeM7g6qgWCktCIsNRl0kGfpcKxAnJOv3t+gPG8KG3vRFq2ycNAX00Dt
         dOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553103; x=1793157903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rj9QUbsFJOA4qpafrOsme0S3/Ei7bet+9iObpPybeA=;
        b=aFmKZnWyo3Z55BXC/BA+HCdero2v40dwpHu1cgJXXxzHJ69mvGeLjRBa5jVCcxLD55
         jXGkZBFg6cHC/8OWATxmLxz/uufWvY0mC+nH8kkfx34/kVMGRuavrr9g1SNfj0XHcskD
         LQWOO1RZIo30FXN1poSnnfmEITkcWK4GhkBnACxG2e2EhkWMz7dZPM4rp1gbkzRLujpB
         9ACVJJnvbGRvVyOxgMsaIIKbOc9cJ6kbzZbznQwSsvL8E/X1LVwquTigAt8iFxWOtq6P
         D+NhBiBtE01jv8Dc46fXNeSTeqZ6jM+qhvW5r9N1ZhcGUCIu+xutCtL3z4XRLl19BT7h
         ebIg==
X-Gm-Message-State: AFq9FYIBC4BWv9Zp/xpSjsCzTIODz5ZcumJ2FtaJ86pYKjgB9U1TZ3QV
	5/61C8U8kd6/xmnmjQvPJFi0T8sZ6hmmkoW0xOrdTMtxN0ydcylKjuDV4n4Yf9BrGf2cQrhm3K8
	KUnjj
X-Gm-Gg: AYBFou3/dLO4d7diP5jJYRxmMHIeIyr61GFHAZeT9Cnldg6Qaz6HB9enuKZ0G3oOsLN
	bwVF9bzFRgXnBChkQcfTg59fyUdyvyeQXzIhyQ/yyT9//dakXrWuuK8iTv4WBtTZmf+T90eAN6r
	cRje4tyJwrsfD9xV2nLLtjK9RhgaQXKkzUgVsk++qZxPOGkss8SCPdz1830a2WY6ukzE3S94Xuc
	LlDktx7R+QdY1HyXaoRvSZJbrh/zR3VLsix9cjvnrqrFX31G3KqnFYFyFlgRLeCBQxDenWr/n2X
	tGt+IRlhJSOpRyR59rRHqIE+75uMFqbf9c3PhGuhIqj2qQOfBHmadICL0/c7jl5qF6xXILqvMG4
	dsgxlN/ew290essPKg7cVUhAzpVYTwOzrrpbABB3+apftXNFn5agT+7KCsrvo+q3PV4kuUBwBDg
	FxPN3biWRk0z+xwqdUYzJYQlltPcq4d7Tg8mIOIp/VlSga/+qxj3eBMF2jt9a/vjIEwHA1KkJx3
	9c2aXWx4BmEPkuHDv2dBmJGgR0bR2MKyLcyDMVV3ZNE3WmTPyO43mUokt1gDjrM8X91yd0bf4FD
	XKO3ot/S2HLcraOpanhR3smENQ94WuzmGU8px1Wkcvr09cD22AvghxzMw2arWAXh/j74IYqtkiT
	T
X-Received: by 2002:a17:90a:c107:b0:3a8:495b:d64b with SMTP id 98e67ed59e1d1-3ad86c2e6dfmr718797a91.4.1792553102953;
        Tue, 20 Oct 2026 20:25:02 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.25.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:25:02 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v6 5/6] nfc: serialize firmware download state
Date: Wed, 21 Oct 2026 08:54:42 +0530
Message-ID: <20261021032443.44412-6-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021032443.44412-1-shubham@octane.security>
References: <20261021032443.44412-1-shubham@octane.security>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_fw_download() marks a firmware download in progress but does not reject
a second request.  An overlapping request can replace driver-owned download
state, and an error from that request clears the shared in-progress flag
while the first download is still running.

Make the in-progress state atomic and claim it before invoking the driver.
An overlapping request then leaves the first download's state unchanged.
Copy the firmware name before releasing that claim, then send the
completion notification after the release so userspace can immediately
start its next operation.  Use release/acquire ordering so the next
operation observes the completed download cleanup.

OpenAI Codex, gpt-5.6-sol assisted a source audit of NFC firmware teardown.

Fixes: 9674da8759df ("NFC: Add firmware upload netlink command")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c       |  4 ++--
 drivers/nfc/nfcmrvl/uart.c       |  4 ++--
 drivers/nfc/st-nci/vendor_cmds.c |  8 ++++----
 include/net/nfc/nfc.h            |  3 ++-
 net/nfc/core.c                   | 19 ++++++++++++++-----
 5 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index b6f47cce0f1f..27fadd64155e 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -189,7 +189,7 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
 	if (priv->if_ops->nci_quiesce)
 		priv->if_ops->nci_quiesce(priv);
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress)
+	if (atomic_read(&priv->ndev->nfc_dev->fw_download_in_progress))
 		nfcmrvl_fw_dnld_abort(priv);
 
 	nfcmrvl_fw_dnld_deinit(priv);
@@ -213,7 +213,7 @@ int nfcmrvl_nci_recv_frame(struct nfcmrvl_private *priv, struct sk_buff *skb)
 		}
 	}
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress) {
+	if (atomic_read(&priv->ndev->nfc_dev->fw_download_in_progress)) {
 		nfcmrvl_fw_dnld_recv_frame(priv, skb);
 		return 0;
 	}
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 95223c20d50f..d87f6497baf2 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -176,7 +176,7 @@ static void nfcmrvl_nci_uart_tx_start(struct nci_uart *nu)
 {
 	struct nfcmrvl_private *priv = (struct nfcmrvl_private *)nu->drv_data;
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress)
+	if (atomic_read(&priv->ndev->nfc_dev->fw_download_in_progress))
 		return;
 
 	/* Remove BREAK to wake up the NFCC */
@@ -190,7 +190,7 @@ static void nfcmrvl_nci_uart_tx_done(struct nci_uart *nu)
 {
 	struct nfcmrvl_private *priv = (struct nfcmrvl_private *)nu->drv_data;
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress)
+	if (atomic_read(&priv->ndev->nfc_dev->fw_download_in_progress))
 		return;
 
 	/*
diff --git a/drivers/nfc/st-nci/vendor_cmds.c b/drivers/nfc/st-nci/vendor_cmds.c
index 6335d7afca24..ec577d497500 100644
--- a/drivers/nfc/st-nci/vendor_cmds.c
+++ b/drivers/nfc/st-nci/vendor_cmds.c
@@ -158,11 +158,12 @@ static int st_nci_hci_dm_fwupd_start(struct nfc_dev *dev, void *data,
 	int r;
 	struct nci_dev *ndev = nfc_get_drvdata(dev);
 
-	dev->fw_download_in_progress = true;
+	if (atomic_cmpxchg_acquire(&dev->fw_download_in_progress, 0, 1))
+		return -EBUSY;
 	r = nci_hci_send_cmd(ndev, ST_NCI_DEVICE_MGNT_GATE,
 			ST_NCI_HCI_DM_FWUPD_START, data, data_len, NULL);
 	if (r)
-		dev->fw_download_in_progress = false;
+		atomic_set_release(&dev->fw_download_in_progress, 0);
 
 	return r;
 }
@@ -181,8 +182,7 @@ static int st_nci_hci_dm_direct_load(struct nfc_dev *dev, void *data,
 {
 	struct nci_dev *ndev = nfc_get_drvdata(dev);
 
-	if (dev->fw_download_in_progress) {
-		dev->fw_download_in_progress = false;
+	if (atomic_xchg(&dev->fw_download_in_progress, 0)) {
 		return nci_hci_send_cmd(ndev, ST_NCI_DEVICE_MGNT_GATE,
 				ST_NCI_HCI_DM_LOAD, data, data_len, NULL);
 	}
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index bcafab5c53e5..f6cb17f46ca7 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -11,6 +11,7 @@
 #ifndef __NET_NFC_H
 #define __NET_NFC_H
 
+#include <linux/atomic.h>
 #include <linux/nfc.h>
 #include <linux/device.h>
 #include <linux/skbuff.h>
@@ -172,7 +173,7 @@ struct nfc_dev {
 	int targets_generation;
 	struct device dev;
 	bool dev_up;
-	bool fw_download_in_progress;
+	atomic_t fw_download_in_progress;
 	u8 rf_mode;
 	bool polling;
 	struct nfc_target *active_target;
diff --git a/net/nfc/core.c b/net/nfc/core.c
index f521669293f0..1f335fa7f6f0 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/rfkill.h>
 #include <linux/nfc.h>
+#include <linux/string.h>
 
 #include <net/genetlink.h>
 
@@ -53,10 +54,14 @@ int nfc_fw_download(struct nfc_dev *dev, const char *firmware_name)
 		goto error;
 	}
 
-	dev->fw_download_in_progress = true;
+	if (atomic_cmpxchg_acquire(&dev->fw_download_in_progress, 0, 1)) {
+		rc = -EBUSY;
+		goto error;
+	}
+
 	rc = dev->ops->fw_download(dev, firmware_name);
 	if (rc)
-		dev->fw_download_in_progress = false;
+		atomic_set_release(&dev->fw_download_in_progress, 0);
 
 error:
 	device_unlock(&dev->dev);
@@ -73,9 +78,12 @@ error:
 int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
 			 u32 result)
 {
-	dev->fw_download_in_progress = false;
+	char name[NFC_FIRMWARE_NAME_MAXSIZE + 1];
+
+	strscpy(name, firmware_name, sizeof(name));
+	atomic_set_release(&dev->fw_download_in_progress, 0);
 
-	return nfc_genl_fw_download_done(dev, firmware_name, result);
+	return nfc_genl_fw_download_done(dev, name, result);
 }
 EXPORT_SYMBOL(nfc_fw_download_done);
 
@@ -104,7 +112,7 @@ int nfc_dev_up(struct nfc_dev *dev)
 		goto error;
 	}
 
-	if (dev->fw_download_in_progress) {
+	if (atomic_read_acquire(&dev->fw_download_in_progress)) {
 		rc = -EBUSY;
 		goto error;
 	}
@@ -1073,6 +1081,7 @@ struct nfc_dev *nfc_allocate_device(const struct nfc_ops *ops,
 	dev->dev.class = &nfc_class;
 	dev_set_name(&dev->dev, "nfc%d", dev->idx);
 	device_initialize(&dev->dev);
+	atomic_set(&dev->fw_download_in_progress, 0);
 
 	dev->ops = ops;
 	dev->supported_protocols = supported_protocols;
-- 
2.43.0

