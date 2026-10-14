Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92C47534D;
	Wed, 14 Oct 2026 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969541; cv=none; b=qudZ5r68pPFf0O9WwWaPD4lUOTrpxrwSsEIIAeGRrVzt2BCP1erpqeUMIcQukNLySD0VbcFUTh0zL8xIcrt/R5Wq7mGjbwIFuDQ3hCcGPZNlpVAs+cFZ1a7lHBp6mpzEU30k7D5/79GXTTUKNFxQr87hf21zajKT8V0RW0WV+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969541; c=relaxed/simple;
	bh=oXP9RfQP7ZCXetexWkZleaNten6hptnRIwVEnY8cRNQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6X87v4h1taA3XY8faz3mRZFjct7ey1w9DZpkSMsm/oyvwOcKrsDnPYFqc/AFTAxRdSNAC8XiaOue4B1xcWtotsvMZa//txyQ7mDMrasHsE+YCRW6jEOqw6M7qo/IF7p0Epx6kuX4V7qXnwrKzpia81+6LpVGMEVzjmzDLOlmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5CF0ojV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5CF0ojV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF97A1F000FF;
	Wed, 14 Oct 2026 09:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791969539;
	bh=5oVNaqQ+9r1SeT3IMoMHRZ4Nb1DIjFvbxB0+bWgzA6I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l5CF0ojVCLTDgHLpmAED527CpABejMd+LQIOm5pSYLeaA+Wdyb4YX79Af6waL5VU+
	 HwPCU2uscbMysOcFhlm4cyVUOTqmPRHzWWYHbDetLG04gUWbksI6oK6/cuLgqz3qNA
	 LPBkS1mRsTwlf+mEHj7cj6RDbLky8ZZyqOvo6d/SmzydQcu+SKsd9EJ9gpU1ee7nyV
	 WwLK7BGqH04Ied4ANUWOepddr0DC1RrTvUwyZiufqjcsR9pxiCYzCunHX1RpoRKfmh
	 B6/pqvPcRIM85LJvs2VPFE84tbByn0JgbwGIty2ISmC9s0S/rtKXmeYC3v3mrn9G/b
	 wXI6xyijqqNkA==
Subject: Re: [PATCH net v3] net: tun: fix race condition between tun_attach
 and tun_get_user with XDP
From: netdev-bot+sashiko@kernel.org
To: xietangxin@h-partners.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, huyizhen2@huawei.com,
 gaoxingwang1@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 09:18:58 +0000
Message-ID: <179196953831.434549.15573271551678509284@kernel.org>
In-Reply-To: <20261013083739.862074-1-xietangxin@h-partners.com>
References: <20261013083739.862074-1-xietangxin@h-partners.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: tun_xdp_one() still has the sequence the
  Fixes: commit added.
- [High] The new detached check is a lockless time-of-check/time-of-use
  test, so it does not close the race it targets.
- [Medium] The commit message presents the new `if
  (unlikely(tfile->detached)) { err = -EBUSY; goto free_skb; }` in…
- [Medium] Fix (b) uses `tfile->detached` as a publish flag: clearing it
  is meant to tell readers that real_num_rx_queues has already grown.
- [Medium] net: tun: incomplete fix leaves detached fd race unhandled in
  non-XDP/non-NAPI fallback path

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but writes on a
  detached, non-NAPI queue that skip the new guard still record the…
- [Medium] This problem wasn't introduced by this patch, but
  tun_set_real_num_queues() (drivers/net/tun.c:526-530) discards the…

--

net: tun: fix race condition between tun_attach and tun_get_user with XDP

This patch reorders tun_attach() so that tfile->tun is published, and a
detached tfile is re-enabled, only after tun_set_real_num_queues() has
updated real_num_rx_queues. It also adds a tfile->detached check to the
skb_xdp branch of tun_get_user(). The goal is to stop a stale queue index
from reaching netif_get_rxqueue() through do_xdp_generic().

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 242899f7fd071..dcab0aba6705c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -811,11 +808,16 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  	 * initialized tfile; otherwise we risk using half-initialized
>  	 * object.
>  	 */
> -	if (publish_tun)
> -		rcu_assign_pointer(tfile->tun, tun);
>  	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
>  	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
>  	tun_set_real_num_queues(tun);

[Severity: Medium]
This isn't a bug introduced by this patch, but tun_set_real_num_queues()
ignores both return values:

static void tun_set_real_num_queues(struct tun_struct *tun)
{
	netif_set_real_num_tx_queues(tun->dev, tun->numqueues);
	netif_set_real_num_rx_queues(tun->dev, tun->numqueues);
}

On a registered device, netif_set_real_num_rx_queues() calls
net_rx_queue_update_kobjects(). If rx_queue_add_kobject() fails there
(for example with -ENOMEM), it returns before dev->real_num_rx_queues is
updated.

tun_attach() still publishes the tfile with queue_index set to the old
numqueues and returns success. With an XDP program attached, could a later
write() then reach netif_get_rxqueue() with index == real_num_rx_queues and
hit the same WARN_ONCE? The reordering in this patch doesn't affect that
path.

> +	if (publish_tun)
> +		rcu_assign_pointer(tfile->tun, tun);
> +
> +	if (tfile->detached) {
> +		tun_enable_queue(tfile);
> +		tun_napi_enable(tfile);
> +	}

[Severity: Medium]
Is there enough memory ordering here for fix (b)? Clearing tfile->detached
now tells readers that real_num_rx_queues has already grown. On re-attach
the stores are:

tun_attach()
  tun_set_real_num_queues()
    netif_set_real_num_rx_queues()
      dev->real_num_rx_queues = rxq;     /* plain store */
  rcu_assign_pointer(tfile->tun, tun);   /* unchanged value on re-attach */
  tun_enable_queue()
    tfile->detached = NULL;              /* plain store */

The smp_store_release() in rcu_assign_pointer() orders earlier accesses
only against that one store. Nothing stops the later detached = NULL store
from becoming visible before the real_num_rx_queues store. On TUNSETQUEUE
re-attach, the release also writes the pointer value readers already have.

On the reader side, tun_get_user() loads tfile->detached with a plain
access, with no READ_ONCE() or smp_load_acquire(). A control dependency
does not order the later load of dev->real_num_rx_queues in
netif_get_rxqueue().

On a weakly ordered CPU such as arm64, can a reader see detached == NULL
together with the old real_num_rx_queues while queue_index already has the
new value, and still hit the WARN? KCSAN would also flag these unannotated
concurrent accesses.

Would this need a release/acquire pair on detached, or a check inside the
RCU section that the detach path already waits for?

>  out:
>  	return err;
>  }
> @@ -1960,6 +1962,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		struct bpf_prog *xdp_prog;
>  		int ret;
>  
> +		if (unlikely(tfile->detached)) {
> +			err = -EBUSY;
> +			goto free_skb;
> +		}
> +

[Severity: Medium]
Does the fallback delivery branch need the same protection? On an fd
opened without IFF_NAPI and with no XDP program, the skb is delivered
through tun_rx_batched() or netif_rx(). The napi_enabled branch
rechecks tfile->detached under queue->lock, but this branch has no
detached check at all.

The new check above does run in this case, because skb_xdp stays 1
when tun->xdp_prog is NULL. However, it is a plain load taken before
rcu_read_lock(). synchronize_net() in __tun_detach() does not wait for
a writer that has passed the check but has not yet entered the RCU
section:

CPU 1 (write, no XDP, no NAPI)    CPU 0 (TUNSETQUEUE detach)
sees detached == NULL
<preempted>
                                  __tun_detach()
                                    numqueues--
                                    tun_disable_queue()
                                    synchronize_net()
                                    tun_set_real_num_queues()
rcu_read_lock()
tun_rx_batched()
  skb_record_rx_queue(skb, tfile->queue_index)
  netif_receive_skb()
    get_rps_cpu()
      // index >= real_num_rx_queues -> WARN_ONCE

The detached tfile keeps its old queue_index. If it was the last
active queue, that index now equals the reduced real_num_rx_queues.
When RPS is configured, get_rps_cpu() does the same check as
netif_get_rxqueue():

	if (unlikely(index >= dev->real_num_rx_queues)) {
		WARN_ONCE(dev->real_num_rx_queues > 1,

So path 3 from the commit message can still trigger the same warning
when real_num_rx_queues > 1, and a panic with panic_on_warn. The
netif_rx() branch reaches get_rps_cpu() the same way.

Could the detached check be done inside the rcu_read_lock() section
that covers delivery instead? That would cover every branch, not just
skb_xdp, and would order it against synchronize_net() in
__tun_detach().

[Severity: Medium]
Should this check apply only when an XDP program is attached? It runs
before tun->xdp_prog is read, and skb_xdp doesn't mean that an XDP program
will run. tun_get_user() initializes it to 1:

	int skb_xdp = 1;

and tun_build_skb() also sets it to 1 when there is no program:

	if (hdr->gso_type || !xdp_prog) {
		*skb_xdp = 1;

So with no XDP program at all, every write() on a queue detached with
TUNSETQUEUE(IFF_DETACH_QUEUE) now fails with -EBUSY. Before this patch, a
non-NAPI tun accepted those writes, and only the napi_enabled branch
returned -EBUSY.

The behavior is also inconsistent. With a native XDP program attached,
small non-GSO writes built by tun_build_skb() get *skb_xdp = 0. They skip
this check and are still delivered on the detached queue through
tun_rx_batched().

The commit message describes this as an XDP fix. If only the XDP case is
intended, could the check move inside the if (xdp_prog) block? If the
wider change is intended, should the commit message going to stable say
so?

These drops also jump to free_skb, which skips
dev_core_stats_rx_dropped_inc(), so they aren't counted anywhere.

[Severity: High]
Does this lockless check close the race? The queue_index load and the
detached load both happen before local_bh_disable() and rcu_read_lock(),
so nothing orders them against detach or re-attach:

tun_get_user()
    skb_record_rx_queue(skb, tfile->queue_index);   /* load 1 */
    ...
    if (unlikely(tfile->detached))                  /* load 2 */
    ...
    local_bh_disable();
    rcu_read_lock();
    ...
    do_xdp_generic()

For path 3 in the commit message (detach):

CPU 1 (write)                     CPU 0 (TUNSETQUEUE detach)
records queue_index = N-1
sees detached == NULL
                                  __tun_detach()
                                    numqueues--
                                    tun_disable_queue()
                                    synchronize_net()
                                    tun_set_real_num_queues()
                                      real_num_rx_queues = N-1
rcu_read_lock()
do_xdp_generic()
  netif_get_rxqueue()
  // N-1 >= N-1 -> WARN

CPU 1 isn't inside an RCU read-side section yet, so synchronize_net()
doesn't wait for it.

For path 2 (re-attach), the reader loads queue_index before detached, but
tun_attach() stores them in the opposite order. Take queues A0 B1 C2 D3.
Detach D (its queue_index stays 3), then detach C (real_num_rx_queues
becomes 2):

CPU 1 (write on D's fd)           CPU 0 (re-attach D)
loads queue_index = 3
                                  tfile->queue_index = 2
                                  real_num_rx_queues = 3
                                  tfile->detached = NULL
loads detached == NULL
do_xdp_generic()
  netif_get_rxqueue()
  // 3 >= 3 -> WARN

This only relies on program order, so it can happen on x86 too.

A tfile that was never detached has the same problem. __tun_detach()
renumbers the remaining ntfile under consumer_lock:

		ntfile->queue_index = index;

tun_get_user() reads queue_index without that lock and outside RCU, so a
writer on ntfile can record the old numqueues - 1 and then see the reduced
real_num_rx_queues. The detached check doesn't cover this case.

Would queue_index have to be read and validated (or recorded) inside the
same RCU/BH section as do_xdp_generic() to close these windows?

[Severity: High]
Does tun_xdp_one() need the same guard? The Fixes: commit 3fe260e00cd0
added skb_record_rx_queue() before do_xdp_generic() in both tun_get_user()
and tun_xdp_one(). This patch adds the detached check only to
tun_get_user():

drivers/net/tun.c:tun_xdp_one() {
    ...
	skb_record_rx_queue(skb, tfile->queue_index);

	if (skb_xdp) {
		ret = do_xdp_generic(xdp_prog, &skb);
    ...
}

skb_xdp is set there when xdp_prog is non-NULL and gso->gso_type is
non-zero. vhost-net reaches this path through:

vhost_tx_batch()   /* .type = TUN_MSG_PTR */
  tun_sendmsg()
    tun_get(tfile)  /* succeeds, tfile->tun not cleared when clean=false */
    tun_xdp_one()
      skb_record_rx_queue(skb, tfile->queue_index)
      do_xdp_generic()
        netif_get_rxqueue()

Could a vhost-net GSO frame on a queue that was just detached with
TUNSETQUEUE (path 3), or one being re-attached (path 2), still trigger the
netif_get_rxqueue() WARN?

Keeping detached non-NULL during re-attach only helps readers that check
it. tun_xdp_one() checks detached only in the napi_enabled branch, after
XDP has already run.

[Severity: Medium]
This is a pre-existing issue, but writes on a detached non-NAPI queue that
skip this guard still record the stale queue_index and pass the skb to the
stack. With native XDP attached, a non-GSO frame built by tun_build_skb()
(*skb_xdp = 0) that returns XDP_PASS goes to tun_rx_batched():

	skb_record_rx_queue(skb, tfile->queue_index);
	netif_receive_skb(skb);

When RPS is in use, get_rps_cpu() has the same check:

	if (unlikely(index >= dev->real_num_rx_queues)) {
		WARN_ONCE(dev->real_num_rx_queues > 1,

Can that WARN_ONCE fire when real_num_rx_queues > 1 and the detached
queue's index is beyond the reduced count? Because the new check rejects
most detached writes made without XDP, the native-XDP build_skb path is
the one that still gets here.

>  		local_bh_disable();
>  		rcu_read_lock();
>  		xdp_prog = rcu_dereference(tun->xdp_prog);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013083739.862074-1-xietangxin%40h-partners.com
