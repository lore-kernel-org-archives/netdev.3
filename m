Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085184;
	b=XfQBGbQA6On2zXcB90jzyr+MD7fDJ6dmLfgayGTXUO4okZ4d6/GezxdShHc9jDIz/XSO
	 ChpAVKmFh2WmRlFPW5pWCENYrDF8cKLYjRY8h6y5VnO4vzbgOlpaay7SS0RsnxvYzWSiU
	 KUn/8zOEYhgkxIEXDYS2JFi05jEy/tdlyL8/+mnQ0whf+HdoThTyMWuoEtafYUNbHuQKe
	 mH0M+eTAgB3WgoLmrDXaNFoRSbqZOx237cdLXzWpS7yHlDbTYRip3c4boZ8cxhROP9yG7
	 gb9awJ3qRvlTlKx92LIY2EaadE4wKKp9BUk72LQTg7Y26SqpIobj+0VcHCMlBY3i9Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085184;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=hpR0zVuRuUqZ9VGR9qvagaBxW1BWpTXv26l9osews90=;
	b=f1eOuN0IN88iWEzypFOe+AI+wGVJZ7ztufsUM9aPpqLoEiNZziew98z3sDik27iXAV4N
	 uKqzNrkZI6fn2ZUpKemduixkYWPUCXaypXOQt4d8HjjSMym/AQmnlfHYd5PxmwJsGaZMv
	 4YUj5U2JdY0N/LaPYnDjtxkfvo7cs49ogCT4DvdzUaUk0RtXQF/qwxR91PObw58JJYZIP
	 9K0K76nAgfSjOXXtQZgeT7F6B71252gsrNER6CqFZdBihk7drdcMsAGC5sTTz/ruH6jIb
	 1wmSEyzrX/YBJX13zHGyMVkkHoYLeMppCtLh+Eq7HotKKZWD0sHiJfyKFW4M3RgreGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=HMFHHVlL;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B447606D809;
	Sat,  7 Nov 2026 20:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B447606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=HMFHHVlL
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58028A1649;
	Sat, 07 Nov 2026 21:59:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794085176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hpR0zVuRuUqZ9VGR9qvagaBxW1BWpTXv26l9osews90=;
	b=HMFHHVlLF1BTzDGHC7Ul38V7bG2CHGty4dh88arRy0FSCRlwoMF0aKrmwHJCsJgfCLH7YL
	TR1A4Pv7DZu+9+bSD3y1Z8A3Q+hqXpMjC2deZeaWXHidR1F7R0Syzk09iH0Go99V9nRlWn
	1e6WYAc18m8L1UjSkq9DLka7mLs2+TFbO2kmtF7vMHwojHFzRKseZV0u4WcO5VCZu/OOsD
	6DunosJzt/IEQLkATQRiLCnWQRDbhCcBzzpH2pQo/hxtScX9uZWkp/wSyTTHAxpKa/Lv+w
	CbvmPhusHBPvGeDuOb8FKah7kPUf9RgzFxw0zq1O/pD4Cb4hiiUhLelfk9Mckg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 07 Nov 2026 21:58:48 +0100
Subject: [PATCH net 2/2] net: macb: take tx_ptr_lock in
 macb_tx_error_task()
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
Message-Id: <20261107-nb-macb-tx-error-task-net-v1-2-a2aac5d64d52@tipi-net.de>
References: <20261107-nb-macb-tx-error-task-net-v1-0-a2aac5d64d52@tipi-net.de>
In-Reply-To: <20261107-nb-macb-tx-error-task-net-v1-0-a2aac5d64d52@tipi-net.de>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, 
 Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The error task resets the TX ring under bp->lock while macb_start_xmit()
updates it under tx_ptr_lock. Stopping the queues does not wait for an
xmit already running on another CPU, so a frame mapped during the reset
is lost and its skb and DMA mapping leak.

Take tx_ptr_lock like macb_start_xmit() does.

Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b6105f915fe35..ff5e364e857e5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1369,7 +1369,8 @@ static void macb_tx_error_task(struct work_struct *work)
 	 * network engine about the macb/gem being halted.
 	 */
 	napi_disable(&queue->napi_tx);
-	spin_lock_irqsave(&bp->lock, flags);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+	spin_lock(&bp->lock);
 
 	/* Make sure nobody is trying to queue up new packets */
 	netif_tx_stop_all_queues(bp->netdev);
@@ -1463,7 +1464,8 @@ static void macb_tx_error_task(struct work_struct *work)
 	netif_tx_start_all_queues(bp->netdev);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 
-	spin_unlock_irqrestore(&bp->lock, flags);
+	spin_unlock(&bp->lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	napi_enable(&queue->napi_tx);
 

-- 
2.53.0

