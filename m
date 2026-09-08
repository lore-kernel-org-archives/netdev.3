Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E74434984;
	Tue,  8 Sep 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895776; cv=none; b=gZctVf17IaBb81ohk7EZyLmMnvPPejvGzmtqKh75ezDwfFAuA/OFh4HqyWfJuqJazR0iAXq4UMzNh0zTSSudvbO/Jf8PUwxLWRE2w6xpS9Ttj56cedW2TeaVBpUE4AZ/ggidi6ZfOQMyO4/7QSSfIEOhVIa4gwQnmJF4azIJ5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895776; c=relaxed/simple;
	bh=Z9NQWZL7x19norpNXapsS6fAwMGQpRh9xiQ3jT8vLnw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kd2UrZaADBF52BkLGLtm8KKDdsNKJGEThti2MQ/36jkjWR1d4EuiOZ6qtGl2O0IIBSkiv4BjZYYtUwIl/DEO6dWHHi34IfeMoRB/XYbamnRYc+ZFVihQAZUMoOIxIJgJJuW0TsoE7RHVdgYmJm0IfLoTewRUF/sgQfuUE+wgRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSX+G2Py; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSX+G2Py"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E492D1F00A3D;
	Tue,  8 Sep 2026 19:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895774;
	bh=7UC2Ou3QUXU9PuvAcNQ+NtSj92jvbJCOH7iW825oVuY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NSX+G2Py7w40j8Ca2eECU5oJiwuItS7Eo1/IKAerhG4CLKaAQDG+9V4mhVsO0z2Hn
	 IOxvFc068JJpBEpsWstrf6f9VrLoGFlrofLmkVYlyBK5OWnMP+BMFvUxPc+hSFG95g
	 YQnD8MwbrVy60N+JLZ8YZSZqAC+nY3TumXwpx+Jm+6U3Gc6Q/KpttygMJKsWjT3b+8
	 ZzseIhGZWBC1n+yC1yVzfIvTqtU1hXUAjzvV4CNgDVwWhdMupqYv0Yc5xpv8/p8CjT
	 IQLFJzcSGHEsIMMtsZlnc4mY0s7DJySaoZIsQaJFL1cupoSeaNyJdN64kJDaamW54i
	 mYJOPsvTa7XrQ==
Subject: Re: [PATCH net-next v4 2/7] netconsole: use the address family
 instead of the ipv6 flag
From: netdev-bot+sashiko@kernel.org
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Tue, 08 Sep 2026 19:29:33 +0000
Message-ID: <178889577349.219967.2663991034477119170@kernel.org>
In-Reply-To: <20260903-netcons_ipv6-v4-2-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-2-bdd183c844d3@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] netconsole: writing "0.0.0.0" (or "::") to local_ip no longer
  requests automatic source-address selection; the zero address is now…
- [Medium] At this commit a configfs target can be enabled with local_ip
  and remote_ip of different families, and the transmit path then reads…
- [Low] The readers converted by this patch treat the newly three-valued
  `family` field as two-valued: local_ip_show()…

--

netconsole: use the address family instead of the ipv6 flag

This drops the per-target nt->ipv6 boolean and derives IPv4 vs IPv6
behaviour from the family field stored in struct inet_addr instead.  The
netcons_local_ip_unset() helper is removed and the "local address not
configured" test becomes local_ip.family == AF_UNSPEC.  A few questions
about behaviour changes that come with this conversion follow.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 432b66cf111a5..351754d53cf97 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c

[ ... ]

> @@ -476,23 +474,6 @@ static int netcons_take_ipv4(struct netconsole_target *nt,
>  	return 0;
>  }
>  
> -/*
> - * Test whether the caller left nt->local_ip unset, so that
> - * netcons_netpoll_setup() should auto-populate it from the egress device.
> - *
> - * nt->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
> - * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
> - * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —
> - * doing so would misclassify a caller-supplied address as unset and
> - * silently overwrite it with whatever address the device exposes.
> - */
> -static bool netcons_local_ip_unset(const struct netconsole_target *nt)
> -{
> -	if (nt->ipv6)
> -		return ipv6_addr_any(&nt->local_ip.in6);
> -	return !nt->local_ip.ip;
> -}
> -
>  static int netcons_netpoll_setup(struct netconsole_target *nt)
>  {
>  	struct net *net = current->nsproxy->net_ns;
> @@ -538,16 +519,13 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
>  		rtnl_lock();
>  	}
>  
> -	if (netcons_local_ip_unset(nt)) {
> -		if (!nt->ipv6) {
> -			err = netcons_take_ipv4(nt, ndev);
> -			if (err)
> -				goto put;
> -		} else {
> +	if (nt->local_ip.family == AF_UNSPEC) {
> +		if (nt->remote_ip.family == AF_INET6)
>  			err = netcons_take_ipv6(nt, ndev);
> -			if (err)
> -				goto put;
> -		}
> +		else
> +			err = netcons_take_ipv4(nt, ndev);
> +		if (err)
> +			goto put;
>  		ip_overwritten = true;
>  	}

[Severity: Medium]

Is the replacement of netcons_local_ip_unset() with the AF_UNSPEC test
intended to also change the user-visible meaning of an all-zero local
address?

Before this patch the auto-populate test was purely value based
(!nt->local_ip.ip for IPv4, ipv6_addr_any() for IPv6), which matches the
long-standing netpoll behaviour where a zero local address requests
selection from the egress device.  After this patch the only way to reach
netcons_take_ipv4()/netcons_take_ipv6() is family == AF_UNSPEC, but
netpoll_parse_ip_addr() stamps a concrete family on every successful
parse, including "0.0.0.0" and "::":

	if (in4_pton(str, len, (void *)&addr->ip, -1, &end) > 0 &&
	    (!end || *end == 0 || *end == '\n')) {
		addr->family = AF_INET;
		return 0;
	}

So writing "0.0.0.0" to local_ip, or booting with
netconsole=@0.0.0.0/eth0,6666@a.b.c.d/, now enables the target without
error and every frame is built with a zero source address in push_ipv4()
and in the UDP pseudo-header, which the receiver or reverse path
filtering will drop, silently losing console output.

Related to that: the only remaining writer of AF_UNSPEC is the failure
path in netcons_netpoll_setup():

	if (ip_overwritten)
		memset(&nt->local_ip, 0, sizeof(nt->local_ip));

Once local_ip has been written once from configfs, is there any way for
userspace to get back to the auto-selection state?

The commit message says:

    We no longer need netcons_local_ip_unset() to check that all bytes are
    zeroes, as that is now denoted by (family == AF_UNSPEC).

Could this be reworded to state that the zeros-means-unset input is no
longer accepted, rather than presenting the two tests as equivalent?  A
later patch in the series ("docs: netconsole: document local_ip
auto-selection") documents the new behaviour, but the behaviour change
itself is not mentioned here.

> @@ -729,22 +707,22 @@ static void netconsole_print_banner(struct netconsole_target *nt)
>  	struct netpoll *np = &nt->np;
>  
>  	np_info(np, "local port %d\n", nt->local_port);
> -	if (nt->ipv6)
> +	if (nt->local_ip.family == AF_INET6)
>  		np_info(np, "local IPv6 address %pI6c\n", &nt->local_ip.in6);
>  	else
>  		np_info(np, "local IPv4 address %pI4\n", &nt->local_ip.ip);
>  	np_info(np, "interface name '%s'\n", np->dev_name);
>  	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
>  	np_info(np, "remote port %d\n", nt->remote_port);
> -	if (nt->ipv6)
> +	if (nt->remote_ip.family == AF_INET6)
>  		np_info(np, "remote IPv6 address %pI6c\n", &nt->remote_ip.in6);
>  	else
>  		np_info(np, "remote IPv4 address %pI4\n", &nt->remote_ip.ip);
>  	np_info(np, "remote ethernet address %pM\n", nt->remote_mac);
>  }
>  
> -/* Parse the string and populate the `inet_addr` struct. Return 0 if IPv4 is
> - * populated, 1 if IPv6 is populated, and -1 upon failure.
> +/* Parse the string and populate the `inet_addr` struct. Return 0 on success
> + * and -1 upon failure.
>   */
>  static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
>  {

[ ... ]

> @@ -874,7 +852,7 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
>  {
>  	struct netconsole_target *nt = to_target(item);
>  
> -	if (nt->ipv6)
> +	if (nt->local_ip.family == AF_INET6)
>  		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
>  	else
>  		return sysfs_emit(buf, "%pI4\n", &nt->local_ip.ip);
> @@ -884,7 +862,7 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
>  {
>  	struct netconsole_target *nt = to_target(item);
>  
> -	if (nt->ipv6)
> +	if (nt->remote_ip.family == AF_INET6)
>  		return sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
>  	else
>  		return sysfs_emit(buf, "%pI4\n", &nt->remote_ip.ip);

[Severity: Low]

The family field now has three states, per the comment on struct
inet_addr:

	/* Address family: AF_UNSPEC when unset, else AF_INET or AF_INET6 */
	u8			family;

but local_ip_show(), remote_ip_show() and netconsole_print_banner() all
use a two-way test, so AF_UNSPEC falls into the IPv4 else-branch.  Should
an unset address print as 0.0.0.0?

For a target with an IPv6 remote_ip and no local_ip written, cat local_ip
returns "0.0.0.0" while cat remote_ip returns an IPv6 literal, and before
this patch the same target had nt->ipv6 set so local_ip read back as
"::".  The 0.0.0.0 result is also indistinguishable from a deliberately
configured zero address, so a save-and-restore of the configuration turns
an auto-select target into a literal zero source address.

This is handled later in the series by "netconsole: show empty string for
an unset IP address", which adds an AF_UNSPEC case to both show handlers
and "local IP unset"/"remote IP unset" to the banner, so it only affects
the intermediate tree state.

[ ... ]

> @@ -1257,7 +1232,6 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
>  {
>  	struct netconsole_target *nt = to_target(item);
>  	ssize_t ret = -EINVAL;
> -	int ipv6;
>  
>  	dynamic_netconsole_mutex_lock();
>  	if (nt->state == STATE_ENABLED) {
> @@ -1266,10 +1240,8 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
>  		goto out_unlock;
>  	}
>  
> -	ipv6 = netpoll_parse_ip_addr(buf, &nt->remote_ip);
> -	if (ipv6 == -1)
> +	if (netpoll_parse_ip_addr(buf, &nt->remote_ip) < 0)
>  		goto out_unlock;
> -	nt->ipv6 = !!ipv6;
>  
>  	ret = count;
>  out_unlock:

[Severity: Medium]

With the shared nt->ipv6 flag gone, local_ip_store() and remote_ip_store()
each set only their own address's family, and nothing couples them.  What
keeps a configfs target from being enabled with local_ip as IPv4 and
remote_ip as IPv6?

netcons_netpoll_setup() at this commit only has the AF_UNSPEC
auto-populate branch, no family agreement check, so such a target reaches
STATE_ENABLED.  The transmit path then keys everything off remote_ip
while reading the local_ip union through the IPv6 arm:

drivers/net/netconsole.c:push_ipv6() {
	...
	ip6h->saddr = nt->local_ip.in6;
	ip6h->daddr = nt->remote_ip.in6;
	...
}

Only 4 bytes were written into that union by local_ip_store(), so the
emitted IPv6 source address is the IPv4 value followed by 12 bytes of
whatever the union previously held (zeros, or bytes of an earlier IPv6
address).  netpoll_udp_checksum() below feeds the same mismatched arm to
csum_ipv6_magic().

> @@ -2078,7 +2050,7 @@ static void netpoll_udp_checksum(struct netconsole_target *nt,
>  
>  	/* check needs to be set, since it will be consumed in csum_partial */
>  	udph->check = 0;
> -	if (nt->ipv6)
> +	if (nt->remote_ip.family == AF_INET6)
>  		udph->check = csum_ipv6_magic(&nt->local_ip.in6,
>  					      &nt->remote_ip.in6,
>  					      udp_len, IPPROTO_UDP,

[ ... ]

> @@ -2601,13 +2567,11 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
>  	if (!delim)
>  		goto parse_failed;
>  	*delim = 0;
> -	ipv6 = netpoll_parse_ip_addr(cur, &nt->remote_ip);
> -	if (ipv6 < 0)
> +	if (netpoll_parse_ip_addr(cur, &nt->remote_ip) < 0)
>  		goto parse_failed;
> -	else if (ipversion_set && nt->ipv6 != (bool)ipv6)
> +	if (nt->local_ip.family != AF_UNSPEC &&
> +	    nt->local_ip.family != nt->remote_ip.family)
>  		goto parse_failed;
> -	else
> -		nt->ipv6 = (bool)ipv6;
>  	cur = delim + 1;

The family agreement invariant that the transmit code depends on is
enforced here for cmdline targets, but not for configfs targets at this
commit.  Would it be worth folding the equivalent check into
netcons_netpoll_setup() in the same patch that removes nt->ipv6?  A
following patch in the series ("netconsole: reject a target mixing IPv4
and IPv6 addresses") does add it, so the window is limited to this
intermediate state.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-netcons_ipv6-v4-0-bdd183c844d3%40gmail.com
