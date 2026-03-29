Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A32E0413;
	Sun, 29 Mar 2026 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774819204; cv=none; b=MfuGl6MvfpTpOhuE2Cf6UD2BJmGKopZtnwbwvq44hLyk67f9TFLUBgTbBy//ASDHhbb1sHXzrGOZNtpTfIKdAPOih5gaM+yGujH93xXoydY5ffMqU6s7UuQFzIXAXhCbPmfH47WLKwlfp7y5pL5Bjx3aIvSgPF7UkgutlrIdoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774819204; c=relaxed/simple;
	bh=kAo9tLjGKCihc6z2YnjSXgOzlhPl2lvECWwCBnkE4SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODSC3igUB6jFmmph3L8GaYKe3/XBZvulS0K9QehlDrigyFEyRFsOoRXMqBj0TUgIaUVlwZ2YuezM0/Uc3d1c3DNFBD3LaTbt1QbGnii+Q1mET7tMHLoFBgkQ3qJD9or22dmy5l6E8sYOnAFI5wruUCyb8SWyikoVA3vcbPt6Cvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwMbK1ow; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwMbK1ow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70679C116C6;
	Sun, 29 Mar 2026 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774819204;
	bh=kAo9tLjGKCihc6z2YnjSXgOzlhPl2lvECWwCBnkE4SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwMbK1ow8cAGT5E9dm/BWee23Je6zD8Gr9ad/W1ASz2BjlNlG+Bztv09F6jpYpcvp
	 dCXt7ybrcE29TksIeJ4qlawV2TTljeMFSNQ43by96ZFHRCQxpXcM+omce1wMo3UJlZ
	 R1qYtU9dVEEMS99avXpLoTaomFppYRYOOEh0vWU0gD/v/aBRHMo58AG8pwQuJJPPjE
	 bNFkbu3Lj3LRYwujF9GWrHgeICDm6sOxBJWWBuXIjpEpJsMMuiqC7UGBz5yByOBpM1
	 nunSKd75+j4xOqBYdANR0kZKERWuLOegSOSRUjD4s56eDaJu3fc1IQDD50+h6GuWt1
	 N3svh7bhj5t/g==
From: Jakub Kicinski <kuba@kernel.org>
To: hramamurthy@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	joshwash@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	willemb@google.com,
	nktgrg@google.com,
	jfraker@google.com,
	ziweixiao@google.com,
	maolson@google.com,
	thostet@google.com,
	jordanrhee@google.com,
	jefrogers@google.com,
	alok.a.tiwari@oracle.com,
	yyd@google.com,
	linux-kernel@vger.kernel.org,
	namangulati@google.com
Subject: Re: [PATCH net-next v2 3/3] gve: implement PTP gettimex64
Date: Sun, 29 Mar 2026 14:20:02 -0700
Message-ID: <20260329212002.2875815-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326224527.1044097-4-hramamurthy@google.com>
References: <20260326224527.1044097-4-hramamurthy@google.com>
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
Subject: gve: implement PTP gettimex64

This commit implements the PTP gettimex64 function to enable chrony and
phc2sys to synchronize the system clock to the NIC clock. It reads the
NIC timestamp along with pre and post system cycle counters to minimize
the uncertainty window.

> diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
> index 140b8fbce4f4..bea794541f30 100644
> --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> @@ -10,28 +10,203 @@

[ ... ]

> +static int gve_adminq_read_timestamp(struct gve_priv *priv,
> +				     cycles_t *pre_cycles,
> +				     cycles_t *post_cycles)
> +{
> +	unsigned long delay_us = 1000;
> +	int retry_count = 0;
> +	int err;
> +
> +	lockdep_assert_held(&priv->nic_ts_read_lock);
> +
> +	do {
> +		*pre_cycles = get_cycles();
> +		err = gve_adminq_report_nic_ts(priv, priv->nic_ts_report_bus);
> +
> +		/* Ensure cycle counter is sampled after AdminQ cmd returns */
> +		rmb();
> +		*post_cycles = get_cycles();

Are execution barriers needed around get_cycles() here? rmb() orders
memory accesses, but the CPU might still speculatively execute the cycle
counter reads out of order with respect to the AdminQ commands.

Could this speculative reordering cause the strict bounds validation in
gve_ptp_gettimex64() to fail spuriously?

[ ... ]

>  static int gve_ptp_gettimex64(struct ptp_clock_info *info,
>  			      struct timespec64 *ts,
>  			      struct ptp_system_timestamp *sts)
>  {
> -	return -EOPNOTSUPP;
> +	struct gve_ptp *ptp = container_of(info, struct gve_ptp, info);
> +	struct gve_sysclock_sample sysclock = {0};
> +	struct gve_priv *priv = ptp->priv;
> +	struct system_time_snapshot snap;
> +	u64 nic_ts;
> +	int err;
> +
> +	/* Take system clock snapshot before sampling cycle counters */
> +	if (sts)
> +		ktime_get_snapshot(&snap);
> +
> +	err = gve_clock_nic_ts_read(priv, &nic_ts, &sysclock);

Could the system time snapshot become stale here? 

If priv->nic_ts_read_lock is contended, or if gve_adminq_read_timestamp()
retries and sleeps, the snapshot might be taken significantly before the
actual hardware read.

Would it be more accurate to take the snapshot immediately before reading the
hardware, inside the mutex?

> +	if (err)
> +		return err;
> +
> +	if (sts) {
> +		/* Reject samples with out of order system clock values */
> +		if (!(sysclock.host_pre_cycles <= sysclock.nic_pre_cycles &&
> +		      sysclock.nic_pre_cycles  <= sysclock.nic_post_cycles &&
> +		      sysclock.nic_post_cycles <= sysclock.host_post_cycles)) {
> +			dev_err_ratelimited(&priv->pdev->dev,
> +					    "AdminQ system clock cycle counts out of order. Expecting %llu <= %llu <= %llu <= %llu\n",
> +					    (u64)sysclock.host_pre_cycles,
> +					    sysclock.nic_pre_cycles,
> +					    sysclock.nic_post_cycles,
> +					    (u64)sysclock.host_post_cycles);
> +			return -EBADMSG;

How does this behave on architectures where get_cycles() is not implemented
and returns 0, or with older firmware that leaves nic_pre_cycles and
nic_post_cycles as 0?

It looks like the bounds check would unconditionally fail and return -EBADMSG.
Since userspace tools like chrony usually expect -EOPNOTSUPP for unsupported
extended ioctls to fall back to basic PTP ioctls, will returning -EBADMSG
cause a hard failure for clock synchronization?

[ ... ]

> @@ -132,7 +307,7 @@ int gve_init_clock(struct gve_priv *priv)
>  		goto release_ptp;
>  	}
>  	mutex_init(&priv->nic_ts_read_lock);
> -	err = gve_clock_nic_ts_read(priv, &nic_raw);
> +	err = gve_clock_nic_ts_read(priv, &nic_raw, NULL);
>  	if (err) {
>  		dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n", err);
>  		goto release_nic_ts_report;

Is there a race condition exposing the PTP device to userspace before its
resources are fully initialized?

Looking at gve_init_clock(), gve_ptp_init() is called before allocating
nic_ts_report and initializing nic_ts_read_lock:

    err = gve_ptp_init(priv);
    if (err)
        return err;

    priv->nic_ts_report = dma_alloc_coherent(...);
    ...
    mutex_init(&priv->nic_ts_read_lock);

If a concurrent userspace process immediately invokes the
PTP_SYS_OFFSET_EXTENDED ioctl after gve_ptp_init() registers the /dev/ptpX
device, could it call gve_ptp_gettimex64() and attempt to lock the
uninitialized mutex or dereference the NULL nic_ts_report pointer?

Additionally, in the error path for gve_init_clock():

    release_nic_ts_report:
        mutex_destroy(&priv->nic_ts_read_lock);
        dma_free_coherent(...);
        priv->nic_ts_report = NULL;
    release_ptp:
        gve_ptp_release(priv);

Could destroying the mutex and freeing the memory before gve_ptp_release()
create a use-after-free window if an ioctl is currently running?
