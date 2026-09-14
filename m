Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A7379988;
	Mon, 14 Sep 2026 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360651; cv=none; b=aYUqWz0VfgdHLwjQLqixMcNePGDhiruQqrFIQm7X6VR7PI3sVlcBrLESMMDWEaeSPwgDu9RBPXJ+Vlvu4yQlE9MW7PC+oaca8Jlmbzdvl/STWLKhvzEPzqae43tbGwi40unBeCBaIViPWY+ugW9834ASocfGrwHeeRC86Pj/KXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360651; c=relaxed/simple;
	bh=1S1c7k9jdFng2gUXqSjYctee/PPMJZh1e/w6JtiudHg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YiewU66/hKDnufBb80xA1A7qXqHi0PgR2irFsNXTzrsy8N3klm24wcu6oxjZB68Z5shwcIMg60kTqQKNOVjRpibd5X3UDIUZIc6mz8uoqPQvRCt/3l2mTiAKVt9mZj26mwe6urYy3VIHHIcJaqpOVIeGmhMkcQFGSPpnRdGOU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en3S4/j6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en3S4/j6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EAB1F00893;
	Mon, 14 Sep 2026 04:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789360643;
	bh=s+jHF0Px0qUjsp5DlyJ1OnYlin096ANFKx24PDmbnHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=en3S4/j6DASSNA/LviMSFaPdyPhXMzqfH739Q8Aaj/29D9Pe+NP4dvGFB7Dzn0lSB
	 0l6ylCXG32tHTTQSPAW/ZQg06TA/tMUYhqVCzmnLvqQUpFbTdiB1Xv0/8qyR7mscaq
	 1zmZlbHXAbc+9KLzhaz0wVYHE/RUAJwh75Zo4lyt2Dtg3QuttBBorH+vr99rALEwJF
	 FD7fBJIVqQm/NVwn1DCLJGDhx5XCYzIc64UMfiPRjigHsRmodI0N5PU/dICLq37zNM
	 ojWC1i8xpSFqKChfY27aoXPbwalI1NcmBEmiHe1ZRiDr1xIMT9H7CQS09HNslSnXbd
	 0K83qkq/wHW/w==
Subject:
 Re: [PATCH net-next v2 8/8] ip6_tunnel: add drop reasons to the transmit path
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 04:37:22 +0000
Message-ID: <178936064264.22033.5452553187769525789@kernel.org>
In-Reply-To: <20260913034937.875068-9-littlesmilingcloud@gmail.com>
References: <20260913034937.875068-9-littlesmilingcloud@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] ipxip6_tnl_xmit() clobbers the drop reason produced by
  ip6_tnl_xmit() on every failure.
- [Low] In the NBMA branch of ip6_tnl_xmit() the IPv4-payload case labels
  a missing rtable as SKB_DROP_REASON_IP_OUTNOROUTES…

--

ip6_tunnel: add drop reasons to the transmit path

This converts the IPv6 tunnel transmit path to report SKB drop reasons,
giving ip6_tnl_xmit() a new output parameter that is threaded through
ipxip6_tnl_xmit(), __gre6_xmit() and the ip6gre_xmit_*() helpers, and
switching the two tx_err paths from kfree_skb() to kfree_skb_reason().

A couple of questions about the reason values below.

> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 458ce328311b4..d804c67c4be3b 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1097,6 +1097,7 @@ EXPORT_SYMBOL_GPL(ip6_tnl_xmit_ctl);
>   *   @encap_limit: encapsulation limit
>   *   @pmtu: Path MTU is stored if packet is too big
>   *   @proto: next header value
> + *   @reason: drop reason, only written when the packet is dropped
>   *
>   * Description:
>   *   Build new header and do some sanity checks on the packet before sending

[ ... ]

> @@ -1162,8 +1167,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  		} else if (payload_protocol == htons(ETH_P_IP)) {
>  			const struct rtable *rt = skb_rtable(skb);
>  
> -			if (!rt)
> +			if (!rt) {
> +				*reason = SKB_DROP_REASON_IP_OUTNOROUTES;
>  				goto tx_err_link_failure;
> +			}

[Severity: Low]
Should this be SKB_DROP_REASON_NO_TX_TARGET instead?

No route lookup has happened yet at this point in the NBMA branch of
ip6_tnl_xmit().  skb_rtable() is just dst_rtable(skb_dst(skb)), so !rt is the
same "the skb carries no dst" condition that the sibling IPv6-payload branch a
few lines above labels NO_TX_TARGET:

			if (!skb_dst(skb)) {
				*reason = SKB_DROP_REASON_NO_TX_TARGET;
				goto tx_err_link_failure;
			}

dropreason-core.h documents IP_OUTNOROUTES as "route lookup failed" and
NO_TX_TARGET as "no target found for xmit", and ip_tunnel_xmit() in
net/ipv4/ip_tunnel.c uses NO_TX_TARGET for the analogous NBMA missing-dst
case:

		if (!skb_dst(skb)) {
			DEV_STATS_INC(dev, tx_fifo_errors);
			reason = SKB_DROP_REASON_NO_TX_TARGET;
			goto tx_error;
		}

As written, IP_OUTNOROUTES now covers two different conditions inside
ip6_tnl_xmit(), since it is also used for the genuine ip6_route_output() and
xfrm_lookup() failures further down.

[ ... ]

> @@ -1408,13 +1435,15 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
>  	fl6.flowi6_uid = sock_net_uid(dev_net(dev), NULL);
>  	dsfield = INET_ECN_encapsulate(dsfield, orig_dsfield);
>  
> -	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
> +	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6)) {
> +		*reason = SKB_DROP_REASON_NOMEM;
>  		return -1;
> +	}
>  
>  	skb_set_inner_ipproto(skb, protocol);
>  
>  	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
> -			   protocol);
> +			   protocol, reason);
>  	if (err != 0) {
>  		/* XXX: send ICMP error even if DF is not set. */
>  		if (err == -EMSGSIZE)
> @@ -1429,6 +1458,7 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
>  			default:
>  				break;
>  			}
> +		*reason = SKB_DROP_REASON_PKT_TOO_BIG;
>  		return -1;
>  	}

[Severity: High]
Does this overwrite the reason that ip6_tnl_xmit() just stored?

The if (err == -EMSGSIZE) body is only the ICMP-emitting switch, so the
*reason = SKB_DROP_REASON_PKT_TOO_BIG assignment runs for every non-zero err,
not just for -EMSGSIZE.

ip6_tnl_xmit() sets a distinct reason on each of its failure paths
(NO_TX_TARGET, NEIGH_CREATEFAIL, IP_OUTNOROUTES, DEV_READY, RECURSION_LIMIT,
NOMEM, TNL_ENCAP), and all of them are replaced here before
ip6_tnl_start_xmit() consumes the value:

  ip6_tnl_start_xmit()
    ret = ipxip6_tnl_xmit(skb, dev, ipproto, &reason);
      err = ip6_tnl_xmit(..., reason);   /* sets IP_OUTNOROUTES */
      *reason = SKB_DROP_REASON_PKT_TOO_BIG;
    tx_err:
      kfree_skb_reason(skb, reason);     /* reports PKT_TOO_BIG */

So an ip6ip6/ipip6/mplsip6 tunnel with an unreachable remote, an allocation
failure in skb_cow_head(), a local routing loop (tdev == dev) or an
ip6_tnl_xmit_ctl() refusal all end up reported as PKT_TOO_BIG.

For the one case where the assignment would be correct, -EMSGSIZE,
ip6_tnl_xmit() has already stored PKT_TOO_BIG, so the statement looks
redundant there.

This also disagrees with the kernel-doc added in the same patch,
"@reason: drop reason, only written when the packet is dropped", which makes
the callee the owner of the value, and with the ip6_gre callers
(__gre6_xmit(), ip6gre_xmit_ipv4(), ip6gre_xmit_ipv6(),
ip6erspan_tunnel_xmit()) which propagate the callee's reason untouched.

Would moving the assignment inside the err == -EMSGSIZE block, or dropping
it entirely, be what was intended here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913034937.875068-1-littlesmilingcloud%40gmail.com
