Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB43DB630;
	Mon,  5 Oct 2026 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234201; cv=none; b=jaCgVyxjQP3cvp8OOirSnKzR3H/ukGITnF9+eBKuYeBMDOor6lvlYIEnjGaHaUi/zHyoxg7grrd+cp95nk2JAR3pJqxe54vkl33rF6ZepEruW/m6ZYgtm2pJT+tNsHknIC0NPRtyPhjdy+ojhYzP0+HlMcpU9oFg1r/0s2/i0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234201; c=relaxed/simple;
	bh=xvu8kyZrzlSTqrj4+ycNVZuOYL908bkbpNaU8CDijhE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PZQFyLJhy+3dNoz7aHkQJmHwp5fzDRUSUBbMhBHerB8C5k7v0726V+Mf+Q1yxUUzPTMDoYiU97QoN0TNuJOBdz5JNjeW2iwdmMle7s5HT7odJAcz7VIzRRoSsazby13JOmvJiH3IILffMyvsO0TqJJBr3BOyeYAKv+QP3N4VkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3MOmJ7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3MOmJ7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D981F00893;
	Mon,  5 Oct 2026 21:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234200;
	bh=ylSXs10EeRHJrN+BIry7xJNcdvoeVjEUBv+yqgEVv1g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c3MOmJ7BsVLxJ25JZF2LXYkNPcL1/8XQeUbH97tmUNrXpl7NytsN94w7zYUj144iy
	 Yt9GcH5jXse9P0ZxuW41MEEclGgcCb+I1TpUA/ApigTfYkRvmGKupHs3mF6F2pbA+w
	 KDltIyhtPqfaf5ynO1KUWtwN/buncDMQf1+8ZWqSghpJ3h32zoBnsP6PvUW6kD4UJB
	 T1l40VsQemAKN1Hqje1nKtkWz6qk0tPfri5RNGNAuU4k/3zTegKkt3aBOK797JWxIR
	 iUlpipU78iF20MzRnB0SWEgko9lgUzk3oAja1JubVBBRwff/JAlisOfiq1IuOR98pv
	 KrB04fZktVuXw==
Subject: Re: [PATCH net-next v6 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS
 via the IP_CTRL channel
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 21:03:18 +0000
Message-ID: <179123419887.434549.1077103528647935423@kernel.org>
In-Reply-To: <20261001204614.3481089-3-peter.hunt@opengear.com>
References: <20261001204614.3481089-3-peter.hunt@opengear.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not reach its stated goal on any in-tree
  hardware.
- [Medium] mhi_wwan_dtr_dl_xfer_cb()
  (drivers/net/wwan/mhi_wwan_ctrl.c:351-364) discards the return value…

--

net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

This patch adds a second mhi_driver to mhi_wwan_ctrl. The new driver
binds the IP_CTRL MHI channel and records it per controller in a small
registry. AT ports implement ->dtr_rts by sending a host serial state
message over their own controller's IP_CTRL channel. A single recycled
DL sink buffer stays queued on IP_CTRL so the modem's transmit path does
not stall.

> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index a31d8540fbb85..b94484a1657d7 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c

[ ... ]

> @@ -255,6 +340,86 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)

[ ... ]

> +static void mhi_wwan_dtr_dl_xfer_cb(struct mhi_device *mhi_dev,
> +				    struct mhi_result *mhi_result)
> +{
> +	struct mhi_wwan_dtr *dtr = dev_get_drvdata(&mhi_dev->dev);
> +
> +	/* Channel is being torn down (e.g. -ENOTCONN), do not requeue */
> +	if (mhi_result->transaction_status &&
> +	    mhi_result->transaction_status != -EOVERFLOW)
> +		return;
> +
> +	/* Modem serial state not needed, requeue the sink buffer to keep DL ring live */
> +	mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
> +		      sizeof(*dtr->rx_buf), MHI_EOT);

[Severity: Medium]
What happens if this mhi_queue_buf() fails? The return value is ignored,
and dtr->rx_buf is the only DL buffer. It is queued once in
mhi_wwan_dtr_probe() and requeued only from here.

parse_xfer_event() has already consumed the ring element before this
callback runs. A failed requeue therefore leaves the IP_CTRL DL ring
empty, and nothing retries until the device is unbound and probed again.

mhi_queue() can fail here in three ways:

- -EIO in an MHI PM error state
- -ENODEV from mhi_gen_tre() when the channel is not enabled
- -ENOMEM from map_single

The map_single call in mhi_gen_tre() looks like this:

mhi_gen_tre()
    if (!info->pre_mapped) {
        ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
        if (ret)
            goto out;
    }

mhi_map_single_no_bb() returns -ENOMEM on dma_mapping_error().
mhi_map_single_use_bb() calls dma_alloc_coherent(..., GFP_ATOMIC) from
this completion path.

Couldn't one transient mapping or allocation failure here cause the
IP_CTRL transmit stall that the sink buffer is meant to prevent? Should
the error at least be logged, and the refill retried later, for example
from a work item?

> +}

[ ... ]

> @@ -278,7 +443,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
>  	},
>  };
>  
> -module_mhi_driver(mhi_wwan_ctrl_driver);
> +static const struct mhi_device_id mhi_wwan_dtr_match_table[] = {
> +	{ .chan = "IP_CTRL" },
> +	{},
> +};

[Severity: High]
Does any in-tree MHI controller declare an "IP_CTRL" channel? This match
table is the only place the name appears as a channel.

MHI client devices are only created for channels in the controller's
static config, because mhi_create_devices() walks mhi_cntrl->mhi_chan.
The SDX55/SDX65 tables in drivers/bus/mhi/host/pci_generic.c don't list
IP_CTRL. For example:

drivers/bus/mhi/host/pci_generic.c:
static const struct mhi_channel_config mhi_sierra_em919x_channels[] = {
	...
	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 512, 1),
	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 512, 2),
};

The same is true of modem_qcom_v1 and the Foxconn, Quectel and Telit
tables.

If so, mhi_wwan_dtr_probe() never runs and mhi_wwan_dtr_list stays empty.
Every ->dtr_rts call then ends up in this branch of
mhi_wwan_ctrl_send_dtr(), whether it comes from wwan core open, close,
remove or TIOCMSET/TIOCMBIS/TIOCMBIC:

	if (!ctrl_dev) {
		dev_dbg(&mhiwwan->mhi_dev->dev,
			"IP_CTRL not enumerated; DTR/RTS not signalled to modem\n");
		return 0;
	}

TIOCMGET would then report DTR as asserted, but the modem never receives
it. The URCs described in the commit message would still be withheld.

Neither this patch nor "net: wwan: core: propagate modem control signals
to port drivers" adds IP_CTRL UL/DL entries to pci_generic.c. Is a
controller-side change needed with this patch? If not, could the commit
message at least note that dependency?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001204614.3481089-1-peter.hunt%40opengear.com
