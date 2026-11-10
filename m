Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303245;
	b=4KAjg2w/VFKbu0I9EuYO1BWRFovQY1Ai/gLfge6RuMj0DdBBX4zAeHmhHDW5gr3GBTkf
	 nTwHtTlIp0epNTqjqEldf+I1pGgVSSVmceQ3aZL41uFfeA81sjKMHhwG38dc6VkUNaQwi
	 BhSAIZSVSx9Y7JgZ7+TB3OWlile/WTlTImQq4saS+PFnMftLb+voZkIlCw2eLwpIF7bL+
	 f5sIpiNrWraFeAxc0FpLB4/1MxR9G4x5vSMEgOhng63Dxc5FKpChGITru7YnzNq4iPj80
	 wj4c+/8lUBXjNDnK9GTSrvrUZy8L6xi0/k0gy/iPClnsmBbS0fOCwGOesii1BXCzY4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303245;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NGAJINqsl0pL1ERlBrJ4oxNTMHJQBWQyUyZoZjOn/ok=;
	b=sU+Tsv9rs3KuYybA3XMWM2twddvfNTLrVtsDqfwFbZxDf6bxuyQHrJ1iChUmpYtV1KUy
	 IeHOOiACXrxCJuuBmoC3JQhcU74kOyLucsZ7wFfUCCvhr4tUL7HcQd4p67WAfEZMCidpl
	 I7nWX6RclHblnsg1ynwqPxuuz/3R3dpugwCflxAqqGADB1l0A+QIbFq1cPn7Do4sl5ciS
	 k9YDKbX9jxzofXV4UaD2J59T4tdrbpiO87QZnHSUHimTd/V0aCFq9k8pHHzRNXbGX60L7
	 jR52UVswSly1PIZMC09rmRw5ZHj4L4g196j3DecC15Mh63fr6mH+97VE+5o/tblnjOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9jMXT0G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2957606C66F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9jMXT0G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEC41F008A1;
	Tue, 10 Nov 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303244;
	bh=NGAJINqsl0pL1ERlBrJ4oxNTMHJQBWQyUyZoZjOn/ok=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g9jMXT0G0cmWxS9w0VMQFmnsYVn7N8jG0b3LiFfNO4XCg3SemcYT9b1QRK9RFN8ni
	 +dO4PWeh4VMqHmA2rCNj8asK4dPJvgMhTZ25a9aekOg1/RlYHF9/98jaVGpTc1/TkL
	 iJYwy7IbDO2sxDxPjwyNzU0shkGD4cVzXVk/XtayKuYGF9KHfw+ufzAt6g2hSiYo72
	 CbBOCjdInDYjzkPO/tw1DHf/CRP10Q47OUDTf63OdV6cS4wIN3+kWufftGOGxsxT+b
	 1ImavlPlfVfwCWZsQk6JFrJsghcq0QfCPrcdo6L/d1muP5Atbdxxo4j1NyITJryyQI
	 Y5FOrvasPvnGQ==
Subject:
 Re: [PATCH net] xfrm: hold migrated state references through xfrm_migrate()
From: netdev-bot+sashiko@kernel.org
To: juny24602@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, nakam@linux-ipv6.org, shinta.sugimoto@ericsson.com,
 yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, junvyyang@tencent.com,
 stable@kernel.org, corvus@tencent.com
Date: Tue, 10 Nov 2026 09:34:03 +0000
Message-ID: <179430324333.994134.1099651074842502096@kernel.org>
In-Reply-To: <20261106091511.45429-1-juny24602@gmail.com>
References: <20261106091511.45429-1-juny24602@gmail.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] This patch fixes put-before-delete only for x_new[].

--

xfrm: hold migrated state references through xfrm_migrate()

This patch makes xfrm_state_migrate() take a caller reference on the
cloned state before installing it. xfrm_migrate() then drops that
reference after a successful migration, or after deleting the new states
on rollback. The goal is to stop a concurrent deletion, such as one from
the expiry timer, from freeing a migrated state before xfrm_migrate()
calls xfrm_state_delete() on it.

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index cea6842e6454d..89e5acf4c210b 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4730,6 +4730,9 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
>  		xfrm_states_delete(x_cur, nx_cur);
>  	}
>  
> +	if (nx_new)
> +		xfrm_states_put(x_new, nx_new);
> +

[Severity: Critical]
This fixes the ordering for x_new[]. Can the old states in x_cur[] still
hit the same use-after-free on the success path?

Stage 4 in xfrm_migrate() drops the caller reference first and only then
deletes the states:

net/xfrm/xfrm_policy.c:xfrm_migrate() {
    ...
	/* Stage 4 - delete old state(s) */
	if (nx_cur) {
		xfrm_states_put(x_cur, nx_cur);
		xfrm_states_delete(x_cur, nx_cur);
	}
    ...
}

The put loop releases the reference taken by xfrm_migrate_state_find().
After that, each x_cur[i] is held only by the table reference. Several
paths can drop that reference concurrently, and none of them take
xfrm_cfg_mutex:

  - xfrm_timer_handler()->__xfrm_state_delete() on hard expiry
  - a PF_KEY SADB_DELETE or flush, serialized by pfkey_mutex instead
  - a datapath byte or packet hard limit that fires the timer at once

If that happens between Stage 2 and the put loop, the put in Stage 4 is
the final one. If it happens between the put loop and the delete loop,
the concurrent deleter does the final put. Either way the state goes to
the GC worker:

__xfrm_state_destroy()
  -> schedule_work(&xfrm_state_gc_work)
     xfrm_state_gc_task()
       -> synchronize_rcu()
       -> xfrm_state_gc_destroy()

xfrm_migrate() is in preemptible process context and holds no RCU read
lock. Could the free therefore finish before this call reads freed
memory?

xfrm_states_delete(x_cur, nx_cur)
  -> xfrm_state_delete(x)
       spin_lock_bh(&x->lock);
       err = __xfrm_state_delete(x);

If the memory has been reused and km.state no longer reads as DEAD,
__xfrm_state_delete() also unlinks list and hash nodes in freed memory
and puts the state a second time.

nx_cur can be up to XFRM_MAX_DEPTH. The whole put loop finishes before
any delete runs, so the window for later entries also covers the
earlier deletes.

The commit message describes this same situation: a concurrent deletion
frees a migrated state before xfrm_migrate() calls xfrm_state_delete().
Should Stage 4 use the order the new restore_state path uses, that is,
xfrm_states_delete(x_cur, nx_cur) and then xfrm_states_put(x_cur,
nx_cur)?

The peer path xfrm_do_migrate_state() in net/xfrm/xfrm_user.c already
does this. It keeps its lookup reference on x across
__xfrm_state_delete(x) and drops it afterwards.

XFRM_MSG_MIGRATE only requires CAP_NET_ADMIN in the netlink socket's
user namespace. That means a user and net namespace can reach this
path, and the same user controls the SA lifetimes that drive the expiry
timer.

>  	/* Stage 5 - announce */
>  	km_migrate(sel, dir, type, m, num_migrate, k, net, encap);
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106091511.45429-1-juny24602%40gmail.com
