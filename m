Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753819;
	b=TySaZDW80GDbsONBW7CgZ7RFH4+/ONERBUoixcH2CLk37IeVe/t+33UlMJ+3OPLZ4txQ
	 11znCS9aw9oZybvvCkv9qhS9E8Mj5ZA1Ben3l73ch/DV9fQKpyt5IxOgPcvKYYKj0R6iT
	 1hvvmUecdwvux7d8lg2e7BvqBe2Jcvb8BkPvwMdS00H079N97FFhYbcxFjyz5Snp5uJ61
	 s08ssEcH0+dFMyqjemVpYADpe32EFAu6qzorRiWdPayoXG6/sYTUwXc2CoHXFsvzoYA4y
	 BImHVgUC88WmW9Yzrdf+FiW2gD4kuYdYy8+6iFUkKnAPF3Ey5Mm9lGr/hmaf502SFfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753819;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=P/DiIq4E5hY6ERPqc4p6/eiApm3YQ3DYXnC0jmxG1dU=;
	b=f5FrK8eHZnCc+0QymE3rA5OeUljNyV3U2gdbWnbsevP+7KW3diE22WuzczeYk+wRq6uW
	 SvMh0ifvS58O71l+D2xLMP3B+oI/SsEg2rCctX7bI5K2b2R2k30ScEfPZfNBIbUcMY6Sz
	 W2afldqhhC/rpYdURiV5WZq+7vpig0NrxZwbu9ao6vZishF+Ld6xsIxn+E4vBXhFlEQTE
	 h7wBo9EnvbdD/aAtCce+YvKsdGn3UeWJ6Gmr5JsBIAiYH/4jz3+jvurEHNpXamLZmkxo3
	 hTVUyELoVujAv1+J4G7C7QaeLH9cVScya1Yvi2rdw8djOMAQXASAqengR5KjPXd6yAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q7UWjUF8;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF29606A31B;
	Wed,  4 Nov 2026 00:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AF29606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q7UWjUF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793753818; x=1825289818;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zWlPRyG3WzBsJRCZoWEQHc1bfqsPLkX/J47KhKkthKk=;
  b=Q7UWjUF8T7hiTc/KdLcMniZpkMTxnzcBxR2vJ2KhGyOqwqW+meHas6iu
   GSau5terINzgUayeUGTOjn59nny89d7g/hWTTxKtCQexAHedN4KF/JcQu
   KSbcbDwbbPp/3IvfK95xiCZlXUFiup+rKRffPwW+2JTjfPKoUS+EpNPCr
   0CWS3B8MG8XoNeWPnCEKrmGO8teTtN8QndMylYfF+XRX7cEZiqoEULJeD
   MlwkRxtYomhxok2AdTUHegYNKGeZ7MZ1rEc+mb35H6gd6+ZprGfGM1tyY
   FVuQ8q0JKk8iM8cPRp0s0jrrysyvQqqPSgON9zbr31cOcMI6oXnRxKIM3
   w==;
X-CSE-ConnectionGUID: XMIkeFLsTlCXUULAgYI5ew==
X-CSE-MsgGUID: iB1RpQfpSwWAQgCYrey3oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2379382"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2379382"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 16:56:58 -0800
X-CSE-ConnectionGUID: qWZs14qiRYy3+UXwlORXAA==
X-CSE-MsgGUID: /4RAmKWSQOO8U0XPepJM+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6449379"
Received: from vcostago-desk.jf.intel.com (HELO vcostago-desk) ([10.98.24.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 16:56:57 -0800
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
In-Reply-To: <ff74c290-3093-49ec-85ce-0e2385419366@gmail.com>
References: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
 <20261009123309.284193-3-krystianmkaniewski@gmail.com>
 <87ik36lee9.fsf@intel.com>
 <ab4a8b2c-0274-4423-8d10-04e7efb6c120@gmail.com>
 <874ieoj990.fsf@intel.com>
 <ff74c290-3093-49ec-85ce-0e2385419366@gmail.com>
Date: Tue, 03 Nov 2026 16:56:56 -0800
Message-ID: <87bj85wh0n.fsf@intel.com>
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

Hi,

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> On 10/14/26 22:51, Vinicius Costa Gomes wrote:
>>>>> +	struct sched_entry *entry, *found = NULL;
>>>>> +	ktime_t cycle_start = sched->start_time;
>>>>> +	s64 offset, entry_end = 0, elapsed = 0;
>>>>> +
>>>>> +	if (ktime_after(now, cycle_start)) {
>>>>> +		s64 periods = div64_s64(ktime_sub(now, cycle_start),
>>>>> +					sched->period);
>>>>> +
>>>>> +		cycle_start = ktime_add_ns(cycle_start,
>>>>> +					   periods * sched->period);
>>>>> +	}
>>>>> +	offset = ktime_sub(now, cycle_start);
>>>>> +
>>>>> +	/* The offset is less than one period, so an entry which ends after
>>>>> +	 * @now is found at the latest at the entry which reaches the end of
>>>>> +	 * the cycle, or at the last entry. A schedule has at least one entry,
>>>>> +	 * so the loop always sets found.
>>>>> +	 */
>>>>> +	list_for_each_entry(entry, &sched->entries, list) {
>>>>> +		entry_end = min_t(s64, elapsed + entry->interval,
>>>>> +				  sched->cycle_time);
>>>>> +		if (offset < entry_end ||
>>>>> +		    list_is_last(&entry->list, &sched->entries)) {
>>>>> +			found = entry;
>>>>> +			break;
>>>>> +		}
>>>>> +		elapsed = entry_end;
>>>>> +	}
>>>>> +
>>>>> +	*start = ktime_add_ns(cycle_start, elapsed);
>>>>> +	*end = ktime_add_ns(cycle_start, entry_end);
>>>>> +	sched->cycle_end_time = ktime_add_ns(cycle_start,
>>>>> sched->cycle_time);
>>>>
>>>> Having this side effect here was unexpected. I think this would make
>>>> more sense outside this function.
>>>>
>>>
>>> Agreed. I can make taprio_entry_at() return the cycle end through an
>>> extra output argument and have advance_sched() store it explicitly in
>>> oper->cycle_end_time. The helper could then take the schedule as const.
>>>
>>> I can wait for the rest of your review of this patch before sending v3
>>>
>> 
>> I am going to try and review this by end of this week.
>> 
>> 
>> Cheers,
>
> Hi Vinicius,
>
> Just a gentle ping on patch 2/2. Did you have a chance to continue the
> review?


Sorry for the delay, just another minor/optional nitpick. The series
look good, run a couple of tests on a VM. For the series:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


> -- 
> Krystian Kaniewski

-- 
Vinicius
