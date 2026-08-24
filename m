Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BD41DDF0;
	Mon, 24 Aug 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579294; cv=none; b=X60IGmaMvijHDBFzcu5XGUAcue8jWiE/SSyNhcXZ01bAn3hpmK2QOUMBza4eKDKIoO9aLwzC9U0KzpmzS1ZxpDKFsdVw/Wcqd16hEjE4VpQ95Dx+qzRbfHrrIVhos6U72PQZxDuIjvHsAk1YbqEmDW7UVGBeSnaj/OPcGsqCPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579294; c=relaxed/simple;
	bh=8DWPLNCdFoid0lrHBjp1BX3lVstTJjGtc9rFCfu6ij0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1zuahNUM2U+uT3VIR/JSqzjfHQzylidkKyTX/ed/YW65XlFC6uFXkoXXW/0U85qZ8WhMx/e0VLu4ktd+WRZ4VaxVAQnx+jF1FMIDASyOvcn451SONJKjpg1Kv9txvex/gKd6wX6/xtHU4E6YwZX7h5j3z3agUUhU8caQZHjHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hfFGK/5/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="hfFGK/5/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D543CA8EBC;
	Mon, 24 Aug 2026 15:48:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787579282; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=99V48+zv/zX3Qd5TIfh/UeVVviG19hLeIcNQBWG1vKw=;
	b=hfFGK/5/GKgkRsfJMEoALNuLZrU3VlEyaY+oY3YtECyfPHS4aw0MuMtgeIGtrQaEN52dtA
	T/QgdgD+CzuWyjStkiKeqVpMzL6qoejo5Rjq70zBHFHCnoHpKBmG2vVbp96t4nS0c/L5SV
	9QF3F518sYWv+4xOMb79yjmdTUAY1esWYHL0NBn6nC1HVKMjPCid1rWZSpUhPoa1DMkWu1
	DR8C7WOe1DPlU8qjCGRQIu/I23RG8xoVdwG9Ijkv0zKZB4BDFwcldULnes7u6WAB78p/2E
	rBMpjL1RLaXA9g6pZ5jkCcsMu2CBKwBKzgbi3JOz3bxzmv9fIQB+bue63P3DnA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 2/2] net: macb: fix zero UDPv4 checksum on transmit
Date: Mon, 24 Aug 2026 15:47:03 +0200
Message-ID: <20260824134703.766708-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824134703.766708-1-nb@tipi-net.de>
References: <20260824134703.766708-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The GEM checksum engine writes its raw result into the UDP checksum
field, so a UDPv4 checksum that computes to zero goes out as 0x0000.
RFC 768 requires:

  If the computed checksum is zero, it is transmitted as all ones
  (the equivalent in one's complement arithmetic). An all zero
  transmitted checksum value means that the transmitter generated
  no checksum (for debugging or for higher level protocols that
  don't care).

Raspberry Pi confirmed in a simulation of the Cadence IP [1] that
the engine skips the final substitution exactly for UDP over IPv4.
UDPv6 and TCP come out correct. The IP changelog shows no related
change, so probably all GEM revisions have the same bug.

Clear the checksum offload features for UDPv4 frames in
macb_features_check(), the core then completes the checksum in
software. With ip_summed cleared, macb_pad_and_fcs() appends the
FCS and TX_NOCRC keeps the hardware off the frame. TCP and UDPv6
keep the offload.

One-step PTP sync packets stay on the hardware path, the MAC
rewrites their timestamp during transmit and would invalidate a
software checksum.

Link: https://github.com/raspberrypi/linux/issues/7550#issuecomment-5343018065 [1]
Fixes: 85ff3d87bf2e ("net/macb: add TX checksum offload feature")
Cc: Jonathan Bell <jonathan@raspberrypi.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 623d072a271d..f3548475f945 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -14,6 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/if_vlan.h>
 #include <linux/inetdevice.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -2373,6 +2374,16 @@ static netdev_features_t macb_features_check(struct sk_buff *skb,
 	unsigned int nr_frags, f;
 	unsigned int hdrlen;
 
+	/* The GEM skips the RFC 768 substitution of 0xffff for a zero
+	 * UDPv4 checksum, do those in software. One-step PTP sync frames
+	 * stay on hardware, the MAC rewrites their timestamp in flight.
+	 */
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    vlan_get_protocol(skb) == htons(ETH_P_IP) &&
+	    skb->csum_offset == offsetof(struct udphdr, check) &&
+	    !ptp_one_step_sync(skb))
+		features &= ~NETIF_F_CSUM_MASK;
+
 	/* Validate LSO compatibility */
 
 	/* there is only one buffer or protocol is not UDP */
-- 
2.53.0

