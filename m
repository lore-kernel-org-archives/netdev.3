Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085184;
	b=y2Dh/H7+Qz1da5nxWwp6IuY+PLCNcMgEn73s78pfbWqDo8MFLJ8V7U8rFGCLUsd42QgJ
	 Km1sg/9BhACVxoOgOumokLY6A4n+FJOK0lHJ/tB40LMmKE+0OrQsxbZx6zAS/GwPcJGet
	 93DMS+iiVKc+1RjTYoh46OguWrzeHsDTYj8vi1ha890fw6xoRkssrvUVL96G6JkDU6TlL
	 Qk1UK0ZQpMFEc2Fv7I0zC3lM+TmMUaStPSau04u5wwSEAAq0FUj0Kkfy63OhHNKiSftlS
	 aiAmiLGMj+8zbFimbHftaLycb1YIs4O9PajbEgfldO4ISQmi0EgxFA4Vm2iyDGy3eRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085184;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=DdANYzbV0Lro+OPxxD4bgUweqNMIXZ8k/JJD4bBO6rI=;
	b=CAYxMOHaMzuEtjjV/+OQn6zaQEWSBvh7uYPcUuzEHSRq1bly0b9Psk70G+5VAOrj+iE1
	 Lngk5fkBVdkj77NBTjO9w5oulzsqnKvEiOPc9AJ39eoUQ4bPtEzXErU05+5ymDKte5Uq6
	 hIVu3dgCl5aZyBlt01EApeuaMezhV250EMAUsEPdegdG26mvOO9+RvQMXtZEdiEBE3KJX
	 hlnKEhG5fjesP8BhM7puxnYfHRjFENDlUomy2dCEzFJeURB+DGwEjRNVDovaxeFlWCEKY
	 6SEEBif2N+seeTzBm4YIu5E3fouuwXg5dZ3+hptF8VmBs6SqZdhRGx2E113VwGXrn7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Edus5YeA;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19E606D805;
	Sat,  7 Nov 2026 20:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D19E606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Edus5YeA
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D29B1A0034;
	Sat, 07 Nov 2026 21:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794085176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DdANYzbV0Lro+OPxxD4bgUweqNMIXZ8k/JJD4bBO6rI=;
	b=Edus5YeAcb7ZtvU1NRFfbiHlNXNRD8a4VytQ74PxTYmtcjZJSITS/xz3/djqBNZOLS3+LN
	qd6r0NO3OYD5NGPkDn/9NDMt6xFnOHDzM80nWq+0lgH/QFkAVAhsdU6/f+NDaL8gMBPJHh
	b/YRXkTxg8nZnE3E240Hgral19jubWkcUYZ5FwkiCgNsbs4FB35yeM4Nu6gXHcVhjYBNtf
	pzpTdZ2AgNih12pLCFHFZLVLkLEjdq1ON+ZTAlxvjgk2mYOKw2W80Fadjv0NhgFPMjXKkQ
	T8QZfGzdfQuwC4+S/nbu9owuGO9DMCxrWebOoJgVfD1cAplUj8ktcMZesrVGrg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 07 Nov 2026 21:58:47 +0100
Subject: [PATCH net 1/2] net: macb: credit unsent frames to BQL in
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
Message-Id: <20261107-nb-macb-tx-error-task-net-v1-1-a2aac5d64d52@tipi-net.de>
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

The frames dropped on a TX error are never returned to BQL. Each error
shrinks the BQL budget for good until the queue stops with an empty
ring.

netdev_tx_reset_queue() is not safe here as the task runs without
tx_ptr_lock, so macb_start_xmit() may still be queueing.

Fixes: e6a532185daa ("net: cadence: macb: Implement BQL")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f087f278f9e56..b6105f915fe35 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1412,10 +1412,8 @@ static void macb_tx_error_task(struct work_struct *work)
 					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
-				packets++;
 				bp->netdev->stats.tx_bytes += skb->len - tx_skb->fcs_len;
 				queue->stats.tx_bytes += skb->len - tx_skb->fcs_len;
-				bytes += skb->len;
 			}
 		} else {
 			/* "Buffers exhausted mid-frame" errors may only happen
@@ -1428,6 +1426,12 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
+		/* BQL has to see every frame leaving the ring, sent or not */
+		if (skb) {
+			packets++;
+			bytes += skb->len;
+		}
+
 		macb_tx_unmap(&bp->info, tx_skb, 0);
 	}
 

-- 
2.53.0

