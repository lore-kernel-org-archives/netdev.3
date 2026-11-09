Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233630;
	b=yuX94818F8bIoMdARnKxtid20VPM0yhsyZrMVvLFmbds9SGXnRklgXIkFDDtpP5zXbvZ
	 K1UHnJNNQHLbCgCSi4whTHcY++fdz8mAB66R8h7VMA3ITDSYn0o0Ki4vsBNFU+Iw1OXxp
	 1h5VBCr07h9OIcId5k3Nr+mjWSakNVZT2KqJBmLDffynIHyjWRMUBNcHnGo0AtR1Jfsm2
	 P72vL2+QVewpf8V2/KZRIliuBIP4QJGma/ditJqLJ7gpIjJhTVQFJMeMU6IMoSi/c9nNt
	 /aKKXkOCDO016gstpHuWKeQ+3iIrAhZeQjSrqFyrWxbwrhs7Bv9iUopuvGuBaOQTdQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Os/kHx4LCNQuEhjGd63XDiS5ZOVJyk0A7oldmTRaPxE=;
	b=sCgmJvzl9uigKr9+ccbSMPI22cg3/7amUR3H3soNoCSlmeluNqLGVaJS0C5VRksz0pOn
	 78X670s6pF8yCYnDM3ZR6inK3jE2Eemmq/aW2+pS35S+3r8rMRSJDkIGFGq23bh8DX8TX
	 ib09DaDuo3ickfjgIVvGNnjdEw1cIFbMjuYB2cE3S36kxnsolOabDQInGRUs2QIOUiWFS
	 9E/Btsqo4jrwx6yiUjx8Zd6R3EYthG5e1KmtcOrjeWu6UMXcokFgniBuVlvZ39KXxxL0P
	 5ieOGUnAbUN/Imlujqfmyy7tTYmj38hWiAMB2PiJcgwlK/U1B/lTux+pBWPquHBfJzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W03cjfAy;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70A606EE85
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 14:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B70A606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W03cjfAy
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so591315f8f.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 06:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794233629; x=1794838429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Os/kHx4LCNQuEhjGd63XDiS5ZOVJyk0A7oldmTRaPxE=;
        b=W03cjfAyfB3Mf1YemElAlcVXtCdh4C5VQGKmkFRtXEuyAWwkH1cQtYiwCeliyriXfg
         ajuhNEC2X3U+Enq43hrs6IKow9w50DLvgAR/tPwtfR9ZZhlqiOR0Tpu1/9Y9DgCWKsRB
         P3uRCVFVNsu2BebFWvWhivxfxHiI6zfYjAdhyzzFRtiB2etkvGbIEb1yV7P6ppxjgiRv
         xtKCMM1gK6C+hIj1ksaF4PbQ5miHMxJoSFnA+5z4WUvKmQaGs4YJDfdwiNLxkyiWb15X
         /V1m1CX3mkupApejKbSpTIUnZfVUA3EZn997/AMtzcvXNvjRpJWRAO95Hy5lQMD4L+7U
         LNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233629; x=1794838429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Os/kHx4LCNQuEhjGd63XDiS5ZOVJyk0A7oldmTRaPxE=;
        b=HLCCQLslgDsRZKyluKyTxjd/Z48/f4PC/ufFryktfwgkivMqDa3UIYxzOk8D9ASS5Z
         5ZsTA2cqVoh1Ye84l+C7t81AYbN/JFP8Ngy8Klu3QvJDny7DlC5mSAJBEf3KhdMK422G
         /Sy52TahiF+oGGHe9vZrgaWYYsYzOO/Zlts/s3zdA5ekM/ahCccJ8/csFUwIn6HjE1of
         e5SKrfPtmnDgufCkTjAzt2zZWk0q0eieg3YXg57iBEaQeWXid+8HnIAbftnoDjbv3GpB
         AKrRhOvEaWcDFGBUftI2EPt2fUCzghc8Y9x6sskxrr0HyJ7veOlKN8bIVciglQYEjuUV
         Qw3A==
X-Gm-Message-State: APuU4Z9PKsiJeR6SqWkkvaEHrCnWpx9Q+tMCac95yUSZnVNkUzQuVwxy
	SzcWiZKc1xzC4voQXvlrIndMyJitEuq2q3kwrWFWs2ekB23Px9QzVM8C
X-Gm-Gg: AYBFou3VXDpBA8/e9Xx6jk19ckFtalu6XSBIvidrGWcXEpejVb/7pnr77HVQ3qeXJj0
	IlIF3AB/aPTj7KlvRQd66aKiT4QdSftPabvRlE0F00dU3nv3VbS/SM9tatMm048/5poYe3Uyx8d
	kIP5azYLEccwmseX/BJrfgqrjElBD3hyzyQkHMMxmwobJGi0mC4CuzfaejTvInADosUq0on3e5m
	HmX16L18HC7OIsy3+LJuDFdJfWY3ZLtbFdHmb5mC/qdBtsWuVgqlhl0rUZc4Hrf9kwWoFdDKu6F
	Ffz8ztmY4frPhwjK/CuqnTMiTFgN2P7/essF8zepp+kUg6VfmYl8uy/SK8szbhg/L47ALGe/YbL
	qAf4+7PuVEgM4Dv587202CLdFd3tMPqmFRfMGiaEwOQ9EwEqu+YFLwq33/4sbbDTqne6a8JweXx
	eo8fP5e4D7d8gGT1uGzuxao0SXmOCyJQVw3D+dq5lZnQGAIpCfbJ7+PkVGMUC+uhZYZEDXD5PNv
	VGVbb6yhkT1xw92/OJlJiCrqfC8XITHlZodTvDMcGS2pyMnZ0EOHoc88hisqrQF/v73IiIs+rht
	AQ6i2oiyxTXZp7MapfI+Z8gzavtC9cObIf7VeCKqbmoIGg==
X-Received: by 2002:a05:6000:2881:b0:488:89c7:31aa with SMTP id ffacd0b85a97d-495842b8bc6mr8287926f8f.39.1794233628388;
        Mon, 09 Nov 2026 06:13:48 -0800 (PST)
Received: from localhost.localdomain ([2a06:c701:474b:1700:46d1:cd03:d771:378e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495bf0772c1sm7949612f8f.18.2026.11.09.06.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:13:47 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: ena: avoid RX copybreak for multi-descriptor packets
Date: Mon,  9 Nov 2026 16:13:44 +0200
Message-ID: <20261109141343.920187-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ena_rx_skb() selects the copybreak path based on the first RX
descriptor's length without checking the number of descriptors. When
a packet spans multiple descriptors, this copies only the first
buffer into the skb and fails to recycle the remaining request IDs,
while RX cleanup advances by the full descriptor count.

Restrict copybreak to single-descriptor packets and apply the same
restriction to the rx_copybreak_pkt statistic. Multi-descriptor
packets then use the existing fragment-processing path.

Discovered by comparing the in-tree ENA driver with Amazon's
standalone ENA driver.

Compiled with W=1 under x86_64 defconfig.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
Already fixed in Amazon's standalone ENA driver:
https://github.com/amzn/amzn-drivers/commit/8c47df628bbc6623bd9a419f261ccc46abbd36de

 drivers/net/ethernet/amazon/ena/ena_netdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 7eb6456ed0d5..80f5d08305c2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -986,7 +986,7 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 	page_offset = rx_info->page_offset;
 	buf_addr = page_address(rx_info->page) + page_offset;
 
-	if (len <= rx_ring->rx_copybreak) {
+	if (len <= rx_ring->rx_copybreak && likely(descs == 1)) {
 		skb = ena_alloc_skb(rx_ring, NULL, len);
 		if (unlikely(!skb))
 			return NULL;
@@ -1293,7 +1293,8 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 
 		skb_record_rx_queue(skb, rx_ring->qid);
 
-		if (rx_ring->ena_bufs[0].len <= rx_ring->rx_copybreak)
+		if (rx_ring->ena_bufs[0].len <= rx_ring->rx_copybreak &&
+		    ena_rx_ctx.descs == 1)
 			rx_copybreak_pkt++;
 
 		total_len += skb->len;

base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
-- 
2.43.0

