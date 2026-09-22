Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E999549378;
	Tue, 22 Sep 2026 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093364; cv=none; b=siAEKi3/i/bnuH56KFMsAFXm6axwKQW/t0ZElLqfOmeXDetAVNnkH/gHIJYzPp8FCQAS7yy1WJFgPRXQDR1fmCdGCo6I9pYf4LkiqRv2os6jLUDxDwq10Pnn47/LaXOOSJIfCaIZT7CX+sV5nLVC8w9e7W1MTXl4JrTfkLVLd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093364; c=relaxed/simple;
	bh=aZis7mWSM6fIM0b/+zVTDdJoxcPKL0dyFAOOK0keljE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgmX/+NxcLC7kS5i2wy7K3jcPbwKeuoLMLL6IW8kyI1VNBRRmrgicxYPc8u0525aM1j+R9g7ElUMgBxwbJeCJDTNJI58pFfaQfT0ykMThPDMcl+s0f5CZ82H0X2xUwTZT0X4xLwHqgX6NXSdxlxhv/G8QkVjENUaiBJ12SbGjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7Rulixi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7Rulixi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC601F000FF;
	Tue, 22 Sep 2026 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093362;
	bh=wiVk/EjFI5SuvKN7+IRuT9f2lsWVYrIeiAj1aVG8x5Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k7Rulixin0iQ485dNCuD3yarfLjOOfj5HiQy40zt9k/j7EMBYYCD4ie61lElcLb1U
	 P+ELCKGNSr7b3hObdd/XUjjH/XO7lmKAYZg5S8ulbKTbOVEMQA6H78FpwWN7L4TYlq
	 wuIgsbeZNLLDFWSFwPT0PxCUNe8zttVA3k6s+olASYAIdwQJLeBSekqQhAHwAnsbmK
	 tQFUG1EX6fo8v1eVxABBwwYcx7mTUFvtAWlSEE6JH79VBKSTYuebvA1XTenZ+HP/Uw
	 pssClQ6HT2kp5tUOtP6CSotpGCTzKLhD7C0h0vo/lZKt9ViLFNFQLLKOJSVph4o9R9
	 Cc8OJwqRNN53Q==
Subject: Re: [PATCH net] ipv4: fib: treat an unbuildable encapsulation as a
 nexthop mismatch
From: netdev-bot+sashiko@kernel.org
To: g.goller@proxmox.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 roopa@cumulusnetworks.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 16:09:21 +0000
Message-ID: <179009336183.2160803.4263260062974778447@kernel.org>
In-Reply-To: <20260918152836.1173368-1-g.goller@proxmox.com>
References: <20260918152836.1173368-1-g.goller@proxmox.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the RTA_MULTIPATH branch of fib_nh_match() never
  compares per-nexthop encapsulation, so the wrong-route-deletion the…
- [High] The fix is gated so narrowly that the bug class the commit
  message claims to close remains reachable: fib_nh_match()…
- [Medium] fib_encap_match() still reports "match" (returns 0) for an
  RTM_DELROUTE that carries RTA_ENCAP but no RTA_ENCAP_TYPE, i.e.…

--

ipv4: fib: treat an unbuildable encapsulation as a nexthop mismatch

fib_encap_match() previously left its result at 0 when
lwtunnel_build_state() failed, which fib_nh_match() reads as "the nexthop
matches".  The patch makes a failed build return 1 so the candidate route
is treated as a mismatch.

A few questions about how far this closes the case described in the
changelog.

> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 50e96f86ca59..951e48ae87da 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -911,17 +911,17 @@ static int fib_encap_match(struct net *net, u16 encap_type,
>  			   struct netlink_ext_ack *extack)
>  {
>  	struct lwtunnel_state *lwtstate;
> -	int ret, result = 0;
> +	int result;
>  
>  	if (encap_type == LWTUNNEL_ENCAP_NONE)
>  		return 0;

[Severity: Medium]
Does this early return leave one form of kernel-rejected encapsulation
still reporting a match?

rtm_to_fib_config() in net/ipv4/fib_frontend.c parses the two attributes
independently:

	case RTA_ENCAP:
		cfg->fc_encap = attr;
		break;
	case RTA_ENCAP_TYPE:
		cfg->fc_encap_type = nla_get_u16(attr);
		err = lwtunnel_valid_encap_type(cfg->fc_encap_type, extack);

so an RTM_DELROUTE carrying RTA_ENCAP without RTA_ENCAP_TYPE yields
fc_encap != NULL and fc_encap_type == 0 == LWTUNNEL_ENCAP_NONE.
fib_nh_match() enters fib_encap_match() purely because cfg->fc_encap is
set, and the encap_type == LWTUNNEL_ENCAP_NONE test above then returns 0
before the new build_state check, without ever looking at nh->fib_nh_lws.

The add path rejects the same input: fib_nh_common_init() calls
lwtunnel_build_state() with encap_type 0 and gets -EINVAL ("Unknown LWT
encapsulation type" in net/core/lwtunnel.c).  For comparison,
nh_create_ipv4()/nexthop parsing in net/ipv4/nexthop.c rejects NHA_ENCAP
without NHA_ENCAP_TYPE with "LWT encapsulation type is missing".

Should the delete path likewise refuse RTA_ENCAP without RTA_ENCAP_TYPE,
rather than having fib_nh_match() fall through to comparing oif and
gateway only and letting fib_table_delete() pick the alias?

>  
> -	ret = lwtunnel_build_state(net, encap_type, encap, AF_INET,
> -				   cfg, &lwtstate, extack);
> -	if (!ret) {
> -		result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
> -		lwtstate_free(lwtstate);
> -	}
> +	if (lwtunnel_build_state(net, encap_type, encap, AF_INET, cfg,
> +				 &lwtstate, extack))
> +		return 1;

[Severity: High]
Is fib_encap_match() reached for every delete request that carries an
encapsulation?  In fib_nh_match() the call site sits inside the oif/gateway
branch:

	if (cfg->fc_oif || cfg->fc_gw_family) {
		struct fib_nh *nh;

		nh = fib_info_nh(fi, 0);
		if (cfg->fc_encap) {
			if (fib_encap_match(net, cfg->fc_encap_type,
					    cfg->fc_encap, nh, cfg, extack))
				return 1;
		}

A request with RTA_ENCAP and RTA_ENCAP_TYPE but no RTA_OIF, no gateway and
no RTA_MULTIPATH skips that block entirely and lands on:

	if (!cfg->fc_mp)
		return 0;

which reports a match without the requested encapsulation ever being built
or compared.  rtm_to_fib_config() records fc_encap/fc_encap_type with no
requirement for an oif or gateway, and it only validates the encap type via
lwtunnel_valid_encap_type() - the per-type payload check in
ops->build_state (for example mpls_build_state()) never runs on this path.

So does "ip route del <prefix> encap mpls 100" still remove a route
installed as "<prefix> encap mpls 200 dev X"?  Would moving the encap
comparison out of the oif/gw branch address that?

[Severity: High]
For the RTA_MULTIPATH case, fib_encap_match() is not called at all.  The
loop under CONFIG_IP_ROUTE_MULTIPATH in fib_nh_match() looks only at
rtnh_ifindex plus RTA_GATEWAY, RTA_VIA and RTA_FLOW:

	for_nexthops(fi) {
		...
		if (rtnh->rtnh_ifindex && rtnh->rtnh_ifindex != nh->fib_nh_oif)
			return 1;

		attrlen = rtnh_attrlen(rtnh);
		if (attrlen > 0) {
			struct nlattr *nla, *nlav, *attrs = rtnh_attrs(rtnh);
			...
			nla = nla_find(attrs, attrlen, RTA_GATEWAY);
			nlav = nla_find(attrs, attrlen, RTA_VIA);
			...
			nla = nla_find(attrs, attrlen, RTA_FLOW);

There is no nla_find(attrs, attrlen, RTA_ENCAP) anywhere in that section,
even though the add side consumes exactly those per-hop attributes in
fib_get_nhs():

		fib_cfg.fc_encap = nla_find(attrs, attrlen, RTA_ENCAP);
		nla = nla_find(attrs, attrlen, RTA_ENCAP_TYPE);
		if (nla)
			fib_cfg.fc_encap_type = nla_get_u16(nla);

and feeds it through fib_nh_init() -> fib_nh_common_init() ->
lwtunnel_build_state().  Pre-dispatch validation of the nested attributes in
lwtunnel_valid_encap_type_attr() (net/core/lwtunnel.c) only checks that the
nested type is registered:

			if (lwtunnel_valid_encap_type(encap_type, extack))
				return -EOPNOTSUPP;

so both a differing and an unbuildable nested encap pass.  An RTM_DELROUTE
with RTA_MULTIPATH whose nexthops agree on ifindex, gateway and flow still
returns 0 from fib_nh_match(), and fib_table_delete() in
net/ipv4/fib_trie.c acts on it:

		    fib_nh_match(net, cfg, fi, extack) == 0 &&
		    fib_metrics_match(cfg, fi)) {
			fa_to_delete = fa;

Can the multipath loop also compare each nexthop's encapsulation, so the
case in the changelog is covered for multipath routes too?

> +
> +	result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
> +	lwtstate_free(lwtstate);
>  
>  	return result;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918152836.1173368-1-g.goller%40proxmox.com
