Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A94BE44C;
	Mon, 12 Oct 2026 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825596; cv=none; b=kuROx5ZhDXGMnIQye6h8cVwa8xBCRzlY064kJGbRSVcjwPXyrFyXMvjSrHu6LDIP82rBpYISehwtbAa8By5F7prqD+ZCvvi5qL6iwKeDXwhqC3IuLY4CqJ03Bmm2FvIr9CNDJlBOpaIgzBomHQ64cvTRon+Dkrq4PCvWb2Cv8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825596; c=relaxed/simple;
	bh=h40ggl8deBeBe2maVyxyiPGuRmq4FgY1nleaKjxEnDw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUjsjlTEr3G+tNvcnwqK3JpriUZhTfFI/JWH0T/enFyOXo3YojZ1usqaz7XUnOyV5OZDk6/IQ6T40k+ilL3hFUScIbEJxEBTFQGgzYkr7/zxXBZdyF+4LKpTJloGRTxEOusFpFQvWFYAJqUipnSGSFTAaifPBVHyLmJpEIHLNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsyJC2O0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsyJC2O0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F831F0089B;
	Mon, 12 Oct 2026 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825594;
	bh=pXgRj89nsEmEJ7SR6gAWW3Ykxx7GORVQRW2IXC5fXfI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UsyJC2O0J8t7d/dm2U3ksbGFMcoVEz/hJF+SvnuzZFMFd/jyv027/FnKYOB9Fnmj8
	 oEyxAtdo8ZXqZbNzvyVguzpLDkTYZFj9s2pIXTDvaie0lVYKKtXB3Uk/z/vU0OGrzw
	 JTgoYxbDnB065SGDXLKGgIETCZQR3m0p2mjgAiGz5pBxqbT3Nji5/oxX7V3J74OTeQ
	 di7KjlilxhnEHZcskOEhY+gbj6hEZiDD8/mEQrJnvGfNatwyWuGXYSi+s99AaydzEj
	 YmzCM0PASkGwcbL6Jizg0p2ebg2VWdmW3A4e0g2ik5dyI7cLX/gWRuW3lggATSBvA1
	 nDrftHZDpdrCw==
Subject: Re: [PATCH net v2 2/3] ipmr: set up GSO state for tunnel vifs
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, steffen.klassert@secunet.com, willemb@google.com,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 17:19:53 +0000
Message-ID: <179182559332.434549.18294510093742639467@kernel.org>
In-Reply-To: <20261011162957.1328474-3-julius@bairaktaris.de>
References: <20261011162957.1328474-3-julius@bairaktaris.de>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, a GSO skb sent through a VIFF_TUNNEL vif is
  a valid SKB_GSO_IPXIP4 encapsulated packet and gets segmented.
- [Low] ip_encap() now turns the skb into an encapsulated GSO packet
  (iptunnel_handle_offloads() sets skb->encapsulation = 1 and ORs in…

--

ipmr: set up GSO state for tunnel vifs

This commit makes ip_encap() call iptunnel_handle_offloads() with
SKB_GSO_IPXIP4 and then skb_set_inner_ipproto(). GSO packets forwarded to
a VIFF_TUNNEL vif are now segmented instead of being dropped in
validate_xmit_skb(). ip_encap() now returns an error, and
ipmr_prepare_xmit() passes it up.

> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index b9c544d48c452..f0666749b14a7 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1835,12 +1835,17 @@ static struct notifier_block ip_mr_notifier = {
>   * This avoids tunnel drivers and other mess and gives us the speed so
>   * important for multicast video.
>   */
> -static void ip_encap(struct net *net, struct sk_buff *skb,
> -		     __be32 saddr, __be32 daddr)
> +static int ip_encap(struct net *net, struct sk_buff *skb,
> +		    __be32 saddr, __be32 daddr)
>  {
> +	const struct iphdr *old_iph;
>  	struct iphdr *iph;
> -	const struct iphdr *old_iph = ip_hdr(skb);
>  
> +	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
> +		return -1;
> +	skb_set_inner_ipproto(skb, IPPROTO_IPIP);

[Severity: Medium]
A GSO skb sent out a VIFF_TUNNEL vif is now a valid SKB_GSO_IPXIP4 packet
and really does get segmented. Is one IP ID reservation for the outer
header still enough?

Later in ip_encap(), the outer header is built with DF clear and a single
ID:

net/ipv4/ipmr.c:ip_encap() {
    ...
	iph->frag_off	=	0;
    ...
	ip_select_ident(net, skb, NULL);
    ...
}

ip_select_ident() hard-codes a segment count of one:

include/net/ip.h:ip_select_ident() {
	ip_select_ident_segs(net, skb, sk, 1);
}

Later, inet_gso_segment() handles the outer header with encap == 0, and
fixedid is normally false. Each segment gets its own consecutive ID from
iph->id = htons(id++), so a packet with N segments uses IDs id..id+N-1.

ip_idents_reserve() moves the bucket forward by only 1 per packet. It adds
random perturbation only when the jiffy changes.

Can back-to-back GSO packets on the same tunnel then reuse most of each
other's outer IDs?

DF is clear on these outer datagrams. If they are fragmented further along
the path, the tunnel endpoint could reassemble fragments from different
packets that share an ID.

The commit message says this matches ipip_tunnel_xmit(). That path ends
in iptunnel_xmit(), which reserves gso_segs IDs:

net/ipv4/ip_tunnel_core.c:iptunnel_xmit() {
    ...
	__ip_select_ident(net, iph, skb_shinfo(skb)->gso_segs ?: 1);
    ...
}

__ip_queue_xmit() does the same. Should ip_encap() call
ip_select_ident_segs(net, skb, NULL, skb_shinfo(skb)->gso_segs ?: 1)
instead?

[Severity: Low]
Should an existing SKB_GSO_TCP_FIXEDID bit be moved to
SKB_GSO_TCP_FIXEDID_INNER here?

tcp4_gro_complete() sets SKB_GSO_TCP_FIXEDID to describe the original
received IPv4 header:

	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);

Once iptunnel_handle_offloads() sets skb->encapsulation, that header
becomes the inner one. However, this documentation file:

Documentation/networking/segmentation-offloads.rst

says "For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the
outer header." inet_gso_segment() follows that rule:

	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));

Take a TCP flow with fixed IP IDs, sent to a multicast group whose route
goes out a VIFF_TUNNEL vif. Would every outer segment get the same IP ID,
while the inner header gets incrementing IDs?

The outer header built by ip_encap() always has frag_off = 0, so this
would send non-atomic datagrams with repeated IDs, which RFC 6864 does not
allow.

ipip_tunnel_xmit() calls the same helper. Its outer DF normally comes from
the tunnel's pmtudisc setting, while ip_encap() always clears DF.

Before this patch these packets were dropped in ipip_gso_segment(), so this
path is newly reachable.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011162957.1328474-1-julius%40bairaktaris.de
