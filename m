Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123704;
	b=IK0XLtJJLNIB/4ec6adZJEOiThGioidP8uovZrM321dAne856lDpQxy+elx33vzE6sTm
	 fu+XGvYC8zzLCPtQKQ3Q43OYxLk/FAxGTG2IXUT0rBkwnfwB8b4EyU4aBushiVNqrAa0D
	 e0kqmNJFT1eO4R2kubc++Krlm5XjG9lDXrI1n0/C+kwLTh9JpRUwZ/wlo3ErMQB1YgxQJ
	 A4gHDX2WR8SJeWb828tnoxqvsSxQi/G6G5uWJ780r0/h8yMybbuXP9rk/+6W72OI0UCFT
	 7lU0tqeNLNjVSkm7HRtmJ5roS7OCm04oS9i5PWQIaWxBAeTq4IlI5zfaacJ1XdgFIqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123704;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4WpAVW4dQFFNUVPt8gw1yfw7VZGL005KtRpAM//rOqg=;
	b=wnYx7YKio2Ks5/HVLUvIw9SnSZQ+Jl1VIKWiE3gt1XxTuFVXMFBU0Egi/QpNCRLTe9vO
	 +ebylzcC87NzPc+WwdELKyfTQexH/aazPQJDvK0jwkKCaoBQZMZ65H5lDAqG+PMNentX4
	 seodYv7j0PzdOVweEGmdNacuaYV7irB/SPoc4kA+98xV4oiZs6jL+4wEqibsVfSUmC2lZ
	 lkyhioVqRac9TTNyxpi0C1rMa/XG9KDc4drAhd5ru2jMZ8S9zXpBEtVUZ2JT9a8WCn8ic
	 aFCwVKviJig7d+6Q1a5q4mjQqS5v5le0oG9wA9HZhQ77q7fnhflICcDfTAk3siEe73g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwU1xQqt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFF606A31A;
	Tue, 27 Oct 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwU1xQqt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B0B1F01825;
	Tue, 27 Oct 2026 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123703;
	bh=4WpAVW4dQFFNUVPt8gw1yfw7VZGL005KtRpAM//rOqg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MwU1xQqtDM1414Zfv3cdteROwf++oS0GzkEpkMMOiwpIgE+q38ASAgcdozvKk7KWJ
	 K++l4Z34qebIRNkxZWC+xrY6TGX3POfH8xWeesXopsCcdaiWARC8YDqPmTNEr3HaQD
	 Y2yPm21v9rSos+K9juOBcczzkjw/ZYJztpLVy+ZfgudxgfLLB1YGzV3uqdjZF2wiuA
	 yM5uBSz6HLt0Lvli+wbdjLTmg8athj2S12iNBzBoGM5ibmrUVTsivLaEcrymEV6dWe
	 rnkMDd6K+9skLSE3fj6pEZNRy97joLANoKyDIpfq/rGh7wjIjbdRlY+Yl8sRNn7Dhy
	 TGM4GEB/ix3Iw==
Subject: Re: [PATCH net] net: wwan: mhi_wwan_ctrl: keep DTR drops and resend
 state when IP_CTRL binds
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 dnlplm@gmail.com, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 17:55:02 +0000
Message-ID: <179312370280.3134.15800465525418472440@kernel.org>
In-Reply-To: <20261023174113.2388353-1-peter.hunt@opengear.com>
References: <20261023174113.2388353-1-peter.hunt@opengear.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In drivers/net/wwan/mhi_wwan_ctrl.c, a DTR drop can still be
  hidden by a later raise when the retry that is pending is the retry of…
- [High] The patch queues the same dtr_work on two different workqueues.
- [High] mhi_wwan_ctrl_dtr_work() reads dtr_mdmbits twice.
- [Medium] When IP_CTRL is not bound, mhi_wwan_ctrl_send_dtr() returns 0
  at line 172 ('IP_CTRL not enumerated').
- [Medium] mhi_wwan_ctrl_probe() adds the port to mhi_wwan_port_list
  (line 394) only after wwan_create_port() (line 384) has registered the…
- [Low] Two existing comments in drivers/net/wwan/mhi_wwan_ctrl.c still
  describe latest-state-only delivery.

--

net: wwan: mhi_wwan_ctrl: keep DTR drops and resend state when IP_CTRL binds

This commit keeps a list of mhi_wwan_ctrl ports. When the IP_CTRL channel
binds, it resends the DTR/RTS state of every port that has already
signalled. It also records a pending DTR drop so that a later raise cannot
hide it, and uses mod_delayed_work() so that a new request runs the work
straight away.

> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index e3c2075889565..52b6d3677558a 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c

[ ... ]

> @@ -71,7 +76,10 @@ struct mhi_wwan_dev {
>  	 * changes is coalesced and only the final state has to get through
>  	 */
>  	unsigned int dtr_mdmbits;
> +	/* State to send for a DTR drop that a later raise would otherwise hide */
> +	unsigned int dtr_drop_mdmbits;
>  	struct delayed_work dtr_work;
> +	struct list_head port_node;
>  };

[Severity: Low]
This isn't a bug, but the dtr_mdmbits comment still says "only the final
state has to get through". The comment above mhi_wwan_ctrl_dtr_work() also
still says:

/* Send the latest DTR/RTS state. A full UL ring or a failed allocation is
 * retried shortly, with whatever state is latest by then, so the modem ends
 * up with the final state. Other errors mean the channel is going away.
 */

The work now sends dtr_drop_mdmbits before the latest state. On a
transient error it re-arms the pending drop and returns without sending
the latest state.

Should both comments be updated to match?

> @@ -197,6 +205,21 @@ static void mhi_wwan_ctrl_dtr_work(struct work_struct *work)
>  						    struct mhi_wwan_dev, dtr_work);
>  	int ret;
>  
> +	/* A DTR drop matters on its own, e.g. to hang up a modem set to AT&D2,
> +	 * so send it before the latest state if DTR has been raised again
> +	 */
> +	if (test_and_clear_bit(MHI_WWAN_DTR_DROP, &mhiwwan->flags) &&
> +	    READ_ONCE(mhiwwan->dtr_mdmbits) & TIOCM_DTR) {

[Severity: High]
Can a raise that lands between the two reads of dtr_mdmbits in
mhi_wwan_ctrl_dtr_work() still hide the drop?

Whether the drop is sent depends on this READ_ONCE(). The value actually
sent comes from a second READ_ONCE() further down. If DTR is still low at
the first read, the drop branch is skipped and DROP has already been
cleared:

CPU0 (dtr_work)                         CPU1
test_and_clear_bit(DROP) -> true
READ_ONCE(dtr_mdmbits) -> 0, skip
                                        mhi_wwan_ctrl_dtr_rts(DTR|RTS)
                                          drop = false
                                          WRITE_ONCE(dtr_mdmbits, DTR|RTS)
                                          mod_delayed_work(...)
send_dtr(READ_ONCE(dtr_mdmbits))
  sends DTR|RTS
requeued run: DROP clear, sends DTR|RTS

mhi_wwan_ctrl_dtr_rts() computes drop == false because the previous
requested state was already low. Nothing sets DROP again, so the modem
never sees DTR go low.

The worker is preemptible, and dtr_rts() can be called from open, close or
ioctl on any CPU.

Would a single snapshot of dtr_mdmbits, used for both the check and the
send, close this window?

> +		ret = mhi_wwan_ctrl_send_dtr(mhiwwan,
> +					     READ_ONCE(mhiwwan->dtr_drop_mdmbits));
> +		if (ret == -EAGAIN || ret == -ENOMEM) {
> +			set_bit(MHI_WWAN_DTR_DROP, &mhiwwan->flags);
> +			schedule_delayed_work(&mhiwwan->dtr_work,
> +					      msecs_to_jiffies(10));
> +			return;
> +		}
> +	}
> +
>  	ret = mhi_wwan_ctrl_send_dtr(mhiwwan, READ_ONCE(mhiwwan->dtr_mdmbits));
>  	if (ret == -EAGAIN || ret == -ENOMEM)
>  		schedule_delayed_work(&mhiwwan->dtr_work, msecs_to_jiffies(10));

[Severity: High]
What happens to the pending drop when the low state itself fails to send
here?

Suppose DTR high has been delivered and the port is closed with HUPCL:

mhi_wwan_ctrl_dtr_rts(0)
  sets MHI_WWAN_DTR_DROP, runs the work
mhi_wwan_ctrl_dtr_work()
  test_and_clear_bit(MHI_WWAN_DTR_DROP) -> DROP now clear
  dtr_mdmbits has no TIOCM_DTR, drop branch skipped
  mhi_wwan_ctrl_send_dtr(0) -> -EAGAIN (UL ring full) or -ENOMEM
  schedule_delayed_work(..., 10ms), DROP still clear

With -EAGAIN, mhi_queue() fails before any transfer descriptor is built, so
the low state never reaches the hardware.

Then suppose the port is reopened within 10ms.
mhi_wwan_ctrl_dtr_rts(DTR|RTS) compares against the last requested state,
which is 0, so drop is false. mod_delayed_work() runs the work at once,
and the work sends only DTR|RTS.

Doesn't this leave the modem going from high to high without seeing DTR
low? That is the "quick close and reopen while a retry was pending" case
the commit message describes as fixed.

Would keeping DROP set until a low state has actually been queued, or
tracking the last delivered state instead of the last requested one,
cover this case?

> @@ -209,9 +232,19 @@ static void mhi_wwan_ctrl_dtr_work(struct work_struct *work)
>  static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
>  {
>  	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
> +	bool drop = (READ_ONCE(mhiwwan->dtr_mdmbits) & TIOCM_DTR) &&
> +		    !(mdmbits & TIOCM_DTR);
>  
> +	if (drop)
> +		WRITE_ONCE(mhiwwan->dtr_drop_mdmbits, mdmbits);
>  	WRITE_ONCE(mhiwwan->dtr_mdmbits, mdmbits);
> -	schedule_delayed_work(&mhiwwan->dtr_work, 0);
> +	/* Publish the state before the flags the work tests */
> +	smp_mb__before_atomic();
> +	if (drop)
> +		set_bit(MHI_WWAN_DTR_DROP, &mhiwwan->flags);
> +	set_bit(MHI_WWAN_DTR_SET, &mhiwwan->flags);
> +	/* Run now, even if a retry is already pending */
> +	mod_delayed_work(system_wq, &mhiwwan->dtr_work, 0);
>  }

[Severity: High]
Is system_wq intended here? The retry paths in mhi_wwan_ctrl_dtr_work()
still use schedule_delayed_work(), which queues on system_percpu_wq:

include/linux/workqueue.h:schedule_delayed_work() {
	return queue_delayed_work(system_percpu_wq, dwork, delay);
}

In this tree these are separate workqueues, and system_wq is marked
deprecated:

kernel/workqueue.c:workqueue_init_early() {
    ...
	system_wq = alloc_workqueue("events", WQ_PERCPU | __WQ_DEPRECATED, 0);
	system_percpu_wq = alloc_workqueue("events", WQ_PERCPU, 0);
    ...
}

__queue_work() only keeps a work item on the pool where it is already
running if the workqueue matches:

kernel/workqueue.c:__queue_work() {
    ...
		if (worker && worker->current_pwq->wq == wq) {
    ...
}

So if a retry instance of dtr_work is running from system_percpu_wq and
mhi_wwan_ctrl_dtr_rts() queues it on system_wq, can two instances run at
once on different CPUs?

One effect would be out-of-order delivery. An older instance that read a
stale dtr_mdmbits before blocking on mhi_wwan_dtr_lock could send after
the newer one, leaving the modem in the old state.

The other is in mhi_wwan_ctrl_remove():

mhi_wwan_ctrl_remove()
  wwan_remove_port()
    wwan_port_drop_dtr_rts()
      mhi_wwan_ctrl_dtr_rts()
        mod_delayed_work(system_wq, ...)
  flush_delayed_work(&mhiwwan->dtr_work);
  disable_delayed_work_sync(&mhiwwan->dtr_work);
  kfree(mhiwwan);

flush_delayed_work() and disable_delayed_work_sync() only wait on the last
pool recorded for the work. Could kfree(mhiwwan) run while the older retry
instance is still using mhiwwan->mhi_dev, ->flags and ->dtr_work?

Before this patch every call site used schedule_delayed_work(). Would
using system_percpu_wq here and in mhi_wwan_dtr_probe() avoid both
problems, and also the deprecated workqueue warning?

[ ... ]

> @@ -357,6 +390,10 @@ static int mhi_wwan_ctrl_probe(struct mhi_device *mhi_dev,
>  
>  	mhiwwan->wwan_port = port;
>  
> +	mutex_lock(&mhi_wwan_dtr_lock);
> +	list_add(&mhiwwan->port_node, &mhi_wwan_port_list);
> +	mutex_unlock(&mhi_wwan_dtr_lock);
> +
>  	return 0;
>  };

[Severity: Medium]
Can the resend in mhi_wwan_dtr_probe() miss this port?

By this point wwan_create_port() has registered the character device, so
userspace can open the AT port before list_add() runs:

wwan_port_op_start()
  wwan_port_raise_dtr_rts()
    mhi_wwan_ctrl_dtr_rts()
      set_bit(MHI_WWAN_DTR_SET, ...)
      queues dtr_work
        mhi_wwan_ctrl_send_dtr() -> IP_CTRL not enumerated, returns 0

If mhi_wwan_dtr_probe() for the same controller runs its resend scan in
that window, the port is not yet on mhi_wwan_port_list. The state is then
never sent, and the wwan core does not signal again unless DTR or RTS
changes.

mhi_dev, flags and dtr_work are all set up before wwan_create_port().
Could the list_add() move ahead of wwan_create_port(), with a list_del()
on its error path?

[ ... ]

> @@ -449,6 +492,11 @@ static int mhi_wwan_dtr_probe(struct mhi_device *mhi_dev,
>  
>  	mutex_lock(&mhi_wwan_dtr_lock);
>  	list_add(&dtr->node, &mhi_wwan_dtr_list);
> +	/* Resend the state of ports that signalled DTR/RTS before IP_CTRL bound */
> +	list_for_each_entry(mhiwwan, &mhi_wwan_port_list, port_node)
> +		if (mhiwwan->mhi_dev->mhi_cntrl == dtr->cntrl &&
> +		    test_bit(MHI_WWAN_DTR_SET, &mhiwwan->flags))
> +			mod_delayed_work(system_wq, &mhiwwan->dtr_work, 0);
>  	mutex_unlock(&mhi_wwan_dtr_lock);

[Severity: Medium]
Can a drop requested while IP_CTRL was unbound be lost before this resend
runs?

While mhi_wwan_dtr is unbound, mhi_wwan_ctrl_send_dtr() returns 0 without
queueing anything:

	if (!ctrl_dev) {
		dev_dbg(&mhiwwan->mhi_dev->dev,
			"IP_CTRL not enumerated; DTR/RTS not signalled to modem\n");
		return 0;
	}

By then mhi_wwan_ctrl_dtr_work() has already cleared MHI_WWAN_DTR_DROP,
and it only sets the bit again for -EAGAIN or -ENOMEM. So a close (drop)
followed by a reopen (raise) while unbound leaves DROP clear.

After a rebind, this loop requeues the work, which sends only the latest
dtr_mdmbits. The modem sees just DTR high.

This resend appears to assume the modem keeps its last DTR state while
IP_CTRL is absent. If so, would it ever see the drop?

In that case the comment on MHI_WWAN_DTR_DROP ("a DTR drop is still to be
sent") would not be accurate either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023174113.2388353-1-peter.hunt%40opengear.com
