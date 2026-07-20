Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632B25228C;
	Mon, 20 Jul 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556883; cv=none; b=aVbE0SKSoxK3xNyTg+noc04DScv1jIeyHKMSQ2QrGjaHw/mgucvdJP12mIlIaGgX0QE3MqlKkNEgHgwtYzXsa1OVzUbavLXXLcsSDaWMV7oGDyPlnO0HVuMvEXDvxD4y5DXkYjn2SH/1uVZrdraAWq6s6tgn4ck4W4LI4TgCkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556883; c=relaxed/simple;
	bh=BEN25scDEV79m2bw0WNyUC5+K2tJoRI+UGSKy+hyDK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLUNVpdjSUfQes/YHJdK8kHg2qm2uOc+sADBjRRmbsmSIAvLywmojwIGZc7eE1DafYv/mW7/sfQQSNvknsxGhjCjlPXozxXqOGvzdkziB1Y+MWPMZqgnz64XKCpeIRXakOTshose2gxQxDpTGuNmo21kuRyMcdw52h/Vtj7V/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwALb2+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwALb2+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359FB1F000E9;
	Mon, 20 Jul 2026 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556882;
	bh=6CSbdQoo9K85/yfRy5WhX6UKHPn4BtdFLZvrdHuMQj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwALb2+YXq5ASnCXppWEwarbNzVo9W95rpNAY/HPPrfYoVSKY4AVasm+8AdR1ycnD
	 Tf4aoo+LO3JHP12kKPDUUWbBdwwCCDfE/MTaY/ciOGUSf/k1JGKZbB97ycGuAiVgMD
	 2OgE30TzLx/lczcWsP69JwAswg1AifYSLPG5StuPnwCaGVRIBzSP8ZCNXUrnt1YsNi
	 jhfZ/cDTIf/wSA9DVCxjMmE6HhoLBhqaCenjR0mA/C7zJV9MP043/dC2uQp9nPF8/o
	 iy19iGqK9OfFaNFzGM1saSXixmdkFIaD3Myjnm+FhORQbyrhaSIRT6/pjhICR2ie71
	 EcSm/S/vB0WbQ==
From: Simon Horman <horms@kernel.org>
To: bastien.curutchet@bootlin.com
Cc: Simon Horman <horms@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	pascal.eberhard@se.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/10] net: dsa: microchip: add two-steps PTP support for KSZ8463
Date: Mon, 20 Jul 2026 15:07:52 +0100
Message-ID: <20260720140751.166805-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713-ksz-new-ptp-v2-10-7209c05058ef@bootlin.com>
References: <20260713-ksz-new-ptp-v2-10-7209c05058ef@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260713-ksz-new-ptp-v2-1-7209c05058ef@bootlin.com?part=10
---
--- Patch [10]: [PATCH net-next v2 10/10] net: dsa: microchip: add two-steps PTP support for KSZ8463 ---
commit 36964d81014567278bc46ae45085179f4779f40a
Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Subject: net: dsa: microchip: add two-steps PTP support for KSZ8463

This patch adds L2 two-step PTP support for the KSZ8463 switch. It
implements the get_ts_info and port_hwtstamp_set callbacks and tracks
the last transmitted event type to read the correct timestamp register.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index be6b8240ac03d..1cd2940c7befa 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
[ ... ]
> +static int ksz8463_set_hwtstamp_config(struct ksz_device *dev,
> +				       struct ksz_port *prt,
> +				       struct kernel_hwtstamp_config *config)
> +{
> +	const u16 *regs = dev->info->regs;
> +	int ret;
> +
> +	if (config->flags)
> +		return -EINVAL;
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		prt->ptpmsg_irq[KSZ8463_SYNC_MSG].ts_en  = false;
> +		prt->ptpmsg_irq[KSZ8463_XDREQ_PDRES_MSG].ts_en = false;
> +		prt->hwts_tx_en = false;
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		prt->ptpmsg_irq[KSZ8463_SYNC_MSG].ts_en  = true;
> +		prt->ptpmsg_irq[KSZ8463_XDREQ_PDRES_MSG].ts_en = true;
> +		prt->hwts_tx_en = true;
> +
> +		ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_1STEP, 0);
> +		if (ret)
> +			return ret;

[Severity: Medium]
If the hardware register configuration fails, does the port software state
remain enabled?

In ksz8463_set_hwtstamp_config(), prt->hwts_tx_en and the ts_en flag are
set to true before attempting to write to the hardware register. If the
hardware write fails, the function returns an error without reverting the
software state. Could this lead to subsequent PTP packets being intercepted
but never hardware-timestamped?

[ ... ]
> +static void ksz8463_set_pdelayresp_flag(struct ksz_port *prt,
> +					struct sk_buff *skb)
> +{
> +	struct ptp_header *hdr;
> +	unsigned int type;
> +	u8 ptp_msg_type;
> +
> +	if (!ksz_is_ksz8463(prt->ksz_dev))
> +		return;
> +
> +	if (skb_linearize(skb))
> +		return;

[Severity: Medium]
If skb_linearize() fails, it returns early without updating
prt->last_tx_is_pdelayresp. Will the caller ignore this failure and
proceed to transmit the packet anyway?

When the hardware interrupt fires, ksz_read_ts() could use the stale flag
from a previous packet to calculate the register offset, resulting in
reading an incorrect timestamp.

> +
> +	type = ptp_classify_raw(skb);
> +	if (type == PTP_CLASS_NONE)
> +		return;
> +
> +	hdr = ptp_parse_header(skb, type);
> +	if (!hdr)
> +		return;
> +
> +	ptp_msg_type = ptp_get_msgtype(hdr, type);
> +	prt->last_tx_is_pdelayresp = (ptp_msg_type == PTP_MSGTYPE_PDELAY_RESP);
> +}
> +
>  void ksz_port_deferred_xmit(struct kthread_work *work)
>  {
>  	struct ksz_deferred_xmit_work *xmit_work = work_to_xmit_work(work);
[ ... ]
>  	reinit_completion(&prt->tstamp_msg_comp);
>  
> +	ksz8463_set_pdelayresp_flag(prt, skb);
> +
>  	dsa_enqueue_skb(skb, skb->dev);
>  
>  	ksz_ptp_txtstamp_skb(dev, prt, clone);

[Severity: High]
This is a pre-existing issue, but does ksz_ptp_txtstamp_skb() leak the
cloned SKB if the wait for the TX timestamp times out?

In ksz_ptp_txtstamp_skb(), the driver blocks waiting for the hardware TX
timestamp interrupt. If the timeout expires, the function returns early
without freeing the clone:

static void ksz_ptp_txtstamp_skb(...) {
    ...
    ret = wait_for_completion_timeout(&prt->tstamp_msg_comp, ...);
    if (!ret)
        return;
}

The caller ksz_port_deferred_xmit() then frees the work item, leaving the
cloned SKB permanently leaked. Could this lead to a system memory leak?

[Severity: High]
Does the shared TX path intercept unsupported network layers for the
KSZ8463?

The commit message notes that IPv4 and IPv6 layers aren't supported by the
hardware. However, the shared ksz_port_txtstamp() relies on
ptp_classify_raw() to intercept packets, which does not filter out
IPv4/IPv6 PTP packets.

If a user sends an IPv4/IPv6 PTP packet, does the driver intercept and queue
it for transmission, only to needlessly block the transmission worker for
100ms because the hardware ignores it and no interrupt will fire?

[Severity: High]
This is a pre-existing issue, but can dereferencing the PTP header without
verifying linearity cause page faults?

In the shared ksz_port_txtstamp() path, ptp_parse_header() is called to
retrieve the PTP header, which only verifies that the header fits within
the total SKB length.

Dereferencing this pointer in ptp_get_msgtype() without first calling
skb_linearize() or pskb_may_pull() could result in reading past the
linear allocation if the packet is non-linear.

[ ... ]
>  static int ksz_read_ts(struct ksz_port *port, u16 reg, u32 *ts)
>  {
> -	return ksz_read32(port->ksz_dev, reg, ts);
> +	u16 ts_reg = reg;
> +
> +	/**
> +	 * On KSZ8463 DREQ and DRESP timestamps share one interrupt line
> +	 * so we have to check the nature of the latest event sent to know
> +	 * where the timestamp is located
> +	 */
> +	if (ksz_is_ksz8463(port->ksz_dev) && port->last_tx_is_pdelayresp)
> +		ts_reg += KSZ8463_DRESP_TS_OFFSET;
> +
> +	return ksz_read32(port->ksz_dev, ts_reg, ts);
>  }

[Severity: High]
Is KSZ8463_DRESP_TS_OFFSET erroneously added to the SYNC_TS register
address here?

The ksz_read_ts() function is used for both the DREQ interrupt and the SYNC
interrupt. If a SYNC_MSG interrupt is processed while
port->last_tx_is_pdelayresp happens to be true, the offset appears to be
unconditionally added to the ts_reg. Does this cause the driver to read
from an invalid hardware register offset?

[Severity: High]
This is a pre-existing issue, but can late TX timestamp interrupts
mistakenly complete the wait for a subsequent, unrelated packet?

If a packet transmission times out, the worker thread moves on to queue the
next packet and reinitializes the completion. In ksz_ptp_msg_thread_fn(),
the interrupt handler calls complete() without verifying sequence IDs:

if (ptpmsg_irq->ts_en) {
    ...
    complete(&port->tstamp_msg_comp);
}

If a delayed interrupt from the first packet arrives, could it falsely
wake up the worker waiting for the second packet, improperly assigning
the first packet's timestamp to the second?
