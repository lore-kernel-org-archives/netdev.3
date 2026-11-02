Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607022;
	b=YyWuO9CbcH8f4GJrfpq+bM66F/w9nUFPgLWFSnrLx1WtNIhJ697u+So2chNEVfq9V8DQ
	 TJ7HlYbVaaExZdl7tNdMqBpy7FE9Aals33j8MbB9DIcm7FGMiAX10uF5HInZzvTSjMW52
	 jh4vWTs1rECoaFySAlz1F++JeWLPYZFPsk1Lw712f/JOPqDdyTm97YSzvDESeXFhnxMDF
	 FPFVwwjed99HUj8EF/G6dMJgyYroV8qSQN1bXDv7di0HnSD1d7B29TLaOtsjCyvWGJRdP
	 ldpeuHK/rMDbhfuBoDb0VDl/hN1exZwu+iOG97QwJWda+1LgHbu9++Iq6biTIiNFWmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607022;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ysgu5v3eB4ToaKQ09/3znJj2IM+I6eUAuOt4TqVE94w=;
	b=WRkMgRGCuD3iWk5gNg8eubV/Nw+txpvi9Dr6Zjrd+Lwe5/Sc01AEoURVglseR9H4ihFU
	 TqW/ygsJmZpilxvp+xvep7VWxiPDLhHXlW5F0L73qBfr/8BiylhvTIBbXJER0+rQlMEjc
	 ITzaiImmi6kquxXF+3/Bf0SMfwzSbnXldQC30w87IwJm4BbKKMYSaKhU9AOkEov6wH3XL
	 hGfcZCR2ZSGqBrR/cn9apDBX/HjnXOeffjJ3V+/bXcRIFcmcnWkTW1Z8fVNBTwurBKwwh
	 p8UdVY4pKr5SyRSoQdR/D452CYEnhox+598CCzO5c0HpkCTdl2Kl9+g8N4RzRsy4QWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=0b5DIR22;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC77606A324;
	Mon,  2 Nov 2026 08:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAC77606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=0b5DIR22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1793607020;
	bh=grCTlBxrI9QvxJqQg5lsXzodkISaca8fxUUkda8novc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=0b5DIR22zqTZl3Za56pRR/PekIahY9BVK9nCQSB1jiIx+FdsN0ca0gimJ5evBju6D
	 0Pf//CGM9LsGSYk/y3STMlK6sv6Xy4Q9cFup6ioK8ZejLtHMMhDuYnfTpFsZwsw30V
	 OszqDWltgcVFgSF3anb9Cr/qIrH53WjE3S/xQ+DbR4TvwUJmXRAK6Pme6epwngqGcS
	 Fe3Tec4xsEwDX4Hke0KgnWuUVHvMtcXt1ImlTm+UR8zQlpthm3yV0Pb5zgeMw2NN8/
	 bEu3iV4JKovrvK4dIjzOrj4Ejmjv//hXgt81sjtgUyEnlbQzR01DpKDm6+5+hc67lx
	 QqlGyfcNs0How==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 7572480E76; Mon,  2 Nov 2026 08:10:20 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: Yao Zi <me@ziyao.cc>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: stmmac: dwmac-motorcomm: mask the MISC interrupt
Date: Mon,  2 Nov 2026 05:09:38 -0300
Message-ID: <20261102080938.2955-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
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

motorcomm_init() writes 0 to MGMT_INT_CTRL0, which unmasks the MISC
interrupt. MISC arrives on MSI-X vector 5, which stmmac requests as its
MAC interrupt, and nothing in stmmac clears it. The vendor driver masks
it.

Since commit 1b9707e6f1a9 ("net: stmmac: enable RPS and RBU interrupts"),
heavy RX load sets MISC and it never clears again, even though every
status register I could find reads zero. Vector 5 then fires about 120k
times per second and the machine stops responding until the TX watchdog
resets the adapter, or does not recover at all. A 64-byte UDP flood
from another host is enough:

  iperf3 -c <host> -u -b 0 -l 64 -R -P 4 -t 10

Mask MISC, as the vendor driver does. I could not find anything else
that depends on it here: EEE is not supported, and Wake-on-LAN uses PME.

Tested on one YT6801 board with net at cb284914e749. Without this
patch the flood above hangs the board within a second. With it, no MAC
interrupt fires under that flood or heavier ones, including after link,
ring, MTU and speed changes and a module reload, and throughput is
unchanged. Suspend could not be tested. The register values were read
with a debug build of stmmac.

Fixes: 02ff155ea281 ("net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller")
Signed-off-by: Magnus Leatti <magnusleatti@kernelriot.com>
---
Russell, d3265c19b35d ("net: stmmac: xgmac2: disable RBUE in default RX
interrupt mask") describes a similar storm on xgmac2. Should dwmac4 do
the same? I have only tested the glue change.

 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
index 124fcd55a..610d533b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
@@ -30,6 +30,7 @@
 #define OOB_WOL_CTRL				0x1010
 #define  OOB_WOL_CTRL_DIS			BIT(0)
 #define MGMT_INT_CTRL0				0x1100
+#define  MGMT_INT_CTRL0_MASK_MISC		BIT(21)
 #define INT_MODERATION				0x1108
 #define  INT_MODERATION_RX			GENMASK(11, 0)
 #define  INT_MODERATION_TX			GENMASK(27, 16)
@@ -172,7 +173,11 @@ static void motorcomm_reset(struct dwmac_motorcomm_priv *priv)
 
 static void motorcomm_init(struct dwmac_motorcomm_priv *priv)
 {
-	writel(0x0, priv->base + MGMT_INT_CTRL0);
+	/*
+	 * Nothing services the MISC source, and once raised it never
+	 * deasserts, so keep it masked.
+	 */
+	writel(MGMT_INT_CTRL0_MASK_MISC, priv->base + MGMT_INT_CTRL0);
 
 	writel(FIELD_PREP(INT_MODERATION_RX, 200) |
 	       FIELD_PREP(INT_MODERATION_TX, 200),

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.54.0

