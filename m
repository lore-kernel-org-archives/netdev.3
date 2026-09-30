Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9F51AEEE;
	Wed, 30 Sep 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789055; cv=none; b=Aq55KWsFnjOocQgwMv3RteqAlsFOdV+3GES6BlTDHpktO+b9ZDgpNIMmH55NLAQ6oUm7saHLcsBpQdw2vveWJGwMdxrX1hflvI/nCEmEpami1tsqTF6ZqlkUvA9WcEJjnpO697+hXMoQREUiWib7EpJ6JLV3jobX9RLgizGMak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789055; c=relaxed/simple;
	bh=4OKMzORgpVYpyxZKu8D/i6mokK71Gx8Qcm0T6kxyE1I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVJIyS04Bo1OLlHv3c9AGpigoJvIRB8cDF6jSNuDPlzSEAiAkPwMufGl5/9cHdCJux9CVovJnA9Ci2LAzLTKuC1zJaqQ6Fm8dM2bUiN31cBdaAyzOvYBonpLDmtkUuLf8SbgQ6L0KGGunl1EvW+O0z80TLLdWUv13S8CyKRpGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQt/vyhN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQt/vyhN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29061F000FF;
	Wed, 30 Sep 2026 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789053;
	bh=lQb9tfrlvMaxDUpVxJmUvBlC4Dx9mV1GDM9q8BWJFQA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UQt/vyhNT6WD4j99wIDXjBihWrr1G8iEvbjKjPIvv0Ac/GXM4JLNlODrRzSpcITL4
	 j0fwLq5gcbrpchSfohZS9qDwB9PHgRhQjW52pXzaK3fVO8eJG5QZYOa0kEZFKHXXI0
	 gFDcrh5GPSrtkvkxwkcvmdfrrlrHoixl4HNcfI9whs3tgDuKfbafSOprnHlSwGf/mK
	 lVZgS4eWBedw1Cgf07ZLfjWugH+L5AvZHJ96w4YK1GeL3O5L4l/zKcPDFXrH3xCPQJ
	 btdTb4VFCkW4DuhX/oZnoQgDnHVkNRqqkAPtD+GllXCT1s1l6XIvYEUjTBiHSXixPM
	 EhCVII22ikCtg==
Subject: Re: [PATCH net] soreuseport: Fix use-after-free when a socket is
 added to socks[] twice
From: netdev-bot+sashiko@kernel.org
To: norbert@doyensec.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 17:24:12 +0000
Message-ID: <179078905251.434549.285280757670269533@kernel.org>
In-Reply-To: <6E4F8645-9453-45F1-B068-52E1B14E8B0C@doyensec.com>
References: <6E4F8645-9453-45F1-B068-52E1B14E8B0C@doyensec.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch stops the duplicate socks[] entry but leaves the root
  cause that its own commit message names.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is still
  reachable from the state the patch leaves in place.
- [Low] This problem wasn't introduced by this patch, but a listener that
  is hashed yet sits in the closed section (the state described above)…

--

soreuseport: Fix use-after-free when a socket is added to socks[] twice

This patch makes reuseport_stop_listen_sock() move a socket to the closed
section of reuse->socks[] only when __reuseport_detach_sock() actually
removed it from the listening section. This stops a second copy of the
socket from being added to socks[], which led to a use-after-free in
reuseport_grow().

> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index 29948cb44b7d..031b641be317 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -479,8 +479,8 @@ void reuseport_stop_listen_sock(struct sock *sk)
>  			 */
>  			bpf_sk_reuseport_detach(sk);
>  
> -			__reuseport_detach_sock(sk, reuse);
> -			__reuseport_add_closed_sock(sk, reuse);
> +			if (__reuseport_detach_sock(sk, reuse))
> +				__reuseport_add_closed_sock(sk, reuse);

[Severity: High]

This removes the duplicate socks[] entry. Does it still leave in place the
membership mismatch that the commit message names as the root cause?

inet_hash() only enters the reuseport path when sk->sk_reuseport is set:

net/ipv4/inet_hashtables.c:inet_hash() {
    ...
	if (sk->sk_reuseport) {
		err = inet_reuseport_add_sock(sk, ilb2);
    ...
}

inet_unhash() instead checks sk_reuseport_cb:

	if (rcu_access_pointer(sk->sk_reuseport_cb))
		reuseport_stop_listen_sock(sk);

Take this sequence: listen() with tcp_migrate_req or a MIGRATE prog,
shutdown(), setsockopt(SO_REUSEPORT, 0), then listen() again. The socket
is now a hashed TCP_LISTEN socket, but it is still in the closed section
of the old group G, and sk_reuseport_cb still points at G.

With this patch, the next reuseport_stop_listen_sock() on that socket does
nothing. The socket is never detached or resurrected, so this state lasts
until sk_destruct().

If the socket was autobound, __inet_put_port() released its port on the
first shutdown(). The second listen() can then pick a different port P2,
while G's live members stay on P1.

Could that lead to the following?

  - After SO_REUSEPORT is set again, inet_lookup_reuseport() ->
    reuseport_select_sock() uses the stale G. SYNs sent to P2 are then
    handed to a listener on P1.

  - A new SO_REUSEPORT listener on P2 matches this socket as sk2 in
    reuseport_add_sock() and joins G through the stale cb. One group then
    spans two ports.

  - On a later shutdown(), inet_csk_listen_stop() ->
    reuseport_migrate_sock() moves this socket's children to G's
    listeners on P1.

The comment in reuseport_grow() ("Only reqsk left at this point.") also
assumes that sockets in the closed section are not live listeners. This
state also keeps the NULL dereference described below reachable.

Would a fix at the source work better? For example, inet_hash() could
detach a stale sk_reuseport_cb when !sk->sk_reuseport, or the cb could be
detached when SO_REUSEPORT is cleared. That would make the new conditional
here unnecessary.

The commit message doesn't mention that this state remains after the fix.

[Severity: High]

This is a pre-existing issue, but the hashed-but-closed state above seems
to make a NULL dereference reachable earlier in the same function:

net/core/sock_reuseport.c:reuseport_stop_listen_sock() {
    ...
		reuse = rcu_dereference_protected(sk->sk_reuseport_cb,
						  lockdep_is_held(&reuseport_lock));
		prog = rcu_dereference_protected(reuse->prog,
						 lockdep_is_held(&reuseport_lock));
    ...
}

inet_unhash() checked sk_reuseport_cb earlier, but it held only the
socket's own ilb2->lock at that point.

reuseport_grow() can clear a closed-section socket's cb under
reuseport_lock when the group cannot grow any further:

	sk = reuse->socks[reuse->max_socks - reuse->num_closed_socks];
	RCU_INIT_POINTER(sk->sk_reuseport_cb, NULL);
	__reuseport_detach_closed_sock(sk, reuse);

reuseport_detach_sock() and reuseport_update_incoming_cpu() already guard
against this case:

	/* reuseport_grow() has detached a closed sk */
	if (!reuse)
		goto out;

Normally a socket in the closed section is unhashed, so inet_unhash()
returns early. Here, though, the re-listened socket S is on P2 and G's
members are on P1, so they sit in different lhash2 buckets. Is this
interleaving possible?

CPU0                                 CPU1
shutdown(S)                          listen(T) on P1
inet_unhash(S) under B2->lock        inet_hash(T) under B1->lock
  sees S->sk_reuseport_cb == G         reuseport_add_sock()
  reuseport_stop_listen_sock(S)          spin_lock_bh(&reuseport_lock)
    spin_lock_bh(&reuseport_lock)        reuseport_grow()
    (waits)                                (max_socks * 2 > U16_MAX)
                                           S->sk_reuseport_cb = NULL
                                         spin_unlock_bh(&reuseport_lock)
    reuse = NULL
    reuse->prog  <- NULL dereference

If it is, the oops happens with reuseport_lock held and BH disabled, and
any later reuseport operation would then spin on that lock.

Triggering it needs about 32K same-uid sockets in G and migration enabled.
tcp_migrate_req is per-netns and can be set from an unprivileged user
namespace.

Should reuseport_stop_listen_sock() have the same !reuse check as its
sibling functions?

>  
>  			spin_unlock_bh(&reuseport_lock);
>  			return;

[Severity: Low]

This isn't a bug introduced by this patch, but the same socket (hashed as
a listener while still in G's closed section) also gets past the guards
in reuseport_attach_prog() and reuseport_detach_prog().

For a hashed socket, reuseport_attach_prog() only checks that the cb is
non-NULL before it overwrites reuse->prog:

	} else if (!rcu_access_pointer(sk->sk_reuseport_cb)) {
		/* The socket wasn't bound with SO_REUSEPORT */
		return -EINVAL;
	}

reuseport_detach_prog() only refuses unhashed sockets:

	if (sk_unhashed(sk) && reuse->num_closed_socks) {

So a socket that G treats as shutdown()ed can replace or clear the
steering prog for all of G's live listeners, through
SO_ATTACH_REUSEPORT_CBPF or SO_DETACH_REUSEPORT_BPF.

The comment in reuseport_resurrect() says this should not happen:

	 * ... In setsockopt() path, we should
	 * not change the eBPF prog of listening sockets by attaching a
	 * prog to the shutdown()ed socket.

All members of G share sk_uid, so no privilege boundary is crossed. Is
this behavior intended, though?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/6E4F8645-9453-45F1-B068-52E1B14E8B0C%40doyensec.com
