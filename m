Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B4329391
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310667; cv=none; b=eITdxnOZvKvDij+ZBeNWvLUVHO/TGE1EMi6FqcFb2WGPbiGq9vRI/NJFgaIVC87UfTL75XfRivykwREA4UzQEFUR4pY7VVvHU0/EoWK0Wd+vvFmGD47Dqk1tH/VXDkr+yRlA/ZNmTWLM0uV4dsgzECavkQ/eS+HDdVFKm+zj5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310667; c=relaxed/simple;
	bh=qrLiLXSbpKm418GppfuyArsNKguL4gSRqF57ZXsh2o0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4/PFbqz1Am8mU3Yca8dlIEFUEIjIHE/5P76Yzy4SPyx23OVatj287uqBVRkrVpocIpr2JrLgYsOzKO0+R3YRMZoPdH3Emch9GphDA4z7AGrZulTVv9g9L+E+vEkjr61fSDu6JRC0jk5e+DZRtKvErO15rOOGrgjax15jQvZgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwuaQEE/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwuaQEE/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EF51F000E9;
	Wed,  2 Sep 2026 00:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788310665;
	bh=0E31ylpq8cojEHHyuFLuJiEdvges6A1wKF5cEAt3OZE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UwuaQEE/rDhh+Wyt9VIBCVlk5iYTxrnCu7EAAG+F4WIEravoj623/WXUkuRm+xt7c
	 UubQZfV7MbP4GEB1Z6dIDppMKbEvYbYzSrjXlqzh5IB7wI0zzf5gzAVLN163DXHoLM
	 ExGQRqAKX5AAn1HpFSUeeIQtxAr8AeQIzLjUYpXLUA7qNCOgyq8k8i8NdyjKNVGWwe
	 /yAqMJKbfGBOqxVjCGGXSGn5L2/UoGlQWjy9rfS0CssX9+OSnj+cIzsbtdrC397Yhf
	 t5muWIQJ/2dBc2/Xctvs08FFssHfa02AC7r63zZpjoyP05GqCLwKMMwzWJ3KP4J8ND
	 /8CO6zG7y5Jww==
Subject: Re: [net,v2] net: stmmac: re-apply taprio offload in __stmmac_open()
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, rayagond@vayavyalabs.com
Date: Wed, 02 Sep 2026 00:57:44 +0000
Message-ID: <178831066405.3394541.2972817415810002471@kernel.org>
In-Reply-To:
 <20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com>
References:
 <20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 3 (1) · Medium: 3 (1) · Low: 0

- [High] Incomplete fix: the taprio/EST offload is re-applied only in
  __stmmac_open(); the second caller of stmmac_hw_setup(),…
- [High] The new EST re-apply failure branch in __stmmac_open()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:4166-4170) does…
- [High] Divide-by-zero kernel oops reachable from a plain interface
  down/up after a rejected taprio replace.
- [Medium] __stmmac_open() calls stmmac_setup_est() with a comment
  asserting the re-apply happens 'after PTP is up', but the guard is…
- [Medium] A transient EST programming failure permanently suppresses the
  newly added restoration.
- [Medium] Lock-scope regression on priv->est->enable, which struct
  stmmac_priv documents est_lock as protecting ('/* Protect est…

Pre-existing issues:
- [High] priv->est is published to concurrent readers across several
  disjoint est_lock sections in tc_taprio_configure(): memset(priv->est,…
- [Medium] In stmmac_adjust_time()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:86-89) the code sets…

--

net: stmmac: re-apply taprio offload in __stmmac_open()

The core soft reset in stmmac_init_dma_engine() clears the MTL_EST registers,
so this patch re-applies the taprio offload from __stmmac_open() after PTP is
brought up, recomputing the base time from the reserved base time and the
current PTP time.  The open, PTP adjust and taprio configure paths are
factored into a new stmmac_setup_est() helper.

Link: https://lore.kernel.org/r/20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> index afc516059b89..bbebd33c8a88 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> @@ -80,6 +80,39 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
>  	return 0;
>  }
>  
> +int stmmac_setup_est(struct stmmac_priv *priv)
> +{
> +	struct timespec64 current_time, time;
> +	ktime_t current_time_ns, basetime;
> +	u64 cycle_time;
> +	int err;
> +
> +	mutex_lock(&priv->est_lock);
> +
> +	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> +	current_time_ns = timespec64_to_ktime(current_time);
> +
> +	time.tv_nsec = priv->est->btr_reserve[0];
> +	time.tv_sec = priv->est->btr_reserve[1];
> +	basetime = timespec64_to_ktime(time);
> +
> +	cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC + priv->est->ctr[0];
> +
> +	time = stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time);

[Severity: High]

Can cycle_time be zero at this point?

tc_taprio_configure() commits the enable flag before it validates the
per-entry values:

	mutex_lock(&priv->est_lock);
	priv->est->gcl_size = size;
	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
	mutex_unlock(&priv->est_lock);

	for (i = 0; i < size; i++) {
		s64 delta_ns = qopt->entries[i].interval;
		...
		if (delta_ns > GENMASK(wid - 1, 0))
			return -ERANGE;

Those failures return directly instead of taking the disable: label, priv->est
was just zeroed, and ctr[]/btr_reserve[] are only written further down.  So a
rejected replace (for example sched-entry interval 1000000 when
dma_cap.estwid is 0x1, which caps the interval at 65535) leaves
{enable = true, ctr = {0, 0}, btr_reserve = {0, 0}}.

sch_taprio leaves q->offloaded false when ndo_setup_tc fails and never sends
TAPRIO_CMD_DESTROY afterwards, so that state stays around.

A plain ip link set dev X up then walks:

__stmmac_open() -> stmmac_setup_est() -> stmmac_calc_tas_basetime()

	n = div64_s64(ktime_sub_ns(current_time, old_base_time),
		      cycle_time);

with cycle_time == 0 (basetime 0 is not after the PTP time, so the else branch
is taken).  Is this a divide error inside ndo_open, which runs under
rtnl_lock?  Would a sanity check of ctr[] and gcl_size in stmmac_setup_est(),
or clearing enable on the validation failures in tc_taprio_configure(), be
preferable?

> +	priv->est->btr[0] = (u32)time.tv_nsec;
> +	priv->est->btr[1] = (u32)time.tv_sec;
> +
> +	err = stmmac_est_configure(priv, priv, priv->est,
> +				   priv->plat->clk_ptp_rate);
> +
> +	mutex_unlock(&priv->est_lock);
> +
> +	if (err)
> +		netdev_err(priv->dev, "failed to re-configure EST\n");
> +
> +	return err;
> +}
> +

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d576059c04df..b30036428188 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -4153,11 +4154,22 @@ static int __stmmac_open(struct net_device *dev,
>  	ret = stmmac_hw_setup(dev);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> -		goto init_error;
> +		return ret;
>  	}
>  
>  	stmmac_setup_ptp(priv);
>  
> +	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
> +	 * registers, so re-apply the taprio offload after PTP is up.
> +	 */
> +	if (priv->est && priv->est->enable) {

[Severity: High]

Does the resume path need the same treatment?  stmmac_hw_setup() has two
callers, __stmmac_open() and stmmac_resume().  stmmac_resume() runs the same
DMA/core soft reset that wipes MTL_EST and then only calls
stmmac_init_timestamping(), never stmmac_setup_est():

stmmac_resume()
	ret = stmmac_hw_setup(ndev);
	...
	stmmac_init_timestamping(priv);

	stmmac_init_coalesce(priv);

Nothing in stmmac_suspend() or __stmmac_release() clears priv->est->enable, so
after a suspend/resume cycle with taprio offloaded the flag is still true
while the hardware block has EEST cleared and an empty gate list, and the
programmed base time is stale because stmmac_init_timestamping() reinitialises
the systime counter.  Isn't that exactly the divergence the commit message
sets out to remove?

[Severity: Medium]

The comment says the re-apply happens "after PTP is up", but is that
guaranteed?  stmmac_setup_ptp() returns void and swallows both errors:

static void stmmac_setup_ptp(struct stmmac_priv *priv)
{
	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
	if (ret < 0)
		netdev_warn(...);

	if (stmmac_init_timestamping(priv) == 0)
		stmmac_ptp_register(priv);
}

Only stmmac_init_tstamp_counter() programs TCR, the sub-second increment and
the initial systime, so when stmmac_init_timestamping() fails the MAC system
time counter stays in its post-reset, non-running state.  stmmac_setup_est()
then reads that counter through priv->ptp_clock_ops.gettime64(), derives
EST_BTR from it and sets EEST, arming the gate list against a time base that
does not advance.  Should the guard here also depend on PTP having come up
successfully?

> +		ret = stmmac_setup_est(priv);
> +		if (ret < 0) {
> +			priv->est->enable = false;
> +			return ret;
> +		}
> +	}

[Severity: High]

Does this bare return skip the unwind that is required at this stage?

By this point stmmac_hw_setup() has already done stmmac_mac_set(..., true) and
stmmac_start_all_dma(), and stmmac_setup_ptp() has done
clk_prepare_enable(priv->plat->clk_ptp_ref) plus, on success,
stmmac_ptp_register().  The pre-existing label just below does the matching
teardown:

irq_error:
	phylink_stop(priv->phylink);

	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);

	stmmac_release_ptp(priv);

Both callers treat the return as an ordinary open failure and free the rings
the running DMA engine is programmed with:

stmmac_open() -> err_dma_resources:
	free_dma_desc_resources(priv, dma_conf);
	kfree(dma_conf);

stmmac_change_mtu()
	ret = __stmmac_open(dev, dma_conf);
	if (ret) {
		free_dma_desc_resources(priv, dma_conf);
		kfree(dma_conf);

Can the MAC/DMA keep fetching TX descriptors and writing RX frames into that
freed coherent memory?  Does this also leak the clk_ptp_ref enable count and
leave a registered PTP clock behind, so that a later successful open calls
ptp_clock_register() again over priv->ptp_clock and re-runs
rwlock_init(&priv->ptp_lock) and mutex_init(&priv->aux_ts_lock) on live locks?

Would jumping to a label that performs phylink_stop()/DMA stop plus
stmmac_release_ptp() be more appropriate here?

[Severity: Medium]

Separately, does clearing priv->est->enable here make the failure permanent?

est_write() can return -ETIMEDOUT from readl_poll_timeout() on
EST_GCL_CONTROL.SRWO before est_configure() ever writes EST_CONTROL, so this
can be a transient programming failure.  Neither stmmac_open() nor
stmmac_change_mtu() removes the attached taprio offload, and sch_taprio keeps
the qdisc installed, so when userspace retries ip link set dev X up the new
block is skipped because enable is now false: the open succeeds with EST
disabled in hardware, taprio still reported as offloaded and no error
reported.  Recovery then requires deleting and re-adding the qdisc.  Is that
the intended behaviour?

> +
>  	stmmac_init_coalesce(priv);
>  
>  	phylink_start(priv->phylink);
> @@ -4181,7 +4193,7 @@ static int __stmmac_open(struct net_device *dev,
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  
>  	stmmac_release_ptp(priv);
> -init_error:
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 960249960004..917ef7ddcae6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c

[ ... ]

> @@ -84,30 +84,8 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  
>  	/* Calculate new basetime and re-configured EST after PTP time adjust. */
>  	if (est_rst) {
> -		struct timespec64 current_time, time;
> -		ktime_t current_time_ns, basetime;
> -		u64 cycle_time;
> -
> -		mutex_lock(&priv->est_lock);
> -		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> -		current_time_ns = timespec64_to_ktime(current_time);
> -		time.tv_nsec = priv->est->btr_reserve[0];
> -		time.tv_sec = priv->est->btr_reserve[1];
> -		basetime = timespec64_to_ktime(time);
> -		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
> -			     priv->est->ctr[0];
> -		time = stmmac_calc_tas_basetime(basetime,
> -						current_time_ns,
> -						cycle_time);
> -
> -		priv->est->btr[0] = (u32)time.tv_nsec;
> -		priv->est->btr[1] = (u32)time.tv_sec;
>  		priv->est->enable = true;
> -		ret = stmmac_est_configure(priv, priv, priv->est,
> -					   priv->plat->clk_ptp_rate);
> -		mutex_unlock(&priv->est_lock);
> -		if (ret)
> -			netdev_err(priv->dev, "failed to configure EST\n");
> +		stmmac_setup_est(priv);
>  	}

[Severity: Medium]

Is the lock scope on priv->est->enable still correct after the refactor?

struct stmmac_priv documents est_lock as "Protect est parameters".  Here the
store to priv->est->enable now happens outside est_lock, and the hardware
programming happens in a separate critical section inside stmmac_setup_est().
The new code in __stmmac_open() also reads and writes the same flag with no
lock at all:

	if (priv->est && priv->est->enable) {
		ret = stmmac_setup_est(priv);
		if (ret < 0) {
			priv->est->enable = false;

rtnl gives no exclusion against clock_adjtime, which becomes reachable as soon
as stmmac_ptp_register() has run a few lines earlier in the same function.
Can the open path observe enable == false in the middle of an adjust and skip
the re-apply, or can its enable = false store be lost to the unlocked
enable = true here?  Can a taprio destroy holding est_lock clear enable and
program the disabled state while this path stores true and re-arms a schedule
that was just destroyed?

Would passing the desired enable state into stmmac_setup_est() and
re-validating it after taking est_lock keep the state transition and the
programming in one section?

[Severity: Medium]

This isn't a bug introduced by this patch, but the return value of the EST
re-programming is still dropped here, and stmmac_adjust_time() returns 0
unconditionally.  EEST and EST_INT_EN were explicitly cleared a few lines
above before the systime adjust:

		priv->est->enable = false;
		stmmac_est_configure(priv, priv, priv->est,
				     priv->plat->clk_ptp_rate);

so if stmmac_setup_est() fails (est_write() SRWO poll timeout, or -EINVAL for
clk_ptp_rate == 0) the MTL_EST block stays disabled while priv->est->enable
remains true, which is the same divergence described in the commit message.
The other two callers of the new helper do check the result.  Since the helper
now returns an error, would it make sense to propagate it here too, or at
least roll priv->est->enable back?

>  
>  	return 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 14cabe76e53e..b41df317d73c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -1069,34 +1069,23 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	}
>  
>  	mutex_lock(&priv->est_lock);
> -	/* Adjust for real system time */
> -	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
> -	current_time_ns = timespec64_to_ktime(current_time);
> -	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
> -					qopt->cycle_time);
> -
> -	priv->est->btr[0] = (u32)time.tv_nsec;
> -	priv->est->btr[1] = (u32)time.tv_sec;
>  
> -	qopt_time = ktime_to_timespec64(qopt->base_time);
> -	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
> -	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
> +	time = ktime_to_timespec64(qopt->base_time);
> +	priv->est->btr_reserve[0] = (u32)time.tv_nsec;
> +	priv->est->btr_reserve[1] = (u32)time.tv_sec;
>  
>  	ctr = qopt->cycle_time;
>  	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
>  	priv->est->ctr[1] = (u32)ctr;
>  
>  	priv->est->ter = qopt->cycle_time_extension;
> -
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
> -	ret = stmmac_est_configure(priv, priv, priv->est,
> -				   priv->plat->clk_ptp_rate);
>  	mutex_unlock(&priv->est_lock);
> -	if (ret) {
> -		netdev_err(priv->dev, "failed to configure EST\n");
> +
> +	ret = stmmac_setup_est(priv);
> +	if (ret)
>  		goto disable;
> -	}

[Severity: High]

This is a pre-existing issue, but since stmmac_setup_est() is now the single
programming helper shared by three contexts, is the split publication of
priv->est safe?

tc_taprio_configure() publishes the configuration across four disjoint
est_lock sections: the memset of priv->est in one, gcl_size/enable in a
second, btr_reserve/ctr/ter/max_sdu in this third one, and the hardware
programming in stmmac_setup_est() as the fourth.  The gate control list itself
is written with no lock held at all:

		priv->est->gcl[i] = delta_ns | (gates << wid);

stmmac_adjust_time() runs without rtnl and, once it has latched est_rst, calls
stmmac_setup_est() unconditionally, which reads ctr[] under est_lock:

	cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC + priv->est->ctr[0];

	time = stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time);

If it acquires est_lock in the window after

		mutex_lock(&priv->est_lock);
		memset(priv->est, 0, sizeof(*priv->est));
		mutex_unlock(&priv->est_lock);

and before ctr[] is rewritten here, cycle_time is 0 and
stmmac_calc_tas_basetime() reaches div64_s64(..., 0).  The window spans the
unlocked gcl[] build loop, so it is not a single instruction.  Can a
concurrent tc qdisc replace and PTP time step on a taprio-offloaded port hit
this divide, or program the hardware from a half-built gate list?  Would
publishing priv->est in one est_lock section, and adding a cycle_time check in
stmmac_setup_est(), close both?

>  
>  	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
>  					      qopt->mqprio.preemptible_tcs);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92%40oss.qualcomm.com
