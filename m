Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45B5226B0;
	Tue, 13 Oct 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897561; cv=none; b=DjO3nR/cDQ1h+DNGRrc/ZNqudb3lccBKve81s+P4LBzUdwnn4DCquutQjB8LgGPEwvrEulBajXQ3/mOTHbMoGJeovlDKJMOwgJVvhTBUmSrrBplY5/yNJ6Oyw7kdZZCCGGPL12g1Dg1Xe2pzChBsQ4bw1ptc9TD5VnOlhxdoU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897561; c=relaxed/simple;
	bh=Tfk6ASw2D97opGupdPZpGBpVAzT5aih27ZwlLWgqw4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncR9rIV3tqTvLtcMGncjyCN/jnvYn9IffrXSkM+1o7XKrtjKKa05TioUwPaCiC8YCHs20Nok7yxKV2sq9iuS1Y88UTHcv87/Vyf0n3X4TUhoUBp1H1mS4tIAXpMGpVGyDFccywkQN3BgUloc4BLS3J7V0625I0SIuoLcux3QKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1IDWL6s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1IDWL6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BC91F000FF;
	Tue, 13 Oct 2026 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897560;
	bh=wZjqdPGTKoWdtYJbiljXoaPlgWC1g1neL5EXZ4ZgKoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N1IDWL6s+oVpHifCp4DZcbQm7bsIOtyHBt3OW2BkA3d08T76IRpajE5GiMu4M+C3Z
	 PfMhefQT3IE1nTsSozNr0g03croyVL/Q1C/BQM6OheP4wMu0d3fFlqlaDc67+UomqL
	 zMW7qVNC5DtsT+Y516kPeGUZx/YH7hpJqpWRHGOfBL208jfhnA2wVczIKhUDKYzCvL
	 g3EY5OjHle0Q+aqucsc0X8lr4NzLe6aKA/+UKJSS96P8gr2rzPJPyyUcfL2mHGQMAa
	 2JE4s8REvDUpuk5g45Xcnn72t05C7Fq+LIsDS88uQe9/4gGUa3OUk3OlhVYkGY7eS/
	 QDJ/3c2zkvAYw==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 25/53] net: ethernet: sgi: ioc3-eth: apply the DMA attributes only to 64-bit addresses
Date: Tue, 13 Oct 2026 15:16:45 +0200
Message-ID: <e50be000dff9fd63e6b1817ecbb3f96aa4f7a941.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Bridge 64-bit direct-mapped DMA address carries the target widget and
the DMA attributes. An address in a bridge's 2GB 32-bit direct window
carries neither, so attributes OR-ed onto one form a 64-bit address
aimed at widget 0, and every receive raises a PCI error.

Apply the attributes, and the RX barrier's upper address bits, only to
64-bit addresses, so the IOC3 can use the 32-bit window behind an XBridge
or PIC.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 009f37105eaf..f86dd192a3d3 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -152,19 +152,38 @@ static inline int ioc3_alloc_skb(struct ioc3_private *ip, struct sk_buff **skb,
 }
 
 #ifdef CONFIG_PCI_XTALK_BRIDGE
+/* A Bridge 64-bit direct-mapped DMA address carries the target widget in
+ * bits 63:60 and the DMA attributes below it.  An address in the 32-bit
+ * direct window, which the IOC3 uses behind an XBridge or PIC, carries
+ * neither, so attributes OR-ed onto one form a 64-bit address aimed at
+ * widget 0.
+ */
 static inline unsigned long ioc3_map(dma_addr_t addr, unsigned long attr)
 {
+	if (!(addr & PCI64_ATTR_TARG_MASK))
+		return addr;
+
 	return (addr & ~PCI64_ATTR_BAR) | attr;
 }
 
-#define ERBAR_VAL	(ERBAR_BARRIER_BIT << ERBAR_RXBARR_SHIFT)
+/* The RX barrier's upper address bits follow the same form. */
+static inline u32 ioc3_erbar(dma_addr_t addr)
+{
+	if (!(addr & PCI64_ATTR_TARG_MASK))
+		return 0;
+
+	return ERBAR_BARRIER_BIT << ERBAR_RXBARR_SHIFT;
+}
 #else
 static inline unsigned long ioc3_map(dma_addr_t addr, unsigned long attr)
 {
 	return addr;
 }
 
-#define ERBAR_VAL	0
+static inline u32 ioc3_erbar(dma_addr_t addr)
+{
+	return 0;
+}
 #endif
 
 static int ioc3eth_nvmem_match(struct device *dev, const void *data)
@@ -727,7 +746,7 @@ static void ioc3_init(struct net_device *dev)
 	readl(&regs->emcr);
 
 	/* Misc registers  */
-	writel(ERBAR_VAL, &regs->erbar);
+	writel(ioc3_erbar(ip->rxr_dma), &regs->erbar);
 	readl(&regs->etcdc);			/* Clear on read */
 	writel(15, &regs->ercsr);		/* RX low watermark  */
 	writel(0, &regs->ertr);			/* Interrupt immediately */
-- 
2.47.3

