Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274501;
	b=gbTxQsslXJRLDcceHY3BS7UUTTIk+beojpNhs/1kul0VP6tVfnCkTbdNG9q/S5Y2Pmat
	 e0B9nK50ogFfIc7h2HUm1rJC+5ZDGyrB7XL3TiEHz4t1rG8aYlbgv6SAHPhFuaAuaXhQW
	 gYLCkx95lFHLow7kuUjUn62XmW48N0wYcvy1GUFvY2mpbn5kl0XAgQAHyKvfTuGx4OjOs
	 tkvs8mxLRKtIoa9ZJIcCS4ufEyvuRsUpV9sfVdF0E5GJXhdketH1yZ1YU8jPnNZvaU9tR
	 kON4XMZKuC+cPL+i8GjbEaHqKDtu6ZM6BrmHu/F87E7Lvs9QcTcFoki/73wTn+MPUZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274501;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=wgRJiQVz8iSlUoLifug2XMB1d1PAGIF3uc3BCAEBSwQ=;
	b=ff6JGpkTM4DaJWcN8bdv2+gB6Jlu7R0OM+1OxFEG9U9Y9aV4Yd4BDQOXDj0R+qf5rc6E
	 QpVBYfPpwSXq1vRAcHGp7hCHfJfivR6gfLJQm1m/pQOzueKCrCfn6J/HoIvbA43Jcr9Ni
	 x/POBZbDPuoOt8ij5Gg+U+NM7BXYwJWcTFdoNgxfGaHxpTdWmpYQIqDqsUzhNdPxVQh6Q
	 mUvLhRAjQN/im87PVOL5UoZea+9oBNCevp/OtSRx+T/NACHZsag7PrJHglNevvHa2TZSL
	 CQDc0nFuE/S2vk/RkM/yuVWYEm6g9d+kzX70g3TFRPoyWbKC8FdVGoeQ6SJt5tN2RHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=pa0BmiFM;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D0606A322;
	Thu, 29 Oct 2026 11:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 596D0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=pa0BmiFM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793274502; x=1824810502;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=NrWs0H/8FTS4htfLqAWNH4tb30RFLulr7f3QGcQV3Mc=;
  b=pa0BmiFMG6VebalK26HYqasGS4aShKjH0RASJhT5cGoRKVh/DyJjuIQI
   bbvaICFqmFzdBKWk3uGcLeK92ttr0N+0yMzNzjwhfbU3vMcarEd05gbB7
   CGISIWq78vCtg/gY/Y8wKqPmgCFVnr0lQoPk4F32YfnAN4/NylWawBoje
   W40+WzZMNiFQNbKLNlYybBEtPlXKzzMjY1WqYgGvnWZZTX5EJVcZT75Od
   bqLNGDtUauITT5AwgTgADYZRo6XtvgWSKaYPWIn5TlJaqu1ALCWCgYonx
   yr5HY+suBCv+X0XuUG5g/cixB2oN6wy/q5Ss65ePIUm2sq3zdDwsMgBDt
   g==;
X-CSE-ConnectionGUID: bmYkYbLbQBaaX2C6L6Wqqg==
X-CSE-MsgGUID: xWvmY8vNSz67/E9Yt9TTDg==
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="297149642"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2026 04:48:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 29 Oct 2026 04:48:19 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 29 Oct 2026 04:48:17 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 29 Oct 2026 12:48:10 +0100
Subject: [PATCH net] net: sparx5/lan969x: release the in-flight slot of a
 stale TX skb
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
Message-ID: <20261029-sparx5-ptp-stale-tx-slot-v1-1-ec15f391bbb7@microchip.com>
X-B4-Tracking: v=1; b=H4sIAHky42oC/x3MwQqDMAyA4VeRnBeogVq2Vxk71DVqQGppwiiI7
 27Z8Tv8/wnKVVjhNZxQ+ScqR+4YHwN8t5hXRkndQI6m0ZFDLbE2j8UKqsWd0Rrqfhiyp2cIc0p
 pJuh5qbxI+6/fkNngc103jkfSgW8AAAA=
X-Change-ID: 20261020-sparx5-ptp-stale-tx-slot-e52977bdddb2
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

sparx5_ptp_txtstamp_request() counts every two step TX skb waiting for
its timestamp in sparx5->ptp_skbs, and refuses new ones once
SPARX5_MAX_PTP_ID are in flight. sparx5_ptp_txtstamp_old_release()
frees the skbs that have waited longer than SPARX5_PTP_TIMEOUT.

Before this patch, old_release() does not decrement ptp_skbs, so every
skb whose timestamp never arrives, for example because the switch
discarded the frame, keeps its slot forever. Once SPARX5_MAX_PTP_ID
slots are lost, two step frames fail to transmit on every port of the
switch.

Return the number of released skbs from old_release() and subtract it
from ptp_skbs in txtstamp_request(), under the ptp_ts_id_lock it already
takes.

This fixes the accounting only. A port's stale skbs are still aged out
only when that port sends a two step frame, so a port that stops sending
them keeps its stale skbs, and their slots, until it sends one again.
That behaviour is unchanged by this patch.

Found by an AI code review agent. Reproduced on a lan9696 board with a
modified kernel that drops the TX timestamps of two step frames, after
which two step timestamping stopped working on the port. With the fix,
timestamping keeps working on that board and on a sparx5 PCB135 board.

Fixes: 70dfe25cd866 ("net: sparx5: Update extraction/injection for timestamping")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 2826e48af1033..9f61692b243b7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -204,9 +204,10 @@ static void sparx5_ptp_classify(struct sparx5_port *port, struct sk_buff *skb,
 	*rew_op = IFH_REW_OP_TWO_STEP_PTP;
 }
 
-static void sparx5_ptp_txtstamp_old_release(struct sparx5_port *port)
+static unsigned int sparx5_ptp_txtstamp_old_release(struct sparx5_port *port)
 {
 	struct sk_buff *skb, *skb_tmp;
+	unsigned int purged = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->tx_skbs.lock, flags);
@@ -217,8 +218,11 @@ static void sparx5_ptp_txtstamp_old_release(struct sparx5_port *port)
 
 		__skb_unlink(skb, &port->tx_skbs);
 		dev_kfree_skb_any(skb);
+		purged++;
 	}
 	spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
+
+	return purged;
 }
 
 int sparx5_ptp_txtstamp_request(struct sparx5_port *port,
@@ -226,6 +230,7 @@ int sparx5_ptp_txtstamp_request(struct sparx5_port *port,
 {
 	struct sparx5 *sparx5 = port->sparx5;
 	u8 rew_op, pdu_type, pdu_w16_offset;
+	unsigned int purged;
 	unsigned long flags;
 
 	sparx5_ptp_classify(port, skb, &rew_op, &pdu_type, &pdu_w16_offset);
@@ -236,9 +241,10 @@ int sparx5_ptp_txtstamp_request(struct sparx5_port *port,
 	if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
 		return 0;
 
-	sparx5_ptp_txtstamp_old_release(port);
+	purged = sparx5_ptp_txtstamp_old_release(port);
 
 	spin_lock_irqsave(&sparx5->ptp_ts_id_lock, flags);
+	sparx5->ptp_skbs -= purged;
 	if (sparx5->ptp_skbs == SPARX5_MAX_PTP_ID) {
 		spin_unlock_irqrestore(&sparx5->ptp_ts_id_lock, flags);
 		return -EBUSY;

---
base-commit: 829a09df899dcce860dcf5f70e09c1b2d7d425ab
change-id: 20261020-sparx5-ptp-stale-tx-slot-e52977bdddb2

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

