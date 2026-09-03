Received: from mail-m49247.qiye.163.com (mail-m49247.qiye.163.com [45.254.49.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101BC442FD4;
	Thu,  3 Sep 2026 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425101; cv=none; b=n7XHgDw7eqJxQ/VrhAZ9jZ1sEJEkIv2w4VIrtNI85kgLsOnuXdMYQnE2/P1wc0QK5rVnRfVz4qT9E2tI1VSS0BWLrtuPQZHgAIupgkltLJSABGVHkd34BPSefRAdkeS20DPpi5mrxufrvv+Esp12Zg3VF0lbwu5DCqmz6m1stRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425101; c=relaxed/simple;
	bh=bD/E5OXt9bu31EjGp9Dxo768gwyJHnmNAZC/wG3PPGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2MgAlKiQ4YkXIwjhaJJ0bhZcsXsADw9VaHDYk0lc1JJh+AnoFDytdmCf2H3UJWMvP2aratXkBvLwbaZvwZ1ovuZvrStpjKCM/MC88oGSWlWTwPrSh+oh8/x8y6EToNKW2Wi0ZpSgGldpoYihnT+SuaSqgC1mOfwaO1o40n6c8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=45.254.49.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5aa0;
	Thu, 3 Sep 2026 16:44:49 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>
Subject: [PATCH net-next 05/14] enic: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:30 +0800
Message-Id: <20260903084339.870562-6-zhouruizhe@resnics.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260903084339.870562-1-zhouruizhe@resnics.com>
References: <20260903084339.870562-1-zhouruizhe@resnics.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0667130a703ackunm85c9d55b5cc2b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ05NVk5DTUkZSEtOSE4dGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSk5VSUlLVUlLT1VNWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

The DMA API guarantees support for masks of 32 bits or wider and
explicitly identifies retrying a 32-bit mask after a wider request as
incorrect:
https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities

Remove the obsolete fallback while retaining the error check so that a
genuine DMA setup failure is still reported and aborts initialization.
A successful setup now necessarily uses the 47-bit mask, so remove the
redundant using_dac flag and advertise NETIF_F_HIGHDMA directly.

Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 0baef7a120ec..d32fd03bbf6a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2991,7 +2991,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct device *dev = &pdev->dev;
 	struct net_device *netdev;
 	struct enic *enic;
-	int using_dac = 0;
 	unsigned int i;
 	int err;
 #ifdef CONFIG_PCI_IOV
@@ -3033,20 +3032,11 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	/* Query PCI controller on system for DMA addressing
-	 * limitation for the device.  Try 47-bit first, and
-	 * fail to 32-bit.
-	 */
-
+	/* The device supports DMA addresses up to 47 bits. */
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(47));
 	if (err) {
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			dev_err(dev, "No usable DMA configuration, aborting\n");
-			goto err_out_release_regions;
-		}
-	} else {
-		using_dac = 1;
+		dev_err(dev, "No usable DMA configuration, aborting\n");
+		goto err_out_release_regions;
 	}
 
 	/* Map vNIC resources from BAR0-5
@@ -3319,8 +3309,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->hw_features |= NETIF_F_NTUPLE;
 #endif
 
-	if (using_dac)
-		netdev->features |= NETIF_F_HIGHDMA;
+	netdev->features |= NETIF_F_HIGHDMA;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
-- 
2.27.0

