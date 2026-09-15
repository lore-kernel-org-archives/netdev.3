Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766ED3A1685
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474271; cv=none; b=J+qQ5Jj4rKCJwcFpDjJzx6WZefvOdeDxzCkWq41P6HKfJ36VIydisKbvUiPAESLpCAC7SntLK5xGm73WRDHr9jgrfxBQElvYimiavr3mTS6IXrcDNTK9AFG+4TZycaMaxkk5on99faBpXACdeFUyydktgmVzZ6sy41zadjSJ2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474271; c=relaxed/simple;
	bh=XKqDF19Lx4pG9+N0DBEmwbHJKcVAILzd7Ite8lcafS8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B+O69/hp143I7hu3249IYvlPR3/zcyUF/de8MOwdKEhvxJmhbZTDXMXPGeT4tAbihbNL2S0x/EC2Or+RC5qQXSgNfi8VHoh5lqpz1TWcN5knfV6RPr5QQuA24MoF1xv7+Ng41Miuc+Wzi45gC1QfEm61R6xp3rgtPmJEWETcx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhMssPSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhMssPSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7571F000FF;
	Tue, 15 Sep 2026 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474270;
	bh=OxwbQ/SLdoO+jLLZZ1DujJiasSJ6WRYqSOPQgRVYGOw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IhMssPSsCyB7uuBr5fsejZK0UeW+RD+c87ohd67sLO2YoB3QU/iE6bVQYBADtozR3
	 fUO+VhZtZitHdSP/USsJF1enuOj0Ax6nVSrg5wB1Gczspv9uV41oFu+7StBJ/iBH8q
	 yEF9GGK+5/gnk/xKnI+pz6c+DOH5e1VVYMf4wImZkKtXGfvr3RFpXNBQoXZsydu5Ui
	 hepnGUSf2/pCH3k3zeUPMcV1yM+Cb5G8rnjZzt6Gk2DW0rcSVPZwH7zXyZOmwWToUr
	 8QennUTJhr2IAXFWNF8W9Ycfis0KIMh66yYlJg9I2gv54H3V1bBCBLY5v4EdIxyE8f
	 uqSbO6wfrAAWQ==
Subject: Re: [PATCH net 1/3] ip_gre: validate netlink attributes before
 changing the tunnel
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Tue, 15 Sep 2026 12:11:09 +0000
Message-ID: <178947426905.22033.13906069160544959333@kernel.org>
In-Reply-To: <20260912150944.3470971-2-edumazet@google.com>
References: <20260912150944.3470971-2-edumazet@google.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] The patch does not close the bug class its commit message claims
  to fix: a rejected GRE/ERSPAN changelink can still leave the live…

--

ip_gre: validate netlink attributes before changing the tunnel

The patch reorders ipgre_netlink_parms() and erspan_netlink_parms() so that
attribute validation happens before the live tunnel is touched.  The ERSPAN
attributes are parsed into local variables and copied into the tunnel at the
end, and the IFLA_GRE_COLLECT_METADATA handling is moved after the
IFLA_GRE_IGNORE_DF validation.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 82309efd417e0..40b922362a7ca 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1233,12 +1233,6 @@ static int ipgre_netlink_parms(struct net_device *dev,
>  		parms->iph.frag_off = htons(IP_DF);
>  	}
>  
> -	if (data[IFLA_GRE_COLLECT_METADATA]) {
> -		t->collect_md = true;
> -		if (dev->type == ARPHRD_IPGRE)
> -			dev->type = ARPHRD_NONE;
> -	}
> -
>  	if (data[IFLA_GRE_IGNORE_DF]) {
>  		if (nla_get_u8(data[IFLA_GRE_IGNORE_DF])
>  		  && (parms->iph.frag_off & htons(IP_DF)))
> @@ -1246,6 +1240,13 @@ static int ipgre_netlink_parms(struct net_device *dev,
>  		t->ignore_df = !!nla_get_u8(data[IFLA_GRE_IGNORE_DF]);
>  	}
>  
> +	/* All attributes have been validated, we can change @dev and @t. */
> +	if (data[IFLA_GRE_COLLECT_METADATA]) {
> +		t->collect_md = true;
> +		if (dev->type == ARPHRD_IPGRE)
> +			dev->type = ARPHRD_NONE;
> +	}
> +

[Severity: High]
The new comment states that the attributes have been validated so @dev and
@t may be changed, but the changelink path still has a fallible step after
the parser returns:

net/ipv4/ip_gre.c:ipgre_changelink() {
	...
	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
	if (err < 0)
		return err;

	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
	if (err < 0)
		return err;
	...
}

and ip_tunnel_changelink() has failure exits with no rollback:

net/ipv4/ip_tunnel.c:ip_tunnel_changelink() {
	if (dev == itn->fb_tunnel_dev)
		return -EINVAL;

	t = ip_tunnel_find(itn, p, dev->type);

	if (t) {
		if (t->dev != dev)
			return -EEXIST;
	} else {
		t = tunnel;

		if (dev->type != ARPHRD_ETHER) {
			unsigned int nflags = 0;
			...
			if ((dev->flags ^ nflags) &
			    (IFF_POINTOPOINT | IFF_BROADCAST))
				return -EINVAL;
		}
	}
	...
}

So does the exact symptom described in the changelog remain reachable?

"dev->type has already become ARPHRD_NONE, breaking the interface for good"

For example, "ip link set gre0 type gre external" on the per-netns fallback
device hits the "dev == itn->fb_tunnel_dev" return -EINVAL, yet the parser
has already set dev->type = ARPHRD_NONE and t->collect_md = true on gre0.
The fallback device is created by __ip_tunnel_create() with
dev->rtnl_link_ops = ipgre_link_ops, so ->changelink is dispatched to it.

The same window applies to an ordinary gre device: one created with
"remote 1.1.1.1" has IFF_POINTOPOINT set, so a request without
IFLA_GRE_REMOTE computes nflags == 0 and returns -EINVAL from the flag
mismatch check, again after collect_md/ARPHRD_NONE have been committed.

Note also that ip_tunnel_find(itn, p, dev->type) and the
"dev->type != ARPHRD_ETHER" test are evaluated against the dev->type the
parser just mutated, i.e. against state the request was never allowed to
commit.

Similarly, t->ignore_df is still committed in the hunk above while the
parms carrying the matching frag_off are discarded when
ip_tunnel_changelink() fails.

Would staging dev->type/collect_md/ignore_df in locals and applying them
only after ip_tunnel_changelink() succeeds (the way net/ipv6/ip6_gre.c
works on a local parm struct) close this, rather than moving the commit
point inside the parser?

>  	if (data[IFLA_GRE_FWMARK])
>  		*fwmark = nla_get_u32(data[IFLA_GRE_FWMARK]);
>  
> @@ -1259,40 +1260,51 @@ static int erspan_netlink_parms(struct net_device *dev,
>  				__u32 *fwmark)
>  {
>  	struct ip_tunnel *t = netdev_priv(dev);
> +	u8 erspan_ver = t->erspan_ver;
> +	u32 index = t->index;
> +	u16 hwid = t->hwid;
> +	u8 dir = t->dir;
>  	int err;

[ ... ]

> +	err = ipgre_netlink_parms(dev, data, tb, parms, fwmark);
> +	if (err)
> +		return err;
> +
> +	/* All attributes have been validated, we can change @t. */
> +	t->erspan_ver = erspan_ver;
> +	t->index = index;
> +	t->hwid = hwid;
> +	t->dir = dir;
> +
>  	return 0;
>  }

The staged ERSPAN values are stored into the live tunnel here, before
erspan_changelink() calls ip_tunnel_changelink():

net/ipv4/ip_gre.c:erspan_changelink() {
	...
	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
	if (err < 0)
		return err;

	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
	if (err < 0)
		return err;
	...
}

Can a request that is reported to user space as failed still change the
wire format emitted by erspan_xmit(), since erspan_ver, index, dir and hwid
are already in t when ip_tunnel_changelink() returns -EINVAL or -EEXIST?

One more note on the changelog:

"Only the parsers become all-or-nothing: ip_tunnel_encap_setup() still
runs before them, ip_tunnel_changelink() after them."

Given that ipgre_newlink_encap_setup() -> ip_tunnel_encap_setup() clears and
rewrites t->encap, t->encap_hlen and t->hlen before the parsers run, and
that ip_tunnel_changelink() can still fail afterwards, is "all-or-nothing"
accurate for the tunnel state as observed by user space?  A stable
backporter reading the changelog would likely conclude the ARPHRD_NONE
breakage is closed.

Checking the rest of the series, the later patches add header length
refreshes on the error paths but do not undo the dev->type, collect_md or
erspan_ver commits, so the state above appears to persist at the end of the
series as well.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912150944.3470971-1-edumazet%40google.com
