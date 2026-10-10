Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FB35200A
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615999; cv=none; b=lwKq6F7ocysb8aHlaqEC3CmX9Q9wQeSXlWumH2jt2K/HhQ0l/7udP4cuM6Jo68qKqEsIo3ETM25Or8D9DeAnCMbKdf5P2Me+wKIqNsOtAAmJ7v5S7Shep9mR4fVFVV7PtjIPoJx7Ix+3RZPuJNYS9X2YUSSYV6c4MfUazm7KGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615999; c=relaxed/simple;
	bh=6I0EPpmwpmvUzUOUBPqtUUg6dmVPu3NOT1khsU1IydY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iM0TY7WV7qiqjJlHStQfgNb8TKEwvhTPv9BOd+MiTtNheZWPEvQf+YQ+w2V0wJmGyOQ0N2ty8jtYCcPE7Ypbh8nnKIGyY5REM1NCrv9erl+bvKRAPkFCfsYv9upJsTCe1e72Q08lYGTJmcFxYkpS4G8kahoxwq/X6Q4Ef1RBNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjns0fgh; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjns0fgh"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so366610a12.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615998; x=1792220798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bbsPZfGBd2rav72sK74P9etUlxxSzGjQ86YpqChNaKk=;
        b=Pjns0fgh/arPzBIJtcbAXrvEXd8AvaZptX0ce3WwJiHrL0tGI9EMdk2jgK+WqpAlvm
         in1kQ2CVLoQ5hstrv57aKu4c+yVCJDuWPD01bq2/1+5D83qRtSQoEwadphe6WV7pr9m3
         QEhQ95G0O+4W38WjeA0Y1ZwiuYC3wK2AHGNjQiu7rdnYj660U76KLpEzOOvkmB+HiU6i
         kVHsN+wyzMNjxT0ZzFucEP1tZ6TsALIUrClnn7+NiS+KM0UGkzA3BavgfP74oWtBJT4f
         hDn6R6D8Dtg3V0qEYAhZH2WtaQ+ssU2I2y8rtGI5jDPP7pOcyMjYRZb25wbPG5SarXPG
         tNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615998; x=1792220798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bbsPZfGBd2rav72sK74P9etUlxxSzGjQ86YpqChNaKk=;
        b=yONmTHJSr00xbP1XgA7hu6yK10jAjl3y0FL7CP9TsBirAZlQ0S65UeArgSyBzm5eZ/
         66EQd9T0AZ+Qd3FIVpUSrLp8qTn2J1qz91c/3QcYVSx3JFRjy6zj4cIKDBKqVLP9obWb
         W9qzvQmNPaiyM8wfOQagKqlmzotgZ0s+EEM8qXLYBrAdombZRym8tHdylePUvP2PZUHl
         7179+4n0n9yhOmZDnrvWAbNUdWb47GIN9lg7mPKl4Yx9Lt/6SU4Jw3I5i2V2n7odcGdA
         F0HM5ol6bnEwobfmFg9MczKPTWyOdpPZpinodnmDHldXLWRodKeEVa6jTKpzgwgSVv2D
         PgPA==
X-Gm-Message-State: AFq9FYL3vFnaJGuPlJ/K1v0m9eq5BD2AbHOa3EoO/0XquiqG5Lxa1koz
	D4IGL79fFJQZ2QC/aLzW0c2OVQs1tquo6fwDnerowIoBhHnz0MPP5f8JHzYjUnJI
X-Gm-Gg: AYBFou0mWEJh2EF1w921ZdJGLnpX5OrBN6lbM1QZ5BJ5BZpohQCHd4bib5z/jhI05ld
	HE/UVpz/R1rDWDDS1sXn7911I2LMZxoQiLLx7i43HXoP6AqGvXzOUFgw/PYpUlwKeznf2B5zKdV
	/bBbV2ED0XyZ3Yc+zUll875C7MAd2BKloNBjxzzV8Al0apaS4yzwNSs9wa/L7ugFwUOtUXBHZ2G
	o6+Q2ge81rMv1lHsbbZOghB/hI/BfF+Tncg7dc7T6Z3IgQS3GEfwFH3AJiE9vJXHYUSUekln3K5
	OFDDti5z/el4vdFPAk3nVzafoAd1YnLG3Y+NzGsHc5ouAl4Dnz/4CZWQp3t4YylySpuzqY833Sb
	b36qscx+WxNkqyjQqiOVIBIr9ooWzk+bcoSEFRjtFQ/K+NM+jTp7/sXU5csd4RlVHEPuxlNvTO5
	1Xe+EVEYBurZE5tEF3PhM9eKFU6IUy3L0ITZX6Lyfy1SDAM0zyQpJbq5x2X9mMz1PZpjpXdK5pL
	6g0Ba+JJbb+OyaQrRDP/DlaJrNT+X/D/+7kG2STdj98IbAPOvFyQ6iRjMKZV+UdTEo/mdtffgfO
	3kf7Wv7T08WJnHs1llVqrB/IDKRDf+HSsh02K6592EXbd4BK
X-Received: by 2002:a17:90b:3bc7:b0:3a8:5fb7:669b with SMTP id 98e67ed59e1d1-3ab3a97cd4emr3375779a91.61.1791615998049;
        Sat, 10 Oct 2026 00:06:38 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37163e21sm7955662a91.14.2026.10.10.00.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 00:06:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: bgmac: use the NAPI skb cache
Date: Sat, 10 Oct 2026 00:06:35 -0700
Message-ID: <20261010070635.97759-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate RX skb heads with napi_build_skb() and free completed TX skbs
with napi_consume_skb(). Both run from the NAPI poll, so the heads are
recycled through the per-CPU NAPI cache and freed in bulk instead of
going through the slab allocator for every packet. The recycled heads
are usually still in the cache, which matters on the small cores bgmac
is found on.

On an Asus RT-N16 (BCM4716, 74Kc at 480 MHz, single TCP stream unless
noted, iperf3 median of 3, A/B in the same boot, two rounds each):

                         before       after     (Mbit/s)
  local rx / tx          242 / 210    251 / 213
  routed down            154          156
  routed, 4 streams      69 / 83      71 / 85

Routed upload and software flow offload were unchanged within noise.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index f40fde1d6bce..df2f0a87cbfd 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -229,7 +229,8 @@ static netdev_tx_t bgmac_dma_tx_add(struct bgmac *bgmac,
 }
 
 /* Free transmitted packets */
-static void bgmac_dma_tx_free(struct bgmac *bgmac, struct bgmac_dma_ring *ring)
+static void bgmac_dma_tx_free(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
+			      int budget)
 {
 	struct device *dma_dev = bgmac->dma_dev;
 	int empty_slot;
@@ -269,7 +270,7 @@ static void bgmac_dma_tx_free(struct bgmac *bgmac, struct bgmac_dma_ring *ring)
 			pkts_compl++;
 
 			/* Free memory! :) */
-			dev_kfree_skb(slot->skb);
+			napi_consume_skb(slot->skb, budget);
 			slot->skb = NULL;
 		}
 
@@ -465,9 +466,9 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
 			/* Omit CRC. */
 			len -= ETH_FCS_LEN;
 
-			skb = build_skb(buf, BGMAC_RX_ALLOC_SIZE);
+			skb = napi_build_skb(buf, BGMAC_RX_ALLOC_SIZE);
 			if (unlikely(!skb)) {
-				netdev_err(bgmac->net_dev, "build_skb failed\n");
+				netdev_err(bgmac->net_dev, "napi_build_skb failed\n");
 				put_page(virt_to_head_page(buf));
 				bgmac->net_dev->stats.rx_errors++;
 				break;
@@ -1157,7 +1158,7 @@ static int bgmac_poll(struct napi_struct *napi, int weight)
 	/* Ack */
 	bgmac_write(bgmac, BGMAC_INT_STATUS, ~0);
 
-	bgmac_dma_tx_free(bgmac, &bgmac->tx_ring[0]);
+	bgmac_dma_tx_free(bgmac, &bgmac->tx_ring[0], weight);
 	handled += bgmac_dma_rx_read(bgmac, &bgmac->rx_ring[0], weight);
 
 	/* Poll again if more events arrived in the meantime */
-- 
2.56.0

