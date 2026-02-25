Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C9387361
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011003; cv=none; b=BcBtTs9PwUFPZxlGe5XvP08/GjDNJJPHiG1sZCwYKiZpqJ267TaobPpYYgYfxJCRKwrZ//K0KOXdo7qmIkZKj6VP2W8897krLarmESMsjDaK6hpuyYWBWtxT7ibv8dWXX2kO62N9gYxyUXIYFZ28NgHugGoVNGRflkYyiDn8Dos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011003; c=relaxed/simple;
	bh=Lw5PO5FUMSxJvJUyOGgj9zsv+1kml1xiUFsh4F5NiZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqB26yAe2A18ssdhJC7pCkeZg7OLOVE8wGqwTIAd6afb6TgPxxcob8Uj8PFYqjHuFmsqhWzZYNRmX+DA+oDxeudHbRjKjs/jl7BZP7MQeDfS6O4TiKFHfEEufB3jWdOtCyVXAXtktteef2p6DEY4pudsxTsl/MxkT5eVY6bTiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hzQyRRhx; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="hzQyRRhx"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CAE9A3F77;
	Wed, 25 Feb 2026 10:16:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772010996; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GKw5TM2U60IlvGW7WqGbWJVMzu0vjPwT1qos5LagtiU=;
	b=hzQyRRhx/AEgzstE5/2oZDIARfBo3FPc5yOnnZveeL0sJk9112zif3GSNERNc+MczHHhiB
	bAn993Ag9iI+u+B7VCDBF5Uwl3D+X+cf4qjatP8qzbwwUQYgOF67LvpA/6bsi5B3QBwJlB
	K7pZQtl7XWXKonO06hhJ/3Wx0YxMtoyDTxNXyj6SP9LemLj62JAx9vA1sLJ2bAPmAdNxcV
	Vs9EC6iVei/Y359jBbCtPZfVwXBAiWuPNJ9GCEJoiuT2jYRlERK54evMwZPxvQ+lj1kUY1
	gsoJf+9HEXRo2nBDkV1YQdTBVL71jK+o7JpcRE4fConEFrwoi/WClUmPcBjuBQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH 1/5] net: cadence: macb: add EEE register definitions and capability flag
Date: Wed, 25 Feb 2026 10:15:54 +0100
Message-Id: <20260225091558.51157-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225091558.51157-1-nb@tipi-net.de>
References: <20260225091558.51157-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add register and bitfield definitions for the Cadence GEM MAC's
IEEE 802.3az Energy Efficient Ethernet (EEE) support:

- LPI statistics counter registers (GEM_RXLPI, GEM_RXLPITIME,
  GEM_TXLPI, GEM_TXLPITIME) at offsets 0x270-0x27c
- TX LPI enable bitfield (GEM_TXLPIEN) in the NCR register (bit 19),
  which directly asserts/deasserts LPI on the transmit path
- MACB_CAPS_EEE capability flag to gate EEE support per platform

These registers are present in all Cadence GEM revisions that support
EEE (verified on SAMA5D2, SAME70, PIC32CZ, and RP1 variants).

No functional change.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..729751d424c2 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -170,6 +170,10 @@
 #define GEM_PCSANNPTX		0x021c /* PCS AN Next Page TX */
 #define GEM_PCSANNPLP		0x0220 /* PCS AN Next Page LP */
 #define GEM_PCSANEXTSTS		0x023c /* PCS AN Extended Status */
+#define GEM_RXLPI		0x0270 /* RX LPI Transitions */
+#define GEM_RXLPITIME		0x0274 /* RX LPI Time */
+#define GEM_TXLPI		0x0278 /* TX LPI Transitions */
+#define GEM_TXLPITIME		0x027c /* TX LPI Time */
 #define GEM_DCFG1		0x0280 /* Design Config 1 */
 #define GEM_DCFG2		0x0284 /* Design Config 2 */
 #define GEM_DCFG3		0x0288 /* Design Config 3 */
@@ -305,6 +309,8 @@
 #define MACB_IRXFCS_SIZE	1
 
 /* GEM specific NCR bitfields. */
+#define GEM_TXLPIEN_OFFSET		19
+#define GEM_TXLPIEN_SIZE		1
 #define GEM_ENABLE_HS_MAC_OFFSET	31
 #define GEM_ENABLE_HS_MAC_SIZE		1
 
@@ -779,6 +785,7 @@
 #define MACB_CAPS_DMA_PTP			BIT(22)
 #define MACB_CAPS_RSC				BIT(23)
 #define MACB_CAPS_NO_LSO			BIT(24)
+#define MACB_CAPS_EEE				BIT(25)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
-- 
2.51.0

