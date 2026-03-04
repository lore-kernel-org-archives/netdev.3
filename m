Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B953A5E7E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621703; cv=none; b=hqV7I0EXo2LZQAsApdLxMSisHsCKffvUXIcnvUBy6UgYnXBfiYO8Xm2OvCeQN5sQtiutNX+voMHAS6pOsVtFlWpbVWNWIVs2D30AxBbVk+FsRRW8hFoT/99beWH0V/pmywXnjN2ElUT2Sg7sEEhwBKHgNlKMJxehgAS+bdVW4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621703; c=relaxed/simple;
	bh=JWGEpJNHlsLc7t3kOVDUNv9bWoZ/sBbzJB9wzkk3WFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac/7Xp0uGRC8rnXIZZkPR5Lo4lxA71sM3OfSuedxQT45tW7PJiDD7nmFrHt1xQvn7XU4tocS5hVvCRVq0w647XCfTdCh8oxOvWpvuT2QB4+t4cbkIq6d+HRzA/8hgIAMulFxLrzbCIoCBZV2swiIbsdKN8y/X1urezN3QWgA6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=bMJ14Fko; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="bMJ14Fko"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BCDBA4F9F;
	Wed,  4 Mar 2026 11:54:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772621696; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kHGKjjf1wvnkVI2pQ6u4mOXMsDYTrygYaHLk1VbRwX0=;
	b=bMJ14FkoyYymt/O21vosGOcjadaKwX+oZQj6wco2/i76vCrlJwUVQap3SSl7Q1rD2qtqke
	I1Kbj3B85ii6x6XBRgfIs5wy8uwdMSAs9O1N5IRcekPH6bVn2Hy2H8MAxPPky8Tyi++YIk
	GFnssurMNe36rIKuLs1Bm3dQuYc6rbUMsn+yWTctEZHPw75OdBsKgv5VqH1MbMIf2Zjsj0
	yWOQk1f+yMIec88qsMUQszx4HyD/V2wQMDDynTlE+BuOe8r9tzAujOrH5IoXLjPaCZK3G4
	5GqQ0AEsMD90KRoMFhn60CyDjwaZpBzWdfN6k4+ODcUkFORRmCoB56m9dK2Mfw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v6 1/5] net: cadence: macb: add EEE LPI statistics counters
Date: Wed,  4 Mar 2026 11:54:28 +0100
Message-ID: <20260304105432.631186-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304105432.631186-1-nb@tipi-net.de>
References: <20260304105432.631186-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The GEM MAC provides four read-only, clear-on-read LPI statistics
registers at offsets 0x270-0x27c:

  GEM_RXLPI     (0x270): RX LPI transition count (16-bit)
  GEM_RXLPITIME (0x274): cumulative RX LPI time (24-bit)
  GEM_TXLPI     (0x278): TX LPI transition count (16-bit)
  GEM_TXLPITIME (0x27c): cumulative TX LPI time (24-bit)

Add register offset definitions, extend struct gem_stats with
corresponding u64 software accumulators, and register the four
counters in gem_statistics[] so they appear in ethtool -S output.
Because the hardware counters clear on read, the existing
macb_update_stats() path accumulates them into the u64 fields on
every stats poll, preventing loss between userspace reads.

These registers are present on SAMA5D2, SAME70, PIC32CZ, and RP1
variants of the Cadence GEM IP and have been confirmed on RP1 via
devmem reads.

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..19aa98d01c8c 100644
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
@@ -1043,6 +1047,10 @@ struct gem_stats {
 	u64	rx_ip_header_checksum_errors;
 	u64	rx_tcp_checksum_errors;
 	u64	rx_udp_checksum_errors;
+	u64	rx_lpi_transitions;
+	u64	rx_lpi_time;
+	u64	tx_lpi_transitions;
+	u64	tx_lpi_time;
 };
 
 /* Describes the name and offset of an individual statistic register, as
@@ -1142,6 +1150,10 @@ static const struct gem_statistic gem_statistics[] = {
 			    GEM_BIT(NDS_RXERR)),
 	GEM_STAT_TITLE_BITS(RXUDPCCNT, "rx_udp_checksum_errors",
 			    GEM_BIT(NDS_RXERR)),
+	GEM_STAT_TITLE(RXLPI, "rx_lpi_transitions"),
+	GEM_STAT_TITLE(RXLPITIME, "rx_lpi_time"),
+	GEM_STAT_TITLE(TXLPI, "tx_lpi_transitions"),
+	GEM_STAT_TITLE(TXLPITIME, "tx_lpi_time"),
 };
 
 #define GEM_STATS_LEN ARRAY_SIZE(gem_statistics)
-- 
2.51.0

