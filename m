Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753688;
	b=o0xs+Jel/pjq9WA/xXYR7gYH6lkKxy9fTny8m65PQNPxF9n8Sd/jqJ21dk87L6MDpJyz
	 iSt2D+11vKch1n8J7CJecV/FISRoZeO1cFBL90et8FO4IEe0A/3s4kWEBJ4YeU/FfM1T1
	 pnnC13JKtPuAnAYtrqO+cRpe4YnNKiGFbRA46LiTh2zK7IKrxdtRsowDJFVSJjHhn90jK
	 aKWzRQ2vvPE1f8K4+Ysf+E/1iZlZQuWS4ojY7aolM4VhzRPJGOnMzYqiNd3MjB4WuaAYc
	 FhydlvXNwoBe2ora54A0hpCNJ8sRmR8CaZTSkGrC8hgCpp+B+VVORq5PxQTMZ8m2wjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753688;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=oj9nKkCW7bWd+0cHGj+wEKxnjQbWPGYPS+k9247roq4=;
	b=IngappsA/sxsjli+ykXR/R+llyC/tCf2IDvUIpAlLMx4ctamlW+RZcqI8YPf+3gyLm3T
	 xBLegQG6sOy43mRSVzEjBRKet2+F05z3HQwsKWRHX77AkNZZfUmPXtgdGJ/I0d0oS3rqD
	 A6tPlAskBK2RIz9svgmjSH/GnQdjXo36hkgpF0dEm1on7UXbS22M9gqOVEogwjiNZmFzZ
	 ls2XujcKbmGZUvlY4XBP/3FaYVrJo2YlZz+TIMhkeBvosVLe2NsXJ+cI0Xi/5QpsdEhdU
	 VuAo9j70Tde70kAzbEtTrL93JrhU5Vv4YhRL73jrvlk+M93LeLtXXDMz+JYQonRUELg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YNyQMJHC;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48275606A31B;
	Wed,  4 Nov 2026 00:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48275606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YNyQMJHC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793753687; x=1825289687;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wJOIBFMpHAM9JF5pnPfq5+zTkGEPuyXHe0DSiQgYtlg=;
  b=YNyQMJHC1jX/4oJekHvrPa07cm6E8GjUhPN/hNO3lSePgdHJXhbaH51N
   cdNEWTAXlirbxEK9EOwwuFyhO7TrOTkSN6abtTp+7x1n1C0j4eJDEwXqU
   kpuKlPZL70OSsCq+csbKjT9KrkCnX3+PZQ4UnURWHj03W6wZd4ipsVPmT
   EUNlcmz+MJ7CP2vKOJsPtFgpRNEFxYfXTuGAWRKfpc1sSRyuQGR0ni72E
   YJuEmFLT+/TycSYPqrQ620fAxZP3QERsw28x9SA+B42ZEPS+NaCyPkTeA
   8p4a9X8pfwi+pbnWLPpoyNUQ86r2UPsXdboA0nRFtA+Pd7OupMUoGNrPW
   g==;
X-CSE-ConnectionGUID: 70C3j7zkTxWs68A4E1p+Rg==
X-CSE-MsgGUID: Ukl+IS47T0OoXiewpMLxRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2526592"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2526592"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 16:54:46 -0800
X-CSE-ConnectionGUID: PW2KjZlPRUqctiXxNmUysw==
X-CSE-MsgGUID: xk8oEFQHSvWNKcm9uu+neg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6580060"
Received: from vcostago-desk.jf.intel.com (HELO vcostago-desk) ([10.98.24.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 16:54:46 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net/sched: taprio: reject software schedules
 that overflow their timestamps
In-Reply-To: <20261009123309.284193-2-krystianmkaniewski@gmail.com>
References: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
 <20261009123309.284193-2-krystianmkaniewski@gmail.com>
Date: Tue, 03 Nov 2026 16:54:45 -0800
Message-ID: <87ik2dwh4a.fsf@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> taprio takes base-time as an unbounded signed 64-bit value. A base time
> in the future is used as the schedule start unchanged, and
> setup_first_end_time() then adds the cycle time, the first interval and
> the gate durations of the first entry to it. With a start close to
> KTIME_MAX these sums overflow, and the software schedule starts with end
> and gate close times that lie far in the past.
>
> If this is the first schedule, the qdisc timer is armed for its future
> start. With an operational schedule running, taprio_start_sched() keeps
> the earlier operational expiry instead. A large cycle-time-extension
> can then trigger an early handover to the pending admin schedule.
> advance_sched() uses the invalid entry end as the next expiry and can
> keep restarting inside the same timer interrupt.
>
> Before a software schedule is initialized and published, check that the
> computed start is not negative and leaves room for every timestamp
> initialized from it, and reject the schedule with -ERANGE otherwise. Full
> offload and txtime-assist do not use the software timer and are not
> affected. Schedules with a reasonable base time behave as before.
>
> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
> Assisted-by: Codex:gpt-6.1-sol
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> ---
> v2: no change
> v1: https://lore.kernel.org/all/20261006113335.241564-2-krystianmkaniewski@gmail.com/
>
>  net/sched/sch_taprio.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 299234a5f0fe6..1f753911cdfec 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1238,6 +1238,48 @@ static int taprio_get_start_time(struct Qdisc *sch,
>  	return 0;
>  }
>  
> +static int taprio_validate_start_time(struct taprio_sched *q,
> +				      const struct sched_gate_list *sched,
> +				      ktime_t start,
> +				      struct netlink_ext_ack *extack)
> +{
> +	int num_tc = netdev_get_num_tc(qdisc_dev(q->root));
> +	const struct sched_entry *first, *entry;
> +	u64 offset = 0, span;
> +	int tc;
> +
> +	if (TXTIME_ASSIST_IS_ENABLED(q->flags) ||
> +	    FULL_OFFLOAD_IS_ENABLED(q->flags))
> +		return 0;
> +
> +	first = list_first_entry(&sched->entries, struct sched_entry, list);
> +
> +	/* setup_first_end_time() adds the cycle time, the first interval and
> +	 * the finite gate durations of the first entry to the start, and
> +	 * setup_txtime() adds the offset of every entry. None of these sums
> +	 * may overflow.
> +	 */

nitpick: In the commit message there's "Full offload and txtime-assist
do not use the software timer and are not affected", and here you say
something about setup_txtime(), I think it's better if you don't mention
anything about those other "modes" here.

> +	span = max_t(u64, sched->cycle_time, first->interval);
> +	list_for_each_entry(entry, &sched->entries, list) {
> +		span = max(span, offset);
> +		offset += entry->interval;
> +	}
> +
> +	for (tc = 0; tc < num_tc; tc++) {
> +		if (first->gate_duration[tc] == sched->cycle_time)
> +			continue;
> +		span = max(span, first->gate_duration[tc]);
> +	}
> +
> +	if (start < 0 || span > KTIME_MAX ||
> +	    (u64)start > KTIME_MAX - span) {
> +		NL_SET_ERR_MSG(extack, "Schedule timing is out of range");
> +		return -ERANGE;
> +	}
> +
> +	return 0;
> +}
> +
>  static void setup_first_end_time(struct taprio_sched *q,
>  				 struct sched_gate_list *sched, ktime_t base)
>  {
> @@ -1958,6 +2000,10 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>  		goto unlock;
>  	}
>  
> +	err = taprio_validate_start_time(q, new_admin, start, extack);
> +	if (err)
> +		goto unlock;
> +
>  	setup_txtime(q, new_admin, start);
>  
>  	if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {
> -- 
> 2.53.0
>


Cheers,
-- 
Vinicius
