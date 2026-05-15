Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7433F6C5F
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870349; cv=none; b=tZUz09COSrNazJ2SlBZZBdRxxn9RoJarFxFYUop5wJdsMaF9JG442FD7QAqIV+aMb+id6lzr2+t/nxnDQ4Bk+CC7mdXaAdskhec9qa2Z/AvwcaF+OOcDattFomS6z7vS+1Aei13QtIvJ9jXKFXMJpSs/DEWzU34HUdM0+vF9L3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870349; c=relaxed/simple;
	bh=alyM4fL2zP9I3YpMAWZdGzHyvU+rcfKXgtXzmLlxz5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9FWvT3OPtyk65XK9yt1bk5JPIHq+f1hQ5DfuwhoAl1FqU3XqJbAVATVn+U3QsXGxEgdtFavOwNE32xJW9o3jhGl6EdhMeeZ8BpU58ZKBnPqnuYhMpSkzR3dx7NwLxn64fVMAeq4+f7jWmgsEiZRCdSTUsjJJV9jVHUTpDPFST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpcHhAaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpcHhAaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB3CC2BCB0;
	Fri, 15 May 2026 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778870347;
	bh=alyM4fL2zP9I3YpMAWZdGzHyvU+rcfKXgtXzmLlxz5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CpcHhAafYdNJIZjTmlcyy+G8z8ZDFrFHmttbjLFFxwIFrOpkjRX56KVyPUAvLagjb
	 iLsOA4Zj0zBM5MpYbSDsIEa8K10zAjinzUzdlWIYd/CG9lrYDPWruO4dNNkmcIUerq
	 CYjezSixDI/2YcqxP7oGISc9bd51+yvSbLUyNoZ7lpggwNoZwcNmy3TBWrWIOXiZQN
	 p9At37cn8+bMa7tlKH7/K1WrIp3Tyylk6vBU441PMaliOUG1JBUNBghF6Ey2FvlTu+
	 c16UGY/dVYVcXZPO8IdFZ8LjJipIVhf5XkzQTPHFi5hEl/ezAzH4k3N0SDbJE+uarL
	 shaqNZuF+lIWQ==
From: Simon Horman <horms@kernel.org>
To: przemyslaw.korba@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH iwl-net] ice: suppress DPLL errors during reset recovery
Date: Fri, 15 May 2026 19:38:52 +0100
Message-ID: <20260515183852.280895-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511083841.1078696-1-przemyslaw.korba@intel.com>
References: <20260511083841.1078696-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: suppress DPLL errors during reset recovery

This commit suppresses DPLL error logging and counter increments when the admin
queue returns EBUSY. The intent is to avoid unnecessary warnings and prevent
the DPLL periodic worker from being disabled during reset recovery.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 0704e92ab0430..78b8836b534b3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -784,7 +784,7 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
>  				   ret,
>  				   libie_aq_str(pf->hw.adminq.sq_last_status),
>  				   pin_type_name[pin_type], pin->idx);
> -	else
> +	else if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)

Could this check of sq_last_status race with other admin queue commands?

The sq_last_status field seems to be global state that is modified by any
admin queue command. If this is checked outside of the admin queue lock,
could another thread (like an ethtool operation) issue an admin queue
command and overwrite sq_last_status before this check runs?

If it gets overwritten to LIBIE_AQ_RC_OK, this would falsely evaluate as not
EBUSY and log the error anyway, incrementing the error counter.

[ ... ]

> @@ -2955,7 +2957,9 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
>  	    d->periodic_counter % dp->phase_offset_monitor_period == 0)
>  		ret = ice_dpll_pps_update_phase_offsets(pf, &phase_offset_ntf);

Does the reset recovery suppression also need to be applied inside
ice_dpll_pps_update_phase_offsets()?

If ice_aq_get_cgu_input_pin_measure() fails with EBUSY during reset recovery,
it looks like ice_dpll_pps_update_phase_offsets() only checks for
LIBIE_AQ_RC_EAGAIN before logging an error, which might still spam the log
with EBUSY errors.

>  	if (ret) {
> -		d->cgu_state_acq_err_num++;
> +		/* EBUSY is expected during reset recovery */
> +		if (pf->hw.adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
> +			d->cgu_state_acq_err_num++;
>  		/* stop rescheduling this worker */
>  		if (d->cgu_state_acq_err_num >
>  		    ICE_CGU_STATE_ACQ_ERR_THRESHOLD) {

By skipping the increment of the error counter on EBUSY, will this create an
unbounded polling loop?

Looking at the end of ice_dpll_periodic_work():

resched:
    kthread_queue_delayed_work(d->kworker, &d->work,
                               ret ? msecs_to_jiffies(10) :
                               msecs_to_jiffies(500));

If the firmware gets wedged and persistently returns EBUSY, the error
threshold will never be reached, and the worker will continue to hammer the
admin queue every 10ms forever. Is it expected to poll this frequently
without a backoff mechanism or an upper bound?
