Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022421;
	b=xRYUkP8AmvEizD0f1Cf2/V3THjeVLVd1g37GGqY/k+dJq6XVdTdcBm9wE6UCj8SspyHc
	 AWJbujHIQrKftE/5otVVIQjJiGkaxe+wlwrAj1jzYamSR2FQ9QYEwHiYZ7AvBGaYfIN7h
	 SKmwGVD67EoKf/0R+oZErffNI8DJdiCCw3mXE3sThOc0uaZUOt2V0od9i8IiewjaW56pC
	 v5rq7VyMLMRy4durnvyKRdlk5lhv3caWwz7L154gqDYP0v9bHhD5LZq2PyjHxNAkBjYFh
	 pctqZChRz/3j+llHbZov2vy76l30AnCP5zCEEgRvQAVvZ5lLSYRl37mYQzlqJUKy6Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022421;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=9sYeJhpFAGo5c5P1VbahKyrxbP2CKE6TtJre/9FBbdc=;
	b=L6he7qK7ZWLnGzFlT3M32Plszv9eVj+UoHGZ3gJAH0W8dGoB/mdajkzPxeQajALvOBCI
	 AVJvggxLx5kzTWz5q3keYbxY8Cx5F8Y1q+Salq+KElgnZICvdsxsnBJ6/uBpb4HDtx/Yb
	 6OelcDAbZfxdKPZ3RwNwJgUIGC+9h7hb0KCusK2eV/f6JLn/96xFZv/Byqc19xVl/FbX0
	 P7wDIPlYt17UKGl5oQFI+iHtYT+JyFQnrAqnNmB5rlMOhb7ribP+7mdaTgm9m6xyLKy+V
	 bdkgyWt5wbkpcgzoaTUfmyN07NLRm2KGrBNDK/a5Fc4NUto0pbdZ5+eANuXyCk462QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ITXwRYWl;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B560A2624;
	Mon, 26 Oct 2026 13:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 935B560A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ITXwRYWl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793022420; x=1824558420;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=gPNjPDT0Eez4R+aWMC/vKM9N+EOB+bn9XquxCfvnEb4=;
  b=ITXwRYWlDdyb0x9XmlV1nIIW37dUAK2l8h4PLO1TMd939FiXofIXXtmG
   JSWntsReoC4gOwRZhRQ3cIqZAjpJJfuo8uzoqdEzF3X9N9MnPee4FhhL3
   Ang8j+Yb83wZ7n5+24R/egDPRRkTGNh093tH1E1n3X6Sv09DLj4mMLdZJ
   JxsDUiL0B9FXamxfH5jfo1ZTnDTWFEDxvqHHEcgmQ0w/RhQDHfdEaw0zU
   X3hSJi9kqIBiLKllYySiGlP3NRKNVEFSrYeC/p8kUNYFi8rTaF20Kyb41
   dnHilTHlN9SMW+EQQBJ6YLf8MvxZzShJllbI+mR92FxnOWFueCxg9woxN
   g==;
X-CSE-ConnectionGUID: JD/6gbCESWaLu8//7+v43w==
X-CSE-MsgGUID: G96SQLiASaOwibMbYoxbag==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="65818867"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:47:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 26 Oct 2026 06:46:59 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 06:46:57 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 26 Oct 2026 14:46:54 +0100
Subject: [PATCH net] net: lan966x: release the in-flight slot of a stale TX
 skb
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
Message-ID: <20261026-lan966x-ptp-stale-tx-slot-v1-1-9f7c895eb1ff@microchip.com>
X-B4-Tracking: v=1; b=H4sIAM1Z32oC/x3MwQrDIAyA4VcpOTdgHRPaVxk7yBLXgFgxoQil7
 z7Z8Tv8/wXKTVhhmy5ofIrKUQaWeYLPHsuXUWgYvPNhcf6BOZY1hI7VKqrFzGgdNR+G65NSio6
 SI4LR18ZJ+v/9gsIG7/v+AQuyMiFwAAAA
X-Change-ID: 20261023-lan966x-ptp-stale-tx-slot-95dffa0df0dd
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

lan966x_ptp_txtstamp_request() counts every two step TX skb waiting for
its timestamp in lan966x->ptp_skbs, and refuses new ones once
LAN966X_MAX_PTP_ID are in flight. lan966x_ptp_txtstamp_old_release()
frees the skbs that have waited longer than LAN966X_PTP_TIMEOUT.

Before this patch, old_release() does not decrement ptp_skbs, so every
skb whose timestamp never arrives, for example because the switch
discarded the frame, keeps its slot forever. Once LAN966X_MAX_PTP_ID
slots are lost, two step frames fail to transmit on every port of the
switch.

Return the number of released skbs from old_release() and subtract it
from ptp_skbs in txtstamp_request(), under the ptp_ts_id_lock it already
takes.

This fixes the accounting only. A port's stale skbs are still aged out
only when that port sends a two step frame, so a port that stops sending
them keeps its stale skbs, and their slots, until it sends one again.
That behaviour is unchanged by this patch.

Found by an AI code review agent. Reproduced on a lan9668 board.

Fixes: 77eecf25bd9d ("net: lan966x: Update extraction/injection for timestamping")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 8c40db90ee8f6..9be2cfe6feeb7 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -376,9 +376,10 @@ static void lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb,
 	*rew_op = IFH_REW_OP_TWO_STEP_PTP;
 }
 
-static void lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
+static unsigned int lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
 {
 	struct sk_buff *skb, *skb_tmp;
+	unsigned int purged = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->tx_skbs.lock, flags);
@@ -389,14 +390,18 @@ static void lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
 
 		__skb_unlink(skb, &port->tx_skbs);
 		dev_kfree_skb_any(skb);
+		purged++;
 	}
 	spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
+
+	return purged;
 }
 
 int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
 				 struct sk_buff *skb)
 {
 	struct lan966x *lan966x = port->lan966x;
+	unsigned int purged;
 	unsigned long flags;
 	u8 pdu_type;
 	u8 rew_op;
@@ -408,9 +413,10 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
 	if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
 		return 0;
 
-	lan966x_ptp_txtstamp_old_release(port);
+	purged = lan966x_ptp_txtstamp_old_release(port);
 
 	spin_lock_irqsave(&lan966x->ptp_ts_id_lock, flags);
+	lan966x->ptp_skbs -= purged;
 	if (lan966x->ptp_skbs == LAN966X_MAX_PTP_ID) {
 		spin_unlock_irqrestore(&lan966x->ptp_ts_id_lock, flags);
 		return -EBUSY;

---
base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
change-id: 20261023-lan966x-ptp-stale-tx-slot-95dffa0df0dd

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

