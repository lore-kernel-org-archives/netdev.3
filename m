Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537438;
	b=BfHZagybSVSUNa7j4tUeJZhBTAVNcMAtTwVsNnDKyX69SLC5kKkBso2iGyhmoCPd49tC
	 0Y3QwmBEfz1mwlS5x8LgN9ONb4KVZM2Ovv/0rmZm7s6SKgAFf3mjnnlj8gnClyeBVxbMh
	 zRyccCs6gI0UvQoZcnMzAShRZKVbXv7qenwEPaFXkIqT+6yJgNPJoegx4X1S8SDsH+QU9
	 cm+o/30h3pXZ2PkyQQZC147GVmVqW2NbikWFjoWrwvoX9ShWbB8unJZ+fqEetr+D6rxDg
	 L6LPbfMYMPzqyhQMQXxdwP/1TBwwv56qe630xBdv4PZzVchz6niwvnATuhQPbAdy7+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uNLcmzGbPyxrDzejr5AbDJAD8CAf+fLALEo3HZwcBXk=;
	b=1y21W1CzJTSO7jVGmwnltANXqrUMn1LLsk7c4Fr/oyVOzi44shSn2zNS4lzUQ0P5VjBb
	 xaQ/EWb+Q5HHHkSmHZpV/YyvnVUbI4LK171hO9UvBZvecs7sDGvs4juLleGK+qKVBHIW7
	 bT76TZNm8pdxb/UK648J5P+OZtEfLbGDNuXbQE2zICmLsYWv7zj7CW0LAI9el0XP8xEhr
	 8GuymUIFNrYHJFY1VWYGl/DbuAs02T5qKk0ZX33P/TIhBbm/lszCrQLJlhHjX5nqyN4K0
	 2LMZihxIDBiaYZg2mwkeUSRiNqYDNHEBaaePghIITIsutWxQOF9bn1OQ07aedNoT4QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SgGEiRBE;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB745606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB745606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SgGEiRBE
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c40f29667e6so10295066b.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792537436; x=1793142236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNLcmzGbPyxrDzejr5AbDJAD8CAf+fLALEo3HZwcBXk=;
        b=SgGEiRBE9unPyBTgv6ppFscSIVEV02BOWARDnd6WD+ZmooptrVIAQuXxMSzTPOT7ZS
         d/JPU/SeNyy5iVFFzc2LjFu3nyCvsgmRf+kDwdbRXFEKB7Kqw2Uu64K+GkzV1fw1+wU8
         QUZ/rkVtayGmeRdxC6kBh0fKlQ13+mW/oqGM91xDU+Sm84g2JSiz7lhUxxJEadtyckxf
         Y/3k1iWLZ6AT+Y7pSEjfQscsRR99C4RFpDt7l3l0UPLRtriDBn+hxPDcqzoTnC3RKSrt
         jMYXDWKp27BV2oXUjRIGGiX77M4W34ASUn6gCj5z7q4fTzGlIaI0swsRS0ISbL9Uyz17
         2dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792537436; x=1793142236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNLcmzGbPyxrDzejr5AbDJAD8CAf+fLALEo3HZwcBXk=;
        b=P3KKOQKeMUublI5y/Gr9dsLhyYQGDBYBI2Qv+J012tUUhB94KHBlAlZOuWPk/2oPot
         5XnfzJNCANRj3gIyWXKeAcZzbQ+PJZ8CE1mvJWvv24reZiErRaPqaASwPEhc5lmvql5O
         X2obY+5j6LUJyuoR2XN1f+i6UDWGk3k9hvKubLCljYxS+yZ6eEw0wvQoHSqF8zcy0iou
         QS9UhQWozufSc8qtQLIIn6DkYmWID9k0ay1YB+BL7b9B+D7mg6L5vEpwniSAymeNz8F0
         jbbe6V1t/frjcHo1K9Qlwy/oWOPzAn/yQf4/TD/oILdWQDch9LfTSBqaZ1nnYR/cHoGy
         QT6A==
X-Gm-Message-State: AFq9FYIFDUwVy/FPhQ4fuC+zvMf6IzYfzJG5yLBPvA2sLT3UexHYxz3i
	0wTC+7p5hHyHgsJjf2x43DWq2UyoifBPClqe5r1x1Zv5t2yb+MJ4Lj97
X-Gm-Gg: AYBFou1wc8rYAwK9WUUpfEkSZmIfg0NMEx8dPnGPAv035lJrcvfqCwHbcSfQrX3onYq
	UjqCdPR9aKNWqiuHM66Dr/tw3b0yRJiLVM0mUzFB3AaA+a6iE441KQq/1ObZenU6g2pB2Yr7F+L
	dBidfV1nb33QEW1tENJvBrZ4J8FhJd85c46wBUwRK4dwk187EYJ/wUGEeMorO+N7zvtInntg9t/
	8amWa4cSr+dbw2nPUX6FWzXB/4cBHoCGb19gbv2Jc221QA+BB8TnOv7D0HAxiDZk64ZqI93rG3O
	LNpukn6qClEDgE9OVhMRIAzGtjwF9Ab/2w/1OO4CyVo7SX+CIBe6gFWMGG79Ay8HriwwS4AvouD
	M9G7cS4Vk+cyKnZ/AIRuddPX5TQe1SRROOp9EapKVqQpjNZTQfZm3yA93QnIsas7e3SCjdqJNVV
	aglaRELrB58wRLvDh+qLiAgCFqPrEyCzT86HSLIYHabiqdXp01UF5lRCOoylTLEeaKbAWBZEyQX
	B1JnxKucz1U+phcTPmrH0pGS7qaheSAqrG4/RbE1pzlIr3hhurL8U/6smtH6vNq5E/F1uMUSEM0
	5aHvyRchHXJGCiaxWubx5Wn5cMY=
X-Received: by 2002:a17:907:2d29:b0:c41:55b4:d88b with SMTP id a640c23a62f3a-c4679708c7fmr34909466b.43.1792537435956;
        Tue, 20 Oct 2026 16:03:55 -0700 (PDT)
Received: from localhost.localdomain (2a02-a466-79a7-beef-68fa-5691-e1e5-a015.fixed6.kpn.net. [2a02:a466:79a7:beef:68fa:5691:e1e5:a015])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46790366d8sm18433266b.87.2026.10.20.16.03.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 16:03:53 -0700 (PDT)
From: Andre Brait <andrebrait@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	g.goller@proxmox.com,
	Andre Brait <andrebrait@gmail.com>
Subject: [PATCH iwl-net v2] e1000e: work around TSO erratum that corrupts data and hangs Tx
Date: Wed, 21 Oct 2026 01:02:11 +0200
Message-ID: <20261020230211.75665-1-andrebrait@gmail.com>
X-Mailer: git-send-email 2.56.0
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

On I219, a TSO packet whose first buffer is long and has a 4 KB
boundary just after the TCP checksum field makes the NIC send corrupted
data and then hang the Tx DMA. Forwarded VM traffic (tun/vhost-net)
produces such packets, so hosts bridging guests onto an I219 hit it
within minutes:

  e1000e 0000:00:1f.6 eno1: Detected Hardware Unit Hang

Right before the hang the receiver gets TCP segments carrying data from
128 bytes earlier in the stream, with a valid checksum.

This is the erratum Intel documents for the 82571/82572 (#76), 82574
(#17) and 82583V (#7): if the first buffer is larger than
3 * (max_read_request - 4) bytes and a 4 KB boundary falls just after
the headers, a read is repeated, wrong data goes out with a correct
checksum, and the Tx DMA hangs. e1000e never implemented the documented
workaround.

Apply it to all e1000e parts: limit the first data descriptor of a TSO
packet to 3 * (max_read_request - 4) bytes (372 on the I219, where
pcie_get_readrq() returns 128). The rest of the linear part goes into
the next descriptor, which e1000_xmit_frame() already reserves; the NIC
still segments the packet.

Tested on I219-LM (8086:15bb), v7.0.14, byte-verified traffic:

                                        unpatched        patched
  packets placed inside the window [1]  hang in seconds  no hang
  guest traffic, TCP timestamps on      hang at 387 s    60 min ok
  guest traffic, TCP timestamps off     hang at 402 s    40 min ok
  guest traffic, VLAN tag from stack    hang at 1176 s   40 min ok

  [1] 785-1013 packets at each of 10 offsets, 54- to 70-byte headers

Unpatched, data was corrupted at every hang. Patched, no corruption, no
Tx timeouts or drops, and hardware TSO stayed in use (26.5M segments).

Developed with an AI coding assistant (Claude); details below the cut.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Assisted-by: LLM
Signed-off-by: Andre Brait <andrebrait@gmail.com>
---

Notes:
    This is a follow-up to a first attempt at fixing this issue
    (https://lore.kernel.org/netdev/20261018203215.77371-1-andrebrait@gmail.com/).
    
    Gabriel replied that the stack can still move the headers after
    ndo_features_check, which made me look further. The condition that
    patch relied on, TSO headers crossing a 4 KB boundary, turned out to be
    only part of the problem.
    
    The NIC hangs, after sending TCP segments with the wrong data and a
    valid checksum, when the first buffer of a TSO packet is long and a
    4 KB boundary falls 1 to 16 bytes after the start of the TCP checksum
    field. The headers do not have to cross the boundary: with TCP
    timestamps off (54-byte headers), a packet whose headers end 10 bytes
    before it hangs the NIC too, and the first patch did not catch that.
    Forwarded VM traffic hits this because tun/vhost-net builds linear TSO
    buffers at arbitrary offsets.
    
    Intel documents the same failure as a TSO erratum for the
    82571/82572, 82574 and 82583V: a first buffer longer than
    3 * (max_read_request - 4) bytes with a 4 KB boundary just after the
    headers. Its workaround is to keep the headers in a first buffer no
    longer than that, which removes the long-buffer condition no matter
    where the boundary falls. This patch applies it to all e1000e parts; on
    the I219 it prevented the hang at every offset in the window.
    
    The full investigation, tools, captures and raw results are at
    https://github.com/andrebrait/e1000e-i219-tso-hang/tree/08c29e379bac
    
    Summary of the runs. "ts on/off" is TCP timestamps in the guest (66-
    or 54-byte headers); "VLAN" has the stack insert a VLAN tag (rx/txvlan
    off, timestamps on). "hang <Xm": every run hung, the slowest within
    X minutes; "ok Xm": ran X minutes without a hang.
    
                          ts on      ts off     VLAN       placed [1]
      unpatched           hang <27m  hang <7m   hang <20m  hang <12m
      first patch         ok 252m    hang <6m   ok 72m     -
      check in xmit [2]   ok 60m     hang <2m   ok 47m     -
      SPT/KBL regs [3]    -          -          -          hang <1m
      split at 4 KB [4]   -          -          -          hang <1m
      this patch          ok 60m     ok 40m     ok 40m     ok
    
      [1] buffer placed so the 4 KB boundary falls inside the window;
          "ok" means about 1000 packets per offset without a hang
      [2] an attempt to redo the first patch in e1000_xmit_frame(), on the
          final layout, segmenting in the driver; it could also stall the
          queue when it returned NETDEV_TX_BUSY
      [3] the existing SPT/KBL IOSFPC/TARC0 workaround, extended to CNP
      [4] first descriptor ending at the 4 KB boundary
    
    Every hang came with corrupted data, except the two with the 4 KB
    split.
    
    Limits:
    - Tested only on I219-LM (CNP); an I219-V hung the same way in
      production. The 8257x parts are covered by the erratum but untested
      here. Runtime-tested on 7.0.14; builds with W=1 on dev-queue.
    - The I219 window (1-16 bytes after tucso) differs from the documented
      8257x one (64 bytes after the headers). Intel may know whether the
      engine differs, and the I219's actual max_read_request.
    - Not addressed here: since 95ecba62e2fd the netdev watchdog may never
      reset a hung e1000e (bugzilla.kernel.org 118721, comments 29-30).
    
    The AI ran as an agent with SSH access to my two test hosts. I set the
    test requirements (byte-checked traffic, controls that must fail first,
    identical setups) and reviewed the results and the code.

 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 63ebe0037..704284188 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -219,6 +219,7 @@ struct e1000_adapter {
 	/* Tx - one ring per active queue */
 	struct e1000_ring *tx_ring ____cacheline_aligned_in_smp;
 	u32 tx_fifo_limit;
+	u32 tx_hdr_buf_max;
 
 	struct napi_struct napi;
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 834a5b888..f5f5d2230 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4143,6 +4143,15 @@ void e1000e_reset(struct e1000_adapter *adapter)
 	adapter->tx_fifo_limit = min_t(u32, ((er32(PBA) >> 16) << 10) - 96,
 				       24 << 10);
 
+	/* TSO erratum (82571/82572 #76, 82574 #17, 82583V #7, also seen on
+	 * I219): when the first buffer of a TSO packet is larger than
+	 * 3 * (max_read_request - 4) bytes and a 4 KB boundary lies just
+	 * after its headers, the NIC repeats a read, sends wrong data with a
+	 * correct checksum and then hangs. Keep the headers in a first buffer
+	 * no larger than that.
+	 */
+	adapter->tx_hdr_buf_max = 3 * (pcie_get_readrq(adapter->pdev) - 4);
+
 	/* Disable Adaptive Interrupt Moderation if 2 full packets cannot
 	 * fit in receive buffer.
 	 */
@@ -5632,6 +5641,8 @@ static int e1000_tx_map(struct e1000_ring *tx_ring, struct sk_buff *skb,
 	while (len) {
 		buffer_info = &tx_ring->buffer_info[i];
 		size = min(len, max_per_txd);
+		if (!offset && skb_is_gso(skb))
+			size = min(size, adapter->tx_hdr_buf_max);
 
 		buffer_info->length = size;
 		buffer_info->time_stamp = jiffies;
-- 
2.56.0

