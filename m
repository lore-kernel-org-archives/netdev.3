Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94926656D;
	Sun, 11 Oct 2026 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745821; cv=none; b=NxzzD7ilpQ5T2N80U5eOwwquhqO3TfmAFath6LBFnTkAgwNH70UVSPSLxy3GMpd9kGCYgnoA5PldEkWaNkhjT716A1LvEixk+Bz94wNXXywpeZR9//NC9ArgaHIYQNGkVjxRfu4S30AlAJzNLyQF6LWHr0r+c1yxyNDeisOab8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745821; c=relaxed/simple;
	bh=qDvZvY3t7hPBznqwwJ+9XczPsawEOtlVdSajCz4MMMc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VoMzhDn+v2dbTVLtMi2nJ9XEk0DWLhnuHmrMlPHhYozirGSrnssXwMd/ZujhcyD73gCYUDGWcowlTMylJlEDhFUvNZbbLHEoW+A/Sh7urDo7Hez0h5UMRbrkUADcTQC4FP2Tk9DVg0yjPqDxT8LB1xvBeuVthB5M3Nf0RBzuUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+/4SCc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+/4SCc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561401F0089B;
	Sun, 11 Oct 2026 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791745820;
	bh=2vyZRcclnaItmGAKqgI1HPyUldWBjcsCTc7GSgZUYEU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c+/4SCc3fez9GSe4bV2mAmxQ4W2rLXhxk6ne92ehHUsVdVXKJzvwC+LJqLzu3w8S+
	 R+2QiU7ZCj0Kdhvlwoc9YsVRLtjEOIZzftFuv5DWxrfI1kTDP6jt8BPSpcnrAmQ7UB
	 cMd9G697S7tcSy8F8jPanCKaJ7R9y4bryfx2MR7aGeIEY776AZ2bZ/Bs5JY5QafhXa
	 PRhcdyh8Ry/PUno5a7GbyjAFinpadfz5vVxnV2Se/M8n6GMrK+Y0J5nx5DQA949iDu
	 JYpejDL2SI9Koa0s273vt6ihy9KffRrEfDRemrOgecgEsISXHhgyk/NWg1hIr8YEHl
	 JjL04K0eukjNw==
Subject: Re: [PATCH net-next v8 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS
 via the IP_CTRL channel
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 19:10:18 +0000
Message-ID: <179174581889.434549.17109268914009115980@kernel.org>
In-Reply-To: <20261007182238.1154851-3-peter.hunt@opengear.com>
References: <20261007182238.1154851-3-peter.hunt@opengear.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In drivers/net/wwan/mhi_wwan_ctrl.c, mhi_wwan_dtr_remove() calls
  mhi_unprepare_from_transfer() at line 448.
- [Medium] The driver keeps no record of DTR/RTS updates that have not
  yet reached the modem.
- [Medium] mhi_wwan_dtr_remove()
  (drivers/net/wwan/mhi_wwan_ctrl.c:448-454) relies on the comment's…

--

net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

This patch adds a second mhi_driver to mhi_wwan_ctrl that binds the
IP_CTRL MHI channel. It implements the wwan ->dtr_rts op by sending a
HOST_STATE message on the IP_CTRL channel of the same controller. A
single DL sink buffer stays queued on IP_CTRL, and a delayed work item
retries the requeue when it fails with -ENOMEM.

> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index a31d8540fbb85..feb9c03b6392b 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c

[ ... ]

> @@ -103,6 +134,61 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
>  	}
>  }
>  
> +/* Signal the modem's DTR/RTS lines over its own controller's IP_CTRL channel */
> +static int mhi_wwan_ctrl_send_dtr(struct mhi_wwan_dev *mhiwwan, unsigned int mdmbits)
> +{

[ ... ]

> +	if (!ctrl_dev) {
> +		dev_dbg(&mhiwwan->mhi_dev->dev,
> +			"IP_CTRL not enumerated; DTR/RTS not signalled to modem\n");
> +		return 0;
> +	}

[ ... ]

> +	ret = mhi_queue_buf(ctrl_dev, DMA_TO_DEVICE, dtr_msg, sizeof(*dtr_msg),
> +			    MHI_EOT);
> +	if (ret) {
> +		dev_dbg(&mhiwwan->mhi_dev->dev,
> +			"failed to queue DTR/RTS signal: %d\n", ret);
> +		kfree(dtr_msg);
> +	}
> +
> +	return ret;
> +}
> +
> +static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
> +{
> +	mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port), mdmbits);
> +}

[Severity: Medium]
The HOST_STATE update is dropped in these cases:

- mhi_queue_buf() fails here (-EAGAIN on a full UL ring, -EIO, -ENOMEM).
- No IP_CTRL entry is registered yet.

mhi_wwan_ctrl_dtr_rts() ignores the return value, and the wwan core has
already committed at_data.mdmbits.

Could TIOCMGET then report DTR as asserted when the modem never received
it? If so, the modem would hold back URCs until the next TIOCM* ioctl or
reopen.

A related case: mhi_wwan_dtr_probe() can register IP_CTRL after an AT
port is already open, for example after an unbind/rebind of the IP_CTRL
device. The port's current mdmbits are not replayed to the modem in that
case.

The commit message describes this as intended:

  Delivery is best-effort: at_data.mdmbits always reflects the committed
  userspace intent for TIOCMGET regardless of whether the IP_CTRL message
  was queued, and the next ioctl or open/close cycle will resynchronise
  the modem state.

Each TIOCMSET/TIOCMBIS/TIOCMBIC does resend the full bits. Would it still
be worth replaying the state from mhi_wwan_dtr_probe() for ports that are
already open, or retrying a failed send?

[ ... ]

> @@ -255,6 +342,118 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)

[ ... ]

> +static void mhi_wwan_dtr_remove(struct mhi_device *mhi_dev)
> +{
> +	struct mhi_wwan_dtr *dtr = dev_get_drvdata(&mhi_dev->dev);
> +
> +	mutex_lock(&mhi_wwan_dtr_lock);
> +	list_del(&dtr->node);
> +	mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +	mhi_unprepare_from_transfer(mhi_dev);
> +	/* No DL callbacks after unprepare, and a pending retry now fails on
> +	 * the disabled channel without rescheduling
> +	 */
> +	cancel_delayed_work_sync(&dtr->rx_refill);

[Severity: High]
Can mhi_wwan_dtr_refill_work() still be inside mhi_queue_buf() when
mhi_unprepare_from_transfer() tears the channel down here?

The work is only cancelled after unprepare. Suppose a DL sink requeue
failed with -ENOMEM (for example map_single failed) and scheduled
rx_refill. The work may already have passed the ENABLED check in
mhi_gen_tre(). chan->lock is dropped before the doorbell is rung:

mhi_wwan_dtr_refill_work()
  mhi_wwan_dtr_queue_rx()
    mhi_queue_buf()
      mhi_queue()
        mhi_gen_tre()     <- ch_state checked under chan->lock, then dropped
        read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
        ...
        mhi_ring_chan_db()
          *ring->ctxt_wp = cpu_to_le64(db);

At the same time, on the remove side:

mhi_wwan_dtr_remove()
  mhi_unprepare_from_transfer()
    mhi_unprepare_channel()
      mhi_reset_chan()    <- takes pm_lock only as a reader
      mhi_deinit_chan_ctxt()
        dma_free_coherent(... tre_ring ...);
        vfree(buf_ring->base);
        tre_ring->ctxt_wp = NULL;

On a normal unbind or rmmod, pm_state is still M0, so
MHI_DB_ACCESS_VALID() passes. Wouldn't the doorbell write then go through
a NULL ctxt_wp?

The comment says a pending retry fails on the disabled channel. That
seems to hold only for a work run that starts after the channel is
DISABLED, not one that overlaps unprepare.

mhi_wwan_ctrl_stop() in the same file cancels its refill work before it
calls mhi_unprepare_from_transfer(). Would calling
disable_delayed_work_sync(&dtr->rx_refill) before
mhi_unprepare_from_transfer() here close this? It would also make any
later schedule_delayed_work() from a DL callback a no-op.

> +	kfree(dtr->rx_buf);
> +	kfree(dtr);
> +}

[Severity: Medium]
Is the "No DL callbacks after unprepare" assumption guaranteed for this
channel?

In the pci_generic configs, software channels are on event ring 0, which
is MHI_ER_CTRL. mhi_ctrl_ev_task() processes that ring without taking
mhi_event->lock. parse_xfer_event() drops mhi_chan->lock before it calls
the client callback:

parse_xfer_event() {
    ...
			read_unlock_bh(&mhi_chan->lock);

			/* notify client */
			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
    ...
}

mhi_unprepare_channel() only takes chan->lock to set DISABLED, so it does
not appear to wait for a callback that is already running.

Consider this sequence:

1. mhi_wwan_dtr_dl_xfer_cb() calls mhi_wwan_dtr_queue_rx(), which gets
   -ENOMEM from mhi_gen_tre() while the channel is still ENABLED.
2. The callback is then delayed, for example by the
   dev_warn_ratelimited() output or by threaded softirqs on PREEMPT_RT.

Could remove finish unprepare, cancel_delayed_work_sync() and kfree(dtr)
before the callback continues? The callback would then run:

    schedule_delayed_work(&dtr->rx_refill, msecs_to_jiffies(100));

on freed memory, and mhi_wwan_dtr_refill_work() would later dereference
the freed dtr.

In the common case, the same ctrl tasklet that runs the callback also
handles the UL RESET command completion, which closes the window. The
window opens in two cases:

- mhi_unprepare_channel() skips the RESET waits through the
  !(BIT(mhi_cntrl->ee) & mhi_chan->ee_mask) branch.
- The event and command rings are split.

So this one is more speculative. Would the disable_delayed_work_sync()
before mhi_unprepare_from_transfer() suggested above also prevent this
re-arm?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007182238.1154851-1-peter.hunt%40opengear.com
