Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957287;
	b=GCRn0L/d5WuxmkzR0eZVGvPG2rZwK9Ay+llmgrgbN0g4G0pEeIuGQbgbZIUUqnXGM0O1
	 UWUUDXZKhS30glLxjEFOQA9UZp1X7mUmVO2fz62gNJjgsfNCxyJ7+xD8zI2HraLGt1DpM
	 spo7TDjzJZdZWf4+5PfdE/3Z4nQA+OjfB5UvoRrPp5X3BYnUr2xHQmYcHQT7V4In1eb9c
	 jzvGlKsFyDHtZShbkKAyp6txBfvbi4t4HJVa0owXfBIhzCIWIGQ/DGPjHA6zN9JK100FP
	 g8OGYgGKGU4BC6y95nVsvknnar9oZY098VIuigjB+jFmdCNzMC7pytdJ9nhb63jl/7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957287;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fszTkOxXJjM0EYFwIAQ+ySQBrU3sfgT5b3oAiln/BOM=;
	b=Fft/AsXR+kIQaiVmVAKg4/IrKndn6/E6GZgNK1Bq9xyqzM0IQemJ0QFwEnNmYeExkjas
	 E+RhRetNB2HwHlnmIzjpnyaEHX+R4pZ5+MgKiXaVxouWeuTH/AdQOXEYN1sdIODd9aLsu
	 ORlLMaNO9fH/FvO68+oF/pGfV5uwrCNQUS3GJ3+EmPdP30/+6DPxeXRzuCp1QsqTeFvab
	 gza87/UUFTdpNRB25YIiJSNz0myZSZ9ny3mj1/FVWgbve4lXP5xpMEKBu7e7SDMdCqNXa
	 6rlxi2uzCt0HUf7kC5HlAaFVh66hTQFf8rt+sZnzAqUJlJyROKmD8mPO2GLbjGV8zzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="S/aLais3";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZCQrLpVt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C18606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C18606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S/aLais3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZCQrLpVt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793957285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fszTkOxXJjM0EYFwIAQ+ySQBrU3sfgT5b3oAiln/BOM=;
	b=S/aLais3UyujT3jL9RjhcI2p1nw1+uLNEUpmOoCGAMCvLEmSebCwtncpEbHJ4fyHy/mRiE
	A1kXgzg51BYHzv5JsHCQjRCS2ZiJX703t9H6OIn/o6Ycpufpp4Y9Hg4j0lFTnBs3Hv/U0m
	4PkoztCZF5wag5cpKtwUr3EbXw66uGc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-3XwX5IoiNbKU5z7m6fTklg-1; Fri, 06 Nov 2026 04:28:04 -0500
X-MC-Unique: 3XwX5IoiNbKU5z7m6fTklg-1
X-Mimecast-MFC-AGG-ID: 3XwX5IoiNbKU5z7m6fTklg_1793957283
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49febef74e3so9825985e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793957283; x=1794562083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fszTkOxXJjM0EYFwIAQ+ySQBrU3sfgT5b3oAiln/BOM=;
        b=ZCQrLpVt1UUgl8eUdZCzFox197KeEPoeXUP7hQfGmZ7/4UWYA0NR9qZO2n/VgtVz7w
         JyuSEuW0H9qryS+mI920fymBisDxEMy6zYA0qvjx7lpf6o7TsNf7/ou8kDMgePn38XrD
         TmRWXQUxN1Z91ViiNHNRZmdrdWbQL6nckXdlrpgtbeb+9fKQ3qeRG246e6OBU8v5nImk
         kecJ8/lULkSdbz7+5mKAoEsXyIF6mch7+IgZBxotOk+StjXMebQM3EfCQ02SbL8xTXq/
         8yR9CEsrYs+f4rmX++WLtMnlsbjW9eXFhc8mDAeuY9UEWPslqFDvbqVQjaM0Err/S4rD
         BK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957283; x=1794562083;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fszTkOxXJjM0EYFwIAQ+ySQBrU3sfgT5b3oAiln/BOM=;
        b=JBkfggh8FtxpFLVkULZVo/6W+tsVoOxxpIR7Z0qew8IG2haIfp3ituANWVoZyHAQUq
         5wP27wmI5XArXwerdTYAvJt8Q/oSmJLWT2/4FhPgYsTMCb+odvm8xYEU1y87jiMRDxOX
         9tX3CsGWgPwghzxm4Ei6sT7w9w9w7jVzMuyIxzqIJxYoKaND6zq8rjfn8e3Nh+ONY3KO
         JGWKYR/XgTYhvvesNc8AeXpVImDMRFyGVSR+rwW2vIO/M/ahqIx7ye5BsW6uweiH2ASt
         4CMO+KAKJzPIjEmkNX6qUkj04bXrCa8szXRs5LMMKwhA3xce8NzDWDlScVnZl774FmUp
         f7Ug==
X-Gm-Message-State: APuU4Z/rPCR5lBLE9rnZLQ/Be2KhphduuaprGN7KQGnlTN7BxjX5oUK7
	oy2HPxm/QrqC+gn2Tg1L+01FFzxKNmBz//R/DgscIM9CkFZPNU/Rx/qjZR+uZleH/YIguks14nH
	Hbl8iSWHMtjQk2U5pGd8nr2K64Ndmmd8skePJtTJoioiiVwL4G4C/7T0khw==
X-Gm-Gg: AYBFou3Uj1AdC8XGG3yLmG+zYI8RzgFgTp1oWa5/p9GqrhZc0dBeFCPYZfcnhBs5SRD
	yD99tOMR98i9vQdc5Iu1gAY3DCeAX1vPR+KkVcLNwateWh0m5eTkXAyTAGm7Be/s1RZHRHplpb0
	TzPKohA+n31bbJVDHIu4z0hmsnWsX5H+ePLo5BiVTp+cnWpUVKisIiaFbMpMa6hc4DpxxkwnMZ+
	VUplWpMwmw1Dj2fPS2z/T04ICfX4vyPYIfVYVSDaQF3EQatC6wZM6+i+/j144JtJ6kLdo5bOaCa
	4BqgXqtI4PzngcAERQtKv5MU5Bz17FTPNmRJ3ZO9dh5iTr3g5anAVjiuHATObQt42E0EDmd1frH
	9VeCboQu7TOx1YRtLE9qyDeEBDGZme1BuW/WFbD7hqg==
X-Received: by 2002:a05:600c:c87:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4b6dff855c7mr27874425e9.13.1793957282593;
        Fri, 06 Nov 2026 01:28:02 -0800 (PST)
X-Received: by 2002:a05:600c:c87:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4b6dff855c7mr27874045e9.13.1793957282051;
        Fri, 06 Nov 2026 01:28:02 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1401:db00:7367:7b9e:e66f:2b7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba0f3sm120602055e9.9.2026.11.06.01.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:28:01 -0800 (PST)
Date: Fri, 6 Nov 2026 04:27:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v3 2/8] net: virtio: do not use dev->type to find the
 outer L3 header
Message-ID: <20261106042744-mutt-send-email-mst@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-3-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105115715.1466924-3-edumazet@kernel.org>

On Thu, Nov 05, 2026 at 12:57:09PM +0100, Eric Dumazet wrote:
> virtio_net_l3_start() decides from skb->dev->type whether the frame
> starts with an Ethernet header. tun decides it from the IFF_TAP and
> IFF_TUN flags, and TUNSETLINK can set the type of a down tun device
> to any value, without changing the flags.
> 
> On an IFF_TAP device set to ARPHRD_NONE, the outer protocol checks
> look at the IP header at the network header (ETH_HLEN), and never read
> the Ethernet header. eth_type_trans() then sets skb->protocol from an
> unchecked h_proto, for instance ETH_P_NSH, and the packet can reach
> the skb_under_panic() addressed by the previous patch.
> 
> On an IFF_TUN device set to ARPHRD_ETHER, the checks validate an
> Ethernet header that tun then treats as the start of the L3 header.
> 
> Checking in tun that the device type matches the framing is not
> enough: the type is read again later, and a concurrent TUNSETLINK can
> change it in between, since tun_get_user() only drops packets of a
> down device after these checks.
> 
> Add a has_eth argument to virtio_net_hdr_tnl_to_skb(), passed down to
> virtio_net_l3_start(), so the device type is no longer used:
> 
> - virtio_net always receives Ethernet frames.
> - tun_get_user() passes whether the device is IFF_TAP.
> - tun_xdp_one() always calls eth_type_trans() on its frames.
> 
> Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/sashiko-outbox-198573@kernel.org/
> Link: https://lore.kernel.org/netdev/179387332014.488856.9111956413610107951@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c          |  9 +++++++--
>  drivers/net/tun_vnet.h     |  5 +++--
>  drivers/net/virtio_net.c   |  2 +-
>  include/linux/virtio_net.h | 27 +++++++++++++--------------
>  4 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e601..3920b3dff1e8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1944,7 +1944,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		break;
>  	}
>  
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
> +				    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;
> @@ -2621,7 +2622,11 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
>  	skb->dev = tun->dev;
>  	skb_set_network_header(skb, ETH_HLEN);
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> +	/* Frames always start with an Ethernet header here, as the
> +	 * eth_type_trans() call below expects.
> +	 */
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr,
> +				    true)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
>  		ret = -EINVAL;
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index f4c652b1fa44..3364e08dd6e0 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -197,9 +197,10 @@ static inline netdev_features_t tun_vnet_hdr_guest_features(int vnet_hdr_sz)
>  static inline int
>  tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
>  			struct sk_buff *skb,
> -			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
> +			const struct virtio_net_hdr_v1_hash_tunnel *hdr,
> +			bool has_eth)
>  {
> -	return virtio_net_hdr_tnl_to_skb(skb, hdr,
> +	return virtio_net_hdr_tnl_to_skb(skb, hdr, has_eth,
>  				features & NETIF_F_GSO_UDP_TUNNEL,
>  				features & NETIF_F_GSO_UDP_TUNNEL_CSUM,
>  				tun_vnet_is_little_endian(flags));
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe..ed20e76fbc4c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2533,7 +2533,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  
>  	skb->dev = dev;
>  	skb_set_network_header(skb, ETH_HLEN);
> -	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> +	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, true, vi->rx_tnl,
>  				      vi->rx_tnl_csum,
>  				      virtio_is_little_endian(vi->vdev))) {
>  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 357116c2a148..b7b6b542f476 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -87,20 +87,18 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
>  }
>  
>  /* Where does the L3 header start, and what protocol is it?
> - * Handles Ethernet and VLAN headers; other devices use the
> - * network header offset the caller set up.
> + * With @has_eth, the frame starts with an Ethernet header, possibly
> + * followed by VLAN tags. Otherwise the L3 header starts at the network
> + * header offset the caller set up.
> + *
> + * The caller knows how the frame will be parsed later: the device
> + * type does not tell, as tun can change it with TUNSETLINK.
>   */
>  static inline bool
> -virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +virtio_net_l3_start(struct sk_buff *skb, bool has_eth, int *nhoff,
> +		    __be16 *proto)
>  {
> -	/* skb->dev should always be set here already,
> -	 * but let's not crash when it is not.
> -	 */
> -	if (WARN_ON_ONCE(!skb->dev))
> -		return false;
> -
> -	if (skb->dev->type == ARPHRD_ETHER ||
> -	    skb->dev->type == ARPHRD_LOOPBACK) {
> +	if (has_eth) {
>  		__be16 h_proto;
>  
>  		if (!pskb_may_pull(skb, ETH_HLEN))
> @@ -431,7 +429,7 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>   * carries, with UDP following it at @outer_th.
>   */
>  static inline bool
> -virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
>  			  unsigned int outer_th)
>  {
>  	int nhoff;
> @@ -439,7 +437,7 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
>  	unsigned int thoff;
>  	int ip_proto;
>  
> -	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> +	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
>  		return false;
>  	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
>  		return false;
> @@ -452,6 +450,7 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> +			  bool has_eth,
>  			  bool tnl_hdr_negotiated,
>  			  bool tnl_csum_negotiated,
>  			  bool little_endian)
> @@ -505,7 +504,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> -	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
>  		return -EINVAL;
>  
>  	/* In case of USO, the inner protocol is still unknown and
> -- 
> 2.53.0

