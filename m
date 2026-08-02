Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0ED242D9B;
	Sun,  2 Aug 2026 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659771; cv=none; b=hUSwAbakyezVzEGYFyCcVNlFrvS7ysZxML0Xjo7lctF4gnetMpolYgz2pAMnU/5/ANay+uY0S+y8z5oqMnsZR+dsUgAjEBJTQcMZFPbw9nG2nzxI+EVNXB4POp01sjwZRkFwgRkwfoDd1C8PLdq5Dh3X/L2Qh2XmErtqX64UQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659771; c=relaxed/simple;
	bh=2dn+pdQmgwzneMeyNfI78fz41t7GJT9KOvqHJ7R0Tvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXbTepTuFEdt9f+BN2GTVx1sjjafRIFUpa99xt3Ip/TxTgBniZPUW0Ur4TE9S/Dcsc+VoaAAm1WCM2pRUatF17FJZDYiyFPkKkXU8cO3cGHHzb+0x/AgVXRw28edrAdAFoTfkXoxVemKVTlO075ZlaP2LpdWcO6M1bWCIrXYP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=O+I0tlSC; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="O+I0tlSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785659743; x=1786264543;
	i=markus.stockhausen@gmx.de;
	bh=YnK1axlNpQUWx6LT1J177n913pF/wVZ1Tg9blSyK6iM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O+I0tlSCx0+JD9Stvof2VqVbEIc7Dx7z2lg3dg3bPTYGf7bm2j8YPAGuHbmfDDyd
	 VhmnXo1FxW7cOfzLkKCaiVM7lPMzW14mM2VhBFggPpGm0RkAqniWDnpm+nKix0cT6
	 bZzNKs51ywj8d77xx58pXr5oijZJ/2Zgj7+qVAWDQLoJUNGGnKj+fpWLSdoIaV8id
	 wyPDfmRCsGuIW55DlYnY3YF0+C1z7fmnljO4FP5SSCcTo//FzOMaS/4PEYqDPP44c
	 kMgDE02JovGnjpu4JuqRnl+IkewR1FTrctUOPaLpCl0eCffMhZQiaABr243CgMfiF
	 28pWAVcspHn3ofODsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNp7-1xDS9i2pWn-00k5Yo; Sun, 02
 Aug 2026 10:35:43 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v11 01/10] net: mctp: usb: Allow multiple urbs in flight
Date: Sun,  2 Aug 2026 10:35:19 +0200
Message-ID: <20260802083528.490216-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802083528.490216-1-markus.stockhausen@gmx.de>
References: <20260802083528.490216-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5LbP6I/1D4cr7cMxcP0KFetDPXoHcxZZQqzfZAVTglwEfco1SGy
 sR/n2NxZW7aDTydpXPWF37GgoLjSB2B987oTTpQ6rg/MUZqOaDsRDZIDHYeGAf82xUemA9u
 jH+gxEvSu6Mns85LF7klUP3tVZyH3SY4Onb5bGDRc0OQDsuKw47Lx68hGW5jYk/YhqTKpGJ
 VYdjgzTGhS9TeoTF9BkwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nVZG0YRk8YM=;r666W8yvd0mCg+pLlt5D0/N4CpJ
 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

From: Jeremy Kerr <jk@codeconstruct.com.au>

Currently, we stop tx queues when we have one urb submitted. This means
we will immediately hit dev_hard_start_xmit's tx-queues-off ->
NETDEV_TX_BUSY case, and revert to the requeue -> gso_skb single-dequeue
path, and no longer be able to pack skbs without an xmit_more
indication.

Instead, allow a few urbs to be in-flight, with a limit of 16kB of data
outstanding (after which we will disable queues). With this, the tx path
will cause fewer requeues (and therefore non-packed transfers) under
normal loads.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Link: https://patch.msgid.link/20260724-dev-mctp-usb-1-1-v5-12-e66bbba0dbd=
c@codeconstruct.com.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
=2D--
 drivers/net/mctp/mctp-usb.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index c4ff9e91a768..542a570c76cc 100644
=2D-- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -42,6 +42,9 @@ struct mctp_usb {
=20
 	struct mctp_usblib_tx tx;
 	struct usb_anchor tx_anchor;
+	/* serialises tx_qmem updates to netdev queue states */
+	spinlock_t tx_qmem_lock;
+	int tx_qmem;
 };
=20
 enum {
@@ -49,23 +52,41 @@ enum {
 	MCTP_USB_SUBCLASS_SPAN =3D 0x02,
 };
=20
+/* We use a total-size limit for outstanding URBs, as the transfer counts
+ * may vary a lot between spanning- and non-spanning modes. In spanning m=
ode,
+ * this will allow for a couple of max-sized transfers to be in flight. I=
n
+ * non-spanning mode, 32.
+ *
+ * We want to avoid disabling the tx queue if possible; doing so will end=
 up
+ * requeueing to gso_skb, and we only dequeue from that one skb at a time=
,
+ * so can no longer perform transfer packing.
+ */
+static const unsigned int TX_QMEM_MAX =3D 16384;
+
 static void mctp_usb_out_complete(struct urb *urb)
 {
 	struct mctp_usblib_tx_ctx *tx_ctx =3D urb->context;
 	struct mctp_usb *mctp_usb =3D mctp_usblib_tx_ctx_priv(tx_ctx);
+	unsigned int len =3D urb->transfer_buffer_length;
 	struct net_device *netdev =3D mctp_usb->netdev;
+	unsigned long flags;
=20
 	mctp_usblib_tx_send_complete(tx_ctx, netdev, urb->status =3D=3D 0);
=20
 	usb_free_urb(urb);
=20
-	netif_wake_queue(netdev);
+	spin_lock_irqsave(&mctp_usb->tx_qmem_lock, flags);
+	mctp_usb->tx_qmem -=3D len;
+	if (mctp_usb->tx_qmem < TX_QMEM_MAX && netif_running(netdev))
+		netif_wake_queue(netdev);
+	spin_unlock_irqrestore(&mctp_usb->tx_qmem_lock, flags);
 }
=20
 static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 			    void *data, size_t len)
 {
 	struct mctp_usb *mctp_usb =3D mctp_usblib_tx_ctx_priv(tx_ctx);
+	unsigned long flags;
 	struct urb *urb;
 	int rc;
=20
@@ -80,8 +101,6 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *=
tx_ctx,
 	if (mctp_usb->span)
 		urb->transfer_flags |=3D URB_ZERO_PACKET;
=20
-	netif_stop_queue(mctp_usb->netdev);
-
 	usb_anchor_urb(urb, &mctp_usb->tx_anchor);
=20
 	rc =3D usb_submit_urb(urb, GFP_ATOMIC);
@@ -89,7 +108,12 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx =
*tx_ctx,
 		netdev_dbg(mctp_usb->netdev, "TX urb submit failed, %d\n", rc);
 		usb_unanchor_urb(urb);
 		usb_free_urb(urb);
-		netif_start_queue(mctp_usb->netdev);
+	} else {
+		spin_lock_irqsave(&mctp_usb->tx_qmem_lock, flags);
+		mctp_usb->tx_qmem +=3D len;
+		if (mctp_usb->tx_qmem >=3D TX_QMEM_MAX)
+			netif_stop_queue(mctp_usb->netdev);
+		spin_unlock_irqrestore(&mctp_usb->tx_qmem_lock, flags);
 	}
=20
 	return rc;
@@ -353,6 +377,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	spin_lock_init(&dev->rx_lock);
 	if (dev->span)
 		netdev->max_mtu =3D MCTP_USB_1_1_MTU_MAX;
+	spin_lock_init(&dev->tx_qmem_lock);
 	usb_set_intfdata(intf, dev);
=20
 	rc =3D mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize),
=2D-=20
2.55.0

