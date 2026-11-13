Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602491;
	b=kAkIls7WnyHggDgYQKQuVFiKqqXnEg26nxAqQ9AlsZ6bicU0XQnU14F71Nb/Z/3K1mJm
	 j7T1Om+JFb7SksvAs+EvqEj0r0Ftg+l9hNFJVVML4FKU1oOqnGe/iT5tyi883IJdY3uol
	 bjQo2j32AuNzC8j9FOmKSTLORqqmSejTDoGvBxDkjXUoA9zneJ03gEmFdNAwQIncpSVbX
	 A7ANXPYI/kFYKXvZW3rK9DQmJbQpT8R372xoAzu/6Fuya+sX3oG4C+M/VnIkSkNlNRa2P
	 XNMsHYV6FxckrR++n1yqdaGrHwj61r3i6ZbZqf6QnEq9D/h91SzVv6Wa47yec7LJtyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=EPlYxbXhojzpwOG9NFJLCBj8FMBv/AriQ6SpX4VoLNs=;
	b=Dbc8q0gFka+EqJzCh5FiaqUgVVvwAZj4pAXTNQtIRVlTWgrMbMyTDT92Ni7v5lSevhUl
	 YvSThyzrrIE6hs0NoLPxpWn5E4HdMtRpv+XFXtszx1XzGj8Q2cMcnfm3HD7NBP89nsVjh
	 z4VWv/n3vRFzMBwRBjPXTYWA3a8qUf+wrq4ms93BvlFjQ9tOdqndsrmZfeyhxCFpQNYT1
	 ID02Mh3Oa3hzZIx8ZoBRm0UZSW/trYQ+JnHXWBjZXU3uKQuJkHOpyeBFSokztesqgZ/Xr
	 /6VOVJWa2HEwAdkEGpI+Fun5mJYtOsQHsabxKtEhWkXXIgq0SKCEXWuOqVqAIs/waQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=duq3ztDk;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0CA606A338
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A0CA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=duq3ztDk
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so823617a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794602489; x=1795207289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EPlYxbXhojzpwOG9NFJLCBj8FMBv/AriQ6SpX4VoLNs=;
        b=duq3ztDk5+5MZ5FHwtxOAEFnt4DAexMncVo9C8ytcEANKrd6DFH+Hz4hMUEFGowvID
         PazWqXQQu03dE16fYKgITCLUmb67ZAMUEqVcfB783cV2ffRq9H0Ak+VAHG/azcZ2Q4Zi
         Ib/h+h90znCjrqLvnfnUKWoy+suWdt/j/My4BoWvWPPLbhWXu5h1r2rHuigSoRs9uaLO
         pFDFaClYZtCaQgyFbLNXBMntQ6yWZqPKclaVBzVeP8baEqJOIVisBaTJjwmlvdwPr6QA
         4IevisNIrqpJL9PPQv/bLeAhIGCHO16kW4+Z5MI86o4mcng8pv7GJ9ZwDtXZQ7P9QRtJ
         /SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602489; x=1795207289;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EPlYxbXhojzpwOG9NFJLCBj8FMBv/AriQ6SpX4VoLNs=;
        b=unbMNdbBf2j0lzU7xOLbQLJ3K31sWYDtGfHamXWHk4P3wqdKFB8xZnElM2sr0e91xP
         /5JCQ8xEvOGTVdPg5vwCGifaHCGNKiGPnYvF93TbJHjLH1jH/gZw2EvdUdAnxNpd65pK
         cx+NxKx/TTVpkneWfI/1yLbb+5H0ju4dHE5rAY9zamiXiMkcfabgxHkDSkhphckniE9E
         ZByArTBovriFR15tnrY6dg8Q0pp0BwkE+b5j49XIOv4oTBaCd7nhQ7a3oYMjTkdL4qL+
         ZMQ+ER+s+totDT4dM2z4+d/44OnxokfizcUel4AqZf+O/D47jU+lLaqu80QHdYg7bzC8
         VUMg==
X-Gm-Message-State: APuU4Z+lbG9G3gyqletKt0XIISJqFYZt1auwXzNVyRVdxHdDvRHJUe/3
	pFoM6VIAKRFq8NolF4RoYnvCtjYCQ6esY/IJnfimO6CbPzFueI1LYcwS
X-Gm-Gg: AYBFou30mcQlk1QvmKR6uWrf3Y+ZMeXyQmCLYMJfspTDSmfv4D9Og4M+Bf+nf/TVNzn
	n2rNPk1Ubnkdq9Od5Ai+qFGskZ34IhdHnhCWgsC7TkLq6Ybd1a0ZCh0VsKg2jGKCyDy4i3ooy8a
	NAJCvGHQwGK6S63oUfQG8dYbCaJsAb9G7Dha00qlt2fJKbiBsd44DqKZb5Ol69rSVsnsSWhy/z6
	6+qkGt59+Gf6OkH2lCdzVqWJEbHinJ3NvEhxBfIYuB/Qb3hwfpZyIsAJy1dII0CgeM2Rrvdw4ws
	V+DGHMYrf2q581rAM195vO11nNrNU0FPYnoW7lTBDIUBfiOLLZM55hf/aFyCYhitAYpR459xkF0
	yFeRaDR7M3EsmgkcDtA+dxKRYQb2K6vIw3673LGs3jR9bMH2IY6+0DwKUu6bHl0K+34NrjeVgZJ
	QJT1uAZ8kBcU9JMZuwdj9VG4VKDUHFdHvcYOSYFeHVGfKGHyrauhAg+yXCIChECJkNzybg41ba6
	F1WtjJoD6nIdmykGETpqkugTHi3eHEKPfiuP9s41VfjBywcwGvKNmNdVWW35bJhE1drHBrIQQa1
	Tpux3cwHw9P3zI8jFIUn5XewjeNhsMrwEuy+3vsOmf5o1QnJUBRD63OUpSfRXBVipKQ6juYGN6h
	b8v7OR7OM+QcEqDHD3lkU9RxyMbbBtbZI0StZf/im2utHV8yvsJQPosbf7Rl37j9G2c0=
X-Received: by 2002:a17:90b:2b45:b0:3ac:b3c7:de04 with SMTP id 98e67ed59e1d1-3b1b0d06fc8mr2419600a91.34.1794602488546;
        Fri, 13 Nov 2026 12:41:28 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39fb9a3sm2724749a91.3.2026.11.13.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:41:28 -0800 (PST)
Subject: [net PATCH 1/6] fbnic: Wait for in-flight PTP timestamps before
 treating Tx as idle
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 13 Nov 2026 12:41:27 -0800
Message-ID: 
 <179460248693.8819.282933709034208845.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179460241885.8819.7179935130629202331.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_wait_all_queues_idle function treats the Tx path as idle once
the QM idle registers report every queue idle. Those registers do not
cover the TMI completion path, so they can report idle while a PTP
timestamp request is still outstanding in the MAC or queued in the TMI
completion FIFO.

The check can then pass without a flush, and the completion arrives
after the rings have been flushed, where the fbnic_clean_tsq function
either reports "Tx timestamp without matching packet" or, if the
interface has come back up and a new timestamped frame is already
waiting, matches the stale completion to that frame and hands an
SO_TIMESTAMPING user the wrong Tx timestamp. After a forced flush it can
also turn FBNIC_TMI_DROP_CTRL_CMPL_DIS back off before the queued
completions have drained, as the completion FIFO is only drained while
that bit is set.

Split the Tx wait out into the fbnic_wait_tx_idle function and have its
idle check require the TCE PTP in-flight count to read zero in addition
to the QM idle registers. The count tracks each timestamp request from
when its frame enters the TCE until its completion leaves the TMI
completion FIFO, so the Tx path is only treated as idle once none are
outstanding, and a forced flush keeps the completion disable set until
they have drained. The Rx wait still checks only the QM idle registers.
The count is printed with the other Tx idle registers on failure.

Waiting on the in-flight count means the Tx idle check can now keep
reading the full set of QM idle registers for the whole timeout, and the
poll timeout only counts the delay between polls, not the time spent in
the register reads. Raise the delay between polls of the Tx and Rx waits
from 2us to 20us so the PCIe read latency stays a small part of each
interval and the 500ms timeout stays close to wall time.

Define the register inside the TCE CSR section and move
FBNIC_CSR_END_TCE to the last register of the TCE block (0x040B4,
TCE_SPARE2 in the CSR map), so that the ethtool register dump covers it.
The section previously ended at 0x04050, short of the TXB, PTP and TCAM
status registers. Per the CSR map, every register in the added range is
read-only or read/write, so reading them for the dump has no side
effects.

A device that has dropped off the bus, or whose CSR access the driver
has disabled after a failed read, reads all ones. The QM idle bits treat
that as idle, and so does the in-flight check: the count is bounded by
the timestamp requests the Tx path can hold and can never reach all
ones, so teardown of a lost device, or during DPC recovery, does not
wait out the idle timeouts.

The issue was found by code review and confirmed against the RTL.

Fixes: ad3d9f8bc66c ("eth: fbnic: add TX packets timestamping support")
Fixes: 7d4568edce74 ("fbnic: Disable PTP completions during the Tx force-flush")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |    3 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c |   73 +++++++++++++++++++++-----
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index c371ac9f78c1..dc234f4d24f6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -422,7 +422,8 @@ enum {
 #define FBNIC_TCE_TXB_NTWRK_DWRR_CTRL_EXT \
 					0x0404E		/* 0x10138 */
 #define FBNIC_TCE_TXB_BMC_DWRR_CTRL_EXT	0x0404F		/* 0x1013c */
-#define FBNIC_CSR_END_TCE		0x04050	/* CSR section delimiter */
+#define FBNIC_TCE_PTP_INFLIGHT		0x040A7		/* 0x1029c */
+#define FBNIC_CSR_END_TCE		0x040B4	/* CSR section delimiter */
 
 /* TCE RAM registers */
 #define FBNIC_CSR_START_TCE_RAM		0x04200	/* CSR section delimiter */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 07d4b2e92362..c75c5683b724 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2398,38 +2398,85 @@ static void fbnic_idle_dump(struct fbnic_dev *fbd,
 				   fbnic_rd32(fbd, regs[i].reg_base + j));
 }
 
-int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
+/* The poll timeout only accounts for the delay between polls, not for
+ * the time spent in the poll itself, and each poll is a series of
+ * non-posted PCIe register reads that take on the order of a
+ * microsecond each. Space the polls out so that the reads stay a small
+ * part of each interval and the timeout stays close to wall time.
+ */
+#define FBNIC_IDLE_POLL_US	20
+#define FBNIC_IDLE_TIMEOUT_US	500000
+
+static bool fbnic_tx_idle(struct fbnic_dev *fbd,
+			  const struct fbnic_idle_regs *regs,
+			  unsigned int nregs)
+{
+	u32 inflight;
+
+	if (!fbnic_all_idle(fbd, regs, nregs))
+		return false;
+
+	/* The QM idle bits do not cover the TMI completion path, so a
+	 * timestamp request can still be waiting on its completion. The
+	 * count is bounded by the timestamp requests the Tx path can hold,
+	 * so all ones is a failed read, as for the idle bits, not a count.
+	 */
+	inflight = fbnic_rd32(fbd, FBNIC_TCE_PTP_INFLIGHT);
+
+	return !inflight || !~inflight;
+}
+
+static int fbnic_wait_tx_idle(struct fbnic_dev *fbd)
 {
 	static const struct fbnic_idle_regs tx[] = {
 		{ FBNIC_QM_TWQ_IDLE(0),	FBNIC_QM_TWQ_IDLE_CNT, },
 		{ FBNIC_QM_TQS_IDLE(0),	FBNIC_QM_TQS_IDLE_CNT, },
 		{ FBNIC_QM_TDE_IDLE(0),	FBNIC_QM_TDE_IDLE_CNT, },
 		{ FBNIC_QM_TCQ_IDLE(0),	FBNIC_QM_TCQ_IDLE_CNT, },
-	}, rx[] = {
-		{ FBNIC_QM_HPQ_IDLE(0),	FBNIC_QM_HPQ_IDLE_CNT, },
-		{ FBNIC_QM_PPQ_IDLE(0),	FBNIC_QM_PPQ_IDLE_CNT, },
-		{ FBNIC_QM_RCQ_IDLE(0),	FBNIC_QM_RCQ_IDLE_CNT, },
 	};
 	bool idle;
 	int err;
 
-	err = read_poll_timeout_atomic(fbnic_all_idle, idle, idle, 2, 500000,
-				       false, fbd, tx, ARRAY_SIZE(tx));
+	err = read_poll_timeout_atomic(fbnic_tx_idle, idle, idle,
+				       FBNIC_IDLE_POLL_US,
+				       FBNIC_IDLE_TIMEOUT_US, false,
+				       fbd, tx, ARRAY_SIZE(tx));
 	if (err == -ETIMEDOUT) {
 		fbnic_tx_flush(fbd);
-		err = read_poll_timeout_atomic(fbnic_all_idle, idle, idle,
-					       2, 500000, false,
+		err = read_poll_timeout_atomic(fbnic_tx_idle, idle, idle,
+					       FBNIC_IDLE_POLL_US,
+					       FBNIC_IDLE_TIMEOUT_US, false,
 					       fbd, tx, ARRAY_SIZE(tx));
 		fbnic_tx_flush_off(fbd);
 	}
 	if (err) {
 		fbnic_idle_dump(fbd, tx, ARRAY_SIZE(tx), "Tx", err);
-		if (may_fail)
-			return err;
+		netdev_err(fbd->netdev, "0x%04x: %08x\n",
+			   FBNIC_TCE_PTP_INFLIGHT,
+			   fbnic_rd32(fbd, FBNIC_TCE_PTP_INFLIGHT));
 	}
 
-	err = read_poll_timeout_atomic(fbnic_all_idle, idle, idle, 2, 500000,
-				       false, fbd, rx, ARRAY_SIZE(rx));
+	return err;
+}
+
+int fbnic_wait_all_queues_idle(struct fbnic_dev *fbd, bool may_fail)
+{
+	static const struct fbnic_idle_regs rx[] = {
+		{ FBNIC_QM_HPQ_IDLE(0),	FBNIC_QM_HPQ_IDLE_CNT, },
+		{ FBNIC_QM_PPQ_IDLE(0),	FBNIC_QM_PPQ_IDLE_CNT, },
+		{ FBNIC_QM_RCQ_IDLE(0),	FBNIC_QM_RCQ_IDLE_CNT, },
+	};
+	bool idle;
+	int err;
+
+	err = fbnic_wait_tx_idle(fbd);
+	if (err && may_fail)
+		return err;
+
+	err = read_poll_timeout_atomic(fbnic_all_idle, idle, idle,
+				       FBNIC_IDLE_POLL_US,
+				       FBNIC_IDLE_TIMEOUT_US, false,
+				       fbd, rx, ARRAY_SIZE(rx));
 	if (err)
 		fbnic_idle_dump(fbd, rx, ARRAY_SIZE(rx), "Rx", err);
 	return err;


