Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317023;
	b=Q/IipiDRamQ0tOSrcGDcwDgDuhYTsn63OjUi2/s+gVAJiPK5J3qKamdY/UzexH6O26q7
	 lHKso6x/8e82YMztkSuMFthp3JFmMF0S57aqsVwTJss74BZiGJk6uU0Xy2OB8Y7Ow0rBy
	 nPaCwWm8LjAN4qMex6i5NdTpnNlabVIcLC6yqwX+s7Eh7S0wb58+4nFCxMpHKAmr8NSt/
	 1vAx1bvCbuHNbQxiPE/pXqh1BK/KlS6youtQNN95JNzTv1wEpgcvjtseH2mvkVUM5B0o3
	 cME1ladKh39TriIiVbhxj9UvKHjSlAkwGwg0/GV+s1FKNpbHrDsvxuofCsi4H3mypOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317023;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rad5lPGCvQqPjNNC3Pwf0T3Sj+x/grDZhtZ0KLC0wkg=;
	b=wyG+RmOibi10dwlqD0cMj4C+mvnBavtTdZ1+e9QSAb3926347UNNajbV11GNiLTqhJVx
	 0vG9metVTpd/cUD+0dSSnh+4sWJpPZw5HZXoFhgOtJeyr2249I4Q249Im1BB8VhHZktCI
	 Un1zKmykLRLBu+4itjUmjt/OEpLhsiTRAR0DnICZPUdbRao63uEtsqbW0IoGNPCcuTWxb
	 YY33c8ykHz+WrtpRom+CkFQcRHKG1Wb8CgsGngvaOlYPiTrMwC1wr6kWfKUnEK0/0DWfm
	 m5ypC4jNXFfcEDNQKoFBxZ2jibF/+432ufVikcn38gwrKOJS6X3TRIWdbWulMgSLW9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=pF4PTX3O;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC374606B2F2
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC374606B2F2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=pF4PTX3O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794317030; x=1825853030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nV5vw8d6BwUyewK2/Tyx2B4D4KC0DHvpvgBUMMJQutA=;
  b=pF4PTX3OPc5j9XHCSwlb9ZYAb9qC/9XQCsW3dFlpXcKxFCjsQmNBYy54
   tHmGonPqcbrPw3XL3WRg/naY8D0fCl9xR4nzGFLhmXdrzJELjxGY+D1fu
   an7dkWdAFTFCwJnBmKeqprBJlqk1PR2fuifuzQ1BXsRcjmogM4aIBjufh
   oELrNSeRS2heG5YyOOyDKf2mkhb75glS7WLqjKtReKb3580kerSGEGSYN
   loSitwQ6he85x4z/RUmpYq+7TOPdunglDIufMxyleKz5RI8OnH7SkFS9L
   7jgiU7+vgRyzBQgKalewt6xHR1A8gIeppKqSbMMr0i9DyjRuaM+ybLSAd
   w==;
X-CSE-ConnectionGUID: jlDY+4DAQBCWdBd9WjnR9g==
X-CSE-MsgGUID: wspN/FKtQH+tukRK5zyC7g==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="76950600"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:23:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 10 Nov 2026 06:23:41 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 06:23:38 -0700
Date: Tue, 10 Nov 2026 14:23:37 +0100
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
Subject: Re: [PATCH net-next v10 5/8] hsr: Use the port and header
 information in hsr_forward_skb()
Message-ID: <20261110132337.2h42rt4xh5h4dc3x@DEN-DL-M70577>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
 <20261104-hsr_ptp-v10-5-2c4a38ad973c@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104-hsr_ptp-v10-5-2c4a38ad973c@linutronix.de>

Hi Sebastian,

A few minor nits for you to consider or ignore.

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
> This is only used in the pure software version. Hardware with any kind
> of NETIF_F_HW_* offload support need to be addressed separately.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/hsr/hsr_forward.c  | 45 +++++++++++++++++++++++++++++++++++++--------
>  net/hsr/hsr_framereg.h |  2 ++
>  2 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index f49d962337f8b..d2a11d4560309 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -426,7 +426,7 @@ static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
>  static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
>  		    struct hsr_frame_info *frame)
>  {
> -	if (frame->port_rcv->type == HSR_PT_MASTER) {
> +	if (frame->port_rcv->type == HSR_PT_MASTER && !frame->has_hsr_header) {
>  		hsr_addr_subst_dest(frame->node_src, skb, port);
>  
>  		/* Address substitution (IEC62439-3 pp 26, 50): replace mac
> @@ -552,6 +552,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  
>  	hsr_for_each_port(frame->port_rcv->hsr, port) {
>  		struct hsr_priv *hsr = port->hsr;
> +

Nice little clean-up, sneaky :-)

>  		/* Don't send frame back the way it came */
>  		if (port == frame->port_rcv)
>  			continue;
> @@ -570,6 +571,19 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
>  			continue;
>  
> +		/* If this frame has a specific outgoing port specified (by the
> +		 * sender) then send it on this port only.
> +		 */
> +		if (frame->req_tx_port != HSR_PT_NONE && frame->req_tx_port != port->type)
> +			continue;

This could easily be wrapped at 80 to avoid the warning.

> +		/* If this TX frame already has a HSR header then forward the
> +		 * frame with it and don't add one.
> +		 */
> +		if (frame->has_hsr_header && frame->skb_std) {
> +			skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> +			goto inject_into_stack;
> +		}
> +
>  		/* Don't send frame over port where it has been sent before.
>  		 * Also for SAN, this shouldn't be done.
>  		 */
> @@ -597,6 +611,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		else
>  			skb = hsr->proto_ops->get_untagged_frame(frame, port);
>  
> +inject_into_stack:
>  		if (!skb) {
>  			frame->port_rcv->dev->stats.rx_dropped++;
>  			continue;
> @@ -661,6 +676,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *skb,
>  	struct hsr_port *port = frame->port_rcv;
>  	struct hsr_priv *hsr = port->hsr;
>  
> +	if (frame->has_hsr_header) {
> +		frame->skb_std = skb;
> +
> +		WARN_ON_ONCE(port->type != HSR_PT_MASTER);
> +		WARN_ON_ONCE(skb->mac_len < sizeof(struct hsr_ethhdr));
> +		return 0;
> +	}
>  	/* HSRv0 supervisory frames double as a tag so treat them as tagged. */
>  	if ((!hsr->prot_version && proto == htons(ETH_P_PRP)) ||
>  	    proto == htons(ETH_P_HSR)) {
> @@ -702,7 +724,8 @@ int prp_fill_frame_info(__be16 proto, struct sk_buff *skb,
>  }
>  
>  static int fill_frame_info(struct hsr_frame_info *frame,
> -			   struct sk_buff *skb, struct hsr_port *port)
> +			   struct sk_buff *skb, struct hsr_port *port,
> +			   enum hsr_port_type req_tx_port, bool has_hsr_header)
>  {
>  	struct hsr_priv *hsr = port->hsr;
>  	struct hsr_vlan_ethhdr *vlan_hdr;
> @@ -725,10 +748,15 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>  	if (port->type == HSR_PT_INTERLINK)
>  		n_db = &hsr->proxy_node_db;
>  
> -	frame->node_src = hsr_get_node(port, n_db, skb,
> -				       frame->is_supervision, port->type);
> -	if (!frame->node_src)
> -		return -1; /* Unknown node and !is_supervision, or no mem */
> +	frame->req_tx_port = req_tx_port;
> +	frame->has_hsr_header = has_hsr_header;
> +
> +	if (!frame->has_hsr_header) {
> +		frame->node_src = hsr_get_node(port, n_db, skb,
> +					       frame->is_supervision, port->type);

Also here.

> +		if (!frame->node_src)
> +			return -1; /* Unknown node and !is_supervision, or no mem */
> +	}
>  
>  	ethhdr = (struct ethhdr *)skb_mac_header(skb);
>  	frame->is_vlan = false;
> @@ -777,10 +805,11 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
>  	struct hsr_frame_info frame;
>  
>  	rcu_read_lock();
> -	if (fill_frame_info(&frame, skb, port) < 0)
> +	if (fill_frame_info(&frame, skb, port, req_tx_port, has_hsr_header) < 0)
>  		goto out_drop;
>  
> -	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
> +	if (!frame.has_hsr_header)
> +		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
>  	hsr_forward_do(&frame);
>  	rcu_read_unlock();
>  	/* Gets called for ingress frames as well as egress from master port.
> diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
> index 127a3fb64d5f0..dc13819d04098 100644
> --- a/net/hsr/hsr_framereg.h
> +++ b/net/hsr/hsr_framereg.h
> @@ -29,6 +29,8 @@ struct hsr_frame_info {
>  	bool is_from_san;
>  	bool dst_in_node_db;
>  	bool dst_in_proxy_node_db;
> +	bool has_hsr_header;
> +	enum hsr_port_type req_tx_port;
>  };
>  
>  void hsr_del_self_node(struct hsr_priv *hsr);
> 
> -- 
> 2.55.0
> 

/Daniel
