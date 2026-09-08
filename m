Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBE48E0F7;
	Tue,  8 Sep 2026 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895780; cv=none; b=bZNrrbt0U640WJkvV3oHfxYLyA8xFlQIP1AG78dy74wA2qJ/EYgoVpkOpGm9BIOi4ozVB7FBqIH0aM8MjPV6VjfyUMcI/5KzhMZ4oIaKTuUTAT2fnmdG2dGF53PzsKgh8c1TZ9kngkDAS8nNBgKWYJBJDNNmGE8NOS+LlMNN7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895780; c=relaxed/simple;
	bh=Al4J46lMgcYKTxQeB5MQKgTMGL+3T2Ip7asxa9z7qCM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hM7GxlUg0DbLG4LmrvYSt9FunkcAg1GAdzYlufMBy45c8nBZZvqHvnAEGTQVFRvWApTHh5dWC0JZqTzPzwAyqeVJ+YIUH6b/gN/IK5xGXw9lL+wiLNx6UuW83GnBmay+CQG2hyhBn9nVQYB6+7qkqR2/uC2S2I688CyC3kyqlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVLwbySD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVLwbySD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7DB1F00A3A;
	Tue,  8 Sep 2026 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895778;
	bh=nhNQk165hlg8Es1R+C7owvKNXbIdi3CC/Vc0LGXnoLg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jVLwbySD+xfWE88/9nAKcJy4QyLwRkwy821yv/jx8ptmPAZfcyW4iEaWr060enJL7
	 gnLWPjlOwgQ/VA8WkHx/WRrQcjaTz6GNnP0FsqfnmH6NSR8CLwTeIAXLalxD4BqcG3
	 euKH5G5ipZmlvY45C/vlW31UfFQGCqk3JHtSPG0+yL2qSNDfQFd85smW3MYz3iAgjj
	 eXdiYM0fDKuqjtgY4YjsTpofOZW96oeBecsBfae6XeLryt6+yXiUydFxyJk6vJIHxK
	 gYMCUaMt7rKbiKqEJ8UjD6nZ6cioR8vB5sDbixe+Fa69mczLVhmmDw4AQCHt9ScrEh
	 FhzzMB5BvgCxA==
Subject: Re: [PATCH net-next v4 5/7] netconsole: show empty string for an
 unset IP address
From: netdev-bot+sashiko@kernel.org
To: gustavold@gmail.com
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Tue, 08 Sep 2026 19:29:37 +0000
Message-ID: <178889577733.219967.15869187759329903017@kernel.org>
In-Reply-To: <20260903-netcons_ipv6-v4-5-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-5-bdd183c844d3@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] ABI show/store asymmetry for the configfs attributes local_ip
  and remote_ip: after this patch local_ip_show()/remote_ip_show() emit…
- [Low] The patch changes the on-read format of two documented configfs
  attributes (local_ip, remote_ip) from an always-parseable IPv4/IPv6…

--

netconsole: show empty string for an unset IP address

An unset local_ip/remote_ip is now denoted by AF_UNSPEC, and this patch
makes the configfs show handlers print an empty string instead of
"0.0.0.0" for that state. netconsole_print_banner() prints an explicit
"unset" message for the same case.

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index abcc8515ddd2b..1f18d0a7d2ddb 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c

[ ... ]

> @@ -863,6 +867,8 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
>  {
>  	struct netconsole_target *nt = to_target(item);
>  
> +	if (nt->local_ip.family == AF_UNSPEC)
> +		return sysfs_emit(buf, "\n");

[Severity: Medium]
Can the value that local_ip_show() now produces be written back into the
same attribute?

A freshly created target has family == AF_UNSPEC, so local_ip_show()
emits just "\n". Feeding that back through local_ip_store() reaches
netpoll_parse_ip_addr():

drivers/net/netconsole.c:netpoll_parse_ip_addr() {
	len = strlen(str);
	if (!len)
		return -1;

	if (str[len - 1] == '\n')
		len -= 1;

	if (in4_pton(str, len, (void *)&addr->ip, -1, &end) > 0 &&
	...
}

An input of "" fails the !len test, and "\n" is trimmed to len 0 so both
in4_pton() and in6_pton() fail. local_ip_store() then returns -EINVAL:

drivers/net/netconsole.c:local_ip_store() {
	...
	if (netpoll_parse_ip_addr(buf, &nt->local_ip) < 0)
		goto out_unlock;	/* ret == -EINVAL */
	...
}

Before this change the show side printed "0.0.0.0", which the store side
accepted, so "cat local_ip > local_ip" and generic save/restore of all
target attributes round-tripped.

Should netpoll_parse_ip_addr() (or the store handlers) gain an
empty-string branch that sets family = AF_UNSPEC?  As it stands there
seems to be no way to move an address back to the unset state through
the configfs ABI, and this remains true at the end of the series
(62342076a29c).

[Severity: Low]
Should Documentation/networking/netconsole.rst be updated along with
this?  The attribute table there still describes both attributes as
plain read-write IP addresses:

	local_ip	Source IP address to use		(read-write)
	remote_ip	Remote agent's IP address		(read-write)

and the example section still shows "cat cmdline0/remote_ip" producing an
address.  The later patch in the series, "docs: netconsole: document
local_ip auto-selection", describes the auto-derivation of an unset
local_ip, but it does not mention that reading an unset local_ip or
remote_ip now yields an empty value, nor that such a value cannot be
written back.

>  	if (nt->local_ip.family == AF_INET6)
>  		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
>  	else
> @@ -873,6 +879,8 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
>  {
>  	struct netconsole_target *nt = to_target(item);
>  
> +	if (nt->remote_ip.family == AF_UNSPEC)
> +		return sysfs_emit(buf, "\n");

[Severity: Medium]
Same question for remote_ip: remote_ip_store() -> netpoll_parse_ip_addr()
rejects the "\n" that remote_ip_show() emits, so
"cat remote_ip > remote_ip" returns -EINVAL on a target whose remote
address was never set.

>  	if (nt->remote_ip.family == AF_INET6)
>  		return sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
>  	else

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-netcons_ipv6-v4-0-bdd183c844d3%40gmail.com
