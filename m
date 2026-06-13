Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44597194A6C
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781337652; cv=none; b=RygLGfGC/PXYuzHXRRxMFavyjUsbGJPMmuGyCHjKbB2TRJhW9n8kttQ/bsy9bkwaQnl/WQjfVCi+SNrC9V8GmrwC0b06X+AZSyN8plH5IPHsYCyPUIzUMMv7vlc6+DF2IZ3iN2GDrS+zZ/rLkVE1tc52Fwj4PG7GHwyvBwb5leo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781337652; c=relaxed/simple;
	bh=/P6cef/Ph1EsoMv/vSxwFbZW2O9JtloQ0tFlgcxAlC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9TV/YjTmp9AWwBjlHL209/bwZN4LlRgFAKvyPqnkbEZNXGSw4mINbs50QK/ddLXGSBfDxPRjVEziW6ZupUgFncjgTvb3zeXeDKZTBK0Ke3J9sEGt4pUvXt5y/87229zFt1xg8CMYOzVmy4W8btOFaEzYQf+eVkPDbKjc5kcYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6ecq/fJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6ecq/fJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf2247e38eso16250435ad.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781337651; x=1781942451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M8aCTmGI+fcgTp/+bGJv6Crm7NUeezXYM9E2T/9hZ/8=;
        b=V6ecq/fJsQnCS2JEoEFjeml81QT0xxssqOHWCKB146MCZvvyCbjl+aWeLGKD3pEEWD
         WTXJOmjyswPln2fgviN77E9XULDnloY/Aj5UmN+ppIT6hb1S2NksaQA3LyPCBhP16v8k
         ptUm8iQ1lBRCi/2EKmHOXMtzxOcKgUvFU3Zx6zGajXlU+dNl3T3gkRNlgbP1LlRNKdUL
         VdwMCpf36b7GKuyZ06zKeF+QU+pgWZAjyRZSZJv01EXmmw3hQ68CCT0JQma3OG0fbW2s
         Ozs43ijoQuBnwxScBCuqFu5exDkBpxDApmcYRwutAfGkoZpj8iQGHYMHXxn4rWAyjji8
         6HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781337651; x=1781942451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8aCTmGI+fcgTp/+bGJv6Crm7NUeezXYM9E2T/9hZ/8=;
        b=k/9fFVUcdZ6r+rY8fzV+BF2v5JzvVGUPOpeovojJ7lL3k9jJr+i+MtEnoNXWB418YO
         V7CKtEIT+EN8uwIE2bo4gf68qbZLXZRX6h53Xvvmtg1ZldD1yU957hX0NSic0tnzIgeS
         cgFNeSsc9uczA/I6/GVj6m0d04/WB6lKmg9od9MFEbx9vu9rbxt0QvN6rzP/iXS8mXOB
         9jy8IB7MKvDKBPO+vB/AH36Lag8g9ibhan5eqg6prTgL7FsDFQTk2+1c7cwGRp3/h6db
         5qnNfrQfFZ+Ud0sHA7QOPX80oMI7p/vIxA1s7IQnx/DqKxdkodN4Kw6W00mL7dr6TRi1
         V8JA==
X-Gm-Message-State: AOJu0YzfbXrVykaEZ1fsjEKjJGGI2WhznCP8EsNbdWJkTUM1gI2lRpTo
	3KMog4SA1FR6CBnCCipL2WK60qiMGCzYPHUKQgZN64JAO6N6n2G7/EXpwTbknA==
X-Gm-Gg: Acq92OGaNKN0cqmAeMBkFAXv5cR9q//DLprHkxQxOGSgBGtBZWIyrbTZc4mwHToICTu
	xxHtHVjAXy6Xf284oWX8wsQXHw7pAssicvzNovlzKuIEKBbaKFEkgMlTDuhPFU20MI1Iq49kENH
	BGockEtPQ0Hzk8a3UFPDPh5aRKAFjDzfJbXGGnCe3wRV9tN4Rw1xro1NS2ApWyB8oYkA9PVrIn0
	IIROjcuPfDpvr0Y+k3Vdf0vsMHhfTA6Y0J342jBnv7YtamrBFlmsjLnHUxh3siYyUTKBT7blfFE
	cWeFTJd83OCZeTycQjnCvw8Otqk19stDLF8Jt0/cvWBkuYQAcJGxoDeWVSjKnfD6BQG7nwwjVaZ
	sK+t7MJ37s2K6NN5/PGwM3jJ+dX+X8r9pkDPDFHLbU5WFQqV4TTwjjtk48snaUbTwh3zaaJ7Gvv
	wlL8F9Sl3G/e48NHBZTao0VusaMkHPi1OodbyYWt+yz1s=
X-Received: by 2002:a17:903:3d10:b0:2be:bcae:f6b0 with SMTP id d9443c01a7336-2c41235d122mr76459585ad.22.1781337650536;
        Sat, 13 Jun 2026 01:00:50 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:c31f:ffa6:4d6e:668b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42c43543asm43277495ad.0.2026.06.13.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 01:00:50 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2] net: pch_gbe: handle TX skb allocation failure
Date: Sat, 13 Jun 2026 16:00:43 +0800
Message-ID: <20260613080043.873027-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pch_gbe_alloc_tx_buffers() allocates an skb for each TX descriptor and
then passes the returned pointer to skb_reserve(). If netdev_alloc_skb()
fails, skb_reserve() dereferences NULL.

Make pch_gbe_alloc_tx_buffers() return an error when an skb allocation
fails. On failure while bringing the device up, clean any TX buffers that
were already allocated and release the RX buffer pool through a shared
cleanup helper before unwinding the IRQ setup.

Fixes: 77555ee72282 ("net: Add Gigabit Ethernet driver of Topcliff PCH")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v2:
- Add the kernel-doc return value description for
  pch_gbe_alloc_tx_buffers().

 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 37 ++++++++++++++-----
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 62f05f4569b10..febf07326d1da 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -1420,13 +1420,25 @@ pch_gbe_alloc_rx_buffers_pool(struct pch_gbe_adapter *adapter,
 	return 0;
 }
 
+static void pch_gbe_free_rx_buffers_pool(struct pch_gbe_adapter *adapter,
+					 struct pch_gbe_rx_ring *rx_ring)
+{
+	dma_free_coherent(&adapter->pdev->dev, rx_ring->rx_buff_pool_size,
+			  rx_ring->rx_buff_pool, rx_ring->rx_buff_pool_logic);
+	rx_ring->rx_buff_pool_logic = 0;
+	rx_ring->rx_buff_pool_size = 0;
+	rx_ring->rx_buff_pool = NULL;
+}
+
 /**
  * pch_gbe_alloc_tx_buffers - Allocate transmit buffers
  * @adapter:   Board private structure
  * @tx_ring:   Tx descriptor ring
+ *
+ * Return: 0 on success, -ENOMEM if a TX skb allocation fails.
  */
-static void pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
-					struct pch_gbe_tx_ring *tx_ring)
+static int pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
+				    struct pch_gbe_tx_ring *tx_ring)
 {
 	struct pch_gbe_buffer *buffer_info;
 	struct sk_buff *skb;
@@ -1440,12 +1452,15 @@ static void pch_gbe_alloc_tx_buffers(struct pch_gbe_adapter *adapter,
 	for (i = 0; i < tx_ring->count; i++) {
 		buffer_info = &tx_ring->buffer_info[i];
 		skb = netdev_alloc_skb(adapter->netdev, bufsz);
+		if (!skb)
+			return -ENOMEM;
 		skb_reserve(skb, PCH_GBE_DMA_ALIGN);
 		buffer_info->skb = skb;
 		tx_desc = PCH_GBE_TX_DESC(*tx_ring, i);
 		tx_desc->gbec_status = (DSC_INIT16);
 	}
-	return;
+
+	return 0;
 }
 
 /**
@@ -1887,7 +1902,13 @@ int pch_gbe_up(struct pch_gbe_adapter *adapter)
 			   "Error: can't bring device up - alloc rx buffers pool failed\n");
 		goto freeirq;
 	}
-	pch_gbe_alloc_tx_buffers(adapter, tx_ring);
+	err = pch_gbe_alloc_tx_buffers(adapter, tx_ring);
+	if (err) {
+		netdev_err(netdev,
+			   "Error: can't bring device up - alloc tx buffers failed\n");
+		pch_gbe_clean_tx_ring(adapter, tx_ring);
+		goto freebuf;
+	}
 	pch_gbe_alloc_rx_buffers(adapter, rx_ring, rx_ring->count);
 	adapter->tx_queue_len = netdev->tx_queue_len;
 	pch_gbe_enable_dma_rx(&adapter->hw);
@@ -1901,6 +1922,8 @@ int pch_gbe_up(struct pch_gbe_adapter *adapter)
 
 	return 0;
 
+freebuf:
+	pch_gbe_free_rx_buffers_pool(adapter, rx_ring);
 freeirq:
 	pch_gbe_free_irq(adapter);
 out:
@@ -1936,11 +1959,7 @@ void pch_gbe_down(struct pch_gbe_adapter *adapter)
 	pch_gbe_clean_tx_ring(adapter, adapter->tx_ring);
 	pch_gbe_clean_rx_ring(adapter, adapter->rx_ring);
 
-	dma_free_coherent(&adapter->pdev->dev, rx_ring->rx_buff_pool_size,
-			  rx_ring->rx_buff_pool, rx_ring->rx_buff_pool_logic);
-	rx_ring->rx_buff_pool_logic = 0;
-	rx_ring->rx_buff_pool_size = 0;
-	rx_ring->rx_buff_pool = NULL;
+	pch_gbe_free_rx_buffers_pool(adapter, rx_ring);
 }
 
 /**
-- 
2.51.0
