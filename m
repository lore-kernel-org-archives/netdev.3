Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCA1E8332
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615867; cv=none; b=lL4+qh8qeb1DDf1KQelnpwVXjZprEM1mJI7bUxEG2f4yHqsLI0wTm0KWy6lolAwr/dlvWPNTvhm7+NUixKsZae2UtHPfH5lw85o/UQmUSW57RGaYvA9edQQsqz4SbiXnrbZIaIbuR72umPr3xjT/ynbnAk7XtPsccMSyr2CfAEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615867; c=relaxed/simple;
	bh=I+gAip6iCiFitEH5ylwS6qDP50zs+Kwrk8kdZnbR62k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAUOeQ3rCu+NHcltwf9EhZjPQvrhl5BmTf0cLxYzuDmMi1xMpVUG4lO3Rdc46M4KaBUzVvjREvHUSOCCqzYhbLKEGrrtAFGjgGvrYXVmzcjcYmb0oov/7PMsTwR7n1XC3mTXWK7x32bTljFKgRlRxedKaiZUxGUgRwa2C60G/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmknqVjW; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmknqVjW"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-917a4b69a79so7587516d6.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615864; x=1792220664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=URgduepPMzAeN426OFGmttK3BIYHP3JxLMLmidFBFp4=;
        b=jmknqVjW7hcgc5Y7WRDvuUQl6h3M09bKi0O/JvaYc3DmWiA3mA6guMyE1AowSq7pz1
         txMRiw8NUgjjAKIeFdbdNbW2Py2nAQkTi8HdW6Zx/wylMwG2ZINZO6iljYpRMxuiOhLV
         ZwWTv/kijXtswTnuaL/WzHZdYWUS6CVX52pXW57DcNT11ymJr4ycnFeUMjHWYC0vRHuY
         fXWtURonsSeyfcAVqywSgMy4Q1a/xp1aKr98vQuEIU05R2iWrhe8LiVcxIpMzK1oUD1q
         RMZfhUDcCcIQXAxY9mT7inG7hNbiWg4NCdB02U0NS/IQac0/syfgGbao8RkjmPwAS5sZ
         tOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615864; x=1792220664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URgduepPMzAeN426OFGmttK3BIYHP3JxLMLmidFBFp4=;
        b=c/Jeb4wyObexQ0E06FEM4Y2AHLV4HNIXD01xkyjDbXDErLKe1TSOdYYe2fmhdmcaWv
         RipkhYN5/dn3Iv7x0Idf8Y8eRje+SwMOnRlJ+foDCx3z0dlcubiTgaPy4k/EDZ3uaA3k
         MTpOmpEOrGk2vF5E0ZqZyP88BfEqepen06TjygXYkxJnDa3JADeme7LV6deO0UoD4ZZS
         Lr0V7L2HUTvkyGLDi0eZ5Q3gMBynIRnwYW62mOaAQIpZrRCi9PN0JPjcgn/EBXht6xM1
         SfiuWtZZddl5o1l7FyvWgtgTI3rHorctNS5rrrXkuNwEz3xGnAHMXxglY+BrJuG3Wige
         tRWw==
X-Gm-Message-State: AFq9FYLssGiNouvarpivXnFG5Z/lgpO0b5W17Uv3ZtOi2AiPWi7Fdx83
	EdbEXX3pcQH18g/OgMWOMp7HSgU/tWUnMs1FRETINznF+n0JX7jue9zBpIdsox7f
X-Gm-Gg: AYBFou3jQUf0owvekVI0SNRhI7AFdV6rtTDFrVyA0hDdh2Fv0fkbhvOPB898Hinxmo/
	nYlkI/0dLpoVy9I1loTDaWrxTxMxb5idjs7XQhNe7dJV3XKYdTj6RJjJynD1eOI2OEvPvLWZdwv
	1gYAkOCUJ8I3pYLs0JScjw/0/UtAt+MKNZ6QmnQGtpxYiMAZKrZ03lZeZODn6RVHcKcr33JNRkY
	fUMLlRhE0PuOIfH3k1PdAWeT9aSZQn0Ze9R+PF6+hBi2B34v1q0RXZlwkl/AvHXaozZUiabTpBV
	y2E200Ygtq0YGltZKBnBlNM1/+nqEpQzcuXeHlhCC0HWMGqjnUQwx9MrGTlkvQlax/Up5LYU0wZ
	nvLR7ZeV4R2cxOMRUnEC0TZECR5lwglAk7SSZFDWfAAf0J+C7XeAbyX5/swtRAP9XTKlleF2FJi
	dzF7JqOJTKPM7vFLIplDrz5rkl19VwPZBdQ1HMD4l2TnW8m8u7ru+3Bh7dE46h5bQ9s+8NdWuxl
	0BxduBjAMEx+9B+paoIn12IqFmYQOz70ZsKh9i+pRdWdV3d0IMiR7SrDKzFN/E3oeH+Gp0urcXD
	wHhz9S2DCfG2Yp499CZsHtQgWvV+3/zv9DhvUf45rCjnuO5XZQ==
X-Received: by 2002:a05:620a:3954:b0:939:46d7:4b4e with SMTP id af79cd13be357-93ebd0e4d0dmr658712885a.7.1791615863616;
        Sat, 10 Oct 2026 00:04:23 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9896ac4sm359095885a.31.2026.10.10.00.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 00:04:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@openwrt.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bgmac: clear TX slots when freeing the ring
Date: Sat, 10 Oct 2026 00:04:18 -0700
Message-ID: <20261010070418.84457-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bgmac_dma_tx_ring_free() frees the skbs of pending TX slots but leaves
slot->skb and slot->dma_addr set. The slots survive a down/up cycle,
and bgmac_dma_tx_add() only sets slot->skb on the last slot of a
packet. If a slot with a stale pointer is later used for the head or a
fragment of a scatter/gather packet, bgmac_dma_tx_free() frees the old
skb a second time when that slot completes.

The function also picks dma_unmap_single() or dma_unmap_page() by
looking at slot->skb, which is set on the last slot of a packet, while
the head was mapped with dma_map_single() and the fragments with
skb_frag_dma_map(). Use the SOF flag of the descriptor instead, like
bgmac_dma_tx_free() does.

Unmap before freeing, and clear both fields.

Fixes: 9cde94506eac ("bgmac: implement scatter/gather support")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index ebc4b3bf6c4a..f40fde1d6bce 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -534,17 +534,19 @@ static void bgmac_dma_tx_ring_free(struct bgmac *bgmac,
 		unsigned int len = ctl1 & BGMAC_DESC_CTL1_LEN;
 
 		slot = &ring->slots[i];
-		dev_kfree_skb(slot->skb);
 
-		if (!slot->dma_addr)
-			continue;
+		if (slot->dma_addr) {
+			if (le32_to_cpu(dma_desc[i].ctl0) & BGMAC_DESC_CTL0_SOF)
+				dma_unmap_single(dma_dev, slot->dma_addr,
+						 len, DMA_TO_DEVICE);
+			else
+				dma_unmap_page(dma_dev, slot->dma_addr,
+					       len, DMA_TO_DEVICE);
+			slot->dma_addr = 0;
+		}
 
-		if (slot->skb)
-			dma_unmap_single(dma_dev, slot->dma_addr,
-					 len, DMA_TO_DEVICE);
-		else
-			dma_unmap_page(dma_dev, slot->dma_addr,
-				       len, DMA_TO_DEVICE);
+		dev_kfree_skb(slot->skb);
+		slot->skb = NULL;
 	}
 }
 
-- 
2.56.0

