Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4A3E451B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094599; cv=none; b=sdO9GzOCQFpN+yva0BIet6l047PiteMu8+Kg4wLtYrWvlpexyo6g6H13U8+eIULcO3XrZnfK/tPvnFmKGvV+9rebg6pKaqyPFmlyxuZLXa68A0CGW4c1R83LcSkcKzaJ+TJAJ+RwEtuDbFHwxG5bU5cURHhpy92mEOSgwL5zL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094599; c=relaxed/simple;
	bh=eMDB4+Rog33C6z1sxyWF82wTb32/5raUetz7oJgdc14=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mDax3ChQSFnuQYrZgFp5SZKplcQt44RDXXF9p+xLxufVgpzi53DUdRyPi++Vy/36ebvuE5N8ef+dUrBpPOur997KUchliHW0RI0WxdLqJIygvwU3N0FM7FPy3v8E0wYf/kjAKVioAIja8n0msQuggsP0R7GU7jdhQ/Gr5LQTRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz10t1789094530td132978e
X-QQ-Originating-IP: Z3+3OYsh9S5Jf9saJq2Qx4RfaE7c4n7k2TvNB/3tCYs=
Received: from smtpclient.apple ( [36.24.96.35])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Sep 2026 10:42:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17674663857577835029
EX-QQ-RecipientCnt: 11
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v5] net: Wangxun: protect ring accesses with RCU
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <178903448885.219967.11444647645606742302@kernel.org>
Date: Fri, 11 Sep 2026 10:41:58 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E48BFD39-2AD5-4DAB-B81E-7495D295F011@net-swift.com>
References: <20260909090005.79368-1-mengyuanlou@net-swift.com>
 <178903448885.219967.11444647645606742302@kernel.org>
To: netdev-bot+sashiko@kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OW7dgECIbKRAxBoTYYGSKIpMYpr2YDdWzjFbs6fNzggA0YyNFZGB9EK4
	IwZPnFmBRudMMzLyNqKqjzG2MONEkRQ1ZAYUY83uidoTflYbsRe2zS50bIU34R1e79lwKOd
	Z0RUQorpUNL6MJM2hJZU+FZpjjm/xYk13OTpDl2hYW9VeDtsh2Lw8UOKAzRHDxzyff97NN/
	hPLAWdPWQgsp6G5pNXX312em9jj7r20pX0Frm7VSE0goeOd02Zn8h8YQiRbNniRwCxjevag
	A9VR9nedCSiYly66vvbire6FNQw5rT0ehQzUyv3qigW5JHVE6BLG7r38SkDIoWkjrmzLJlm
	66f8KVWcZMLcNQNhC92gRcxwKrKbdaK6dmDGJhwVPg3cNcPDBnl8M8Lz5JPlto4TBMQgNUI
	9Cb75feQ9NDT7uRtZNQ3BAdRYR3B67qzMxYoCSIMC2y+CR5eYWqCZaooWeIrArAnhZvfkFf
	JfNcK3DRkSYAc+KJfEytTfGJ+QGMmMH7XDWGMfPjQ3u7a8G7QNkRBfJ5222ZqLBdxUToZRY
	N6D883CJgLXHtbIPl8UUrnu5BwOs6f9/aWzKywReXURvZYJ5djK5ZamJAPSjq3dZb2CCZVQ
	dMk9fVudV2C2utIH435cTIwowgEz3TgoAlfnJQP/OkQn3FaScUneYQMVrHKqRODeK/6xbpD
	YBuEnNq6gxXlVAqIj/N0ENQxdy0e+jKGABi+A+nlB0vW94OFZGUCuDmrLqm+hfuB8OQV0Vz
	WvTqwLJwQTx1FVFPn2qqHzGE1J/oSi+8tCF+2NVxdieael/+PUtnYOj0PA+JSkBhjNo4D4G
	tD4rtLXLp0eogLzrQUda+rAIPsBKovkkfclH8aoLmKRs2pnpGoXviT44mudb8vunPUZzodq
	NalWLeN46Tr853afh2MpZ+tC2dxSufwUXn2bgP55dSyvU9CfF1DrF4aVC9kNv7uFZFcDMBU
	8Yqn5AVAOkNDTCOlL2zrrjH5OFIjVwN+HbalHB0bEtqM/z3iaaqapD0R84JwtvXi0uNhVru
	OLPDokzJNdiVe4xEtZjOXL/3NZxlisVkG5cD7cVOjs56falvJD9QNdoKcTZ7Odl2PaVw4D5
	0o/LH5SAkw4pWo0Dl6oqxc=
X-QQ-XMRINFO: MPJ6Tf5t3I/ytltQNbdVib889w8ymTSdLA==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=8810=E6=97=A5 =
18:01=EF=BC=8Cnetdev-bot+sashiko@kernel.org =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 3 (2) =C2=B7 Low: 1
>=20
> - [High] wx_xmit_frame() now guards against wx->tx_ring[r_idx] being =
NULL
>  during teardown, but the line immediately above still does `if =
(r_idx=E2=80=A6
> - [Medium] The commit body states that the pre-patch code can produce
>  "NULL pointer dereferences or Use-After-Free (UAF) issues" when=E2=80=A6=

> - [Medium] wx_xmit_frame() now reads the newly __rcu-annotated ring
>  pointer with the classic rcu_dereference(), but it is the=E2=80=A6
> - [Medium] Bypassing lockdep validation by passing `1` as the lock
>  condition to `rcu_dereference_protected()`.
> - [Low] The commit message claims that during "interface stop" ring
>  pointers "can be cleared to NULL and freed asynchronously via=E2=80=A6
>=20
> Pre-existing issues:
> - [High] wxvf_suspend() (wx_vf_common.c:14-24), also used by
>  wxvf_shutdown(), only does netif_device_detach() and then=E2=80=A6
> - [Medium] ngbe_set_ringparam() (ngbe_ethtool.c) and
>  txgbe_set_ringparam() (txgbe_ethtool.c) initialise err to 0, call=E2=80=
=A6
> - [Medium] ngbe_setup_tc() (ngbe_main.c:620-645) and txgbe_setup_tc()
>  (txgbe_main.c:611-635) close the running device, destroy the =
interrupt=E2=80=A6
>=20
> --
>=20
> net: Wangxun: protect ring accesses with RCU
>=20
> This annotates wx->tx_ring[] and wx->rx_ring[] with __rcu, converts =
the
> lockless readers to rcu_dereference() inside rcu_read_lock() sections =
with
> NULL checks, publishes and clears the slots with rcu_assign_pointer(), =
and
> uses rcu_dereference_protected() in the control paths.
>=20
> A couple of questions about the changelog and the converted call sites
> below.
>=20
> Two notes on the commit message first.
>=20
>> Concurrency between interface reconfiguration and background tasks =
(such
>> as service tasks, dev_get_stats, or PTP watchdogs) can result in NULL
>> pointer dereferences or Use-After-Free (UAF) issues when accessing
>> per-queue structures.
>=20
> [Severity: Medium]
> The v5 changelog says the description was reworded "to suit net-next =
rather
> than a bug fix" and that the Fixes: tag was dropped, but the text =
above
> still describes a real crash in shipped kernels.
>=20
> Before this patch wx_update_stats() dereferenced wx->rx_ring[i] and
> wx->tx_ring[i] unconditionally after only a non-atomic gate:
>=20
> if (test_bit(WX_STATE_DOWN, wx->state) ||
>    test_bit(WX_STATE_RESETTING, wx->state))
> return;
>=20
> and it is reached from wx_get_stats64(), the ndo_get_stats64 callback,
> which dev_get_stats() calls without RTNL (for example from =
/proc/net/dev
> readers).
>=20


> Meanwhile wx_free_q_vector() NULLs the slots and hands the containing
> q_vector to kfree_rcu() during ethtool -L / setup_tc, and the =
pre-existing
> READ_ONCE() plus NULL check already in wx_get_stats64() suggests the =
array
> was known to be observable mid-teardown.
>=20
> Since the state test is a check-then-use rather than mutual exclusion, =
is
> the affected part of this change actually a fix that stable trees =
need,
> and would a Fixes: tag be appropriate so backport tooling can find it?

This patch involves a large amount of code and commits, and it is not =
necessarily
an issue that will definitely be triggered.
I prefer to rework it for net-next instead.

>=20
>> During queue teardown, interface stop, or channel reconfiguration =
(e.g. via
>> ethtool -L), ring pointers in wx->rx_ring[] and wx->tx_ring[] can be
>> cleared to NULL and freed asynchronously via kfree_rcu().
>=20
> [Severity: Low]
> Is "interface stop" accurate here? The ndo_stop implementations
> ngbe_close(), txgbe_close() and wxvf_close() bring the device down and
> release descriptor resources through =
wx_free_resources()/wx_free_irq(),
> but none of them calls wx_clear_interrupt_scheme(), so the ring array
> stays published and no q_vector is handed to kfree_rcu().
>=20
> Only interrupt-scheme teardown clears the slots:
>=20
> wx_clear_interrupt_scheme()
> wx_free_q_vectors()
> wx_free_q_vector()
>=20
> which is reached from ngbe_setup_tc()/txgbe_setup_tc(), PCI remove,
> shutdown, suspend and the probe error paths, rather than from a plain
> interface stop.


>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>> index ed5aad7857bd..9f90aa92f840 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>> @@ -1714,7 +1714,12 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
>>=20
>> if (r_idx >=3D wx->num_tx_queues)
>> r_idx =3D r_idx % wx->num_tx_queues;
>=20
> [Severity: High]
> Can this modulo still divide by zero in the same teardown window the =
new
> NULL check is meant to cover?
>=20
> wx_free_q_vectors() zeroes the counts before the ring slots are =
cleared:
>=20
> wx->num_tx_queues =3D 0;
> wx->num_rx_queues =3D 0;
> wx->num_q_vectors =3D 0;
>=20
> while (v_idx--)
> wx_free_q_vector(wx, v_idx);
>=20
> So a concurrent transmit observes num_tx_queues =3D=3D 0 strictly =
before it can
> observe a NULL ring. With count 0 the unsigned comparison is always =
true
> and r_idx % 0 raises a divide error before the guard below is reached.
>=20
> Is the window open on the VF suspend/shutdown path? wxvf_suspend() =
only
> does:
>=20
> netif_device_detach(wx->netdev);
> wx_clear_interrupt_scheme(wx);
>=20
> netif_device_detach() stops the queues without taking the per-txq =
locks, so
> an xmit already inside wx_xmit_frame() on another CPU keeps running. =
The PF
> paths differ because ngbe_close()/txgbe_close() run =
netif_tx_disable(),
> which takes every txq lock and drains in-flight transmits.
>=20
> Would snapshotting the count once with READ_ONCE() and returning early =
when
> it is 0, or keying the whole decision off the ring pointer, be a =
better fit
> than adding the NULL check after the division?

I can check the release order in the "we_free_q_vectors".
However, this is not the issue I need to address in this patch for =
wx_ring.


>> - tx_ring =3D wx->tx_ring[r_idx];
>> + tx_ring =3D rcu_dereference(wx->tx_ring[r_idx]);
>=20
> [Severity: Medium]
> Should this be rcu_dereference_bh()? wx_xmit_frame() is the
> ndo_start_xmit callback and runs inside rcu_read_lock_bh() taken by
> __dev_queue_xmit():
>=20
> net/core/dev.c:__dev_queue_xmit() {
> /* Disable soft irqs for various locks below. Also
> * stops preemption for RCU.
> */
> rcu_read_lock_bh();
> ...
> }
>=20
> rcu_dereference(p) expands to rcu_dereference_check(p, 0), whose =
condition
> is rcu_read_lock_held(), and that returns lock_is_held(&rcu_lock_map) =
while
> rcu_read_lock_bh() acquires rcu_bh_lock_map instead.
>=20
> With CONFIG_PROVE_RCU=3Dy, does the first packet on a wangxun NIC =
produce a
> "suspicious rcu_dereference_check() usage" splat from the transmit =
path?
> This also looks like the only reader converted here that has no
> rcu_read_lock() of its own, now that struct wx carries:
>=20
> struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
> struct wx_ring __rcu *rx_ring[64];
>=20

> wx_xmit_frame() is the
> ndo_start_xmit callback and runs inside rcu_read_lock_bh() taken by
> __dev_queue_xmit():

Should be rcu_dereference_bh().


>> +
>> + if (unlikely(!tx_ring)) {
>> + dev_kfree_skb_any(skb);
>> + return NETDEV_TX_OK;
>> + }
>>=20
>> return wx_xmit_frame_ring(skb, tx_ring);
>> }
>=20
> [ ... ]
>=20
>> @@ -2245,10 +2250,10 @@ static void wx_free_q_vector(struct wx *wx, =
int v_idx)
>> struct wx_ring *ring;
>>=20
>> wx_for_each_ring(ring, q_vector->tx)
>> - wx->tx_ring[ring->queue_index] =3D NULL;
>> + rcu_assign_pointer(wx->tx_ring[ring->queue_index], NULL);
>>=20
>> wx_for_each_ring(ring, q_vector->rx)
>> - wx->rx_ring[ring->queue_index] =3D NULL;
>> + rcu_assign_pointer(wx->rx_ring[ring->queue_index], NULL);
>>=20
>> wx->q_vector[v_idx] =3D NULL;
>> netif_napi_del(&q_vector->napi);
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but the VF suspend path =
reaches
> this function without any prior quiesce, and the RCU conversion makes =
the
> resource side unrecoverable.
>=20
> wxvf_suspend() in wx_vf_common.c, also used by wxvf_shutdown(), does =
only:
>=20
> netif_device_detach(wx->netdev);
> wx_clear_interrupt_scheme(wx);
> pci_disable_device(pdev);
>=20
> There is no wxvf_down(), no wx_free_irq(), no timer_delete_sync() /
> cancel_work_sync(), and no wx_free_resources().
>=20
> Does this free the q_vector while its users are still live? The NAPI
> instance is still enabled, the DIM work items are only disabled by
> wx_napi_disable_all(), the service timer is still armed from
> wxvf_up_complete(), and the MSI-X handlers are still requested:
>=20
> wx_msix_clean_rings() {
> struct wx_q_vector *q_vector =3D data;
>=20
> if (q_vector->rx.ring || q_vector->tx.ring) {
> napi_schedule_irqoff(&q_vector->napi);
> ...
> }
>=20
> That runs in hard-IRQ context, which the kfree_rcu() grace period does =
not
> synchronise against, and wx_reset_interrupt_capability() then calls
> pci_free_irq_vectors() with the handlers still installed.
>=20
> Does the same path also leak the ring memory? wx_free_q_vectors() =
zeroes
> num_tx_queues/num_rx_queues/num_q_vectors before this function NULLs =
the
> slots, so wx_free_all_tx_resources()/wx_free_all_rx_resources() would
> iterate zero queues afterwards and the dma_alloc_coherent() descriptor
> rings, the tx_buffer_info/rx_buffer_info arrays and the page pools =
become
> unreachable, with page_pool_destroy() never called.
>=20

Not for this patch.

> [ ... ]
>=20
>> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
>> index 1960f7154151..9e90702a5146 100644
>> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
>> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
>> @@ -37,9 +37,9 @@ static int ngbe_set_ringparam(struct net_device =
*netdev,
>>=20
>> if (!netif_running(wx->netdev)) {
>> for (i =3D 0; i < wx->num_tx_queues; i++)
>> - wx->tx_ring[i]->count =3D new_tx_count;
>> + rcu_dereference_protected(wx->tx_ring[i], 1)->count =3D =
new_tx_count;
>> for (i =3D 0; i < wx->num_rx_queues; i++)
>> - wx->rx_ring[i]->count =3D new_rx_count;
>> + rcu_dereference_protected(wx->rx_ring[i], 1)->count =3D =
new_rx_count;
>> wx->tx_ring_count =3D new_tx_count;
>> wx->rx_ring_count =3D new_rx_count;
>=20
> [Severity: Medium]
> This is a pre-existing issue, not something this patch introduces, but
> while touching these functions: ngbe_set_ringparam() and
> txgbe_set_ringparam() initialise err to 0 and then drop the return =
value
> of wx_set_ring():
>=20
> ngbe_down(wx);
>=20
> wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
> kvfree(temp_ring);
>=20
> ngbe_up(wx);
>=20
> wx_set_ring() returns the failures from wx_setup_tx_resources() and
> wx_setup_rx_resources(), and an Rx allocation failure can happen after =
the
> Tx rings and wx->tx_ring_count were already committed. Does ethtool -G
> then report success for a partially applied configuration?
>=20
> wx_set_ringparam_vf() captures and returns this value, so should the =
PF
> versions do the same?

Not for this patch.

>=20
>> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
>> index 855dc963c610..e45d7dfdc9f9 100644
>> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
>> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
>> @@ -406,7 +406,7 @@ static void ngbe_disable_device(struct wx *wx)
>> /* disable all enabled rx queues */
>> for (i =3D 0; i < wx->num_rx_queues; i++)
>> /* this call also flushes the previous write */
>> - wx_disable_rx_queue(wx, wx->rx_ring[i]);
>> + wx_disable_rx_queue(wx, rcu_dereference_protected(wx->rx_ring[i], =
1));
>=20
> [Severity: Medium]
> This is a pre-existing issue rather than something added here, but it =
is in
> the reconfiguration path the commit message names. ngbe_setup_tc() in =
this
> same file, and txgbe_setup_tc(), close the running device, destroy the
> interrupt scheme, and then ignore both return values:
>=20
> wx_init_interrupt_scheme(wx);
>=20
> if (netif_running(dev))
> ngbe_open(dev);
>=20
> return 0;
>=20
> If wx_alloc_q_vectors() fails it zeroes the queue counts:
>=20
> wx_alloc_q_vectors() {
> err_out:
> wx->num_tx_queues =3D 0;
> wx->num_rx_queues =3D 0;
> wx->num_q_vectors =3D 0;
> ...
> }
>=20
> so setup_tc re-opens a device with zero queues, ngbe_open()'s error is
> dropped, and __LINK_STATE_START stays set from the direct close/open =
calls.
> wx_set_channels() propagates only setup_tc's return value, so does
> ethtool -L report success while leaving the interface unusable, and =
with
> netif_running() true and num_tx_queues =3D=3D 0 does it also feed the =
modulo
> in wx_xmit_frame() discussed above?
>=20
> [ ... ]

Not for this patch.
>=20
>> @@ -2775,7 +2780,7 @@ void wx_clean_all_tx_rings(struct wx *wx)
>> int i;
>>=20
>> for (i =3D 0; i < wx->num_tx_queues; i++)
>> - wx_clean_tx_ring(wx->tx_ring[i]);
>> + wx_clean_tx_ring(rcu_dereference_protected(wx->tx_ring[i], 1));
>> }
>> EXPORT_SYMBOL(wx_clean_all_tx_rings);
>>=20
>=20
> [Severity: Medium]
> Every control-path conversion in this series passes a literal 1 as
> the condition argument, here and in wx_configure_tx(),
> wx_configure_rx(), wx_set_rx_buffer_len(), wx_fc_enable(),
> wx_cache_ring_rss(), wx_cache_ring_vmdq(), wx_set_ring(),
> wx_setup_all_{tx,rx}_resources(), wx_free_all_{tx,rx}_resources(),
> wx_configure_tx_vf(), wx_configure_rx_vf(), the three
> *_set_ringparam() variants, ngbe_disable_device(),
> txgbe_disable_device(), txgbe_add_ethtool_fdir_entry() and
> txgbe_fdir_filter_restore().
>=20
> rcu_dereference_protected(p, 1) makes the lockdep check
> unconditionally true, so it only casts away the __rcu annotation for
> sparse and asserts nothing at runtime. The commit message says these
> sites are "strictly guarded by outer locks (e.g. RTNL or dev state
> locks)", which is exactly the claim the condition argument exists to
> verify under CONFIG_PROVE_RCU. As written, a future caller that
> reaches wx_configure_tx() or wx_clean_all_tx_rings() without the
> outer lock held will not be caught by anything.
>=20
> Which lock is actually being relied on at these sites? The
> *_set_ringparam() paths hold wx->reset_lock and come in through
> ethtool, while wx_configure_tx()/wx_configure_rx() are also reached
> from the reset and open paths, so the answer may differ per call
> site. If a single predicate covers all of them, could the condition
> spell it out, for example lockdep_is_held(&wx->reset_lock) or a
> combination with lockdep_rtnl_is_held()? Where no such predicate
> exists, a short comment naming the lock that makes the access safe
> would at least tell the next reader why the bare 1 is there.
>=20
The possibility of ring access problems occurring at these locations is =
very low.
Does it make sense to add lockdep_is_held at every call site?


> --=20
> Sashiko AI review =C2=B7 =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909090005.79368-1=
-mengyuanlou%40net-swift.com
>=20

