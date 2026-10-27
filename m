Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130869;
	b=ASM81FuYSj5uJGoUtgCt8/oWrt/vvh6FlUJyRgULULgbLLo6OUWEZNY+zwQenpnmIEIu
	 PzBw7UKH4pQr9MSIU0qCWpcdYWfq2wcAlJKGQFiQYyIDCsRe/dduJcAP2VCAXd6SEoIY7
	 0sRCSli2GvYpJmrrOrho1BHETtr+Cue9gpEeHx3+5ozVgvmqU6ZdBYRzKbguOGwKqha+C
	 0yP2GPnzpwF3xguaKv8V63ajJ7xBJomI8FTUDTi4cG21orPPBPY8XQBBz2Xs79SAsP6AU
	 o+rPlssgMJBHz4pslAA3CIGQ7pGXeVJHt5Z5fAgNtmZsOGp2cW/gFomLuxy5kTPE2Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130869;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=uMUAvH+gylo3aGfBUzHy5/oge2cBB7PCRzSrhUkZMmM=;
	b=MQdBMFBQ4Hq67jdsWfeKbOF+cw+ZUewlCD8v0ik+3vzJMNu4IrUUfD84/ZJblkVPYpdu
	 WCBYTxCdQUWXkD8my17kG5ARtau/lH7LeLVGz+lir9e4tiHtEypZQWCXMW3NM/Q8l/5oj
	 XqDXqsUgqYlBvCMWOwRW0I+2RwOe2YksfeWWmVWmBW6Ae0fj+b8yi2Tkaj4juP+XnoheU
	 1fHObPbK4+Uu4RhRIdru3BkCOwWpKFsRQlHoncrDX562fC+513lagafkpl9TmkgoUHUty
	 hlqoDsq5Qm4fagTKzcnJa/6vKcYdWr/0y1BWg/qQQZjuL4hETMl9ZPR0+kf804zfHqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=VQVXz5Fu;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67A606A31D;
	Tue, 27 Oct 2026 19:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B67A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=VQVXz5Fu
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18BFBA50BC;
	Tue, 27 Oct 2026 20:54:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793130865; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uMUAvH+gylo3aGfBUzHy5/oge2cBB7PCRzSrhUkZMmM=;
	b=VQVXz5FuGAGcIWC6YCwdDF3Y3xmzAneEvnasNs+h3ctScrS2LFNoTCZh0X1ruVwIXleDXc
	UyRmv9MVHA3ah/hTYTBtvw3ycDv/hphsV+Xhc8WILhpKdV5RZD62uM0cz18d1M55K1lE91
	L6LVY0sZo7tbNAZwcoHTc+HILYcXXlNuGhdSxZfecH2crCNR5hpcO5pLFBchDSc6EDKWXA
	dduZ37rESV8cPbgGa23dwwqFSTiM2b05IqhjrY8LSCPv8anKibHzMjjvwH/GrEXQCZyX/D
	fTxfV93hdq8sQGjYN3036SptVAzXO15FUZuOhXjg8bCwrLhgKOJ/cdFts3i+4Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 27 Oct 2026 20:54:06 +0100
Subject: [PATCH net 1/2] octeontx2-pf: fix skb use-after-free on ipsec
 transmit drop
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
Message-Id: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-1-2114c4f10c36@tipi-net.de>
References: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36@tipi-net.de>
In-Reply-To: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36@tipi-net.de>
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

When an SA is removed while packets for it are still queued, the
transmit path frees the packet but reports the queue as busy. The stack
then requeues the freed skb, and the DMA mappings leak.

Fixes: 6a77a158848a ("cn10k-ipsec: Process outbound ipsec crypto offload")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 77543d472345e..3920cd0985831 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -1037,6 +1037,9 @@ bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
 	cn10k_cpt_inst_flush(pf, &inst, sizeof(struct cpt_inst_s));
 	return true;
 drop:
+	otx2_dma_unmap_skb_frags(pf, &sq->sg[sq->head]);
+	sq->sg[sq->head].skb = (u64)NULL;
+	atomic_long_inc(&pf->hw.dev_stats.tx_discards);
 	dev_kfree_skb_any(skb);
-	return false;
+	return true;
 }

-- 
2.53.0

