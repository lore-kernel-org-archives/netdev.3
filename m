Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3355C33D;
	Tue, 22 Sep 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091424; cv=none; b=WJtpNdr541YcnFTGyU7ZmMz88VG0Zho2SMbKzds4rpm38yQt/VykTTDgVEaDI1rUEVm3ZsHxV1d24b+oU4zeaaPRNs1kfBDyOYybQIlQjfa4V4yFdvvXdshDjlDuqJeWTeD0YzOTlBrrYQTm16MtKBqL+V0VTP1jDyHFWWrZQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091424; c=relaxed/simple;
	bh=rsMDvdAbtvoABYwhg/X/cTGymXJ9hKGwhRWcnnt6A68=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QlAmMPpWIyGjpwDM8uhjao+qgwZr7Wy5d4Tv46XHIQDyHpFUODE9NgQOruKwga7E3wAivT7kc/lXbFddvobeNIXXlZSGEKtCNmKOjPLAVERDle1lAN6DnvGuKZTjWvi5IQJkeUBpb178q1OYN/mOT3nGFvP9KjECn6VrWcgGKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGuqbTJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGuqbTJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78E31F000FF;
	Tue, 22 Sep 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091422;
	bh=S13S5usVPAem3KF3x7SHy0e4q0NgWKp/T4RI6TxtJjw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jGuqbTJ85HdCyG9Ktgs4IzfMWqgI9cPqd9NFr39PjZnZI9NnpkrObG0x8QVVVKy2U
	 WS+KIEK4DmnSbpS0sqkP3chZjqptyB6cY1VKuCaorDB73cHof0QdP6yuAY0N2EUtOF
	 S9JzxEbFdWV/sYhhAaVFpcFaL1hEx7+pYWKcozC/g9q2po8gN7hRC4taW2xpNARYTv
	 BNr0c1NwW7ly8X2lsr2VO8es0Wxd40e2yS1SCJwh5B7gWIQoGA12948iGkPDbaw5x/
	 2S6tBqFjc9vw0G15i+OA8HIkcNXGzu36WlZEpvTsaONYj8Y4akn1idnGBsgQiGoVld
	 9SkWrENTKfmnA==
Subject:
 Re: [PATCH] ipv6: check per-interface proxy_ndp in forwarding and NA paths
From: netdev-bot+sashiko@kernel.org
To: adrianox@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 15:37:01 +0000
Message-ID: <179009142113.2160803.656958485064300227@kernel.org>
In-Reply-To: <20260918151405.716075-1-adrianox@gmail.com>
References: <20260918151405.716075-1-adrianox@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete alignment in ndisc_recv_na(): the patch makes the
  proxy_ndp half of the proxy-NA suppression test per-interface aware…
- [Medium] In ip6_forward() the newly added per-interface test reads
  `idev->cnf.proxy_ndp`, where `idev` is derived from `IP6CB(skb)->iif`…

--

ipv6: check per-interface proxy_ndp in forwarding and NA paths

This makes ip6_forward() and ndisc_recv_na() consider the per-interface
proxy_ndp setting in addition to the global net.ipv6.conf.all.proxy_ndp,
matching what ndisc_recv_ns() already does.

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 550965058991..738fa46a892a 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -581,8 +581,8 @@ int ip6_forward(struct sk_buff *skb)
>  		return -ETIMEDOUT;
>  	}
>  
> -	/* XXX: idev->cnf.proxy_ndp? */
> -	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
>  	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {

[Severity: Medium]
Is the device used for the new per-interface read the same one used by the
lookup on the next line?  In ip6_forward(), idev comes from IP6CB(skb)->iif:

net/ipv6/ip6_output.c:ip6_forward() {
	idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
	...
}

while pneigh_lookup() is called with skb->dev.

IP6CB(skb)->iif is recorded in ip6_rcv_core() before the l3mdev receive
handler runs:

net/ipv6/ip6_input.c:ip6_rcv_core() {
	IP6CB(skb)->iif = skb_valid_dst(skb) ?
				ip6_dst_idev(skb_dst(skb))->dev->ifindex :
				dev->ifindex;
}

and vrf_ip6_rcv() then replaces skb->dev without rewriting IP6CB->iif:

drivers/net/vrf.c:vrf_ip6_rcv() {
	if (!is_ndisc) {
		struct net_device *orig_dev = skb->dev;

		dev_dstats_rx_add(vrf_dev, skb->len);
		skb->dev = vrf_dev;
		skb->skb_iif = vrf_dev->ifindex;
	...
}

The device-preserving NDISC branch is chosen by ipv6_ndisc_frame(), which
only matches when iph->nexthdr == NEXTHDR_ICMP, with the in-file comment
noting "This really fails for multiple next protocols (e.g., NEXTHDR_HOP).
But it is a start."

So for non-NDP traffic to a proxied address, or an NS/NA behind a
hop-by-hop or destination-option header, idev is the slave while skb->dev
is the VRF master.  pneigh_lookup() only matches the requested device or a
wildcard entry:

net/core/neighbour.c:pneigh_lookup() {
		if (!memcmp(n->key, pkey, key_len) &&
		    net_eq(pneigh_net(n), net) &&
		    (n->dev == dev || !n->dev))
	...
}

Can this end up consulting proxy_ndp on one interface while looking up
proxy entries on another?  In that case the master's own proxy_ndp is
ignored (the packet is forwarded with the hop limit decremented instead of
going to ip6_input(), and the link-local dst_link_failure() path in
ip6_forward_proxy_check() is skipped), and conversely a slave's flag can
enable the proxy check against a wildcard entry on the master.

Both ndisc.c call sites use skb->dev for the per-device read and for the
lookup, and the removed "/* XXX: idev->cnf.proxy_ndp? */" comment sat
directly above the skb->dev based lookup.  Would reading
__in6_dev_get(skb->dev) here (or doing the lookup on the iif device) be
more consistent?

> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 75515fd99383..f787082069b7 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1097,9 +1097,9 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
>  		 */
>  		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
>  		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
> -		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +		    (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +		     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
>  		    pneigh_lookup(&nd_tbl, net, &msg->target, dev)) {
> -			/* XXX: idev->cnf.proxy_ndp */
>  			goto out;
>  		}

[Severity: Medium]
Should the forwarding test here be made per-interface too?  The condition
still short-circuits on devconf_all->forwarding, so with global forwarding
at 0 the newly added per-interface proxy_ndp term is never evaluated.

The site the changelog names as the reference uses the per-device value:

net/ipv6/ndisc.c:ndisc_recv_ns() {
		if (ipv6_chk_acast_addr(net, dev, &msg->target) ||
		    (READ_ONCE(idev->cnf.forwarding) &&
		     (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
		      READ_ONCE(idev->cnf.proxy_ndp)) &&
	...
}

and ndisc_recv_na() itself uses the per-device value a little earlier for
the RFC 9131 decision:

	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {

ip6_forward() also admits forwarding on the per-device flag alone:

net/ipv6/ip6_output.c:ip6_forward() {
	if (!READ_ONCE(net->ipv6.devconf_all->forwarding) &&
	    (!idev || !READ_ONCE(idev->cnf.force_forwarding)))
		goto error;
}

with Documentation/networking/ip-sysctl.rst describing force_forwarding as
"Enable forwarding on this interface only -- regardless of the setting on
``conf/all/forwarding``".

For conf/all/forwarding=0, conf/<dev>/forwarding=1,
conf/<dev>/force_forwarding=1, conf/all/proxy_ndp=0 and
conf/<dev>/proxy_ndp=1 with a proxy neigh entry, ndisc_recv_ns() answers
the proxy NS and ip6_forward() now takes the proxy path, but this test
falls through to ndisc_update() for a proxy NA carrying the router's own
MAC, which is what the "Don't update the neighbor cache entry on a proxy NA
from ourselves" comment is guarding against.

For an entry that is not NUD_VALID, __neigh_update() installs the supplied
lladdr without the override restriction:

net/core/neighbour.c:__neigh_update() {
	if (old & NUD_VALID) {
		if (lladdr != neigh->ha && !(flags & NEIGH_UPDATE_F_OVERRIDE)) {
	...
}

so can the proxied target's entry end up holding the router's own MAC in
that configuration?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918151405.716075-1-adrianox%40gmail.com
