Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48D415B8D;
	Wed, 14 Oct 2026 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011118; cv=none; b=fCO5zs7QopnrRRWPtlCFbYXz4ZRDB2kfP6JqAzm07ao41lpETEgFfrhTyf/BBk+iNOBa7WW7IpSo1yfq1hUj7r/ZAvJtBnmBvuHAiFzypgARLm/8Ub1CYbCEQNP2skYFHJx4ZjWEhRVsAT3b0aC1rpFtrgy7oTyvMDtTdgy7L9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011118; c=relaxed/simple;
	bh=lfWqWrfyTdZ5WF7lFRmxw0Tfd7SNw3NiNxdD+5V1V28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nebUd+YO/JgslkXh6tIbuLDFoMOhSdFgvwOswxNevxmNVmvCvS26ttGoVhLs+a7y3PK0vGx94kib+ui8HNEME5aqSbSFwhOc+ADLkYDe5fZm2ZlqaxrIgNRYB3psnEUwnGmJItzbb90tjGe5+21B1WvNS9/MKQt3X3yb7xt/HVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knqXjZQq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knqXjZQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792011117; x=1823547117;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lfWqWrfyTdZ5WF7lFRmxw0Tfd7SNw3NiNxdD+5V1V28=;
  b=knqXjZQq2UIQkUDUtQnNXdPsQRdfZFUFFbtP85+sJteJvTj7ROJ6G9FI
   76v/5Mee96ZLf3flAdGEW0Na/fHolsIB0AXsrXk6VagicMtbevA8dHcmj
   nMWGtjFcV1eudQ4R+coHvO89htkNxsXJPnapu/O6NIx65mR2VRX4dKZw/
   LrQM7NKZArgHmUzY5GnpZPbibZL5xh8NGb2wLTE/Kfeec5Mr7VEYzl1hi
   xK4oi09Dx5OlupGq4kRUGHUsFesruqIeB0W0ZppERpqH1pMBCKXGTaTTm
   zfak6gw4wmqxh7QY0iRhP+CRiu3OBuHeCo2iEq1la3KNJZIAs5QzXuk54
   A==;
X-CSE-ConnectionGUID: ZcWkG0tKRkKLUO/XG+GRrg==
X-CSE-MsgGUID: rHoxTgtiReus9Ri8Iw1Wcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="670441"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="670441"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 13:51:56 -0700
X-CSE-ConnectionGUID: gzzHLpVbRyOIt9zS1CJy0w==
X-CSE-MsgGUID: jSnupg9zR02MO2hv9tlYCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1631423"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.241.243.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 13:51:55 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+e044a9b6370ed8ca9737@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 2/2] net/sched: taprio: do not replay missed
 entries in advance_sched()
In-Reply-To: <ab4a8b2c-0274-4423-8d10-04e7efb6c120@gmail.com>
References: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
 <20261009123309.284193-3-krystianmkaniewski@gmail.com>
 <87ik36lee9.fsf@intel.com>
 <ab4a8b2c-0274-4423-8d10-04e7efb6c120@gmail.com>
Date: Wed, 14 Oct 2026 13:51:55 -0700
Message-ID: <874ieoj990.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> On 10/13/26 00:53, Vinicius Costa Gomes wrote:
>
> Hi Vinicius,
>
> Thanks for the review, and for the Ack on patch 1.
>
>>>  struct taprio_sched {
>>> @@ -902,8 +909,19 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
>>>  	 * plus the amount that can be extended would fall after the
>>>  	 * next schedule base_time, we can extend the current schedule
>>>  	 * for that amount.
>>> +	 *
>>> +	 * cycle_time_extension is an unbounded signed value from netlink, so
>>> +	 * clamp the sum instead of letting it wrap. A wrap would make this
>>> +	 * test non-monotonic in end_time, and advance_sched() relies on it
>>> +	 * being monotonic to check it once after catching up instead of once
>>> +	 * per skipped entry.
>>>  	 */
>>> -	extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
>>> +	if (oper->cycle_time_extension > 0 &&
>>> +	    end_time > KTIME_MAX - oper->cycle_time_extension)
>>> +		extension_time = KTIME_MAX;
>>> +	else
>>> +		extension_time = ktime_add_ns(end_time,
>>> +					      oper->cycle_time_extension);
>>>
>> 
>> This one I could argue that it could be in a separate patch. As the
>> wrapping could cause issues even before these changes, no?
>> 
>
> Yes. With an extension larger than KTIME_MAX minus the end time, the sum
> becomes negative and should_change_schedules() ignores the extension.
> That is independent of the stall. I can move the clamp to a separate 
> patch with a Fixes tag for c25031e99344 ("taprio: Add support
> for cycle-time-extension"), before the advance_sched() change which
> relies on it.
>
> get_interval_end_time() has the same addition on the txtime-assist path.
> I can cover that path in the same  patch as well. Would you like me to
> do it?

Good catch. Yeah, fixing that one as well would be good.

>>> +	struct sched_entry *entry, *found = NULL;
>>> +	ktime_t cycle_start = sched->start_time;
>>> +	s64 offset, entry_end = 0, elapsed = 0;
>>> +
>>> +	if (ktime_after(now, cycle_start)) {
>>> +		s64 periods = div64_s64(ktime_sub(now, cycle_start),
>>> +					sched->period);
>>> +
>>> +		cycle_start = ktime_add_ns(cycle_start,
>>> +					   periods * sched->period);
>>> +	}
>>> +	offset = ktime_sub(now, cycle_start);
>>> +
>>> +	/* The offset is less than one period, so an entry which ends after
>>> +	 * @now is found at the latest at the entry which reaches the end of
>>> +	 * the cycle, or at the last entry. A schedule has at least one entry,
>>> +	 * so the loop always sets found.
>>> +	 */
>>> +	list_for_each_entry(entry, &sched->entries, list) {
>>> +		entry_end = min_t(s64, elapsed + entry->interval,
>>> +				  sched->cycle_time);
>>> +		if (offset < entry_end ||
>>> +		    list_is_last(&entry->list, &sched->entries)) {
>>> +			found = entry;
>>> +			break;
>>> +		}
>>> +		elapsed = entry_end;
>>> +	}
>>> +
>>> +	*start = ktime_add_ns(cycle_start, elapsed);
>>> +	*end = ktime_add_ns(cycle_start, entry_end);
>>> +	sched->cycle_end_time = ktime_add_ns(cycle_start,
>>> sched->cycle_time);
>> 
>> Having this side effect here was unexpected. I think this would make
>> more sense outside this function.
>> 
>
> Agreed. I can make taprio_entry_at() return the cycle end through an
> extra output argument and have advance_sched() store it explicitly in
> oper->cycle_end_time. The helper could then take the schedule as const.
>
> I can wait for the rest of your review of this patch before sending v3
>

I am going to try and review this by end of this week.


Cheers,
-- 
Vinicius
