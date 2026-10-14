Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4454CF57
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989059; cv=none; b=fbhmPffmNiUcjyz1NR6uigy4zyMJVgeIsrXv7PfQ3RqWNoRGOGCmk5pxinsxPRfkdRuvyImuVSnj+miRX/XV1nuvc2KlpSrLccQlUB7Tu2RlFr40OnoBQ6OLSb3coq9lv7ouMDIA10tAhYlc8JXmaQScfv2bfqi1Zocf8QGC240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989059; c=relaxed/simple;
	bh=GgSOlwCPHV7EM13Uamo2tNUhnKD6b3ac1SjyPRrGvKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKXK/hxiy2MOpMuZdlb6vZPelk/EkVEd1HRj/5YnS8EDVPZ8edkDYy3YtvkNShPaYaFOjgzPIaWOiR1uED8HfyFxeHSQJE8sjjMZoqdA6HQ5F3ASt6eRQomsSzazPtYEToW43ctCnjzsJxt5nsucqgiEIVnUDiB9X2xIYvahCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Olf75yM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZSDtwnlC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Olf75yM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZSDtwnlC"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791989048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cka8IuO/1nkYkHI0lFgV3kHakfCHoKTyDJW2iz0H2Qc=;
	b=4Olf75yMYhhkh0eb6+xfOrsIQ4ORK6WVDlOZqMjILWUabYTnoV9VcXdOZOdXzJFLpJr9N5
	6p3Go8PyNRSPzL2pOKCkqU6HULrgdYQaYf/30bKL48xAlXSf+dk0bp14XoHSNnNySJAbXe
	0JsmfabMZGMF3KCmWqb+uelWZgs5nI2U+QNJjQiblV7juE4bYWQZnDmKw7GDvtp+0/MGJf
	0THbx/n8cifWSOEUjPfw9PJ6ec6LkspMsBFkd92CgeMZ268oT7qHub2crjqq8xe+uNKfD6
	5/Nv7yKjB1J5ljZLoiZqRiU+gJGYq0uhNCu2N6Qgs2xOJY1WM/cTpawH2E+Uhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791989048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cka8IuO/1nkYkHI0lFgV3kHakfCHoKTyDJW2iz0H2Qc=;
	b=ZSDtwnlCq/HnEpdwOdk4VwLqqIbrwO+ZlpUl/EiDWdkw8VIbEXlxKugGE9uoemaOwH/H85
	0aGKFtrNCy4w+xAQ==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next v9 5/8] hsr: Use the port and header information in hsr_forward_skb()
Date: Wed, 14 Oct 2026 16:43:59 +0200
Message-ID: <20261014-hsr_ptp-v9-5-2d20a2a0f816@linutronix.de>
In-Reply-To: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The upper layer can submit a port on which the skb should be sent and
whether or not a HSR header should be added. Use this information while
forwarding the packet:
- If the port set, deliver it only on the requested port.
- If a header is already present then skip parts of the stack:
  - The packet originates from the master port and we don't want to
    assign a sequence number to it, it needs to preserve the original
    one.
  - The existing h_source must be used (and not replaced).
  - The node should already exist in the node_db if "other" packets are
    exchanged. If the node information is not yet existing then
    creating it makes no sense because it is used for deduplication of
    incoming packets and this is not used in the PTP case. If no other
    packets are exchanged then the node_db will age and then removed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_forward.c  | 45 ++++++++++++++++++++++++++++++++++++---------
 net/hsr/hsr_framereg.h |  2 ++
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 2b8ae9723bd7f..534798da48d53 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -426,7 +426,7 @@ static void hsr_deliver_master(struct sk_buff *skb, str=
uct net_device *dev,
 static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 		    struct hsr_frame_info *frame)
 {
-	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER) {
+	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER && !frame->has_foreign_hea=
der) {
 		hsr_addr_subst_dest(frame->node_src, skb, port);
=20
 		/* Address substitution (IEC62439-3 pp 26, 50): replace mac
@@ -547,11 +547,12 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, str=
uct hsr_port *port)
 static void hsr_forward_do(struct hsr_frame_info *frame)
 {
 	struct hsr_port *port;
-	struct sk_buff *skb;
 	bool sent =3D false;
=20
 	hsr_for_each_port(frame->port_rcv->hsr, port) {
 		struct hsr_priv *hsr =3D port->hsr;
+		struct sk_buff *skb =3D NULL;
+
 		/* Don't send frame back the way it came */
 		if (port =3D=3D frame->port_rcv)
 			continue;
@@ -570,6 +571,17 @@ static void hsr_forward_do(struct hsr_frame_info *fram=
e)
 		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
 			continue;
=20
+		/* PTP TX packets have an outgoing port specified */
+		if (frame->req_tx_port !=3D HSR_PT_NONE && frame->req_tx_port !=3D port-=
>type)
+			continue;
+		/* PTP TX packets may already have a HSR header which needs to
+		 * be preserved
+		 */
+		if (frame->has_foreign_header && frame->skb_std) {
+			skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+			goto inject_into_stack;
+		}
+
 		/* Don't send frame over port where it has been sent before.
 		 * Also for SAN, this shouldn't be done.
 		 */
@@ -597,6 +609,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		else
 			skb =3D hsr->proto_ops->get_untagged_frame(frame, port);
=20
+inject_into_stack:
 		if (!skb) {
 			frame->port_rcv->dev->stats.rx_dropped++;
 			continue;
@@ -661,6 +674,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *=
skb,
 	struct hsr_port *port =3D frame->port_rcv;
 	struct hsr_priv *hsr =3D port->hsr;
=20
+	if (frame->has_foreign_header) {
+		frame->skb_std =3D skb;
+
+		WARN_ON_ONCE(port->type !=3D HSR_PT_MASTER);
+		WARN_ON_ONCE(skb->mac_len < sizeof(struct hsr_ethhdr));
+		return 0;
+	}
 	/* HSRv0 supervisory frames double as a tag so treat them as tagged. */
 	if ((!hsr->prot_version && proto =3D=3D htons(ETH_P_PRP)) ||
 	    proto =3D=3D htons(ETH_P_HSR)) {
@@ -702,7 +722,8 @@ int prp_fill_frame_info(__be16 proto, struct sk_buff *s=
kb,
 }
=20
 static int fill_frame_info(struct hsr_frame_info *frame,
-			   struct sk_buff *skb, struct hsr_port *port)
+			   struct sk_buff *skb, struct hsr_port *port,
+			   enum hsr_port_type tx_port, bool has_hsr_header)
 {
 	struct hsr_priv *hsr =3D port->hsr;
 	struct hsr_vlan_ethhdr *vlan_hdr;
@@ -725,10 +746,15 @@ static int fill_frame_info(struct hsr_frame_info *fra=
me,
 	if (port->type =3D=3D HSR_PT_INTERLINK)
 		n_db =3D &hsr->proxy_node_db;
=20
-	frame->node_src =3D hsr_get_node(port, n_db, skb,
-				       frame->is_supervision, port->type);
-	if (!frame->node_src)
-		return -1; /* Unknown node and !is_supervision, or no mem */
+	frame->req_tx_port =3D tx_port;
+	frame->has_foreign_header =3D has_hsr_header;
+
+	if (!frame->has_foreign_header) {
+		frame->node_src =3D hsr_get_node(port, n_db, skb,
+					       frame->is_supervision, port->type);
+		if (!frame->node_src)
+			return -1; /* Unknown node and !is_supervision, or no mem */
+	}
=20
 	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
 	frame->is_vlan =3D false;
@@ -777,10 +803,11 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_=
port *port,
 	struct hsr_frame_info frame;
=20
 	rcu_read_lock();
-	if (fill_frame_info(&frame, skb, port) < 0)
+	if (fill_frame_info(&frame, skb, port, tx_port, has_hsr_header) < 0)
 		goto out_drop;
=20
-	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
+	if (!frame.has_foreign_header)
+		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
 	hsr_forward_do(&frame);
 	rcu_read_unlock();
 	/* Gets called for ingress frames as well as egress from master port.
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 127a3fb64d5f0..e5e6363c0466f 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -29,6 +29,8 @@ struct hsr_frame_info {
 	bool is_from_san;
 	bool dst_in_node_db;
 	bool dst_in_proxy_node_db;
+	bool has_foreign_header;
+	enum hsr_port_type req_tx_port;
 };
=20
 void hsr_del_self_node(struct hsr_priv *hsr);

--=20
2.55.0

