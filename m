Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A04756D8
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142662; cv=none; b=Jgdat/3b2iD1ZVOiyDrUjfA3oinLurip65ydRp+aFWfsOIgOADlpkjlNJSpWhn/KoQ/pxzKBHfInQ5viMmWYkExjNzVYe6f9a2a6iixRp8/BJgRKyr4bUojBH/MHc9nwTRtBU48zPDd/Yhh3GP57/jphrZLO2K+YJNHyWLk8Pmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142662; c=relaxed/simple;
	bh=bz+1pFb61D8CyKw2rY+IFoPp/qP45pxbbzohzmdgn1c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjHrF5ICNcslpsqVj8TieOSXDOE7ySXAO9SDM8OPlwEqf5Voq4Gci6TKFLA9hLS5vqxUAnKruESbdOj9ruhMJUg8ZY9KEUQbbl8ibVoGvN4qp0zh0WX0ZJQ0ytS8AtlDA0zoaDJrdPYRSCW81J4lTp176BiVtFbP4I+UXjUl2Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pJUDdDGj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pJUDdDGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792142661; x=1823678661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bz+1pFb61D8CyKw2rY+IFoPp/qP45pxbbzohzmdgn1c=;
  b=pJUDdDGjog/Z3hDrd5u6GO+iuONz6Wz2gApn4aVd4F+hPHBQRWEYfAx3
   3CsQMYicf2Z5z9CEt1gF7se6J0qMuxUkJCs5sAwIQ5zs2NSkmgaiLj/XN
   pIhb4Y421vPlF+yaspYDa6cliKaoiT6wmH2FJ6Q8MmcsEdWGcCwWJilz7
   OJiLsN7tkhiYOcY/UWLb+5BhrZA7rVpo+kBGyU/y5+HQGZUTlYQRECWzc
   CtN1ZyL+KO4Wi5Fs2hEmGDBVvIpp9RIbWDQX5xRAuj4ksAXETi6DD5FK+
   4N98/xnYqHnkkervOTJXfs99hR4/FYVlZP2plBv0gqUvME9qIfXBrL8yY
   A==;
X-CSE-ConnectionGUID: zOkwIjKTRC6JKaEcU7/9Eg==
X-CSE-MsgGUID: cdsi1meCTdKcL4VvVkivsA==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="232223609"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:24:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 16 Oct 2026 02:24:19 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 02:24:16 -0700
Date: Fri, 16 Oct 2026 11:24:16 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <netdev@vger.kernel.org>, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chintan Vankar <c-vankar@ti.com>, Danish
 Anwar <danishanwar@ti.com>, Daolin Qiu <d-qiu@ti.com>, "David S. Miller"
	<davem@davemloft.net>, Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Neelima Muralidharan <neelima@ti.com>, Paolo Abeni
	<pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>, Pratheesh Gangadhar
 TK <pratheesh@ti.com>, Richard Cochran <richardcochran@gmail.com>, Simon
 Horman <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v9 5/8] hsr: Use the port and header information
 in hsr_forward_skb()
Message-ID: <20261016092416.5ssargoekf74pcwn@DEN-DL-M70577.microsemi.net>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-5-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014-hsr_ptp-v9-5-2d20a2a0f816@linutronix.de>

> The upper layer can submit a port on which the skb should be sent and
> whether or not a HSR header should be added. Use this information while
> forwarding the packet:
> - If the port set, deliver it only on the requested port.
> - If a header is already present then skip parts of the stack:
>   - The packet originates from the master port and we don't want to
>     assign a sequence number to it, it needs to preserve the original
>     one.
>   - The existing h_source must be used (and not replaced).
>   - The node should already exist in the node_db if "other" packets are
>     exchanged. If the node information is not yet existing then
>     creating it makes no sense because it is used for deduplication of
>     incoming packets and this is not used in the PTP case. If no other
>     packets are exchanged then the node_db will age and then removed.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/hsr/hsr_forward.c  | 45 ++++++++++++++++++++++++++++++++++++---------
>  net/hsr/hsr_framereg.h |  2 ++
>  2 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 2b8ae9723bd7f..534798da48d53 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -426,7 +426,7 @@ static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
>  static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
>  		    struct hsr_frame_info *frame)
>  {
> -	if (frame->port_rcv->type == HSR_PT_MASTER) {
> +	if (frame->port_rcv->type == HSR_PT_MASTER && !frame->has_foreign_header) {
>  		hsr_addr_subst_dest(frame->node_src, skb, port);
>  
>  		/* Address substitution (IEC62439-3 pp 26, 50): replace mac
> @@ -547,11 +547,12 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
>  static void hsr_forward_do(struct hsr_frame_info *frame)
>  {
>  	struct hsr_port *port;
> -	struct sk_buff *skb;

Is this needed, or just cleanup?

>  	bool sent = false;
>  
>  	hsr_for_each_port(frame->port_rcv->hsr, port) {
>  		struct hsr_priv *hsr = port->hsr;
> +		struct sk_buff *skb = NULL;
> +
>  		/* Don't send frame back the way it came */
>  		if (port == frame->port_rcv)
>  			continue;
> @@ -570,6 +571,17 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
>  			continue;
>  
> +		/* PTP TX packets have an outgoing port specified */
> +		if (frame->req_tx_port != HSR_PT_NONE && frame->req_tx_port != port->type)
> +			continue;

This checks that if the frame is directed and that the frame is only send to the
directed port. Maybe the comments could be more clear about that.

> +		/* PTP TX packets may already have a HSR header which needs to
> +		 * be preserved
> +		 */
> +		if (frame->has_foreign_header && frame->skb_std) {
> +			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> +			goto inject_into_stack;
> +		}
> +
>  		/* Don't send frame over port where it has been sent before.
>  		 * Also for SAN, this shouldn't be done.
>  		 */
> @@ -597,6 +609,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		else
>  			skb = hsr->proto_ops->get_untagged_frame(frame, port);
>  
> +inject_into_stack:
>  		if (!skb) {
>  			frame->port_rcv->dev->stats.rx_dropped++;
>  			continue;
> @@ -661,6 +674,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *skb,
>  	struct hsr_port *port = frame->port_rcv;
>  	struct hsr_priv *hsr = port->hsr;
>  
> +	if (frame->has_foreign_header) {
> +		frame->skb_std = skb;
> +
> +		WARN_ON_ONCE(port->type != HSR_PT_MASTER);
> +		WARN_ON_ONCE(skb->mac_len < sizeof(struct hsr_ethhdr));
> +		return 0;
> +	}
>  	/* HSRv0 supervisory frames double as a tag so treat them as tagged. */
>  	if ((!hsr->prot_version && proto == htons(ETH_P_PRP)) ||
>  	    proto == htons(ETH_P_HSR)) {
> @@ -702,7 +722,8 @@ int prp_fill_frame_info(__be16 proto, struct sk_buff *skb,
>  }
>  
>  static int fill_frame_info(struct hsr_frame_info *frame,
> -			   struct sk_buff *skb, struct hsr_port *port)
> +			   struct sk_buff *skb, struct hsr_port *port,
> +			   enum hsr_port_type tx_port, bool has_hsr_header)
>  {
>  	struct hsr_priv *hsr = port->hsr;
>  	struct hsr_vlan_ethhdr *vlan_hdr;
> @@ -725,10 +746,15 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  	if (port->type == HSR_PT_INTERLINK)
>  		n_db = &hsr->proxy_node_db;
>  
> -	frame->node_src = hsr_get_node(port, n_db, skb,
> -				       frame->is_supervision, port->type);
> -	if (!frame->node_src)
> -		return -1; /* Unknown node and !is_supervision, or no mem */
> +	frame->req_tx_port = tx_port;
> +	frame->has_foreign_header = has_hsr_header;
> +
> +	if (!frame->has_foreign_header) {
> +		frame->node_src = hsr_get_node(port, n_db, skb,
> +					       frame->is_supervision, port->type);
> +		if (!frame->node_src)
> +			return -1; /* Unknown node and !is_supervision, or no mem */
> +	}
>  
>  	ethhdr = (struct ethhdr *)skb_mac_header(skb);
>  	frame->is_vlan = false;
> @@ -777,10 +803,11 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
>  	struct hsr_frame_info frame;
>  
>  	rcu_read_lock();
> -	if (fill_frame_info(&frame, skb, port) < 0)
> +	if (fill_frame_info(&frame, skb, port, tx_port, has_hsr_header) < 0)
>  		goto out_drop;
>  
> -	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
> +	if (!frame.has_foreign_header)
> +		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
>  	hsr_forward_do(&frame);
>  	rcu_read_unlock();
>  	/* Gets called for ingress frames as well as egress from master port.
> diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
> index 127a3fb64d5f0..e5e6363c0466f 100644
> --- a/net/hsr/hsr_framereg.h
> +++ b/net/hsr/hsr_framereg.h
> @@ -29,6 +29,8 @@ struct hsr_frame_info {
>  	bool is_from_san;
>  	bool dst_in_node_db;
>  	bool dst_in_proxy_node_db;
> +	bool has_foreign_header;
> +	enum hsr_port_type req_tx_port;

The same flag is hsr_hdr in the uAPI, has_header in hsr_dev_xmit(),
has_hsr_header in hsr_forward_skb() and has_foreign_header here. The
port is tx_port in some places and req_tx_port in others. Could the naming be
aligned?

>  };
>  
>  void hsr_del_self_node(struct hsr_priv *hsr);
> 
> -- 
> 2.55.0
>

/Daniel
