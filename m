Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199896;
	b=Xd0TrtplllJlmoJ3kKcLATDsZWGzoi7Yn6LOxqTyfWjmyy/8zQM3nwKjOa/86vvmtBFY
	 PkuqcZu8WL8dB+yAcRo3RIkSyaSk+qqxnJzBAFDhu1Cxbrl+/U9LHSFOKilunm3vv5HNV
	 9Zy9GM5a5BfmNc7RjW5o6g7Xvlk3qzviCdCK4pJy9o7Ut1ZVa6q9WbXaCz18hXePsmtwv
	 Qd/EPa6SkoLmjFeWy5Z35AqP8V+VPso1WrJCp1AKL5k2l4Jc2ZeANl//yvOwqAbRK+4v2
	 /vZOmgfeNC39cWWYz43v3D2LgHG8KCOSF6RV3B0WzGWEsKx2zTS+qTo3NJmBKIZGiqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199896;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=z62OfWpJCIMFh0MJOTCFqnkCgOEtVmX/+I0r+KURVhI=;
	b=JfFssobf67PXqs9ToDbF2ZKZ8z3luJFz1PA+lSNX5Mx9tt7ObatK4xVuR66vFaCxjV27
	 5ExWyLkEhhHdGdNV4uaeiqyowDZwvkrLDrfJ/4pzAzCDm4oRKpRIN9BcKS9lQAu8fsK78
	 m6m63ZnwD6hmL6h4/4Ihz2WEzOAztjecU3RZxbR0nVmfHVLM+0qb2/R9ZiYzBujDTn9cx
	 Sk/WO8EShdhIL5KZ+ZYBk1T/o+84uAvizyChSKd9kwMAbpoYGcqo7FwJjv6/NN9Z3IMXl
	 o8DeGcviSH2W3ZbuJhbMOi6cbsfRx+ucFCjwVSwiga6o8uo1lc48kZaHuIC6wZ8P5MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5US4viD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E585F606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J5US4viD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DE01F0089F;
	Mon,  9 Nov 2026 04:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794199895;
	bh=z62OfWpJCIMFh0MJOTCFqnkCgOEtVmX/+I0r+KURVhI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J5US4viDe9wYhM1Ay6gG2K/MQumgoruX6tvHvNDsKgI07O7/JKktPtLHoWlAka1gj
	 RaoQDvRCGhCiNkfhbHrCvUjygAWXnJaMrmeWTOc5e+hK2QyD4+tF4ifn5h6XVjcTDE
	 MZxGydo/PEDGv5O0jmcjk2cXlgm8ZXpqiNvPtlgN29Z86YpM3qKmnHSiXX3ij1o0rq
	 4SPvC3lbuzRbE6D1K8UPX7uX6sPaYINE3KIXvakary63a/iFQMkmJvM8L3xbbGIbYI
	 GdwZ6UoG64jhDD7LqIJdSYzJQrv+6RaBt3EnkkzmbFBXjHFeCVFBpTAob6VBDZm922
	 MxKWyVZQIW8Ew==
Subject: Re: [PATCH net] tcp: do not resurrect a former listener with
 SO_ATTACH_REUSEPORT_[CE]BPF
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 kylebot@openai.com
Date: Mon, 09 Nov 2026 04:51:34 +0000
Message-ID: <179419989441.994134.10967877917982374376@kernel.org>
In-Reply-To: <20261105164830.1682714-1-edumazet@kernel.org>
References: <20261105164830.1682714-1-edumazet@kernel.org>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check in reuseport_attach_prog()
  (net/core/sock_reuseport.c) decides the socket is an…

--

tcp: do not resurrect a former listener with SO_ATTACH_REUSEPORT_[CE]BPF

This patch makes reuseport_attach_prog() return -EINVAL when it is called
on an unhashed TCP socket whose unhashed_state is TCP_LISTEN. Without this,
a socket that was shutdown() after listen() could be put back into the
listening section of a new reuseport group. reuseport_migrate_sock() could
then pick that dead socket, which leads to a use-after-free in
espintcp_destruct().

> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index fccbdd0430b05..41a25be1bfff6 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c

[ ... ]

> @@ -692,6 +693,14 @@ int reuseport_attach_prog(struct sock *sk, struct bpf_prog *prog)
>  		if (!sk->sk_reuseport)
>  			return -EINVAL;
>  
> +		/* Do not put a shutdown()ed TCP listener back into the
> +		 * listening section of a reuseport group while it is in
> +		 * TCP_CLOSE: requests can still migrate to it.
> +		 */
> +		if (sk->sk_protocol == IPPROTO_TCP &&
> +		    inet_csk(sk)->unhashed_state == TCP_LISTEN)
> +			return -EINVAL;

[Severity: High]
Can a raw socket reach this check with sk_protocol == IPPROTO_TCP? For
socket(AF_INET, SOCK_RAW, IPPROTO_TCP), inet_create() does:

    if (SOCK_RAW == sock->type) {
        inet->inet_num = protocol;
    ...
    sk->sk_protocol = protocol;

In that case the object is a struct raw_sock (or raw6_sock for AF_INET6),
not an inet_connection_sock.

As far as I can tell, this path gets there from userspace:

  socket(AF_INET or AF_INET6, SOCK_RAW, IPPROTO_TCP)
    raw_hash_sk() hashes it, since inet_num is 6
  connect(AF_UNSPEC)
    inet_dgram_connect()->__udp_disconnect()->sk->sk_prot->unhash()
    (raw_unhash_sk()), so sk_unhashed() is now true
  setsockopt(SO_REUSEPORT, 1)
    only sk_is_inet() is checked
  setsockopt(SO_ATTACH_REUSEPORT_CBPF), or SO_ATTACH_REUSEPORT_EBPF with a
  BPF_PROG_TYPE_SOCKET_FILTER program
    sk_reuseport_attach_filter()->reuseport_attach_prog()

Neither attach path checks sk_type before it calls reuseport_attach_prog().
Only the SK_REUSEPORT program type does.

In inet_connection_sock, unhashed_state comes after icsk_accept_queue, two
bind bucket pointers, two timer_lists and five u32s. struct raw_sock only
adds icmp_filter, ipmr_table and numa_drop_counters on top of inet_sock.

On !SMP builds, or with lockdep or debug spinlock configs that make
spinlock_t and timer_list larger, does this become a slab-out-of-bounds
read past the raw_sock object? On other configs the read lands in padding
or in the drop counters, which may be uninitialized.

For raw6_sock it reads an unrelated byte inside ipv6_pinfo. If that byte
happens to equal TCP_LISTEN, the attach fails with -EINVAL.

The only privilege needed is CAP_NET_RAW in the netns user namespace, which
an unprivileged user can get with unshare(CLONE_NEWUSER | CLONE_NEWNET).

Would the existing sk_is_tcp() helper in include/net/sock.h work better
here than the bare sk_protocol test?

    return sk_is_inet(sk) &&
           sk->sk_type == SOCK_STREAM &&
           sk->sk_protocol == IPPROTO_TCP;

> +
>  		err = reuseport_alloc(sk, false);
>  		if (err)
>  			return err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105164830.1682714-1-edumazet%40kernel.org
