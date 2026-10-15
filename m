Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA7541E66
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077888; cv=none; b=FnvJc8zxhxwnYqTcY1HQySABvBqDKsZ+GTpCkf44IltUVnO+69XGYFgPWiaCTPKjcr28vYWh0QzeJN3gmBurYKkQ3atKzeqi1cBvh5Fuw7XGVLvBdVx1ydZv11J1AslWIoKC1fbOqPbiRDXP8jbgnMLT8TPGK9P+PtuSXSDfpwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077888; c=relaxed/simple;
	bh=cuIY+wGisX6BZ9QgCz02U6RzwMIFi3T63zMYqTshz7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKqt9B/nIGZ/EvsWQEwXojolhzw+mKqvxVFBbXIVnNevX67HmOJpQnzxL0FMT4dtT0mKE01aKaRKaTS89F46ZVBzq1mg5Anet1ZXCjulXKwTN07TYrqSuJOehd/onsrfzqLke7AMBXq4s8lT0KXR+I2BCCUlKYCHMmZIZJeT9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feRcrwmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feRcrwmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D841F000CF;
	Thu, 15 Oct 2026 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077881;
	bh=3VN85fJK6tIdEwk4p22gj7DVYADxop45zd+maMejsHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=feRcrwmdPH9DDftVyZOsXc2FikxCwn2VwR8KiEsPEfi7wPcq1yZa8GFZcLMPJRT1u
	 s+Yzc81vs1btinod4MW0Hiz73w7+8m8ZbsiCp7rjlGPVVTBq5LNcUAuE+J7xfnk5Jc
	 IEQiOdPsrU0qNlYzpDQah8zk+YzxMovR7Ah4lKifA/YhugqisQWtEXNnbIA1fDPlEN
	 lM7aJ6Oc//l5d5WvcCtdQs/OTVDO/KgRUK//yD5lfpb/GFvr+kLVXbJT+xz2kHT7yc
	 U1N9o/BufMthQIo0pSXcP9Zm6CQKvn98Gqu8yJIfwqlSTJ+oXIaq5XvUsNqrYGj+vt
	 ed13s6JZNDNbA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:12 +0200
Subject: [PATCH net-next v5 12/14] net: ethernet: cortina: Release partial
 RX frames on stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-12-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

A NAPI poll can retain a partially assembled frame across invocations. The
stop path clears that pointer without releasing its fragment references,
leaking every page already attached to the frame.

Free a pending fragment skb after disabling NAPI and before clearing the
saved RX state. Count the discarded frame as dropped under the RX
statistics sequence counter. Use the irqsave update helpers because
ndo_stop runs in preemptible process context while 32-bit statistics
writers must not be preempted.

The issue was found by inspecting the partial frame lifetime and statistics
writer contexts. The series was tested on a D-Link DIR-685 with media
playback and ksmbd transfers under ping load.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index d4e90aa97d22..843423187f8d 100644
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

