Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5475293FB
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651356; cv=none; b=nUufL+/wblmy0EjbAARjsAg1ULAURbczCODaKuIks3GihNu/Kay7IBWdz+xALS+797Jn/TSJ9fY6Nk4dnd7SYFYZ3XNRC7u6KkRSf+yMtIuAAE2CV41b7b4bg5oU8FynOo0eB2MfKAbutGLZdtcZNkIditO4uLxr5GclqrFTgms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651356; c=relaxed/simple;
	bh=l+TO9NE6ImvSXw6PM92ri2ML9EStT75wyf8AN11onHc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tXUVcYtQKe82PKcc2sPBxsZ/GatkYRioxcZjO6O/h9JmWZQKWDS6hJ570+SSt7bI7lPlz/KuRdZSjH+pFDemcZJCkMJXgrflHXe72R5Xh0BW472Mafqxe5k5rioykXcJ3lahkJ2C8fY00eW8hzUU7OHkFikD6qAc+busOA2bnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csRtA1hg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csRtA1hg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ADD1F00898;
	Thu, 17 Sep 2026 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651353;
	bh=czekthCnFjoHVaZxtoKcsHgTsKJQPhecxrE3HznNlBY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=csRtA1hgYpVH60KGs6juY53Sv2tmmCaAbnsg8zaRhymZd+rikyULPHgqP5Fs+VLKU
	 gZw+hrR++oTpHHCfSD0TGr04ydI5qXXCnHAEqa/I5CLN/QRz9wiLu5/evw15o8/PTK
	 eLl2tRppm0251fiYwnz2hSW87m67sHTeKBJFvNqzDIhmbgKV5XgDZSA9SmDLenwiJn
	 lEGeQJBp9PsPUybq79qGPkj1at6mvA1Vojk8MdkW7Xp3XPe1eKs+qim0DrITHFTYUU
	 7cehEYDQbyKylvd/7WfiCn0/J8p7P9TgHdQUEWk9OjgQD+EyZicinBBxgc9BOBTmgm
	 9fM0m+wkWDwTg==
Subject: Re: [PATCH net-next 1/3] net: rmnet: annotate data-races around
 port->data_format
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com
Date: Thu, 17 Sep 2026 13:22:32 +0000
Message-ID: <178965135273.22033.11370457643443204587@kernel.org>
In-Reply-To: <20260916132231.1780091-2-edumazet@google.com>
References: <20260916132231.1780091-2-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 1

- [Medium] Even with a single per-packet snapshot of port->data_format,
  the individual stages still resolve the checksum-version bits…
- [Low] The commit message of "net: rmnet: annotate data-races around
  port->data_format" documents concrete, user-visible wire-format…

Pre-existing issues:
- [Medium] port->rmnet_mode and port->bridge_ep are written with plain
  stores under RTNL (rmnet_newlink() at rmnet_config.c:163-164,…
- [Medium] rmnet_register_real_device() publishes the zero-initialized
  struct rmnet_port through netdev_rx_handler_register()…

--

net: rmnet: annotate data-races around port->data_format

This adds READ_ONCE()/WRITE_ONCE() annotations around
port->data_format, which is written under RTNL from rmnet_newlink() and
rmnet_changelink() but read from the RX and TX data paths without any
lock. The value is now sampled once per packet in
rmnet_map_ingress_handler() and rmnet_map_egress_handler() and passed
down to the MAP helpers instead of being re-read by each of them.

A couple of questions below about the commit message and about the
remaining asymmetry between the stages that consume the sampled value.

[Severity: Low]
The changelog describes concrete wire-format failures rather than just a
KCSAN annotation cleanup:

> so a concurrent rmnet_changelink() could produce
> a MAP header announcing a v5 csum header that was neither reserved
> nor written.

and

> rmnet_map_send_ack() could trim a dl csum
> trailer that the ingress path never accounted for.

Should this carry a Fixes: tag then?  Candidates would be
b6e5d27e32ef60 ("net: ethernet: rmnet: Add support for MAPv5 egress
packets"), which added the second read of port->data_format in
rmnet_map_add_map_header(), and 14452ca3b5ce ("net: qualcomm: rmnet:
Export mux_id and flags to netlink"), which made the flags runtime
configurable.

Without a tag, stable tooling will not pick this up.  If the intent is
net-next hardening instead (the third patch in the series,
"net: rmnet: no longer rely on RTNL in rmnet_fill_info()", is clearly a
refactor), would it be better to word the two paragraphs above as
theoretical rather than as observed packet corruption?

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index bed6f63facf25..59ef8b4ce5321 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c

[ ... ]

> @@ -342,14 +342,16 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (data[IFLA_RMNET_FLAGS]) {
>  		struct ifla_rmnet_flags *flags;
>  		u32 old_data_format;
> +		u32 data_format;
>  
>  		old_data_format = port->data_format;
>  		flags = nla_data(data[IFLA_RMNET_FLAGS]);
> -		port->data_format &= ~flags->mask;
> -		port->data_format |= flags->flags & flags->mask;
> +		data_format = old_data_format & ~flags->mask;
> +		data_format |= flags->flags & flags->mask;
> +		WRITE_ONCE(port->data_format, data_format);
>  
>  		if (rmnet_vnd_update_dev_mtu(port, real_dev)) {
> -			port->data_format = old_data_format;
> +			WRITE_ONCE(port->data_format, old_data_format);
>  			NL_SET_ERR_MSG_MOD(extack, "Invalid MTU on real dev");
>  			return -EINVAL;
>  		}

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> index d055a2628d8c9..d4fec2fff227c 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c

[ ... ]

> @@ -82,7 +83,7 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
>  
>  	skb->dev = ep->egress_dev;
>  
> -	if ((port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
> +	if ((data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
>  	    (map_header->flags & MAP_NEXT_HEADER_FLAG)) {
>  		if (rmnet_map_process_next_hdr_packet(skb, len))
>  			goto free_skb;

[ ... ]

> @@ -120,14 +122,16 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
>  		skb_push(skb, ETH_HLEN);
>  	}
>  
> -	if (port->data_format & RMNET_FLAGS_INGRESS_DEAGGREGATION) {
> -		while ((skbn = rmnet_map_deaggregate(skb, port)) != NULL)
> -			__rmnet_map_ingress_handler(skbn, port);
> +	data_format = READ_ONCE(port->data_format);
> +
> +	if (data_format & RMNET_FLAGS_INGRESS_DEAGGREGATION) {
> +		while ((skbn = rmnet_map_deaggregate(skb, data_format)) != NULL)
> +			__rmnet_map_ingress_handler(skbn, port, data_format);
>  
>  		consume_skb(skb);
>  	} else {
> -		if (rmnet_map_validate_packet_len(skb, port))
> -			__rmnet_map_ingress_handler(skb, port);
> +		if (rmnet_map_validate_packet_len(skb, data_format))
> +			__rmnet_map_ingress_handler(skb, port, data_format);
>  		else
>  			kfree_skb(skb);
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but the caller of
rmnet_map_ingress_handler() reads two more fields of the same struct
with plain loads while RTNL writers store them plainly:

drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:rmnet_rx_handler() {
	switch (port->rmnet_mode) {
	case RMNET_EPMODE_VND:
		rmnet_map_ingress_handler(skb, port);
		break;
	case RMNET_EPMODE_BRIDGE:
		rmnet_bridge_handler(skb, port->bridge_ep);
		break;
	}

done:
	return RX_HANDLER_CONSUMED;
}

The writers update the pair in two separate stores, in opposite orders.
rmnet_add_bridge() does:

	port->rmnet_mode = RMNET_EPMODE_BRIDGE;
	port->bridge_ep = slave_dev;

while rmnet_unregister_bridge() does:

	port->bridge_ep = NULL;
	port->rmnet_mode = RMNET_EPMODE_VND;

Can a concurrent receive observe rmnet_mode == RMNET_EPMODE_BRIDGE
together with bridge_ep == NULL?  rmnet_bridge_handler() only acts
inside "if (bridge_dev)", yet rmnet_rx_handler() still returns
RX_HANDLER_CONSUMED, so does the skb leak in that window?

Since the RX path being annotated here is the same one that reads these
fields, would it make sense to annotate rmnet_mode and bridge_ep in the
same series?  They are still plain accesses at the end of the series
(94ca9c4e3244).

[Severity: Medium]
This is a pre-existing issue, but it is closely related to the note in
the changelog that "the rx_handler is live and traffic can already be
flowing".  rmnet_register_real_device() publishes the zero-filled port
through the rx_handler before any receive-visible state is set:

drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c:rmnet_register_real_device() {
	port = kzalloc_obj(*port);
	...
	rc = netdev_rx_handler_register(real_dev, rmnet_rx_handler, port);
	...
	for (entry = 0; entry < RMNET_MAX_LOGICAL_EP; entry++)
		INIT_HLIST_HEAD(&port->muxed_ep[entry]);
}

port->rmnet_mode is only assigned later, in rmnet_newlink(), after
rmnet_vnd_newlink() and netdev_upper_dev_link().  The valid values are
RMNET_EPMODE_VND (1) and RMNET_EPMODE_BRIDGE (2), so during that window
rmnet_mode is 0, the switch in rmnet_rx_handler() matches neither case
and there is no default, but RX_HANDLER_CONSUMED is still returned.

Is a packet arriving on the real_dev in that window leaked?  Would it be
better to install a valid rmnet_mode before netdev_rx_handler_register()?

> @@ -139,14 +143,16 @@ static int rmnet_map_egress_handler(struct sk_buff *skb,
>  {
>  	int required_headroom, additional_header_len, csum_type = 0;
>  	struct rmnet_map_header *map_header;
> +	u32 data_format;
>  
>  	additional_header_len = 0;
>  	required_headroom = sizeof(struct rmnet_map_header);
>  
> -	if (port->data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4) {
> +	data_format = READ_ONCE(port->data_format);
> +	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV4) {
>  		additional_header_len = sizeof(struct rmnet_map_ul_csum_header);
>  		csum_type = RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
> -	} else if (port->data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5) {
> +	} else if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5) {
>  		additional_header_len = sizeof(struct rmnet_map_v5_csum_header);
>  		csum_type = RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
>  	}
> @@ -161,7 +167,7 @@ static int rmnet_map_egress_handler(struct sk_buff *skb,
>  						 csum_type);
>  
>  	map_header = rmnet_map_add_map_header(skb, additional_header_len,
> -					      port, 0);
> +					      data_format, 0);
>  	if (!map_header)
>  		return -ENOMEM;

[Severity: Medium]
The snapshot removes the race, but the stages still resolve the
checksum-version bits differently, so is the symptom named in the
changelog ("a MAP header announcing a v5 csum header that was neither
reserved nor written") still reachable when both egress bits are set,
now without any race?

Nothing appears to reject that combination: rmnet_policy only checks the
size of struct ifla_rmnet_flags, rmnet_rtnl_validate() only validates
the MUX ID, and both rmnet_newlink() and rmnet_changelink() apply
flags->flags & flags->mask verbatim.  RMNET_FLAGS_EGRESS_MAP_CKSUMV4
and RMNET_FLAGS_EGRESS_MAP_CKSUMV5 are independent uAPI bits.

On TX, this function picks V4 first, so
rmnet_map_checksum_uplink_packet() -> rmnet_map_v4_checksum_uplink_packet()
pushes a v4 header:

	ul_header = (struct rmnet_map_ul_csum_header *)
		    skb_push(skb, sizeof(struct rmnet_map_ul_csum_header));

while rmnet_map_add_map_header() looks at the raw V5 bit of the same
sampled word:

	/* Set next_hdr bit for csum offload packets */
	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5)
		map_header->flags |= MAP_NEXT_HEADER_FLAG;

Since the only caller passes pad == RMNET_MAP_NO_PAD_BYTES, the early
return keeps that flag.  Would passing the already-resolved csum_type
(or rejecting both version bits at configuration time) be preferable to
threading the raw bitmask, which only closes the race?

The same asymmetry exists on RX: rmnet_map_validate_packet_len() gives
INGRESS_MAP_CKSUMV4 precedence and adds 8 bytes of dl csum trailer,
__rmnet_map_ingress_handler() gives V5 precedence when
MAP_NEXT_HEADER_FLAG is set and consumes a 4-byte v5 header, and
rmnet_map_send_ack() trims 8 bytes purely on the V4 bit.  With both
ingress bits set, is a v5 frame rejected as 4 bytes short, and inside an
aggregate does rmnet_map_deaggregate() advance its cursor 4 bytes into
the following MAP header, breaking every later split point?

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> index add0f5ade2e61..d334727e1f525 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
> @@ -48,13 +48,13 @@ static u8 rmnet_map_do_flow_control(struct sk_buff *skb,
>  
>  static void rmnet_map_send_ack(struct sk_buff *skb,
>  			       unsigned char type,
> -			       struct rmnet_port *port)
> +			       u32 data_format)
>  {
>  	struct rmnet_map_header *map_header = (void *)skb->data;
>  	struct rmnet_map_control_command *cmd;
>  	struct net_device *dev = skb->dev;
>  
> -	if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4)
> +	if (data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4)
>  		skb_trim(skb,
>  			 skb->len - sizeof(struct rmnet_map_dl_csum_trailer));
>  

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index e6f48dc9fe64d..39d6d084e73f0 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -306,7 +306,7 @@ struct rmnet_map_header *rmnet_map_add_map_header(struct sk_buff *skb,
>  	memset(map_header, 0, sizeof(struct rmnet_map_header));
>  
>  	/* Set next_hdr bit for csum offload packets */
> -	if (port->data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5)
> +	if (data_format & RMNET_FLAGS_EGRESS_MAP_CKSUMV5)
>  		map_header->flags |= MAP_NEXT_HEADER_FLAG;
>  
>  	if (pad == RMNET_MAP_NO_PAD_BYTES) {
> @@ -351,9 +351,9 @@ u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port *port)
>  
>  	packet_len = ntohs(maph->pkt_len) + sizeof(*maph);
>  
> -	if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4) {
> +	if (data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4) {
>  		packet_len += sizeof(struct rmnet_map_dl_csum_trailer);
> -	} else if ((port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
> +	} else if ((data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
>  		   !(maph->flags & MAP_CMD_FLAG)) {
>  		/* Mapv5 data pkt without csum hdr is invalid */
>  		if (!(maph->flags & MAP_NEXT_HEADER_FLAG))

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916132231.1780091-1-edumazet%40google.com
