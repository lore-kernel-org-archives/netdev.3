Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022382;
	b=QpQlZQLKFFVMZcnG4bfRtfU1pjqDUHir9chEN/I0BR9UWM4WfmUpxd+kHCkI26XFiUvc
	 6WQiRcvuJ2Q8Tu1lCpMBFdfhtZLP0ydpq7sAQuI4BqCqhQFIKjS1Vn3JWvIeKytfPfQ0E
	 EmFeKP5DKpNR/pGsb2oCkbNCcg3P6fsKE7qCp2eDWF9qUufvHKex5nttutpvR0B3QaYjk
	 tA78iMP/3E0NSg9VsHlfCAck+srO/H0NDtTDwmaI5cHseKa81ily2JQb9n/G1a8G1PFls
	 tyBEECcJa+wwovFGt4zIkxh4tOAf+/X9a9ukOrjiAgYJG2S+hJhHxibfbJHRY44MX8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022382;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=WpOT74lSLRQb+MC1GsnJ7Tk0v7udp2z7rZsVwo7fCqk=;
	b=vNIrsGWSVs2NiFXu38rj39l+C6VLQ42qdteJQ+9v43p+xyvUqqVD6oadsnkzox4yKvXz
	 Fq9kerzqFkC+Q1H6qAvizMDjwOtOG9XARcFefQ4GQu7/ydidoXZduvKR2pT1j0lQJVLHk
	 xWzeXlDGmRC0rxN8eIK6vEDaNmW10h9nCy47Ui5ptT+yBju/D188UTOaEVb9w8CMtl+gk
	 EWI+be+7Ww6zm1V29nYehHWogwkMGbi6u8DPqwswuCUWmvbATPUsBhdE472L3zhttgEIS
	 M8QV0VwZYnUu3J1WbbGtVa2DC1FWyxvt5ZhOGMLGCBiZ2O+rsNtkZl2B+M3xtGOlzaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=kqV58FnF;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F6606A321;
	Mon, 26 Oct 2026 13:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961F6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=kqV58FnF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793022381; x=1824558381;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=trzj/5wD6SrtKjBh119k7eH5i9ToYRMakEcZ4SqhelI=;
  b=kqV58FnFZYloSjMpEnq+TbeJnvrrYDLQN/CqtZu7FCN8jKmSL46cuWh8
   XX/JPgHoXwIG3DdXo3C6rn24740nAqXvwK0Ke9MkqPeTXcjlCz7ofUacj
   HYSvT9fJyKTB2z8Qv2Yj6I5HLBZoRu2v+sqm7YQhP3c1jb3zl36T72KO9
   X9bdjQ/DX37DQHf+GG0nvOXimOXASZzBDvmnh4Qb4xwrXhWs52wFy/g2H
   rI4S3ibOB3pOb+C1BiG+aosibekGqKFj+N0/iLaqNq1OjMuBSRa1evsDw
   CbjBuN6DeNiE/vJYEU9u7HgE5/H4qDpm4CdcFnkTWuKDDaebg6trmUmla
   Q==;
X-CSE-ConnectionGUID: P74IImgOTCiU12CS7Fa/LQ==
X-CSE-MsgGUID: GbYuEHk8TFmI4s8cz3EU1w==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="64595100"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:46:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 26 Oct 2026 06:46:20 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 06:46:18 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 26 Oct 2026 14:46:15 +0100
Subject: [PATCH net] net: lan966x: do not inject uninitialised bytes past
 skb->len
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-lan966x-inject-tail-bytes-v1-1-51d599a48313@microchip.com>
X-B4-Tracking: v=1; b=H4sIAKZZ32oC/x3MQQrCMBBG4auUWTuQpBCMVykukvirI2UsSSgtp
 Xc3uPwW7x1UUQSVbsNBBatU+WqHvQyU31FfYHl0kzPOW+NGnqMG7zcW/SA3blFmTntD5ZBSDPA
 5m6ul3i8FT9n+74kUje7n+QMrD5DqcAAAAA==
X-Change-ID: 20261023-lan966x-inject-tail-bytes-9bba9e6cc081
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

lan966x_port_ifh_xmit() writes the frame to the injection FIFO one
32-bit word at a time, and pads frames shorter than 60 bytes with zero
words.

Before this patch, the last word is loaded whole even when skb->len is
not a multiple of four, so 1 to 3 bytes past the end of the frame are
read. For a frame shorter than 60 bytes those bytes are also
transmitted, as VLD_BYTES marks the whole last word valid and the
padding starts at the next word.

Write the trailing bytes from a zeroed word. The number of words written
and VLD_BYTES are unchanged.

Found by an AI code review agent. Reproduced on a lan9668 board with
register injection, by sending a
57 byte frame and capturing it on the link partner: byte 57 of the
padded frame was not zero. With the fix all padding bytes are zero.

Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index e4c9c5812ccab..c276fec2f9d6f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -263,9 +263,8 @@ static int lan966x_port_ifh_xmit(struct sk_buff *skb,
 		lan_wr((__force u32)ifh[i], lan966x, QS_INJ_WR(grp));
 	}
 
-	/* Write frame */
-	count = DIV_ROUND_UP(skb->len, 4);
-	last = skb->len % 4;
+	/* Write the whole words of the frame */
+	count = skb->len / 4;
 	for (i = 0; i < count; ++i) {
 		/* Wait until the fifo is ready */
 		err = lan966x_port_inj_ready(lan966x, grp);
@@ -275,6 +274,20 @@ static int lan966x_port_ifh_xmit(struct sk_buff *skb,
 		lan_wr(((u32 *)skb->data)[i], lan966x, QS_INJ_WR(grp));
 	}
 
+	/* Write the last 1 to 3 bytes, zero padded to a whole word */
+	last = skb->len % 4;
+	if (last) {
+		/* Wait until the fifo is ready */
+		err = lan966x_port_inj_ready(lan966x, grp);
+		if (err)
+			goto err;
+
+		val = 0;
+		memcpy(&val, skb->data + count * 4, last);
+		lan_wr(val, lan966x, QS_INJ_WR(grp));
+		++i;
+	}
+
 	/* Add padding */
 	while (i < (LAN966X_BUFFER_MIN_SZ / 4)) {
 		/* Wait until the fifo is ready */

---
base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
change-id: 20261023-lan966x-inject-tail-bytes-9bba9e6cc081

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

