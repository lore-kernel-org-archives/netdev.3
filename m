Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504424;
	b=fj7K2GCIJ+EKPfkdMU1n82+fFB9qc4I4TOhcTIUAYy7X6qDf2R5CzQCpD0B6ePZm3rVO
	 gZ7Yei6Jha+fehqwc4Z5SBuQr7aSHMOBOhx3fzMm5oJw/B2yJ0MlHuiVIfceXynEXTS3B
	 3c4yqGOtUlNl1spTKQw3rXHpNbq6Yf+h8BE1WVDv9TQDLK5fc+/c5C3u9nWHHvksz5j80
	 WIZf7JVhccKkNSRKGWS+Y6gLDilwOf/Y7o04B2YZw/SmHWfQE9qKcF7wm5StZnFCiF84/
	 uvj1ryMk+j3+6e6/NA9XKPB9XU5PD/SbYLp0QmbJf1VR5GjVMfXy9hzCPYTnLHl79eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504424;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Fm6me2Tx8KhS46QP/LJuMR1NMJOWqBPzD8rb/WA+wSU=;
	b=Ws2DIRYyZBpdFL7GNatPf0aLagA4HdVsG/YxsINR0mG9QB0lWIyu/emwNGsLjyGxsJya
	 W0iOOW+g6DHvB9512aU4t1viZcKfZSgulSM+TIiPrhqPlRC/+0KgIDT7JT2SQ32Z0CekT
	 R/ldr6DpYHavifWKf68zElZgoRhA2ZYHhpsVKSNtIiBci3Sdpelc4u9+TogDopZd8vaym
	 kGwMQiT9lQ0lOW/sV7ibHVnTYPhARKd1uZ+ZY06xdTyAODwGU1dMcTzKl5kWZS3i0+avf
	 8ocD88i/Kq2ceeIy8ljhD1PPBt6dyfIIhgI2yN5jrYSSSbmYmh0ATjSVf1VoEtEhBCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hw4MElUz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974A606A321;
	Thu, 12 Nov 2026 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hw4MElUz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47C81F000C4;
	Thu, 12 Nov 2026 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504424;
	bh=Fm6me2Tx8KhS46QP/LJuMR1NMJOWqBPzD8rb/WA+wSU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hw4MElUz21pOnXsRnw4tds+RkDdvtqI61sTtJVjFQhiK3gTZ7ec4cfE0A5Vko7TmP
	 jQp8m7Rm0/fS2xxE5KfoOvAiDfi+UyTfqygWRW/SWqaKIJEzg/oUv2RCkvdfaV6Ac4
	 03Rf5i2qHbB2sCCTq0OZFbXknzUzVu1nUzsuNvncn6U+kvtnqY7YHKUyz8/M9vvrI6
	 PAuW29D6k3aRxjHahqDClLYDuvPz/lJgNtaCMqYr2TY+xVH6gkioO+cizShUL4wmq2
	 P3eY74t+gGM5HgIaXdhKDgEkOXBUtzYzob3tUywgU/KeXMZ5qnFZZIuIw24LUMp86T
	 1MS8957bKSlEA==
Subject:
 Re: [PATCH net v2] net: preserve skb header offsets during headroom changes
From: netdev-bot+sashiko@kernel.org
To: kylebot@openai.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 17:27:03 +0000
Message-ID: <179450442320.2199510.6846453839901153012@kernel.org>
In-Reply-To: <20261110051258.64350-1-kylebot@openai.com>
References: <20261110051258.64350-1-kylebot@openai.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] net: skb_mpls_pop() checks wrong offset and hits mac_header
  sentinel
- [High] net: u16 transport_header wrap after skb_mpls_pop() and
  mpls_forward()
- [Medium] skb_header_offsets_fit() (net/core/skbuff.c ~2121-2135) does
  not check every field that skb_headers_offset_update() shifts right…
- [Medium] The new check in mpls_xmit() (net/mpls/mpls_iptunnel.c, after
  skb_cow_head()) carries the comment 'The aligned expansion must still…
- [Medium] skb_header_offsets_fit() rejects only when `nhead > U16_MAX -
  skb->network_header`, so after an accepted expansion network_header…

--

net: preserve skb header offsets during headroom changes

This patch adds a skb_header_offsets_fit() check to pskb_expand_head()
and skb_copy_expand(). The check rejects headroom growth that would wrap
the u16 network, transport or csum_start offsets. It also adds bounds to
mpls_forward(), mpls_xmit() and skb_mpls_pop() for header moves that
do not expand the allocation.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 8da53d5b76fc2..6e0205f923f38 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2118,6 +2118,22 @@ struct sk_buff *skb_clone(struct sk_buff *skb, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(skb_clone);
>  
> +static bool skb_header_offsets_fit(const struct sk_buff *skb,
> +				   unsigned int nhead)
> +{
> +	if (!nhead)
> +		return true;
> +	if (nhead > U16_MAX - skb->network_header)
> +		return false;
> +	if (skb_transport_header_was_set(skb) &&
> +	    nhead >= U16_MAX - skb->transport_header)
> +		return false;
> +	if (skb->ip_summed == CHECKSUM_PARTIAL &&
> +	    nhead > U16_MAX - skb->csum_start)
> +		return false;
> +	return true;
> +}
> +
>  void skb_headers_offset_update(struct sk_buff *skb, int off)
>  {

[Severity: Medium]
Can the inner header offsets still wrap after this check passes?

skb_header_offsets_fit() checks network_header, transport_header and
csum_start. skb_headers_offset_update() also shifts mac_header (when set),
and it always shifts the inner offsets:

    skb->inner_transport_header += off;
    skb->inner_network_header += off;
    skb->inner_mac_header += off;

On encapsulated skbs the inner offsets sit above network_header.
mpls_xmit() in this same patch builds that layout:

    skb_reset_inner_network_header(skb);   /* inner = H */
    skb_push(skb, new_header_size);
    skb_reset_network_header(skb);         /* network = H - new_header_size */

UDP/GRE tunnels build a similar layout after iptunnel_handle_offloads().

Take a later pskb_expand_head() or skb_copy_expand() with nhead in the
range (U16_MAX - inner_network_header, U16_MAX - network_header]. It
passes this check, and inner_network_header then wraps to a small value.

mpls_gso_segment() computes:

    mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);

That consumer seems to fail safely through pskb_may_pull(). The tunnel
GSO and driver offload users of the inner offsets were not traced.

There is also an edge case with mac_header. The network check uses '>',
so network_header + nhead can equal 0xFFFF. When mac_header equals
network_header (mac_len == 0 on L3 devices), mac_header becomes 0xFFFF.
skb_mac_header_was_set() treats that value as unset.

The transport check uses '>=' to protect its sentinel. Should mac_header
get the same protection, and should the inner offsets be checked too?

[ ... ]

> @@ -2305,6 +2321,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>  		return -EINVAL;
>  	}
>  
> +	if (unlikely(!skb_header_offsets_fit(skb, nhead)))
> +		return -EINVAL;
> +

[Severity: High]
Does this cover the allocation paths that can wrap network_header without
ever calling pskb_expand_head()?

netkit_new_link() and netkit_set_headroom() in drivers/net/netkit.c take
any u16 IFLA_NETKIT_HEADROOM value and store it in dev->needed_headroom.
There is no upper bound. netkit uses ether_setup(), so hard_header_len is
14. With needed_headroom 65535:

    LL_RESERVED_SPACE(dev) = ((14 + 65535) & ~15) + 16 = 65552

Several transmit paths reserve that much on a fresh skb and then set the
network header from skb->data:

net/ipv4/raw.c:raw_send_hdrinc() {
    hlen = LL_RESERVED_SPACE(rt->dst.dev);
    ...
    skb_reserve(skb, hlen);
    ...
    skb_reset_network_header(skb);
}

__ip_append_data() in net/ipv4/ip_output.c follows the same pattern with
LL_RESERVED_SPACE(). packet_snd() in net/packet/af_packet.c follows it
with LL_RESERVED_SPACE_EX().

In each case network_header is stored as 65552 & 0xffff = 16. The
DEBUG_NET_WARN_ON_ONCE() in skb_reset_network_header() compiles away
without CONFIG_DEBUG_NET.

ip_finish_output2() only expands when skb_headroom(skb) < hh_len. That is
false here, so skb_header_offsets_fit() never runs. The packet then goes
through:

neigh_resolve_output()
  __skb_pull(skb, skb_network_offset(skb))   /* -65536 -> 0xFFFF0000 */
  dev_hard_header()
    eth_header()
      skb_push(skb, ETH_HLEN)   /* 14 bytes written at the wild address */

neigh_connected_output() has the same __skb_pull().

This looks like the out-of-bounds Ethernet header write described in the
commit message. It is reachable from a plain raw, UDP or ping sendmsg over
a netkit device with large headroom. CAP_NET_ADMIN/CAP_NET_RAW inside a
user namespace netns is enough.

Would capping dev->needed_headroom (or LL_RESERVED_SPACE()) below U16_MAX,
with some slack, fix the root cause and make the per-site checks
unnecessary?

[ ... ]

> @@ -6771,6 +6795,9 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
>  	if (unlikely(!eth_p_mpls(skb->protocol)))
>  		return 0;
>  
> +	if (unlikely(skb->network_header > U16_MAX - MPLS_HLEN))
> +		return -EINVAL;
> +

[Severity: High]
Is there enough room left for the inner L3 header after the pop?

This check lets the post-pop network_header reach U16_MAX. The bound
added to skb_mpls_pop() does the same.

skb_header_offsets_fit() also lets an earlier expansion get there.
While the skb is still MPLS, transport_header is either unset or
equal to the outer network_header. Headroom and network_header can
therefore grow to about 65534, for example by skb_cow() towards a
netkit device with a large IFLA_NETKIT_HEADROOM. For penultimate hop
popping, this check also runs before the skb_cow() for out_dev further
down.

When the inner IPv4 packet reaches ip_rcv_core(), for example after
an act_mpls or Open vSwitch pop at ingress, it does:

    skb->transport_header = skb->network_header + iph->ihl*4;

With network_header in [65516, 65535], or a wider range with IP
options, the u16 wraps to a small value.

ip_local_deliver_finish() then calls __skb_pull() with
skb_network_header_len(skb). That is the u32 difference and comes out
around 0xFFFF0014. On a linear skb data_len is 0, and the wrapped
skb->len stays above it, so the BUG() in __skb_pull() does not fire.
The len > INT_MAX check only warns under CONFIG_DEBUG_NET. skb->data
ends up about 4 GiB past skb->head before ip_protocol_deliver_rcu()
reads the L4 header.

ip6_rcv_core() sets transport_header the same way, using
sizeof(struct ipv6hdr).

This also needs only CAP_NET_ADMIN in a user namespace netns.

Should the pop paths leave room for the following L3 header? Or would
bounding headroom well below U16_MAX at creation avoid picking a
margin at every site?

[Severity: High]
Does this check bound the offsets that skb_mpls_pop() actually writes?

After the pull, skb_reset_mac_header() stores skb_headroom(skb) +
MPLS_HLEN in mac_header. skb_set_network_header(skb, mac_len) stores
skb_headroom(skb) + MPLS_HLEN + mac_len in network_header. Neither
value comes from the incoming skb->network_header. The guard only
holds when network_header already equals skb_headroom(skb) + mac_len
on entry.

Two cases seem to get past it.

The first is mac_len == 0, for example an L3 MPLS packet in Open
vSwitch, or act_mpls after the MAC header was popped. A packet with
skb_headroom(skb) == network_header == U16_MAX - MPLS_HLEN passes the
check. skb_reset_mac_header() then sets mac_header to U16_MAX, which
is the unset sentinel. skb_mac_header_was_set() returns false from
then on, and later skb_mac_header() users trip
DEBUG_NET_WARN_ON_ONCE().

The second is TC ingress, where tcf_mpls_act() in net/sched/act_mpls.c
does:

    skb_push_rcsum(skb, skb->mac_len);
    mac_len = skb->mac_len;

That moves skb->data back to the MAC header without touching
network_header. If __netif_receive_skb_core() already stored a wrapped
network_header (0..13 for a headroom of 65536..65549), headroom here
is 65522..65535. The check sees a small network_header and passes.
skb_reset_mac_header() and skb_set_network_header() then both wrap.
A preceding skb_vlan_push(), which decrements network_header, can
produce a similar mismatch.

Both cases need only CAP_NET_ADMIN in a user namespace netns, using
act_mpls or an Open vSwitch pop_mpls action on a device with large
headroom.

Should the check be on skb_headroom(skb) + MPLS_HLEN + mac_len, and
keep mac_header strictly below U16_MAX? Or does this suggest the
headroom should be bounded where it is created?

[Severity: Medium]
What about other header pops that do not expand the skb?

skb_header_offsets_fit() lets network_header reach exactly U16_MAX after
an expansion. That means every later forward header move without
expansion needs its own bound. This patch adds one to skb_mpls_pop(),
mpls_forward() and mpls_xmit().

bpf_skb_net_hdr_pop() in net/core/filter.c does the same kind of pop for
bpf_skb_adjust_room() on shrink (up to 0xfff bytes), with no U16_MAX
check:

net/core/filter.c:bpf_skb_net_hdr_pop() {
    ...
    ret = bpf_skb_generic_pop(skb, off, len);
    if (likely(!ret)) {
        skb->mac_header += len;
        skb->network_header += len;
        if (trans_moves) {
            skb->transport_header += len;
    ...
}

Here is one possible trigger. A tc/tcx BPF program runs on an skb whose
network_header is within 0xfff of U16_MAX, for example after
skb_expand_head() on a large-headroom netkit device. If the program
shrinks the room, network_header wraps to a small value.

ip_rcv_core() would then parse the IP header from uncopied headroom. On
forwarding, neigh_resolve_output() would see a negative
skb_network_offset() again.

Whether an skb really reaches such a program with network_header that
close to U16_MAX was not fully traced. Does bpf_skb_net_hdr_pop() need
the same bound?

[ ... ]

> diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
> index 1a1a0eb5b787f..4eccbd911fe1f 100644
> --- a/net/mpls/mpls_iptunnel.c
> +++ b/net/mpls/mpls_iptunnel.c
> @@ -109,6 +109,10 @@ static int mpls_xmit(struct sk_buff *skb)
>  	if (skb_cow_head(skb, hh_len + new_header_size))
>  		goto drop;
>  
> +	/* The aligned expansion must still fit the u16 header offsets. */
> +	if (unlikely(skb_headroom(skb) > U16_MAX))
> +		goto drop;
> +

[Severity: Medium]
Can this check fire because of the expansion, as the comment says?

On this LWT output path skb->data is at the network header. With the new
guard in pskb_expand_head(), a successful skb_cow_head() expansion keeps
network_header + nhead <= U16_MAX. Headroom after the expansion is
therefore at most U16_MAX.

So skb_headroom(skb) > U16_MAX can only be true here if headroom was
already above U16_MAX on entry. That would mean network_header was
already wrapped by an allocation path such as raw_send_hdrinc() or
__ip_append_data().

In that case mpls_xmit() has already read through the wrapped offset a
few lines earlier:

    ttl = ip_hdr(skb)->ttl;

The IPv4/IPv6 output code before the LWT hook has used it as well.

Could the comment be reworded to say what this check actually catches?
Alternatively, would bounding headroom at allocation time make this check
unnecessary?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110051258.64350-1-kylebot%40openai.com
