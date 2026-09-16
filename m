Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481838DC6E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521145; cv=none; b=rQ9bTyDCADfLCQc5dm1u6XcSA6ZuN07j9JpcUBl59CbPP4YpQ6YaZE6prdt3rTZw+L4Hj688dNPixhjJsDU6rq8Ym1GM8ivFUPLjOgnIUxM3SPcI8uIiY1GQNzK0lGS5k+tn+Eebzxqd8ZZXqBmp6sTxofv8bpLr5Pz1XIwbj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521145; c=relaxed/simple;
	bh=MBR0O+wPz5gm8iBHY9solWnfUm5LpRHBJkB69NIvgVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBMlN17ehCIoEZI1YamDDILyFExmlJRlQ7k+C5+Wrr6JvBGI6wYgxHyA5XBvUl9oyzJrB9Q7Cs1C7nWdaJBqDrn+R7zJ+APJRz2upOIiWege8pOP9REz+UEBbOlgyabXMWK5gd1Pi85EOMeI6v1EtBf5ppsRW3zblFMdyUWjWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfnl4RL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfnl4RL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E284A1F000FF;
	Wed, 16 Sep 2026 01:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521144;
	bh=/+CsbdqzawtHoLRrzE7YR/ha8SbnFuXJLVAqDlGF29M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfnl4RL9MSbbM5QTTyAsei6+XZdEQMhqCj5DHwJyfAGKly4TryCt1AMbVIePU/Xhm
	 lSFZf8zY4Oy7lLeYDFquElRCEmEh/IDnXB11WDTm1tN7gDl6OwcwKgMFed3Gdd3gVh
	 hz1LjD2rvsrBNDsmgKC831N5EXYsbElZ9z9Wogs5bmPsZtFmQFOSJz9FQAhnoG2uXN
	 Ld81/M4w93Ow+T6vUqREmhpSXUs7CL/Lisv66o+wIkj4kpUKQNqC6ZHYJRwjuWwKjV
	 3veEWOt2F9HZwInXSJ61uPwGclh3XQo5JHvm5o9zFDcm3W999YWG/RIQBZG3j08MML
	 1w76rY9RsNgjw==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	maciej.machnikowski@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com,
	alexander.nowlin@intel.com
Subject: Re: [PATCH net 10/15] ice: wait for in-flight Tx timestamps before flushing the tracker
Date: Tue, 15 Sep 2026 18:12:23 -0700
Message-ID: <20260916011223.1632696-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-11-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-11-anthony.l.nguyen@intel.com>
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
Here is the report:

commit fea79aeeb67734d73dbd19b0b88b152cd016c86e
Author: Petr Oros <poros@redhat.com>

ice: wait for in-flight Tx timestamps before flushing the tracker

This adds ice_ptp_wait_for_tracker_drain(), called from
ice_ptp_flush_tx_tracker(), which polls the PHY Tx timestamp ready bitmap
for up to 10 ms so that in-flight captures publish their ready bits before
the tracker entries are freed and the ready bits are cleared.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 4dec728e219d8..b142b779dc105 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -740,6 +740,37 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
>  	return 0;
>  }
>  
> +static void
> +ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
> +{
> +	unsigned long deadline = jiffies + msecs_to_jiffies(10);

[Severity: Low]
Is the 10 ms budget the commit message describes actually available at every
HZ setting?  With CONFIG_HZ=100, msecs_to_jiffies(10) is 1, so the deadline
is a single tick ahead and the remaining fraction of the current tick is
arbitrary.

Since the loop body only sleeps 500-1000 us before re-testing
time_before(jiffies, deadline), can the whole wait end after one poll of
roughly 500 us?

Would a microsecond-resolution deadline (ktime_get() plus ktime_add_us(), or
read_poll_timeout()) match the documented budget better here?

> +	struct ice_hw *hw = &pf->hw;
> +	u64 tstamp_ready;
> +	bool pending;
> +	u8 idx;
> +
> +	if (hw->reset_ongoing)
> +		return;
> +
> +	do {
> +		if (ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready))
> +			return;
> +
> +		pending = false;
> +		for_each_set_bit(idx, tx->in_use, tx->len) {
> +			if (!(tstamp_ready & BIT_ULL(idx + tx->offset)))
> +				pending = true;
> +		}
> +		if (!pending)
> +			return;

[Severity: High]
Should this read of the ready bitmap be gated on tx->has_ready_bitmap?

On ICE_MAC_E810 the flag is cleared in ice_ptp_init_tx():

	/* The E810 PHY does not provide a timestamp ready bitmap. Instead,
	 * verify new timestamps against cached copy of the last read
	 * timestamp.
	 */
	tx->has_ready_bitmap = pf->hw.mac_type != ICE_MAC_E810;

and the backing helper in ice_ptp_hw.c is a stub:

	static int
	ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
	{
		*tstamp_ready = 0xFFFFFFFFFFFFFFFF;
		return 0;
	}

With every bit set, doesn't the for_each_set_bit() loop above leave pending
false on the first iteration, so the helper returns immediately without ever
sleeping?  That would make the wait dead code on E810, which is the device
named by the Fixes tag ea9b847cda64 ("ice: enable transmit timestamps for
E810 devices").

The other consumer of the same register in ice_ptp_process_tx_tstamp() does
gate both the read and the per-index test:

	if (tx->has_ready_bitmap) {
		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
		if (err)
			return;
	}
	...
		if (tx->has_ready_bitmap &&
		    !(tstamp_ready & BIT_ULL(phy_idx))) {

and the kernel-doc in ice_ptp.h states the register is only valid when the
flag is set:

 * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
 *                    bitmap register. If false, fall back to verifying new
 *                    timestamp values against previously cached copy.

Would it make sense to either skip the wait when
!tx->has_ready_bitmap and use the cached-timestamp fallback on E810, or
adjust the Fixes tag and commit message to describe which devices are
actually covered?

Also, a device with has_ready_bitmap == 0 whose stub returned zeros instead
of all-ones would make this loop burn the entire budget on every flush,
wouldn't it?

> +
> +		usleep_range(500, 1000);
> +	} while (time_before(jiffies, deadline));
> +
> +	dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
> +		tx->block);
> +}
> +

[ ... ]
