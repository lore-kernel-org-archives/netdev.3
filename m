Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190128C009;
	Mon, 21 Sep 2026 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994688; cv=none; b=st2yD20RizZQpnN0rOy+kPjaMzOnZ/mpXzsF3Rdf5Czk53f24VxB92qh+fglxWTfqRQzRXRuIT8S3PwoHWSu+HnNMx9tLzljtdJIsada9/vuVlwHshDKFK13feMrOIJHHdUx3e8KSZd45tQ8YF1jXh4038TaHGMUBeXKhRmd408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994688; c=relaxed/simple;
	bh=w1GlDaYjGOLyqTw2T7atvpFGJJuRBmdthAUnufDAhok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9ep/CuhVcCPOVUN4I8ltx5C4rOLoclkv7qnAbBDPHKTasF37wLApVTKWVnePZIHOIoqFOeIt2+Cw4xjD/Jbj3zr9DsbbCbQw8HWheIY0HQSWwpUQ6SsOt7lz4h+sIwVS/O/nQGyMNVsX0YMDmY3N1z/p7FaHVnzNp9sKq0ZGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=yGKHp0In; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="yGKHp0In"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 184B1A4A18;
	Mon, 21 Sep 2026 14:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789994680; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=CbRBRCnqdsWMFVb2TRFmDEKx0JYd2/g65NfgRA9kBmQ=;
	b=yGKHp0InIi3Cu0Id+HN3gRHss+CSwJA/4ctTu97cW5Nfmc2GVFupNyw12LjmfpabhiHUKN
	DyRoZwhX7/EzDMP3JK29sV26+nsIA1vhyXqG7gAqXry8bQwQOcOiHhcQNZ6eHExCc5jPrR
	+21zHDD6SPMENwcZV9YRY7lZZw9ckJbN19Oo72zqL03wfJcxOmDAN13zcsJsf0PiOCgzSw
	moGT+L76Mqp3js8H9jZ2PJ5ifW4vPh2Fzd3BxLEgczpNlN+iA0oer8uWG9NfXal44c+Ze5
	YgaATx0e242iYHP9MUZr+ERgquAVfWRJ2nzI5DmSzPONZiRk2C75yFzch92ZUw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bcmgenet: stop Tx NAPI before disabling the queues
Date: Mon, 21 Sep 2026 14:44:34 +0200
Message-ID: <20260921124435.974581-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

bcmgenet_netif_stop() disables the Tx queues first and stops Tx NAPI
several steps later. A completion in flight calls netif_tx_wake_queue() in
between, so a transmit can reach the rings after bcmgenet_fini_dma() has
freed them.

Close is safe because dev_deactivate_many() stops the qdisc first.
bcmgenet_suspend() does not, so stop Tx NAPI before the queues.

KASAN on a Raspberry Pi CM4, driven from an MTU change because suspend
freezes user space before the callback runs:

  BUG: KASAN: use-after-free in bcmgenet_xmit+0x17f8/0x2258
  Write of size 8 at addr ffffff8055844a68 by task ksoftirqd/0/14
   bcmgenet_xmit+0x17f8/0x2258
   dev_hard_start_xmit+0x13c/0x588
   sch_direct_xmit+0x108/0x340
   __dev_queue_xmit+0x1190/0x3848

Fixes: 254f3239dd07 ("net: bcmgenet: revise suspend/resume")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Found this, while I was preparing my jumbo frame series for genet.
The MTU change in my test comes from that series and is not in tree
yet.

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b916080f4ff1..0789b60e664a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3441,6 +3441,8 @@ static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
+	/* Stop completion polling before it can wake a stopped queue */
+	bcmgenet_disable_tx_napi(priv);
 	netif_tx_disable(dev);
 
 	/* Disable MAC receive */
@@ -3455,7 +3457,6 @@ static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
 	/* Disable MAC transmit. TX DMA disabled must be done before this */
 	umac_enable_set(priv, CMD_TX_EN, false);
 
-	bcmgenet_disable_tx_napi(priv);
 	bcmgenet_disable_rx_napi(priv);
 	bcmgenet_intr_disable(priv);
 
-- 
2.53.0

