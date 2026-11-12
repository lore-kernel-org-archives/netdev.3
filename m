Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461232;
	b=vktb01MlOvYRy9TLATbJQJ7hY0N67ZGABkEmE4mehUGIIRK4Hxo1fpQPurENIAf0Fq7Y
	 FJwa+l9Qnazpb48WnSxIla9GsvO9s5iAzUoqWpgIkbE26604Eu5+nWlKrRup1VTaB54vO
	 gV03CP85tcpqIwbuX17qpiQhSWJCs4JOsNTH2SX3Zeh+J7QlaoA34NsQGX4pucQis21Jo
	 rQ8pqjs2Vyp6XTjudGLG6GAHnruMCJcTGMZ1pApP/RbXUf7EHO4ciptP/bfyd+HcDYUL8
	 UX8nsNoi4FI1kwGHtGsgMSGuORRQDvKFYm1TD3KYS9Cxuw+Snqla98KR8BFchFskfZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461232;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xkOeEYLMMpH6ZuvHY2cCndyYzwqV1/KwZKAH3DOhFYE=;
	b=kWUTOtYLKAqjMiG27HynWdULtk3qyQlKwr0o6ye4joL/MayaLmikfRSFT9lR6JG2AeqP
	 IqcT7alrpEoa7zbEaD+CqCeZqmBDiImvtkqJkjTYqaAIzjQOFmcq9cQBRkO5HddMQrbAx
	 uaPZgre/8XVLCghadBXN0bswc/+vNO1kpFwgQ86WmRDyvBAqi/OcIMEkhic74cq8f4tcP
	 gnK2L2bGT7NlpVhQL7jw96o3btjoEj49vLG9zQNkI9JnHjmLqrKanrg4dbdRrij7292MO
	 83Qt0PLgmf5Go42F1386RFPpo+x4yUG0Qu+Rjfutine+UNdUJjGbxGRLa4CJEjk4ALA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuB2d8WO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2D60A260D;
	Thu, 12 Nov 2026 05:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuB2d8WO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE8A1F00A05;
	Thu, 12 Nov 2026 05:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461232;
	bh=xkOeEYLMMpH6ZuvHY2cCndyYzwqV1/KwZKAH3DOhFYE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iuB2d8WOI0N8Fq+hjVepL9cx7wMHw9XvKrqcKN5UWpv2hs+5M/QL1i6HvRnu03MIt
	 fF1UOQL4VZ7radJZzgsGR2tUKmkIo3MTn2YHs+sR/y5eJ+YXJQ7wX59A0LaMDGGhM8
	 8tyDn/CpIJZkuDLKjBNCsSr2hgbnoD/RZtu4qz0B8hYoWkTxtRhp4EjF1NgldNvUCI
	 DikFRuxCsX2A+d0sBhSAbsyyMl/3v4XTpiPlRGO+KLtW6+LghS5XQZWe7SFoz6HIU1
	 KVDEFe4U9SXzPxnlu2oJFZ9EwZtfn7ItaOPZRxwT1zmVcyYMJhGSBIfBC/G6FWBGl/
	 99KA8L2uXOJAA==
Subject: Re: [PATCH net v2 3/3] selftests: net: netlink-dumps: test dump of
 route larger than skb
From: netdev-bot+sashiko@kernel.org
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, idosch@nvidia.com, sd@queasysnail.net,
 sdf.kernel@gmail.com, parri.andrea@gmail.com, nickgarlis@gmail.com,
 willemb@google.com, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 05:27:10 +0000
Message-ID: <179446123083.2199510.12420205782226383855@kernel.org>
In-Reply-To: <20261110172925.3293312-4-stephen@networkplumber.org>
References: <20261110172925.3293312-4-stephen@networkplumber.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] dump_large_route() adds an IPv4 multipath route with
  BIG_RT4_NH = 1500 gateway-less nexthops.
- [Low] In tools/testing/selftests/net/netlink-dumps.c, nl_request_ack()
  cannot decode an error ACK for either of the two large RTM_NEWROUTE…
- [Low] The comment in dump_large_route() before close(netlink_sock) says
  "The ACK reads above used large buffers, which raise the dump skb size…

--

selftests: net: netlink-dumps: test dump of route larger than skb

This commit adds a dump_large_route test. The test installs IPv4 and
IPv6 multipath routes that are too large for the first dump skb of a
fresh socket. It then checks that the dump either returns the route or
fails with -EMSGSIZE.

The commit also creates a dummy device for the IPv6 nexthops,
generalizes lo_set_up() to if_set_up(), and adds the IPv4 routing
options to the config.

> diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
> index 4a94a25167e25..43f63f3f22895 100644
> --- a/tools/testing/selftests/net/netlink-dumps.c
> +++ b/tools/testing/selftests/net/netlink-dumps.c

[ ... ]

> @@ -362,4 +362,267 @@ TEST(dump_with_queued_ntf)

[ ... ]

> +static int nl_request_ack(int sock, const void *req, size_t len)
> +{
> +	struct nlmsghdr *nlh;
> +	char buf[4096];
> +	ssize_t n;
> +
> +	if (send(sock, req, len, 0) != (ssize_t)len)
> +		return -errno;
> +	n = recv(sock, buf, sizeof(buf), 0);
> +	if (n < 0)
> +		return -errno;
> +	nlh = (struct nlmsghdr *)buf;
> +	if (!NLMSG_OK(nlh, n) || nlh->nlmsg_type != NLMSG_ERROR)
> +		return -EPROTO;

[Severity: Low]
Can nl_request_ack() report the real errno when the kernel rejects one
of the large RTM_NEWROUTE requests?

On error, netlink_ack() copies the whole original request into the
reply unless NETLINK_CAP_ACK is set, and this test never sets it:

net/netlink/af_netlink.c:netlink_ack() {
    ...
	if (err && !test_bit(NETLINK_F_CAP_ACK, &nlk->flags))
		payload += nlmsg_len(nlh);
    ...
}

new_route4 is 48 + 1500 * 8 = 12048 bytes and new_route6 is
60 + 500 * 28 = 14060 bytes, so neither error ACK fits in buf[4096].
recv() truncates the datagram and returns 4096. NLMSG_OK() then fails
because nlmsg_len > n, and the helper returns -EPROTO without reading
the errno at NLMSG_DATA(nlh).

The ASSERT_EQ() calls in dump_large_route() still fail when they
should. But every route-add failure (-ENOBUFS, -EINVAL, -ENETUNREACH,
and so on) gets printed as -71.

Would setting NETLINK_CAP_ACK on the socket fix this? Another option is
to read with MSG_PEEK | MSG_TRUNC into a buffer big enough for the
copied request.

> +	return *(int *)NLMSG_DATA(nlh);
> +}

[ ... ]

> +TEST(dump_large_route)
> +{
> +	int netlink_sock, inet_sock, i, ret, routes;

[ ... ]

> +	for (i = 0; i < BIG_RT4_NH; i++) {
> +		new_route4.nh[i].rtnh_len = sizeof(new_route4.nh[i]);
> +		new_route4.nh[i].rtnh_ifindex = 1; // lo
> +	}
> +	ASSERT_EQ(nl_request_ack(netlink_sock, &new_route4,
> +				 sizeof(new_route4)), 0);

[Severity: Medium]
Could this route add fail spuriously on a machine with fragmented
memory?

With BIG_RT4_NH = 1500, fib_create_info() allocates the fib_info and
all 1500 fib_nh entries as one contiguous block:

net/ipv4/fib_semantics.c:fib_create_info() {
    ...
	fi = kzalloc_flex(*fi, fib_nh, nhs);
    ...
}

kzalloc_flex() expands to plain kzalloc(), not kvzalloc(). struct
fib_nh is about 112-120 bytes on 64-bit, so the request is about
170-180 KB. That is an order-6 allocation on 4K-page kernels.

If that allocation fails, fib_create_info() returns -ENOBUFS. Because
__GFP_NOWARN is not set, the kernel also logs a page allocation failure
warning in dmesg. The test then fails for reasons unrelated to the dump
behaviour it checks.

The count is this high only because each gateway-less IPv4 nexthop adds
just 8 bytes to the dumped route. Could each IPv4 nexthop get an
RTA_GATEWAY, as the IPv6 nexthops do? That would reach the same dump
size with far fewer kernel-side fib_nh entries.

[ ... ]

> +	ASSERT_EQ(nl_request_ack(netlink_sock, &new_route6,
> +				 sizeof(new_route6)), 0);
> +
> +	// The ACK reads above used large buffers, which raise the dump
> +	// skb size for this socket. Dump on fresh sockets instead.
> +	close(netlink_sock);

[Severity: Low]
Is this comment accurate? The ACK reads in nl_request_ack() use a
4096-byte buffer, so max_recvmsg_len for this socket only reaches 4096.

netlink_dump() uses max_recvmsg_len only when it exceeds
alloc_min_size:

net/netlink/af_netlink.c:netlink_dump() {
    ...
	alloc_min_size = max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);

	max_recvmsg_len = READ_ONCE(nlk->max_recvmsg_len);
	if (alloc_min_size < max_recvmsg_len) {
    ...
}

On 4K-page kernels NLMSG_GOODSIZE is SKB_WITH_OVERHEAD(4096), so the
dump skb grows by only a few hundred bytes. With 8K or larger pages,
nothing changes. Either way, the 12 KB and 14 KB routes would still not
fit in the first dump skb if this socket were reused.

Opening fresh sockets is fine, but could the comment be reworded? The
buffer that actually raises later dump skb sizes is the 32 KB one in
dump_big_table().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110172925.3293312-1-stephen%40networkplumber.org
