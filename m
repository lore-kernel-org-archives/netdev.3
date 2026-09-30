Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F701DF27F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743302; cv=none; b=e4N6DAtBp5rawCUNRzfit63tMrezAyQuuPXTqdnwzBNZRZEfM8U/XUjDYXytggnrFyHznQ63aNbZmaAzD+C/RPH9WUE1Cd48e60cVAlWuO/88gP1j3/i3rUa/BMutGhOOYqSyUrAPUSUMiTxM9iE9TbBWa6FVpbMLEhf7c2Vx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743302; c=relaxed/simple;
	bh=hDj44xFe35cWZ2RAhzwAY5Oc3EXAh5AjqHC0ppM+HVM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fi7ICcrYQjRdZjV3qwX2E0r72Hqt1l2fKhrDreAKQCG06isMwy1UqJLdfmuR7hAmWGOTGjcunmiNbaQoPgtw3/1Ex0R+RlZXSLKEkNFjQR3g056puaZs6F3HqfVcbHIjl5OpC6BwawkpRPKysHgvKDb+1zF1i525qknn7CetADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knO76hZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knO76hZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0531F00893;
	Wed, 30 Sep 2026 04:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743301;
	bh=mOO9JbobB9mH7JMNLXX6on3h5ienjt3p02exQoZNVYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=knO76hZ2Oerhh65LXmyFN4BrclA/pxynhq49peWE8AIBog/3Okuqw0eyUCAZbcAxT
	 JWbcdX3zV0l1dAXGvaQsWlKOiFEGObYU/HpiQR1DJDIlm2cswCGtsSyd1wV68PlWRM
	 ht/ej404ItfdcC9EESz5eENMtRtwdtlMMpyEAalFYdozrje5enZJcqVoaWTyOK1aUJ
	 vFIobUKpF/qiMoPD0FyRVbHe0BipY5FFMG8KHKuvWdfft5/8smX3s4CA7wL5of5JM/
	 VUK/YiZqTt4pl9BCtLig3WIR7cPBV3cX1q+fWhobadM+ajoQi1zJlygiuwqpqKq6JF
	 k3jJNMPRCTIhA==
Subject:
 Re: [PATCH net-next v3 4/5] net: core: resegment oversized TCP GSO skbs
From: netdev-bot+sashiko@kernel.org
To: wang.zhan@smartx.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, keyong.sun@smartx.com,
 willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, andrew+netdev@lunn.ch,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 dev@openvswitch.org, daniel@iogearbox.net, ncardwell@google.com,
 kuniyu@google.com, alice@isovalent.com, david.laight.linux@gmail.com
Date: Wed, 30 Sep 2026 04:41:39 +0000
Message-ID: <179074329950.434549.8190840891812548812@kernel.org>
In-Reply-To: <20260928044102.1004310-5-wang.zhan@smartx.com>
References: <20260928044102.1004310-5-wang.zhan@smartx.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] skb_gso_output_max_segs() (net/core/dev.c:3954-3960) works out
  hdr_len from a TCP header read at skb->transport_header.
- [Low] Parts of the commit message's cost claims do not match the code.

--

net: core: resegment oversized TCP GSO skbs

When an unencapsulated TCP GSO skb exceeds the egress device's
gso_max_size or gso_max_segs, validate_xmit_skb() now resegments it into
smaller GSO skbs instead of segmenting it into individual packets. A new
helper, skb_gso_output_max_segs(), works out the per-output segment bound
from the header length, the MSS and the device limits. The size limit is
capped at GSO_LEGACY_MAX_SIZE.

> The helper runs on the skb which is handed to the driver, after
> validate_xmit_vlan() and sk_validate_xmit_skb(), and only from the
> netif_needs_gso() branch, so an skb which is not segmented pays nothing.
> An over-limit skb pays one device limit test and one ndo_features_check()
> for the bound, in exchange for keeping the output a GSO skb.

[Severity: Low]
Is this description of the cost accurate?

Take SKB_GSO_DODGY TCP skbs, for example from tap/virtio guests or packet
sockets, sent through a device without NETIF_F_GSO_ROBUST. They fail
skb_gso_ok() and take the netif_needs_gso() branch, so they now pay the
gso_within_dev_limits() test in validate_xmit_skb().

They are then not segmented, because tcp_gso_segment() returns early:

    if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
        /* Packet is from an untrusted source, reset gso_segs. */
        skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len, mss);
        segs = NULL;
        goto out;
    }

CHECKSUM_NONE GSO skbs on a TSO device go through the same path.

In the over-limit case, the helper calls __netif_skb_features(skb, false).
That reruns gso_features_check(), the VLAN feature intersection,
ndo_features_check() or dflt_features_check(), and harmonize_features().
The helper also does an extra skb_header_pointer() read for the TCP header.

Could the commit message describe this cost more precisely?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index d66b667071837..728260772f349 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3933,6 +3933,63 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(netif_skb_features);
>  
> +static unsigned int
> +skb_gso_output_max_segs(struct sk_buff *skb, struct net_device *dev)
> +{
> +	unsigned int mss = skb_shinfo(skb)->gso_size;
> +	unsigned int gso_max_size, hdr_len, max_segs;
> +	netdev_features_t features;
> +	struct tcphdr _tcph, *th;
> +
> +	/*
> +	 * The TCP frag-list path segments through skb_segment_list(), which
> +	 * does not carry max_segs, so bounded calls skip those skbs.
> +	 */
> +	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
> +	    skb->encapsulation || skb_has_frag_list(skb) ||
> +	    !skb_mac_header_was_set(skb) ||
> +	    !skb_transport_header_was_set(skb))
> +		return 0;
> +
> +	th = skb_header_pointer(skb, skb_transport_offset(skb), sizeof(_tcph),
> +				&_tcph);
> +	if (!th || th->doff < sizeof(*th) / 4)
> +		return 0;
> +
> +	hdr_len = skb_transport_header(skb) - skb_mac_header(skb) +
> +		  th->doff * 4;

[Severity: High]
Can hdr_len end up computed from a header that isn't the TCP header?

skb_transport_header_was_set() only says that the offset was set. It does
not say that the offset points at the TCP header.

The segmentation code does not use this offset. inet_gso_segment() and
ipv6_gso_segment() re-parse L3 and reset the transport header themselves,
so skb_segment() builds the outputs from the real header length.

There seem to be two ways a forwarded TCP GSO skb can arrive here with a
stale transport offset.

The first is IPv6 forwarding with a Destination Options or Routing header.
ipv6_gro_receive() sets the transport header to the real TCP header.
ip6_rcv_core() then overwrites it:

    skb->transport_header = skb->network_header + sizeof(*hdr);

Only a Hop-by-Hop header moves it past that point. So on the
ip6_forward()->validate_xmit_skb() path, this helper reads doff from
extension header bytes that the remote sender controls.

The second is VXLAN decap followed by bridge forwarding, with GRO off on
the vxlan device or an XDP prog attached. gro_cells_receive() does:

    skb_unset_transport_header(skb);

    if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
        res = netif_rx(skb);

Without CONFIG_DEBUG_NET, __netif_receive_skb_core() then resets the
transport header to skb->data, which is the inner IP header, and the
bridge leaves it there.

doff then comes from the high nibble of the inner IPv4 saddr. An address
in 80.x to 95.x gives doff = 5, so hdr_len is 34 instead of 54 or more.

In both cases hdr_len comes out too small, so max_segs comes out too large.
Take gso_ipv4_max_size = 32160, MSS 1460 and no TCP options. This helper
returns 22 instead of 21, and skb_segment() emits a 32174 byte GSO skb.
That is above the limit the device advertises.

In the BIG TCP to 64 KiB case, the GSO_LEGACY_MAX_SIZE cap does not bound
the real output either. A Destination Options header of about 48 bytes is
enough in the IPv6 case for the output to go past what the 16-bit length
field can hold. ipv6_gso_segment() would then truncate here:

    payload_len = skb->len - nhoff - sizeof(*ipv6h);
    ipv6h->payload_len = htons(payload_len);

The same applies to iph->tot_len in inet_gso_segment(). The commit message
says the output "obeys the GSO feature and limit contract the device
already advertises". Before this patch, these over-limit skbs were fully
segmented.

Would it be safer to find the TCP header the same way the GSO code does?
One option is to require CHECKSUM_PARTIAL and use
skb_checksum_start_offset(), since tcp_gso_segment() already requires
csum_start to match the TCP header. Another is to return 0 unless
skb_checksum_start(skb) == skb_transport_header(skb).

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928044102.1004310-1-wang.zhan%40smartx.com
