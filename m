Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348838;
	b=MHOZehTHdc+mW6siAEEn9KIG24UjzdATXm5/eiuWWMU/JiKeUAiMycSEVxaq+qSyrKjY
	 nB7TqAEQzO3PxTFrhWm8Fo4iVDeUoI2dI0w7iVeosJYCDVV+JidMoJQ0RP8aLwzyrmC9F
	 +CzoV/cajl6oYOPH1q73EHvUSoCm1RcezirnYP2Oe1EZ+xQfo0slfuMrCZZY3KFodAaPv
	 AD+DUZWFTA7adNawj2WubtBXa41D1rITfLI9hxGtnYhXcU3GzWM2TL0cWdXBuqDKoJpQ1
	 JecfOG1aAgeXEIjhZP1Rn6ic1b1v1sF2oKSaonlYiQ05Wyzhoi+W/ByOczyMM5e+TBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348838;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=cOkTPVWBCHuP1zGUI8ZXA5imLKoMmBYYAcQcmlTHROM=;
	b=N74ijaHvutWWB/Gud/otdu+bviXySCl95en2YHiWV/1j2MU1CYQgadOxKzTPHfxeGRjq
	 Y4jeyQ7WnrL0O3ZiGECUcJInMmaoQZlVFju0NbZwDuuWyOOZDzPwcMLoZ4PGdZh8Xnjmq
	 X5vkhz2Sp/Ds9QPdP50mHurXObTRBfr1uUXJIQbYOlSe7Fe+2PuNvmTSbGSbEOtDKekn7
	 X/D3ute+flkqD0ypeBGAKAKlQ0YB2KLKOVmw5IEGGgXnCx7RzJqAqdinVlGSimIJqvBTp
	 JEcO5TJc61AiJiZD+Yi1k81uvy8ht4SbiLvcWgnsxFCl6/BlKeQtgCyG8PdsFStmbyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzgmRBSo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37F606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzgmRBSo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1F51F008A3;
	Tue, 10 Nov 2026 22:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348837;
	bh=cOkTPVWBCHuP1zGUI8ZXA5imLKoMmBYYAcQcmlTHROM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QzgmRBSoXIZnLGiW1bnOv7ALAgkmc4w6PN5xvw6OTnB94QX8SYYOvaSvrRUa/KZhe
	 zWvAsA4dw5aImSIZ+DYej7YAfeKJpYBC3MIV8aQ5AMRLkmqzOQaunaZCZDPKk885lv
	 8RhiI707TLiR3XlJrlePIG3mANQTCtNfzzKK02iw3ZiYJOzeE0JVTsD8/u4NDGpU0a
	 y8HrUM9nv4+uwEXGsEYhxk2cZU+dhUF7TxHQWPJC/t1j3RghyUmvCiN6DhIlLdDbJ4
	 UYBp0oq+pQyPv1alWaQ6hpdcCeLQ4vdAlGsR0jj6V60ZgRuwtVJZ55cZBs8TwWBz88
	 13qc0y9DSb0qw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:27 +0100
Subject: [PATCH net-next v7 12/18] net: ethernet: cortina: Release partial
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-12-9c32a1a46aec@kernel.org>
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
index 73ba008a9c7f..d08dbb0aabcf 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2228,12 +2228,19 @@ static int gmac_open(struct net_device *netdev)
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

