Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4A36C5BF
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742017; cv=none; b=u4gVcNxnOpfyr771vlhsZuekMbLlL0X1TsdXt1ofVYutDQBpKizE7JO/pcV5SgEO3usqKhrBU4+cabIS+XC5kjIkyyE2VG/nL1eYZQxJNGEsWSp7x+GBV0GsUfnk5YhqnlG67cyoZXt+F3rBrHutMlQEXTT4lSJ9LQMA2CKLrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742017; c=relaxed/simple;
	bh=ctlA+4TCWViyiOWk2aEjuYSewQr6MmeMkdosaT/PDCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ln605zVKvYhURTMhAFRDCJb4sUcs4Yss3aAqYyuqE9hm21qvj8OfmqjJHXMVBhB+kFW7oYR4GYF1rZnkbEac783s1zxri/zQa+P5+yQn0TeWMTEkejpl60lKsUxYtY7N7f+fp/DAbU9rDhgrQMPFrPv8101lo4qq3lhVa4gUo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zux5G2ta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zux5G2ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B181F0089C;
	Sun, 11 Oct 2026 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742016;
	bh=8f8fvLyJnp5ILB6tffGBNRRMtCO0b+RLby/FaDst74M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zux5G2tahGhR2RuOsyqhtvVh6LA7p8a6DVmKjvulu7fjSi+jSprex1fQJIWA8kkA4
	 divj32vorBJpy7Tmp2GoAAaq4OU34qYOB19pfl32yiiCDIFWGGdOyQuusCIxWhIxP2
	 6kl+pUMg8E/WMAQH0ueZvYnoPaIoPUR9OohL/91josMFyYiXY7ul2P8MQTF+sUsJ5g
	 ycXtcl89UnZzG25Y/GeAMqfrdaRqpgPlRGRPIMi8pG76TVhfxkKwUdsLLzEirr55Zy
	 x4H6GDhwFEDliZxxPBxzwJBcYvHHY28OWoc5RuZEp9N1pOMxUpkUYUg3kD8okWW1B4
	 Q+A16t/IfoPkA==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:26 +0200
Subject: [PATCH net-next v4 13/15] net: ethernet: cortina: Release partial
 RX frames on stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-13-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
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
index 43fd8fd773e3..32291d4c3390 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2209,12 +2209,19 @@ static int gmac_open(struct net_device *netdev)
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

