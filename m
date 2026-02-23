Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAE13D891
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837524; cv=none; b=JBvObYZQj44haEez8v9UlsfOVkgaQiYNe8BZiX/YjnlLwzE5xXVdXjujUdCyQYNSLuhTR0DHagDZKJLXIlP/Ta3jfm28qmmJ941Foh/GNp9GusariWkEuFnF1lk59IBw3HxdJJxxuY6PhOaIBrck7KGTQRrj/+OX/zdIn4XsC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837524; c=relaxed/simple;
	bh=CwORaJk4t7M/X37NmV5ecmhJNln7SvJ4q3TcqMgPzYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zk+ooIHGzYrkcHEFUqLMjYkYRJQa0J/Hy6f54xNOkhAM8ExDDCrg9WBKqwKfaNQ9V4bsyxR9a50QDBhUkITVyfuK0tpjKLL34nOvyshvYYfSeMWXDCx9lLoPW+wXwyWO1wd/FBVc15tifvDMYkTvA/7il8XxK2c/BE+PekciAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=KFUSXazX; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="KFUSXazX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BB91A3E6A;
	Mon, 23 Feb 2026 10:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771837521; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=msO9wIRe0eMZdl6b4a6WRDWlk64LVv74d2OouL9kFA0=;
	b=KFUSXazXtqO2F8fp+sfdYRL4uxfWzQujLiWE0Rd2z50ycnk8YREpOOpX0qQ7Lz0gRRdeGr
	toXuL11exrmLtZXvo/DtgF+94wuYadDozd5Dsa0oOp8xTIDvIMQDeeyS3+Ky/pnDGu147n
	H+CVT1pLBCAaBr8/kia2fUnhpn2VDWaLw50ubmxz69KxUxdFYRKTnWZwN3xdP2vdpqYDHb
	0UFqYpnB9aoW+VAz28PGIiKcFkSEMfHfAE9gj4G5lYJnXOAgYs1SaxtThLaAzn6ZxCz9KX
	qbcCz1ruz4yJSn5qCYuJ+G5kMlmXYIsl8Zo15OeP9oruE2vAQjD3XuBNEpAKVw==
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
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 1/5] net: cadence: macb: add EEE register definitions and capability flag
Date: Mon, 23 Feb 2026 10:04:08 +0100
Message-Id: <20260223090412.44070-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260223090412.44070-1-nb@tipi-net.de>
References: <20260223090412.44070-1-nb@tipi-net.de>
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
 drivers/net/ethernet/cadence/macb.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..f8fdb83bb5f3 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -170,6 +170,10 @@
 #define GEM_PCSANNPTX		0x021c /* PCS AN Next Page TX */
 #define GEM_PCSANNPLP		0x0220 /* PCS AN Next Page LP */
 #define GEM_PCSANEXTSTS		0x023c /* PCS AN Extended Status */
+#define GEM_RXLPI		0x0270 /* EEE RX LPI Transitions */
+#define GEM_RXLPITIME		0x0274 /* EEE RX LPI Time */
+#define GEM_TXLPI		0x0278 /* EEE TX LPI Transitions */
+#define GEM_TXLPITIME		0x027c /* EEE TX LPI Time */
 #define GEM_DCFG1		0x0280 /* Design Config 1 */
 #define GEM_DCFG2		0x0284 /* Design Config 2 */
 #define GEM_DCFG3		0x0288 /* Design Config 3 */
@@ -264,6 +268,10 @@
 #define MACB_MIIONRGMII_OFFSET	28 /* MII Usage on RGMII Interface */
 #define MACB_MIIONRGMII_SIZE	1
 
+/* GEM specific NCR bitfields. */
+#define GEM_TXLPIEN_OFFSET	19 /* TX LPI Enable */
+#define GEM_TXLPIEN_SIZE	1
+
 /* Bitfields in NCFGR */
 #define MACB_SPD_OFFSET		0 /* Speed */
 #define MACB_SPD_SIZE		1
@@ -779,6 +787,7 @@
 #define MACB_CAPS_DMA_PTP			BIT(22)
 #define MACB_CAPS_RSC				BIT(23)
 #define MACB_CAPS_NO_LSO			BIT(24)
+#define MACB_CAPS_EEE				BIT(25)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
-- 
2.39.5

