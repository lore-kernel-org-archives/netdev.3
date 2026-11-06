Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955991;
	b=Xsr8Bu+V9W3ElsBCdRlblpLobG0v/xvOVMKO0S/ngCjxrzb+oJHTvX8kT1/DUm9n/74q
	 VW8yVGoRh7m+X/Uh4GOwQEe9Ovlg0egqAO82+TLNiiqgocwQsK890IMXIvtChJw4GocY7
	 7rPpypnaB6EqvrhgOjDN4nmi9sGCA1nVw40AzakHudA8WCdcKx0fNm0uCAdndHA8ZEvpT
	 0X7OuDaJLBjPHnp7JyIsPySt/zYJJtnQ/CAhD5SB/6KKEo36Y+dCiaP2BaRlTan1Vs+R2
	 XR34viDPVV1PITNmNjCXQnWkRC6V5P1bnO1af4skIJPysf49W0D8TVDRay5UDFCfeYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955991;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=x0suRdZ6/DF0tbptt+Dz30G9c7M6uSYDspT/LuLlnuM=;
	b=qbJMwKbMJW6XnoSPYpeGToD2y1DLHFDlQ9iFH8tzpAAPZKICmhvhnCF/if427Qm9YNCU
	 QGN3q3WUxr0mHVrqCHJyV85d/5xB52npB04yGZZ+1syB2QQsGN9YF4p/5ySfx5tM3XRLB
	 ii5A3UYyxUAB3CjEUj1gF5uFEdZ9H6cDwCSsVWi5Q54S6Nk4FZdXHBVtLKH/GRV7AOfat
	 zp7x27pg0wWtTwtUmvWnht9rXx4BUY3y8J8ULj3lDW3AwGSQkrhL+0Z29W6Cfo4Ktu3jN
	 /RHba487ZrHHX+vDDtHX1I4xCOgjju5lFCqr1WQoPZrPbCdC3hnv33IdcLu5cR+dzZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="k8ZsrgO/";
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20935606A32D;
	Fri,  6 Nov 2026 09:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20935606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=k8ZsrgO/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=x0
	suRdZ6/DF0tbptt+Dz30G9c7M6uSYDspT/LuLlnuM=; b=k8ZsrgO/gGZjMnHHiD
	G2oXQYV0mkoAFKpqAXiK9xMILaV0idwWttTqIVBt9qK5rB6923Phrln8Eshqwhb5
	J7JeyIdgqZ804sjdc/R2c6Vf6nflQsY0DTFTgNf0xR2jDcBiUKNKTjXl8oAZAaCJ
	X7yl1Qq8wbS0SguxU8bWT1rmo=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_7hJmO1qqwdQFQ--.15084S6;
	Fri, 06 Nov 2026 17:05:41 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: dinghui@lixiang.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: [PATCH net-next v6 RESEND 4/4] net: stmmac: hold RTNL when reading descriptor rings in descriptors_status
Date: Fri,  6 Nov 2026 17:05:06 +0800
Message-Id: <20261106090507.1020751-5-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106090507.1020751-1-dinghui1111@163.com>
References: <20261106090507.1020751-1-dinghui1111@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_7hJmO1qqwdQFQ--.15084S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrW7Kr4rAr4kXr13Ww17ZFb_yoW5CrWrpa
	y3CayqkrykJF15Ja1DCw48Xa45Ga95tFW3Wrn7Gr1fA3WjvFZ0gwnIgry3WFyDGFWkX3Z3
	K3Wq93sxGFW8C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6XdbUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0QVVgWrtmGVRiAAA3j

From: Ding Hui <dinghui@lixiang.com>

The descriptors_status debugfs entry inspects the descriptor rings
without any synchronization against the control-plane paths that
tear them down (ndo_stop, MTU change, XDP program release, XSK pool
reconfiguration). All of those paths hold RTNL, so take the same
lock around the reader.

Holding RTNL also makes it safe to report queues whose descriptor
rings are not allocated: the interface may be IFF_UP with unallocated
rings when an internal reopen fails (e.g. an MTU change whose
__stmmac_open() call fails), as those paths do not clear IFF_UP.
Skip such queues with a hint instead of dereferencing a NULL pointer
in stmmac_rings_status_show().

Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b093119e752f..0f4af7ec3fc8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6707,8 +6707,10 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 	u8 tx_count = priv->plat->tx_queues_to_use;
 	u8 queue;
 
+	rtnl_lock();
+
 	if ((dev->flags & IFF_UP) == 0)
-		return 0;
+		goto out;
 
 	for (queue = 0; queue < rx_count; queue++) {
 		struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
@@ -6716,10 +6718,20 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "RX Queue %d:\n", queue);
 
 		if (priv->extend_desc) {
+			if (!rx_q->dma_erx) {
+				seq_puts(seq, "Extended descriptor ring not allocated\n");
+				continue;
+			}
+
 			seq_printf(seq, "Extended descriptor ring:\n");
 			sysfs_display_ring((void *)rx_q->dma_erx,
 					   priv->dma_conf.dma_rx_size, 1, seq, rx_q->dma_rx_phy);
 		} else {
+			if (!rx_q->dma_rx) {
+				seq_puts(seq, "Descriptor ring not allocated\n");
+				continue;
+			}
+
 			seq_printf(seq, "Descriptor ring:\n");
 			sysfs_display_ring((void *)rx_q->dma_rx,
 					   priv->dma_conf.dma_rx_size, 0, seq, rx_q->dma_rx_phy);
@@ -6732,16 +6744,29 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "TX Queue %d:\n", queue);
 
 		if (priv->extend_desc) {
+			if (!tx_q->dma_etx) {
+				seq_puts(seq, "Extended descriptor ring not allocated\n");
+				continue;
+			}
+
 			seq_printf(seq, "Extended descriptor ring:\n");
 			sysfs_display_ring((void *)tx_q->dma_etx,
 					   priv->dma_conf.dma_tx_size, 1, seq, tx_q->dma_tx_phy);
 		} else if (!(tx_q->tbs & STMMAC_TBS_AVAIL)) {
+			if (!tx_q->dma_tx) {
+				seq_puts(seq, "Descriptor ring not allocated\n");
+				continue;
+			}
+
 			seq_printf(seq, "Descriptor ring:\n");
 			sysfs_display_ring((void *)tx_q->dma_tx,
 					   priv->dma_conf.dma_tx_size, 0, seq, tx_q->dma_tx_phy);
 		}
 	}
 
+out:
+	rtnl_unlock();
+
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(stmmac_rings_status);
-- 
2.34.1

