Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E992DECBA;
	Sun, 19 Jul 2026 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784439074; cv=none; b=MhEvb5SzhYO9MYFAY1tAB09SL6H7jJhIv4jrBjZ20T5GUtH/3Qg02ybwXgUOvWaojZRRbS12ic+yPS267vegmf4NS0IzrxOnAtSSSxBBfop1AtUsToOXoXNwGs7YXaj3JMotjZ7qasN6yhGy3YFNXbmG1jqovyyhg5KZ1WFNpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784439074; c=relaxed/simple;
	bh=S/m7wEGVPPuy/T0jA6cuudg3kG0H7utcE7QLoebxOpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuCY2K1bjgOV9z7G8o6Xg+svTA41Ab9aZ6aSzWfcFhifPRk9o56N+zW/ly7JFl3P/cFBZixYKvTTgLf8yfz50kX8dgoikyHbQWpVt+5GpLZTzUREMdY6XzjtP2pnoXBKApRqsBGpUz4cFt/1C+Yks4Sd3OchRjYe6l9B5+uI8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=H5bHsnJ9; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="H5bHsnJ9"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id AB21C60D3C;
	Sun, 19 Jul 2026 01:31:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784439065; bh=FapvGTAxBY2u9Vb3QN5cttB3cakXLqKSc2AEx2t5wDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H5bHsnJ9bTTSQ6d5IVK09qjimDr6ftve984VWLpNqFrIgtQp5e1qgkzB4IucyMgft
	 ro4HgVKF/ExU3QP4oMW5y84VXJLQy/Bddl7Kd6WwPVvT6OAUveasEuXWqeViiOU2BO
	 Qoxdhnu2ZllUSbR3br7UEr4E3Xt0YJn4+2Hh4tYuvQrg8399j67V+UhmzXq+sneOvF
	 RlAa0X3gy/GBAdmX7omAV9ZxyT1ekZG8JX0Nig6Q4l1+8D6/Cyhv56elO4UNLl3w1N
	 pJlwNopYgYero71QSVaSGnBiiH9d86wHRkLx1bcOVPa4UFxcGlFTc3iCuvg58KoohN
	 52feMWBryrqgw==
From: Luke Howard <lukeh@padl.com>
Date: Sun, 19 Jul 2026 15:30:53 +1000
Subject: [PATCH net-next v3 1/3] net: dsa: mv88e6xxx: use ARRIVAL1 counter
 for all peer delay messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-mv88e6xxx-ptp-fixes-v3-1-161386ac8a62@padl.com>
References: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
In-Reply-To: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784439056; l=2031;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=S/m7wEGVPPuy/T0jA6cuudg3kG0H7utcE7QLoebxOpk=;
 b=IclY4je3GtNAPlrKV7v1rjJlGcRH+l+nwFhxu7i1zI9goggmyCfAuK2dGBoWU0Fq/IIVld4ok
 rAMEIrk0TGEBMHd5jFgWjIvcm4D8eAFsNxxY7ofanVeBdiCClakxuvl
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

