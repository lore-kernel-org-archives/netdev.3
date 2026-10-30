Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793366379;
	b=uwj/TlxdMJrGqnd+NodnS5Vem8nubvbrhyv60H+HXAV4FHdr6qr/Jq0XVgB4wXKgblqK
	 lnRdsDu04ysWwOC//3mwLJ5dO/UZBexuN6h9yMRxYQ6Z/kLufwPNtHQAGkTpA7k+ab+WD
	 xPLzG5NN91wjPYcU9g47BEAbdOfSqWvA++aZCK4PZeLDpijNU3KViYeX0GI5Ol6FrNydS
	 NKNgpDw7bmuvVJCqahG+ipC2RRKNaROzYP9cPBxyIq+9Algky9xEpzk5d63AgT8DLnKiE
	 o3kZsF0zZyfSCkYf8go4LYVn93mIegA0hByKDb7fAh4ijl90HBF0tPuIS/4VSv1grow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366379;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0c+srI46VN9ambPL/mY8yTajB7Qm3pVtlX5ODIx1yNs=;
	b=10dqVKZwmnJZkNECGZbnd0ARiWI8rpffflpHYbdwQtX2cfRvu5FUPcEqodYSQPgnsp1T
	 vTc6X32diDW1yZPCXsMJgNf5ddBbaP11f89kAdmjs14EqBrMbihrg7IHwoAtOTPLxUS7m
	 Os9SidDbzCUmYxX8q2VBANrEmvsXT64pDEIsZGTyR6os+3DFOq5otTyeH+SbpZJzhGD2m
	 4t2Q/9VpsqYQi651mrbuLUD+iezXQgmbUeVCr3pjlxcdSRaoJoGIxi4wRAZTzRBaOreyJ
	 sE7mEznaJDJgjoi5sv9/X5u4aYP8dMC2pgTzT0tCXGGEw3c/MkMuBh7mFb97l1BdgmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GC6NbJpl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD85606A31A;
	Fri, 30 Oct 2026 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GC6NbJpl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793366378;
	b=dhfS0TZfEBS+AJUXTElFfM+1Hhe2Ee1MEcB4Gz0OCMuL3xJp6JhznTkXSNBgXCi2rz7y
	 87RnX+nztNccsgTaGycA4ZwY5AUErxh1wvSxMGJrjc7ncitb+GlXXX3gmIreUztE5pZLk
	 HcTW35G0v6e/iH0cuH16f9xHT7UAdtbrNnt76gU2qMlaVbVAXtwvqgYPbqGJpZhdWbFZM
	 pkwAxUeazR3SUlrDll03YSBV3ZY0eMJY8gKxOPckTQfBJ0Im0lT1wq7g8pm2oSIfczMSn
	 RLKsJc/lVIggwL0GurpKFAnAnXdLNDmXlqSb3kL3uTxl3DjNXbFulkNqmsqlzBVrh7A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793366378;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0c+srI46VN9ambPL/mY8yTajB7Qm3pVtlX5ODIx1yNs=;
	b=WpLBh8MiRnNMgQc6h4g7zbQvhq21O/7QQkxWcN7nhwcGK+GBDCZEXjMt24zBvJwONRa2
	 pBlEg+OYIYN5Ad414i+QfR69z805AAPqWcB+dDNpKxgzPeeVwcEfnU48UT99ERbaxGOem
	 AI30xNzx/FQAFvN4ZO+FyhYIDRyluuFRbdpFNp/K7KGyOvUzfdk7cTzpd+WwG47nnNrGl
	 MIaM53fqaV/GZaLpQrW2ZGdhCv75VBeeg77yBs77NE7t2PjQJziYi5c17uVXgpyMgoeEM
	 aS+s685UwB8k3Rd7wD7FeGkgxFAdgV220OhACpS7ujL+ezNLTTzh+TDd3Q1I9P9PZBQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 511B31F000C1;
	Fri, 30 Oct 2026 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793366378;
	bh=0c+srI46VN9ambPL/mY8yTajB7Qm3pVtlX5ODIx1yNs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=GC6NbJplIOqqRpGreEmwxf7ViVa9lQJBlO3DcaSHqib8gA3VbJyj5d8e0tHDu7x64
	 z4Ib9aeI7hwtimAefHo05B+XY2xyYi8kfeoKl77jQWQ5z12OS1xHkegmTz7SgLzS+K
	 z3USyut0Spsqv6qJBnUpghYGFTStjkina3m1Ce5Ays8S1N+kFDH5SkaFTGQOpN4bKn
	 kJHm9DFMldjBb8l2nOnloJpP5S1JaFiw7xoJsz0PSBOMMvvn1CgB05yi57a1pnjsT8
	 nnpJttpoZ7PHS3CrJgNBPnou5pWr4uzmUZmMgAxNCuBY5D0WrbiJQSsgcEQunMeREP
	 GoabdCoXIrwlw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A6102437C4;
	Fri, 30 Oct 2026 13:19:37 +0000 (UTC)
From: "Jesper L. Nielsen via B4 Relay" <devnull+jln.pascal-audio.com@kernel.org>
Date: Fri, 30 Oct 2026 14:19:27 +0100
Subject: [PATCH net] net: ethernet: ti: am65-cpts: keep port and direction
 when matching PTPv1 TX timestamps
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
Message-Id: <20261030-am65-cpts-ptpv1-v1-1-0bb4c370d970@pascal-audio.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqAIBBA0avErBtQS4OuEi1immoWmahEEN49a
 fkW/7+QOAonGJsXIt+S5PIVum2AjsXvjLJWg1HGadUpXE5nkUJOGHK4NfaWqKPBDG41UKsQeZP
 nP07gOcNcygdL26HJZgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793366377; l=4797;
 i=jln@pascal-audio.com; s=20261030; h=from:subject:message-id;
 bh=g6Pxn3bL6YJURZnn2XnFYFyzwaZXA1q8XNApH4S0gc0=;
 b=xQAFVSNuNnPJi5w8tieHSuPlpBwr23QvEXWNtHDkYUmj8l7yDrjbop23tn0mEy2zxa4A/2wfA
 JP8iYtxXW+qAt4mIdWzf9Wp76g8Z+NF7rbDdLIsYVQbHQ6nhJBOGap0
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
commit a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port number to identify timestamps").
The overwritten value also sticks for the rest of the TX queue walk.

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
---
 drivers/net/ethernet/ti/am65-cpts.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index df5659ead7..e30fae0bcd 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -788,6 +788,29 @@ static struct ptp_clock_info am65_ptp_info = {
 	.do_aux_work	= am65_cpts_ts_work,
 };
 
+/*
+ * The CPTS decodes the message type of an event using the PTPv2 header
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
@@ -797,7 +820,6 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 	bool found = false;
 	u32 mtype_seqid;
 
-	mtype_seqid = event->event1;
 	__skb_queue_head_init(&txq_list);
 
 	spin_lock_irqsave(&cpts->txq.lock, flags);
@@ -810,11 +832,9 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
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


