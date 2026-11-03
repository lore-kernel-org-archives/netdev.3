Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793695375;
	b=lgx3m5Dcv21ALFAGFeR0Q58hQUj8BOHoGTCozClm0TAoOrmlo+dkcXMDHweIqc3Fchke
	 CJf/u/qBLzTwCrLe11ur3vcNKlQ4gCtrUf10B70OTRNO9mExg9dZSvut/LBIvgkxPAAsC
	 5NN7gAp5A4SG9IdjujShHe07eERGffpAat/mwph35Jr/r/+0Z+ZdsVdIMuV9t1qjkaVXV
	 LJD2Z+Oq/cWwBf3WTMo5KyrDNVoD0cH3qqeNljte7DrEfIoG7ruwr0+xZBmZPlC+ViqKA
	 YYT4IZNcwwwfemJbOQ80QtrWuZ8sa7E8W1Eb/r2kHkl+/PYwvZLQzR54qLKZGIUEUbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695375;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2iRrY/OfyFptn9d9uQx8ftgHSl/eU+8UCllnzn3P1yo=;
	b=Sdpj6QSBFZ4qH0/MffrIu3FASPXlxBW/VNT012s4nCFJn5Cu6Nz5SarRuJzIPNOAhaSO
	 /QMtZaeBdt9rrB6525VGzpJZoSkMHZLBQf0bP2MIOGPadQRPlswa9J70nR+sK6rspuPYf
	 2IFYxvB7PBKCnxJm0R3e/v+qkmjrTl9fBSvHIMXkTmPg3eixA2FRSTQgONxcixUWUXTDZ
	 NyxC/Q/G9YtDl1NYGbc7GxntwHYSCCvi+R4TX/HGzjjmlmBdAtT91LtIUZDmlH+sderrq
	 Vh690FQv86NmCF9T36ROA/45rmf9HL2cA9rGZQC18XjFDazLkX7k2TsMwwc4BBuUXgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Euwa6rk3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDB606A32F;
	Tue,  3 Nov 2026 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Euwa6rk3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793695375;
	b=C0omEPmRHB3ALe8gLyqWd7GIIwzOj9s3d8IOWLaJ0PnWeXZnPCnTsxO8uQC3Yd/2ROq9
	 rGVLwOyvKQpGvk2vlQZle6fDSqDRkqVwTnhT+Xavfn1nEOGBBjDBoeKelqsISQzwRg7vR
	 LohOp3Dc8EtHRzLqc0Y1aian1ogy6E+Af+KF1O4Uz5MRHtmL1gnx9jmf0tH55JrxvpSu7
	 0GJtgBF8UcD0HYNCViyJs7PaABLxjiFJcOFBLwJ3BMSydM5ymTij3hpHRBGF3AlBtrF38
	 Naoif2mzCmEbNZNL6H+4d1v82A1WTe48MdEikIXJAAgesdanIMu3i1jL8+Ok/acYQ+Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793695375;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2iRrY/OfyFptn9d9uQx8ftgHSl/eU+8UCllnzn3P1yo=;
	b=s1IbI/ElR97YcLMLnPTg6L/ZjunooMBhprWTz17KMcBFVtOrZx7dVAYMgH8vNdGFro+Q
	 Q7X8hkj2CjkGGfHC3Xjzd+FCxirEpeB6vSKqPYH1llZYIXJ97+Mh20+WRvdPA4dfODTZy
	 KM2qOxLwmgusMeChSE1+G5GUYu99md9lsMI3nY0ggrqk33sxyZYsYzH3OD4okAMsbALE+
	 3pBGLlze0nzEMbHBrBnxTv08t/ZUpmIgrzEEKxDvXbtkSocx8VUc/kGUf5A29H6NnqJnl
	 zActeuiwDq8RXWPVSBgQGKdBguGc09mPtcYrpOklnr3PwAWat6d4vsyZMlblyErhGmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A5CD1F000C1;
	Tue,  3 Nov 2026 08:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695375;
	bh=2iRrY/OfyFptn9d9uQx8ftgHSl/eU+8UCllnzn3P1yo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Euwa6rk3+OtwB1lMpX4r2BtYuyED6rGXuLT7doXqCkUfRDXaYX3cwPL1kvCeAJ8xp
	 osh8fnaa3iYLIC3XUv9ixxiHRzQUczRA2wxruyF4LbPhOBNx+RXxJ1sso6sPCsJI0e
	 Jir/0R9gfHeNT/YaYe1c+dFCYWCODERqCdhNeORlMG0xICnic0Ay6VROXY7n5kjIwW
	 9Bi6x1pd7Bbmgsaha/QcOj0+2axPl/ddMgUCTCH8l8jzjHzYGQTmq5VCgr6cAoi119
	 N4wDD9CuZDjxOiLnAU+g3O1YuAKXr0T2sA5RzkeN3hWEgiuXp6olnCokZ6BMxsi+GG
	 VlaVxwP4M9J8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D9D0346839;
	Tue,  3 Nov 2026 08:42:53 +0000 (UTC)
From: "Jesper L. Nielsen via B4 Relay" <devnull+jln.pascal-audio.com@kernel.org>
Date: Tue, 03 Nov 2026 09:42:52 +0100
Subject: [PATCH net v2] net: ethernet: ti: am65-cpts: keep port and
 direction when matching PTPv1 TX timestamps
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
Message-Id: <20261103-am65-cpts-ptpv1-v2-1-e1f79ed1ba60@pascal-audio.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/3WNzQrDIBCEXyXsuVvU/Eh76nuUHMxqm4UmitrQE
 nz3Su6FuXwzzMwOyUV2Ca7NDtFtnNivFdSpAZrN+nTItjIooQYpWoFmGXqkkBOGHDaJXU/UklZ
 6sApqK0T34M+xeIfVZRirOXPKPn6Pl00e0d/BKolimjpqtbAXLW7BJDIvNG/L/kx+gbGU8gPvi
 O50ugAAAA==
X-Change-ID: 20261030-am65-cpts-ptpv1-45cc3c7276d2
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Martin Kaistra <martin.kaistra@linutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Jesper L. Nielsen" <jln@pascal-audio.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793695373; l=5455;
 i=jln@pascal-audio.com; s=20261030; h=from:subject:message-id;
 bh=KkkM70wITXUFTStvvy/VCOMH1m9ua1ZSVUId0tiFcgA=;
 b=gTigozlOmH+7swK3ZG+4vys4SMXHBYkkLZDq3Lv1RVn9F8b25ddFguGPFlE8QHiylt3+ipO7v
 yTkvGb+DkueCYzbgI5QyLs60EUiMq8HYz83YsSqtvLP4JmKrORaYBAx
X-Developer-Key: i=jln@pascal-audio.com; a=ed25519;
 pk=HN4GIuN0bzT/+cWaO2W1D3+3WUOlizjI/JLKLramukQ=
X-Endpoint-Received: by B4 Relay for jln@pascal-audio.com/20261030 with
 auth_id=1362
X-Original-From: "Jesper L. Nielsen" <jln@pascal-audio.com>
Reply-To: jln@pascal-audio.com
Content-Transfer-Encoding: 7bit

From: "Jesper L. Nielsen" <jln@pascal-audio.com>

The CPTS reports the message type of a timestamp event using the PTPv2
header layout, i.e. the low nibble of the first header byte. In a PTPv1
header that byte is the upper byte of versionPTP and always 0, so every
PTPv1 event is reported as message type 0, while
am65_skb_get_mtype_seqid() reads the PTPv1 message type from the control
field. To make PTPv1 match at all, commit 1b9e743e923b ("net: ethernet:
ti: am65-cpts: Fix PTPv1 message type on TX packets") overwrites the
whole value compared against the skb with the skb's own value once the
sequence ids are equal. That throws away the event type and the port
number of the event as well, so a PTPv1 skb matches any TX event with
the same sequence id on either port. For PTPv1 this defeats
commit a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port
number to identify timestamps"). The overwritten value also sticks for
the rest of the TX queue walk.

Since every PTPv1 frame reads as message type 0, the hardware timestamps
all PTPv1 frames to UDP ports 319 and 320, including Follow_Up and
Delay_Resp, for which no skb waits. With a PTPv1 master on both ports
whose sequence ids run in step (e.g. a Dante device with primary and
secondary network started at the same time), the unclaimed TX event of
Follow_Up N on one port is still on the event list when the other port
queues Sync N, and am65_cpts_find_tx_ts() tries to match before it
checks for expiry. Sync N then gets the transmit time of the other
port's Follow_Up N, and the master announces a preciseOriginTimestamp up
to one Sync interval early to every slave on that network.

For PTPv1 replace only the message type of the event with the skb's and
keep its event type, port number and sequence id, and compute the value
per skb.

Tested on AM62x with ti-linux-6.12.y and the port number commit backported:
without this patch every boot in which both ports started PTP together
(10 of 10) sent wrong Sync timestamps, with it none did (0 of 29).

The bug was tracked down, and this fix and changelog drafted, with the
help of an AI coding assistant (Claude). I reviewed and tested it on
hardware as described above.

Fixes: a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps")
Signed-off-by: Jesper L. Nielsen <jln@pascal-audio.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Changes in v2:
- Wrap the commit a23c657e332f reference like the one above it (Siddharth)
- Use netdev comment style for the new comment (Siddharth)
- Collect Reviewed-by from Siddharth
- Link to v1: https://patch.msgid.link/20261030-am65-cpts-ptpv1-v1-1-0bb4c370d970@pascal-audio.com

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/ti/am65-cpts.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index df5659ead7..db5fc0f769 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -788,6 +788,28 @@ static struct ptp_clock_info am65_ptp_info = {
 	.do_aux_work	= am65_cpts_ts_work,
 };
 
+/* The CPTS decodes the message type of an event using the PTPv2 header
+ * layout. For PTPv1 that nibble is part of versionPTP and always reads 0,
+ * while am65_skb_get_mtype_seqid() takes the message type from the PTPv1
+ * control field. For PTPv1 take the message type from the skb, but keep
+ * the event type, port number and sequence id of the event so that an
+ * event only matches a packet of the same direction on the same port.
+ */
+static u32 am65_cpts_event_mtype_seqid(struct am65_cpts_event *event,
+				       u32 skb_mtype_seqid,
+				       unsigned int ptp_class)
+{
+	u32 mtype_seqid = event->event1;
+
+	if (ptp_class & PTP_CLASS_V1) {
+		mtype_seqid &= ~AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK;
+		mtype_seqid |= skb_mtype_seqid &
+			       AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK;
+	}
+
+	return mtype_seqid;
+}
+
 static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 				  struct am65_cpts_event *event)
 {
@@ -797,7 +819,6 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 	bool found = false;
 	u32 mtype_seqid;
 
-	mtype_seqid = event->event1;
 	__skb_queue_head_init(&txq_list);
 
 	spin_lock_irqsave(&cpts->txq.lock, flags);
@@ -810,11 +831,9 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 		struct am65_cpts_skb_cb_data *skb_cb =
 					(struct am65_cpts_skb_cb_data *)skb->cb;
 
-		if ((ptp_classify_raw(skb) & PTP_CLASS_V1) &&
-		    ((mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK) ==
-		     (skb_cb->skb_mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK)))
-			mtype_seqid = skb_cb->skb_mtype_seqid;
-
+		mtype_seqid = am65_cpts_event_mtype_seqid(event,
+							  skb_cb->skb_mtype_seqid,
+							  ptp_classify_raw(skb));
 		if (mtype_seqid == skb_cb->skb_mtype_seqid) {
 			u64 ns = event->timestamp;
 

---
base-commit: 5838f10563d58afca6711edb5e4eda968ca181d9
change-id: 20261030-am65-cpts-ptpv1-45cc3c7276d2

Best regards,
--  
Jesper L. Nielsen <jln@pascal-audio.com>


