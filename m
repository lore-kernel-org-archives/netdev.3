Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152933839A1;
	Fri, 14 Aug 2026 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737076; cv=none; b=q+81AdGY0Gyyy9clV7/U5cfHa2/8ZVXKZbb6S33XILp5V3x5SNmfxgF2pRYYLLV66pGt4+zINUmV5qd/hckGRta1xYEQhWpIQAy5zWJHmDaJSKjKPWMZ/oMXWIiK9rhILK7qA8SZfkN33guSUFmBqMv2jfRgfuDKYa6OV46cEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737076; c=relaxed/simple;
	bh=35Iq1pjSS4rQ8UHa1SL0Ik1fw0Q6aDqlggS9QhyexZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoMCkTT555qPdEvE6kHVcdy3cTaogUHd/+UKKn1v+OCjXzCTqVGQFXF+GNoZrs0gIKJntgjK+5RgQJw5i4IL23GUc1RkX8952yeoA32d6EPyLYmbO0uZtUfzuhUo9T78vMQuF5ln+YFayi06sToNSacQD05JLk8ewYwIiOGoBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV5bXy/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV5bXy/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47081F000E9;
	Fri, 14 Aug 2026 19:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737075;
	bh=IvU4AEySlf5auKJ9wZHp7KI/XKrB4A0LWFq7SKqgjhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lV5bXy/sXlRZ8HjV2GAI/nVZCr0mIl7JoQ3FDR2moeRgpYnO2UTLkztQvSUnJeVsf
	 KxgSJ3ted7lC9VXU7f6Sloz/OV/+YYchlf5Y3sHMZQV/T6jV1orVIVpHhm9PrEfvBi
	 ZX46/6c27bVvy9vvYm+E1O3AmJxsN6Y9pl8f/F8bssRmWSp1XsvDY0R72g5+LJdpjg
	 s34l5YlCED2ZfwpYvel3oEYBf/V5Sztu38L4jLZ9So+IkffsffcevL1S1xnvssmJDp
	 GWnpXUqrL41O5qOXd7UK6B66uQaJcklfLmyEuNiKbtK7uw0dc8AsTJytvgBeh3TgK3
	 0HlpGnZmeFIwA==
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
Subject: Re: [PATCH net-next v3 3/3] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Fri, 14 Aug 2026 12:51:04 -0700
Message-ID: <20260814195103.3204086-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807215042.2714442-4-peter.hunt@opengear.com>
References: <20260807215042.2714442-4-peter.hunt@opengear.com>
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

This adds a second mhi_driver to mhi_wwan_ctrl that binds the IP_CTRL
channel and keeps a per-controller registry of those devices, so an AT
port can push the host DTR/RTS state to its own modem.  A new
wwan_port_ops->dtr_rts implementation builds a struct mhi_dtr_ctrl_msg
and queues it on that channel.

A few questions below about the new ->dtr_rts path.

> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index a31d8540fbb8..3aef90ec2176 100644
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

> @@ -103,6 +131,56 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
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
> +
> +	list_for_each_entry(dtr, &mhi_wwan_dtr_list, node) {
> +		if (dtr->cntrl == cntrl) {
> +			ctrl_dev = dtr->mhi_dev;
> +			break;
> +		}
> +	}
> +	if (!ctrl_dev)
> +		return 0; /* IP_CTRL not enumerated; best-effort, not an error */

[Severity: Medium]
Is it intended that this path is completely silent?

For any MHI modem configuration that does not declare an IP_CTRL channel
(the Quectel EM1xx, Foxconn SDX55/SDX61 and Telit FN990/FN920c04 DUN
entries in pci_generic.c, for example) the lookup never finds an entry, so
every DTR request is accepted and discarded without so much as a dev_dbg().
The core has already committed port->at_data.mdmbits by then, so TIOCMGET
reports DTR/RTS asserted while nothing was sent to the modem.

Would a dev_dbg() or a one-time dev_warn() here make the "URCs still not
arriving" case diagnosable?

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
> +	if (ret)
> +		kfree(dtr_msg);
> +
> +	return ret;
> +}
> +
> +static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, bool on)
> +{
> +	mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port),
> +			       on ? TIOCM_DTR | TIOCM_RTS : 0);
> +}

[Severity: Medium]
Continuing the previous question: the return value of
mhi_wwan_ctrl_send_dtr() is dropped here, including the -ENOMEM path and
every mhi_queue_buf() error.  Those are reachable failures rather than dead
code:

drivers/bus/mhi/host/main.c:mhi_queue() {
	...
	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
		return -EIO;

	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
	if (unlikely(ret))
		return -EAGAIN;
	...
}

and mhi_gen_tre() returns -ENODEV when the channel is not
MHI_CH_STATE_ENABLED.

So after a modem SYS_ERR, or with a full UL ring, the host-state message is
dropped with no retry and no message, and the symptom the patch is fixing
comes back silently.  Since the op returns void the error cannot be
propagated, but could it at least be logged the way
mhi_wwan_ctrl_refill_work() logs its queue failure?

[Severity: Medium]
Can DTR and RTS still be driven independently after this?

mhi_wwan_ctrl_send_dtr() maps each line separately (TIOCM_DTR -> BIT(0),
TIOCM_RTS -> BIT(1)) and struct mhi_dtr_ctrl_msg carries both bits, but its
only caller collapses everything into one boolean, so msg can only ever be
DTR|RTS or 0.  The core side does the same collapse:

drivers/net/wwan/wwan_core.c:wwan_port_fops_at_ioctl() {
	...
		if (cmd == TIOCMBIC)
			port->at_data.mdmbits &= ~mdmbits;
	...
		if (port->ops->dtr_rts)
			port->ops->dtr_rts(port,
					   !!(port->at_data.mdmbits &
					      (TIOCM_DTR | TIOCM_RTS)));
	...
}

With RTS asserted, ioctl(fd, TIOCMBIC, &(int){TIOCM_DTR}) - the usual way to
drop DTR so an AT&D1/AT&D2 modem leaves data mode or hangs up - leaves "on"
true, so DTR is re-asserted on the wire while TIOCMGET reports it cleared.
Asserting only RTS likewise raises DTR.

The limitation comes from the void dtr_rts(struct wwan_port *, bool)
signature added in patch 1 rather than from the hardware.  The tty layer
keeps these separate (ops->tiocmset gets the full bitmask, dtr_rts is only
used for open/close/hangup) - would passing the mdmbits mask through be
workable here?

[Severity: Critical]
Is there anything keeping the port drvdata alive across this callback?

wwan_remove_port() clears port->ops under ops_lock:

drivers/net/wwan/wwan_core.c:wwan_remove_port() {
	...
	port->ops = NULL; /* Prevent any new port operations (e.g. from fops) */
	mutex_unlock(&port->ops_lock);
	...
}

but the new TIOCMSET/TIOCMBIC/TIOCMBIS branch in
wwan_port_fops_at_ioctl() dereferences port->ops holding only data_lock,
without ops_lock and without the "if (!port->ops) return -ENODEV;" check the
other fops-reachable op calls (wwan_port_op_tx(), wwan_port_fops_poll()) use.

An fd opened on /dev/wwanXatY stays usable after the device is gone -
wwan_port_fops_open() takes a device reference via
wwan_port_get_by_minor() and only wwan_port_fops_release() drops it - so
after a modem firmware crash, a PCI hot-unplug or rmmod of the controller
driver, a TIOCMSET on that fd reads port->ops as NULL.

The second half is this driver's remove path:

drivers/net/wwan/mhi_wwan_ctrl.c:mhi_wwan_ctrl_remove() {
	wwan_remove_port(mhiwwan->wwan_port);
	kfree(mhiwwan);
}

If the ioctl thread observed port->ops non-NULL just before the store and is
inside mhi_wwan_ctrl_dtr_rts() -> mhi_wwan_ctrl_send_dtr(), the lockset
intersection with wwan_remove_port() is empty (data_lock vs ops_lock), so
mhiwwan is freed while that thread reads mhiwwan->mhi_dev->mhi_cntrl and
mhiwwan->mhi_dev->ul_chan_id and then queues a DMA buffer on behalf of the
removed device.  mhi_wwan_dtr_lock only covers the IP_CTRL registry, not the
AT port's mhi_wwan_dev.

This patch is the first ->dtr_rts implementer, so it is what makes the
use-after-free variant reachable; the unguarded call site itself came in with
patch 1.  Would calling the op under port->ops_lock with the usual NULL check
close both cases?  A bare NULL test alone would only narrow the window.
