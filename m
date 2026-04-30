Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2538E106
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537590; cv=none; b=hvV1Rb6Gm8v7Zl7tkCsmYvrY74kweJyuNRs07d9Cwjm28l3H23lPt0SOtx4GRdcM8qgz5al6TgPLyPDiD31xljhN/2eeD+c4Lxg+yirWuRCf8+qv6bEhoOIJL83f06dKsNqpz4Jel5ruUwNbX7DcH+YXFdokx1vv3aNiqPU3sus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537590; c=relaxed/simple;
	bh=r3/p5IIDDvcr6jdNXzakR+vAwMvAbP/ufBb0gPnzt4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFRUJAZJ33y4/BDHurADDSIwwSi3d0dCyjhtEFXK3bB5OZiv1vpO9jBORaiCdH4uxNqCSTmbUr02SjgsfJDlCsavWykPqeGZLLV2X0+I2SyHzzol6X2oagAiXN6D/XnI9zb79Zuqk+7/MkdAGfNIWv/kVYBAPEZ53Dhb1x6T84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1777537555t78bd86aa
X-QQ-Originating-IP: FF7LQ38VBhsXppt1Ho3WZptUHu9dZMzepJymGvEYvHE=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.155.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Apr 2026 16:25:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15663724136487969234
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Joe Damato <joe@dama.to>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 5/6] net: wangxun: clear stored DMA addresses after dma_free_coherent()
Date: Thu, 30 Apr 2026 16:25:16 +0800
Message-Id: <20260430082517.19612-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260430082517.19612-1-jiawenwu@trustnetic.com>
References: <20260430082517.19612-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ODt4oR9+iAxWgmg0gJW3MRrhqWowKz96Xrvk9DMFURTSRMxhZLFNWVgA
	jBbJwB74384HDve34kibf6CzYyigOydLnWUOnmnQS1j6dnrfPA+gXMbDvjkeVZj9H40Nx4r
	rqtvJi2ecj/Zp66xNixGFtPEW3DHCoMStLgah7LY5s9X/cQ74vgTt291k6267Z7HntdzfIP
	xedmSSvN7f91XA5yxRrSTarpOJSWvQ0fm7SAcUF7H+fvALaumqbW61BQlprGIEikjGBIMkx
	IEHPBqE+yjs2bCO79KO+Fe9Q7fiKaORe2lGkd8XSXZIQUkYPf0Wot/PeTkK/TQy9uM6SzaB
	jym1Qrbb5Fn6iVqPeSc2sqWPwIhoahQZrK0pPbozo8KXumWOqyMCEx0OO0fukZRVTmQuY0O
	wxBl4yH7VlGFHBJ5SHoJOPPc5NbgSxP2hY5zdhDdN3xUYxzFteVdHFszZLCihOrPC/KE39z
	wmLw6H1XXN829wBXcCOVoWONWs5A174rq3ryNxoHbWqyGWAjg/ozNrrMERX84BtgLKNnvjZ
	LBRti5QO5Mp5ZOG8kot7XBxcDDjXuReWlJ7maiikU4bdXd3Xq2ydMh/hXnk1l2qWttQEfvR
	NlN80WG93AsxiyuDfx6iRN0iVjjBQFpTs297CFUTbLryti9ozl9xQiMgjjzJ4963orEKUth
	NoWOTN/X3TdnDLSMk5HHh7P8mmliFGMLkPfqbEDRuDkUcLKDz0D5r7K9hoConV0tOZAMyHq
	Bo7lWPkhT9bRd4LQRNvWEmDgi7ykCIL2qu+SjjSuKEZTkOBAk0CkHSSvFUvXBDbI57WzHp+
	ZvRdTlk3r84YlY8ZLUNN3CODe43Bj5IL4G+nkra2Fwh82EwCIfCtuJxQTJX+lG16aHK7gkV
	96Z4CWGliMM0J4IwN+VEZ32g/FEjEzHWVZ67kNwdELG66he021h37LlOG4+APq1DfnZZqv+
	rxEZkKHlyx4yGg9EvJNrKRWhDQ1W2S2cc31zf7OZuR17pO0jiy8WwwllkahxpIqMRE6hKbP
	pbQDQ+fyzsMxqEXAXqWI2UkkrNDEfS80P+y2Mz/ZwN7EK3suVcQGCKksUmu6WC1b1ySqITt
	q3KNtcB0TOk2Qnrr4H32ns=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Rx and Tx descriptor rings are freed via dma_free_coherent() in
wx_free_resources(), while ring->dma is not cleared upon free. This
result in a use-after-free of the DMA rings at ngbe_dev_shutdown(), if
WOL is enabled.

For insurance purposes, clear all stored DMA addresses after
dma_free_coherent().

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 3216dee778be..51599f6b878e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2462,6 +2462,7 @@ void wx_free_isb_resources(struct wx *wx)
 	dma_free_coherent(&pdev->dev, sizeof(u32) * 4,
 			  wx->isb_mem, wx->isb_dma);
 	wx->isb_mem = NULL;
+	wx->isb_dma = 0;
 }
 EXPORT_SYMBOL(wx_free_isb_resources);
 
@@ -2678,6 +2679,7 @@ static void wx_free_rx_resources(struct wx_ring *rx_ring)
 			  rx_ring->desc, rx_ring->dma);
 
 	rx_ring->desc = NULL;
+	rx_ring->dma = 0;
 
 	if (rx_ring->page_pool) {
 		page_pool_destroy(rx_ring->page_pool);
@@ -2782,6 +2784,7 @@ static void wx_free_headwb_resources(struct wx_ring *tx_ring)
 	dma_free_coherent(tx_ring->dev, sizeof(u32),
 			  tx_ring->headwb_mem, tx_ring->headwb_dma);
 	tx_ring->headwb_mem = NULL;
+	tx_ring->headwb_dma = 0;
 }
 
 /**
@@ -2803,6 +2806,7 @@ static void wx_free_tx_resources(struct wx_ring *tx_ring)
 	dma_free_coherent(tx_ring->dev, tx_ring->size,
 			  tx_ring->desc, tx_ring->dma);
 	tx_ring->desc = NULL;
+	tx_ring->dma = 0;
 
 	wx_free_headwb_resources(tx_ring);
 }
@@ -2906,6 +2910,7 @@ static int wx_setup_rx_resources(struct wx_ring *rx_ring)
 
 err_desc:
 	dma_free_coherent(dev, rx_ring->size, rx_ring->desc, rx_ring->dma);
+	rx_ring->dma = 0;
 err:
 	kvfree(rx_ring->rx_buffer_info);
 	rx_ring->rx_buffer_info = NULL;
-- 
2.51.0

