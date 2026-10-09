Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30243E9CB;
	Fri,  9 Oct 2026 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540668; cv=none; b=bRMSZnEhMSgfdJyxJbGMiFe6hZRnCufMzipLBO7tP3LSLlvvU2E2a+UhmKDxjQ2SvkAOP4rxE493/QLSz//RxCi2UPzqo8cWHoh7iw2shbWSuUO9pdcdOTO/yP6cjDEUBG3mGsd/WGBjP8XP/bM5LXnCJRcBbFpyf5tamWLB704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540668; c=relaxed/simple;
	bh=fha1a3arIoJLlTVM53k7P7B7fPGKH9vmXcXb315lgc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HoGFU9N9e78U8BFXz6v0q9cq7/UbAwlgzEP/1LNrlbotGGusohWJLLlD/1fl2IvFc40YvyLBn1w4xDw2PPqwfF2g1NaRanfLKgkjohSfWgzfp+6YVIg27b01C5A3nrC8ya4yhcYyKpoG1nMYxvNOyzPRXQnNEXqRa8MRPhVHDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=b9tCNn+5; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="b9tCNn+5"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FCE3A1546;
	Fri,  9 Oct 2026 12:10:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791540660; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=O/E93M9qF++wqqPi27386nQo3pvtjSqURQxn24uotfg=;
	b=b9tCNn+5/p6SoTKL7k+Jr8zBPjvw4+29TqG5U47b5HYtJ81d8gVh6jEszVbzHxWZ0Q7Lgx
	h3dP3Hr5m3U9fLAqKXgTWynYDwgxywJnY22sylGREzcwRYedpnqlroQQS8tAcT10C15esO
	xdo/tad5cGgEi1vtec6ekZzWrt5YD7qIWs8yKlNIN17ORw1OoWMOL+Yp93tz2mgxUNp4+p
	Ddfec0h6Rz/lDHvi5l470x1wd7TyZsIj68gWXH3abBQhVqX/qfqdXplL9TtkUTSdxLMbCE
	6AYSJvusNwYSuNqGcmULNhANH4UA7vq7bZo3vRziZEZvOqpRK99xCqQj1FBTZw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 09 Oct 2026 12:10:41 +0200
Subject: [PATCH net] net: bcmgenet: unshare the skb before writing the
 control block
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-nb-genet-shared-skb-net-v1-1-c6d0a841977d@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw6CQBAEf4X02UkWwkP9FeOBZRsYTVazg8aE8
 O8ueqxOV60wJqXhXKxIfKvpI2YoDwWGuY8TRUNmVK5qS+dOEr1MjFzE5j4xiN297Nh0dUc2YTy
 2NbL9TBz18ytfkA+4/kd7+RuHZW9i275PZLT7gAAAAA==
X-Change-ID: 20261009-nb-genet-shared-skb-net-5747ee5df864
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

bcmgenet stores first_cb, last_cb and bytes_sent in the skb control
block and reads them back on completion to free the skb and credit BQL.
ether_setup() leaves IFF_TX_SKB_SHARING set, so the stack can resubmit
a shared skb that is still in the ring. The next transmit overwrites
last_cb, so the earlier slots complete without crediting their bytes
and BQL stalls the queue until the watchdog resets it.

Unshare the skb before writing the control block.

Reproduce with pktgen in clone_skb mode, which hands the driver the same
skb while earlier copies are still in the ring:

  modprobe pktgen
  pg=/proc/net/pktgen
  echo "add_device eth0" > $pg/kpktgend_0
  echo "dst_mac AA:BB:CC:DD:EE:FF" > $pg/eth0
  echo "dst 192.0.2.1" > $pg/eth0
  echo "clone_skb 8" > $pg/eth0
  echo "count 0" > $pg/eth0
  echo start > $pg/pgctrl &
  sleep 5
  echo stop > $pg/pgctrl
  wait
  cat /sys/class/net/eth0/queues/tx-0/byte_queue_limits/inflight

inflight stays nonzero on the now idle queue. clone_skb 0 leaves it at
zero.

Fixes: f48bed16a756 ("net: bcmgenet: Free skb after last Tx frag")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Another finding while testing the genet MTU series. Similar shared-skb
bug as the macb fixes already merged in net [1], here in bcmgenet's Tx
control block rather than the software FCS path.

[1] https://lore.kernel.org/netdev/20261006-nb-macb-shared-skb-net-v1-0-a80641479041@tipi-net.de/
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e8908916558b..f4cfbff49a1b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2153,6 +2153,16 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto out;
 	}
 
+	/* We store Tx state in the control block, so the skb must not be
+	 * shared, but ether_setup() leaves IFF_TX_SKB_SHARING set.
+	 */
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb) {
+		BCMGENET_STATS64_INC((&ring->stats64), dropped);
+		ret = NETDEV_TX_OK;
+		goto out;
+	}
+
 	/* Retain how many bytes will be sent on the wire, without TSB inserted
 	 * by transmit checksum offload
 	 */

---
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
change-id: 20261009-nb-genet-shared-skb-net-5747ee5df864

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

