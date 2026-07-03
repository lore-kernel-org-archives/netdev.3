Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33823393F;
	Fri,  3 Jul 2026 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061478; cv=none; b=YXvXXXRTl8NBcIjtJsUWqDLnC7DAAzJ/vvmfGtKIKIwRxxa6CiGhyntiwxuQtpBlqabl6u+VnT13GGMReg9FfAuaIaDk3zj8gyBny6NA13MxittN6MkXwF+Kq6gUmQRQrJHcEOK6QJ5U/glruUKnucwXst6YLTpaji/72lGWa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061478; c=relaxed/simple;
	bh=S/m7wEGVPPuy/T0jA6cuudg3kG0H7utcE7QLoebxOpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LsBcGumEPEePTPCezra5Z8DCzIKumjJJONPV53EcNa30XzuXN+XvGfg5ggaXDgkuKzmebBMLbZiBErATdWIhLB5/8HLM2lT6ilPbI7fRYWIVBBolHSTiLOLoxPxj3Z5fekShLMNIXMUM9wxdGfD5mUELBO/DpElxq2k1TTfIhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=v58E5UHv; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="v58E5UHv"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 3B8B960D39;
	Fri,  3 Jul 2026 02:42:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783060934; bh=FapvGTAxBY2u9Vb3QN5cttB3cakXLqKSc2AEx2t5wDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=v58E5UHvFJENAgjqzhbhItSueRQtAwlwDDBzuq/GA6nbVi8KzPL+PvtRfVuauOhyL
	 me4pn8Qb6je6hoNLKkyTO1kbJhAj4YigFNPWkrpvHGvUWNn7/xkFaIF/tkX8Jk79/i
	 +ksY/hN6SFDGnsKJ9DJPFDYConu7jkKKJjDJeKYVZXTgBqF8WHnxxYpXG8uY53Yir8
	 z86js/VhqFtmdsYGdtLT4M+Wvi7EisqQ6jh11mzEg+sFyBG11lJ33zC3Pysv0pL6R+
	 rjH7TzGdVXNp70RZ0MZtHRv66vC0NBJ232XbBMbKNyZ0P8/qNRdM/YQkaWzpC/0R9p
	 WNVEmSdFo7WdA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 16:41:58 +1000
Subject: [PATCH net-next 1/2] net: dsa: mv88e6xxx: use ARRIVAL1 counter for
 all peer delay messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mv88e6xxx-ptp-fixes-v1-1-0138581889a9@padl.com>
References: <20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com>
In-Reply-To: <20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.deA>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783060925; l=2031;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=S/m7wEGVPPuy/T0jA6cuudg3kG0H7utcE7QLoebxOpk=;
 b=70QXdRfcw0nGZAhqzMMi415jIHcKLNENF20omCZYPx54YI5pGSoPBRXxYPGzHFjwYnfTnHVRt
 Lgc7qCuCddNDaN0DNrhxytHMLYTH/Wv6Kv2wMB1LMBGRcM2OGazEZzg
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
index 6e6472a3b75ad..57ff77496864f 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -319,9 +319,16 @@ static void mv88e6xxx_rxtstamp_work(struct mv88e6xxx_chip *chip,
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
@@ -343,7 +350,7 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 
 	SKB_PTP_TYPE(skb) = type;
 
-	if (is_pdelay_resp(hdr))
+	if (is_pdelay_msg(hdr))
 		skb_queue_tail(&ps->rx_queue2, skb);
 	else
 		skb_queue_tail(&ps->rx_queue, skb);
@@ -584,8 +591,9 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
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

