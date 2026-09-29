Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1977364EAB
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654149; cv=none; b=oVRljYmvDQToBnVR72KK7JkeygNAVf+3kWCYW+Yit8sQ7bhmIFvEttUFTYniohbEedNU5dpdeuwkl2Jc9FVbSM2Cl7qE+wnXhRrQtrRVYCDNp5L2qvH5T+gAe5Xnv0BqhD8Xm4TKNCJ1hZfZg1M+uhGappuaByuwiAM97DRDFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654149; c=relaxed/simple;
	bh=dO+m5Kjn/WxepUTogyBZdS3dV86zXPOizQP5rc2jbIE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tqwh1P1Ty+iMqqQ8clHdXqoHy0tR6e/Q2img76X8loWY9ZDfdrlutcYSIwWi3OBCLM6L4rzNDBTFiLfvbXVfIkX3RVvsc8G2djUsTg+Eos20szWWfBUhxWnej06k0bS69YHid0FhHyaxg3MTYWReu9qgG3OIULHFHjQff0uBnxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp/zVwkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp/zVwkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E1E1F000FF;
	Tue, 29 Sep 2026 03:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790654147;
	bh=M3FIVWFeQTq+ASvsWaTLigj5x4C/C6IgQ26uilVAtXk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kp/zVwkDMJgkxLSpRL4M4ZEVGiT+OUo7cfjdj04gEgZ5HYxauayUAw3fgDVzdB8IE
	 pEuUfRrHDh4cY4g/IZb34UDtvRWiTBrol28uCibAXnsWPGdiUsFraU7n9dccyNm0Wt
	 b4MXkDwbl0FOHSuQh7jDkYCUD643/s+DJDVSxwRhiWFXQj3e6d6BpDWO6yrkyiPPxw
	 Fg+TJY6Zw9TG8mQedTuFlFefMW5CM3ubVA/VTxB1WN244VcFIyOJj/6PQKxi/uX9+/
	 88EkCL0iojzrpgaY0i2FeKqvRd5u7camCq5R4UO9fv43bUidyhvWsS3RRQpi7hq51W
	 IyijGEjQZTJjg==
Subject:
 Re: [PATCH net] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, edumazet@kernel.org, bestswngs@gmail.com,
 willemb@google.com, jasowang@redhat.com, mst@redhat.com
Date: Tue, 29 Sep 2026 03:55:46 +0000
Message-ID: <179065414648.434549.9608467020285428237@kernel.org>
In-Reply-To: <20260927195536.2489079-1-edumazet@google.com>
References: <20260927195536.2489079-1-edumazet@google.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 2 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] net: uninitialized mac_header usage in
  __virtio_net_hdr_to_skb() causes OOB read
- [Medium] The commit message names the wrong trigger.
- [Medium] VLAN-tagged GSO frames without VIRTIO_NET_HDR_F_NEEDS_CSUM are
  now always dropped on the rerouted receive paths: tun IFF_TAP…

Pre-existing issues:
- [Low] UML raw_verify_header() now goes through the dissection branch
  (skb_set_network_header(skb, ETH_HLEN) at vector_transports.c:212),…

--

net: always dissect GSO packets in __virtio_net_hdr_to_skb()

This commit removes the skb->network_header condition in
__virtio_net_hdr_to_skb(), so every GSO packet without
VIRTIO_NET_HDR_F_NEEDS_CSUM is flow-dissected. It also adds a
virtio_net_hdr_match_proto() check on keys.basic.n_proto after dissection.
To support this, tun_get_user(), tun_xdp_one(), virtnet_receive_done() and
the UML raw_verify_header() now set skb->dev and skb->network_header before
they parse the vnet header.

Closes: https://lore.kernel.org/netdev/20260927163117.746432-2-bestswngs@gmail.com/

> However, skb->network_header is an offset from skb->head, not a boolean
> flag. When skb_headroom(skb) is 0 on a device without L2 headers (for
> instance packet_snd() or tpacket_snd() on a tunnel/pure-L3 device where
> LL_RESERVED_SPACE_EX(dev, 0) == 0), skb_reset_network_header(skb)
> legitimately sets skb->network_header to 0.

[Severity: Medium]
Is this trigger accurate? LL_RESERVED_SPACE_EX() always adds HH_DATA_MOD
(16), so it looks like it can never be 0:

include/linux/netdevice.h:
#define LL_RESERVED_SPACE_EX(dev, hlen) \
	((((hlen) + READ_ONCE((dev)->needed_headroom)) \
	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)

tpacket_fill_skb() reserves that amount before it resets the network
header:

	skb_reserve(skb, hlen);
	skb_reset_network_header(skb);

packet_snd() also reserves hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len)
before skb_reset_network_header(). The later skb_reserve(skb, -reserve)
moves back by only hard_header_len, and that is always less than hlen.
So on both AF_PACKET paths network_header seems to stay non-zero, and
those paths already took the dissect branch before this patch.

The callers that actually reached the unvalidated else if (gso_type)
fallback appear to be the ones that never set network_header, so it
stayed 0 from allocation: tun_get_user(), tun_xdp_one() (vhost-net),
virtnet_receive_done() and raw_verify_header(). These are the callers
this patch changes.

Could the commit message name those paths as the trigger instead? It
could also note that tun users, vhost-net guests and virtio devices can
reach the bug, rather than only CAP_NET_RAW AF_PACKET users.

> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index ddd127ee96785..e1fb2a76fdff5 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -209,6 +209,7 @@ static int raw_verify_header(
>  	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
>  		return 1;
>  
> +	skb_set_network_header(skb, ETH_HLEN);
>  	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
>  	return 0;
>  }

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. Now
that raw_verify_header() enters the dissection branch, it is worth
noting that it runs on an untrimmed skb and ignores the result.

prep_skb() sizes the skb to the whole preallocated buffer:

arch/um/drivers/vector_kern.c:prep_skb() {
    ...
	skb_put(result, vp->max_packet);
	result->data_len = len - vp->max_packet;
    ...
}

vector_legacy_rx() and vector_mmsg_rx() call vp->verify_header() before
pskb_trim(). As a result, the pskb_may_pull(skb, keys.control.thoff +
thlen) check and the gso_size threshold check compare against the buffer
size, not the received packet length.

raw_verify_header() also returns 0 whatever virtio_net_hdr_to_skb()
returns. Frames that fail validation are therefore still delivered, and
they can keep partial state such as CHECKSUM_PARTIAL from
skb_partial_csum_set() when a later transport offset check fails.

The out-of-bounds read this patch fixes does not look reachable here.
The UML linear area is max_packet in size and is never reallocated. Also,
every -EINVAL return happens before gso_size and gso_type are set, so a
rejected frame is delivered as a plain non-GSO skb.

Should the verify_header() callback run after pskb_trim(), and should a
failing virtio_net_hdr_to_skb() result cause the frame to be dropped?

[ ... ]

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index c381b916c1b54..8902d5a5c418c 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -111,48 +111,44 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		p_off = nh_min_len + thlen;
>  		if (!pskb_may_pull(skb, p_off))
>  			return -EINVAL;
> -	} else {
> +	} else if (gso_type) {
>  		/* gso packets without NEEDS_CSUM do not set transport_offset.
>  		 * probe and drop if does not match one of the above types.
>  		 */

[ ... ]

> +		if (!skb->protocol) {
> +			__be16 protocol = dev_parse_header_protocol(skb);
>  
> -			skb_set_transport_header(skb, keys.control.thoff);
> -		} else if (gso_type) {
> -			p_off = nh_min_len + thlen;
> -			if (!pskb_may_pull(skb, p_off))
> +			if (!protocol)
> +				virtio_net_hdr_set_proto(skb, hdr);
> +			else if (!virtio_net_hdr_match_proto(protocol,
> +							     hdr_gso_type))
>  				return -EINVAL;
> +			else
> +				skb->protocol = protocol;
>  		}

[Severity: Critical]
Does this read an uninitialized mac_header on the rerouted receive
paths?

After this change, tun_get_user() sets skb->dev and network_header
before it calls tun_vnet_hdr_tnl_to_skb(). However, eth_type_trans()
now runs afterwards, so skb_reset_mac_header() has not been called yet
and skb->protocol is still 0. For a GSO frame without
VIRTIO_NET_HDR_F_NEEDS_CSUM, the dissect branch is now always taken.
With skb->dev set, dev_parse_header_protocol() reaches the Ethernet
parse_protocol callback:

tun_get_user()
  skb->dev = tun->dev;
  skb_set_network_header(skb, ETH_HLEN);   /* mac_header still ~0 */
  tun_vnet_hdr_tnl_to_skb()
    virtio_net_hdr_tnl_to_skb()
      virtio_net_hdr_to_skb()
        __virtio_net_hdr_to_skb()
          dev_parse_header_protocol()
            eth_header_parse_protocol()
              eth_hdr(skb)->h_proto   /* skb->head + 0xffff */

The skb comes straight from tun_alloc_skb() or tun_build_skb(), so
mac_header still holds the ~0 value set at allocation. eth_hdr()
therefore returns skb->head + 0xffff, and h_proto is read far past the
end of the linear buffer. With CONFIG_DEBUG_NET this should also trip
the skb_mac_header_was_set() warning in skb_mac_header().

Before this patch these callers had skb->dev == NULL and
network_header == 0, so they never reached
dev_parse_header_protocol().

tun_xdp_one() and virtnet_receive_done() have the same ordering. The
skb is built with build_skb() or the virtio_net receive helpers, and
mac_header is never set. The patch then sets skb->dev and
network_header, and eth_type_trans() only runs after
virtio_net_hdr_tnl_to_skb().

This looks reachable by anyone holding a tap fd with IFF_VNET_HDR, by
a vhost-net guest, and by the virtio-net device. The ethertype that
virtio_net_hdr_match_proto() compares against is also just whatever
happens to be at that address.

Would it be enough to call skb_reset_mac_header() together with
skb_set_network_header(skb, ETH_HLEN) in these callers?
eth_type_trans() resets it again afterwards anyway. Alternatively,
setting skb->protocol from the Ethernet header first, as
tap_get_user() does, would skip dev_parse_header_protocol()
altogether.

Could raw_verify_header() also be checked? It now sets network_header
but not mac_header. Depending on whether the UML receive path has set
skb->dev at that point, dev_parse_header_protocol() will either
dereference a NULL skb->dev or hit the same unset mac_header.

[Severity: Medium]
Will VLAN-tagged GSO frames without VIRTIO_NET_HDR_F_NEEDS_CSUM now be
dropped on the rerouted receive paths?

In tun_get_user() (IFF_TAP), tun_xdp_one(), virtnet_receive_done() and
raw_verify_header(), network_header and skb->dev are now set, but
skb->protocol is still 0 at this point, because eth_type_trans() runs
afterwards. For an in-band 802.1Q or 802.1AD frame the call chain looks
like this:

tun_get_user()
  skb_set_network_header(skb, ETH_HLEN);   /* skb->protocol == 0 */
  tun_vnet_hdr_tnl_to_skb()
    virtio_net_hdr_tnl_to_skb()
      virtio_net_hdr_to_skb()
        __virtio_net_hdr_to_skb()
          dev_parse_header_protocol()
            eth_header_parse_protocol()
              return eth->h_proto;   /* ETH_P_8021Q or ETH_P_8021AD */
          virtio_net_hdr_match_proto(protocol, hdr_gso_type) -> false
          return -EINVAL;

This rejection happens before skb_flow_dissect_flow_keys_basic() runs.
The dissector handles ETH_P_8021Q and ETH_P_8021AD and reports the inner
protocol in keys.basic.n_proto, so the new post-dissection check would
accept these frames:

	    !virtio_net_hdr_match_proto(keys.basic.n_proto,
					hdr_gso_type))

Before this patch, these callers had network_header == 0 and took the
else if (gso_type) fallback, which accepted such frames.

The peer callers behave differently. tap_get_user() and
tap_get_user_xdp() set the protocol beforehand, which skips the L2
pre-check:

	skb->protocol = eth_hdr(skb)->h_proto;

af_packet sets it in packet_parse_headers(). Both paths accept the same
frames, so macvtap and AF_PACKET accept input that tun, vhost-net and
virtio_net now reject.

On the rejecting paths, virtio_net counts the drop in rx_frame_errors,
and tun increments rx_frame_errors and returns -EINVAL.

Would it make sense to drop the pre-dissection ethertype match now that
n_proto is checked after dissection? Alternatively, the callers could set
skb->protocol from the Ethernet header first, as tap.c does.

The commit message also doesn't mention this change in behaviour.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927195536.2489079-1-edumazet%40google.com
