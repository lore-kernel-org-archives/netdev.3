Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80568377A82;
	Thu, 10 Sep 2026 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010722; cv=none; b=mYhMQTIo2wVKzFhwq9vMPR/NiBuq6PfqN5/6Vm8o1feXwvhRGvx/rJke+F8usDEjJ7n5nt1XYhyvRsh8wL3o2SwWFTOg0u0k19C19qYPjNdvNWi4xsjVUbqCwZ75DM3SbOGIVFUxbRLuVip/lvEizguqrbrW+Z+IjmFjBkPNXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010722; c=relaxed/simple;
	bh=5idCJhAH6K+ZGLCAouPIMuXtgRNA8TEtHE7Rqr2RXig=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uf/5D/IFMJr0VYLSHmp1lrFEWVrDidiZRdD6LX0ng/V/+5FKmOJ9POEXseOVnh6Z+pMgrt4qfvGzq4wIdW7Tj2cYJAuhZig2JqVJ03CIwukulPPpioJMtTSwRc0tQhZ+HqM5Jt3PtSVAEAdeSYhh/Lwa6fKEenFfngEwlTvR4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmTm8a7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmTm8a7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EAC1F000FF;
	Thu, 10 Sep 2026 03:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789010716;
	bh=q+BlV7VQo9im4yYboK9tVVbGi59nDBacCVPPiY5YtAU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VmTm8a7n2UBbQkz/rSNRB7uL5dklu4BuzXdXXtYGRueQDnK31gzLsAdc52MKt3Hcd
	 1HzcM/ES908gW+609Tdiyl1x7JudiPFpze8VHTWwGbnPS6m81U4ZctVv+r8msl7HF7
	 fsWy/DKBe2c1zJ4b7ghln0CqD6vLnB9yeeqWjMmlTGyZ/Ra6stFyVES16xMQcwckEQ
	 6jICF0wEJzFMFAwmY9aMYfA1Om9MTc03bfHMLd7lKNiuLNiECFjiyBabiF26RDb76Y
	 RU0sDWNR1PikNKxzFntARndHZJTyYdlvRrEL8HW/onK920DgAVuf7s3SMFYh+d9l06
	 q2tDk9nRzoQZw==
Subject: Re: [PATCH net v3] octeontx2-pf: Fix ethtool timestamping
 capabilities for SDP representors
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rfranz@marvell.com,
 sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Thu, 10 Sep 2026 03:25:14 +0000
Message-ID: <178901071460.219967.16897602981271759339@kernel.org>
In-Reply-To: <20260907032311.3228168-1-nshettyj@marvell.com>
References: <20260907032311.3228168-1-nshettyj@marvell.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 (3) · Low: 0 (1)

- [High] The otx2_txrx.c hunk is presented as defensive hardening ("add
  null checks ... to avoid a potential NULL dereference") and is carried…
- [High] The fix is incomplete: the TX *completion* peer of the hardened
  code, otx2_snd_pkt_handler() (otx2_txrx.c:148-152), still dereferences…
- [Medium] Skipping otx2_ptp_init() entirely for SDP representors does
  more than stop advertising hardware timestamping: it also skips…
- [Medium] The new `sq->timestamps` test in otx2_set_txtstamp() silently
  converts a per-SQ resource gap into a silent capability gap: every…

Pre-existing issues:
- [Medium] otx2_set_txtstamp() still never consults
  OTX2_FLAG_TX_TSTAMP_ENABLED, so on a PTP-capable interface where…
- [Medium] otx2_config_hwtstamp_set() discards the return values of
  otx2_config_hw_tx_tstamp() and otx2_config_hw_rx_tstamp().
- [Medium] Inside the one-step-sync branch guarded by the condition this
  patch modifies, otx2_ptp_is_sync() computes *offset purely from packet…
- [Low] In otx2_config_hwtstamp_set(), the HWTSTAMP_TX_OFF branch uses
  the non-synchronous cancel_delayed_work() on…

--

octeontx2-pf: Fix ethtool timestamping capabilities for SDP representors

The patch skips PTP initialization for SDP representors so that
otx2_get_ts_info() only advertises software timestamping, changes
otx2_config_hwtstamp_set() to return -EOPNOTSUPP with an extack message
when pfvf->ptp is NULL, and adds pfvf->ptp / sq->timestamps NULL checks
to otx2_set_txtstamp().

A few questions about the changes below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index c995f29008590..d82a71c0a5d82 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2455,8 +2455,11 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
>  {
>  	struct otx2_nic *pfvf = netdev_priv(netdev);
>  
> -	if (!pfvf->ptp)
> -		return -ENODEV;
> +	if (!pfvf->ptp) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Hardware timestamping is not supported");
> +		return -EOPNOTSUPP;
> +	}
>  
>  	switch (config->tx_type) {
>  	case HWTSTAMP_TX_OFF:

[Severity: Medium]
This is a pre-existing issue and not something introduced here, but since
this hunk rewrites the error prologue of otx2_config_hwtstamp_set(), should
the rest of the function propagate errors too?

The results of otx2_config_hw_tx_tstamp() and otx2_config_hw_rx_tstamp() are
discarded, yet both can fail with -ENOMEM from the mbox message allocation
or with the otx2_sync_mbox_msg() error:

otx2_config_hw_tx_tstamp() {
	...
	err = otx2_sync_mbox_msg(&pfvf->mbox);
	if (err) {
		mutex_unlock(&pfvf->mbox.lock);
		return err;
	}
	...
}

The caller then still does:

	pfvf->tstamp = *config;

	return 0;

so userspace is told hardware timestamping was configured while the NIX LF
was never programmed.

For HWTSTAMP_TX_ONESTEP_SYNC the ordering makes it worse, since the flag and
the periodic work are armed before the unchecked call:

		pfvf->flags |= OTX2_FLAG_PTP_ONESTEP_SYNC;
		schedule_delayed_work(&pfvf->ptp->synctstamp_work,
				      msecs_to_jiffies(500));
		fallthrough;
	case HWTSTAMP_TX_ON:
		otx2_config_hw_tx_tstamp(pfvf, true);

On mbox failure the driver is left patching origin timestamps and running
synctstamp_work with hardware timestamping off. Should these return values
be checked and the one-step state be unwound?

[Severity: Low]
This isn't a bug introduced by this patch either, but in the
HWTSTAMP_TX_OFF branch of the same function:

	case HWTSTAMP_TX_OFF:
		if (pfvf->flags & OTX2_FLAG_PTP_ONESTEP_SYNC)
			pfvf->flags &= ~OTX2_FLAG_PTP_ONESTEP_SYNC;

		cancel_delayed_work(&pfvf->ptp->synctstamp_work);

the non-synchronous cancel races with the callback, which unconditionally
re-arms itself:

otx2_sync_tstamp() {
	...
	schedule_delayed_work(&ptp->synctstamp_work, msecs_to_jiffies(250));
}

If otx2_sync_tstamp() is running on another CPU, cancel_delayed_work()
returns false and the work re-queues, so the 250 ms PTP_OP_GET_CLOCK mailbox
traffic continues after the user asked for timestamping to be turned off.
The call site is process context under rtnl, so would
cancel_delayed_work_sync() be usable here? Note otx2_ptp_destroy() already
uses the sync variant, so this is only a state/overhead question, not a
use-after-free.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> index 95b0a1e7c936d..7b0a51f453cec 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> @@ -386,7 +386,7 @@ int otx2_ptp_init(struct otx2_nic *pfvf)
>  	struct ptp_req *req;
>  	int err;
>  
> -	if (is_otx2_lbkvf(pfvf->pdev)) {
> +	if (is_otx2_lbkvf(pfvf->pdev) || is_otx2_sdp_rep(pfvf->pdev)) {
>  		pfvf->ptp = NULL;
>  		return 0;
>  	}

[Severity: Medium]
Does this also remove the PTP hardware clock device from SDP representors?

SDP representors are probed by the VF driver (PCI_DEVID_OCTEONTX2_SDP_REP is
in the otx2_vf_id_table) and otx2vf_probe() calls otx2_ptp_init(vf), so up
to now these interfaces registered a PHC via ptp_clock_register() with
working gettime64/settime64/adjfine and the extts pin. With the early return
that registration never happens, and otx2_get_ts_info() falls back:

otx2_get_ts_info() {
	if (!pfvf->ptp)
		return ethtool_op_get_ts_info(netdev, info);
	...
	info->phc_index = otx2_ptp_clock_index(pfvf);

so /dev/ptpN for the interface and the phc_index reported by ethtool -T both
disappear.

The changelog only mentions the packet timestamping limitation. Could it
state that the PHC is being removed as well, and why that is acceptable,
given the Fixes tag will send this to stable trees?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 8d2d607bc92f9..94da021d452ed 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1135,7 +1135,8 @@ static void otx2_set_txtstamp(struct otx2_nic *pfvf, struct sk_buff *skb,
>  	__wsum skb_csum;
>  	u64 iova;
>  
> -	if (unlikely(!skb_shinfo(skb)->gso_size &&
> +	if (unlikely(pfvf->ptp && sq->timestamps &&
> +		     !skb_shinfo(skb)->gso_size &&
>  		     (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))) {

[Severity: High]
The changelog describes this as avoiding "a potential NULL dereference", but
is it actually closing a live one that has nothing to do with SDP
representors?

sq->timestamps is only allocated under two conditions:

otx2_sq_init() {
	...
	if (pfvf->ptp && qidx < pfvf->hw.tx_queues) {
		err = qmem_alloc(pfvf->dev, &sq->timestamps, qset->sqe_cnt,
				 sizeof(*sq->timestamps));

so it is NULL for LBK VFs and RVU_REP devices, where otx2_ptp_init() has
forced pfvf->ptp = NULL since long before SDP representor support, and it is
NULL for QoS/HTB send queues with qidx >= pfvf->hw.tx_queues on fully
PTP-capable PFs.

Before this patch the guard was only:

	if (unlikely(!skb_shinfo(skb)->gso_size &&
		     (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))) {

and the body dereferences both pointers:

		iova = sq->timestamps->iova + (sq->head * sizeof(u64));
		otx2_sqe_add_mem(sq, offset, NIX_SENDMEMALG_E_SETTSTMP, iova,
				 ptp_offset, pfvf->ptp->base_ns, udp_csum_crt);

SKBTX_HW_TSTAMP is set purely from the socket's SO_TIMESTAMPING request in
__sock_tx_timestamp() with no device capability check, so any unprivileged
socket asking for SOF_TIMESTAMPING_TX_HARDWARE and sending a non-GSO packet
over an LBK VF or a QoS SQ reaches those dereferences.

Since the only tag is Fixes: 2f7f33a09516 ("octeontx2-pf: Add representors
for sdp MAC"), stable trees that predate SDP representors will not pick up
this hunk and keep the oops. Would it make sense to split the otx2_txrx.c
change into its own patch with a Fixes tag pointing at the commit that
introduced the unguarded dereference? The errno and extack change in
otx2_config_hwtstamp_set() is also a separate user-visible change for the
pre-existing LBK VF case rather than part of the SDP fix.

[Severity: High]
Should the matching completion path be guarded too? otx2_snd_pkt_handler()
still dereferences both pointers with only the skb flag as a gate:

	if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) {
		timestamp = ((u64 *)sq->timestamps->base)[snd_comp->sqe_id];
		if (timestamp != 1) {
			timestamp = pfvf->ptp->convert_tx_ptp_tstmp(timestamp);
			err = otx2_ptp_tstamp2time(pfvf, timestamp, &tsns);

SKBTX_IN_PROGRESS lives in skb_shared_info, which skb_clone() shares, and it
is not cleared here, so it can have been set by a different transmit of the
same buffer. With a bridge or a tc mirred mirror spanning one PTP-capable
otx2 port and one port whose SQ has no timestamp area:

otx2_set_txtstamp()            /* PTP-capable port, sets the shared flag */
    skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;

otx2_snd_pkt_handler()         /* clone completing on the other port */
    timestamp = ((u64 *)sq->timestamps->base)[snd_comp->sqe_id];

sq->timestamps is NULL there (SDP rep, LBK VF, or any QoS SQ), so this reads
through a NULL pointer in NAPI context. Note otx2_ptp_tstamp2time(), called
two lines later, already does:

	if (!pfvf->ptp)
		return -ENODEV;

so the driver already treats pfvf->ptp as nullable in this exact path. This
patch newly creates the NULL-ptp state for SDP representors, which
previously had a registered ptp and allocated per-SQ timestamps.

[Severity: Medium]
On a PTP-capable PF with tc HTB offload, does the new sq->timestamps test
silently turn a per-queue resource gap into a silent capability gap?

QoS/HTB SQs have qidx >= pfvf->hw.tx_queues, so otx2_sq_init() never
allocates their timestamp area, while NIX_AF_LFX_TX_CFG.PTP_EN is set for
the whole LF and otx2_get_ts_info() keeps advertising:

	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
				SOF_TIMESTAMPING_TX_HARDWARE |

Packets egressing those queues now take the else-branch, no
NIX_SENDMEMALG_E_SETTSTMP SEND_MEM_S subdescriptor is emitted, and
SKBTX_IN_PROGRESS is never set, so two-step users get no hardware timestamp
at all. In HWTSTAMP_TX_ONESTEP_SYNC mode the Sync frame's originTimestamp
and correctionField are also left unpatched, so the frame goes out with a
stale value.

Would allocating the SETTSTMP scratch area for all SQs of an LF that can
have PTP_EN set be a better fix than the NULL test in the fast path?

[Severity: Medium]
This isn't something the patch introduces, but since the condition is being
touched: otx2_set_txtstamp() never consults OTX2_FLAG_TX_TSTAMP_ENABLED,
which otx2_config_hw_tx_tstamp() maintains:

	if (enable)
		pfvf->flags |= OTX2_FLAG_TX_TSTAMP_ENABLED;
	else
		pfvf->flags &= ~OTX2_FLAG_TX_TSTAMP_ENABLED;

That flag is never read in otx2_txrx.c. So on a PTP-capable interface where
userspace never enabled hardware TX timestamping, a socket that requested
both SOF_TIMESTAMPING_TX_SOFTWARE and SOF_TIMESTAMPING_TX_HARDWARE still
takes the hardware branch, skb_tx_timestamp() is never called, and the
hardware writes the "no timestamp" value 1 which otx2_snd_pkt_handler()
drops. The result is no timestamp of either kind. Should the enable flag be
part of this condition?

>  		if (unlikely(pfvf->flags & OTX2_FLAG_PTP_ONESTEP_SYNC &&
>  			     otx2_ptp_is_sync(skb, &ptp_offset, &udp_csum_crt))) {

[Severity: Medium]
This is a pre-existing issue rather than something added here, but it sits
directly behind the condition being modified. Can a short frame make
otx2_ptp_is_sync() read past skb->len?

The offset comes entirely from packet header values, and the message-type
byte is read without any skb->len, skb_headlen() or pskb_may_pull() check:

otx2_ptp_is_sync() {
	...
	case ETH_P_1588:
		if (network_depth)
			*offset = network_depth;
		else
			*offset = ETH_HLEN + nix_offload_hlen +
				  inner_vhlen;
	...
	msgtype = data + *offset;
	/* Check PTP messageId is SYNC or not */
	is_sync = !(*msgtype & 0xf);
}

For a 14-byte AF_PACKET SOCK_RAW frame with h_proto set to 0x88F7, that byte
is past the data. If the low nibble happens to be zero, otx2_set_txtstamp()
then writes 10 bytes at an offset derived from the same untrusted value:

			origin_tstamp = (struct ptpv2_tstamp *)
					((u8 *)skb->data + ptp_offset +
					 PTP_SYNC_SEC_OFFSET);
			ts = ns_to_timespec64(pfvf->ptp->tstamp);
			origin_tstamp->seconds_msb = htons((ts.tv_sec >> 32) & 0xffff);

and passes ptp_offset to the hardware as the in-packet correction-field
offset. The write can land up to roughly 44 bytes past skb->len; whether it
crosses skb_end_pointer() into skb_shared_info depends on the head buffer's
kmalloc slack, so this is speculative on that last point. Would a
pskb_may_pull() covering ptp_offset + PTP_SYNC_SEC_OFFSET +
sizeof(struct ptpv2_tstamp) be appropriate before both the read and the
write?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907032311.3228168-1-nshettyj%40marvell.com
