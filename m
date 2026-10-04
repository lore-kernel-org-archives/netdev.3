Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC54AA1CF;
	Sun,  4 Oct 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147657; cv=none; b=dJjUkt2ZiE+TugP8QJEyLqJOMEZA0i4ctw8a/TzL7zgfd0kU0pwiGikvmt0PfXuiuj6+HwWDqaRZ1srLMKGFjLtqBHYTPqlirzBfHtRZxk+GGs/zx4wDKp6rnXb99Q7hAyiQLGx++DedVI7NtTOx91RE5xmSV3FBJx67lruTC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147657; c=relaxed/simple;
	bh=FLFtg+4co7PlFPIHCAd9KoJpqPw0SMsMk/Gr+dkCAkk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVtRPil3d791tuGuDbRI/X9EsRJdm0B7P1hWS7ViPH6mtzgjasVU3qxCUdejsnusksY9TMsxsphEPDT3FY/iC9b0uctEEfeh5aFsxlv2uOqt9J0HtY2RyPLUMYKh2w4rQ9Hmy2H940HmrqCkm/D/negND88/H3PNNP9CUPM79cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSsJHPQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSsJHPQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9F21F000FF;
	Sun,  4 Oct 2026 21:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147651;
	bh=XSxRuUiAvy/im0ZRXBGg9QLJ1ZPEa22LgK/QhPgkRGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OSsJHPQWH/4ZnOTgEIYPsjP10MiSZgBSviQ9UFrYYW8sFJXBCccMYAI4iO8Gyc/I4
	 SsPad4fBm7DMozzy6PlVIOSi11+Q0pL7MCOv2HzwqRp7W2DCEJ/Rdn//xrf0e2WdJD
	 hbVPG1psEk5PXB0x57N6YnSSQVZQS2MJ+FMI9/wvP3FRDTNJotI5cXOIpE59qCMrIT
	 UJwDo1LjYUCPmD0UBo/VXXl8IvpaWMLHbinxTEO12NxfHnRhRquP/G0+K9ETFs58YE
	 IJvlSJLD4wYkO/4o1ypII7USAvY+5kz1nM+kEIKqB3+1HDbxl85VVPg7KZE03km7PZ
	 slkZL4PO1Qe9g==
Subject:
 Re: [PATCH net-next v5 13/14] ip6_gre: add drop reasons to the transmit path
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 21:00:50 +0000
Message-ID: <179114765080.434549.7267204104417826416@kernel.org>
In-Reply-To: <20260930183910.3151873-14-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-14-littlesmilingcloud@gmail.com>
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

- [Medium] On a collect_md ip6gre/ip6gretap device, ip6gre_xmit_ipv6()
  (net/ipv6/ip6_gre.c:839-840) still compares the inner IPv6 source…
- [Low] ip6gre_tunnel_xmit() (net/ipv6/ip6_gre.c:901-904) and
  ip6erspan_tunnel_xmit() (lines 967-970) label every refusal by…

--

ip6_gre: add drop reasons to the transmit path

ip6gre_tunnel_xmit() and ip6erspan_tunnel_xmit() now free dropped packets
with kfree_skb_reason() instead of a plain kfree_skb(). The handlers' own
drops get specific reasons. For a collect_md ip6gre device, the metadata
check now runs right after skb_tunnel_info_txcheck(), so a packet without
usable IPv6 metadata gets SKB_DROP_REASON_TUNNEL_TXINFO.

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 9e94ea6b6c20f..dbca782308158 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -889,14 +889,28 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
>  	enum skb_drop_reason reason;
>  	__be16 payload_protocol;
>  
> -	if (!pskb_inet_may_pull(skb))
> +	reason = pskb_inet_may_pull_reason(skb);
> +	if (reason)
>  		goto tx_err;
>  
> -	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
> +	if (!t->parms.collect_md && ipv6_addr_any(&t->parms.raddr)) {
> +		reason = SKB_DROP_REASON_NO_TX_TARGET;
>  		goto tx_err;
> +	}
>  
> -	if (t->parms.collect_md)
> +	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr)) {
> +		reason = SKB_DROP_REASON_DEV_READY;
> +		goto tx_err;
> +	}

[Severity: Low]
Is SKB_DROP_REASON_DEV_READY the right label for every refusal by
ip6_tnl_xmit_ctl()? The same mapping is added in ip6erspan_tunnel_xmit().

One of the refusal paths in ip6_tnl_xmit_ctl() is an explicit loop
detection:

net/ipv6/ip6_tunnel.c:ip6_tnl_xmit_ctl() {
    ...
		else if (!(p->flags & IP6_TNL_F_ALLOW_LOCAL_REMOTE) &&
			 !ipv6_addr_is_multicast(raddr) &&
			 unlikely(ipv6_chk_addr_and_flags(net, raddr, ldev,
							  true, 0, IFA_F_TENTATIVE)))
			pr_warn_ratelimited("%s xmit: Routing loop! Remote address found on this node!\n",
					    p->name);
    ...
}

The kernel-doc for DEV_READY in include/net/dropreason-core.h describes a
device whose data structures are not up/ready/initialized. In the same
transmit path, ip6_tnl_xmit() uses SKB_DROP_REASON_RECURSION_LIMIT for its
own loop case:

net/ipv6/ip6_tunnel.c:ip6_tnl_xmit() {
    ...
		net_warn_ratelimited("%s: Local routing loop detected!\n",
				     t->parms.name);
		reason = SKB_DROP_REASON_RECURSION_LIMIT;
    ...
}

So a loop through the local node could show up as either reason,
depending on which check catches it.

This happens when the device's non-multicast remote address is configured
on the local node and IP6_TNL_F_ALLOW_LOCAL_REMOTE is not set. The commit
message does acknowledge this choice.

ip6_tnl_xmit_ctl() only returns a boolean, so callers can't tell its
refusal causes apart. Could ip6_tnl_xmit_ctl() return a drop reason
instead, so the loop case is reported like the one in ip6_tnl_xmit()?

> +
> +	if (t->parms.collect_md) {
>  		tun_info = skb_tunnel_info_txcheck(skb);
> +		if (IS_ERR(tun_info) ||
> +		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6)) {
> +			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
> +			goto tx_err;
> +		}
> +	}

[Severity: Medium]
This early check only covers packets without valid IPv6 metadata. What
happens to an inner IPv6 packet from :: that does carry valid IPv6 TX
metadata on a collect_md ip6gre or ip6gretap device?

On such a device, raddr is :: because ip6gre_tap_validate() accepts an
omitted IFLA_GRE_REMOTE. ip6gre_xmit_ipv6() still compares the inner
source address with raddr, even in collect_md mode:

net/ipv6/ip6_gre.c:ip6gre_xmit_ipv6() {
    ...
	if (ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr))
		return SKB_DROP_REASON_RECURSION_LIMIT;
    ...
}

As a result, every inner IPv6 packet sourced from :: is dropped, even if
key->u.ipv6.dst holds a real endpoint. One example is the DAD Neighbour
Solicitation of a VM behind an OVS collect_md ip6gretap port.

With this patch, that drop goes to kfree_skb_reason() as
SKB_DROP_REASON_RECURSION_LIMIT. dropreason-core.h documents that reason
as a "Dead loop on virtual device", but no loop exists here. Drop
monitoring tools would then report a routing loop for ordinary DAD or
MLD traffic.

The commit message notes this case:

    A packet from :: that carries IPv6 metadata still meets the check in
    ip6gre_xmit_ipv6().

ip6erspan_tunnel_xmit() in the same file only runs the raddr/saddr test
in native mode. ip6_tnl_start_xmit() in net/ipv6/ip6_tunnel.c applies
ip6_tnl_addr_conflict() to collect_md ip6tnl devices as well, and it now
reports the same RECURSION_LIMIT reason.

The drop itself predates this series. The check came from c12b395a4664,
and 6712abc168eb left it in place for collect_md. The RECURSION_LIMIT
label is new, though, and the last patch in the series only touches
vxlan, so it is still there at the end of the series.

Would it make sense to guard the test in ip6gre_xmit_ipv6() (and in
ip6_tnl_start_xmit()) with !t->parms.collect_md, as
ip6erspan_tunnel_xmit() does?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930183910.3151873-1-littlesmilingcloud%40gmail.com
