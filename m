Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294106;
	b=PCZEkRZgQzN/Nx8QhhIxH5YZJze7e73q17wg/jvDk/cJ9V/VRDkWGpza5hiir22wbTnG
	 hA4tiIIgtVST7Y6lnFG/cGSgQiu++HJv5B1Dr/BboBTE8LeuYjjgrY/l9LVZyq/QDd9Vd
	 aEvR85XhlQtPFNE1QcNJ3J4FcRAOW37CYdC5J9LOKBGLUdqW56iqpQOr8R21nQboER53q
	 uNDOa7ovbNEEG6DaTKVCLy2rJLmrJFYQxx7iS3WJyYWCYWFsz9si2CCsXRpz0NyCmuDPL
	 2DFCSKLptL22943sfH4b38x8rZnF0Mhi58bHiLWYT1r7rIOsbCN1iJP99vmpMLaZELg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294106;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RB1Pk+9m7Z9vhYzC2pN1Rp1mzLzUovnJBnJ8agVboCA=;
	b=XNcWUs52cpynAJQaruRheKOpEK3dP2XOQpj+1qFBkVC6QSMWOUDCpN2rE4WvzyaJbx+u
	 Ol+fj20EEfOfwZeExfLrlrr0HKCMtmZWaZV+mG6Onng/9iPWLAG/Lgp4nvN7Tm7RejFaw
	 j/LoC/UHAbiD5cR+ZsxW/vjWuX24Y9sPibGLCNrWNjmNgcCj4VQXAF/UjwQZEG7YVV8Qn
	 I6Loat97+zLfHaFx5ZYJ8emUBhpF/XyJy9ahv8bbdJkSr4QKHt8SM2n5qlEKImt8HVus8
	 Kpo9q+ut0qb72VyzuihnMfqpTWXqe4ktNsFbNCQ+iBRJlS8AfMzL1uQp238cA262cOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUtQe3Jk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA4606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUtQe3Jk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123291F01816;
	Thu, 29 Oct 2026 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793294105;
	bh=RB1Pk+9m7Z9vhYzC2pN1Rp1mzLzUovnJBnJ8agVboCA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iUtQe3Jkghym49We05vmYBVQSnGf7qHgVfwTinpuTyC3V5UdMtmY6IJmPsb0HFFTb
	 Y2YXcb6bmA1W3F5PDYhrNXa/4IKosMQqVBCWlhiaKC5N3EcdVNEswraJihxm0hMNt3
	 sKNhpVt5Hnw7Ls7VaEuHNX0liOfkXSvZ/tu5JFKgr4E89aK51j6p7DRwwHHOUm2WBW
	 EAM5gwuFpBOhdUM097rIk2sEsnMsQ/bvNRsibQvV3iFJALwGeesm5JxVLvgb2w/lN9
	 oZuQlemrw723BdiDkH3RBDXyMXB/PCznXbgYTpg8pFJq8V1WN6M00uGyeAIYail1xE
	 xbI290kUb12lg==
Subject: Re: [PATCH net] tcp: wait for TIME_WAIT teardown before freeing
 per-netns ehash
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 ncardwell@google.com, horms@kernel.org, netdev@vger.kernel.org,
 kylebot@openai.com
Date: Thu, 29 Oct 2026 17:15:04 +0000
Message-ID: <179329410450.3134.7838743761467837570@kernel.org>
In-Reply-To: <20261028162510.2180528-1-edumazet@kernel.org>
References: <20261028162510.2180528-1-edumazet@kernel.org>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tcp: missing synchronize_net() in tcp_sk_exit_batch() for shared
  ehash

Pre-existing issues:
- [Medium] tcp_sk_exit_batch() (net/ipv4/tcp_ipv4.c) now calls
  synchronize_net() only when some netns in the batch has a private…

--

tcp: wait for TIME_WAIT teardown before freeing per-netns ehash

This commit adds a synchronize_net() call in tcp_sk_exit_batch() after
tcp_twsk_purge(). The goal is to wait for inet_twsk_kill() callers that
unhashed their socket before the purge could see it. The wait runs only
when at least one netns in the batch uses a private ehash, before the
private hashinfo is freed.

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index ebe5aa70374a3..3f8563a36db1e 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3561,6 +3561,17 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
>  
>  	tcp_twsk_purge(net_exit_list);
>  
> +	/* inet_twsk_kill() can unhash a socket before the purge sees it.
> +	 * Wait for such BH-disabled callers to finish before freeing a
> +	 * private ehash. This is not needed for the shared tcp_hashinfo.
> +	 */
> +	list_for_each_entry(net, net_exit_list, exit_list) {
> +		if (net->ipv4.tcp_death_row.hashinfo->pernet) {
> +			synchronize_net();
> +			break;
> +		}
> +	}
> +
>  	list_for_each_entry(net, net_exit_list, exit_list) {
>  		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
>  		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));

[Severity: High]
Is the shared tcp_hashinfo case really safe to skip here?

The new comment says the grace period is not needed for the shared
tcp_hashinfo. That holds for the hashinfo memory. inet_twsk_kill()
also touches per-netns state, though, and tcp_sk_exit_batch() checks
that state for every netns in the batch.

inet_twsk_kill() does three things in order:

- unhashes the twsk with sk_nulls_del_node_init_rcu()
- looks up the bhash and bhash2 buckets via twsk_net(tw)
- calls refcount_dec(&tw->tw_dr->tw_refcount), where tw_dr is
  &net->ipv4.tcp_death_row

Every TIME_WAIT socket holds a tw_refcount reference, taken in
__inet_twsk_schedule(), whether or not hashinfo->pernet is set.
Consider a batch where every netns uses the default shared ehash
(tcp_child_ehash_entries == 0). Can this still happen?

CPU A
tw_timer_handler()
  inet_twsk_kill()
    sk_nulls_del_node_init_rcu()   /* twsk of dying netns unhashed */

CPU B
tcp_sk_exit_batch()
  tcp_twsk_purge()
    inet_twsk_purge(&tcp_hashinfo) /* twsk already gone */
  /* no pernet hashinfo, synchronize_net() skipped */
  WARN_ON_ONCE(!refcount_dec_and_test(
          &net->ipv4.tcp_death_row.tw_refcount))
                                   /* 2 -> 1, WARN fires */

CPU A
    refcount_dec(&tw->tw_dr->tw_refcount)
                                   /* 1 -> 0, REFCOUNT_DEC_LEAK */

A BH caller can hit the same window. If tcp_v4_rcv() wins
timer_shutdown_sync() in inet_twsk_deschedule_put(), it may still be
inside inet_twsk_kill() when the purge runs. The purge then either
fails to find the twsk, or gets false from its own
timer_shutdown_sync(). In both cases it does not wait.

The result is a WARN splat in tcp_sk_exit_batch(), then a
refcount_warn_saturate() splat from inet_twsk_kill(). Systems with
panic_on_warn would panic on the first one. inet_twsk_kill() can also
keep dereferencing twsk_net(tw) and tw->tw_dr after
tcp_sk_exit_batch() has returned for that netns. An unprivileged user
with user and network namespaces can reach this setup, the same as in
the reproducer in the commit message.

The window predates this patch. However, the new comment documents the
shared case as not needing the wait. That seems to contradict the
invariant stated above the mutex_lock() in tcp_sk_exit_batch(): the
thread dismantling a twsk must finish before another thread reaches
refcount_dec_and_test() of tcp_death_row.tw_refcount.

Should the wait cover the shared case too? It could run
unconditionally. Or it could run when
refcount_read(&net->ipv4.tcp_death_row.tw_refcount) != 1 for some net
in the batch after tcp_twsk_purge(), which would keep the common
no-TIME_WAIT case cheap.

[Severity: Medium]
This isn't a bug introduced by this patch, but is the shared tcp_hashinfo
case really safe to skip?

The hashinfo memory doesn't need the wait in that case. The per-netns
tw_refcount, though, lives in struct net, and the WARN_ON_ONCE() above
checks it for every netns, shared ehash or private.

inet_twsk_kill() in net/ipv4/inet_timewait_sock.c unhashes first. It
drops the death-row reference only after the bind table locking:

net/ipv4/inet_timewait_sock.c:inet_twsk_kill() {
    ...
	spin_lock(lock);
	sk_nulls_del_node_init_rcu((struct sock *)tw);
	spin_unlock(lock);
    ...
	spin_lock(&bhead->lock);
	spin_lock(&bhead2->lock);
	inet_twsk_bind_unhash(tw, hashinfo);
	spin_unlock(&bhead2->lock);
	spin_unlock(&bhead->lock);

	refcount_dec(&tw->tw_dr->tw_refcount);
	inet_twsk_put(tw);
}

Take a batch where every netns uses the shared tcp_hashinfo (the default,
tcp_child_ehash_entries == 0). Could this sequence happen?

CPU A
tw_timer_handler()
  inet_twsk_kill()
    sk_nulls_del_node_init_rcu()   /* twsk of dying netns N unhashed */

CPU B
tcp_sk_exit_batch()
  tcp_twsk_purge()
    inet_twsk_purge(&tcp_hashinfo) /* never sees the twsk, so no
                                      timer_shutdown_sync() */
  /* no pernet hashinfo, synchronize_net() skipped */
  WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
                                   /* count is 2 -> 1, WARN fires */

CPU A
    refcount_dec(&tw->tw_dr->tw_refcount);
                                   /* 1 -> 0, refcount_warn_saturate()
                                      with REFCOUNT_DEC_LEAK */

That would give two warning splats and leave tw_refcount saturated in the
dying netns. On panic_on_warn systems, the first one would panic. An
unprivileged user with user and network namespaces can reach this, the
same setup as the reproducer in the commit message.

The comment above mutex_lock() in tcp_sk_exit_batch() states the
invariant:

	 * tcp_twsk_purge() handles twsk in any dead netns, not just those in
	 * net_exit_list, the thread that dismantles a particular twsk must
	 * do so without other thread progressing to refcount_dec_and_test() of
	 * tcp_death_row.tw_refcount.

The commit message also says:

    Wait for an RCU grace period after purging the whole batch.
    TIME_WAIT removal runs with bottom halves disabled, so this also waits
    for removers that were already invisible to the purge.

With the pernet condition in place, that only holds for batches that
contain at least one private-ehash netns. Mixed batches are covered only
because the single synchronize_net() also covers the shared-ehash nets.

This same window existed before this patch for both shared and private
ehash. The shared-ehash path is unchanged here.

Would it make sense to drop the pernet condition and wait for every batch
before the refcount_dec_and_test() loop? If not, should the new comment
say that the shared case still has this tw_refcount window?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028162510.2180528-1-edumazet%40kernel.org
