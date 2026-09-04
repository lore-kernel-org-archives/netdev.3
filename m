Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9405480DF3;
	Fri,  4 Sep 2026 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522588; cv=none; b=C84qTSdjMFI1owI0BFixy1RGgCglwVzCR7xE0RiE8Rgj6y4h2OzbnuLwLBHHkSH64xImC4NCA+pk0FhZY1fUV81vceswtRRwLOvGjH5x+urGhfM9Q02Lm81KQ17vMWHTTZP8COJn+T9b2Gpg8lFSYwZg/9rPqVR2CUD1niwtfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522588; c=relaxed/simple;
	bh=vmEGvOKd2TDZkPb5PIj74hifwKPjIMn0AtvZdRg3h/k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVURCyakdyvq3YrEjxTgNbGYw6nngtzK49Mf4XSDDNLvhQNESsC/XKGFgxA+AIn+j5LsLfqFnPH/LQpy4AWeT1SidSlIexrYZpi9YvF3TU6ru0L1Nw98Z9KNNtiAGToXO28PDaMRjd81xWTEobGhORBTHL+tpb6MVthJK/iDRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa6KEj+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa6KEj+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC871F00A3D;
	Fri,  4 Sep 2026 11:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522586;
	bh=/DRb5Hvs6OhFmxwqUOQQE77wKJ3oO1v0QrtDvJVdFtY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sa6KEj+rPUzQE7k1y1nV2su3laVqEXU6DRILowSGmEkjqUqVhP9ct1j/70l76MhHm
	 kmqD84bGkrjWnE+neJAmjk+uX8YdEbkhDlw7G6rL92kejBc6rmZgcYgtuvouLgv9Cq
	 7UT8yp9AtWznyoOh8Wq9hRXmLeRQci4rQqQFyDHWf+d5XlEqYYq2IBgctss6l9vYHF
	 I2thpJHPPKfEq1MJg+d+dK9u5DB+DK1TsqQSfW/ucYt2EKhKcu4eI7QrJQ6e0Z/4dv
	 3gYNfVXOCaWYHkyVTmCwoAVfnhlOnoF2OxAvNcQdhBXcYZaEwjKpLhmqtvDlk1xupF
	 qS86o2XUpbS+Q==
Subject: Re: [PATCH net v2] octeontx2-pf: Fix ethtool timestamping
 capabilities for SDP representors
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rfranz@marvell.com,
 sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Fri, 04 Sep 2026 11:49:45 +0000
Message-ID: <178852258532.4131868.9280674038797217075@kernel.org>
In-Reply-To: <20260901114808.1701352-1-nshettyj@marvell.com>
References: <20260901114808.1701352-1-nshettyj@marvell.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 1 · High: 0 · Medium: 1 · Low: 0 (1)

- [Critical] Setting pfvf->ptp = NULL for SDP representors introduces an
  unprivileged-userspace-triggerable NULL pointer dereference in the…
- [Medium] Commit message describes a fix in otx2_get_ts_info() ("Fix
  this by checking if the device is an SDP representor and returning the…

Pre-existing issues:
- [Low] With pfvf->ptp forced to NULL for SDP representors, the two
  halves of the hwtstamp ndo pair disagree and the errno is not the…

--

octeontx2-pf: Fix ethtool timestamping capabilities for SDP representors

The patch adds is_otx2_sdp_rep() to the early-return condition in
otx2_ptp_init(), so SDP representors are left with pfvf->ptp == NULL and no
PTP clock is registered for them.  The intent is that ethtool -T on those
interfaces reports software-only timestamping.

A few questions below.

> octeontx2-pf: Fix ethtool timestamping capabilities for SDP representors
>
>     SDP representors do not support hardware timestamping. The current
>     implementation of otx2_get_ts_info incorrectly advertises hardware
>     timestamping capabilities and a PHC index to userspace for these
>     interfaces.
>
>     Fix this by checking if the device is an SDP representor and returning
>     the default software timestamping capabilities instead.

[Severity: Medium]
Does the changelog still match the code?  otx2_ethtool.c is not touched by
this patch, and otx2_get_ts_info() already had:

	if (!pfvf->ptp)
		return ethtool_op_get_ts_info(netdev, info);

so the ethtool behaviour changes only as a side effect of forcing
pfvf->ptp to NULL in otx2_ptp_init().

The wider effects of that are not described in the message body: no PTP
clock device is registered for SDP representors any more, otx2_sq_init()
skips the per-SQ sq->timestamps allocation because of

	if (pfvf->ptp && qidx < pfvf->hw.tx_queues)

and otx2_config_hwtstamp_set() now returns -ENODEV for these interfaces.

Could the subject and message be reworded to describe the change in
otx2_ptp_init() and list those consequences?  The v2 note about disabling
PTP initialization is below the '---' separator, so it does not appear in
git log for backporters.  It also looks like the '---' separator and the v2
changelog were accidentally committed into the message itself.

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

[Severity: Critical]
Can this NULL-dereference the transmit path on SDP representors?

otx2vf_probe() calls otx2_ptp_init(vf) for PCI_DEVID_OCTEONTX2_SDP_REP, so
after this change pfvf->ptp stays NULL and otx2_sq_init() never allocates
the write-back region:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:otx2_sq_init() {
	...
	if (pfvf->ptp && qidx < pfvf->hw.tx_queues) {
		err = qmem_alloc(pfvf->dev, &sq->timestamps, qset->sqe_cnt,
				 sizeof(*sq->timestamps));
	...
}

so sq->timestamps remains NULL for the lifetime of the netdev.

otx2_sq_append_skb() then calls otx2_set_txtstamp() on every transmit, and
that function gates the timestamping branch only on the skb flags:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:otx2_set_txtstamp() {
	if (unlikely(!skb_shinfo(skb)->gso_size &&
		     (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))) {
		...
		iova = sq->timestamps->iova + (sq->head * sizeof(u64));
		otx2_sqe_add_mem(sq, offset, NIX_SENDMEMALG_E_SETTSTMP, iova,
				 ptp_offset, pfvf->ptp->base_ns, udp_csum_crt);
	} else {
		skb_tx_timestamp(skb);
	}
}

There is no test of pfvf->ptp, sq->timestamps or
OTX2_FLAG_TX_TSTAMP_ENABLED here, so both sq->timestamps->iova and
pfvf->ptp->base_ns are dereferenced through NULL.

SKBTX_HW_TSTAMP comes straight from the socket option, with no check
against device capability:

net/socket.c:__sock_tx_timestamp() {
	...
	if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE)
		flags |= SKBTX_HW_TSTAMP_NOBPF;
	...
}

So an unprivileged setsockopt(SO_TIMESTAMPING,
SOF_TIMESTAMPING_TX_HARDWARE) plus one non-GSO send out an SDP representor
appears to be enough, even though otx2_config_hwtstamp_set() refuses the
ioctl with -ENODEV.

If the first dereference is survived, does the completion side hit the same
problem in NAPI context?

drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:otx2_snd_pkt_handler() {
	...
		timestamp = ((u64 *)sq->timestamps->base)[snd_comp->sqe_id];
		if (timestamp != 1) {
			timestamp = pfvf->ptp->convert_tx_ptp_tstmp(timestamp);
	...
}

Before this patch SDP representors had a fully initialised pfvf->ptp and an
allocated sq->timestamps, so this path looks new for this device class.
Would it work to gate only the reporting paths on is_otx2_sdp_rep(), or
alternatively add the missing guard in otx2_set_txtstamp():

	if (!pfvf->ptp || !sq->timestamps) {
		skb_tx_timestamp(skb);
		return;
	}

[Severity: Low]
This isn't a bug introduced by this patch, but routing SDP representors
into the !pfvf->ptp path exposes an asymmetry between the two hwtstamp
callbacks.  otx2_config_hwtstamp_get() has no ptp check and succeeds,
returning the zeroed pfvf->tstamp (HWTSTAMP_TX_OFF / HWTSTAMP_FILTER_NONE):

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_config_hwtstamp_get() {
	*config = pfvf->tstamp;
	return 0;
}

while the set side rejects every request, including one that re-applies the
state just reported:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_config_hwtstamp_set() {
	if (!pfvf->ptp)
		return -ENODEV;
	...
}

Since ethtool now advertises software-only timestamping through
ethtool_op_get_ts_info(), is -ENODEV the right errno here?  The netdev is
registered and present, and dev_get_hwtstamp()/dev_set_hwtstamp() in
net/core/dev_ioctl.c use -EOPNOTSUPP for the missing-operation case.  The
existing code predates this patch and already applied to LBK VFs.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901114808.1701352-1-nshettyj%40marvell.com
