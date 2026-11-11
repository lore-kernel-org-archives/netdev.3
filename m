Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390786;
	b=RL595cG/S+TI/dEAWeKbGoWLBCvFY3wcJDKZbkSJ5cmFC9gS/L61k609wfDUk1OxWubk
	 gRuWhKIQ69ZwPGQM1pZmd5vGaBRKbdKU/FKyQrbYqlEhGJVru7CTYH6Zl//9UegymTGfL
	 KZvkX/dIJfdsX0a1Y25GiLRnRCoSKtMi99ulp/b5fz2NTB4+5m1t4xtlJfRm6OIg6piAg
	 X2syuGHxwDL4XydcjLU4FK4v4kH1bNuV6a474D6EQfN8gzuPTqWmjz1iWSmUVZQECD4dD
	 mJcZ8sd5CfX8vZaHLNAccTO1J5XZK94FzDEg72GbtZF8e5M+bk50FLp9XU7nu0Lb5Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390786;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XT6BWjf3e2H2CZG/NlymA92TO1byQpSSnVJi47YMPVw=;
	b=WZfiFeBPQJafZCGOsMsU0b82iDYbXZtwKcM/1SMliSobkFsCcYAuaFXaa+EE3VKtTuGC
	 dnHNHaRcgB2NoONUNv4REsINyAtQLRcPHQ16hV40zuqekcZbvngznX9YVaeF/Tn8+YeBE
	 pseP24hwb0m7KAWuT2m/K4bJDbpwmrdp07aNYwvGA+4/ieQI8ENjO/A+pTNYf7+7QETon
	 3NNYMkSlVsoVzynyz1JljaKDfLrfSDGLLMaKSO3j08tavL7n5EhsueyWiUoNLAHxbC0Sm
	 0/OlnVusMMSSduEv2B9wpgeJtHCjaG5m8QDBwKad6ONYmsZgmD8nPcqdsgOSraO3ltw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Edvf/VAz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BF606A33B;
	Wed, 11 Nov 2026 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Edvf/VAz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8624D1F00A09;
	Wed, 11 Nov 2026 09:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794390785;
	bh=XT6BWjf3e2H2CZG/NlymA92TO1byQpSSnVJi47YMPVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Edvf/VAzHbtYaB6SGLqNNuQrY6tn2AxZui0ULEp46nZrw4K3zZk9Wu6J4oQsRvuPf
	 TVUEnJ44FOaTXZWgB7PMlbbkrnLSq5ulB+MOuffoMo+m93hsJiQ0CBT2wN6GwYSW0R
	 ym+Z+mITLcZEE84igwJOXX5sScBa2MDCBqPC9SCjKxBuxXs9SzgUlMSA9Pn10senYg
	 F/rWKYIRZdflDZyjj5V8A6S5aBr2KxFNeUvtRlDFm2ZIU++Z9EXBi6PwlRdcD8+lxS
	 HbV+AY1bfvxBgM7TT1r9gG7PXwpwNJEFABMlwmTE1q/d22XSCVt7itKVw93iPu1ZBs
	 +bayyvWeaJX4g==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: sgi: ioc3-eth: apply the DMA attributes only to 64-bit addresses
Date: Wed, 11 Nov 2026 10:51:37 +0100
Message-ID: <20261111095138.1757-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111095138.1757-1-kaloz@kernel.org>
References: <20261111095138.1757-1-kaloz@kernel.org>
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

A Bridge 64-bit direct-mapped DMA address carries the target widget and
the DMA attributes. An address in the 2GB 32-bit direct window carries
neither, so attributes OR-ed onto one aim it at widget 0, and every
receive raises a PCI error.

Apply them, and the RX barrier's upper address bits, only to 64-bit
addresses. IP27 and IP30 give the IOC3 64-bit addresses; behind an
XBridge or PIC it can use the window.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
Previously posted as 25/53 of the IP35 series v2: https://lore.kernel.org/all/cover.1791890466.git.kaloz@kernel.org/

 drivers/net/ethernet/sgi/ioc3-eth.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 009f37105eaf..25139cf5ff62 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -152,19 +152,37 @@ static inline int ioc3_alloc_skb(struct ioc3_private *ip, struct sk_buff **skb,
 }
 
 #ifdef CONFIG_PCI_XTALK_BRIDGE
+/* A Bridge 64-bit direct-mapped DMA address carries the target widget in
+ * bits 63:60 and the DMA attributes below it.  An address in the 32-bit
+ * direct window carries neither, so attributes OR-ed onto one form a
+ * 64-bit address aimed at widget 0.
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

