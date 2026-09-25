Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E78175A5
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790302405; cv=none; b=PS/Z3G56VLk7ypWD++2YnsIAkboBLVFBwTU3km3tAlZxcHO1MimHiq7ivIfgoAjbkIYsZ6VKDEaqNEbKdcpfNn/idoE7qLm+ninqoRtOYMdcRfaUduL8vwwx3wekeYmEaHUp8dk3/cIR1u6LAWR9WME/Qpstjq8l8uDFgcw0w3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790302405; c=relaxed/simple;
	bh=TmJUTtuR7ra2Q873QmQYdADCzuV8Y4wwTvEnpl4BVY4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P49bzSygTgC0CrH6/sbJNPOoij3q0aTxThaTvD5rzSd3fi1vDxjrfrqlshKqxh0HUwpOoK01/dDgf0iUI3RWjmdBxhKEKEW7oLgMgAydGnIo2+fLrMOzN6naz196iizFaSPgNSZY3cDNJDgBOrWc3PevIwTEBD0cvo1yQXIw/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7FNrsp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7FNrsp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391071F000FF;
	Fri, 25 Sep 2026 02:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790302403;
	bh=ni0c2O/ykpR71YuA39uG1VqG8trotPSRhLbuEZQgmsQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G7FNrsp8S1G1YZrRLSyImTMIhIDg+a7EwqHkxErB93UMa7g70EFdaq/JsSt3DuC35
	 jA7oAqvmTEgfgIrvKPu/QjagdNy/2hZOrunI/qOebS1EPe5a1rbfrWR8VVHh6pWs1n
	 S94AQSCslgqTUHuxIBh/qMeqVq1+ascyxx6VT3krypB6j9+T7mGVyNG21nrK0yNfF+
	 OhfABps/tVSfq84k7YeaPAEWbbrVL+MVsc1pIJwrSMjUFUeMdI5vd5c45YPHz/qcMh
	 13xF50FsKexg1SizYtLFcF0mEN95qh7H5FDYxwTwsq7Z99xrIdM6OrWzUxcKT1cuf3
	 p9BSWkhIA0zHA==
Subject:
 Re: [PATCH net] gve: DQO: accept TSO packets with non-protocol gso_type bits
From: netdev-bot+sashiko@kernel.org
To: hannu@varjosoft.com
Cc: joshwash@google.com, hramamurthy@google.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nktgrg@google.com, willemb@google.com,
 pkaligineedi@google.com
Date: Fri, 25 Sep 2026 02:13:22 +0000
Message-ID: <179030240275.2160803.7121151150196393029@kernel.org>
In-Reply-To: <20260923141047.14047-1-hannu@varjosoft.com>
References: <20260923141047.14047-1-hannu@varjosoft.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With the new bitmask test in gve_prep_tso()
  (gve_tx_dqo.c:602/607), SKB_GSO_DODGY TSO/USO skbs are now accepted,…

Pre-existing issues:
- [Medium] gve_can_send_tso()
  (drivers/net/ethernet/google/gve/gve_tx_dqo.c:916) always computes…
- [Medium] gve_prep_tso() caches `shinfo = skb_shinfo(skb)` at line 573
  and then calls `skb_cow_head(skb, 0)` at line 592.

--

gve: DQO: accept TSO packets with non-protocol gso_type bits

This commit replaces the exact gso_type switch in gve_prep_tso() with
bitmask tests. TSO/USO packets that carry SKB_GSO_DODGY, SKB_GSO_TCP_ECN
or SKB_GSO_TCP_FIXEDID are therefore no longer dropped. The change fixes
TSO traffic forwarded from tap-backed guests on DQO queue formats, which
was being dropped and counted in tx_dropped.

> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> index 80ab0a449ff54..675c7644817a6 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -596,21 +596,20 @@ static int gve_prep_tso(struct sk_buff *skb)
>  	l4_start = skb_transport_offset(skb);
>  	paylen = skb->len - l4_start;
>  
> -	switch (shinfo->gso_type) {
> -	case SKB_GSO_TCPV4:
> -	case SKB_GSO_TCPV6:
> +	/* gso_type is a bitmask: SKB_GSO_DODGY, SKB_GSO_TCP_ECN and
> +	 * SKB_GSO_TCP_FIXEDID may be set alongside the protocol bit.
> +	 */
> +	if (shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {

[Severity: Medium]
Now that SKB_GSO_DODGY skbs get through here, is their gso_size ever
checked against the hardware maximum?

The comment at the top of gve_prep_tso() explains why the upper bound is
not checked, and only the lower bound is enforced:

	/* Note: HW requires MSS (gso_size) to be <= 9728 and the total length
	 * of the TSO to be <= 262143.
	 *
	 * However, we don't validate these because:
	 * - Hypervisor enforces a limit of 9K MTU
	 * - Kernel will not produce a TSO larger than 64k
	 */

	if (unlikely(shinfo->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
		return -1;

For DODGY skbs, gso_size comes from an untrusted virtio_net_hdr through
__virtio_net_hdr_to_skb() (tun/tap or PACKET_VNET_HDR). That function only
rejects 0 and GSO_BY_FRAGS, and it never compares gso_size to an MTU.
tcp_gso_segment() and __udp_gso_segment() then pass the skb through
unsegmented. On bridged, macvtap or direct AF_PACKET paths, the value ends
up in a 14-bit descriptor field:

gve_tx_fill_tso_ctx_desc() {
    ...
	desc->mss = skb_shinfo(skb)->gso_size;
}

gve_desc_dqo.h:
	u16 mss: 14;

A gso_size from 9729 to 16383 exceeds the documented hardware limit. A
gso_size of 16384 or more is truncated, so 16384 becomes mss 0 and 16472
becomes mss 88.

gve_can_send_tso() also relies on the same 9728 assumption:

	 * Since max gso size (9728) is less than
	 * GVE_TX_MAX_BUF_SIZE_DQO, it is impossible
	 * for the segment to span more than two
	 * descriptors.

With gso_size above 16383, one segment can span more than two descriptors
of a single frag, so the per-segment buffer count can come out too low.

Before this patch, the exact switch dropped every DODGY skb, so these
values never reached the descriptor. Should gve_prep_tso() reject
gso_size above 9728, or should gve_features_check_dqo() fall back to
software GSO in that case? If so, the comment above the check would need
updating too.

>  		tcp = tcp_hdr(skb);
>  		csum_replace_by_diff(&tcp->check,
>  				     (__force __wsum)htonl(paylen));
>  		header_len = skb_tcp_all_headers(skb);
> -		break;
> -	case SKB_GSO_UDP_L4:
> +	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {

[Severity: Medium]
This isn't a bug introduced by this patch, but both gso_type tests still
use the shinfo pointer that was cached before skb_cow_head():

gve_prep_tso() {
	struct skb_shared_info *shinfo = skb_shinfo(skb);
    ...
	err = skb_cow_head(skb, 0);
    ...
	if (shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
    ...
	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
    ...
}

When the header is cloned, skb_cow_head() calls pskb_expand_head(). This
happens, for example, when dev_queue_xmit_nit() clones for a packet tap,
or when a bridge floods. pskb_expand_head() copies skb_shared_info into a
new head and calls skb_release_data() on the old one.

After that, only the other clones hold the old head, and they can free it
on another CPU at any time. Can these shinfo->gso_type reads then touch
freed memory?

A garbage gso_type could send a TCP skb down the UDP branch and rewrite
bytes at the UDP check offset, or it could drop the packet. On KASAN
kernels, it would show up as a use-after-free.

Would it make sense to reload shinfo = skb_shinfo(skb) after a successful
skb_cow_head(), or to copy gso_type into a local before the COW?

>  		udp = udp_hdr(skb);
>  		csum_replace_by_diff(&udp->check,
>  				     (__force __wsum)htonl(paylen));
>  		header_len = sizeof(struct udphdr) + l4_start;

[Severity: Medium]
This is a pre-existing issue, but gve_can_send_tso() never got the UDP
handling that commit 014c607f86ab added here. It still uses the TCP header
length for every GSO type:

gve_can_send_tso() {
    ...
	const int header_len = skb_tcp_all_headers(skb);
    ...
	cur_seg_size = skb_headlen(skb) - header_len;
    ...
}

For SKB_GSO_UDP_L4, tcp_hdrlen() reads the doff nibble at offset 12 of the
transport header. That is byte 4 of the UDP payload, which the sender
controls. header_len can then be anywhere from l4_start to l4_start + 60,
while the value gve_prep_tso() programs is l4_start + 8.

gve_features_check_dqo() is the only place that enforces the
GVE_TX_MAX_DATA_DESCS per-segment limit. With every modelled segment
boundary shifted by -8..+52 bytes, can a real segment span more than 9
buffers and still pass the check? Small frags from MSG_SPLICE_PAGES,
sendfile or vhost-net zerocopy could trigger this. On RDA queues, the
device would then get a layout that exceeds its per-segment limit.

This patch now lets SKB_GSO_UDP_L4 | SKB_GSO_DODGY frames from tap guests
and packet sockets through, which adds guest-controlled senders for this
path. Should gve_can_send_tso() compute header_len the same way
gve_prep_tso() does?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923141047.14047-1-hannu%40varjosoft.com
