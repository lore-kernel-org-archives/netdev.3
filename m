Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144988;
	b=pHXtV5ww0HHYRb4X2NXv7iHhW1gI+4oplbkjaubPtkaBoY+IGEVPV1iy8LNxsesYT5qE
	 kAIve4M+ANViItYBbAbD51HewUm+ii7CQCW2x4nw4rYoSqIleEY5yWR1/BXAfswBxyM2H
	 aSsSnJTwKxUF7YxJ6npaleUABhLJZ3jHn3I7eKtvVjy5G8qJarJ8gENQpjTT202SH5tT+
	 JBIFd8wv+rktjpHq1tOgiM9iZH+VRgELGYKxnatWz/ydpCbbNIjyBKFtoHgCBkbpCf2ZV
	 /kcgle7zBUiyKSjEcGrrM3PilAnNJoXlIwAmkN6ekqYfmC8EZsY1TeTEOv6nK+1GS2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OsGKoIGB8oJgiLBZispb/gUIEGCVQxTtM4o9rSDXfhw=;
	b=tc7rgqEJcqD+hjnhGAJiTtzo52eDzRfgq2fSqSvRR4HzLvNrjwUxHllESiTt2h6nOGM7
	 Xr0wEzmPFqcLaXYMPF6SyOs6g/5J4pV1omGGpNeOp91Dez+IHV4KH3+UV2p57UTE1koPx
	 LI0zcQ+vF/NgN3C96OVNKNd2ZDc3p4NE3GOebdxowL3xmaUwPm/8RIrQyFdw3KIjuOaTh
	 BOXZ4lW8beOnpxNFCni+cE7Gu4sX3eGhNcxuix+OXSsfTCfeg1BxmibGI21z9puUti5Um
	 7U5EWceNFdIoTh73qtakAUJtev03gcnbNxydiNQ58kse+6YrQZFimrwwC3o6GRoAnSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MTfEj/DO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2A6606A326
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTfEj/DO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5041F031E3;
	Tue, 27 Oct 2026 23:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144988;
	bh=OsGKoIGB8oJgiLBZispb/gUIEGCVQxTtM4o9rSDXfhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MTfEj/DOaBV7UYVHeUcCXXbeOORi8rcuarCC7lAfzfkNg9g545SEA7YTD6k8Ia01y
	 qHYk1Ou7bWBQAYbexg9LykKfmicFsawznISakqXhLqM2eQjA+S7fNXxNZF0dmFDYCe
	 QNLry+IJZ6nOFmBCI4twxjvHJAoW2ioQSWYykebmRqMDr6RctHDr3r4tw95UycBzkw
	 v426Tld9CcRlrVdymC7KOk3dbg04ObeoK9cScagjqmVJQkNbdyoQmfqf1vxYX9Seok
	 Dcb/iB1fEBDV/LLJpt6R934Z75Ol3RyHqBwmTXGMBsOD1FAho+YBkw4zkIolFR31Ip
	 A+f0bmhEP5F8Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	eddie.wai@broadcom.com,
	prashant@broadcom.com,
	huangjw@broadcom.com,
	gospo@broadcom.com,
	brett.creeley@amd.com,
	ap420073@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/5] eth: bnxt: resize Rx head buffers when rx-copybreak changes
Date: Tue, 27 Oct 2026 16:49:37 -0700
Message-ID: <20261027234940.1267225-3-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027234940.1267225-1-kuba@kernel.org>
References: <20261027234940.1267225-1-kuba@kernel.org>
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

Since rx-copybreak became configurable, bnxt_set_ring_params() sizes
the head buffers to fit at least rx_copybreak bytes, and the copybreak
path in bnxt_copy_data() syncs rx_copybreak bytes of the head buffer.
bnxt_set_tunable() however only updates bp->rx_copybreak, and nothing
on the open path recalculates the ring parameters. After raising
rx-copybreak the head buffers keep their old size until some other
setting changes, and bnxt_copy_data() syncs past their end, into the
next buffer in the page or past the end of the page:

  DMA-API: bnxt_en 0000:01:00.0: device driver tries to sync DMA memory it has not allocated [device address=0x00000002aa210c40] [size=1024 bytes]
  WARNING: kernel/dma/debug.c:1162 at check_sync+0x577/0x1eb0, CPU#22: swapper/22/0
  Call Trace:
   <IRQ>
   debug_dma_sync_single_for_cpu+0x66/0x90
   bnxt_copy_data+0x12f/0x290
   bnxt_rx_pkt+0x24ea/0x50f0
   __bnxt_poll_work+0x42c/0xc00
   bnxt_poll_p5+0x579/0x17a0
   __napi_poll+0x8b/0x2c0
   net_rx_action+0x58f/0xbb0

Here the head buffers were still sized for the 640B HDS threshold,
four 1kB buffers per page, while rx-copybreak was raised to 1024.
Without coherent DMA or with swiotlb the oversized sync can corrupt
a neighboring buffer owned by the device or by an skb.

The device must be down for rx-copybreak to change, so recalculate the
ring parameters right away, like bnxt_set_ringparam() does.

Hit while testing patch 1, tested on BCM57504 - boot; set rx-copybreak
to 1024 with the link down (CONFIG_DMA_API_DEBUG); ifup.

Fixes: 152f4da05aee ("bnxt_en: add support for rx-copybreak ethtool command")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 622e89587e5d..ef4bea4a0f8c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4601,6 +4601,7 @@ static int bnxt_set_tunable(struct net_device *dev,
 			if (netif_running(dev))
 				return -EBUSY;
 			bp->rx_copybreak = rx_copybreak;
+			bnxt_set_ring_params(bp);
 		}
 		return 0;
 	case ETHTOOL_PFC_PREVENTION_TOUT:
-- 
2.56.0

