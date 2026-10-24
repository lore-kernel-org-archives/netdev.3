Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802804;
	b=j8q/TpogwEcLFBPNWfAEj5zjwxRhe6dHtuJu89QCn+toyvOA+T8QWfTUtkq1N06rRgjy
	 aKCzqF56aShZcLuo0Gk7dvEpe0e+YViAvPk6xpi8VU2lWTbE1Pi9jwqLUw3f3vGCHMlOy
	 0RTvFQU8z7NkkOjLTCDi1LIj+ZEqNdWZWVM/AfdxTjqfUwxwbSwXlYqoXYA11ExOgTHSb
	 QIDLnhFZ3wxOn4not7EgP9rtuII+km8yqT6lFLcAiCh5+H7hVw//pSN1cMYQi+X766v1C
	 8ZS2PXsPKhNreWpVWTH/r2TpOiG/DtOBbe52EYQpynnVA2N9i+sKcJWJw2a2ZNSXazw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MsZrhWTvBYo1vnFa1x2gD9MSo4aFcjCOgnLOkNzEX0U=;
	b=EeET+7ks2ULxPi9WCwFXcAFsc9iZT/s5fgK05nHTKs9QLZeLtDpGKzmlJthJKObIf2qK
	 elYEbXrFxkHp+IxfJY/3XTbIpFLJ8PiVR0d4ivtAS1N5HHM/6hVJLsXXjgEiI7FDAVKKf
	 R0qIIvFGQGXAuDPITzmJU/VsDjD9NJfXGpEJ7X9e8PT2IunNfMic6B/2uzOf5J81Sqvcr
	 w0fNxz13VIayZuJePadTcRKu/Gag+diuecgPdQnvh3lDBX5LnTLjO3V8cSEFCfrpfq/ZM
	 Va1BfvYNaOFBxKt7LzKsRzritG4okpUnhfNwp1WSPBTURucx3FDbW7FOUn3jLRMYuDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YNE2Ztpg;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E915606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 00:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E915606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YNE2Ztpg
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c263415982eso180120066b.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792802802; x=1793407602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MsZrhWTvBYo1vnFa1x2gD9MSo4aFcjCOgnLOkNzEX0U=;
        b=YNE2Ztpg1p2fXs/Hc1dEd4CaZP7Bs6JEtKZWbjv9h8dr/ytH1a58pM+s5yzyf2SpAG
         nBoba5kYFw0lLX07vqIgRbqDvCXZxaHJ1DYFTZQhZBs+Q/1xrLa1TecpzXKpWHOlo+Ly
         0fLEWAiYFXjRX7V8oJD2pHErohMsYjBHsf88J3PijvOAj+xq7S9nryV97/T1cpoy+0Gu
         WWVjYgb0C4yOZMwuvDJeV5wOMhjuMzInrDdsH4mCBsX0LslMscKnHMpt2aasiM1WlfN1
         Ws9piX8tx6W+qzM8hbCC/BuiBV+ChaRpXd1E0b0anRKY/I9I1bh0qKxp4vfoXSYFGl/X
         NmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792802802; x=1793407602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsZrhWTvBYo1vnFa1x2gD9MSo4aFcjCOgnLOkNzEX0U=;
        b=XsVnjXONETUe3dOaF+gR4csb67KbSswIpv3nP1hQAWKUNMar/ixTnp3/hBxI8SPraZ
         /s3QX46rwnSM7A7zYiEpY2HycYY6HjXUthRlD6ZIqJdeHzATx4FJZ3+4EEqO4tyspie2
         e6QBJwJzlyj34ONIlO+AZzzvU8Qd2JDMx9vIdQF2+QzmeY3lGrU8FFltsE/wOsEnHFmV
         Ly6XJZnyagbwCVqZkMAZx6Causj803fo3YWAiu5RvRoIJM5heIf/3YWXtqoIQK9mmmDV
         1vNCP7vFlw57+SYAurc3JHCLboYSPe7yr9u3PHmt3ycbHcZbJGD6epaodButl/t54gzG
         21Pg==
X-Gm-Message-State: AFq9FYKFRsnx/2FjW/W/zW2RhXilQ02hdp9Qh0NOgo7DqsN3P3UJSTLK
	0CkgoR6pLCdp0WhqzFwTmKcl21mGoiTt1lbGMpebtJmGTvRCe34IAoM0
X-Gm-Gg: AYBFou3C/1mBhAs6BFu1zblEheYB9MBIBFjED+jxwGE+lpyKEYM+nTV+bhix1YsaLBu
	V+owfEMs6tznemgR5gWXEIPo6JYqQs7z8CGclQ5g3AqP277i32ys62k+cc5AAPC/DqhKm+0mWTw
	SaAIwq+Z6Yeg96YVLj7jTxvscySBsbKkOc6q/No7p/Efit5G6UqYDLHSb79XK5P0TMfdPzd7JoQ
	wMV4VYluO6aOH3T50C0s6h6ZvcwVoAillpqazN1jCR2DmLFymmn3JCWJWHyjArM//nuKrRDhC+K
	fHf/jr+xtioDflzZ/TqpaTJzIi+CS5HAHbn3cR/sFqY1IE7Q1NiO607lss3f7saLcWbsxTG2bMc
	mXQemYgOxg7qHy0b+mcteKc9Y5bSgRvUp+qbLratiLjCeP8LSgQaH9L2tYdDjSRkAC6T+FhBHGb
	Dt8KGdWlvFUB3tObyo9ENvu1u6ojsv6WP/IL5idkZvfNCCqjv0SyLhsWcZU7R92BSVzk5OXPy7W
	Vz9/a/LUADuvNeIsaO0n5i4tVlb5y0O/m6bhQHVMX5gqJeOOvge+sHGzA5cZedg8BydJp+S5oDr
	aid/kniH8nbF9Op3p3TdxVQ7z1Sxl2+dKiJH3poTkC7h1uNOmdhXAzdaCpamj++tKRY4r08fyqa
	HrqB2mkr6vEs6idM7bfGjPnryhCBwPMw=
X-Received: by 2002:a17:907:6d0a:b0:c31:be58:5dde with SMTP id a640c23a62f3a-c46bdea43d2mr54564466b.40.1792802801610;
        Fri, 23 Oct 2026 17:46:41 -0700 (PDT)
Received: from localhost.localdomain (2a02-a466-79a7-beef-592b-860d-a608-4c37.fixed6.kpn.net. [2a02:a466:79a7:beef:592b:860d:a608:4c37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd79b8b7sm25738566b.78.2026.10.23.17.46.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 17:46:39 -0700 (PDT)
From: Andre Brait <andrebrait@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	g.goller@proxmox.com,
	david.laight.linux@gmail.com,
	Andre Brait <andrebrait@gmail.com>
Subject: [PATCH iwl-net v3] e1000e: work around TSO erratum that corrupts data and hangs Tx
Date: Sat, 24 Oct 2026 02:46:30 +0200
Message-ID: <20261024004630.24579-1-andrebrait@gmail.com>
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
the next descriptor, and the NIC still segments the packet.

The split can take one descriptor more than before, which
e1000_xmit_frame() already reserves: it counts one descriptor more than
e1000_tx_map() uses, a leftover from e1000, which spends it on a 4-byte
TSO sentinel that e1000e does not use. Comment that count.

Tested on I219-LM (8086:15bb), v7.0.14, byte-verified traffic:

                                        unpatched        patched
  packets placed inside the window [1]  hang <12m        no hang
  guest traffic, TCP timestamps on      hang <27m        60 min ok
  guest traffic, TCP timestamps off     hang <7m         40 min ok
  guest traffic, VLAN tag from stack    hang <20m        40 min ok

  [1] 785-1013 packets at each of 10 offsets, 54- to 70-byte headers
  "hang <Xm": every run hung, the slowest within X minutes

Unpatched, data was corrupted at every hang. Patched, no corruption, no
Tx timeouts or drops, and hardware TSO stayed in use (26.5M segments).

Developed with an AI coding assistant (Claude); details below the cut.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Assisted-by: LLM
Signed-off-by: Andre Brait <andrebrait@gmail.com>
---

Notes:
    v3: incorporated the changes David Laight asked for in his review of v2:
    a comment on the spare descriptor in e1000_xmit_frame() and a matching
    paragraph in the commit message. The code itself does not change.
    
    v2: https://lore.kernel.org/netdev/20261020230211.75665-1-andrebrait@gmail.com/
    v1: https://lore.kernel.org/netdev/20261018203215.77371-1-andrebrait@gmail.com/
    
    The investigation, the test results and how the AI assistant was used
    are in the v2 notes and at
    https://github.com/andrebrait/e1000e-i219-tso-hang/tree/3764faf44ab6

 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

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
index 834a5b888..cb3b530d6 100644
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
@@ -5905,6 +5916,9 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 	/* reserve a descriptor for the offload context */
 	if ((mss) || (skb->ip_summed == CHECKSUM_PARTIAL))
 		count++;
+	/* spare descriptor: e1000_tx_map() splits the linear part of a long
+	 * TSO packet to keep its headers within tx_hdr_buf_max (TSO erratum)
+	 */
 	count++;
 
 	count += DIV_ROUND_UP(len, adapter->tx_fifo_limit);
-- 
2.56.0

