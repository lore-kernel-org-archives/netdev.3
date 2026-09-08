Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B935200F;
	Tue,  8 Sep 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895775; cv=none; b=VLXEFmvkGAw2Zdbjnf75/EV9AX/3Us7EOPVfXLtDiSbFaM43z/BEcDxVa9xNKoj+k0QHt21poBMSzDSUbk8kv9+jJoPLfQZa+cCakOtEqczEmGqo1g3zhB1+CquZzJttn8Z2NF00rOKKME6N1LV8HJeGAUsPfFGjfynEu8YH+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895775; c=relaxed/simple;
	bh=JCiL8hv602c8gYXfE5rDU/8AV6GBGRCzOLEWKj6IN00=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCOV9Ag0cc2pWTYS1eEnU90ZdlyADUJuYbRK4MCca0TwnaQCVUddYOOAt0CUC+sGWujNHTlVbZHBUUD2R2wN7s4oSqXzN6d+bWewGmaSjGGQZEfNQZwCQeqbnDBP2DBX7vp5neOeV8d6SMnS3Quo0IXsaokxqCsRDYxZHYkjtT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSWHNTrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSWHNTrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A761F00A3A;
	Tue,  8 Sep 2026 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895773;
	bh=y62mn4QRey0eAVVix/32nPGAi1SN0/sEwRuBHCqJf2w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TSWHNTrwJ0Dm/DRfzI3/JbrMJCRDK94Wa3A03f8Dk1dt4pv5tgLRmPv6KxeaPiRwS
	 VEgAbKw5dPYHSZu34llxkWorr0t28YxTNowUxWOjBLhHOq4mHmNGY4KG2BRqzwGllr
	 RzSzlDxupSOtuJqkJpm6E5UGq/5pXh/MpqpNEYfIwcmnWUMQtC2X4hHbQF/PxCD1AN
	 9UG7MwnHjromiivLpJWVwRs8YO6J/Rw6P954Yn32MATVMY0wfNzngd4uTxEgz2bC87
	 ByuEXyt2WgsfN6yKXSB5TEKbofeCzxlQ7NhPaL9sA5lzTVMHY8ugI1juGjNzw3Wj8t
	 7QYYUZtpzj9Rg==
Subject: Re: [PATCH net-next v4 1/7] netconsole: add an address family to
 struct inet_addr
From: netdev-bot+sashiko@kernel.org
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Tue, 08 Sep 2026 19:29:32 +0000
Message-ID: <178889577200.219967.3594830888243297249@kernel.org>
In-Reply-To: <20260903-netcons_ipv6-v4-1-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-1-bdd183c844d3@gmail.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 1

- [Low] Stale comment: the block comment above netcons_local_ip_unset()
  in drivers/net/netconsole.c still states "nt->local_ip is a union of…

Pre-existing issues:
- [Medium] netpoll_parse_ip_addr() (drivers/net/netconsole.c:751-773)
  commits address bytes into the caller's live struct inet_addr before…

--

netconsole: add an address family to struct inet_addr

Converts union inet_addr into a struct that carries a per-address family
field (AF_UNSPEC when unset, else AF_INET/AF_INET6) and sets that field in
the netconsole paths that populate local_ip/remote_ip. The %pI4 users are
updated to point at the union member instead of the containing object. No
reader of the new field is added yet.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index b358e5c367351..432b66cf111a5 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c

[ ... ]

> @@ -741,10 +743,10 @@ static void netconsole_print_banner(struct netconsole_target *nt)
>  	np_info(np, "remote ethernet address %pM\n", nt->remote_mac);
>  }
>  
> -/* Parse the string and populate the `inet_addr` union. Return 0 if IPv4 is
> +/* Parse the string and populate the `inet_addr` struct. Return 0 if IPv4 is
>   * populated, 1 if IPv6 is populated, and -1 upon failure.
>   */

[Severity: Low]
This comment was updated from "union" to "struct", but the block comment
above netcons_local_ip_unset() in the same file still describes the old
layout:

drivers/net/netconsole.c:
 * nt->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
 * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
 * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —

After this patch nt->local_ip is a struct whose address payload no longer
starts at offset 0, and it carries its own family discriminator. Should
that comment be refreshed too?

The reasoning about "first 4 bytes" is exactly the assumption this patch
had to fix at the three %pI4 sites (local_ip_show(), remote_ip_show() and
netcons_take_ipv4()), so leaving it in place is a little confusing.

For completeness: the netcons_local_ip_unset() helper and this comment are
removed by the following patch in the series ("netconsole: use the address
family instead of the ipv6 flag"), so the stale text does not survive the
series.

> -static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
> +static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
>  {
>  	const char *end = NULL;
>  	int len;
> @@ -756,14 +758,18 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
>  	if (str[len - 1] == '\n')
>  		len -= 1;
>  
> -	if (in4_pton(str, len, (void *)addr, -1, &end) > 0 &&
> -	    (!end || *end == 0 || *end == '\n'))
> +	if (in4_pton(str, len, (void *)&addr->ip, -1, &end) > 0 &&
> +	    (!end || *end == 0 || *end == '\n')) {
> +		addr->family = AF_INET;
>  		return 0;
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but can a rejected write leave
the target's address half-updated?

in4_pton() copies the parsed bytes into the destination before returning,
so the trailing-character check here runs after the store has already
happened:

net/core/utils.c:in4_pton() {
	...
	ret = 1;
	memcpy(dst, dbuf, sizeof(dbuf));
out:
	if (end)
		*end = s;
	return ret;
}

For input like "1.2.3.4x", in4_pton() returns > 0 and has written four
bytes into addr->ip, then (*end == 'x') fails the check, in6_pton() also
fails, and -1 is returned. The callers parse straight into the live target
and bail out without restoring the old value:

drivers/net/netconsole.c:remote_ip_store() {
	...
	ipv6 = netpoll_parse_ip_addr(buf, &nt->remote_ip);
	if (ipv6 == -1)
		goto out_unlock;
	nt->ipv6 = !!ipv6;
	...
}

local_ip_store() does the same for nt->local_ip. So a write that returns
-EINVAL to userspace can still change the configured address that
push_ipv4()/push_ipv6() and netcons_take_ipv6() later use.

Before this patch nt->ipv6 was the field left describing the previous
contents; with this patch addr->family is now also inconsistent with the
stored bytes on that path, even though the new field documents:

include/linux/netpoll.h:
	/* Address family: AF_UNSPEC when unset, else AF_INET or AF_INET6 */
	u8			family;

Would it be reasonable for netpoll_parse_ip_addr() to parse into a local
struct inet_addr and have the callers commit both the bytes and the family
only on success?

The behaviour is unchanged at the end of the series: netpoll_parse_ip_addr()
still writes into the caller's struct before validating, and
local_ip_store()/remote_ip_store() still return the error without restoring
the previous value.

>  
>  	if (IS_ENABLED(CONFIG_IPV6) &&
> -	    in6_pton(str, len, (void *)addr, -1, &end) > 0 &&
> -	    (!end || *end == 0 || *end == '\n'))
> +	    in6_pton(str, len, (void *)&addr->in6, -1, &end) > 0 &&
> +	    (!end || *end == 0 || *end == '\n')) {
> +		addr->family = AF_INET6;
>  		return 1;
> +	}
>  
>  	return -1;
>  }

[ ... ]

> diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
> index 1c6b1eec5efd6..de97f001a0f9c 100644
> --- a/include/linux/netpoll.h
> +++ b/include/linux/netpoll.h
> @@ -16,9 +16,13 @@
>  #include <linux/ip.h>
>  #include <linux/udp.h>
>  
> -union inet_addr {
> -	__be32		ip;
> -	struct in6_addr	in6;
> +struct inet_addr {
> +	/* Address family: AF_UNSPEC when unset, else AF_INET or AF_INET6 */
> +	u8			family;
> +	union {
> +		__be32		ip;
> +		struct in6_addr	in6;
> +	};
>  };

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-netcons_ipv6-v4-0-bdd183c844d3%40gmail.com
