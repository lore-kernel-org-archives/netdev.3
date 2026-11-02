Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614790;
	b=w3rRlJPZR4ckZGEO0WeYamh1hfHuFlmfX2T/zOloomSam6d+8s8wBE43gGmkcD3QvoP3
	 lftYdmx9KbjpieFDg1eTYPzmFRg7ydmF6mBSUG4b1lRNTLFvYaxK0KaXR6kZHx9qduCLK
	 Jj6ptOfxerpIx72Eiey21Uk9e8iOObfD53c6owuq/gm9tKfQ0syFATPItg8SZfLf9lWzc
	 hsNjsdNQUp3ABg1G0yXlqRgEcxL9VAm1lGYhWwAZGgBIEWoOajK2iRkfI9RlPgsLKTzbt
	 K+KrvSw93PSTs6lusoMCdjeGDUYrmo8RU4k27mc7lA30NO8RPCt6kqDfu/ohccsS7Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zbRFxtn0bmST4ot7xJOZ3J8yhLdMWFCd3X8j2ANvOdQ=;
	b=BRWpGf8v+4fCUBKrFoJ04+NclpSwmwx97GqNDqRKBG8O3GBP5trWDBHa6cM3iL1xJ9Kb
	 JbmYRASy/rCuxvyOEOBxZSMtunYq4DG2yZieyAAkrEap8BiYjRqd7QFOlgnKit/4uysj6
	 kWhcaPbs+BWZhvKb1KxVq6AoFHI7wyN+p1nVqhr5AAfI1QZx1mB+4SUi3bJd7or8stM5D
	 zDJuF2l9KM/B+gF2Cg/0cazTYTs/b7Iw9Z+fC+P3mbAlZt0vQKcXILMeMi7+/SvtR7/dK
	 iuWgiwGNwm3Oh55KUAaUoXl2A2r7pKPKWksEGiiGW35bGEcZhP7jKCcL15P+v4D6dQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fzT0M4Hu;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5248C606A333
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5248C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fzT0M4Hu
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a215e64962so25402365e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793614789; x=1794219589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zbRFxtn0bmST4ot7xJOZ3J8yhLdMWFCd3X8j2ANvOdQ=;
        b=fzT0M4HukfUlzDn4yWiRhIKlBw1T28PUkGkOSKvaaObOSGlsp0qfW07r6pgJLFu0yG
         frdDj3JLSWTwBqs3mbc4RCIBYRtua4AkFXTx1ymThRpZnfqQgeMDxgDLR31XAmufd740
         ULpXuAaOJ+7TGgRk1U1Du4DOgxOLxXrq9Rfw5gQ/ubThWV7ZahIdQGQmahB6yg/yA8Sd
         at6LR2C1wgTgoiMS6OzVZeM9XwJhofEAHjKq3KKjvGPIvv5pFt0zbqu4dZx/3isfQbpB
         XqQ3lW99clHzSkevKhgq+DpU06/3X/zsesE2GVgZUDLDFnBjQDnIOvffeBlp4YGS0ZDY
         gBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614789; x=1794219589;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zbRFxtn0bmST4ot7xJOZ3J8yhLdMWFCd3X8j2ANvOdQ=;
        b=ofFn8+aqTUAwc9ol4m2yjUNYT3r01kGJQ6GSaOXf2fpX1DtmRva2JASm9/r4Q7YanO
         +p0tMWKThVyyf3AccEGXEEhmcgC3zUTojIsFuKk7WKmp9yLeFPVjPx3jxE+DXikdFXsC
         g1rGyfQn4DetdlYAIrJGFONrE0Lz0BSUg+gXTCfak69je24Lz+WsbCL8PpKMA3+znY5K
         5f6do5mQrhij25BnZGMJB4Ap229C5f/9Nkp8aeBGEg4OgyI7M4hHBy/cN4GYcHc5ADvk
         zWBHp1DFqomMGGnjHKdpvTdLSnFyWRda3Ftwtktgk7h3E2/vn6pz1/DYBobwpz4KKmoy
         Z5uw==
X-Forwarded-Encrypted: i=1; AKwUvBzXkVXZjiRuwlQQ3Ym+bLPwTOKDh1nE3jZoaKW5BpIJJsbbmB+Gkbz7sPUt+LJsO6vGbO4rGm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDCN7VAwepWK79QKcwT73aIDmxMfGjyoFd8HKDZJ6B9BS3IiIY
	MKgbhuYQnhTRCLz/EDpjx83a1C9/8TWDFdZ4VAPtIJdRttzAU+6CBa5DKvLkSPnIaiM=
X-Gm-Gg: AYBFou32vpSkRO8G86eZL6cTL7QxKx7zK1+5cAxWBYY56rAXUfLwHXrQAPTSbtbVcAM
	6lq+bOVDM04n1MDCewxfWCx4KQkfppp2pb+qUOf6/gm35ny33h/jeSL+GV8AdTcDUpAmCKqqFWk
	iE4Cyc8BKu1Rnk64ILymQesyUfgOLz0jGHkvPNdOTyw+m5eW87UIBLYAxLkmSQqDPbsnogLX+fS
	Jzoo59sLHzDJ2eposvEh+GwbcRKQGIn0WbVE6i6O0j2Z39Y9FhqPz4p7wVbHKZ07emMfHIDHQwk
	ttdnOAciYw/6h/ivNMlmgYUXLIPrLTG/6/NGt5bZYFqXziglBDVObSDJ1MeSq2gB6Wkw7qm0atn
	/mn5P8N6UTUbl76AWeOEm9Zzi35jem/wHizW3wB7O3iPKrQDK9VFvghDPgq7Z5wmMeqHdBV6EZ1
	f4FxeqFXBe2xYoXV0P5BtvnDzGb8QM0lqdl3nkF5RVzSX/niMuRzN2tNNfmlhclh7nCHgGhLkSG
	Y8MbJS15UoMygrZQhf+QkMEXRf/9TbVZvAYLg34S7OdPDuIrYed3+zyXfcHNbJWwOhBEQ6RrBFo
	RgN2GAja0iwsxnHEeq/rnjrZM57jzM3hUMxSOx0C+C4RuVaIohAss1rd751pT+qIFejNpadA3Fx
	SEne0S7W0MCbU5ltCEF9yRvMwJmlkkSSZDMRqEto0K2GOBuiOiVExIlTXI9fr6Y4/4aQPiWfXkQ
	03qnH7qKpr0I4oK4QQAqPOfKaFEhImoL0MYohzrPYSs52tFDnR/df+DMlme5ui6BE=
X-Received: by 2002:a05:600c:3b0e:b0:4a7:7d22:c50c with SMTP id 5b1f17b1804b1-4ac150b2243mr239535245e9.2.1793614788494;
        Mon, 02 Nov 2026 02:19:48 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm18041307f8f.15.2026.11.02.02.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:19:48 -0800 (PST)
Message-ID: <ff74c290-3093-49ec-85ce-0e2385419366@gmail.com>
Date: Mon, 2 Nov 2026 11:19:47 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
 <87ik36lee9.fsf@intel.com> <ab4a8b2c-0274-4423-8d10-04e7efb6c120@gmail.com>
 <874ieoj990.fsf@intel.com>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <874ieoj990.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 22:51, Vinicius Costa Gomes wrote:
>>>> +	struct sched_entry *entry, *found = NULL;
>>>> +	ktime_t cycle_start = sched->start_time;
>>>> +	s64 offset, entry_end = 0, elapsed = 0;
>>>> +
>>>> +	if (ktime_after(now, cycle_start)) {
>>>> +		s64 periods = div64_s64(ktime_sub(now, cycle_start),
>>>> +					sched->period);
>>>> +
>>>> +		cycle_start = ktime_add_ns(cycle_start,
>>>> +					   periods * sched->period);
>>>> +	}
>>>> +	offset = ktime_sub(now, cycle_start);
>>>> +
>>>> +	/* The offset is less than one period, so an entry which ends after
>>>> +	 * @now is found at the latest at the entry which reaches the end of
>>>> +	 * the cycle, or at the last entry. A schedule has at least one entry,
>>>> +	 * so the loop always sets found.
>>>> +	 */
>>>> +	list_for_each_entry(entry, &sched->entries, list) {
>>>> +		entry_end = min_t(s64, elapsed + entry->interval,
>>>> +				  sched->cycle_time);
>>>> +		if (offset < entry_end ||
>>>> +		    list_is_last(&entry->list, &sched->entries)) {
>>>> +			found = entry;
>>>> +			break;
>>>> +		}
>>>> +		elapsed = entry_end;
>>>> +	}
>>>> +
>>>> +	*start = ktime_add_ns(cycle_start, elapsed);
>>>> +	*end = ktime_add_ns(cycle_start, entry_end);
>>>> +	sched->cycle_end_time = ktime_add_ns(cycle_start,
>>>> sched->cycle_time);
>>>
>>> Having this side effect here was unexpected. I think this would make
>>> more sense outside this function.
>>>
>>
>> Agreed. I can make taprio_entry_at() return the cycle end through an
>> extra output argument and have advance_sched() store it explicitly in
>> oper->cycle_end_time. The helper could then take the schedule as const.
>>
>> I can wait for the rest of your review of this patch before sending v3
>>
> 
> I am going to try and review this by end of this week.
> 
> 
> Cheers,

Hi Vinicius,

Just a gentle ping on patch 2/2. Did you have a chance to continue the
review?
-- 
Krystian Kaniewski
