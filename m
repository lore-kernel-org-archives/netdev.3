Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05E3749F0
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901313; cv=none; b=ImPX6hR+m1aEcx8szytVT8kQ5+na39EOYnQ05z6ptfEOFViBkZWHUudGt/+HepUDFaoUMpAQRnI1wHLNAecTmOZ+xc7XUbCrxsG6+oFtk1B2MK4CQBqcN3LdeDMkcv7Nf/PtDou4wv5QDpaO/3Yu8PmltZv5+nVBitZPzey6qww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901313; c=relaxed/simple;
	bh=g1tpcn/v04AR2BmnyCo3WBrEO75eBCtQuKfyek/KRwI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gD8u52F6S2J3TrjssgOgHgIkwAdcx0+u0qnuZ3TIxmjh4pO4lMjWfrvJcSUs7I6v1TR3lADxIq8ECI6FtBQLkiCBCwk+SzDtmv26YQwpNAUo5KiMQMoTarTk60enY4Om3//qZbY5T2MJRf5JAO4Df0H4A2u53bV6wPXigMro14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrmyQUcj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrmyQUcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB431F00893;
	Sun, 20 Sep 2026 10:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789901311;
	bh=NIwH38ssCWBJLlFQWXWbjbzTE8bP4vcOw0CEt1XAu3o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jrmyQUcjKwM2P9+8qRRTi0qCb1i7svX3LEnSKE7BARX04rvw/XB2VvKq3w/AAz+ZJ
	 5tWuFWF8ETydQSuijcPLSxTDmGmMo1VURfoRXi1YcgbNxSAAsvXCuoNshAl/n1Qwew
	 GPzz0WNb+aeCdSXLytUrz3QWsiGBR1v5h3vPaNgRIqaiU7oBvEaMhgGgJ7YTLymfVv
	 NQEBgFiO+6O1tB5wFVo7gP3T/l5fhQvUkW4KNbrOcQ6IQQAiNSCPf9EDWRQ08+NYrF
	 3JCbMhJYp/WbghM1yRYMnTbyJCQydwoldIIftKdvU6UeLxQUI7VvB9SAY7owaaV0gX
	 CEaClcbXq9uuA==
Subject: Re: [PATCH net v2 5/5] gre: fix out-of-bounds read of erspan metadata
 in collect_md mode
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Sun, 20 Sep 2026 10:48:30 +0000
Message-ID: <178990131061.2160803.13037148573841720783@kernel.org>
In-Reply-To: <20260916100155.1398403-6-edumazet@google.com>
References: <20260916100155.1398403-6-edumazet@google.com>
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

- [Medium] Commit message / in-code comment mismatch: the patch is titled
  "gre: fix out-of-bounds read of erspan metadata in collect_md mode"…

Pre-existing issues:
- [Medium] erspan_rcv() (net/ipv4/ip_gre.c:334-361) hands collect_md
  consumers an ERSPAN option with md->version == 0 for ERSPAN type I…
- [Medium] is_erspan_type1() (net/ipv4/ip_gre.c:258-265) classifies a
  packet as ERSPAN type I purely from gre_hdr_len == 4, without…

--

gre: fix out-of-bounds read of erspan metadata in collect_md mode

This adds a check rejecting an ERSPAN base header whose version field is
neither 1 nor 2 in erspan_rcv() and ip6erspan_rcv(), and skips the md2
metadata copy in erspan_rcv() for ERSPAN type I, which carries no ERSPAN
header.  The collect_md option area is left as the zeroed area handed out
by ip_tun_rx_dst(), so md->version = 0 alone describes type I.

No Link: tags were present in the commit header.

First, a question about the changelog itself:

> gre: fix out-of-bounds read of erspan metadata in collect_md mode

and

>     Both read 8 bytes at 12 bytes from the start of the GRE header, but only
>     ask pskb_may_pull() for erspan_hdr_len(ver) bytes beyond it, which type I
>     support made 0 for version 0.

[Severity: Medium]
Is the "out-of-bounds read" description accurate here?  Both erspan_rcv()
and ip6erspan_rcv() only reach the memcpy() after
__iptunnel_pull_header(skb, len, htons(ETH_P_TEB), false, false) returned
success, and that helper linearizes an extra ETH_HLEN for ETH_P_TEB with
raw_proto == false:

net/ipv4/ip_tunnel_core.c:__iptunnel_pull_header() {
	...
	if (!raw_proto && inner_proto == htons(ETH_P_TEB)) {
		struct ethhdr *eh;

		if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
			return -ENOMEM;
	...
}

erspan_rcv() does "goto drop" and ip6erspan_rcv() does
"return PACKET_REJECT" when that fails, so at the copy point there are at
least 14 linear bytes from skb->data.  Walking the three cases in the
changelog:

- IPv4 type I: gre_hdr_len == 4, len == 4, pkt_md == skb->data + 4, an
  ERSPAN_V2_MDSIZE copy ends at skb->data + 12.
- IPv4 8 byte GRE with ershdr->ver == 0: len == 8, pkt_md == skb->data + 4,
  copy ends at skb->data + 12.
- IPv6 with ver == 0: len == 0, pkt_md == skb->data + 4, copy ends at
  skb->data + 12.

All three stay inside the linearized region, so nothing outside the skb is
touched and KASAN would not fire.  What does happen is that the first 8
bytes of the inner Ethernet frame get copied into md->u.md2 and an
unvalidated 4 bit wire value is stored in md->version, which is a
data-correctness problem rather than a memory-safety one.

Could the subject, the changelog and the stable justification describe that
instead, or is there a path that defeats the ETH_HLEN guarantee?

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 696884f53cdcc..92f3a52d20d38 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c

[ ... ]

> @@ -294,6 +293,9 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>  
>  		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
>  		ver = ershdr->ver;
> +		if (unlikely(ver != 1 && ver != 2))
> +			return PACKET_REJECT;
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but can this new check be
bypassed for a packet class that does carry a base header?

is_erspan_type1() decides purely on the GRE header length and never looks
at the GRE protocol:

net/ipv4/ip_gre.c:is_erspan_type1() {
	/* Both ERSPAN type I (version 0) and type II (version 1) use
	 * protocol 0x88BE, but the type I has only 4-byte GRE header,
	 * while type II has 8-byte.
	 */
	return gre_hdr_len == 4;
}

gre_parse_header() is more careful and treats the two protocols
differently:

net/ipv4/gre_demux.c:gre_parse_header() {
	if ((greh->protocol == htons(ETH_P_ERSPAN) && hdr_len != 4) ||
	    greh->protocol == htons(ETH_P_ERSPAN2)) {
		struct erspan_base_hdr *ershdr;

		if (!pskb_may_pull(skb, nhs + hdr_len + sizeof(*ershdr)))
	...
}

So a frame with greh->flags == 0 and greh->protocol == htons(ETH_P_ERSPAN2)
yields hdr_len == 4, and gre_rcv() still routes it to erspan_rcv():

net/ipv4/ip_gre.c:gre_rcv() {
	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
		     tpi.proto == htons(ETH_P_ERSPAN2))) {
		if (erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)
			return 0;
	...
}

In erspan_rcv() is_erspan_type1(4) then returns true, ver is forced to 0 and
the new "if (unlikely(ver != 1 && ver != 2))" above is never reached for
that packet.  len also stays at 4, so the 4 byte base header plus the 8 byte
md2 are handed to ip_tunnel_rcv() as the start of the inner Ethernet frame.

Would making the type I predicate also require
tpi->proto == htons(ETH_P_ERSPAN) close that, given ETH_P_ERSPAN2 can never
describe type I?

> @@ -334,19 +337,26 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>  			info = &tun_dst->u.tun_info;
>  			info->options_len = sizeof(*md);
>  
> -			/* skb can be uncloned in __iptunnel_pull_header, so
> -			 * old pkt_md is no longer valid and we need to reset
> -			 * it
> -			 */
> -			gh = skb_network_header(skb) +
> -			     skb_network_header_len(skb);
> -			pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
> -							    sizeof(*ershdr));
>  			md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
>  			md->version = ver;

[Severity: Medium]
This is a pre-existing issue, but is the version 0 encoding usable by any
consumer of this option?  For type I this publishes md->version == 0 with
info->options_len = sizeof(*md) and IP_TUNNEL_ERSPAN_OPT_BIT set, while
every peer of that option only accepts 1 or 2:

net/ipv4/ip_gre.c:erspan_fb_xmit() {
	if (version == 1) {
		...
	} else if (version == 2) {
		...
	} else {
		goto err_free_skb;
	}
}

net/ipv6/ip6_gre.c:ip6erspan_tunnel_xmit() {
		if (md->version == 1) {
			...
		} else if (md->version == 2) {
			...
		} else {
			goto tx_err;
		}
}

net/ipv4/ip_tunnel_core.c:ip_tun_parse_opts_erspan() {
	ver = nla_get_u8(tb[LWTUNNEL_IP_OPT_ERSPAN_VER]);
	if (ver == 1) {
	...
	} else if (ver == 2) {
	...
	} else {
		return -EINVAL;
	}
}

So a BPF or OVS mirror that re-emits a received ERSPAN type I frame with the
received tun_info is dropped in erspan_fb_xmit() (kfree_skb plus
tx_dropped), even though the non collect_md path does implement type I:

net/ipv4/ip_gre.c:erspan_xmit() {
	if (tunnel->erspan_ver == 0) {
		proto = htons(ETH_P_ERSPAN);
		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
	} else if (tunnel->erspan_ver == 1) {
	...
}

The patch does not create that asymmetry, but the changelog wording
"md->version = 0 alone describes it" makes version 0 a permanent, blessed
encoding.  Should erspan_fb_xmit(), ip6erspan_tunnel_xmit() and the netlink
parser learn about type I, or should IP_TUNNEL_ERSPAN_OPT_BIT not be
advertised for type I at all?

> +
> +			/* Type I has no ERSPAN header, thus no metadata to
> +			 * extract: reading it would go past the @len bytes
> +			 * pulled above. ip_tun_rx_dst() zeroed @md for us.
> +			 */

[Severity: Medium]
Same question as on the changelog above: "reading it would go past the @len
bytes pulled above" leaves out that __iptunnel_pull_header() already
required ETH_HLEN more linear bytes, so the read landed on the inner
Ethernet frame rather than past the linear area.  Could the comment say that
type I has no metadata to copy and the bytes there belong to the inner
frame?

> +			if (!is_erspan_type1(gre_hdr_len)) {
> +				/* skb can be uncloned in __iptunnel_pull_header, so
> +				 * old pkt_md is no longer valid and we need to reset
> +				 * it
> +				 */
> +				gh = skb_network_header(skb) +
> +				     skb_network_header_len(skb);
> +				pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
> +								    sizeof(*ershdr));
> +				md2 = &md->u.md2;
> +				memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
> +							       ERSPAN_V2_MDSIZE);
> +			}

[Severity: Medium]
This isn't a bug introduced by this patch, but tied to the is_erspan_type1()
question above: for an ETH_P_ERSPAN2 frame with a 4 byte GRE header this
guard now skips the copy for a packet that does carry an ERSPAN v2 metadata
block, so collect_md consumers see version 0 with an all zero md2.  Before
this change the copy at gh + gre_hdr_len + sizeof(*ershdr) happened to land
on the real md2 for that packet.

>  
>  			__set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
>  				  info->key.tun_flags);
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 8ebda0b6a78b2..a59fb82c74dad 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -503,6 +503,8 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>  	ipv6h = ipv6_hdr(skb);
>  	ershdr = (struct erspan_base_hdr *)skb->data;
>  	ver = ershdr->ver;
> +	if (unlikely(ver != 1 && ver != 2))
> +		return PACKET_REJECT;

The version rejection itself looks right for this path, since ip6erspan_rcv()
always has a base header at skb->data.  The only question here is the one
raised on the changelog about the ver == 0 case being described as an out of
bounds read.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916100155.1398403-1-edumazet%40google.com
