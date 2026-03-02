Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91604411617
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465300; cv=none; b=R0SPt1zwOl8zYT1c+UCMsipTwRoyrR8RxtZd48eV0yXSYTDUdytJN4+WVApPU7o/dGpVHkoi/QyrQ69Ete0/IQO0cgfb1vTzWARVcSjgpV2wBT8QOGUakjTG/QGZkkIe+bJIKZfDZu5STFr41H/EYgZi5N6o3CSneomVzfduAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465300; c=relaxed/simple;
	bh=OmuZ+VILbupgktkBc2ZqVrC1+1zuzqBKC4DDlxtGSLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/oRC2KJbEd38gEYhMGEBSdmvxPRrS5AXV1IlvbdWzdhCd8/tDMLebxsiVkg7d3gC3bRt3i1RuJVDy+xIPUf9V8zQ0PiIqCMDcCueYGD/7Yk2OB1IxI7BJzgB70Os9f9bVhqmQyHPBttqJtWKvQGLvks7dCPBO9kqq1f1/LXqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bf-0004kQ-Ms; Mon, 02 Mar 2026 16:27:59 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bc-003P0u-2q;
	Mon, 02 Mar 2026 16:27:58 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E86A64F5472;
	Mon, 02 Mar 2026 15:27:57 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org
Subject: [PATCH net 09/12] can: usb: f81604: handle bulk write errors properly
Date: Mon,  2 Mar 2026 16:16:15 +0100
Message-ID: <20260302152755.1700177-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302152755.1700177-1-mkl@pengutronix.de>
References: <20260302152755.1700177-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If a write urb fails then more needs to be done other than just logging
the message, otherwise the transmission could be stalled.  Properly
increment the error counters and wake up the queues so that data will
continue to flow.

Cc: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable@kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026022334-slackness-dynamic-9195@gregkh
Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/f81604.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index c61bd30d1765..1cc927d79b6a 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -880,9 +880,27 @@ static void f81604_write_bulk_callback(struct urb *urb)
 	if (!netif_device_present(netdev))
 		return;
 
-	if (urb->status)
-		netdev_info(netdev, "%s: Tx URB error: %pe\n", __func__,
-			    ERR_PTR(urb->status));
+	if (!urb->status)
+		return;
+
+	switch (urb->status) {
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+		return;
+	default:
+		break;
+	}
+
+	if (net_ratelimit())
+		netdev_err(netdev, "%s: Tx URB error: %pe\n", __func__,
+			   ERR_PTR(urb->status));
+
+	can_free_echo_skb(netdev, 0, NULL);
+	netdev->stats.tx_dropped++;
+	netdev->stats.tx_errors++;
+
+	netif_wake_queue(netdev);
 }
 
 static void f81604_clear_reg_work(struct work_struct *work)
-- 
2.51.0

