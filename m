Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6293DEFFE;
	Mon, 27 Jul 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124784; cv=none; b=aNqTOBEIE+2f0oBe43n2o7a8IeQKTUgONOMz12UHHQl/JyteGHY1vekVj8m4vV9qFYgPLx9XJmZSbmLUIzoNDsOD708eQL563t0ddZSWtuAICIwP3Ayss/Znwr86tyyGSamsV6N7W8k7g9lO+YcArksV6sCOw9VKbAd16FvNlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124784; c=relaxed/simple;
	bh=wCfxgErhzZkjcA9+yD3lKGRQ1vh3Zp0pgx9oWbvLZAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovFKHUWT+c+JZM/MNI/kSMJRqHL6l1P7P1DHRyNa0ZSGEgLm1whCA9OZYmk1659wpenRCMInkFos36/WOJRcNxnjdTuub1916uau28vhWt6BjIdO3kRIsqe6g6EEOxTLJTrrnoBzsvNSHCmY9FW1pv+oipddbstRBH859HhBazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=HEQXZFsH; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="HEQXZFsH"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 626C56227C;
	Sun, 26 Jul 2026 23:59:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1785124777; bh=47023XEFQ9ph2HePpdoqHS701MsGITqkFgVF0aHCvlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HEQXZFsH0z0py3lL6YFDckIRUQASXNkVW1G/TyLetw9l6EZr1hmnzfxeY/O89z/e2
	 q9CS+P2obxu2J4fvc7n2I+bny+OJEYoLSkBku3ShZrdREyPKrALJkN4A5e3ReyXZvg
	 gwf3qg12FI6/EdizwlfKMdkANj5PQ/jmtP06YGWxt1LW4WQdRBvrbxUYzuN5wuvU3I
	 OO8oaBvfO+i1dqcf3+Ostx5/LLpGaADxST1nQJ7etIL/svOcRbD4yRlVko90n63+Wg
	 YabwI+f9ZImMSr0SKMB69/bHpzSWXlEkWhxJioXtCrUNa6KbJfG5MFc3/ZRWXiNqCM
	 VCEPGx3emlS0g==
From: Luke Howard <lukeh@padl.com>
Date: Mon, 27 Jul 2026 13:59:13 +1000
Subject: [PATCH net-next v4 2/5] net: dsa: mv88e6xxx: use ARRIVAL1 counter
 for all peer delay messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mv88e6xxx-ptp-fixes-v4-2-10b4020155fc@padl.com>
References: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
In-Reply-To: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785124760; l=2031;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=wCfxgErhzZkjcA9+yD3lKGRQ1vh3Zp0pgx9oWbvLZAk=;
 b=F9tmRm1mqiNs3zegWDhnsiUH8RZAmS5RniXDW12TDTaL9ko9avaEQ+19cM7KgaGZj+eQWfK71
 5a4r4lqawwYCHyhgor47oQuKoEwsx17SKUDtXbWWili0Ul0AJvuH4s2
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

mv88e6xxx switches have two arrival timestamp counters for timestamping
PTP event messages. This permits more than one arriving event message's
timestamp to be captured. This is useful for the case where event
messages from a grandmaster arrive at the same time as PDelayReq/PDelayResp
messages from a peer.

Previously only PDelayResp messages were assigned to the second arrival
counter; this patch does so for PDelayReq messages as well.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index e4326165e1896..d468d988b258c 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -323,9 +323,16 @@ static void mv88e6xxx_rxtstamp_work(struct mv88e6xxx_chip *chip,
 				   &ps->rx_queue2);
 }
 
-static int is_pdelay_resp(const struct ptp_header *hdr)
+static bool is_pdelay_msg(const struct ptp_header *hdr)
 {
-	return (hdr->tsmt & 0xf) == 3;
+	switch (ptp_get_msgtype(hdr, PTP_CLASS_V2)) {
+	case PTP_MSGTYPE_PDELAY_REQ:
+		fallthrough;
+	case PTP_MSGTYPE_PDELAY_RESP:
+		return true;
+	default:
+		return false;
+	}
 }
 
 bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
@@ -347,7 +354,7 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 
 	SKB_PTP_TYPE(skb) = type;
 
-	if (is_pdelay_resp(hdr))
+	if (is_pdelay_msg(hdr))
 		skb_queue_tail(&ps->rx_queue2, skb);
 	else
 		skb_queue_tail(&ps->rx_queue, skb);
@@ -588,8 +595,9 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	/* Use ARRIVAL1 for peer delay response messages. */
+	/* Use ARRIVAL1 for peer delay messages. */
 	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
+				  MV88E6XXX_PTP_MSGTYPE_PDLAY_REQ |
 				  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);
 	if (err)
 		return err;

-- 
2.43.0

