Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6303CC9F6;
	Thu,  8 Oct 2026 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486391; cv=none; b=t9kq3Xaaqd4a4zpdT/iuCqbm/iaco1LoREvrIZRObmUGfdKEBYeVe07kOetFmZYz0pNPhBIS/JxajrDgXxg/HenOALVzefKDwmOrFxkfnsKGmxUbfoVa8cyAVXFm2ZiNy23a/LXrII0mVHILaJxoRf68/iFPgsDob7ISWH15z24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486391; c=relaxed/simple;
	bh=8eXBPQWld7cTZJBgR/4sa7rQlnhfuf45rVAdus77Ey8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6GEBdY10oWxejN6RLP6lsiCS0ds0sca+yhYUZ1WEQ5NiIvSiK5yzcscg7wmyTpJA1BDdbX69om8jO6n7zDmC19Zb8gD9thlHQeOfD1SDT6zfakzj/zcJDFYYyxqU0cCKSzaJ0qSUps4W0R85+Mglc+25ZY4XWJpT1U+JbTzJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqZvOjeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqZvOjeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE531F00893;
	Thu,  8 Oct 2026 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486386;
	bh=tqxR8yPeNloXsaFrv3oGGq6ymcKLlLeTkK7NvoxRAJg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jqZvOjeV03vvNRbNY8WdvbEoDbm3J1z+HIFZNQWJ24scOAThR2fTzVaDFtVqTnO0/
	 zI1jcntmOinCh/Z1N7xqZZubP82oheQwW3hqSEtqVdC2skQKSrnW82fhfRosw6VnHe
	 ItbiDCeS9V0M7911k27+QIeiJorMXg76mmMIVPV2MfpVuhdVsTfayJw09lkUCJ/J2w
	 ofakZPnxDC7YQJKg6y2wOnSAPbOMZmCHRGzb7QTUE5eKrPtuXd2A9Xg/E3e5NnAzqz
	 nWKYJQgr8xd9WIIdrO7PgbQxMEYhsuz9PpKVCSCeSFPU4hqulJ0VHWWmqJ/Q2cl7Vx
	 org5AIaI3kFmQ==
Subject: Re: [PATCH net-next v7 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS
 via the IP_CTRL channel
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 19:06:25 +0000
Message-ID: <179148638511.434549.17989288344012789608@kernel.org>
In-Reply-To: <20261006040422.3208888-3-peter.hunt@opengear.com>
References: <20261006040422.3208888-3-peter.hunt@opengear.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Race in mhi_wwan_dtr_remove() (drivers/net/wwan/mhi_wwan_ctrl.c)
  between the rx_refill retry worker and channel teardown.
- [Low] mhi_wwan_dtr_probe() unprepares the channels twice on its
  err_unprepare path.
- [Low] The commit message names its prerequisite only as "The wwan core
  (patch 1)".
- [Low] Concern: mhi_wwan_ctrl_dtr_rts() drops the result of
  mhi_wwan_ctrl_send_dtr(), and failed sends are not retried.

--

net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

This commit adds a second mhi_driver to mhi_wwan_ctrl. It binds the IP_CTRL
MHI channel and uses it to send DTR/RTS host state messages to the modem.
AT ports implement the new ->dtr_rts wwan op by finding their own
controller's IP_CTRL device in a small registry. A single recycled DL sink
buffer keeps the IP_CTRL DL ring live, and a delayed work item retries the
requeue if it fails.

> The wwan core (patch 1) raises DTR/RTS on first open and drops them on
> last close (if HUPCL is set) for any AT port whose driver implements
> ->dtr_rts, so no open/close handling is needed here.

[Severity: Low]
This isn't a bug, but "patch 1" only means something inside the posted
series.

Could this name the wwan core commit by subject, the same way the MHI tree
dependency is cited as commit 83c29a55b89e? The ->dtr_rts op and the
open/close/HUPCL handling seem to come from "net: wwan: core: propagate
modem control signals to port drivers".

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

[Severity: Low]
mhi_wwan_ctrl_dtr_rts() throws away the return value of
mhi_wwan_ctrl_send_dtr(). Nothing retries a failed send, whether it is a
kzalloc failure or -EAGAIN/-EIO/-ENODEV/-ENOMEM from mhi_queue_buf().

mhi_wwan_ctrl_send_dtr() also returns 0 when IP_CTRL is not bound yet.
mhi_wwan_dtr_probe() does not replay the DTR/RTS state of AT ports that are
already open.

In these cases, can TIOCMGET (at_data.mdmbits) show DTR as asserted when the
modem never got the message? URCs would then stay withheld until the next
TIOCM ioctl or reopen.

The commit message calls this best-effort, and acm_port_dtr_rts() in cdc-acm
also only logs a failed acm_set_control(). Since mhi_wwan_dtr_driver is
registered first, the probe replay case seems to need a sysfs
unbind/rebind. Is that the intended tradeoff?

[ ... ]

> +static int mhi_wwan_dtr_probe(struct mhi_device *mhi_dev,
> +			      const struct mhi_device_id *id)
> +{

[ ... ]

> +	ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
> +			    sizeof(*dtr->rx_buf), MHI_EOT);
> +	if (ret)
> +		goto err_unprepare;
> +
> +	mutex_lock(&mhi_wwan_dtr_lock);
> +	list_add(&dtr->node, &mhi_wwan_dtr_list);
> +	mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +	return 0;
> +
> +err_unprepare:
> +	mhi_unprepare_from_transfer(mhi_dev);

[Severity: Low]
Does this path unprepare the IP_CTRL channels twice? mhi_probe() in
drivers/bus/mhi/host/init.c already unprepares them whenever the client
probe fails:

	ret = mhi_drv->probe(mhi_dev, mhi_dev->id);
	if (ret)
		goto exit_probe;
	...
exit_probe:
	mhi_unprepare_from_transfer(mhi_dev);

On the second pass the channels are already DISABLED. mhi_unprepare_channel()
then logs "Failed to reset channel, still resetting" for each direction, in
addition to the real queue failure.

There is no double free, because mhi_deinit_chan_ctxt() returns early when
rbase is 0. The cost is only misleading log output.

Could the error path skip mhi_unprepare_from_transfer() and leave it to the
core?

> +err_free_buf:
> +	kfree(dtr->rx_buf);
> +err_free_dtr:
> +	kfree(dtr);
> +	return ret;
> +}
> +
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
Can the rx_refill worker race with the channel teardown here? The comment
covers a retry that starts after unprepare. What about a retry that is
already inside mhi_queue_buf()?

Suppose mhi_wwan_dtr_queue_rx() got -ENOMEM earlier and armed rx_refill. The
worker can then be inside mhi_queue(), between mhi_gen_tre() and the
doorbell:

mhi_wwan_dtr_refill_work()
  mhi_wwan_dtr_queue_rx()
    mhi_queue_buf()
      mhi_queue()
        mhi_gen_tre()        <- succeeds, drops mhi_chan->lock
        <preempted>

At the same time, mhi_wwan_dtr_remove() runs on another CPU:

mhi_unprepare_from_transfer()
  mhi_unprepare_channel()
    mhi_reset_chan()
    mhi_deinit_chan_ctxt()
      buf_ring->base = tre_ring->base = NULL;
      tre_ring->ctxt_wp = NULL;

When the worker resumes, MHI_DB_ACCESS_VALID() is still true because the
device is powered. mhi_ring_chan_db() then does:

	db = ring->iommu_base + (ring->wp - ring->base);
	...
	*ring->ctxt_wp = cpu_to_le64(db);

Wouldn't this write through a NULL pointer from the kworker?
mhi_unprepare_channel() takes mhi_chan->mutex, which mhi_queue() never takes,
so nothing seems to serialize the two.

mhi_wwan_ctrl_stop() in the same file does the steps in the opposite order:

	cancel_work_sync(&mhiwwan->rx_refill);

	mhi_unprepare_from_transfer(mhiwwan->mhi_dev);

Should the work be stopped first, for example with
disable_delayed_work_sync() before mhi_unprepare_from_transfer()? That would
also stop a late DL callback from re-arming it.

> +	kfree(dtr->rx_buf);
> +	kfree(dtr);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006040422.3208888-1-peter.hunt%40opengear.com
