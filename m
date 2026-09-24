Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1801AAE17;
	Thu, 24 Sep 2026 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212131; cv=none; b=BsP1HhvZ19PvsrlcYRAkmFKEjm5wGyABF1TdngJO60yKXjxZlj7QMmNw/XmmJs72OtKGWrEe3bDZg0KlL0xDwxYfl6hYycRritqnB68B8ztPxOodN7XsWfA/yrff+GqAUlfx27ZAAw68CcRHuQ3eQT6eL0UFq1RC3jCuY07noF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212131; c=relaxed/simple;
	bh=DxhAggqbZTZAw7OS+5nSffx8tAYwP09fytEMMqVIq0g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y5NE9wTB9tERYU1tmanpJqe9SAB6zAvYOlRy3YSXmggnoENHs2WCzGSMtmCtf115eQTqEzNHTOL8i8o1/JnAy4P5EmVTBC6ASZwuwG4tqbX4zw44UUmlIJPF3HvbzVfmbgaNmX8atn2Tzpaxz+Vf2tMsJFQnyuEltqMKeUX9Xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgH3MRRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgH3MRRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6871F000FF;
	Thu, 24 Sep 2026 01:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212129;
	bh=g4/RKkiF55bCTpqDfG1U5T4zS6JNMb3fo/WqGETZ0Jc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PgH3MRRvn0mb5itMSaIsF0eLApt+fcG84Vx+GyNRD8tmv6E3bWv7ZYKD/uFtmG+pk
	 haeprTUK4emYH7XpXlW1sWuQZcPTnY6ohHnwSALwsvisfnDP04MPyZjtT/Eloi6gi7
	 lCZyJH+19LWdLjIvJrZZ+8FhOoixh/CufH+eMVsHmBcqjdmjyWKW/O3ryd2YhukSUI
	 WxurGV9tWUwhS/ZaqnyTkyNXmCsYvFNmX4NvwUHLyIGak0bpjmY6CWzMC6kET51ZBZ
	 iCZUfgfg1D8xIpQTXHhSgJb6ROG9sepA3zcBTWsCBp0fAZ375ds+JFNUGKr3HxOpcH
	 Y+M2hCbSGcrFQ==
Subject: Re: [PATCH net v2] ipv4: fib: treat an unbuildable encapsulation as a
 nexthop mismatch
From: netdev-bot+sashiko@kernel.org
To: g.goller@proxmox.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 roopa@cumulusnetworks.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 01:08:48 +0000
Message-ID: <179021212874.2160803.12156416995100672970@kernel.org>
In-Reply-To: <20260921130736.210845-1-g.goller@proxmox.com>
References: <20260921130736.210845-1-g.goller@proxmox.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the encapsulation selector of an RTM_DELROUTE is
  still ignored on two reachable paths, so the exact outcome the commit…

--

ipv4: fib: treat an unbuildable encapsulation as a nexthop mismatch

fib_encap_match() used to leave its result at 0 when lwtunnel_build_state()
failed, which fib_nh_match() reads as "the nexthop matches".  The patch
returns a mismatch in that case and drops the now redundant
LWTUNNEL_ENCAP_NONE test, since lwtunnel_build_state() rejects that type
itself.

> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 50e96f86ca59a..001da9fc86cc3 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -911,17 +911,14 @@ static int fib_encap_match(struct net *net, u16 encap_type,
>  			   struct netlink_ext_ack *extack)
>  {
>  	struct lwtunnel_state *lwtstate;
> -	int ret, result = 0;
> +	int result;
>  
> -	if (encap_type == LWTUNNEL_ENCAP_NONE)
> -		return 0;
> +	if (lwtunnel_build_state(net, encap_type, encap, AF_INET, cfg,
> +				 &lwtstate, extack))
> +		return 1;
>  
> -	ret = lwtunnel_build_state(net, encap_type, encap, AF_INET,
> -				   cfg, &lwtstate, extack);
> -	if (!ret) {
> -		result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
> -		lwtstate_free(lwtstate);
> -	}
> +	result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
> +	lwtstate_free(lwtstate);
>  
>  	return result;
>  }

[Severity: High]
The change to fib_encap_match() looks right on its own, but does it actually
cover the case described in the changelog?

The commit message says:

    So if there comes along a RTM_DELROUTE which carries an encapsulation
    the kernel rejects, it could delete a different route with a different
    encapsulation.

fib_encap_match() has a single caller, and that call is nested inside a test
for an output interface or a gateway in fib_nh_match():

net/ipv4/fib_semantics.c:fib_nh_match() {
	...
	if (cfg->fc_oif || cfg->fc_gw_family) {
		struct fib_nh *nh;

		nh = fib_info_nh(fi, 0);
		if (cfg->fc_encap) {
			if (fib_encap_match(net, cfg->fc_encap_type,
					    cfg->fc_encap, nh, cfg, extack))
				return 1;
		}
	...
}

rtm_to_fib_config() records RTA_ENCAP unconditionally and does not require
RTA_OIF or RTA_GATEWAY next to it:

net/ipv4/fib_frontend.c:rtm_to_fib_config() {
	...
		case RTA_ENCAP:
			cfg->fc_encap = attr;
			break;
	...
}

So for an RTM_DELROUTE carrying only RTA_DST plus RTA_ENCAP (and no
RTA_OIF, no RTA_GATEWAY, no RTA_MULTIPATH), isn't the whole block above
skipped, leaving fib_nh_match() to fall through to:

net/ipv4/fib_semantics.c:fib_nh_match() {
	...
#ifdef CONFIG_IP_ROUTE_MULTIPATH
	if (!cfg->fc_mp)
		return 0;
	...
}

and fib_table_delete() then picks that alias?

net/ipv4/fib_trie.c:fib_table_delete() {
	...
		    fib_nh_match(net, cfg, fi, extack) == 0 &&
		    fib_metrics_match(cfg, fi)) {
			fa_to_delete = fa;
	...
}

Two aliases with different lwtunnel encapsulation can coexist, since
nh_comp() distinguishes them via lwtunnel_cmp_encap(), for example:

  ip route append 10.0.0.0/24 encap ip id 1 dst A dev eth0
  ip route append 10.0.0.0/24 encap ip id 2 dst B dev eth0

A delete request for 10.0.0.0/24 carrying the id 2 encapsulation, or an
RTA_ENCAP with no RTA_ENCAP_TYPE (encap_type == LWTUNNEL_ENCAP_NONE, which
lwtunnel_build_state() rejects with -EINVAL), and no oif or gateway, would
then remove the id 1 route instead.  Should the encap comparison be moved
out from under the cfg->fc_oif || cfg->fc_gw_family test so this path is
covered too?

A second path looks similar.  The RTA_MULTIPATH loop in fib_nh_match()
compares rtnh_ifindex, RTA_GATEWAY/RTA_VIA and, with
CONFIG_IP_ROUTE_CLASSID, RTA_FLOW, but never the nested RTA_ENCAP and
RTA_ENCAP_TYPE:

net/ipv4/fib_semantics.c:fib_nh_match() {
	...
	for_nexthops(fi) {
		int attrlen;

		if (!rtnh_ok(rtnh, remaining))
			return -EINVAL;

		if (rtnh->rtnh_ifindex && rtnh->rtnh_ifindex != nh->fib_nh_oif)
			return 1;
	...
}

The add side does consume those attributes in fib_get_nhs():

net/ipv4/fib_semantics.c:fib_get_nhs() {
	...
			fib_cfg.fc_encap = nla_find(attrs, attrlen, RTA_ENCAP);
	...
}

and rtm_to_fib_config() only validates the nested encapsulation type
number, never the payload:

net/ipv4/fib_frontend.c:rtm_to_fib_config() {
	...
		case RTA_MULTIPATH:
			err = lwtunnel_valid_encap_type_attr(nla_data(attr),
							     nla_len(attr),
							     extack);
	...
}

Does this make ECMP routes that differ only in per-nexthop encapsulation
interchangeable for deletion?

If relocating the check and teaching the multipath loop about RTA_ENCAP is
out of scope here, could the changelog be narrowed to say the fix applies
only to requests that also carry an oif or a gateway, so backporters do not
read it as closing the whole case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921130736.210845-1-g.goller%40proxmox.com
