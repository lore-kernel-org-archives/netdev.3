Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0057312836
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 04:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754766; cv=none; b=NmJ+CUfbeQRRrimDLbSTedGQqBobnEXJZkScKRu/ZUwwJGaaiga4M9olFl91BXC7zV8B3QHDBWnipkRIsjUFyWf8OfGlZQ5RtVPXg+U3wu3ekEkFE4A17YHZhFwlGui0C6/VSgJeWy8/SJ1+QPsVaMzo3azfWUh5VA/r1jHHaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754766; c=relaxed/simple;
	bh=YRgwvzJWGCCglANQM5aFYRrE3/4HHR658UVWqvBi5gk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O791AEkCDGb0pfMydhMwuw4pF3WK5a+hPmvvWMjexKqMe7zGVmt9pmAmNRampGAYYE9knehIVxtCRfDN1XJPn6fgMaIm/X6veQPX7ncHf+LmJP1RVVdpPa6GvMWf0wlfCruapmVZmMrVjTriVookGn4JQfm60bGIyIYOJEqIz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEtws9Uq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEtws9Uq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896171F00A3D;
	Mon,  7 Sep 2026 04:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788754764;
	bh=PM8KDiq7gMLfewDUvb/Gn5L7BZS9jNJUEBGp/1pGHU8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lEtws9UqY20LU6gx7e+/TgT8LoyHau2yawVlXt0/W/fCYQCC3cjZ4+J+EJ48e2Axc
	 k2PM+gyYgghhax7qU2LQljvn6YEsDpZFyOKOo3UfgwDMRdB3PubNPKvF1Fc3Q2QHcf
	 eC9VDJzO7vUZc8/3448dZv2/Zprws80MwxPswB7h7MZ+Z90qtqKZ1uyCmdL8/RwCaX
	 rq+2mJNJiPg45Aasl0h+pY2FI7cZ/ysU9xjhPr9qaxYQfMe+5zAQd+fPAmHFIXL7RS
	 EvcHrpuhCH7j7OUk2ZrL/0+zlTVDwpBb8oyZZigJALyR9GKtUtQQlFm4DLkWfl6876
	 ES8IfpAUfb7VQ==
Subject: Re: [PATCH v1 net-next 2/2] ipv6: Remove IPV6_ADDRFORM.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, willemb@google.com,
 dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, 4ncienth@gmail.com, imv4bel@gmail.com
Date: Mon, 07 Sep 2026 04:19:23 +0000
Message-ID: <178875476308.219967.13148368199022522829@kernel.org>
In-Reply-To: <20260904033543.2635540-3-kuniyu@google.com>
References: <20260904033543.2635540-3-kuniyu@google.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 2

- [High] Verified userspace-visible ABI removal with no deprecation path
  and no disclosure of the resulting errno.
- [Low] The removal is incomplete: the patch cleans up the ADDRFORM
  comments in net/core/sock.c, net/ipv4/af_inet.c and…
- [Low] security/landlock/net.c retains three comments (and one user-
  visible policy decision) whose entire justification is that 'sk_family…

--

ipv6: Remove IPV6_ADDRFORM.

This removes the IPV6_ADDRFORM socket option from both the setsockopt and
getsockopt paths in net/ipv6/ipv6_sockglue.c, and drops the comments in
net/core/sock.c, net/ipv4/af_inet.c, net/ipv6/af_inet6.c and
include/linux/net.h that documented the sk_prot, sk_family and socket->ops
mutability the option caused. The commit message notes that
sk->sk_prot_creator and commit c26c192c3d48 can be cleaned up afterwards.

Closes: https://lore.kernel.org/netdev/20260902010408.1057857-1-4ncienth@gmail.com/
Closes: https://lore.kernel.org/netdev/20260824033331.1084971-1-imv4bel@gmail.com/

> diff --git a/include/linux/net.h b/include/linux/net.h
> index 3d82966e2243b..470100ae71077 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -166,7 +166,7 @@ struct socket {
>  
>  	struct file		*file;
>  	struct sock		*sk;
> -	const struct proto_ops	*ops; /* Might change with IPV6_ADDRFORM or MPTCP. */
> +	const struct proto_ops	*ops; /* Might change with MPTCP. */
>  
>  	struct socket_wq	wq;
>  };

[Severity: Low]
This hunk and the ones in net/core/sock.c, net/ipv4/af_inet.c and
net/ipv6/af_inet6.c clean up the ADDRFORM comments, but a grep at this
commit still finds three places whose only justification was the option.

The kernel-doc for the retained sk_prot_creator field in include/net/sock.h
still points at the deleted code:

  *	@sk_prot_creator: sk_prot of original sock creator (see ipv6_setsockopt,
  *			  IPV6_ADDRFORM for instance)

set_xfrm_gro_udp_encap_rcv() in net/ipv4/udp.c still explains its
unregister branch with a feature that no longer exists:

		if (udp_sk(sk)->gro_receive != new_gro_receive) {
			/*
			 * With IPV6_ADDRFORM the gro callback could change
			 * after being set, unregister the old one, if valid.
			 */

The family argument there comes from sk->sk_family, which can no longer
change for a live socket, so is the remaining comment accurate?

mptcp_supported_sockopt() in net/mptcp/sockopt.c still lists the option
among the IPv6 options MPTCP does not support:

		/* IPV6_MULTICAST_HOPS, IPV6_MULTICAST_LOOP, IPV6_UNICAST_IF,
		 * IPV6_MULTICAST_IF, IPV6_ADDRFORM,

Were these three left out on purpose?  Only the udp.c one is mentioned in
the commit message, as a later revert of c26c192c3d48, so it is hard to
tell which leftovers are intentional.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index fa60b7494c586..1d5927cd49a10 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -770,7 +770,7 @@ bool sk_mc_loop(const struct sock *sk)
>  		return false;
>  	if (!sk)
>  		return true;
> -	/* IPV6_ADDRFORM can change sk->sk_family under us. */
> +
>  	switch (READ_ONCE(sk->sk_family)) {
>  	case AF_INET:
>  		return inet_test_bit(MC_LOOP, sk);

[Severity: Low]
Dropping this comment in sk_mc_loop() says the tree now treats sk_family as
stable after socket creation, and a grep for writes to sk->sk_family agrees:
the only assignments left are in sk_alloc(), the per-family create paths such
as inet6_create(), and net/bpf/test_run.c on a freshly allocated socket.

security/landlock/net.c was not updated the same way, so the tree now holds
two contradictory statements about the same field.
current_check_access_socket() still says:

	/*
	 * The socket is not locked, so sk_family can change concurrently due to
	 * e.g. setsockopt(IPV6_ADDRFORM).
	 */
	sock_family = READ_ONCE(sock->sk->sk_family);

and, further down, it still denies an explicit AF_UNSPEC destination on an
IPv6 UDP socket for that same reason, while conceding the operation should
be permitted:

				 * on such sockets (so it should always be
				 * allowed).  That's because the socket's family
				 * can change under our feet (if another thread
				 * calls setsockopt(IPV6_ADDRFORM)) to IPv4,
				 * which would then treat AF_UNSPEC as AF_INET.
				 */
				audit_net.family = AF_UNSPEC;

The bind path repeats the same rationale.  Should the Landlock comments be
updated in this series too, or at least called out in the commit message so
whoever revisits that -EACCES knows the premise is gone?

> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index b4c977434c2e0..1f68fb64a43ef 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -547,86 +547,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>  
>  	sockopt_lock_sock(sk);
>  
> -	/* Another thread has converted the socket into IPv4 with
> -	 * IPV6_ADDRFORM concurrently.
> -	 */
> -	if (unlikely(sk->sk_family != AF_INET6))
> -		goto unlock;
> -
>  	switch (optname) {
> -
> -	case IPV6_ADDRFORM:
> -		if (optlen < sizeof(int))
> -			goto e_inval;
> -		if (val == PF_INET) {
> -			if (sk->sk_type == SOCK_RAW)
> -				break;
> -

[ ... ]

> -			/* Disable all options not to allocate memory anymore,
> -			 * but there is still a race.  See the lockless path
> -			 * in udpv6_sendmsg() and ipv6_local_rxpmtu().
> -			 */
> -			np->rxopt.all = 0;
> -
> -			inet6_cleanup_sock(sk);
> -
> -			module_put(THIS_MODULE);
> -			retv = 0;
> -			break;
> -		}
> -		goto e_inval;
> -
>  	case IPV6_V6ONLY:
>  		if (optlen < sizeof(int) ||
>  		    inet_sk(sk)->inet_num)
> @@ -1088,14 +1009,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
>  	if (copy_from_sockptr(&len, optlen, sizeof(int)))
>  		return -EFAULT;
>  	switch (optname) {
> -	case IPV6_ADDRFORM:
> -		if (sk->sk_protocol != IPPROTO_UDP &&
> -		    sk->sk_protocol != IPPROTO_TCP)
> -			return -ENOPROTOOPT;
> -		if (sk->sk_state != TCP_ESTABLISHED)
> -			return -ENOTCONN;
> -		val = sk->sk_family;
> -		break;
>  	case MCAST_MSFILTER:
>  		if (in_compat_syscall())
>  			return compat_ipv6_get_msfilter(sk, optval, optlen, len);

[Severity: High]
Is this a user visible ABI regression that needs a deprecation step first?

With the case gone from do_ipv6_setsockopt(), optname 1 matches nothing in
either the lockless or the locked switch, so the function falls through to
its initial value:

	int retv = -ENOPROTOOPT;

ipv6_setsockopt() then hands optname 1 to netfilter:

	if (err == -ENOPROTOOPT && optname != IPV6_IPSEC_POLICY &&
			optname != IPV6_XFRM_POLICY)
		err = nf_setsockopt(sk, PF_INET6, optname, optval, optlen);

No PF_INET6 sockopt handler claims optnames below IP6T_BASE_CTL (64), so
setsockopt(SOL_IPV6, IPV6_ADDRFORM, &PF_INET, 4) now returns -ENOPROTOOPT
where it previously converted an established v4-mapped socket, and
getsockopt(SOL_IPV6, IPV6_ADDRFORM) hits the default: return -ENOPROTOOPT;
arm of do_ipv6_getsockopt() where it previously returned sk->sk_family.

The UAPI definition is kept:

  #define IPV6_ADDRFORM		1

so existing binaries keep compiling and only start failing at runtime with
a generic "Protocol not available", with no pr_warn_once() naming the
caller and no Kconfig or sysctl to restore the old behaviour.

Could the commit message state the new errno explicitly, and say that
already-built applications will fail at runtime rather than at build time?

The message says "getsockopt(IPV6_ADDRFORM) can be replaced with
SO_DOMAIN", which covers only the getsockopt side and still needs a
recompile.  Is there any suggested replacement for the setsockopt side,
i.e. for the IPv6 to IPv4 socket conversion itself?

Would a warn-and-deprecate cycle before the removal make this easier for
whoever is still calling it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904033543.2635540-1-kuniyu%40google.com
