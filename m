Received: from mail-dy2-f19.google.com (mail-dy2-f19.google.com [74.125.229.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031694825C7
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172732; cv=none; b=n+pdnMi+WphPGCFilMbXfgvz1WWyScCdRPAm+KxLCVn6DMJLGo+4qPpJ5Xg6NKGTJEAXNzG+ZNbG9+myW46VMztyebGUijNSj38MorzV+WcAxKZvsoz2dXCVPcH3lGEciMxajWWQ3lKdgunl9hftD83FXoSlCyGj1uSs8Rq/d+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172732; c=relaxed/simple;
	bh=ktR9e2h8nCd9S0EFkl5DruJEUJcripKPI1tSmR1JOBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOdQZH4O6E1nzrpsz9+WaIk8Yt/B5mfCf68Td77btoHIWEj26R2JyFObSHXxgZoLDMXTHM57hLj7m4y+NQEWrdOk3uBJU0cz2zVTIXuH8f+jeQWFpPlq5Ed9nJLrjo17B8/v+hvYwnw85SsvaJrFIBnGg+efkOjGvyyrNNS5WkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRp7RS61; arc=none smtp.client-ip=74.125.229.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRp7RS61"
Received: by mail-dy2-f19.google.com with SMTP id 5a478bee46e88-3286624d194so693204eec.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790172729; x=1790777529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ZvYoYp7T3tg2JMG9Cckdchh+Egbf2tNmPcdBTT/ZU4=;
        b=pRp7RS61spOd3YquanMz3ILiDZe8eHlW4x1rnIWd94D+4fOganFvcOPUe8A2kdakHK
         4TBq6wSV11Otke9AyXZmkBBYvTEY6URiQVjYkEXZQpI2TBQyg7+VSXLkntRQ5pp0b6Te
         fXpxsue7zMjEdWg678URa+ONc3SIeFx2s0PsP7mlWZKI4iQyVisjAAftV7SxpHjkkaeI
         31iclWvQ04FX32JZ3a8a1LxcKxJC7H/uz5CEZxATZfKYw6k5s08bm4sZ+z9JRSFl+QzA
         ImD0yuJmFtW6SRfX7gUhCwc3xq/HZkYTv2lM1xIqYKc3XFcgEueLb+7b9uNNL9DDfyH5
         K0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172729; x=1790777529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZvYoYp7T3tg2JMG9Cckdchh+Egbf2tNmPcdBTT/ZU4=;
        b=E1TaT+KS0lkcvBVXmBIwi9LWMtfyYrQ2OxITFhNMRStDUQNQ5NGYWO2IngOlZnvCC1
         gHDOSj4qQOFesZYZJ72AI2UyU37eJ1MqhXtzirmKKEi17zvMDPvfYLwdSmmp6bdMsaKa
         0egDIzvtd/u4I/XghTyQnMqvtrZTkIOA0I7rpqIZecoXP0cEC3HpHB0bki55JE3EI5Jv
         TbwKtD3WV/Xl9ABmtcv/7CcCukFChUd4R0BcFhbb1H9VPbVwtTYH7v01BQ1XLmfAGxaF
         +1cLErbA1s5rm1Bz38aKVRJ9JJmu44GnnYnIsBIsdajIG42WU6kUujpD8Kired3yzeam
         di6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwldtkl3c/eT3/O6jKd4uO9/9FcpVknTEpoq2ozcYI0lMdcKnxQlHXeKMHhBn7eN1Gl8E92sJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kZAw0BLxsf+n+krh2hACfGD7aU6yIhloXsnRtkowrO8YKnQjnD
	93L0DeGr55pGwDR7LKY73jJkM3w7s9otXwLg6XReejgrzlOfvUV8xSzk
X-Gm-Gg: AYBFou0A7lsbzUF8az1DZHM2EIOfWxM1PKMD7RSyVs3NgTATAeZPGNxjXUlhRYXfIZQ
	YHxYbGcFg3Sh9Osm0Sej35ANj1UL7gteDjjQAARzZmDlYlk0VV7UERObpxkuu8nHmXh+4My9i4t
	Lee8ZqremIA4DpbSxZ90GtAbETjdBEhP5x/+ju6HA62w1VOCU1cyb18amR3xmOMMPsGByTo7M1x
	9UgjCRqlncFFuJFpXR9idUA3vSG657oEufK1y2nu0u/tzEYK55gm0ivDgqbxYQL77CAVwjOHhPo
	ijT03KKTX7BOKc4rT5UtSZsDUg3GAgwYEEHYD3OdCW2uXWeHLkjhC4a6eIZf29lujd2HbZKWqtW
	5GFwDaZB1CSSQ1U7rApkOW2qKNFukQCR69lZ3+DYGp7Xrf+7MqxLZD5MEm4rCSdZWATUmdx34Ap
	eLH8AVlf54WAxLbMXxzm0dl+k/1RKeU4Mth12AO0FTJJkktbRH9LMODNOy9w+GDMCW4n+rDMZuA
	A==
X-Received: by 2002:a05:7301:6196:10b0:33b:fc9d:947f with SMTP id 5a478bee46e88-33e8ea87051mr2781245eec.40.1790172728561;
        Wed, 23 Sep 2026 07:12:08 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm7193489eec.5.2026.09.23.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:12:08 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: wei.fang@nxp.com
Cc: frank.li@nxp.com,
	shenwei.wang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] net: fec: reject oversized fragments before bounce-buffer memcpy
Date: Wed, 23 Sep 2026 11:11:54 -0300
Message-ID: <20260923141154.2415545-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fec_enet_txq_submit_frag_skb() and fec_enet_txq_submit_skb() copy
transmit data into a per-ring bounce buffer when the source address is
misaligned or the FEC_QUIRK_SWAP_FRAME quirk is active. The bounce
buffers are allocated as kmalloc(FEC_ENET_TX_FRSIZE) where
FEC_ENET_TX_FRSIZE is 2048 bytes.

However, skb_frag_size() can return up to PAGE_SIZE (4096 on most
architectures) for scatter-gather fragments, and skb_headlen() can
exceed 2048 for certain GSO packets. When this happens the memcpy
overflows the bounce buffer by up to 2048 bytes, corrupting adjacent
heap objects.

Add a length check before each bounce-buffer copy. If the data exceeds
the bounce buffer capacity, fall through to the error path rather than
performing the out-of-bounds write.

Fixes: 6605b730c061 ("FEC: Add alignment handling for FEC driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 794ec42..8614984 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -558,6 +558,8 @@ fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
 		if (((unsigned long) bufaddr) & fep->tx_align ||
 			fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+			if (frag_len > FEC_ENET_TX_FRSIZE)
+				goto dma_mapping_error;
 			memcpy(txq->tx_bounce[index], bufaddr, frag_len);
 			bufaddr = txq->tx_bounce[index];
 
@@ -634,6 +636,8 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	index = fec_enet_get_bd_index(bdp, &txq->bd);
 	if (((unsigned long) bufaddr) & fep->tx_align ||
 		fep->quirks & FEC_QUIRK_SWAP_FRAME) {
+		if (buflen > FEC_ENET_TX_FRSIZE)
+			goto release;
 		memcpy(txq->tx_bounce[index], skb->data, buflen);
 		bufaddr = txq->tx_bounce[index];
 
-- 
2.43.0
