Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256394;
	b=b4SrlDke1VjAjOlg1sc6rCYBwQtbns+s1yi4O2JSHip44ZgFwWzouE5fsk55n2MYBlmZ
	 2v4Grbt/jcIajGCJtGQ+P3ugcIaFohWWr1s1c1DDfyTur5ly6effM3RS66R5xS2c8pbM7
	 YTHJx2XVVIQpoMxC5xLSvaMFDdbgQpcgC7cpHWNxLaOPMF+kDWjgXvJ44/tG/PSCmvVxr
	 kF9CH+0SC5WBMtp8o7b541X0xCHvjmHaANFQHzpAvWO1cWfMns+tddlC1dCmpIT1URiLy
	 wnnOaOaqn5DFxaGvoRUhgRiG3ztQaMFvuXPWa8k7QnV33JMqj5vR5QcHKJm119quxqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256394;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EjVXytVtPdyf8nmMgK3CDP18MdmAEUR+jL88CL1mcLQ=;
	b=FxFFV5XfZnT7A0iOodN+sKKFxyGFpfUUbXs8esRw/kRFimWscuDVX06w2dGDKp1/ZU6z
	 rRJRpEGnGJHNeK0tq218Z7vATCb4vmO5DIoP15nwq1wIdJs32lpbFRYYS9bCxEuq9jdRH
	 dQO4atlIDxBHIcQ2UDscmlZu96dV2ooS7RElTartfW+NKm/DvdGypdnQPuIf+nuA1LK6r
	 F3YOTT5Vpo9n4pUuzY1XvKF6y7261qRHA7/Ggz/+h0/6m9c7gLOfyuwTTCLcI7ZT7REr6
	 zXr8eRBPHX+jmtWJ5LW9DrD1tH2NUffG672/xpCpH/ZR95PAzRc6eDw4b1a6Ti4qz3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+KHWZ+d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFC606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+KHWZ+d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610451F01825;
	Thu, 29 Oct 2026 06:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793256393;
	bh=EjVXytVtPdyf8nmMgK3CDP18MdmAEUR+jL88CL1mcLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j+KHWZ+dYHKbzmQLQoOsnam6P/45DXkAIfUmahGbrZ7lh+NQHEWMqBIBmt/VJSYXo
	 0XI4JfUWyuqBTHT6XPBn9i8kTpkvCbN2lIU8R/mMGKnvWroboRKXOADjIzE3npafy9
	 KPxsAbNd/8lHHyXdk2mTRp3N3XlqP6z/mePdUVQ6iI0qrMbm7NJxUKXWJWUpygTjzC
	 fQBZ/j55lgT94Jv7KwXTMNeaPxF0G2huqzbhTazcW4Ksbj/Byr5rX4kTtl6Uga5ygN
	 Mb0FbDsUzd+6bV4nn6yfE8G4mkTSmxjewesGILCsbcRrU146jDetSeH6J0I3LmhMoW
	 GeW+OYTc3jprw==
Date: Thu, 29 Oct 2026 08:46:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, netdev@vger.kernel.org, baijiaju1990@gmail.com,
	jjzuming@gmail.com
Subject: Re: [PATCH ipsec] xfrm: keep the mode module pinned until
 destroy_state returns
Message-ID: <20261029064628.GC28851@unreal>
References: <pm-xfrm-core-objects-candidate-0003-v3-3f3e13b81234df0bb10f@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-xfrm-core-objects-candidate-0003-v3-3f3e13b81234df0bb10f@gmail.com>

On Thu, Oct 29, 2026 at 11:19:11AM +0800, Cen Zhang wrote:
> An IPTFS state keeps its mode module referenced while mode_data exists.
> However, iptfs_destroy_state() drops that reference before returning to
> xfrm_state_gc_destroy(), which has no reference covering the callback's
> return path.

This is a good example of why module dependencies should be handled through
direct calls to functions exported with EXPORT_SYMBOL(), rather than through
callbacks for inter-module communication.

Thanks

> 
> With CONFIG_XFRM_IPTFS=m and module unloading enabled, deleting the last
> IPTFS SA can overlap with ordinary module removal in this order:
> 
>   XFRM GC worker                      rmmod xfrm_iptfs
>   iptfs_destroy_state()
>     free mode_data
>     module_put(owner)
>     <preempted>
>                                       delete_module()
>                                         xfrm_iptfs_fini()
>                                           unregister mode callbacks
>                                         free_module()
>     resume in freed module text
> 
> An unload started after the put can finish before the callback resumes.
> GC invokes the callback outside an RCU read-side critical section, after
> its grace period. The RCU waits in mode unregistration and module
> freeing therefore do not protect the callback. The GC mutex only
> serializes GC with device state flushes. Resuming the callback can cause
> an instruction-fetch fault in the freed module text.
> 
> The Oops below was observed on an earlier kernel with scheduling probes
> holding the worker in module_put() after the decrement until ordinary
> rmmod completed. The fixture created and deleted the SA over
> NETLINK_XFRM.
> 
> Take an additional reference to the already pinned owner before calling
> destroy_state(), and release it in XFRM core after the callback returns.
> Cache the owner before the call so releasing the extra reference does
> not need to access the callback table after the callback has finished.
> 
> Oops report as below:
>     BUG: unable to handle page fault for address: ffffffffc0407455
>     #PF: supervisor instruction fetch in kernel mode
>     #PF: error_code(0x0010) - not-present page
>     PGD 80a9067 P4D 80a9067 PUD 80ab067 PMD 0 
>     Oops: Oops: 0010 [#1] SMP KASAN NOPTI
>     CPU: 3 UID: 0 PID: 53 Comm: kworker/3:1 Not tainted 7.2.0-rc5-pmb-xfrm-functional-v1+ #11 PREEMPT(lazy) 
>     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>     Workqueue: events xfrm_state_gc_task
>     RIP: 0010:0xffffffffc0407455
>     Code: Unable to access opcode bytes at 0xffffffffc040742b.
>     RSP: 0018:ffff8881013e7aa0 EFLAGS: 00010282
>     RAX: 0000000000000000 RBX: ffffffffc02199c0 RCX: ffffffff816fc84e
>     RDX: ffff8881013c0000 RSI: 0000000000000000 RDI: ffffffff86338344
>     RBP: ffff8881013e7ba8 R08: 0000000000000001 R09: 0000000000000001
>     R10: ffffffff893e0257 R11: ffff8881013c0000 R12: ffff888107e9ec00
>     R13: ffff888102b07980 R14: ffff888107412ec0 R15: ffff8881013e7ae0
>     FS:  0000000000000000(0000) GS:ffff8881fd929000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffffffc040742b CR3: 00000000080a6006 CR4: 0000000000770ef0
>     PKRU: 55555554
>     Call Trace:
>      <TASK>
>      ? pmbd_gate_maybe+0x47/0x60
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? lock_is_held_type+0x8f/0x100
>      xfrm_state_gc_task+0x17e/0x790
>      ? lock_acquire+0x17b/0x2f0
>      ? __pfx_xfrm_state_gc_task+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? lock_release+0xc8/0x280
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      process_one_work+0x908/0x19c0
>      ? __pfx_process_one_work+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? lock_is_held_type+0x8f/0x100
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      worker_thread+0x65c/0xe40
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? __kthread_parkme+0x175/0x220
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0x34f/0x460
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x659/0x940
>      ? __pfx_ret_from_fork+0x10/0x10
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? __switch_to+0x74f/0xf80
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>     Modules linked in: [last unloaded: xfrm_iptfs]
>     CR2: ffffffffc0407455
>     ---[ end trace 0000000000000000 ]---
>     RIP: 0010:0xffffffffc0407455
>     Code: Unable to access opcode bytes at 0xffffffffc040742b.
>     RSP: 0018:ffff8881013e7aa0 EFLAGS: 00010282
>     RAX: 0000000000000000 RBX: ffffffffc02199c0 RCX: ffffffff816fc84e
>     RDX: ffff8881013c0000 RSI: 0000000000000000 RDI: ffffffff86338344
>     RBP: ffff8881013e7ba8 R08: 0000000000000001 R09: 0000000000000001
>     R10: ffffffff893e0257 R11: ffff8881013c0000 R12: ffff888107e9ec00
>     R13: ffff888102b07980 R14: ffff888107412ec0 R15: ffff8881013e7ae0
>     FS:  0000000000000000(0000) GS:ffff8881fd929000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffffffffc040742b CR3: 00000000080a6006 CR4: 0000000000770ef0
>     PKRU: 55555554
>     Kernel panic - not syncing: Fatal exception
>     Kernel Offset: disabled
> 
> Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> Assisted-by: LLM
> 
> ---
>  net/xfrm/xfrm_state.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 0555e5d796ed..45a52771796b 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -596,8 +596,14 @@ EXPORT_SYMBOL(xfrm_state_free);
>  static void xfrm_state_delete_tunnel(struct xfrm_state *x);
>  static void xfrm_state_gc_destroy(struct xfrm_state *x)
>  {
> -	if (x->mode_cbs && x->mode_cbs->destroy_state)
> +	if (x->mode_cbs && x->mode_cbs->destroy_state) {
> +		struct module *owner = x->mode_cbs->owner;
> +
> +		/* The callback may drop the last module reference. */
> +		__module_get(owner);
>  		x->mode_cbs->destroy_state(x);
> +		module_put(owner);
> +	}
>  	hrtimer_cancel(&x->mtimer);
>  	timer_delete_sync(&x->rtimer);
>  	kfree_sensitive(x->aead);
> 
