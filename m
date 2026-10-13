Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B838642C;
	Tue, 13 Oct 2026 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870296; cv=none; b=tgQ/mhGMpbOfAVdlTZe/8nZu10/wqJFXC058YllrlxOZ1mqSlVpmd35uexL8VdmtsKOqn60kBb5FIoL2UkpPCl81BY7jlQvI5KDSysPEgS3XMWQN/oHFONqG0jQGmSGfwGNFrDEywiRwE7u2QDcrQsliPAKHnS6WA81U5iFZ5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870296; c=relaxed/simple;
	bh=ZoG7SAYYGKfJeHNW7o+moT28quRmq0FHmHebJyJ+EYI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTNMcu7/dlYb0aQhpqITOBRlPZmr96mfhKDVjfqdue5qh9w10LQnteIjaJFu5LKRYTIWbH0GKihjhyFhpjwtIWnwn/Gz9h8mmo6920+e2KH6TsWjWhVenQEI8llhC+jZTl2DMtEPRDkozy1jo69MrrtuZYDQceeckmCTiJDAxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQGYzmPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQGYzmPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8641F000FF;
	Tue, 13 Oct 2026 05:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870295;
	bh=E4pLVor2xTpoLdetxUvSEBzfSZOJ2VUDhuGE1vaXnFI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AQGYzmPXMELuzCqCfPj2XusA//u98UHYEiX70EllUKRr4cFQeao5dUKHqe816dFpR
	 l55tCw619Zp8E+JC0VQnjitr7G2Ul8PScSZLrR80MTMVjTGzMDwhqsx7G2yDsGJYea
	 6vkhMibEgzuy06AD3fE3dxyFTB+wlBr3dZGbiDWZJHKoic3zQrwrQYBqLG4PJBDj7e
	 B5R2J6gNAXH/oqc1hXA4kgRwFlxHYstRhJ0+A8NsSzcABIbz9n6ZFnS79FRCHY/1y2
	 8GcpR+G+fLflAUZLRFw+aKdTstaSFcEXQsK2YKH1RGvg/g3TfM160Ab2ZaPLPWK5UU
	 1oYs7TMsqyKtg==
Subject:
 Re: [PATCH net] ipv6: Keep the SCTP provider alive through socket allocation
From: netdev-bot+sashiko@kernel.org
To: zzzccc427@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, fmancera@suse.de,
 willemb@google.com, kees@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Date: Tue, 13 Oct 2026 05:44:53 +0000
Message-ID: <179187029392.434549.13658813155444673744@kernel.org>
In-Reply-To:
 <pm-ip-core-objects-candidate-0001-v2-efc0e8a00d4f22c36ab8@gmail.com>
References:
 <pm-ip-core-objects-candidate-0001-v2-efc0e8a00d4f22c36ab8@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only covers IPv6.
- [Medium] The COMING check in inet6_create() is skipped for every kernel
  socket (`!kern && owner && module_is_coming(owner)`), not just SCTP's…
- [Medium] inet6_create() now fails a user socket(AF_INET6,
  SOCK_STREAM/SOCK_SEQPACKET, IPPROTO_SCTP) with -EPROTONOSUPPORT if the…
- [Low] The commit fixes a user-triggerable kernel fault (GPF in
  kmem_cache_alloc reached from socket(2)), but its trailers are only…

--

ipv6: Keep the SCTP provider alive through socket allocation

This patch makes inet6_create() reject user SCTP sockets while the SCTP
module is still in MODULE_STATE_COMING. It also takes a temporary
reference on the SCTP proto owner under RCU and holds it across
sk_alloc(). The goal is to stop a failing sctp_init() unwind from
destroying the sctpv6_prot slab while a socket constructor still holds
the cache pointer.

> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> Assisted-by: LLM

[Severity: Low]
This isn't a bug, but the commit message describes a fault that socket(2)
can reach, and the only trailers are Signed-off-by and Assisted-by.

Could a Fixes: tag naming the commit that opened this window be added,
along with Cc: stable, so backporters know which trees are affected?

> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 282912a119999..3873f1f50accb 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c

[ ... ]

> @@ -169,6 +170,17 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>  
>  	sock->ops = answer->ops;
>  	answer_prot = answer->prot;
> +	if (answer->protocol == IPPROTO_SCTP) {
> +		owner = answer_prot->owner;
> +		err = -EPROTONOSUPPORT;
> +		/* SCTP init can unwind despite an owner reference.
> +		 * Allow the kernel control socket during initialization.
> +		 */
> +		if (!kern && owner && module_is_coming(owner))

[Severity: Medium]
The comment says only the SCTP kernel control socket is allowed during
initialization. This check lets every kern=1 caller through, though. Is
that the intended scope?

As the commit message notes, try_module_get() succeeds on a COMING module.
For a kernel caller, the reference taken below therefore does not block
the init unwind. Only sctp_ctl_sock_init() is ordered against that unwind,
because unregister_pernet_subsys(&sctp_ctrlsock_ops) runs before
sctp_v6_protosw_exit().

Other in-tree kernel SCTP users have no such ordering. For example,
fs/dlm/lowcomms.c does:

	result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
				  SOCK_STREAM, dlm_proto_ops->proto, &sock);

Here dlm_sctp_ops.proto is IPPROTO_SCTP, and ss_family can be AF_INET6.

Suppose such a caller finds the sctpv6 entry while SCTP is COMING, and a
later sctp_init() step then fails:

  inet6_create(kern=1)                sctp_init() failure path
  --------------------                ------------------------
  try_module_get(owner) succeeds
  rcu_read_unlock()
                                      sctp_v6_protosw_exit()
                                        proto_unregister(&sctpv6_prot)
                                      do_init_module() fail:
                                        module_put(mod)
                                        free_module(mod)
  sk_alloc(..., answer_prot, kern)
  module_put(owner)

Could sk_alloc() then allocate from a destroyed kmem_cache, and could
module_put() then touch a freed struct module? On init failure,
do_init_module() frees the module without waiting for the refcount to
drop.

> +			goto out_rcu_unlock;

[Severity: Medium]
Is -EPROTONOSUPPORT the intended user-visible result here?

Before this patch, socket(AF_INET6, SOCK_STREAM or SOCK_SEQPACKET,
IPPROTO_SCTP) succeeded if it ran while the module was COMING. Now it
jumps straight to out_rcu_unlock and skips the try_loading_module /
request_module() retry. That retry would have waited for the load in
progress, and the re-lookup would then have found a LIVE module.

The window is not small. sctp_init() publishes the IPv6 entries in
sctp_v6_protosw_init(). It then runs register_pernet_subsys(
&sctp_ctrlsock_ops), which creates one control socket per netns, followed
by sctp_v4_add_protocol(), sctp_v6_add_protocol() and sctp_offload_init().
Only after all of that does do_init_module() set MODULE_STATE_LIVE.

Say one thread triggers the autoload and a second thread calls socket()
after the entries are published. Would the second thread get "protocol
not supported" for a protocol that is moments away from being usable?

> +		if (!try_module_get(owner))
> +			goto out_rcu_unlock;
> +	}

[Severity: High]
Does inet_create() in net/ipv4/af_inet.c still have the same race during
the same sctp_init() unwind?

sctp_init() calls sctp_v4_protosw_init() first. That registers sctp_prot
and publishes sctp_seqpacket_protosw and sctp_stream_protosw while the
module is still COMING. Every later failure ends up in
sctp_v4_protosw_exit():

net/sctp/protocol.c:sctp_init() {
    ...
	status = sctp_v6_protosw_init();
	if (status)
		goto err_v6_protosw_init;

	status = register_pernet_subsys(&sctp_ctrlsock_ops);
    ...
err_v6_protosw_init:
	sctp_v4_protosw_exit();
    ...
}

sctp_v4_protosw_exit() finishes with proto_unregister(&sctp_prot), which
destroys the slab.

Meanwhile, inet_create() has neither the COMING check nor the temporary
owner reference:

net/ipv4/af_inet.c:inet_create() {
    ...
	sock->ops = answer->ops;
	answer_prot = answer->prot;
	answer_flags = answer->flags;
	rcu_read_unlock();

	WARN_ON(!answer_prot->slab);

	err = -ENOMEM;
	sk = sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern);
    ...
}

Could an unprivileged socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP) still
reach kmem_cache_alloc() on a destroyed cache? That is the same fault this
commit describes, and the commit message does not mention IPv4.

It also leaves the two constructors behaving differently while the module
is COMING: user AF_INET6 SCTP sockets now fail with -EPROTONOSUPPORT, but
AF_INET SCTP sockets go ahead and stay exposed. Should inet_create() get
the same protection?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-ip-core-objects-candidate-0001-v2-efc0e8a00d4f22c36ab8%40gmail.com
