Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59C2E1F06
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527146; cv=none; b=Zli2v1lmd7Zc1nGMKgqklaoxZMEvxs363tkI5XjQrB4poUVXRqcEmgHYIdWFxV/5yXhuOb5mmfmsq16MBpBvMNdUH8W2B70HKvuS4kjpQd4P1Ea1LKzCJqLcnpIU7LWyJ8ntwMDyOpzH5fV5Ue9gn1FR+7lRUevzysZJlIbzQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527146; c=relaxed/simple;
	bh=NCwKcmZcjwpyxfuCBu3gRJQo8N9He6UW9Gym6yLkACk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnp4ynpoVxHTJmqnEMSOXVTwZS+BftSR0JmY1aHu64iT198tWZ3NLGjBwXX60vDZRo2f+cGuolvFlSeiJClBMNIiWKvda43YnKYxvYqNMrYkZCTxmQa4GVxJ1j/Y5LpOz5iX4T9I/IbxwOXI4sKx8BMDLnY7glg/xk+HcxPtZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=c127.dev; dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b=VkCWi2jj; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=CebkOwiY; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b="VkCWi2jj";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="CebkOwiY"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=VkCWi2jjyEYL/h8rDWd1bR0QkKmYifYNep/rXJw5JJWPilwb/FpDTOBlwRFyet5RE+SdJyhLNn9EsxK0FG2l5pT87IFhK0vI/6VyKs82hjdMU+QMzYnzfz3nyCz+RocVrwS0PmLAB7dl5CsLrV83gMSqOHvDYBEC5QvBQrPgzqoqBOta9442AgjLy8Xkzi9I6qs7tL2ZA5Lf1eT62aKKmx/S2iMsy8lRFjUEDOPc3be8Hy+/KPkp0DTPMTHdJWuBhJE5mm9Z6DLfXrd0F/vTeQYuZN7+wqiXeDEBkwK+Y5OWxLDovi5lVNRFF+noJqzCrLZRE56yQ08RGIfgzF9R1Q==; s=purelymail1; d=c127.dev; v=1; bh=NCwKcmZcjwpyxfuCBu3gRJQo8N9He6UW9Gym6yLkACk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=CebkOwiYxvxLYJB+Yak+5HZxAqksb3saekcQ0A1hsSx8+gQJDnqp6yAwSOYXlSDWmn5hVDujqP0o/rVam4RkKwdig+bkhrTO/LUdP05BKpD2qvlcRxXb1OIuUaF2GLGtAGXIrZR++0NYippD4JC7vKCYX1bxLYYKyIcuacQUk9OhRL2SCSoNN5JTnf8sf0acpy+v2Nc5FlsolTxJhFA6HSfA/3oLmVy5VGVMyMr7vAwCFPDDi0kvXTYF/7AaZnl5ZqAW+RhHLWkw/NkHYpHTGCEBlphmt2SgV4Iob7sXTTNUvHfPbGuyPESAUy8qQfoyeXhZFoffTx8ztvQSu6C3Mg==; s=purelymail1; d=purelymail.com; v=1; bh=NCwKcmZcjwpyxfuCBu3gRJQo8N9He6UW9Gym6yLkACk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 897215426;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 31 Jul 2026 19:45:41 +0000 (UTC)
From: Johan Alvarado <contact@c127.dev>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	Jose.Abreu@synopsys.com,
	rmk+kernel@armlinux.org.uk,
	pavel@ucw.cz,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Alvarado <contact@c127.dev>
Subject: [PATCH net RESEND] net: stmmac: raise TX completion interrupt at the end of an xmit burst
Date: Fri, 31 Jul 2026 14:45:22 -0500
Message-ID: <20260731194522.55069-1-contact@c127.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The TX mitigation logic only sets the Interrupt on Completion bit once
every tx_coal_frames descriptors (STMMAC_TX_FRAMES = 25), with the
tx_coal_timer hrtimer (STMMAC_COAL_TX_TIMER = 5000 us) as the only
fallback. TX skbs are freed exclusively from the TX completion path,
so any flow that keeps fewer than 25 frames in flight has all of its
skbs held for up to 5 ms after transmission.

Paced flows never queue enough frames to reach the frame threshold:
TCP Small Queues caps the amount of unfreed data at roughly two pacing
intervals worth, which at moderate pacing rates is only a couple of
packets. Every small burst then stalls until the coalesce timer fires,
and throughput collapses to approximately tsq_limit / tx_coal_timer
regardless of link capacity.

This is easily reproducible with BBR, which paces its output and thus
keeps only a few frames in flight at a time. On a YT6801
(dwmac-motorcomm) equipped Orange Pi 5 Pro, a BBR upload over a ~23 ms
RTT path is capped at 5.24 Mbit/s, while CUBIC reaches 207 Mbit/s on
the same path. BBR measures the stalled send rate as the path
bandwidth and locks its estimate near the floor, so the connection
never recovers. Lowering the coalesce settings with ethtool -C
(tx-usecs 100 tx-frames 1) lifts the same transfer to 447 Mbit/s,
confirming the mechanism.

Fix this by setting the IC bit on the last descriptor of every xmit
burst, i.e. whenever netdev_xmit_more() reports that no further frames
are pending in the current dequeue batch. Frame-based coalescing still
applies within a burst, bulk traffic keeps batching through qdisc bulk
dequeue and NAPI polling, and the coalesce timer becomes a pure
fallback instead of the primary completion mechanism for lightly
queued flows.

tx-frames 0 keeps its meaning of timer-based mitigation only.

Fixes: da2024510031 ("net: stmmac: Tune-up default coalesce settings")
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
No code changes since the original posting on 2026-07-06; reposting at
Jakub's request after the netdev patch queue overflowed:
https://lore.kernel.org/netdev/20260720173557.09e322d7@kernel.org/

Previous posting, including the discussion with Maciej Fijalkowski on
whether frame-based coalescing could be dropped entirely (kept as is;
any rework is net-next material):
https://lore.kernel.org/netdev/0100019f35ea26e0-42ad009c-01ab-4a8f-b126-fa65fbacae5c-000000@email.amazonses.com/

Notes for reviewers (not for the changelog):

Tested on an Orange Pi 5 Pro (RK3588, Motorcomm YT6801 PCIe GbE via
dwmac-motorcomm), iperf3 upload to a public server over a ~23 ms RTT
path, coalesce settings left at their shipped values (tx-usecs 5000,
tx-frames 25):

  before, BBR:    5.24 Mbit/s (cwnd pinned, bw estimate ~6 Mbit/s)
  before, CUBIC:  207 Mbit/s
  after,  BBR:    447 Mbit/s

Interrupt overhead stays sane: ~3.3k NIC IRQs/s total at 447 Mbit/s
(~38 kpps), i.e. roughly 12 packets per interrupt, since qdisc bulk
dequeue plus NAPI polling still coalesce within bursts.

The 5000 us STMMAC_COAL_TX_TIMER value postdates the tagged commit
(it was 1000 us back then); the stall mechanism is the same, only the
throughput ceiling differs, hence the Fixes tag on the frame-count
change.

The XSK/XDP TX paths keep their frame-count-only IC logic: there is
no skb/TSQ backpressure on those paths, and netdev_xmit_more() is not
meaningful outside ndo_start_xmit.

The same completion starvation was reported by Pavel Machek in 2016
(UDP burst pauses, back then a 40 ms low-res timer):
https://lore.kernel.org/netdev/20161123105125.GA26394@amd/
His patch disabling TX coalescing entirely was rejected in favour of
"a real solution":
https://lore.kernel.org/netdev/20161205122711.GA30774@amd/
The subsequent hrtimer conversion fixed the timer resolution but kept
the timer as the only completion mechanism for lightly queued flows;
this patch adds the missing burst-end interrupt.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3801f9d45278..89f207eaf560 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4613,6 +4613,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		set_ic = true;
 	else if (!priv->tx_coal_frames[queue])
 		set_ic = false;
+	else if (!netdev_xmit_more())
+		set_ic = true;
 	else if (tx_packets > priv->tx_coal_frames[queue])
 		set_ic = true;
 	else if ((tx_q->tx_count_frames %
@@ -4897,6 +4899,8 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		set_ic = true;
 	else if (!priv->tx_coal_frames[queue])
 		set_ic = false;
+	else if (!netdev_xmit_more())
+		set_ic = true;
 	else if (tx_packets > priv->tx_coal_frames[queue])
 		set_ic = true;
 	else if ((tx_q->tx_count_frames %
-- 
2.55.0

