Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236BA531AEF;
	Thu,  1 Oct 2026 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871241; cv=none; b=YvvU6e8ZBHXCSebAptlLsN/BMX+dcvjEhYuBJnVlWF1zi21qqgMV396qbNgl3qhaLnIFNabpOL42SAqcZILpeZ4icFP7tJUNP/eOoA4dYZEIu3MI6vvoB2k7L/aoYma4b5kclzPbqi3MewPbc64kvJM3XWeUYhJAbFRGYIfgkJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871241; c=relaxed/simple;
	bh=F+1UaVLDAOjB+FzB41F17QFGQeYKIHv5Thi7o0zcKIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMhFpfg4WsZuIpw4Vkz+wSnmJBPYFdan8JRPAz3SsxOe0Eq/I0BQPdtR5FNgZEHhBJjA+bZ89SYAwgYFOwCG8YDgXGqvQKemHZQgvQzHEGOqsmgXJG/LwWaX7gnpCz8CWvB6qqQ2kwumyQ0yEYur8ZADgIN0SgmTMJR3enqnUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6J9zy7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6J9zy7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519681F00898;
	Thu,  1 Oct 2026 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871239;
	bh=Mxqxt53Wv27u59MDQfKrGHETlQ9HTT6+jnccS9oxZhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P6J9zy7rcklpL/QLYO18U0R5RZS4vjJb2ljU84xlbOqGrJW1D9qiNm6qOTYYrlJ51
	 bmj1gIw3Xa7Lj7ydt51chdBpkBZiLgcPi3UjrSifsUPr/RuIQeF2sabBS5vgu0kQLB
	 zBjQh8SOYt/n+5D5JPDDuMoasreeIAr0HOimfXJivhT/rTpuLYQY9J47orHKctk9ha
	 nZ2sBinTyNL4weJ2OhZw1VRlAdKwMpdjWB+LcH42J/yM0Xv6W34U8Jpfg1/6Y0RKyW
	 HDanWCRHH2M5zHpe9HqVgarlrHNUqPbGx3whGsE5ZwU7AlfXCgKIej3hZols6cpBls
	 xQ6PEw5652J6g==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 20/38] net: ethernet: sgi: ioc3-eth: apply the DMA attributes only to 64-bit addresses
Date: Thu,  1 Oct 2026 18:11:55 +0200
Message-ID: <42a71ea9aa16afdeb230d4d8c61c33cc055f2a28.1790857966.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790857966.git.kaloz@kernel.org>
References: <cover.1790857966.git.kaloz@kernel.org>
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
64-bit addresses, in preparation for driving an XBridge through its
32-bit window.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 009f37105eaf..8702dfdf4c36 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -152,19 +152,37 @@ static inline int ioc3_alloc_skb(struct ioc3_private *ip, struct sk_buff **skb,
 }
 
 #ifdef CONFIG_PCI_XTALK_BRIDGE
+/* A Bridge 64-bit direct-mapped DMA address carries the target widget in
+ * bits 63:60 and the DMA attributes below it.  An XBridge is driven through
+ * its 32-bit direct window instead, where an address carries neither, so
+ * attributes OR-ed onto one form a 64-bit address aimed at widget 0.
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
@@ -727,7 +745,7 @@ static void ioc3_init(struct net_device *dev)
 	readl(&regs->emcr);
 
 	/* Misc registers  */
-	writel(ERBAR_VAL, &regs->erbar);
+	writel(ioc3_erbar(ip->rxr_dma), &regs->erbar);
 	readl(&regs->etcdc);			/* Clear on read */
 	writel(15, &regs->ercsr);		/* RX low watermark  */
 	writel(0, &regs->ertr);			/* Interrupt immediately */
-- 
2.47.3

