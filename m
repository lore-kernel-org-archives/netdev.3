Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2D3A3E68
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857280; cv=none; b=HYGHeHOLLzZ45B2HWYybJw9bsae+CKgO7GsOwDh+HYLUvlssgLS1qzYQtiMw5BGeV1E0m+n514+Tu7MmVQu+tO1ld8E1/+Xb9u1zMBj8pfJycyiCG4od2kTzQkr143oMgHWKJO4fH18qhQ4jpGIIr9ALLtH+a0YpXdKFjaUBlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857280; c=relaxed/simple;
	bh=YJzIm5QA/CHQO6n6vteWNo/Y1kHnMLjMisvbzcEtMco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VP3xCrX19SY+5ZfkO1FBrmQlh0V5ifvwqhGtpFd+YLB6numKlC60oAUqi1L3OQgeFyCudNUpYtF9EytOUXDIUfnetrdcOUFDKGl3ZNtwMxliVT7MemJMMLnmGkaK3Om/jJ+50YUX/w/YVp6b0RSoLPUswbxC+w3BDxwavr16udo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFFLTC2I; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFFLTC2I"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a3so1625038b3a.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857278; x=1790462078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZPaps3uZw3+pSOsVulPRPw9JNmYOgWQLZSyhTH36qMY=;
        b=pFFLTC2INjED/CG7b4vrIABeK9tfcCeOqbsqZRsl0IlL1uFKuZk4S7pLCGC6+cWLp3
         Rs8x2D9I1QEmVN/PLwoeXseHE6AYP1z87CmL/4Bo22EjBE8A9BDlqxvHYXTJjoz4Awd9
         KYKoGIWC6yd3fJgv6q0rO5OYiCe8ijSOO241gdvxaX++AH2BVVv8i5eZ5MB1IrLXGLsZ
         QFGLRo2Xouj8MyXJb3ak+r+ApwYpeMIU4FT5MEiBARnChf9qJI8HjvbZ88rkgzSz7tT8
         5cfmYE8JOwRE+dN/PDLDkvr8eI8+pO6h8zWZ9vWvxpQWEplrkVoZwsPGb1yOdnUwtu+D
         VS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857278; x=1790462078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPaps3uZw3+pSOsVulPRPw9JNmYOgWQLZSyhTH36qMY=;
        b=seVgBKsTbJBkE+uNOiw55Xwm0G4sQcTGTHkiSr77yGvu3/K09YI5GUGs63cKq3NwSu
         OF3N9OUDy1nCAz+iHtafmQo/QA16WCq78uqqkqti2mRwa1LoqBre2P4SI4/LW9yaDw1G
         CGN+WvWe2MM1AF5/RfgdkQKaTvSzM2DqyPiHClBWblBSYwCpK8tjAN9Y73vd7qx5BXTS
         QxcUDsePCrpqKAgVCtWhOOUllDgWDpFLbKNZnIAZHBRE9+ejG2fmurQzMMgFaqLWF5K5
         wvTvnGVHVgte/YigNFG6hY/9JNe3/7n//C4mPKynMpy5jY/TvfiB94P58Yd2My/ZPIC7
         +7Nw==
X-Forwarded-Encrypted: i=1; AKwUvBz/E+5NY96za7Cei5FJQ4WQYeCNQqRu5gRMbu12x36wWMTEz8ewuTjINirVyJuh1vQQL6SzDYw=@vger.kernel.org
X-Gm-Message-State: AFuF++mB02GGTgI3oYVrL257AkfeXhAV+Dp5YRBHnL61dOF5P95fZsBI
	dA4pZvxLv4jBdSDGycVr+8n+aPqJEHd7Up0SAEixsSoKd01GeLpnuJaT
X-Gm-Gg: AYBFou1HDMvAn9CMHkatHq9TZdMGlbEgjrKfsCV9VEE8vjfoKFk0piAej3hI3NMWKjm
	NMT5cydbZUP09tCzyrfhDbUP0c7cxd4ZCuf+tlgmo0sQvJeoRuiiuchJUIs/CEmWN6D4S9RS1A3
	xmvmMccRmOaaBN+O1gr3j8VTWgVJpVK/2cHuBWRpe20xm+Ftjn+/a3n2FZWkJlOwHpS29ca7Qmj
	QfJfGG9ejELKqOwGALxp9VfmdVakttZcidjkiPuatcKVh3wPORWfM7r/roJwtJaOOSlTQghg/UI
	oX/bbA7p5iHID3mV4hD7lruRY7LIG3Y1kPDZerh5UvGqjJhdF+Nvi0fF+MrDfVnztm1dKMsXbM8
	nJ3ICIe83BJtGRcqti90DCUDFTA6uLvNva909gbKOaHJgP372RbUsdOyIdmHCs7h+ScuGhWIWGL
	98TFHGxL/n8VfWnyhDQsdcjNhXw/D5WSZsVIf851GRqUo+fl8hlHU9Pf21z5mM+pWD7ZihyEoti
	yZNYs70Wmxnya9Z1gz6mPOmyeUOLipxzUKEuX8y66Y8EoRr8jbPtqOAHgtzQ7Nt1z65FHw1pIOc
	RVRg3yOkwg==
X-Received: by 2002:a05:6a00:3982:b0:878:3811:237 with SMTP id d2e1a72fcca58-87838110992mr2854371b3a.51.1789857278259;
        Sat, 19 Sep 2026 15:34:38 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f4a10sm1362241b3a.22.2026.09.19.15.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:37 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: cc2520, mcr20a: reject invalid RX frame lengths from SPI FIFO
Date: Sat, 19 Sep 2026 22:34:37 +0000
Message-ID: <20260919223437.3883127-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drivers/net/ieee802154/cc2520.c and drivers/net/ieee802154/mcr20a.c,
validate the RX frame length byte read from the radio FIFO before
subtracting the 2-byte FCS or allocating/trimming the skb so len < 2
cannot underflow.

Fixes: 0da6bc8cc341 ("ieee802154: cc2520: adds driver for TI CC2520 radio")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index abfcfe07246a..d2c8484d8fea 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -482,8 +482,14 @@ cc2520_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
 	 * values on RX. This means we need to manually add the CRC on TX.
 	 */
 	if (priv->promiscuous) {
-		u16 crc = crc_ccitt(0, skb->data, skb->len);
+		u16 crc;
 
+		if (skb_tailroom(skb) < 2 &&
+		    pskb_expand_head(skb, 0, 2, GFP_KERNEL)) {
+			rc = -ENOMEM;
+			goto err_tx;
+		}
+		crc = crc_ccitt(0, skb->data, skb->len);
 		put_unaligned_le16(crc, skb_put(skb, 2));
 		pkt_len = skb->len;
 	} else {
@@ -1147,8 +1153,8 @@ static int cc2520_probe(struct spi_device *spi)
 	return 0;
 
 err_hw_init:
-	mutex_destroy(&priv->buffer_mutex);
 	flush_work(&priv->fifop_irqwork);
+	mutex_destroy(&priv->buffer_mutex);
 	return ret;
 }
 
diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 020d392a98b6..d7e076397550 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -790,7 +790,8 @@ mcr20a_handle_rx_read_buf_complete(void *context)
 
 	if (!ieee802154_is_valid_psdu_len(len)) {
 		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
-		len = IEEE802154_MTU;
+		mcr20a_request_rx(lp);
+		return;
 	}
 
 	len = len - 2;  /* get rid of frame check field */
@@ -866,8 +867,7 @@ mcr20a_handle_tx(struct mcr20a_local *lp)
 	/* add 2 bytes of FCS */
 	lp->tx_len[0]		= lp->tx_skb->len + 2;
 	lp->tx_xfer_buf.tx_buf	= lp->tx_skb->data;
-	/* add 1 byte psduLength */
-	lp->tx_xfer_buf.len	= lp->tx_skb->len + 1;
+	lp->tx_xfer_buf.len	= lp->tx_skb->len;
 
 	ret = spi_async(lp->spi, &lp->tx_buf_msg);
 	if (ret) {
