Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CF414438
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358263; cv=none; b=huY3Dq83UX2NKXnDtvPumjmQbLqc3WiB8gi0Lg51Z5mnGktYfGzH4ts7mQjkSpyU8oiRn2UmcA2sipZgYs549k8eXRX7qU6yNyNDtTvGJIJdbSlk3JxDJynl1Rl3snzmv5vEQ6hZA3heRYmhg6mcO73vnN+d0rFquAIPrii4B2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358263; c=relaxed/simple;
	bh=nEGQtNsOqRgVj1stkN28aBwKl650Crgr+AGHAzUbLlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsRBLvPjhbQzkl/PjsY9crL6NT2NVa1LXwnxrB0WbezmisQYa25QcZP7/PiwmGlgwe+X6vSxm0KZEUIFVHk9YzXpj82s6wqZxNOgZiVuS391nCWz1Y03xPPfTbzcsodRZUvu0dlnpWgSTDfGAgSlXVq+LVHsGJrm9QOB7G3Q2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=r7PFHR1X; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="r7PFHR1X"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fbef5018so7911265ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790358259; x=1790963059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=od1b2NiNF/g5sU9VqKXFtus5k8nOhhjRHoBVgLXdW6g=;
        b=r7PFHR1Xo1Bd9dHniplSLk8dS/WCUpNoZ6pSGee4WifduU3R/a62yhePFE2Jw4ytMl
         hAQ+sQQl6zabjxLdgnLwb0WYuGZ2oQ0RffnIIp9YSkhFeG4vZoaGhqy9FCUzgpYSiQ83
         Z1DFuUJyDAzXFbv9gkWdrAUZyKRkh36zlhYSdvnPGwt7Pz+VeaSEqV5kJN7J4dI9dcHo
         jnPpDKl2zfZq2Q0WzaDm13/rNqBlu3JlCA6djuc7ZAajPLobNoaKVGUTupuTFCsqAJMj
         pxqu6DVJsz2YFZaPuQOKq+kHazDIwgHufqgeJcwyrjTzeKZydfR6qWxzndMdOkiveITz
         ZJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790358259; x=1790963059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=od1b2NiNF/g5sU9VqKXFtus5k8nOhhjRHoBVgLXdW6g=;
        b=KpYpwEez6bRQWRkltF8AzWDSU8MrhT0+xqvzVyJQh0uzA1E36HkMMay5VKZhNZ1Fge
         RtSchkUfj956xrTdFIp4krE0Dsy1F9G8bB1T+uYt/5rmnvyDZ+zcyCi1RvW9vI+3+k44
         pIufbHOtHIXqq/ixFAkglUU0ktZf+mq29OFKqzVlcJpFOyu5+fE/T8dpa6H6RGptKNTN
         WO8EJpR+Tk1gGf5TZZVIfnzK3wtFuPn0ZKIv2ItslVqwr60QS9+TMLrgWZIBniKKIUHp
         y6y8J/HSRTio4rTe+rO/lXPn704bU+AkIbQjfE9dvdoE+s9crYUP3UcQCxO3jv1vffry
         P7hw==
X-Gm-Message-State: AFuF++mXPZ9pBB5R+Q+y4/kg6GxC6a7CoLuPrHHNJ2jc7BlxrSWY+Sgl
	ZyMKlYnmp9OoQjxpwb+3Q/HV8rbyPflOaFW+zKR3mFayrhGbAMzGzIs8NWyKfN3+9/5GiV8fy4s
	JsADw
X-Gm-Gg: AYBFou1/A2Pfp823amLPZw8ZnyutkDxtfZJNh5sNIeW3DDoAG1gy/s58PqwbsCpTiAB
	a81jgXPgw8ifQioU8Of/ZnwwnjY8lU7z5NYZu3aJujIg0n5RXumpeMTLIW5a2rAC/E6nSfeDFlA
	d9WYhABLWWxM7+bTRIYJh/EQVoS0JZb9U4xOcEOYIgXlHKTeS+okm2B1pq+bw20wZ3W/N+9tpSU
	GMxfwxWCHWIAbcSEiimYX1IIsw0gXs5RMQy+s9F0RG4foZp+xLGJXTqtnbS7uhCDTvYav16118U
	uRyjr+T+gG9IhOneSfVdaASuRbqk1mgKyfL+1lOMMQmZAx0FJqHLxQhwbVij3qKj+PgoKKJrLng
	x/sEbSr6axFs76GQR/Giytrp/5uUI9Sjmc28EjzfTCImxTTQF5u8OiIq/4H3kpigHOvsKFL95I8
	RrHBB6OxgizYE3CisKGT2MEqeNaIEy+Ljd09HeZ53/PctoQrHr2M19fRuJDqoRWU4u3DsTCS48l
	IhVE9Jf55Vm
X-Received: by 2002:a17:902:ce82:b0:2df:9a7e:d41f with SMTP id d9443c01a7336-2df9a7edeafmr15014465ad.41.1790358258843;
        Fri, 25 Sep 2026 10:44:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm14329895ad.51.2026.09.25.10.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:44:18 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>
Cc: edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net v4 4/4] bnxt_en: refuse to open a device with stopped DMA
Date: Fri, 25 Sep 2026 10:44:01 -0700
Message-ID: <20260925174404.2789072-5-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925174404.2789072-1-joe@dama.to>
References: <20260925174404.2789072-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BNXT_STATE_DMA_STOPPED and set it in bnxt_stop_dma() to signal that
the device had DMA disabled. When opening the device later, check this
bit and exit with an error.

This is a very rare case, but when it happens the device needs manual
intervention by the user to become usable again.

Fixes: 74608fc98d28 ("bnxt_en: Ring free response from close path should use completion ring")
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 33e9ce8eb449..21da989e136e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7814,9 +7814,20 @@ static void bnxt_stop_dma(struct bnxt *bp)
 {
 	netdev_err(bp->dev,
 		   "Disabling DMA before releasing ring memory, the driver must be rebound to recover\n");
+	set_bit(BNXT_STATE_DMA_STOPPED, &bp->state);
 	pci_clear_master(bp->pdev);
 }
 
+static int bnxt_check_dma_stopped(struct bnxt *bp)
+{
+	if (!test_bit(BNXT_STATE_DMA_STOPPED, &bp->state))
+		return 0;
+
+	netdev_err(bp->dev,
+		   "DMA was disabled after the firmware failed to free rings, rebind the driver to recover\n");
+	return -ENODEV;
+}
+
 static int __bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 			     bool shared);
 static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
@@ -13387,9 +13398,10 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 
 int bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
-	int rc = 0;
+	int rc;
 
-	if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state))
+	rc = bnxt_check_dma_stopped(bp);
+	if (!rc && test_bit(BNXT_STATE_ABORT_ERR, &bp->state))
 		rc = -EIO;
 	if (!rc)
 		rc = __bnxt_open_nic(bp, irq_re_init, link_re_init);
@@ -13406,7 +13418,11 @@ int bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
  */
 int bnxt_half_open_nic(struct bnxt *bp)
 {
-	int rc = 0;
+	int rc;
+
+	rc = bnxt_check_dma_stopped(bp);
+	if (rc)
+		goto half_open_err;
 
 	if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
 		netdev_err(bp->dev, "A previous firmware reset has not completed, aborting half open\n");
@@ -13466,6 +13482,10 @@ static int bnxt_open(struct net_device *dev)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc;
 
+	rc = bnxt_check_dma_stopped(bp);
+	if (rc)
+		return rc;
+
 	if (test_bit(BNXT_STATE_ABORT_ERR, &bp->state)) {
 		rc = bnxt_reinit_after_abort(bp);
 		if (rc) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c673b2ce4a0d..061f57824c7a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2470,6 +2470,7 @@ struct bnxt {
 #define BNXT_STATE_DRV_REGISTERED	7
 #define BNXT_STATE_PCI_CHANNEL_IO_FROZEN	8
 #define BNXT_STATE_NAPI_DISABLED	9
+#define BNXT_STATE_DMA_STOPPED		10
 #define BNXT_STATE_FW_ACTIVATE		11
 #define BNXT_STATE_RECOVER		12
 #define BNXT_STATE_FW_NON_FATAL_COND	13
-- 
2.53.0-Meta

