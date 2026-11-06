Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992488;
	b=2t7wPligu3NBSkWbqKNKFAim16ca88KMT+v2+h4FpiFx32Uk0Zf2iBjKffEtSaMP/HTE
	 xch3iyzn0uX+sWr27VWD/l3cAimy3sVQ1fiRnb4wFTPQh9Gv8S9s8IMpSEgeb3Ddij+ZR
	 XVCP0p7nYpeD1OXmx8P61Ea5MtR1yr9D032m+rdG+zgDuX7IqgDsJH5Z4nG0K+1DOr7Ho
	 PNE392rIlgmW7fgdCeyE4ddUS9Hpp1KS5LrALwGO/unV0fgz5Vskvh9UMcvPXg3M5K8GJ
	 n1LvBAs8ubTRVlFrx8AI3JVq3vSbY354PdrrOGvhGaICzSoJTcn0CVJQlFjZyqLIMlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RBHpMRzf0eXM8WBZB8WQfweRMvvNhErIo9L3xk/Va88=;
	b=zOD3QQQyEkh8K48eQBaHGFPjW5tM5viN07qRX3frUre+QwwMlSB+J1y+2GidyIO3L3/D
	 E5yAGbnGC1G4qmsMvZQP+lG539zrg6ENYLT7PjQR7F4vnvsa7NzwglTUOUj8CJkmoOMRP
	 snlN0PlQP1rbMxvE8dAvEU3gGlETbf07jl3WL+3C0aMFiMpjlpL4TeUkoBDczkhSotJAt
	 PkQymk6eHDH/WyAcQbxiaUtNJyomwfhO4l9FE9MyahZiR18rz/kFq2o4c6LzMBn4pBOAW
	 b3mZMneSoOGSxYVGrji6HpFC+UV4zr1wNU8xn8n9bSQHE47kq2URuAlu3xwWI1ONKDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gna5QCte;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426F606D81B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4426F606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gna5QCte
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b1a705b88aso682787b3a.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793992488; x=1794597288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RBHpMRzf0eXM8WBZB8WQfweRMvvNhErIo9L3xk/Va88=;
        b=gna5QCtee0aRLn/cjKcQq4J46FWm7qslQshOsN0WGUAfN65odsRNeABPrV98Y+Xv71
         1eQ2h2mWfFwzQVLyrwYRjn3TlUhHd+9DUFrhOaAEbm2t6Yg0Vgt4UEyAQe6kgX94P7kP
         pnjQwVkgtAwBK3yl3HhimjT8JzjO3xNKoUX6fyEPSsFDr87eNEb9koqOPRk0XzMaw72g
         aY4MkoOae2ChmhkOsEm4BvATcf5zahcCfIxYCxW9fg5kEWhPkQ4jz7ioTbrHmWWdpRn9
         bZgHUPuW+FW3nhEoYrGHxNtACkivb3Mbe8rFHx8DV+HH0GCtUS9C7csfCG826OOyRAPR
         Yf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992488; x=1794597288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RBHpMRzf0eXM8WBZB8WQfweRMvvNhErIo9L3xk/Va88=;
        b=sF65Xxb9z2R3/37okxeleNnbeTx7haOIsfLL6GsK/WNdOFb683e1JlpyN4Y6U73SH2
         5fxOGQvNrs77Lg/xsdPj5xPitLbGQjjX6JfcrVyikjnaSp4XWU3F9XLnH1n3o9DeKnKo
         TbHuX1ED5dSd595i/6/7RJ2yVzG57qzGfaAaWbbSs/HgdYEZfSfhPS35eW4ZGHomKcZ3
         V4HBOb702bcpZuiomMDKO5Ic5BCA03BZ/FNEypTuT/yGiR+H7Ji7YVfFBXO1GIbQ0GdW
         MNeun/HjoA6ecNbQ8NNj7sde4n2ueSWxxqlJ+EHxWEgd1oK5Hpy8tWazmtSN8Agmzuho
         7VIA==
X-Gm-Message-State: APuU4Z+gDqix0n99eNxG9rMpotK5Xofcz8pR0M4FkFN3KVkfV/0aqQuB
	wau1zZAJNf8PNi9d6syamU6RiEQEN6VxxiKWdP2xnmJhvCaHVgo+H7SK1IklW0iFkOn4WOha1PY
	kMcYx
X-Gm-Gg: AYBFou02+NwXtt3Kt9RuRC4oQSkYx/NTdD8Ggl7Z+JmQ9lQs0Ngb6QLrM4WGvTrH9Og
	vKMYDVGwQ6b+GtHLDP7ysN2luKNXL7m5CAPHBXlyYmc3hNU+vKyM+/uMZKWAM2Jj7IisxS0B4rK
	2D/BxkaMj8d4Vrp3Qk8OH3dUGD4DE5fUxDgdIbbYU04DZTuwrINIxZYbngaHv5NANanjOfXs4Bq
	96MnpL61XMzn+uVDSqrVUm+33Aa0afFb5oo7uE+cswKk8yotDkSsZIq+T6uKlfllcO/uEYPwA7j
	Hlfhc2nNC5DCWB3QFvlycc/8/7OLjh8ft3PF86VyRUYbMapUZjKCeJQMbV5PHAb/qBScqqkLvNb
	OsN2DDgnExrTVW33pj074enuVYJMya7/nOjN9A5vVukDUK3Ik0TP3DcPRyHepwjVpBeaGtsBAZn
	z0F4Y/YNx+HbDraRq4AfKXZbrwy4wj4rxwWn9a3h9BTBor/vWZNdj+J+EaWrJ9pveRV+iApWDYt
	2JLIv+0n53RuUz6x9I9TeZrScCt7AFOpj3T4QbjEfrtJs66aYRg4wqFlj99SpE+vNk00qEOINnl
	BsVJFgWiC5xmyAWngN/XUYefF2qKH/YdU8npWc3bd+2qEIiDJ6W3K8V6c3mXIlDP
X-Received: by 2002:a05:6a00:3a18:b0:880:b709:cefb with SMTP id d2e1a72fcca58-8b37bf4f837mr3321843b3a.45.1793992487685;
        Fri, 06 Nov 2026 11:14:47 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b356c287a8sm936695b3a.3.2026.11.06.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:14:47 -0800 (PST)
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
Subject: [PATCH net v5 4/4] bnxt_en: refuse to open a device with stopped DMA
Date: Fri,  6 Nov 2026 11:14:20 -0800
Message-ID: <20261106191423.4194081-5-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106191423.4194081-1-joe@dama.to>
References: <20261106191423.4194081-1-joe@dama.to>
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
index b5ef86bf92bf..eb885fd74064 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7833,9 +7833,20 @@ static void bnxt_stop_dma(struct bnxt *bp)
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
@@ -13426,9 +13437,10 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 
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
@@ -13445,7 +13457,11 @@ int bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
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
@@ -13505,6 +13521,10 @@ static int bnxt_open(struct net_device *dev)
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
index 41d05efd6307..7e65b61b6bf8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2474,6 +2474,7 @@ struct bnxt {
 #define BNXT_STATE_FW_NON_FATAL_COND	13
 #define BNXT_STATE_FW_ACTIVATE_RESET	14
 #define BNXT_STATE_HALF_OPEN		15	/* For offline ethtool tests */
+#define BNXT_STATE_DMA_STOPPED		16
 
 #define BNXT_NO_FW_ACCESS(bp)					\
 	(test_bit(BNXT_STATE_FW_FATAL_COND, &(bp)->state) ||	\
-- 
2.53.0-Meta

