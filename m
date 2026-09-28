Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C96311C2D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599193; cv=none; b=C5RFR1FWgarPsw3qd4+BcmCLMHjSWW05VSAHmFtMwUKo0Tg25VfdhdV6zY4Jq3BI+EGyoimZD/oBZsQoIeGCS8/ydiS+kTFUcdq77dhtGBqDfWI3LJMmuCMGwxMTvT6RnwPZTfrK83Ecj13cA8UhGfqk2xLbO2RhZW7MVjfwlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599193; c=relaxed/simple;
	bh=mz0tkl4A6nJH0ZC7sZzzfC94ReAF7nIEBIL4Tp7daIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXghNJI2txby8uMY78Ls4AXIVQVwchEr6SHCSTO0MWbRa3vRSrR7TraegymKuu6BVGn36tq1gBIjKMpDq4ZmbjXvGMB15aNf1EP+m6zSS1CpHtPj5EQI2u0SgkLsyImySC9CjzMCq9KEoXNC+erRYHBu+y2Zl/Q9qu3cJ/zPWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NWUnx5Tj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=44ozzDIb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NWUnx5Tj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="44ozzDIb"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790599190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LK2wfhOXfEMS882MHFApxO+wMVCsgEjRs7CU1SzUfgs=;
	b=NWUnx5TjQoLra0eNn9YzbiDBzcFgrlBA+b2O8nEzlCAT7NJ7xiVgU8tGXGeyOsK0/AHFWS
	xUtH/5+mjL4UahmIcrztmk5UxNRb4nyhCaNkY9yRqQyB1iTwtWmJZhqho2avZvm7cTEZL5
	ywCC/Rc5Kgzw5usWp0f8vuVkmPYp2cQ42jYqfaz0zM7+IsHvElGwo4oAmiBcgP+XaQxaNu
	XvGGLQo3Wl4+GHAfQF8G7Ncqy+s2Lz5Y+W2Z6T0ZN3Bd5dj+DhWTVXeyYxQ708GAeFLo5m
	FX7P+TlaU+9rocIwgdCPe3SQmAFebFPPtENTTC20dN8xVYi39MfTeqeWgQTmSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790599190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LK2wfhOXfEMS882MHFApxO+wMVCsgEjRs7CU1SzUfgs=;
	b=44ozzDIb9yfP6BS5PVfYAj1weOKNpMn7mlkuc4cUy3ucYrY68S7g7E4hV8+evtB0gBBibe
	VouMhwESTOs5ILBw==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v7 5/8] hsr: Use the port and header information in hsr_forward_skb()
Date: Mon, 28 Sep 2026 14:39:39 +0200
Message-ID: <20260928-hsr_ptp-v7-5-d55d304d9a7e@linutronix.de>
In-Reply-To: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
References: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
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
    exchaned. If the node information is not yet existing then
    creating it makes no sense because it is used for deduplication of
    incoming packets and this is not used in the PTP case. If no other
    packets are exchanged then the node_db will age and then removed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_forward.c  | 45 ++++++++++++++++++++++++++++++++++++---------
 net/hsr/hsr_framereg.h |  2 ++
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index bf5b8c7fad306..2ce31b1da7b35 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -428,7 +428,7 @@ static void hsr_deliver_master(struct sk_buff *skb, str=
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
@@ -549,11 +549,12 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, str=
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
@@ -572,6 +573,17 @@ static void hsr_forward_do(struct hsr_frame_info *fram=
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
@@ -599,6 +611,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		else
 			skb =3D hsr->proto_ops->get_untagged_frame(frame, port);
=20
+inject_into_stack:
 		if (!skb) {
 			frame->port_rcv->dev->stats.rx_dropped++;
 			continue;
@@ -663,6 +676,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *=
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
@@ -704,7 +724,8 @@ int prp_fill_frame_info(__be16 proto, struct sk_buff *s=
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
@@ -727,10 +748,15 @@ static int fill_frame_info(struct hsr_frame_info *fra=
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
@@ -779,10 +805,11 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_=
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

