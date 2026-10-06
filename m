Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF25F23E342
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287746; cv=none; b=Vj16dAk2HCZDGSmIwD7BkF+8d8Daz7hOS1m33+XDhO8JfKCwyOfO6Yk63SExR2D44t8WUZqj6jnsLiTwa6HqWjGK5SnT/ybYDn8FKrJuUNl8aU4eIKXd+sYmrAhHcmHtk1jSGwJe7brrfvWq9xYYxTE/TyRBMIdCmSSFMDamLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287746; c=relaxed/simple;
	bh=PYDA2NsGtvdEO6m48SQvTOJ4Ei1MI+nEE3W/KkMJ/BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yjn/zrHGpg+OJq/pWx2PY36Z77lQYonZ85ZpcZES0PIghEi11vSTg3XrqdQzVWX8u9F/EjjlfZxakjvUFjeXa7n/CRDnllIgEf/FAO0ogJ27qmVJP6m7oQzC0KDKs/OSP8VaDFxHpCLFi2r5cNeUVQDh8G4C60AjQOX5moGzX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=lpNJxHqG; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="lpNJxHqG"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-34ceab2900eso654078eec.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1791287744; x=1791892544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rp9ExwtVwETjuUXyxP6tQzqH186LBUjG5zHp0li/qcw=;
        b=lpNJxHqGDQJlKEDAlNy67dDa2z5hKTs5/vVWystcp46FvnQr4hgqfY2xhfxu7UcVE8
         6dq2I7yJSmhiK8+rNlyKnH99/5wdYPqT/CKyVWKoJUvmguf2JzsILPLnkpFUAMUSQvtO
         9+sMyAndLBGUV09bWvV6jNX7YWBpU2ByEIePPd5awgVVfsN2MKd2OKMM9cbo/6RMrAI0
         P8njOU6/d7YQPy6tWeOg0VBjnz5JkIT4xAsLvvEd3m+I1Z5lwkD2G0NE/0m45t/Ng8dg
         /wZKqK1bXqL5DCCxSMC+kQKLQcJg7uilLVaGH0/rw1mYd8Gxpgb0JAow0Hq0sYwcKswf
         AUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287744; x=1791892544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rp9ExwtVwETjuUXyxP6tQzqH186LBUjG5zHp0li/qcw=;
        b=SnaMSgWJzjG4pHbUDvKwIsBATCuhEm7GeKGLmhu9YiO+hmxWAh5p7+PHl1GUaetmw3
         kJ1V5xM0NvtHQ2yRDhnLuY/CJndBrXI5tQvo9qia8vtARjH5aL4lbE29xHnTAK8ATPk0
         WJuRXOP+PHD0hwLk2YH5UK5FBDxCngor9nWEau7S+IMPjDqacxoUpAC9W6IgSD7KZ01h
         GR04kGc1eLgW8Azd3U9fUpkRrNRGFGSPyIABARFxkw29P4Xl7IJwCCEc/pih0p6+Mm9C
         AiKxBX90PhZb9y0LvlyF6oGmLMyvLJZGRnY5UqQQKLgz70JODIUmUQUudnYMyX522pec
         2HKQ==
X-Gm-Message-State: AFuF++nR21sdLmFayOTAzW2aBB3iWf7bGziwhSzO8QedDofjtHORINIk
	gI/YdA8T4GiWKrjM1JSZOI9GsAnEZ8ntxUEpHgO2twZYQmz5qBDjwTEGuRviIEspp9/J5F3roMV
	4wQZs
X-Gm-Gg: AYBFou2MGhh3xEXv0a4H1V3rdcDePWOhFtoyDlN0yv/+Bcma6lIUn9FVG2yVeyoCQev
	uwi4x++gnFapVT4aGe2UmDjMDhE9Rnm31wQkFWrQn2krP48Ub+xd53aQRPLCTtcZbnNQQ4XhUMK
	IIu0/sGvtbd0/pxBeXvmiFYomKsqMx77X10PbQPov+PAtGcyAPcBfUI+5DKg25HTIGaaGIP4QEN
	BJYQbLlEfTxAsYAHFR1euJ2qOr4JO5IZd943F5Z8yRMPTEJnFwY7648b68JBYO5ns1MK53on5iJ
	vUQcWgwxmEK1teWRrQNNC0I3QZjdqlnNE/DV+r5YXiuYcl8py3mMKFYAm2S9y0LAM6Vozlxi7xD
	vfKOhU7yd4BsWchU69ed2xgapqLn7GfF7vzXJI1XjIS7OWAXbxhH31EBJHddsUzXCiSNK12/Rzi
	fUHXdm24zHJXqijk0dMly0gm/tFaV3uSZ7ce7UKKu9F/RZNwTOwOR+P2PvwDfOpqU3BgzYp92L1
	MxbS7tMxPGgVY2jaGU3lDm7OBVNTZp/qGUXawtkTL+ODx2Tf0vCMamIAeKilp4VhBh3OUoN7S/M
	8wqTNzw7xOtXKbIhxEE=
X-Received: by 2002:a05:7301:4601:b0:351:1f6c:2a85 with SMTP id 5a478bee46e88-3514e2e78edmr1202521eec.14.1791287743780;
        Tue, 06 Oct 2026 04:55:43 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469f75fesm8638511eec.5.2026.10.06.04.55.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 04:55:43 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Giovanni Vignone <gio@octane.security>
Subject: [PATCH v4 1/2] nfc: nfcmrvl: set drv_data before registering the nci device
Date: Tue,  6 Oct 2026 17:25:30 +0530
Message-ID: <20261006115532.72100-2-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006115532.72100-1-shubham@octane.security>
References: <20261006115532.72100-1-shubham@octane.security>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfcmrvl_nci_uart_open() stores the per-ldisc back-pointer nu->drv_data
only after nfcmrvl_nci_register_dev() has returned.  That function
registers the nci device, and a transmit started during registration
reaches the UART write path

  nci_uart_write_work() -> nu->ops.tx_start()
  == nfcmrvl_nci_uart_tx_start()

which dereferences nu->drv_data:

  struct nfcmrvl_private *priv = (struct nfcmrvl_private *)nu->drv_data;

  if (priv->ndev->nfc_dev->fw_download_in_progress)

At that point nu->drv_data is still NULL:

  BUG: KASAN: null-ptr-deref in nfcmrvl_nci_uart_tx_start+0x2c/0xc0
  Workqueue: events nci_uart_write_work
  Call Trace:
   nfcmrvl_nci_uart_tx_start
   nci_uart_write_work
   worker_thread

Publish nu->drv_data (and nu->ndev) for the UART phy before
nci_register_device() is called, and clear them again if registration
fails, so that a transmit triggered during registration finds a valid
pointer.  The now-redundant assignment in nfcmrvl_nci_uart_open() is
removed.

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Assisted-by: LLM Claude
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c | 17 +++++++++++++++++
 drivers/nfc/nfcmrvl/uart.c |  3 ---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 6efa83219..8186e86d7 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -96,6 +96,7 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 				const struct nfcmrvl_platform_data *pdata)
 {
 	struct nfcmrvl_private *priv;
+	struct nci_uart *nu = NULL;
 	int rc;
 	int headroom;
 	int tailroom;
@@ -110,6 +111,9 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 	priv->dev = dev;
 	priv->phy = phy;
 
+	if (phy == NFCMRVL_PHY_UART)
+		nu = drv_data;
+
 	memcpy(&priv->config, pdata, sizeof(*pdata));
 
 	if (!priv->config.reset_gpio) {
@@ -154,9 +158,22 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 
 	nci_set_drvdata(priv->ndev, priv);
 
+	/* For the UART phy the transmit path reaches the driver through
+	 * nu->drv_data; publish it before nci_register_device() so a transmit
+	 * triggered during registration does not dereference a NULL pointer.
+	 */
+	if (nu) {
+		nu->drv_data = priv;
+		nu->ndev = priv->ndev;
+	}
+
 	rc = nci_register_device(priv->ndev);
 	if (rc) {
 		nfc_err(dev, "nci_register_device failed %d\n", rc);
+		if (nu) {
+			nu->drv_data = NULL;
+			nu->ndev = NULL;
+		}
 		goto error_fw_dnld_deinit;
 	}
 
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 9aedd1687..421e6dc99 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -138,9 +138,6 @@ static int nfcmrvl_nci_uart_open(struct nci_uart *nu)
 
 	priv->support_fw_dnld = true;
 
-	nu->drv_data = priv;
-	nu->ndev = priv->ndev;
-
 	return 0;
 }
 
-- 
2.43.0

