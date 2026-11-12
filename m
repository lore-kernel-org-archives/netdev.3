Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490257;
	b=4in/+MAfTdzjylnJN/bD0jwGDerjFlWpm8/G3d1vA9K5/VjAmnvpwwIXc9qo6Bt36TW7
	 w2b2oJwoTOUYXy8ngpnDWIj6GdrLKH5lmz2eD4HmVjZBHnNNCvqAirOOYhRakp7LSH+1E
	 Z0/eGeRHFUqQhDGYHL7PSz0fWToIYr4Z9TR771ya9WP0tMtT8VTH4AtIhSbsSrT8w3kZ6
	 rtB3mW/dv4+y/MfqwveSh4RgypeM81ci2gXOEnCjf8KzuKIZqvtevnPTSXhZVRMyTKiR6
	 3b292RynxbarupP69uM7nTF8fxnSv/VoyGteU3Nheb+x2QkG1RMyIVrKYhpg1fvUzbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490257;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=9NFlyzheJ/uPv9Jw0T8IRZlrdyCC10zz4URYM0laKEU=;
	b=H3lC7kheod2qoqgWe4dXSzVqWUPWt+yl6wucwzciK+T17b68sKZYk6P59zBeMSSaqdII
	 MvSV1wqzE8KGFRQmVdPuvS36as3df8CsYO0y0nDq7PLbqhJ27K+TciJr/HMGLSyuHu5zB
	 VrS/Y04aRRI24DgeNQ2ngr3t+4SUmrxIo6DBvehpMZHJM9WCTyyjrbiAuhZTXPiW+kbjo
	 H+kSylrcnptfwbh05h0xpxjqiN462K+bF3eU8hCdYuWNQP8ePrQeu38sOJYekViAY82JL
	 RO3JY1b7GYGdt2YGmexLoivPgZzFdS9u4K8n1ZYXyLNMLyT60SZpqohWgCSou60XFVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4JwvWeP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03FE606A331
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4JwvWeP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393BF1F00A05;
	Thu, 12 Nov 2026 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490256;
	bh=9NFlyzheJ/uPv9Jw0T8IRZlrdyCC10zz4URYM0laKEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S4JwvWeP9n7zgckzzvW67O/lxukTvzrhZNUJHAPIK7rWEN3JoYNf9z/INOO5iMGSb
	 piec8RF3twa1hL0+V0ARS8AnbXRlYrhm28TYk4iZc9FsxkjXG1NwW5QnuqxgNFBYdY
	 01Jc7iLMWICkK6ZgpEWVLFUhgsaT4KGrdg4VXRtd71WsjbWQPGYi/FfjAWopSxizM8
	 Z0xZzwwV/f2ZOe82kT/60hfeP6OjAPEzNAqWTo4GkH05QnST3g7ieIAdQxOkguGM/7
	 tg75c3DQaa7TVfk1gMSL3kdr7EchwtUAQ9XDjoFSQEe1Lv6HFNLY71GwLvcQ5IciZ1
	 NvdaOMLouI32A==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:28 +0100
Subject: [PATCH net-next v8 13/19] net: ethernet: cortina: Release partial
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-13-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
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
index f31fd0de0059..0588e573f8da 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2269,12 +2269,19 @@ static int gmac_open(struct net_device *netdev)
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

