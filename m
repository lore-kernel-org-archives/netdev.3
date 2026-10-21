Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553101;
	b=AgMrg0iYB4dj3o50AgiVN+XFcqZoQGADU9p8edfK1FmGMlRFUEwZ/mi5oojNnqdSp3an
	 TsPqXrEsMv5CYHhtvkanM9UyLr2e5yZkSsbbDU36RXIUQ8cqAbfEHUYSjDpT79ztTZiXX
	 4R9wwuwhC1TAiu9Z3x7rqFRyswBB2crw8/CzNNc5ToGSNAk4V0NO/L0y38Dr+hnqFxEvk
	 x8irPkLA0jWL5hnJFp+l3kImelAP7fl3ckax5Il4LkL+9/m8lUldINTNoIUotJI2W26Ig
	 zrz+ZRT65sxpqGlWIQDgkhRTZb3tRqtxSZverEIl+qq1J3H9fFI2pvGgF4wzUnuPd7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VCfGQX5Enxz7dxwKYko3XxUHVAAWfi+FllLcCi4k6eA=;
	b=xjn6/y1viA4Hrrfy8Y1eF5cbcDSELUqaewyeT9wEZ/Zkb5/FKZQh1Yi844y48jtFf72w
	 9Nc7DEy6KyNwch1Sqt7mS14Nnx0/VhurM2QHImw1CWvmCJGsPM7/xlaZpIBf7ZZX0+aBG
	 RjipC2KPYMkH6wxG5+HaGqk6/9rW34nnodXv3yYam8K2jQp/0Lf6sH+2/vxa+vmbJB8Tx
	 3HcHrxxHOiX1WBIXh2/9tEkFXkayjyiBmescJ4Lk4CLkq47HDjxIiVULCwXxLbPEQf4zG
	 KGRRBMd2oTOHRTVseCSIAWo6j2XAwBKOaJQUcYta9iXDhFqvU/z37k2D+9f/y6BOWMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=WUujsKjv;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A5606E861
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D59A5606E861
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=WUujsKjv
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so155075a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553100; x=1793157900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VCfGQX5Enxz7dxwKYko3XxUHVAAWfi+FllLcCi4k6eA=;
        b=WUujsKjv5ZQy/rL3LjAakUr26Y2xzhqQBXYREgAVPuPS+p2eL1rDVV25Qr9szKKlSE
         CUoos+1xWwjWfnGet9cgVTYuD7tIopXMFLYkfV2EIvnmkn2gEZJy41CBowrUpSLJAAgG
         2C4n2CdRF9cMHI4X+m+xQFHe6fIMeEfXsfsci5nFa9uyAnq42GdgwaNJwGaE+UQvy9l+
         WGh3mhswoLQJnCTshifjbfzdukLcc9nfSlD30l2zKNcpkz6W3rew36HR9/8zPyA+jMMH
         lUo0MF88914b+mwCN9Aao6iWuTytEZ45gDUngGqaJYKyOiHewti09EW12UEu4Om6G09N
         3sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553100; x=1793157900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VCfGQX5Enxz7dxwKYko3XxUHVAAWfi+FllLcCi4k6eA=;
        b=mTj7NQinTWO7LkU4gPZXcCbQx/Wy7B8UAnDj9hBMrlMLrpWMoLipK4YOaUZrzOYK3S
         T+N0Bw5ikMltuK4rd4TURhhSdOp/UMJ+fzaGtZhWQalY1GG3KsbpU95gH7Jd5Kcehrc6
         UWhHFGCIJC24rngZC88tvE3b0X706eb7rxS4fnfB4vn7obETROBn5GGqj46lQlKPXbMO
         suaHHVE9wqrfoJxRk/r28AUFCe9VDcXppfCn9Lp77/XKEbzsok3iHc2LSyOaFxC88gvd
         06j466r+i+oex/fqWDHTnSI8t/3mCJQRrDAiWe728qiaqjl72XEBYjVQChfg3skunV0d
         2Lqg==
X-Gm-Message-State: AFq9FYKaqIdDUYNPJaCurr5bvZLtiXE89D8xRyVpFkAHg3GzPaZDy85r
	vaZdVLSmKiLeJXhZUYCecNVhEmFPIlzJrWNwa7w4Y4OxElTZk5YdoqbdLJ57UOm+OQleSGs6O4Z
	r8TwP
X-Gm-Gg: AYBFou3SRraAUIbzvCY0S5Dtx8SoFxSNFVNzitJHf5dWjNpv1bZuV//w76dWqafI2zx
	CLt6tjzklwRLHPA+WkR17Wf1lH7Va/gNufiGOhJhUlho0ef6LbLi6N4WuftNzJYwSiXHil0QnOO
	QuLcKeEaiBNA9QhPyj8/bilGfcPgu0AVZqLs60Or6oZ0CYNB+Sk4PvH+TFF72BF/Pe3/quyJ1q9
	WmYwPdgDugdP55e971cylg9zlBzicbVXHTbdpyg05co048o99lR8BBMCdCioMYT1MkFPSZy7P8r
	paeL6IUAsLsNC6Y0YIqCuR5SE18aPgYSwXdHeFV7MOSGOFrpYA0mnAtcYBYS9g0CvvZDclwPe3G
	nq7BhLhCH5QUSPUHuuC7n1PgxINqjaE/tChREMo1SMS9OyVHVcOmXXKQs4P2rV3l6vS7+klZHSi
	7wJJh56tymlhi+DQTKLk6KZmXpRk1Gz72Uj/sA1r/JP/MbRYgntOizp4aQh0pJ62BvLnWPeGFHZ
	KaxvmZ6c5tMIz57FcO3Mu1Ua/1X7SOyrO2klRHOg0XH2P+2mUfWLhjq81NDDe8skjyBO241eLDW
	7QfYpccvZx7AndkJWQGjG5WLxklyaaY+MgKW9vsbmr9P84+glS9g5kfsWNVYZ63R4+we8LawMzC
	m0MLQcoUh3vsjmDVToOxCRA==
X-Received: by 2002:a17:90b:1b0e:b0:3ac:9a54:e3ce with SMTP id 98e67ed59e1d1-3ad86ddec88mr739902a91.63.1792553100121;
        Tue, 20 Oct 2026 20:25:00 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.24.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:24:59 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v6 4/6] nfc: nfcmrvl: publish UART state before registration
Date: Wed, 21 Oct 2026 08:54:41 +0530
Message-ID: <20261021032443.44412-5-shubham@octane.security>
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

nfcmrvl_nci_uart_open() does not publish the UART back-pointers until
nfcmrvl_nci_register_dev() returns.  The registration call exposes the NCI
device first, so an early open can reach the transmit path while those
pointers are unset.  Its response is also dropped because the TTY receive
path is not enabled yet.

Add a transport callback which publishes the Marvell UART state and
enables its TTY callbacks before nci_register_device().  Halt the
controller before that publication.  The existing quiesce callback rolls
the state back if registration fails and withdraws it during normal
teardown.

The generic UART layer still marks the transport ready after ->open()
returns.  For Marvell, repeating the publication is idempotent.  It also
retains the fallback for transports without an early publication hook.

Found during a source audit assisted by OpenAI Codex, gpt-5.6-sol, and
reproduced with a pty-backed controller that returned CORE_RESET_RSP during
device registration.

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c    |  9 ++++++---
 drivers/nfc/nfcmrvl/nfcmrvl.h |  1 +
 drivers/nfc/nfcmrvl/uart.c    | 16 +++++++++++-----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index baf4c781ee6b..b6f47cce0f1f 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -154,15 +154,18 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 
 	nci_set_drvdata(priv->ndev, priv);
 
+	/* Ensure that the controller is powered off before exposing it. */
+	nfcmrvl_chip_halt(priv);
+
+	if (priv->if_ops->nci_ready)
+		priv->if_ops->nci_ready(priv);
+
 	rc = nci_register_device(priv->ndev);
 	if (rc) {
 		nfc_err(dev, "nci_register_device failed %d\n", rc);
 		goto error_fw_dnld_deinit;
 	}
 
-	/* Ensure that controller is powered off */
-	nfcmrvl_chip_halt(priv);
-
 	nfc_info(dev, "registered with nci successfully\n");
 	return priv;
 
diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
index 61b3f4a4f096..5c2a5382c280 100644
--- a/drivers/nfc/nfcmrvl/nfcmrvl.h
+++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
@@ -112,6 +112,7 @@ struct nfcmrvl_if_ops {
 	int (*nci_open) (struct nfcmrvl_private *priv);
 	int (*nci_close) (struct nfcmrvl_private *priv);
 	int (*nci_send) (struct nfcmrvl_private *priv, struct sk_buff *skb);
+	void (*nci_ready)(struct nfcmrvl_private *priv);
 	void (*nci_quiesce)(struct nfcmrvl_private *priv);
 	void (*nci_update_config)(struct nfcmrvl_private *priv,
 				  const void *param);
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 66803f1c6fd3..95223c20d50f 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -44,6 +44,16 @@ static int nfcmrvl_uart_nci_send(struct nfcmrvl_private *priv,
 	return nu->ops.send(nu, skb);
 }
 
+static void nfcmrvl_uart_nci_ready(struct nfcmrvl_private *priv)
+{
+	struct nci_uart *nu = priv->drv_data;
+
+	priv->support_fw_dnld = true;
+	nu->drv_data = priv;
+	nu->ndev = priv->ndev;
+	nci_uart_set_ready(nu);
+}
+
 static void nfcmrvl_uart_nci_quiesce(struct nfcmrvl_private *priv)
 {
 	struct nci_uart *nu = priv->drv_data;
@@ -68,6 +78,7 @@ static const struct nfcmrvl_if_ops uart_ops = {
 	.nci_open = nfcmrvl_uart_nci_open,
 	.nci_close = nfcmrvl_uart_nci_close,
 	.nci_send = nfcmrvl_uart_nci_send,
+	.nci_ready = nfcmrvl_uart_nci_ready,
 	.nci_quiesce = nfcmrvl_uart_nci_quiesce,
 	.nci_update_config = nfcmrvl_uart_nci_update_config
 };
@@ -147,11 +158,6 @@ static int nfcmrvl_nci_uart_open(struct nci_uart *nu)
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-	priv->support_fw_dnld = true;
-
-	nu->drv_data = priv;
-	nu->ndev = priv->ndev;
-
 	return 0;
 }
 
-- 
2.43.0

