Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348843;
	b=dn1rE862XCM7NW57vibdCEdoaYF1WsIZwWbIHILKvx4/SX/MznCSB2vHFT02d8rGnpaV
	 j9a2A7eh5DQSJRuITq8A/RWReVrXm0ZJF7ip/NKY7+Gg+cHncDLUnWLr0+ozHQUyXUF/w
	 6ZVgV/luA9DDVYTxCHCJtHKCvYJM5RbrAX8+t63zee8WCSvyQLT36joGhwGm9v2bqVvqD
	 QtZUbhYo03VnrdVAv4BYK9QaeRcLs4+Ci4fOFEhCrZWFFhOO5D7m6UX1BWLNr3xwDEQce
	 cJZQlZJLVT/0SU8+Q8TKNx+329h48cmUDMVwj1exM6EsYS39RXBDhnRfaUWmOfXZr5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348843;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=2qX/I/XV7ORRNM8Ywkm8Sacexc84WHEJt2rZrvJvcJE=;
	b=ECaxUS80zlA2XipWu7Go/j1nSbI0NNWY4Nv7nUgrjmzFn4Fm0/MrkFZ2b1o6mHUj6qoc
	 Wu5cOEPfnjpLfUEddsMAjEwVxSs2Vt+Rhj+jQPBFlOmTaS2k47zLDT+TVx3vCiGFVweVX
	 qFcGTfSpo0Mt0mwHOVyWAA4v/7mq7ZobJahCLEG7zFiSv+PZw6aWu0QiwabaYyzwbvtI/
	 gRwVBJn+g3Rw8/aqHcc4t+DLKHNP6uanS3rGM44ag6vJBasKr855mNGEi0BVE48h7aRcW
	 /DaRUz41Vhksi3QwWRAY02tbFg1lfg//YiMqJp1V8F0Js9/9Q0vWjwnmvrl7QjRNWVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbqxmXLU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39053606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbqxmXLU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71031F008A3;
	Tue, 10 Nov 2026 22:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348843;
	bh=2qX/I/XV7ORRNM8Ywkm8Sacexc84WHEJt2rZrvJvcJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VbqxmXLUiKd/atbP9SudEYdSPSgRwGErPyJpjGefqqZM43lPVi+9TBI+q2U9wjThw
	 fZoLuS6nQ7AEaqXjBBh75MywbskLyLGUD8gjj9oI54hv0UHfWjCItyfEylNpWUYleN
	 NbJS+vZbCw/2HIJHalHMTFrIazehnV/KxjFM95I7JXvWy5SPX2MNIpJKAN65x7LE51
	 dcSzc7P/Zk5kFK/wpfXCupfuMVPKgdhVWOa+J6krNvzESREJT8DnKJmUvJnhGIbbyO
	 HA5FLaALTyPNrYQuBj1e1F9DVJnXWbKeX//XVI/ttHGOx3tJihJ8IgJqohA64M2wkR
	 BI7JsYUKm9DTA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:29 +0100
Subject: [PATCH net-next v7 14/18] net: ethernet: cortina: Serialize TX
 completion statistics
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-14-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

gmac_clean_txq() updates ir_stats_syncp with hard interrupts enabled,
while the MIB and RX overrun interrupt paths update the same seqcount.
Initializing its lockdep key exposes the incompatible IRQ contexts on
32-bit debug kernels. The writer sections also lack mutual exclusion.

Take the existing IRQ-safe irq_lock around the TX completion statistics
update, matching the other ir_stats_syncp writers. Acquire it before
opening the seqcount writer section so PREEMPT_RT does not acquire a
potentially sleeping spinlock with preemption disabled.

Found during Sashiko review and confirmed by tracing all three writer
paths. Cross-built gemini.o for ARM with W=1. No hardware lockdep or
PREEMPT_RT runtime testing was performed for this change.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index a96b6292820a..04a125d6d413 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -637,6 +637,7 @@ static void gmac_clean_txq(struct net_device *netdev, struct gmac_txq *txq,
 	union gmac_txdesc_1 word1;
 	unsigned int hwchksum = 0;
 	unsigned long bytes = 0;
+	unsigned long flags;
 	struct gmac_txdesc *txd;
 	unsigned short nfrags;
 	unsigned int errs = 0;
@@ -688,12 +689,14 @@ static void gmac_clean_txq(struct net_device *netdev, struct gmac_txq *txq,
 		}
 	}
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
 	u64_stats_update_begin(&port->ir_stats_syncp);
 	port->stats.tx_errors += errs;
 	port->stats.tx_packets += pkts;
 	port->stats.tx_bytes += bytes;
 	port->tx_hw_csummed += hwchksum;
 	u64_stats_update_end(&port->ir_stats_syncp);
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
 
 	txq->cptr = c;
 }

-- 
2.56.0

