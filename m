Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587A41DE12
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127748; cv=none; b=cPu8n875LpZnKtg8y4DTMRIN8cGs9ZnCB8SK420VSv0Cuvlqga7g8RNqjky4WCjgknynY7piI3nKZs9NVxb7yVJ+sqadlrsGqWhQmdawt7fSHgv1r8+OwjVlWX8tK3iErGtS8sE142idR0zo8QIMGh6V0zb2HppTf1L/hfw5U2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127748; c=relaxed/simple;
	bh=ns8JUZo/8h1qt2BLbxp7mlBkPBfbdESk+YHF71YA72g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+CuiVmIcOF9pbAwF98NcViQDBelxV1JzYsrnECSZDBUZUEIJG5pg4CGo89VlkFyKn4IVFyRrm2OQM+J6SMZ0+rUELO/qpkfJ4sPYF8880+FjgRnyxczsFnZ+/DBzss6A600T7OZlPR6PtrkC6f2shk52sPFJRsqeu3FhP2UY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJPYG8sr; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJPYG8sr"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so9283725e9.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791127744; x=1791732544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNNbazBXmL+AGn+X6q34XEzodiqndLswy1F6C+r0wbk=;
        b=YJPYG8srbinfjEFY46TxPa7yWtO9ydxgkO4/CM9/KebSnGIjXIRDjrrm1YScd2Fx6X
         IGfeEYuMWJjAlrFSFMxI2O6mjcPSSPEjtmXWf71e5w/3VVxL6jBxlv47TsBaAggZ02yq
         CwH54XkAGCK8838tn2hTpCbPnTvnL7kgfMPrDHuGmrg+me8kc5PWhPo2k9qk8eTrdBGv
         ypBhJiCA33X9dny9S8XT4NJYg1BSSY2EX99G9vgQqdiTWrN2KbsWvBPiK2V2aQHHp0ke
         2WM+2Ks+j+f02wr3mRrMre3PjjZUj6xcfBh7spfLrB/e8AeKlthsklZ8Kf7H5rLMfEns
         FxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127744; x=1791732544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNNbazBXmL+AGn+X6q34XEzodiqndLswy1F6C+r0wbk=;
        b=Isvq2uNByfFF4py/RarUgq7ySsmF7PTZV/uCgLBVjL18MaQHxHSmrS8rrv2iBBF0pF
         wNL/leTpX78pMSFLWtvFKdKwrMnbwVSPF0LKPsPOjiqIOD5c8jfCuVE6olvx6vG5kAID
         IdSnbNMVBrfwzs0YwBoLWKrulz1T645oZnJ0aWdGP4jHWTuhjPOtA4NV3/p+z7M0ye/e
         u5NZaT7GMk5vwmzKkvGSzjiEJ1x96VPTVAsWDQtHlODkwqZKkRMkuVHe63Rvn5LmAH0B
         776xMIrOxdh05OTWXn0jgCo/Xl30mSmNqoHmqzgX93tqf1HiMiBoGuKQYA5Y290hUCPd
         XeDQ==
X-Gm-Message-State: AFuF++lm2LmqjwUjlvIqUKCyOxBMIWoCRbDZhuT5nXqI3b7wvdz/phAb
	73dRda4Ug7GlYQxl0OCv+s3IMVBcN+MGnRXG/cXDBWz3mAR9h2dl+w/N
X-Gm-Gg: AYBFou0jLsd+AMKdcUmBoCSO9Uba7VCRvy+EokCxekJMN5RG4VDj0nG62vXH6pguZAx
	dNgg0aHJFi7m9dG+gPM5squEsESWG5O3X7S4ttEyQD+9wcT5dWG8CM/61eTYywAb+uN7VcrTwba
	foGypbVaitP2FQkFhIjsO2jIeMJ0/R4tMkwOOaTRcYUV/XHpLL+RxjGW2DBu/DfftkCAQU711Bp
	NtaChOHX1eCRt/Y8KsAZLbuhKFyK4/045rB2+SjCqgCrCqPM45zrrvXxi//uhGyoY44HmVUH2N/
	C+yQSaYycm4YsnSyGWKcs05t3oWQWC+EKhxMkVERKzIXOzMuESQoUKLx6p4WyXVMvbw08sgHn6/
	w7eI0harDkRWYMx9WyDu9AbRtimM1IEmjn1CQ7Q5p601b+Tw+OTUhrbP93HGNtxcx08lu62/+4s
	HJdfDTw/uFi1kOcpaWUYq0+jv2ijbXkQD4NXAf5/55uAjCzLg9Spz18xSYKNPdoacSzBT55uSmq
	sdPMew0jKNvRzH8IRkCiuBqo5jH4UHdsUQnbSrlSCdzYm5EJsqCosEnJ+/y1wFYQNk5AcJr0LA=
X-Received: by 2002:a05:600c:3545:b0:4a1:242:1353 with SMTP id 5b1f17b1804b1-4a102421468mr124163015e9.5.1791127744379;
        Sun, 04 Oct 2026 08:29:04 -0700 (PDT)
Received: from citron.bnl.ovh ([2001:861:44c1:870::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1698f7910sm83819735e9.3.2026.10.04.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 08:29:03 -0700 (PDT)
From: Benoit DE RANCOURT <b2rancourt@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	linux-kernel@vger.kernel.org,
	Benoit DE RANCOURT <b2rancourt@gmail.com>
Subject: [PATCH iwl-net 1/2] igc: Fix Tx stop threshold to cover empty frame descriptors
Date: Sun,  4 Oct 2026 17:28:39 +0200
Message-ID: <20261004152840.61222-2-b2rancourt@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004152840.61222-1-b2rancourt@gmail.com>
References: <20261004152840.61222-1-b2rancourt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag
bit") raised the number of free descriptors that igc_xmit_frame_ring()
requires before mapping a packet from count + 3 to count + 5, to leave
room for the empty frame (one context and one data descriptor) that may
be inserted ahead of a launch time packet. DESC_NEEDED was left at
MAX_SKB_FRAGS + 4. igc_tx_map() uses it to stop the queue in advance,
and TX_WAKE_THRESHOLD is derived from it.

A queue left running after a transmit therefore only guarantees
MAX_SKB_FRAGS + 4 free descriptors, while the next skb with a linear
part and MAX_SKB_FRAGS fragments, each fitting in one data descriptor,
requires MAX_SKB_FRAGS + 6. igc_xmit_frame_ring() then returns
NETDEV_TX_BUSY, which the queue stop logic is meant to prevent.

With TSO this happens routinely. On an I226-V (8086:125c) running 7.2.8
with MAX_SKB_FRAGS = 17, routed and locally generated TCP traffic on a
CPU-saturated router produced 10890 NETDEV_TX_BUSY returns in three
runs of 180 seconds, all for TSO skbs with 16 or 17 fragments, with
21 or 22 free descriptors in all but 5 cases. Together with deferred
tail writes (xmit_more), these returns led to 25 Tx timeouts and
adapter resets in the same runs:

  igc 0000:08:00.0 terra: NETDEV WATCHDOG: CPU: 1: transmit queue 2 timed out 5353 ms
  igc 0000:08:00.0 terra: Reset adapter

The following patch addresses the lost tail write itself.

Raise DESC_NEEDED to MAX_SKB_FRAGS + 6 to match the admission check.
The additional reservation is currently unconditional, including when
launch time is disabled; match that existing admission policy in the
proactive stop threshold. With MAX_SKB_FRAGS = 17, the queue is now
stopped below 23 free descriptors instead of 21. This also raises the
completion-based wake threshold from 42 to 46 free descriptors,
preserving the existing two-times-stop-threshold policy. Throughput
and latency effects were not measured.

With this change alone, three runs of the same test on 7.2.8 produced
no NETDEV_TX_BUSY and no Tx timeout over 8.8M NETDEV_TX_OK returns,
including 613k TSO skbs with 17 fragments.

As before commit db0b124f02ba, an skb whose linear part or fragments
exceed IGC_MAX_DATA_PER_TXD may still need more descriptors than
DESC_NEEDED accounts for.

Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
Cc: stable@vger.kernel.org
Assisted-by: LLM bpftrace
Signed-off-by: Benoit DE RANCOURT <b2rancourt@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 17f213cc93e4..f1efadbd9f74 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -575,9 +575,13 @@ enum igc_boards {
 #define IGC_MAX_TXD_PWR		15
 #define IGC_MAX_DATA_PER_TXD	BIT(IGC_MAX_TXD_PWR)
 
-/* Tx Descriptors needed, worst case */
 #define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), IGC_MAX_DATA_PER_TXD)
-#define DESC_NEEDED	(MAX_SKB_FRAGS + 4)
+
+/* Tx descriptor budget for a head and MAX_SKB_FRAGS fragments,
+ * each fitting in one data descriptor: one context descriptor,
+ * two descriptors for an optional empty frame, and two spare entries.
+ */
+#define DESC_NEEDED	(MAX_SKB_FRAGS + 6)
 
 struct igc_rx_buffer {
 	union {

base-commit: a83267db14681b3be481e02a4d5a38177507006c
-- 
2.55.0

