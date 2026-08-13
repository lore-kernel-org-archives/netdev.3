Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3831ED83
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606470; cv=none; b=eB8Rb+wY/cllryiWLrDDltlV42kfo9BXlDCxDS7Ksm3SZCn8nnL+/yDI2XUyOFanTVt9KfiJlakL28PJYgs2OfLISTuiY+hp3x6M9xax1vX8LqUx9MRlYie/ssOPWCyQwfjVIUXPYvVNa/4Vd3fRZl1u9iTXaHvsWJgC5vnN44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606470; c=relaxed/simple;
	bh=EBNg0GmDYCZqs5/jZh2Ptz6/mWztUNlm5+Q3nICofjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dhu3bQ2STj35aSmdKshX72vsy28X+QN1J1Stqst4VkOFScbCb/JljK+2cCtFIJBpgM7/BBuSNcHWAGHSVsY9vwLtBp3oIEgqZkQEHaPQ6fcmAkqRao4vNCTe1XdC/naL/MOOhZHcD6uAMyQfUlx1OtPpc5si0vbkYdazLlJAMg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1786606392tf1070753
X-QQ-Originating-IP: Lalj4WuMZw486L+2IoBM0BW1ulJ15n6ljsa6Yv3UyGE=
Received: from w-MS-7E16.trustnetic.com ( [36.24.185.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Aug 2026 15:33:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16781039887724340673
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: txgbe: fix interrupt mask for MISC cause in non-MSI-X mode
Date: Thu, 13 Aug 2026 15:33:05 +0800
Message-ID: <59215DA27859BC49+20260813073305.360251-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nv1Zs1ssfOILUEsn03iTBqcRPKbsmX9agxkjD3/drbQ/m9O2iHfcEP8M
	xVCe/fWgyF8fMzmgGPWVTJVHtfCEN9JhBECpwdg7jAvw1PUI7rIEi0mYWNMz4fBUPtQOXdy
	UsV1HH70xsfBTJqNbvyOzz+ok43MMHGlLyqIL/2G/mGWpjIGiVDmtdketA41gabOsnQjA4g
	UMF+K6Q7FvQNKCRZl9elTVe9wq17+cX6CpafGnEL48gmx69nT0ZFr3B5fWRcwNLVkIk/wGS
	uE6kzG4UYFdJOIJdkg+kL/URmhIiyNVpV6zdMaQGtPXCyEdb8KvSz8JUn9DrYe/8cbje6Xp
	k2nQduSAOKczu7FCf+RYd2xXxwEUEOt8rIo61iRxsS4dIFsjnZEZCo7HYm0bGwbOKKJ5yxJ
	kxeFRDVFGFASSje8lkrPUJxfdLwZ6b3mRyBIlV9Wwyqgh5oiW9Zo+6qxfo+wWw9AuSP50N4
	QK1HEzbwnZ2q7MlYdTAiLzFE0bMSKvnoPGMxeY2m2E8R3UYv8oFkshWPWfLOwlYpDewksl6
	i9JP7gqGGfkF65R5gWIHoMO7dFNWrZmtDb1D+LCwPI3U5S2L/1Rcvmi453MoDOQE0OJyDDJ
	MYXsB8PBXOAK+vzsHlrXBtk8myB8txw0u2D/hL2oK1Gk/g1NcVekWv++fABN1FS/hYstLbW
	oPnr+RyStqP5eHUpFet4o8qpg7M28S73od+8BGOB642mFfGjWcGZ04WMgCqwcHBQab5AmWw
	LbVlMJdfsAENgbBMTttcGy7tGaqXW7RaV6MxaQtgKlp9bwVZSB8tR2nlGMG/fmo84vYrEad
	xgIODLGDzfexvSaXgW3E+UnxKDRfFDTzR48NjKYUH1g0+8mxN1UON/1C0KXul8lVyH+TURk
	b3CwCOjBLHOV0CgfF2Qc7LLZ9Qz50MuWXw5la75O9w9l3tz46TxiCsD7v9NUaP0M3O/XvQi
	WEfagv0j72gWAAZfXK+KNL2A9+Sx0e15U316bpcK4oQZoJOafk1SKvhgvcs5hXgI/OcPKig
	zLgNju3pVqaFdI4H25QaznCQSl7PuHir7xIO6IssAfpgJrlA785HBDNvPXw8M5zseHSa6eC
	DI8J4fBDn/R
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

In txgbe_misc_irq_thread_fn(), the driver unmasks the miscellaneous
interrupt at the end of the handler using TXGBE_INTR_MISC(wx) (which
resolves to BIT(wx->num_q_vectors)). While this is correct for MSI-X
mode, it is incorrect for legacy INTx or single MSI modes.

Due to hardware behavior, the WX_PX_MISC_IVAR register is completely
ignored by the hardware when MSI-X is disabled. In non-MSI-X mode, the
hardware forcibly merges all interrupt causes (both Queue and MISC) into
a single bit: BIT(0) of the interrupt register.

Unconditionally unmasking TXGBE_INTR_MISC(wx) (e.g., BIT(1)) in non-MSI-X
mode means the actual MISC interrupt bit (BIT(0)) is not unmasked
promptly at the end of the MISC thread. Instead, it remains masked until
NAPI completes its polling and unmasks the shared BIT(0). This delays the
assertion of subsequent MISC interrupts, preventing timely handling of
events like link state changes.

Fix this by explicitly checking `pdev->msix_enabled` and falling back
to BIT(0) as the interrupt mask for the MISC cause when MSI-X is disabled.

Fixes: e37546ad1f9b ("net: wangxun: revert the adjustment of the IRQ vector sequence")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 8746318ad3bc..05b318f4e6ed 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -164,6 +164,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 	struct wx *wx = txgbe->wx;
 	unsigned int nhandled = 0;
 	unsigned int sub_irq;
+	u64 misc_mask;
 	u32 eicr;
 
 	eicr = txgbe->eicr;
@@ -183,7 +184,8 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 		nhandled++;
 	}
 
-	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	misc_mask = wx->pdev->msix_enabled ? TXGBE_INTR_MISC(wx) : BIT(0);
+	wx_intr_enable(wx, misc_mask);
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
 
-- 
2.51.0

