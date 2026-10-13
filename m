Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC99412C0D;
	Tue, 13 Oct 2026 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899550; cv=none; b=fZtBssLttPUeDgiPTHkTcfrZfppjbWevyKYSeMJmh37DkWBd67dE5k3GyLPrPYtkHQqp/gSspOl1QMQwEVyNCDecgXbwV0+mvgNB8c8I8+UPvyax5k4+2+/olxrwkborjk+eRu+p7Q8ZmbxlWQTjPNFk5m1buC5aJtHxO/FHMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899550; c=relaxed/simple;
	bh=2DSSLAym5jaQ/eRYFvmsOr6wNQLeWGdPMCC3vOzXjvM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J18w/0IGU2CmAIsRJ+emQRg6mO3g0PeG0xSluZhiIBtLIyikdQCNYXoYt/xhgKupayUCzYKNziFD4xmJJruk6vWZAcHS0zQSesHc3KPG+nMAfJztWGa2+Q9CLOCuH1O75C8m2Wv+2svH/rMrYxQ5vjkupUFSHN1gYEjmW9naWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW5QFqvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW5QFqvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E595C1F000FF;
	Tue, 13 Oct 2026 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899549;
	bh=carq4ztoeIkZ78Y5Ef+QmjAypJ2FfIu92cH1tAmmy8w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NW5QFqvLT2dE6l0Wk/kiM+h2MdYYL2dk7YfrJyPWPLcKEAZlM+IgbW8eaBylbL5T3
	 pIBvw/crXtodQXv/5zLQZEhZQXXbQf0q0/DKkK0L/hsxhqvbh9LibUm0nYvy+2kkTz
	 ouV6o7RRhbJu2IOYzQBpVxii2IWaAjJ/aE7QF+WSAJtKj8lXhwJvwWI8zy/yQTLrtn
	 X6PRsTA6P47fkdxo3qDq6e1m/kk4moPsyIMqgN1IYaCCKmgFYHmBQWaL2W4JetILDd
	 M3KtrpUrn+nrrQqGc9a6YKemoP6jKixuHfXABcSSbUFyR3CJsFNHl2CSolr0i4ZnVm
	 /WTFEWCb+0fCg==
Subject: Re: [PATCH net-next v3 2/2] selftests/net/packetdrill: cover
 SO_RCVBUF vs the route window clamp
From: netdev-bot+sashiko@kernel.org
To: jain.sm@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 13:52:28 +0000
Message-ID: <179189954849.434549.2045283674698122143@kernel.org>
In-Reply-To: <20261012132622.48550-3-jain.sm@gmail.com>
References: <20261012132622.48550-3-jain.sm@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new tests only cover the active-open side.
- [Low] Two of the new scripts use raw socket option numbers instead of
  their names.

--

selftests/net/packetdrill: cover SO_RCVBUF vs the route window clamp

This adds three packetdrill scripts. They check the window and window scale
sent on an active-open SYN when SO_RCVBUF, TCP_WINDOW_CLAMP and the route
RTAX_WINDOW metric interact. One script covers the deferred SYN that
TCP_FASTOPEN_CONNECT sends.

> diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_connect_rcvbuf_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_connect_rcvbuf_window.pkt
> new file mode 100644
> index 0000000000000..7892ac566e189
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_connect_rcvbuf_window.pkt
> @@ -0,0 +1,22 @@

[ ... ]

> +// optname 30 = TCP_FASTOPEN_CONNECT, 34 = TCP_FASTOPEN_NO_COOKIE on SOL_TCP.

[ ... ]

> +    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> +   +0 setsockopt(3, SOL_TCP, 30, [1], 4) = 0
> +   +0 setsockopt(3, SOL_TCP, 34, [1], 4) = 0

[Severity: Low]
This isn't a bug, but could these lines use the symbolic names instead of
the raw optnames 30 and 34?

tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt in the same directory
already does this:

    +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN_CONNECT, [1], 4) = 0

So the packetdrill these selftests run against knows at least that name.

The raw 10 in tcp_window_clamp_vs_rcvbuf.pkt has this comment:

    // TCP_WINDOW_CLAMP is optname 10 on SOL_TCP (this packetdrill build has no
    // symbol for it).

That comment describes a local packetdrill build, not something the
upstream selftest depends on. If the packetdrill used here really has no
TCP_WINDOW_CLAMP symbol, could the comment say that without referring to a
particular build?

The numeric values themselves are correct.

> +   +0 connect(3, ..., ...) = 0

[ ... ]

> diff --git a/tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf.pkt b/tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf.pkt
> new file mode 100644
> index 0000000000000..3d73178df6433
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf.pkt
> @@ -0,0 +1,24 @@

[ ... ]

> +    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> +   +0 setsockopt(3, SOL_TCP, 10, [16384], 4) = 0
> +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1048576], 4) = 0
> +   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> +   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)

[Severity: Low]
All three new scripts call connect() and check only the outgoing SYN. Is
the passive side of the fix tested anywhere?

The fix earlier in this series ("tcp: keep the route window metric when
SO_RCVBUF is set before connect") also changes tcp_openreq_init_rwin() in
net/ipv4/tcp_minisocks.c. That function now picks the clamp based on the
listener's user-clamp bit:

    req->rsk_window_clamp = tp->window_clamp_user ? window_clamp :
                            dst_metric(dst, RTAX_WINDOW);

The fix's commit message says the change applies "on a listener" and to
the "SYN / SYN-ACK". It also says "a passive socket inherits the decision
from its listener".

No script in tools/testing/selftests/net/packetdrill/ sets up a listener
behind a route with a window metric and then checks the SYN-ACK.

Would it make sense to add listener versions of two cases: SO_RCVBUF
alone, and TCP_WINDOW_CLAMP followed by SO_RCVBUF?

The new reset rules also look untested. In do_tcp_setsockopt(),
TCP_WINDOW_CLAMP=0 now clears the bit:

    tp->window_clamp_user = !!val;

tcp_disconnect() clears it as well.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012132622.48550-1-jain.sm%40gmail.com
