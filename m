Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731088;
	b=HM/4c6+wdwSf+wuzwXz2MKmw543C1t9E+UDGg5J9qU2UUgOWHviRxUhmdhhdLDJtgJqK
	 EC8DURDWf2vLBfeH5XKkjFMGF//JWCHRNM1nJ9kJAEEZtrMCGFJ0XBWbh8tdALcJiNqFq
	 V02YUkh8AKwFEM46Vi6m/eOL/u/bWw+iH9wSFUUF/lJ41oRui4ZTeLPG2c5w7GFKIRU4/
	 pY+hRuYyo0sXvSifFmHlGP5lbfk5xwwt/3AnU+Xysd6TjhXVHOlilQqvLqFFH2V2kvAIk
	 Klk3QcK+Qq1tJrwYvl8uZO7kwlQnpG7NOycuzmgJ98TA5kjqRjiU2eU/ZOP8f02c5bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731088;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wocz8r3Z14BmQCtGO1kjwm6YZ/KPutkoxo0QyQ0cCQs=;
	b=kwBG5+hviuzNDLfeUQ0KMLbfrvK0QLgCxs52tmwdv4N/LTf/CWpRNlVXlL4f0gxB2uOU
	 nIcQLWnukmMkrLCillPiDNfEvU12pqNakxXV8Cy6s860NGNZWIw5aP1EywBYFiBODQj+x
	 UotHlg7g5u2lW6nawLkTaEzfdUYn7zH2aGczJGViuRLi9lCdx2pcLypG0Sgnpcq5JpCeP
	 pEQYTzJ/P3AO46+lson6nfKmfFRq/BRyMfU/krTQlXxkMkv+7Kh8PkRA1Xgqi7SS6TbXk
	 /EcmN1o9nSKeGY8+85d4U3pkbMwnCDaP2wvYgzqGvh0UB4ioA2MGg3/FY1ea1CGCguA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAqUqXDI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B08606A330
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAqUqXDI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2C01F00A22
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731088;
	bh=wocz8r3Z14BmQCtGO1kjwm6YZ/KPutkoxo0QyQ0cCQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gAqUqXDI1KDUJjH/e7eRU5lf1a1ZBsC7CHtEG4ntAmUhcr0do6EtT4kIcP3aIlwEN
	 l30CHZoHsof36U3GsHtHedNQaShyvvQpxsFnC9ubIRf5nJn6GPyEmeiH4Jb1/RnuK3
	 9C4R86yIMm9L23h/fRdpFUDkTm5eDQNGiW281/qT5d5lWQ/GTngqBtsjJlJV5i5NOE
	 dA0uKpxSI5CllX3tgjAsJbzKo84CZkekuXCQK9QOoAdLEuGFw87f3zlKXhzbBQ0oGR
	 uMpsy4C20/wDlRKHJJi5Xn90sP2gK+PAOLtYbYle4JZ31QbXdaD+sFawYXi2HNKuzY
	 3gV7pOKWjgaBQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-705cb6ceebaso2897054eaf.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:38:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxZ2V4cm1Il1TdK9uLv24rT2DOUPKDfoBLMu02bENckk0Fukm4clTolOe7KqbUMrcOrOXLXHiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9M528S5gtgZjDnUaWQFBKbS1odhKsh7zclpw3mHFBSlTDYSqL
	zD+HASpmXjMnDc/++DYL5/oSPDbBukCg1AdbZndMCU6fkmZcuOkZQ+9eOPHRhSbY0FEnYTs0U6P
	OqvwdsneDV/zXyazmfcVDjxDmCB1lTJM=
X-Received: by 2002:a05:6820:60f:b0:6df:10cb:4a5f with SMTP id
 006d021491bc7-714f278f5f4mr7377950eaf.70.1793731087384; Tue, 03 Nov 2026
 10:38:07 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-napi-timer-cancel-v1-1-55c631ad5286@columbia.edu>
In-Reply-To: <20261103-napi-timer-cancel-v1-1-55c631ad5286@columbia.edu>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 19:37:55 +0100
X-Gmail-Original-Message-ID: <CAL4WiioJuY1L5ji7tVXggp=FDm3eidwekpxqAMdnxWUyiTR3fg@mail.gmail.com>
X-Gm-Features: AclHuK-5QRfDhVd6PX6rRiLGs5x_KUk2nea94GeuQzRj9GBpfeF3rw83rbf-cDc
Message-ID: <CAL4WiioJuY1L5ji7tVXggp=FDm3eidwekpxqAMdnxWUyiTR3fg@mail.gmail.com>
Subject: Re: [PATCH net] net: cancel napi->timer after the grace period in netif_napi_del()
To: mt4022@columbia.edu
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Martin Karsten <mkarsten@uwaterloo.ca>, Joe Damato <joe@dama.to>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Wang Zhan <wang.zhan@smartx.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 19:19, Mani Tofigh via B4 Relay
<devnull+mt4022.columbia.edu@kernel.org> a =C3=A9crit :
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> A napi can be freed with its timer still queued.  napi_disable()
> cancels napi->timer, but napi_complete_done(), busy_poll_stop() and
> napi_suspend_irqs() start it without owning the napi and can do so
> right after the cancel.  netif_napi_del() only waits for that start to
> finish:
>
>   Task A (epoll_wait)                  Task B (queue reset)
>   napi_suspend_irqs()
>     rcu_read_lock()
>     napi =3D napi_by_id(id)
>                                        napi_disable_locked(napi)
>                                          hrtimer_cancel(&napi->timer)
>                                          napi_hash_del(napi)
>                                        netif_napi_del_locked(napi)
>                                          synchronize_net()
>                                          /* waits for Task A */
>     hrtimer_start(&napi->timer)
>     rcu_read_unlock()
>                                        kfree(rq)
>                                          /* timer still queued */
>
> With netdevsim and debug objects:
>
>   [    3.073483] ODEBUG: free active (active state 0) object: 00000000150=
4358f object type: hrtimer hint: napi_watchdog+0x0/0xa0
>   [    3.073515] WARNING: lib/debugobjects.c:629 at debug_print_object+0x=
1a4/0x3b0, CPU#0: napitimer/66
>   [    3.079603] CPU: 0 UID: 0 PID: 66 Comm: napitimer Tainted: G        =
W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
>   [    3.084822] RIP: 0010:debug_print_object+0x1ae/0x3b0
>   ...
>   [    3.103822] Call Trace:
>   [    3.104408]  <TASK>
>   [    3.105933]  debug_check_no_obj_freed+0x496/0x5f0
>   [    3.109988]  kfree+0x33a/0x510
>   [    3.110715]  netdev_rx_queue_reconfig+0x357/0x580
>   [    3.111780]  netdev_rx_queue_restart+0x8f/0xc0
>   [    3.113924]  nsim_qreset_write+0x24d/0x350
>   [    3.117832]  full_proxy_write+0x109/0x1d0
>   [    3.118741]  vfs_write+0x1e3/0x1250
>   [    3.124758]  __x64_sys_pwrite64+0x18c/0x250
>   [    3.129645]  do_syscall_64+0xfb/0x590
>   [    3.131385]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Without debug objects, napi_watchdog() later runs on freed memory.
>
> After napi_disable() and a grace period none of the three can reach the
> napi anymore.  Two need SCHED, which napi_disable() keeps, and
> napi_suspend_irqs() needs the napi hash, which napi_disable() removed it
> from.  So cancel the timer again after the grace period that
> netif_napi_del() already waits for, and in free_netdev(), where
> unregister has already waited for one.  With the fix, debug objects
> don't report a freed active timer anymore.
>
> This bug was identified and confirmed with the help of a deterministic
> hypervisor currently under development.  The C reproducer below however
> hits it within about 1s.
>
> Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> Fixes: 3fcbecbdeb04 ("net: Add control functions for irq suspension")
> Fixes: 58e2330bd455 ("net: napi: Avoid gro timer misfiring at end of busy=
poll")
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---

Bug seems real, but could we prepare something generic (in the core).

> Drivers that call __netif_napi_del{,_locked}() and then their own
> synchronize_net() (eg netdevsim on close, veth, virtio_net, bnxt and
> gro_cells) need the same cancel.  I can send that separately.

The list is longer than that : bnx2x, enic, ixgbe, myri10ge, dpaa and
bnge also use __netif_napi_del{,_locked}(). I would rather not touch 11
drivers for a core implementation detail.

Also the free_netdev() part assumes napi_disable() was called before
the synchronize_net() in unregister_netdevice_many_notify(), which is
not guaranteed (ndo_uninit(), or remove() handlers calling
napi_disable() between unregister_netdev() and free_netdev()).

All callers of __netif_napi_del_locked() must already respect an RCU
grace period before freeing the napi, and the three hrtimer_start()
callers run under RCU or with BH disabled.

So I think we can solve this in the core, with a store-buffer
pairing on NAPI_STATE_LISTED: the arming side re-checks LISTED after
hrtimer_start(), and __netif_napi_del_locked() cancels the timer after
clearing LISTED. One of the two must see the other.

Something like (untested):

/* Callers do not own @n, which can be deleted concurrently.
 * Pairs with test_and_clear_bit(NAPI_STATE_LISTED)
 * in __netif_napi_del_locked().
 */
static void napi_timer_start(struct napi_struct *n, unsigned long timeout)
{
        hrtimer_start(&n->timer, ns_to_ktime(timeout),
                      HRTIMER_MODE_REL_PINNED);
        smp_mb();
        if (unlikely(!test_bit(NAPI_STATE_LISTED, &n->state)))
                hrtimer_try_to_cancel(&n->timer);
}

And in __netif_napi_del_locked() :

        if (!test_and_clear_bit(NAPI_STATE_LISTED, &napi->state))
                return;

        /* Full barrier implied by test_and_clear_bit()
         * pairs with napi_timer_start().
         */
        hrtimer_cancel(&napi->timer);

napi_complete_done(), busy_poll_stop() and napi_suspend_irqs() would
use napi_timer_start().

If hrtimer_try_to_cancel() fails, napi_watchdog() is running, either
from hard irq or softirq context. It does not rearm the timer, and the
grace period the caller of __netif_napi_del_locked() has to observe
before freeing the napi also waits for it.

A timer armed between napi_disable() and __netif_napi_del_locked()
is harmless : napi_watchdog() can not grab NAPI_STATE_SCHED.

This removes the need for the 'listed' dance in netif_napi_del() and
the netdev_napi_exit() change, and covers all drivers.

The extra smp_mb() is only paid when the timer is armed, next to
an hrtimer_start() which is already much more expensive.

Can you give this a try with your reproducer ?

Thanks.
