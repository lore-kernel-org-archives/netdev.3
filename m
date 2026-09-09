Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAF8466B57
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941050; cv=none; b=G8pvyp4DsSPmG5GiU1k2SEpUWqz+js/kaZgYijGcZhwa3vZ26/FWPAACUCNY+2hDbFYxicV6UYTrSc4z8P+RhuylBoFDyP7CqoOrCXFm6vBiCx3LllklCzwBcud1MdOhe7GCdDqleGFDbK6hcPjK3HnXsHcKmNt9jU/AbNJh1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941050; c=relaxed/simple;
	bh=e1+Lb/NG+mk3Ilrk3d4Lqqcpc5Zw8k7/MCjnzOdByLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbBtuWLCaaGvp8/iryrkL+8OzTaNHvVBHk+tY0VrRDMedgV+le2ToEVgh1ZD8DSZGRNvXK2+AjfS/VT3h137W5ORng80jarQxGPep3EqgjzrFJJZGhHEiT2zxzhbS2MOa2M1E1Yj/y2PZhbX0mJvDW5HVrOZnl3A/tS1ntZpnLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHirGcih; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k9R4+inj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHirGcih";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k9R4+inj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788941046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGIjuVUQngRfRgvOMv6WaGJ9yxJojhd+x80M9bpkP2Y=;
	b=GHirGcihoWwaf2HY9os+KDukq5Ra8saiCFhLUzhvtRf5ujW+t5IYts16jDyRgSx9wlt3kI
	XEr0atA40TeBQ4GS5PrX4Rma6XE2prI3vj7uWfmgEiAHroF6BU2nXs8G/C9lhmuPnWmsel
	a3i5NWs9qngzbF1hRc+q3qF6yvIxJPQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-qMzNHWXIOUWenARbbYMfAw-1; Wed, 09 Sep 2026 04:04:05 -0400
X-MC-Unique: qMzNHWXIOUWenARbbYMfAw-1
X-Mimecast-MFC-AGG-ID: qMzNHWXIOUWenARbbYMfAw_1788941044
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-485835753caso4470040f8f.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788941044; x=1789545844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GGIjuVUQngRfRgvOMv6WaGJ9yxJojhd+x80M9bpkP2Y=;
        b=k9R4+injsc/zbqg0EA2TiH1ju0+WWPJJsyndH2z63bbD4wmNJrPQhm6Y7SKH8as9cy
         oyackBYiVfOR+IepwIF4tDGSDhZLLvYyJy0r2yKUxzfHTGv8bmYCfWAwlE1VMOpvQZOO
         USkP+l87T7hRinb+ajFFhywlZ41IQOhCD59lDeUuqJV66j5kDedOlK6o+UU2/yzj98V4
         ly6q4OXi6guTv1RiVmhgpgVrY8+sfP1DMfQ1ixrwA3HEOl5GfwPmFOrz3+qHoBxy5HPf
         HGwWMydYDnoNGQPmo8MA/DRBv96x0UWoQseLf1DG5W5W8d914yFO1spKGbTgaLJCfYkG
         0nAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788941044; x=1789545844;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GGIjuVUQngRfRgvOMv6WaGJ9yxJojhd+x80M9bpkP2Y=;
        b=XQHkBXrCb/bIHjx1NU+wgZGwCHpbIzNCbejyCokCIlk6u13/IN8v7djqO+BbchlRh5
         DicS7HeLkQrA8fC+w+gXeTz7YDvdx/EvQJA7pJTlaE8GcYoy7lvCcAeSIQB+hcc725nl
         ECYwt/tOG/YFlk1tKg1YN1SzNNoponoJcd9ay+p1m68tqCPK6e4ePoDpqZLpc+RLYZP8
         L7nUC9TBEhjoLQSdf956gH+CwQpdLEa19ILRQ/K55sh9ADXTzhofkQ1RcUbNvV368YJj
         Eiqb4ju3bMPwLfTM+4WOTN2EVZIq/p+REq5EuqgIV+4qqwe/I+fTYJlQJe7pS39M/0QV
         V5CA==
X-Forwarded-Encrypted: i=1; AKwUvBzFig/AwhwTeZE2qztaQ68wrBNjgGgd/9Wx36bNBL93xpx9ueg6aXtNPFIsuaVlehcB0T5mIK4=@vger.kernel.org
X-Gm-Message-State: AFuF++km8ynxn3IbWtw0bRZL3dF/NqLyyKJvGI4NR4hv0tpHXDLveXNm
	z/ODAlPxm7a/H7OJ7AzTw0I/OBUPCclRSrgmDwJzG4xhlvqxfCO6cy6YF56uRLqidy+ibMZOk2V
	Sj9RRjNh/g4BL8u4+tP3IsIh6hl92sQ7Y6gppN/JCfLeyzwMB8cch+JRCYA==
X-Gm-Gg: AYBFou1rayI/FSLWmeJa29nLCiQlyuh6PQxeoFmBLIQBBx6O8YQ3kTVsbkjEzId1d70
	vdVqP1OAvhauII9cHrYBnYWP7sWJFFdsTdUAmOoytVB0ipiUE7IYHO/eet+6HJFWGm7Runq/Kju
	w8Vtl25OPOgguaBvzZEgorrboJEOiTOoKFkQu1RkdegoSJo2e5SpKPm/NePxtRtUr+4PzppDt/h
	4brapbtGjaCv0uK/kPIu+6D6pva09caU+rotPuhUlU8wQCkDnwu5w5R9VyKJ8nCfSE1ExhegqQc
	XdUtJWgV/upiQRi+F4O5t3uHOP9aZAGztdaLPoZstM3xDQp4cmdbmibtIY4i0RPznM5ijTVVe6i
	tM113Pk84SSPppXGhAwRDiR92xlta3NfNL8nv2ybnOtZuHBp/ohNVDa3Bqn5/I/D+mfAX/csO0Q
	==
X-Received: by 2002:a05:600c:8b05:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49cf823c411mr360364125e9.6.1788941044351;
        Wed, 09 Sep 2026 01:04:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:49c:edd2:855 with SMTP id 5b1f17b1804b1-49cf823c411mr360363415e9.6.1788941043923;
        Wed, 09 Sep 2026 01:04:03 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm89320615e9.4.2026.09.09.01.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 01:04:03 -0700 (PDT)
Message-ID: <d447c4e8-9f68-41fe-9598-68a35f48057e@redhat.com>
Date: Wed, 9 Sep 2026 10:04:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dibs: Avoid inconsistent lockstate warning in
 dibs_lo_move_data()
To: Alexandra Winter <wintera@linux.ibm.com>, netdev-bot+sashiko@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, mjambigi@linux.ibm.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, horms@kernel.org
References: <20260904094446.1342654-1-wintera@linux.ibm.com>
 <178887153533.219967.1817289806507440884@kernel.org>
 <a5ffb5d2-4509-4e73-af0d-aad4b1cc9412@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a5ffb5d2-4509-4e73-af0d-aad4b1cc9412@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/8/26 7:04 PM, Alexandra Winter wrote:
> On 08.09.26 14:45, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider:
>>
>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>
>> - [Medium] The patch fixes an observable lockdep "inconsistent lock
>>   state" splat produced by the plain spin_lock(&dibs->lock) in…
>>
>> --
>>
>> Here is the report.
>>
>> dibs: Avoid inconsistent lockstate warning in dibs_lo_move_data()
>>
>> This converts the plain spin_lock()/spin_unlock() around the
>> dibs->subs[]->ops->handle_irq() call in dibs_lo_move_data() to
>> spin_lock_irqsave()/spin_unlock_irqrestore(), because the same lock is
>> also taken from hardirq context in ism_handle_irq().  The commit message
>> notes this is not a real deadlock since dibs_lo devices have no interrupt
>> context.
>>
>>> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
>>> index 649e4e375be33..44a2e74c2efcb 100644
>>> --- a/drivers/dibs/dibs_loopback.c
>>> +++ b/drivers/dibs/dibs_loopback.c
>>
>> [ ... ]
>>
>>> @@ -267,12 +268,12 @@ static int dibs_lo_move_data(struct dibs_dev *dibs, u64 dmb_tok,
>>>  	if (!sf)
>>>  		return 0;
>>>  
>>> -	spin_lock(&dibs->lock);
>>> +	spin_lock_irqsave(&dibs->lock, flags);
>>>  	client_id = dibs->dmb_clientid_arr[sba_idx];
>>>  	s_mask = ror16(0x1000, idx);
>>>  	if (likely(client_id != NO_DIBS_CLIENT && dibs->subs[client_id]))
>>>  		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
>>> -	spin_unlock(&dibs->lock);
>>> +	spin_unlock_irqrestore(&dibs->lock, flags);
>>
>> [Severity: Medium]
>> Should this carry a Fixes: tag?  The lockdep splat quoted in the commit
>> message is reproducible on shipped kernels, and git blame attributes the
>> converted spin_lock()/spin_unlock() pair in dibs_lo_move_data() to:
>>
>> cc21191b584c6f ("dibs: Move data path to dibs layer")
>>
>> The hardirq-side acquisition of the same lock is in ism_handle_irq()
>> (drivers/s390/net/ism_drv.c):
>>
>> 	spin_lock(&dibs->lock);
>>
>> which matches the {IN-HARDIRQ-W} registration in the report, so the
>> warning can be hit by ordinary SMC traffic through
>> smc_close_active()->smcd_cdc_msg_send()->smcd_tx_ism_write()->dibs_lo_move_data()
>> on a lockdep-enabled kernel.
>>
>> The splat also ends with "INFO: lockdep is turned off", so further lock
>> checking is lost for the rest of that boot on affected kernels.
>>
>> Would adding the following help backporters and stable tooling identify
>> which trees need this change?
>>
>> Fixes: cc21191b584c6f ("dibs: Move data path to dibs layer")
>>
> 
> 
> As mentioned in the commit message the paths reported by lockdep belong to two
> different device types (dibs-lo and ism). So not a real deadlock.
> So unless lockdep-warnings by themselves warrant a Fixes-tag (?), I think net-next is correct here.
> 
> Paolo applied this already to net-next.
> For the records: Sahiko identified the right patch to blame.
The current guidance is no fixes tag for net-next patches address old
'issues'. Since this is a false positive, I deemed it as a 'non issue',
hence I agreed with the net-next target (and thus no fixes tag).

/P

