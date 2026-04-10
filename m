Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D464C81;
	Fri, 10 Apr 2026 03:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775791008; cv=none; b=cuO3cTbZr1X+xxINVmyzQtxhHE5qa/J/Xkgy261Of5ROHDBU/jWL2rmOq7OTJQu47oqTvm66Q+jpi+mjdAvjp9dyjXOouWQA1MgUjOsNAyq3K8nBBbfOh5fN9SPX/MW6OJgns2kigVb3Uh+raGZsxhDqneSc1Q9yWX79tcl8/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775791008; c=relaxed/simple;
	bh=e7FUhKW+stjQbSZ1O/68uzOSpp/0q/w+jTRFIJ7iLZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXT06ag1g8kDV0bIT72y6uF9/Y/LS35aK9LaiTp3nAGkLOlpALJS2HroCe9CMlHbyAMfjBXBLbv99cgsnICVXdIOsx6tHzzGZnsTqxUleolk7vyLYGDDY5TMG3mEnDiCWn5lZmFxb4EVp4jJJAR4ogyTBU42MkQHzf4Dr22AuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhsIzVpH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhsIzVpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43876C116C6;
	Fri, 10 Apr 2026 03:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775791008;
	bh=e7FUhKW+stjQbSZ1O/68uzOSpp/0q/w+jTRFIJ7iLZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MhsIzVpHb32uq2bvrZdvn5bUHqFoV28g/Vgs1K6QqrMkVfTk8jHM/6aIpBMf30xTy
	 bCMqlJi09PfQF2EOxpfMvuYhIa+FeNyvQXPQvtvZpWSkYXy8SPDQCrAOP+wIAihVpP
	 UE0if+Nm4Fm2eKO/+tUSpe1qq3wnPJjwxqPHO+sJyzPQ0igVMCzi5DNTPfUuZoGInv
	 zwjSkyyHM2BiozoZ2GXh18uhzfGDP/vI2KjM6bLcjKyuO0gwSxG1Zvdnk0JHgi2Bvu
	 g9R7P3AB5zC35tYuXzIB/7u5sGGV7HcqdSAHUfjS/UFo31ANAuIJbdEKbrpFyOrfmk
	 tF0FbxudZT+Eg==
Date: Thu, 9 Apr 2026 20:16:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com, willemb@google.com, nktgrg@google.com,
 jfraker@google.com, ziweixiao@google.com, maolson@google.com,
 thostet@google.com, jordanrhee@google.com, jefrogers@google.com,
 alok.a.tiwari@oracle.com, yyd@google.com, jacob.e.keller@intel.com,
 linux-kernel@vger.kernel.org, Naman Gulati <namangulati@google.com>
Subject: Re: [PATCH net-next v4 3/3] gve: implement PTP gettimex64
Message-ID: <20260409201646.6af5235d@kernel.org>
In-Reply-To: <20260406234002.3610542-4-hramamurthy@google.com>
References: <20260406234002.3610542-1-hramamurthy@google.com>
	<20260406234002.3610542-4-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Apr 2026 23:40:02 +0000 Harshitha Ramamurthy wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> Enable chrony and phc2sys to synchronize system clock to NIC clock.
> 
> The system cycle counters are sampled by the device to minimize the
> uncertainty window. If the system times are sampled in the host, the
> delta between pre and post readings is 100us or more due to AQ command
> latency. The system times returned by the device have a delta of ~1us,
> which enables significantly more accurate clock synchronization.

Interesting. I'd like this looked over by David Woodhouse and tglx.
Please repost after the merge window or send them an RFC.

> +static int gve_ptp_read_timestamp(struct gve_ptp *ptp, cycles_t *pre_cycles,
> +				  cycles_t *post_cycles,
> +				  struct system_time_snapshot *snap)
> +{
> +	unsigned long delay_us = 1000;
> +	int retry_count = 0;
> +	int err;
> +
> +	lockdep_assert_held(&ptp->nic_ts_read_lock);
> +
> +	do {

This can't be a for () loop with 5 iterations?

> +		if (snap)
> +			ktime_get_snapshot(snap);
> +
> +		*pre_cycles = get_cycles();
> +		err = gve_adminq_report_nic_ts(ptp->priv,
> +					       ptp->nic_ts_report_bus);
> +
> +		/* Prevent get_cycles() from being speculatively executed
> +		 * before the AdminQ command
> +		 */
> +		rmb();
> +		*post_cycles = get_cycles();
> +		if (likely(err != -EAGAIN))
> +			return err;
> +
> +		fsleep(delay_us);
> +
> +		/* Exponential backoff */
> +		delay_us *= 2;
> +		retry_count++;
> +	} while (retry_count < 5);
> +
> +	return -ETIMEDOUT;
> +}
> +
>  /* Read the nic timestamp from hardware via the admin queue. */
> -static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw)
> +static int gve_clock_nic_ts_read(struct gve_ptp *ptp, u64 *nic_raw,
> +				 struct gve_sysclock_sample *sysclock)
>  {
> +	cycles_t host_pre_cycles, host_post_cycles;
> +	struct gve_nic_ts_report *ts_report;
>  	int err;
>  
>  	mutex_lock(&ptp->nic_ts_read_lock);
> -	err = gve_adminq_report_nic_ts(ptp->priv, ptp->nic_ts_report_bus);
> -	if (err)
> +	err = gve_ptp_read_timestamp(ptp, &host_pre_cycles, &host_post_cycles,
> +				     sysclock ? &sysclock->snapshot : NULL);
> +	if (err) {
> +		dev_err_ratelimited(&ptp->priv->pdev->dev,
> +				    "AdminQ timestamp read failed: %d\n", err);
>  		goto out;
> +	}
>  
> -	*nic_raw = be64_to_cpu(ptp->nic_ts_report->nic_timestamp);
> +	ts_report = ptp->nic_ts_report;
> +	*nic_raw = be64_to_cpu(ts_report->nic_timestamp);
> +
> +	if (sysclock) {
> +		sysclock->nic_pre_cycles = be64_to_cpu(ts_report->pre_cycles);
> +		sysclock->nic_post_cycles = be64_to_cpu(ts_report->post_cycles);
> +		sysclock->host_pre_cycles = host_pre_cycles;
> +		sysclock->host_post_cycles = host_post_cycles;
> +	}
>  
>  out:
>  	mutex_unlock(&ptp->nic_ts_read_lock);
>  	return err;
>  }
>  
> +struct gve_cycles_to_clock_callback_ctx {
> +	u64 cycles;
> +};
> +
> +static int gve_cycles_to_clock_fn(ktime_t *device_time,
> +				  struct system_counterval_t *system_counterval,
> +				  void *ctx)

Does this do anything GVE specific??

> +{
> +	struct gve_cycles_to_clock_callback_ctx *context = ctx;
> +
> +	*device_time = 0;
> +
> +	system_counterval->cycles = context->cycles;
> +	system_counterval->use_nsecs = false;
> +
> +	if (IS_ENABLED(CONFIG_X86))
> +		system_counterval->cs_id = CSID_X86_TSC;
> +	else if (IS_ENABLED(CONFIG_ARM64))
> +		system_counterval->cs_id = CSID_ARM_ARCH_COUNTER;
> +	else
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
-- 
pw-bot: cr
