Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1151DE00;
	Tue, 13 Oct 2026 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912233; cv=none; b=h4F4t1eQSCg3CqSJkKOQhumpasR6p1NBgCfM0gLQbfWOEe+vgG2JRUKDn4ASsEAEWNuEZp1IMy8G6/srphPgRtKtn6HsLJFqvjrATxL+ObA5m8cGYPoMshpaqPTyenVI9Z1q/1T1UV9qCb7oP7Uq+q6nxN0inoLtsz3Bu/2pjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912233; c=relaxed/simple;
	bh=tj1iKHUd6B/c5xb9oFoejxiP9MyuK2swCeVtkx9GHME=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWCbpjQIRX2WoEjSO7Hw3ZOnb5oHA0rmIKvyYWp01aU+4KRUQvJ0gRmZG09YuCBVPChpuZcmoJcTlWiM2b7cwZcUHFmHyt8NGju3Zhu61tOmXkFK2fu9V7v/QVxzq2iON6dMSeet9YkkIvZQZCYITbkwfjt9myAAWOWtweKIO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frsojOz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frsojOz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A49A1F00893;
	Tue, 13 Oct 2026 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912232;
	bh=5jBQVVQu87yDTmql24gbGwBkBE1SHG0V0o4YJ33B3sI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=frsojOz9bMWm6YFcOezxubB2GzO2ttPSyaL+nYbX0eUnoSvx/Rf8MSbdZlsd2DELi
	 SW1rgmiFSzXqDnr0jdrr6kkSV8zZsPpeJWH+Kjr3MdkJ22Ec9xDqx3JNAmAhRFY0v7
	 Y/g2omSs0jDLbggJVWldx4Ui+zlvnHwSoznpIddsDUoaSPMGliutxBfi+eZQnbj2xg
	 s8qC0m7P25vd0+A4CkndTte2tuJ+iu/8npKP0K2XamyNoQfxkl6gzKL7orSh2Eqo0r
	 wh8abIFr0itdbBysm/zK9nU7yD3bM30O0CJ36zU2u88BKSr9AGed7Vxep+3MvZlR+l
	 BD39OOrHN2v3g==
Subject: Re: [PATCH net-next v9 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS
 via the IP_CTRL channel
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, dnlplm@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 17:23:50 +0000
Message-ID: <179191223098.434549.11899173102479904971@kernel.org>
In-Reply-To: <20261012172219.3668624-3-peter.hunt@opengear.com>
References: <20261012172219.3668624-3-peter.hunt@opengear.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When a DTR/RTS message fails to send, nothing retries it, and
  the wwan core's change-only filter stops userspace from re-sending it.
- [Low] (Baseline verification: the main trigger is disproven; only a
  root-only sysfs corner case remains.) The concern says an AT port can…

--

net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

This patch makes mhi_wwan_ctrl also bind the IP_CTRL MHI channel and uses
it to send the host DTR/RTS state to the modem, so SDX55/SDX65 modems
deliver URCs on the AT ports. A per-controller registry maps each AT port
to the IP_CTRL device of its own modem, and a new ->dtr_rts op sends the
line state, while a recycled DL sink buffer keeps the IP_CTRL DL ring
live.

> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index a31d8540fbb85..1cbbfcb3b920a 100644
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
> +
> +	dtr_msg = kzalloc_obj(*dtr_msg);
> +	if (!dtr_msg)
> +		return -ENOMEM;

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
What happens to the modem's line state when this send fails?

mhi_wwan_ctrl_send_dtr() can fail with -ENOMEM from kzalloc_obj(). It can
also fail from mhi_queue_buf() with -EAGAIN (UL ring full), -EIO (MHI
error state), -ENODEV, or a map_single error. In each case the message is
freed, and mhi_wwan_ctrl_dtr_rts() ignores the return value.

Nothing retries the send. The DL sink path in this same patch does retry
-ENOMEM.

The wwan core has already stored the new value in port->at_data.mdmbits
before it calls ->dtr_rts:

drivers/net/wwan/wwan_core.c:wwan_port_raise_dtr_rts() {
    ...
	port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
	port->ops->dtr_rts(port, port->at_data.mdmbits);
}

The TIOCMSET/TIOCMBIC/TIOCMBIS handler only calls the driver when the
bits change:

drivers/net/wwan/wwan_core.c:wwan_port_fops_at_ioctl() {
    ...
		/* Only signal the driver when DTR or RTS actually changes */
		if (port->type == WWAN_PORT_AT && port->ops &&
		    port->ops->dtr_rts &&
		    (old ^ port->at_data.mdmbits) & (TIOCM_DTR | TIOCM_RTS))
			port->ops->dtr_rts(port, port->at_data.mdmbits);
    ...
}

So after a lost DTR raise, TIOCMGET reports DTR as asserted, but the modem
still sees it de-asserted and keeps withholding +CREG/+DMI. A repeated
TIOCMBIS(TIOCM_DTR), or a TIOCMSET with the same bits, never reaches the
driver.

Only clearing and then setting DTR, or a full last-close/first-open cycle,
brings the modem back in step. A long-lived opener such as ModemManager
rarely does either.

This also seems to conflict with the commit message:

    the next ioctl or open/close cycle will resynchronise the modem
    state.

That only holds for an ioctl that actually changes DTR or RTS. The
companion wwan core commit also says that the TIOCM state and the line
state sent to the driver cannot get out of step.

Could a failed send be retried from a work item, as the DL refill is? Or
could the driver track the last state the modem accepted, so that a later
ioctl can resend it?

[ ... ]

> +	mutex_lock(&mhi_wwan_dtr_lock);
> +	list_add(&dtr->node, &mhi_wwan_dtr_list);
> +	mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +	return 0;

[ ... ]

> +static void mhi_wwan_dtr_remove(struct mhi_device *mhi_dev)
> +{
> +	struct mhi_wwan_dtr *dtr = dev_get_drvdata(&mhi_dev->dev);
> +
> +	mutex_lock(&mhi_wwan_dtr_lock);
> +	list_del(&dtr->node);
> +	mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +	/* Stop the refill work, and stop a late DL callback re-arming it, before
> +	 * the channel is torn down so no requeue can race with the teardown
> +	 */
> +	disable_delayed_work_sync(&dtr->rx_refill);
> +	mhi_unprepare_from_transfer(mhi_dev);

[Severity: Low]
This is a narrow corner case, but can the IP_CTRL device and the open AT
ports get out of step across a sysfs unbind and rebind of mhi_wwan_dtr?

The normal boot and hot-plug order is fine. mhi_create_devices() probes
channels synchronously in channel-number order, so IP_CTRL (18/19) binds
before DUN (32/33). mhi_wwan_ctrl_init() also registers
mhi_wwan_dtr_driver first.

Suppose root unbinds mhi_wwan_dtr while a DUN port is open. Then
mhi_wwan_dtr_remove() tears down the channel without first sending DTR/RTS
low. The drop on last close finds no ctrl_dev in mhi_wwan_ctrl_send_dtr()
and returns 0 without sending anything.

On a later rebind, mhi_wwan_dtr_probe() adds the registry entry but does
not replay the stored mdmbits of AT ports that are already open. The core
filters ioctls that do not change the bits, so TIOCMBIS(TIOCM_DTR) cannot
recover this either.

The ordering assumption above also does not hold when the async_probe
module parameter is used.

During mhi_destroy_devices(), IP_CTRL is also removed before DUN, so the
final drop does nothing. The modem is being reset or powered off at that
point anyway.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012172219.3668624-1-peter.hunt%40opengear.com
