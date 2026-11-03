Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728311;
	b=XCqGumflmZvafZsGuBtXl1xIADkT3wqhFcArFypQ7wEHtC2lOjIZw/FaavYqh9/7q7gx
	 yeqOmMbGB6fiXiWfHoLj+OVfy+jISY4ZAlZ2Cv7zfswcOjEFMpCoGkMb1/Z75OLIGlFdb
	 XxS0K3A2qsNUlo2sEkJwETmcYf3P/GN5Grddm90jk3YI9KNyYjLYdILs2CN6WD/qTNeYd
	 LxDnT8pR16ul2qa/9sgQ1yDJRWoWhJsIR/kywVZL4FhIdtDyxVBnXe6Z5DD26kMM86kZW
	 iTeqyZPYK9pGiupdaGpVEpzfMvB8D/ntv69WH6vtP6cWvWssL6GcaYxHZ7nEV/fkWJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728311;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=oZvDTfyLxxVKnqo2uetIGOPCEKYj6D7bCCASuTPFJgM=;
	b=phRwVZpq/vt/3crSZWq+oJrzwm1tMx8BDhaG0/FNOsKBm/u71TAJUru+/rwlx2psY/YP
	 ZaTeXahV3n3kI+1j25jNpLKLjn8pxLxFATUTCChJou2tYQziMj8PuteeD6Rz8N67LntHL
	 pajUlE9RxEtrKb2mJ4fAI5RC1hN50lcepMnCLdVYm6Jctfu8XJVMwXlRIUaCLi3ilN1JR
	 p1ZApq9FYq7rkkwB++ug2lrANeQpdT01+PEvh3SMgn9Bh2/gZgCOx6dwy6ig4yifj74BD
	 +Y3Jw1hqtrH8B4t278LyDMoTf06EHR5/e4m8fl3WaAsAfvREfKO5vOLYK6RMx04IZiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nM/ZZZ2o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB955606D80D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nM/ZZZ2o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0071F0093A;
	Tue,  3 Nov 2026 17:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728310;
	bh=oZvDTfyLxxVKnqo2uetIGOPCEKYj6D7bCCASuTPFJgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nM/ZZZ2owabif9IUBbusmNY9Okb0n2KW7j+SlpameHwzy1mLn5okvWBhUYmV2di/l
	 SgterxhONqMi1tLgCW5MqkoriQf+80ozhWS9y7dLxQh1OgdxvIXaAQZUopaW4Tb0QL
	 ihV6pQ0ReRxZmKDaAfG1QYeEzacmYC/g/Gr2Vwf4/mAyLXOUm9msrQ54FW2ob1chbK
	 9Tg+m/dXVBaLnZS891NwoCQDGWLf+QR1gR2wNVR9yMuGr4xxfo26UrAhLZ6Lvs3Qb9
	 MbHf2WLIP4RqhYaiu2tKkq9GWOu07CpegMtAS8Wt0RSiS4auSsdBRM+mtEbhkc1bg3
	 ZbA1cG91PUbqQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:23 +0100
Subject: [PATCH net-next v6 12/15] net: ethernet: cortina: Release partial
 RX frames on stop
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
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-12-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

A NAPI poll can retain a partially assembled frame across invocations. The
stop path clears port->rx_skb without freeing the skb retained in
napi->skb. If the interface is reopened, napi_get_frags() returns that
stale skb. The next frame overwrites its fragment array from index zero
while len and data_len still include the partial frame.

This can lose page references belonging to the old fragments or pass an
skb with inconsistent fragment accounting to GRO. If the interface is
removed without reopening, NAPI teardown eventually frees the stale skb.

Free a pending fragment skb after disabling NAPI and before clearing the
saved RX state. Count the discarded frame as dropped under the RX
statistics sequence counter. Use the irqsave update helpers because
ndo_stop runs in preemptible process context while 32-bit statistics
writers must not be preempted.

The issue was found by inspecting the partial frame lifetime and statistics
writer contexts. The series was tested on a D-Link DIR-685 with media
playback and ksmbd transfers under ping load.

Fixes: 06937db21ee3 ("net: ethernet: cortina: Make RX SKB per-port")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 7569c9935b85..be2b9702718f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2224,12 +2224,19 @@ static int gmac_open(struct net_device *netdev)
 static int gmac_stop(struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
+	unsigned long flags;
 
 	hrtimer_cancel(&port->rx_coalesce_timer);
 	netif_tx_stop_all_queues(netdev);
 	gmac_disable_tx_rx(netdev);
 	gmac_stop_dma(port);
 	napi_disable(&port->napi);
+	if (port->rx_skb) {
+		napi_free_frags(&port->napi);
+		flags = u64_stats_update_begin_irqsave(&port->rx_stats_syncp);
+		port->stats.rx_dropped++;
+		u64_stats_update_end_irqrestore(&port->rx_stats_syncp, flags);
+	}
 	port->rx_skb = NULL;
 	port->rx_frag_nr = 0;
 	port->rx_dropping = false;

-- 
2.56.0

