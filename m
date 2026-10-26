Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011906;
	b=Zurj+neceZUvkJsg+QpWSdVooMTCuRekdmT9aLVaJFX5XiIj9pl2bAtjES6t5Dt5GDAR
	 6JWcuVM5/KrLitEFw2sUjVoTEhf5YktdQQmdP791c0WTLjxhJFi4nfwS+r3944jBK9srJ
	 CZSHD1JZR9ZxEhwvl0jHS0dytUAnLJi1arnAzfOTZMHP/J3CZvsLw5guartjZnHuKTQoh
	 KTOkrBatqcCTRpSXTaqk/Y8TdgYOXufJy8T9lv8qoiviTUbPthqAzAFDKUtDhBnjJlGKn
	 thji03V5+AbOYwnwmYf0wubrWGrroQhcJV3EnCWgWKmtJu5LdaNUZPXxosKCfc595eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011906;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=v5tLdsYVe6jkudpLhvAnNdfNyTx+hkCn0nQ4rxKNJDg=;
	b=NGUAL9p++364Hqu/MLXgWMNmY/J2/T4NijpOgoVLZhwjyZSQXaDZJHBqHWUUewq1kLgY
	 XakTk0dxI0HaUk7jflJ+RJA8I4ljNMdUGELRRz3GaXMwwyuohLTpyzrg1ed8QqhlNFcSH
	 gGwK4jMzdVz88i3HTFfS9m5CzQSjBI6al8ZPU7rFZII4ugp/IUV9Z8h6aQxQ/rDZxuEid
	 W2lgDHfQT1zCfOuWW+LVZxLjOjogki8izw17ru9SmiJu5ZJKQ4qr5lt6wRLdaEehiE7SX
	 sXJSBNBgtEwbQbO6IlirCnnme6r3n+DrZJO1acxWHeaNrDK4qBIBuLbYgL0iQIXn5BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgntCwBi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3E606A31B;
	Mon, 26 Oct 2026 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgntCwBi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176351F01825;
	Mon, 26 Oct 2026 10:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011905;
	bh=v5tLdsYVe6jkudpLhvAnNdfNyTx+hkCn0nQ4rxKNJDg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JgntCwBilmygVU4migOHVAa1q/0zsYcGJ1yaRuD/XcHGcPkuoaN/dM5JrmBfsdy3t
	 Ydi/D39kX+0QL8Bc/iSA/+5cXEbTnnZpndFZs41eidxdLNM0HP72SUxfhyObejal1w
	 Vlg2FyuwirYyADGgwIElgWezMmwIkRaNm6Jvpoj+k8tNoyqBCjFyoCikAoX/5v8NEu
	 6PMUqONYKGUbUH2f12ZfYXWvFg4ubsxYWHan9LBCGb38cNqlIZKSOVDzJRUEVl9Qum
	 ALTElPbWX1Ta0iuXQwoqsQ1XO0bLQGv2LCzl2eTMczR9E3O126KIFLdFcU/SyRg2xC
	 bR5CmV5PwTPNg==
Subject: Re: [PATCH] xfrm: disable state hash resize work on netns exit
From: netdev-bot+sashiko@kernel.org
To: hackerowskiy@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+f3f4fce0609f8e91b540@syzkaller.appspotmail.com
Date: Mon, 26 Oct 2026 10:51:44 +0000
Message-ID: <179301190461.3134.10521978654575001066@kernel.org>
In-Reply-To: <20261022102641.1429128-1-hackerowskiy@gmail.com>
References: <20261022102641.1429128-1-hackerowskiy@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The race the commit message describes cannot happen, so this
  patch does not change any reachable behaviour and cannot be the fix…
- [Low] The commit message splits its trailer block.

--

xfrm: disable state hash resize work on netns exit

This commit replaces flush_work() with disable_work_sync() for
state_hash_work in xfrm_state_fini(). The stated goal is to stop a
concurrent state insertion from queueing a hash resize while netns
teardown walks and frees the per-net state hash tables.

Closes: https://syzkaller.appspot.com/bug?extid=f3f4fce0609f8e91b540

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index e45aa1ed5b965..8a2e465bd73d7 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -3392,7 +3392,7 @@ void xfrm_state_fini(struct net *net)
>  	unsigned int sz;
>  	int i;
>  
> -	flush_work(&net->xfrm.state_hash_work);
> +	disable_work_sync(&net->xfrm.state_hash_work);

[Severity: High]
Can the race in the commit message actually happen? If it can't, this
change does not alter any reachable behaviour, and the syzbot report would
be closed without its real cause being fixed.

The commit message says:

  A concurrent state insertion can queue another resize while that flush
  is in progress.

The only place that queues state_hash_work is xfrm_hash_grow_check():

net/xfrm/xfrm_state.c:xfrm_hash_grow_check() {
	if (have_hash_collision &&
	    (net->xfrm.state_hmask + 1) < xfrm_state_hashmax &&
	    net->xfrm.state_num > net->xfrm.state_hmask)
		schedule_work(&net->xfrm.state_hash_work);
}

It is only called from xfrm_state_find(), __xfrm_state_insert() and
__find_acq_core().

xfrm_state_add(), xfrm_state_update(), xfrm_find_acq(), xfrm_migrate() and
ipcomp_tunnel_attach() are only reached from xfrm_user netlink handlers
(xfrm_add_sa, xfrm_alloc_userspi, xfrm_do_migrate) or from af_key
handlers. Those need a live user socket in the netns. That socket holds a
netns reference, so cleanup_net() cannot have started yet.

xfrm_state_find() only links an ACQ state when a key manager accepts the
acquire:

		if (km_query(x, tmpl, pol) == 0) {
			spin_lock_bh(&net->xfrm.xfrm_state_lock);
			...
			xfrm_hash_grow_check(net, x->bydst.next != NULL);

Once xfrm_user_net_pre_exit() has run:

	RCU_INIT_POINTER(net->xfrm.nlsk, NULL);

xfrm_nlmsg_multicast() returns -EPIPE. pfkey_broadcast() returns -ESRCH
because no PF_KEY sockets are left in the dying netns. So km_query()
fails.

xfrm_state_find() holds rcu_read_lock() across km_query() and the
insertion. ops_undo_list() runs synchronize_rcu() between all pre_exit
and exit methods:

net/core/net_namespace.c:ops_undo_list() {
	...
	list_for_each_entry_continue_reverse(ops, ops_list, list) {
		hold_rtnl |= !!ops->exit_rtnl;
		ops_pre_exit_list(ops, net_exit_list);
	}
	...
		synchronize_rcu();
	...
	list_for_each_entry_continue_reverse(ops, ops_list, list)
		ops_exit_list(ops, net_exit_list);
}

That means any xfrm_state_find() already in flight finishes before
xfrm_net_exit()->xfrm_state_fini() runs.

Any resize queued before .exit would therefore already be drained by the
old flush_work(), and xfrm_hash_resize() never re-queues itself.

Which insertion path can queue state_hash_work during xfrm_state_fini()?

The commit message gives no such path and no splat, and says no
reproducer was available. With the Fixes: and Closes: tags, this would go
to stable and mark the syzbot report fixed while the actual trigger is
still reachable.

Earlier WARNs in xfrm_state_fini() have had other causes, for example kern
states that xfrm_state_flush() skips because of xfrm_state_kern(). This
patch does not touch those.

Could the syzbot report be rechecked to find the real root cause?

>  	xfrm_state_flush(net, 0, false);
>  	flush_work(&xfrm_state_gc_work);

[Severity: Low]
This isn't a bug, but the trailer block in the commit message is split
by a free-form paragraph:

    Assisted-by: LLM

    Build-tested: W=1 ARCH=arm64 net/xfrm/ (out-of-tree build).
    No reproducer was available to run the teardown race locally.

    Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>

git interpret-trailers only treats the last paragraph as trailers. As a
result, Fixes:, Reported-by:, Closes: and Assisted-by: are not parsed as
trailers.

Could the testing notes go below the --- separator, with all tags kept in
one block at the end of the message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022102641.1429128-1-hackerowskiy%40gmail.com
