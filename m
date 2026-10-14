Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBA488223
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968887; cv=none; b=huaxpLMkfCw3TmXgra6gkgM4dtNDmZFa4fYDBbndzVNi5Iej7uGjgtomaKY5JZXvVeo9uJd2QH/CIFYCLTmvMQ/27uPzcrENYAZCFTzmdHw6qdg3Iz1VxAqk4T4+I1mb6AikraBIheDoB8yKSsm5J9vO5OdF4W8nIlXu7YdrYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968887; c=relaxed/simple;
	bh=lKiPfEj4GiFsESIXSMABmEWrbzmHHHXncq9jkZ21n/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+A9GfmvVDhoVZO5wvf40HgqA/UBkDktmNS4WGdTpuYb/5qtaazY7A+ULj8gwpbVtbOLTY9l8Brc/MUeDcMNQ3BLf/UMW1J1N5ubbi7iOOtYY5E9kZeDynBdO5vFmmyyV6ejQYCy1ZrHevh211MzO/7qO+NbqAGmkSin3UbiveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxIIv81S; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxIIv81S"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e4df2e26fso521211766b.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791968884; x=1792573684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X6jLRvEdFUZOs356gfPWUV5PoYZmQs3hOKeg53YuPxY=;
        b=nxIIv81SyOUgNpr+UQvGbuCSoGYUXLwmsdeoSLIaqys3RpkLZeGHhHt2Amhli+1Ifz
         nQDK3nd1B/ZtW98dn57o6x7oA5LnZv975rHuDm9EyVxRfHyQBKty6jsQrIO46YSPURw7
         yD1CvR9skpiiIFR3k54lELHAez5LGmmstKwHM4zW73xlzf3IE30eiEXBERnvEPfHynlk
         Uog0x62Wkb4g7tozgkrtd3/ZjOhEBnW2AIN3UhbpamRXP5AFyEae2j3hm+F++g2mOj6L
         +gpULllYbrIJQToqseJDzoINy8/DTxv2pc4VQV0TNgFcJZUcanCAZMVGOV4pM20aZq4M
         XoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791968884; x=1792573684;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X6jLRvEdFUZOs356gfPWUV5PoYZmQs3hOKeg53YuPxY=;
        b=NbbW0HRBC1NDItaVLl1gR4Ti/a5Wxj0Q/3QysIeYK6YgG3kMn6SlD7+ovMypE4Um6H
         byW1vyo15aVDZl2HpnPn2m5DJN2xwyN5LjjSQpCmZ6OMHtkQ1R4QU6URiF6ygqw1Om3t
         wl2hs24hyO9d7VwKjdwWA+oUqoPD8q+TyupmZUlC4tsRdSTy76o4N4mDqeQdXppk61l/
         M/YdNGhUz12N5BWuJuzgXB+dJzPpcS8Uoxr5/9CNIMXfWNz6arwv7e0ngQX+rCz4pXfe
         ZlEeJ3rRfOgvsWDQ4Sq2M99bupyGP9h6RThKIVgF4XNAeRx8lPqdqMNAeKc0QVBWoM6j
         AbAQ==
X-Forwarded-Encrypted: i=1; AKwUvBye+i42F28oOIC+anQ+ppTo5xPvHS4QsjVe9U2hNloAJdWFZiuK779JJR/MkfACADjWGt4zIg0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEe+EwHkFZ3HbqQqzMbUkM5/K6HXwQnlAKjZUJqcfMfl8trIDN
	UcLAetHRbRAeNf55jDuDf3gdLutyTevOfjEZrLt7ylR4vtfD9GnZ1u7T
X-Gm-Gg: AYBFou1aOLhxkn0DYjdgED6VNIK8fLlIMrFLd4a15gq9RFYfFppaDDz2QpIFnin4xZm
	ScGR2g8FJ1Bu4Ir5ARf9md4nzdHo+YC0quUnXu/gkbGWX2RY0pjjhrHiRx2LiR9+S/BZN3SckHD
	V/p0YAfYuBJw2TTf4cDr/DWnZz6sCCinbIQMx6lxXYhSr0m9t8ZSq/sZpDhP/2e0apQGXMW819b
	53S6sCY4+F2z8g3+ZW142uyueFu6BlsT3EXNjJqziQmjwjC6UaDvZkkpgC1hXD/alOAW1CX0kRq
	IU6rhSO2YgQ35hYzMF2SLRmycxZQSoWtxelsmlTHugkx1fjzrX6YcdHbxL7uGvG00saBU4k2+IM
	I7TXxKngCHCxlCWpv5qYs7KN/l1N4WbieTWL3Jz3vqUE2IfNeosH3UOCEXy1tQ/AjuDOHpHaRli
	7+XjDnPrjSZSbV8aFoJlvrPCOsEjG3H/kgha1QppvOoZKfEMYpboc0AhveVUfIhYOTuW+4lif5C
	xOnnHh6rTnh2k2PuYZ5JW3L7XUCPdOltrT59L8PolqTHPHwn+dk/jGhbr3Ah1UktCpE882sajm7
	/+DfmRtpTU2avugbbRND+zNrElDdtIvuyd6Mhw9/9+qOwZP28w2t2FNnpGmWWJMPNuyFbCeqwhr
	16FctizfGaeeSK5FcULt5s/gv5vW+rJ8Uhg==
X-Received: by 2002:a17:907:a310:b0:c2e:4e08:19ab with SMTP id a640c23a62f3a-c31a9afb4b9mr1447672966b.16.1791968883457;
        Wed, 14 Oct 2026 02:08:03 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3b7ee45694sm25010166b.34.2026.10.14.02.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:08:03 -0700 (PDT)
Message-ID: <ab4a8b2c-0274-4423-8d10-04e7efb6c120@gmail.com>
Date: Wed, 14 Oct 2026 11:08:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net/sched: taprio: do not replay missed
 entries in advance_sched()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+e044a9b6370ed8ca9737@syzkaller.appspotmail.com
References: <20261009123309.284193-1-krystianmkaniewski@gmail.com>
 <20261009123309.284193-3-krystianmkaniewski@gmail.com>
 <87ik36lee9.fsf@intel.com>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <87ik36lee9.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 00:53, Vinicius Costa Gomes wrote:

Hi Vinicius,

Thanks for the review, and for the Ack on patch 1.

>>  struct taprio_sched {
>> @@ -902,8 +909,19 @@ static bool should_change_schedules(const struct sched_gate_list *admin,
>>  	 * plus the amount that can be extended would fall after the
>>  	 * next schedule base_time, we can extend the current schedule
>>  	 * for that amount.
>> +	 *
>> +	 * cycle_time_extension is an unbounded signed value from netlink, so
>> +	 * clamp the sum instead of letting it wrap. A wrap would make this
>> +	 * test non-monotonic in end_time, and advance_sched() relies on it
>> +	 * being monotonic to check it once after catching up instead of once
>> +	 * per skipped entry.
>>  	 */
>> -	extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
>> +	if (oper->cycle_time_extension > 0 &&
>> +	    end_time > KTIME_MAX - oper->cycle_time_extension)
>> +		extension_time = KTIME_MAX;
>> +	else
>> +		extension_time = ktime_add_ns(end_time,
>> +					      oper->cycle_time_extension);
>>
> 
> This one I could argue that it could be in a separate patch. As the
> wrapping could cause issues even before these changes, no?
> 

Yes. With an extension larger than KTIME_MAX minus the end time, the sum
becomes negative and should_change_schedules() ignores the extension.
That is independent of the stall. I can move the clamp to a separate 
patch with a Fixes tag for c25031e99344 ("taprio: Add support
for cycle-time-extension"), before the advance_sched() change which
relies on it.

get_interval_end_time() has the same addition on the txtime-assist path.
I can cover that path in the same  patch as well. Would you like me to
do it? 
>> +	struct sched_entry *entry, *found = NULL;
>> +	ktime_t cycle_start = sched->start_time;
>> +	s64 offset, entry_end = 0, elapsed = 0;
>> +
>> +	if (ktime_after(now, cycle_start)) {
>> +		s64 periods = div64_s64(ktime_sub(now, cycle_start),
>> +					sched->period);
>> +
>> +		cycle_start = ktime_add_ns(cycle_start,
>> +					   periods * sched->period);
>> +	}
>> +	offset = ktime_sub(now, cycle_start);
>> +
>> +	/* The offset is less than one period, so an entry which ends after
>> +	 * @now is found at the latest at the entry which reaches the end of
>> +	 * the cycle, or at the last entry. A schedule has at least one entry,
>> +	 * so the loop always sets found.
>> +	 */
>> +	list_for_each_entry(entry, &sched->entries, list) {
>> +		entry_end = min_t(s64, elapsed + entry->interval,
>> +				  sched->cycle_time);
>> +		if (offset < entry_end ||
>> +		    list_is_last(&entry->list, &sched->entries)) {
>> +			found = entry;
>> +			break;
>> +		}
>> +		elapsed = entry_end;
>> +	}
>> +
>> +	*start = ktime_add_ns(cycle_start, elapsed);
>> +	*end = ktime_add_ns(cycle_start, entry_end);
>> +	sched->cycle_end_time = ktime_add_ns(cycle_start,
>> sched->cycle_time);
> 
> Having this side effect here was unexpected. I think this would make
> more sense outside this function.
> 

Agreed. I can make taprio_entry_at() return the cycle end through an
extra output argument and have advance_sched() store it explicitly in
oper->cycle_end_time. The helper could then take the schedule as const.

I can wait for the rest of your review of this patch before sending v3

-- 
Krystian Kaniewski
