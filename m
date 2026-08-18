Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4D48124E;
	Tue, 18 Aug 2026 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072971; cv=none; b=GKDReKBuXwIdhN/kXqb/9IbQ4dPmFBNpwid71pl1JFroxJVzTpGcoNKJ8XjJQ8IMRotk47y7ohErhrMwY1SZkVOCaOinIQiF8aMwMYk0gRyKpfoPnqMl74aDly/mfDp1zM8FsDqs7rksPn76zObaCp+JDOghN0MrOHM6GL6m7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072971; c=relaxed/simple;
	bh=guuT85ErYf9UpzLluGIAzNGBLyxCuEg1Z95LSytC99o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwiYTqsPetJVCSnAiLNPwYMSe15HExBeaGWU50eRqRCT4zOxINUWEtUzGs2WprEnaE8CpZlPIQVexsNpZupqIl00dGT56eEpoabYOqL+0xPd1vvyOZrDvH2hZo7yBdnZBu4ihXd4uQyS+3s/5x+MTcEaljvO6ZlNexTDe+g/RU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY38lQVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY38lQVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E01F00A3A;
	Tue, 18 Aug 2026 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072969;
	bh=FKXQz9j5Q9PPhTu4Are2ufwUKwVcc4+rdCmtu6MgkhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BY38lQVgIzkiBaSa7Ki5T1B52VExTWW1Cgk1Y6grXm9i7NRcW0D05aJaZlUvJU2BZ
	 +mWa+xD2XmbMJYRD4IPAii3hnCrE8btD4T/KJhFa0k2py3ggrPfq8AnanqsVylmWjT
	 iElkFzNozpqrMROph/7+oQt6DwPqezjOHtqcTYjlK6lvbs9+HtzdEeNZC/bL/sUIpE
	 4T3+awR8yckvU1rzrBZglhxBWe89ghx6r7B0zGpKhi42duFhxqZ/YxHdcwpYP4bLpf
	 5zA4WwCn2S9lFw2yU26df63/36OvW73Xr2PJPvXYLFQBaQYv9WXme+XBDzidJrtQv1
	 PlteOTGUMwJVA==
From: Jakub Kicinski <kuba@kernel.org>
To: peter.hunt@opengear.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	mani@kernel.org,
	johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Tue, 18 Aug 2026 10:09:28 -0700
Message-ID: <20260818170928.4019460-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816121705.858013-4-peter.hunt@opengear.com>
References: <20260816121705.858013-4-peter.hunt@opengear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

This adds a second mhi_driver in mhi_wwan_ctrl that binds the IP_CTRL
channel, keeps a per-controller registry of those devices, and implements
the new wwan_port_ops->dtr_rts callback by queueing a host serial-state
message on the IP_CTRL channel of the AT port's own controller.

A few questions below about the DTR/RTS state handling.

> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index a31d8540fbb85..a917df9bb17b8 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c

[ ... ]

> @@ -14,6 +18,30 @@ enum mhi_wwan_flags {
>  
>  #define MHI_WWAN_MAX_MTU	0x8000
>  
> +/* IP_CTRL channel message that sets the modem's DTR/RTS control lines */
> +struct mhi_dtr_ctrl_msg {
> +	__le32 preamble;
> +	__le32 msg_id;
> +	__le32 dest_id;
> +	__le32 size;
> +	__le32 msg;
> +} __packed;
> +
> +#define MHI_DTR_CTRL_MAGIC	0x4C525443	/* 'CTRL' */
> +#define MHI_DTR_MSG_DTR		BIT(0)
> +#define MHI_DTR_MSG_RTS		BIT(1)
> +#define MHI_DTR_HOST_STATE	0x10

[ ... ]

> @@ -103,6 +131,62 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
>  	}
>  }
>  
> +/* Signal the modem's DTR/RTS lines over its own controller's IP_CTRL channel */
> +static int mhi_wwan_ctrl_send_dtr(struct mhi_wwan_dev *mhiwwan, unsigned int mdmbits)
> +{
> +	struct mhi_controller *cntrl = mhiwwan->mhi_dev->mhi_cntrl;
> +	struct mhi_device *ctrl_dev = NULL;
> +	struct mhi_dtr_ctrl_msg *dtr_msg;
> +	struct mhi_wwan_dtr *dtr;
> +	u32 msg = 0;
> +	int ret;
> +
> +	guard(mutex)(&mhi_wwan_dtr_lock);

[Severity: Medium]
Can two concurrent modem-control requests reach the modem in the opposite
order to the recorded mdmbits?

In wwan_port_fops_at_ioctl() the mdmbits update and the dtr_on snapshot
happen under port->data_lock, but the callback is invoked after that lock
is dropped, under port->ops_lock:

	mutex_unlock(&port->data_lock);

	if (call_dtr_rts) {
		mutex_lock(&port->ops_lock);
		if (port->ops && port->ops->dtr_rts)
			port->ops->dtr_rts(port, dtr_on);
		mutex_unlock(&port->ops_lock);
	}

wwan_port_op_start() does the same split for the first-open path:

		if (port->start_count == 1 && port->type == WWAN_PORT_AT &&
		    port->ops->dtr_rts) {
			mutex_lock(&port->data_lock);
			port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
			mutex_unlock(&port->data_lock);
			port->ops->dtr_rts(port, true);
		}

So an ioctl thread that clears TIOCM_DTR (dtr_on = false) can block on
ops_lock while an opener sets mdmbits |= TIOCM_DTR | TIOCM_RTS and signals
DTR high, then resume and signal DTR low with its stale snapshot.

mhi_wwan_ctrl_send_dtr() queues the IP_CTRL message in the order it takes
mhi_wwan_dtr_lock, so the modem ends up with DTR de-asserted while TIOCMGET
reports it asserted, and that sticks until the next transition.

Would committing the mdmbits update and the ->dtr_rts() call inside one
critical section (for example taking ops_lock around the TIOCM* mdmbits
update) avoid this?

> +
> +	list_for_each_entry(dtr, &mhi_wwan_dtr_list, node) {
> +		if (dtr->cntrl == cntrl) {
> +			ctrl_dev = dtr->mhi_dev;
> +			break;
> +		}
> +	}
> +	if (!ctrl_dev) {
> +		dev_dbg(&mhiwwan->mhi_dev->dev,
> +			"IP_CTRL not enumerated; DTR/RTS not signalled to modem\n");
> +		return 0;
> +	}
> +
> +	dtr_msg = kzalloc_obj(*dtr_msg);
> +	if (!dtr_msg)
> +		return -ENOMEM;
> +
> +	if (mdmbits & TIOCM_DTR)
> +		msg |= MHI_DTR_MSG_DTR;
> +	if (mdmbits & TIOCM_RTS)
> +		msg |= MHI_DTR_MSG_RTS;
> +
> +	dtr_msg->preamble = cpu_to_le32(MHI_DTR_CTRL_MAGIC);
> +	dtr_msg->msg_id = cpu_to_le32(MHI_DTR_HOST_STATE);
> +	dtr_msg->dest_id = cpu_to_le32(mhiwwan->mhi_dev->ul_chan_id);
> +	dtr_msg->size = cpu_to_le32(sizeof(__le32));
> +	dtr_msg->msg = cpu_to_le32(msg);
> +
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

[Severity: Medium]
Is the error code computed here ever acted on?

mhi_wwan_ctrl_send_dtr() can return -ENOMEM from kzalloc_obj(), and
mhi_queue() can return -EIO when MHI_PM_IN_ERROR_STATE(pm_state) is true,
-EAGAIN when the IP_CTRL uplink ring is full, or -ENODEV when the channel
is not in MHI_CH_STATE_ENABLED.

The only caller, mhi_wwan_ctrl_dtr_rts(), is void and drops the value, and
wwan_port_ops->dtr_rts is itself void, so wwan_port_fops_at_ioctl() returns
its precomputed status:

	if (call_dtr_rts) {
		mutex_lock(&port->ops_lock);
		if (port->ops && port->ops->dtr_rts)
			port->ops->dtr_rts(port, dtr_on);
		mutex_unlock(&port->ops_lock);
	}

	return ret;

Nothing re-drives the requested state either: mhi_wwan_dtr_ul_xfer_cb()
only frees the buffer, and the core calls ->dtr_rts only on first open,
last close, or an explicit ioctl.

So TIOCMSET/TIOCMBIS/TIOCMBIC report success while no host-state message
reached the modem, leaving the port in the same "URCs never arrive" state
this change is meant to fix, with only a dev_dbg to show it. Should
->dtr_rts return an int so the failure can be propagated, or should the
desired state be re-queued from the uplink completion callback?

> +
> +static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, bool on)
> +{
> +	mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port),
> +			       on ? TIOCM_DTR | TIOCM_RTS : 0);
> +}

[Severity: Medium]
Does driving RTS from the DTR bit invert userspace-requested RTS states?

struct mhi_dtr_ctrl_msg carries MHI_DTR_MSG_DTR and MHI_DTR_MSG_RTS as
independent bits, but mhi_wwan_ctrl_dtr_rts() fabricates both from the
single bool, and in wwan_port_fops_at_ioctl() that bool is derived from
TIOCM_DTR only:

		if (port->type == WWAN_PORT_AT) {
			dtr_on = !!(port->at_data.mdmbits & TIOCM_DTR);
			call_dtr_rts = true;
		}

Two cases that follow from that:

TIOCMSET with only TIOCM_RTS set leaves mdmbits = TIOCM_RTS, computes
dtr_on = false, and sends msg = 0, so RTS goes low at the modem while
TIOCMGET reports it set.

TIOCMBIC(TIOCM_RTS) while DTR is set computes dtr_on = true and sends
MHI_DTR_MSG_DTR | MHI_DTR_MSG_RTS, so RTS is re-asserted on the wire while
TIOCMGET reports it cleared.

Patch 1 documents the DTR-only boolean for the open/close paths, but the
ioctl path here appears to make TIOCMGET disagree with what was signalled.
Would passing the modem-bit mask (or separate dtr/rts arguments) to
->dtr_rts keep the two lines independent?

[ ... ]

Cross-instance finding from sashiko-gemini (b336eac424601552df7b2a5a6930f6f1777d59223ded79ac6c93f05fff648f90):
[Severity: High]
The driver starts the IP_CTRL downlink channel but fails to queue any RX buffers for it, which will stall the modem's MHI transmit path when it attempts to send serial state updates.
