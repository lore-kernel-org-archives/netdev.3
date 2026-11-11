Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399793;
	b=ibc8ekmsctqEJA3DpuLb4KWJpvG4LpkW2qKRgZkgH11MkEFvnxQZvXe+nQwo/hKJc71U
	 KjcRXNhIZPL98Yr77SZg1qek7GWzRyCUJrZhzJZGHPbgovltE9v+sSFpdc9eoRcK5SOHs
	 iap8XdjVOTfy6RAxTlL3u6gDyBN+ilAGOQKlXjWplFz3DtYRB2uGE5RSIwTawuFh629y9
	 W3ZG49WNU6P+OZCX8wF1UeeFUeEkPZN9bqMnEPGjMRaExF9QeWEz8TqkGUegBCWki8/pc
	 VNAKRxFKprpgy2+Z2xF/xrVzeVzQyJRKE0IUiPVk3zpa6dYkAuOE1y+N86LgVokCw8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399793;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=5BFnT/zEs2nZDDXgK2IhiC+IEo1XOeLD90u3XzoM3dE=;
	b=elQ0iUkfZhmsNa3I0sjX1QQjUh10MrlEVasM6V8pP3HavWbvAVaL3rwkvWuN+2W5m+Wc
	 2jF4xc6JvdRSuoo3il7XOg0Eczuw/hiaKC3gYg0m9xAxEAxTP2ZOUr9DYogfdE7u899uB
	 11563uUyEVIWIqzSS0aGiI3YkNzIndn0kdIudhmCFOr3CJjIka5Oy8u+zyVdL3TQp7ncu
	 cITfZHPcNxYQfUQr5RthRFqDZ6k+W3RNQ/CQhszLm/8eu/o33VjoheMhB7sPhb6frZadS
	 FG8XGV2o09xBhZZTCnxle55yUmMkjJcm0GNPMSJ+4zLGUORS8DJLF3tJSlLj9uDpUZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=TflCKuwV;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F7606A31C;
	Wed, 11 Nov 2026 12:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 457F7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=TflCKuwV
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54502a16d;
	Wed, 11 Nov 2026 20:23:06 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: fealnx: Fix potential use-after-free during removal
Date: Wed, 11 Nov 2026 20:23:05 +0800
Message-ID: <20261111-e5624093d6-net-fealnx@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ca8fd77003a1kunm7b1594631b3658
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSR1NVkhMHxhISUsdGElIH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=TflCKuwVIS2kFsyGCA+i3h4c4K+e90idRd0T8bW5cWxQE8eWJPX4NPeNZ0AgVIbhOyhIaoGtT7mzfhjbxhj3yE/w+rLE5iqo3P4YXybYjxMjpLE3YSkUZESaextcABFOJHD1JLAQu0sTX/zq8yAMi54UqBGVqkUiSyOgUBzkjkY=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=5BFnT/zEs2nZDDXgK2IhiC+IEo1XOeLD90u3XzoM3dE=;
	h=date:mime-version:subject:message-id:from;

Removing an active device frees its descriptor rings before
unregister_netdev() calls ndo_stop. The stop callback then reads the
freed rings to unmap and release their skbs.

Unregister the netdev while the rings and registers are still available.

This issue was found by our static analysis tool under development.

Fixes: 8f1482080104 ("eth: fealnx: bring back this old driver")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/net/ethernet/fealnx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index bdc38aac5850..68194c9ef332 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -682,11 +682,11 @@ static void fealnx_remove_one(struct pci_dev *pdev)
 	if (dev) {
 		struct netdev_private *np = netdev_priv(dev);
 
+		unregister_netdev(dev);
 		dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
 				  np->tx_ring_dma);
 		dma_free_coherent(&pdev->dev, RX_TOTAL_SIZE, np->rx_ring,
 				  np->rx_ring_dma);
-		unregister_netdev(dev);
 		pci_iounmap(pdev, np->mem);
 		free_netdev(dev);
 		pci_release_regions(pdev);

base-commit: 2e54b3e187300893688c2c7517894f5d96732e05
