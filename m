Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE736A014
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924749; cv=none; b=OTFlQ+/8vOwyp1XH/rH0NTa9oNDUqE+fGp6IB19RVyIDISNHK1b+R3GaGTKRGZ4QHoE5f5x2HhC1VA6lDtZMbywjtfq7wKyp/q2wTC3MY0wFJ7l0cHB4jVjeICf5/YCnzM6Woo55jYp2EvQpuFLkaqv8xbLvNCigadJFbcWNvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924749; c=relaxed/simple;
	bh=Lw5PO5FUMSxJvJUyOGgj9zsv+1kml1xiUFsh4F5NiZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPrK7mDnWYFEwLbqUEhfNdDgE0aDD0ebATCZ4+msEuwHKq4CO/4b7UMK6bjK9nBLYA3AZ4nqDvhcrPg7jf4EIWRqfecYt3iGaKZrkmGBHE2dHnZ1EtGvtUOCowFi8v5iN0XJLqnCLGsfN8tuYCOKQJw68z7eBHKqwfXnXSn7eS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=zJIJ7rWe; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="zJIJ7rWe"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41434A3E6A;
	Tue, 24 Feb 2026 10:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771924737; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GKw5TM2U60IlvGW7WqGbWJVMzu0vjPwT1qos5LagtiU=;
	b=zJIJ7rWeY8CyxRrjOPM1s575FIGopjVrKT6UtGvkzkW/Ji5T+S2PBJNDruA2m9gEnjdpTI
	T5pw/AR8mxtB6psLud4N93F/nOqTMG4pvT/7LttrhZYzOIBaR5K6m9CzaV9v4zi72Rjk6H
	yk0GvAL62YsSrAvcboPeyFsD6m43vaPIGT19VfoRV+JYfP4W739bl7lu9kKCrZF6iarhIs
	oF/DDDcKc1pGZ2iIGnl2yIZ9B7A+4JC1GS1GgI617KQka//L/HwUlfH0hRVMei+D5W6U4H
	muqieoYUt+XdJn7z/7kIzQSefue/pB6mfD80U0gexJWHvLj2ZWPM97Yu4wZDkQ==
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
Subject: [PATCH net-next v2 1/5] net: cadence: macb: add EEE register definitions and capability flag
Date: Tue, 24 Feb 2026 10:18:17 +0100
Message-Id: <20260224091821.47671-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260224091821.47671-1-nb@tipi-net.de>
References: <20260224091821.47671-1-nb@tipi-net.de>
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

