Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375BE471CEE
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860280; cv=none; b=Zc2fknLe+q6sZvd8b2BfvQRXqv64oW8Pq0vI53b1PEbYYZlJURu0VOrKBFzAcL3h4Viz8Xm/MLgapethrhkOBtzgitqU7iufIGujO7QdugtBWa82tt28KB0Y2I/mmb9U8tnJNAfQCdusWUmfSdEG6MWo+gz/Mnl+JkSI2BkwVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860280; c=relaxed/simple;
	bh=VSJJkJiLisOd14jzU3NtN+1l4ORk3Rz7Onx0RA8eoDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgqD7AcYclBXPndPmx+a50Kc8rJUodBmX0NJgjqgSOlkgyPUjnOqsRtZMR/nuC6IToPYp8xz8mQ3XrarYE+Rh/eJ9M4bdUw9fu/HfD2J44xvqcfxU/IXJ6sr8Fls9OvClMsQ+2rIrorlDC+Q+nKudYdsVJ+VQESxsyRZrbvk+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=QKJZ48dz; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="QKJZ48dz"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4348116eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1791860278; x=1792465078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+AztMa9ZkTcAA+tH8ZRmmfmqDCx4w5BgOfCE+Z46tQA=;
        b=QKJZ48dzlGZWIDcDiqTsVdi8A/TQnffGLLjgpO6Xxrx/eOB3P1Ln8K5qWNDSUAMDme
         1XnaBQbKrA94jqTyPEjUjK5cFKs5do/8j9/zuZTBzIidsGmgtzvMCndTYtE7wuBHLCUK
         DQx9ppZhi7GVEv/Oa/hrERop9k8GL7oedy76DsPMtihCUURP7mloUfaagOQXno7u9BUM
         MalJSSdz/ulXHLpLt/BlYk0eiwdF0DJkrmIAVoG3E2wuh3WSjuxVIWmLhhTdLwEST12y
         6cYL9+2NSjREafk4lEsRlR9TKn97D8JQJPJ41g/tlnI8nlw4AsUduPs4PzaMul7wpw/S
         MQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860278; x=1792465078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+AztMa9ZkTcAA+tH8ZRmmfmqDCx4w5BgOfCE+Z46tQA=;
        b=xhfNJwZGxZ+PEn8BO5a3FVXI1Fp/HdGo5zbNA+bOW17QB4KUH4SAlj2Zy0g04/ctod
         VB5bhW08Ll788wbaGoc5cJd5v/i65ZN1xZdZ7MUnikdz4+uYt89ExYBppJZzVjJZgxWE
         kjhvw2G82BUx/tow/owRMt+oSG/wU83hw3u/I2o/wp8HnPEi7NEKpNgnT1bbw9jWldO8
         yPZhjsaUukrSElme3ER+cdS1r2Rx2m7MK1LGUEF5d5H1X2Bh9l1WLhPL3hQBT6Nejacg
         Ax9QU7VWttX4vzjmwTyJOJyeaurE38RRjXpbxjdwLv0GuD22xo+TJA6RJAJrnaf6KJv0
         lJcg==
X-Gm-Message-State: AFq9FYIbiPDt8az0RJ+s2h35LdugimYhA+REeyF3q8U+CElSX8VM9jh3
	aOYC9XF+AjTgO58zTeCG0I/KCrFgw92j7yzw4+kOasHA5cDEIRyoX+tV6M7rAdFUU2ukRqfINAl
	bVckG
X-Gm-Gg: AYBFou0G5Xiwlw5zF8E2AMwQ9QYmhMQzDycEjxLsrsbSXYoiXOlB8G8eqwPXPcOGYjV
	QAU1rF9Tr+zpEYGn/PB4yhg3R+9vwHDQQC9ejbk5freOQxYDEdV8rsRx9yqcE6erms067TW73vl
	k6PHRdA0dVeP67+1Zd0LSBKPob6lT7FNSSPQBBbmzsRzCazjK92XEFmu8t9+fUro6W+bx3v497o
	eILXwwDzOV91F211xkmgAxZI+uivVFPx6iItmrhE1wvubD6ECNIRSw24lGkhcGuZNILLyJ/EmAq
	tkHjGW26uyGxcsQjhiM8V+zQheBrcwTSPVBxFGXdCsrkiunTvsPkIPByp1QU0gd2mI8mIze2N0i
	QM4twr2OvedW+e89M0EXaO+pveqXOih6s/hxyTtUNEXcXTpjox7VXnUyOIZTyOny7W4I6y0jnn4
	YGFTzyw+H+MrgdIXPjQTA+3O7n9WcTUXeORxBHt8HMHTesVxgAavR8ZVo41pgrdF4+8mn/kNj5+
	CRVWp8aWklGK+sPV41cTFPzMuxYcZ+//riHtAFnC2R/2/0dE1UMBWsvuFSEC0ihi9ehwHoRptWD
	XPmb2MDtu+UNOw==
X-Received: by 2002:a05:701b:2309:b0:151:f0c5:7a09 with SMTP id a92af1059eb24-16a5f01db04mr18014428c88.43.1791860278186;
        Mon, 12 Oct 2026 19:57:58 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becefdsm34223721c88.7.2026.10.12.19.57.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 19:57:57 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	cuissard@marvell.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gio@octane.security,
	Shubham Antil <shubham@octane.security>,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/2] nfc: nfcmrvl: publish UART state before registration
Date: Tue, 13 Oct 2026 08:27:45 +0530
Message-ID: <20261013025746.41292-2-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013025746.41292-1-shubham@octane.security>
References: <20261013025746.41292-1-shubham@octane.security>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfcmrvl_nci_uart_open() does not publish nu->drv_data and nu->ndev until
nfcmrvl_nci_register_dev() returns.  The registration call exposes the NCI
device first, so an early transmit can reach the UART callbacks while those
back-pointers are not initialized.

Add callbacks which publish the UART back-pointers before
nci_register_device() and withdraw them if registration fails.  Halt the
controller before exposing the device as well.

The ordering issue was found during an LLM-assisted source audit and
reproduced using a pty-backed NCI UART under KASAN.

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c    | 11 ++++++++---
 drivers/nfc/nfcmrvl/nfcmrvl.h |  2 ++
 drivers/nfc/nfcmrvl/uart.c    | 24 +++++++++++++++++++-----
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 6efa83219117..3d26a54ef51b 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -154,20 +154,25 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 
 	nci_set_drvdata(priv->ndev, priv);
 
+	/* Ensure that controller is powered off before exposing the device. */
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
 
 error_fw_dnld_deinit:
 	nfcmrvl_fw_dnld_deinit(priv);
+	if (priv->if_ops->nci_unready)
+		priv->if_ops->nci_unready(priv);
 error_free_dev:
 	nci_free_device(priv->ndev);
 error_free:
diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
index 62fa77d587b2..66f8cc06e2d5 100644
--- a/drivers/nfc/nfcmrvl/nfcmrvl.h
+++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
@@ -112,6 +112,8 @@ struct nfcmrvl_if_ops {
 	int (*nci_open) (struct nfcmrvl_private *priv);
 	int (*nci_close) (struct nfcmrvl_private *priv);
 	int (*nci_send) (struct nfcmrvl_private *priv, struct sk_buff *skb);
+	void (*nci_ready)(struct nfcmrvl_private *priv);
+	void (*nci_unready)(struct nfcmrvl_private *priv);
 	void (*nci_update_config)(struct nfcmrvl_private *priv,
 				  const void *param);
 };
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 9aedd168759c..d688071f4b26 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -44,6 +44,23 @@ static int nfcmrvl_uart_nci_send(struct nfcmrvl_private *priv,
 	return nu->ops.send(nu, skb);
 }
 
+static void nfcmrvl_uart_nci_ready(struct nfcmrvl_private *priv)
+{
+	struct nci_uart *nu = priv->drv_data;
+
+	priv->support_fw_dnld = true;
+	nu->drv_data = priv;
+	nu->ndev = priv->ndev;
+}
+
+static void nfcmrvl_uart_nci_unready(struct nfcmrvl_private *priv)
+{
+	struct nci_uart *nu = priv->drv_data;
+
+	nu->drv_data = NULL;
+	nu->ndev = NULL;
+}
+
 static void nfcmrvl_uart_nci_update_config(struct nfcmrvl_private *priv,
 					   const void *param)
 {
@@ -58,6 +75,8 @@ static const struct nfcmrvl_if_ops uart_ops = {
 	.nci_open = nfcmrvl_uart_nci_open,
 	.nci_close = nfcmrvl_uart_nci_close,
 	.nci_send = nfcmrvl_uart_nci_send,
+	.nci_ready = nfcmrvl_uart_nci_ready,
+	.nci_unready = nfcmrvl_uart_nci_unready,
 	.nci_update_config = nfcmrvl_uart_nci_update_config
 };
 
@@ -136,11 +155,6 @@ static int nfcmrvl_nci_uart_open(struct nci_uart *nu)
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
