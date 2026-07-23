Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC94318ED2
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844694; cv=none; b=dhHcs8ow5+USzEYmGNoPM/v8v3gs78j3PMlzMWIBrBBgp2tYEFlvEdL9m7xxpfLwtUe9+pSoIgxoNWBAyDSO8gcXbpynTfjdCoDGvXHUwP4tZXUws1EEw9PJUo1nV9o6xx0nrNmVvmbPqZeWsfDqnjT8YP4inz9Te77neiH+NKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844694; c=relaxed/simple;
	bh=wVSYcLY4YzBsLAFkXn+Pwu8oa5Wu2JqHlvcBPG7W2cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drscy33wyRHvzpqCaHdwA57u49MOyPLQxP1cSIQ718SfOBK7sBg+5as5vRjcFvZnQXLajZZKSrrfLU16HsQM5bf023U3nIOvx4w29VB2s50jt1F0JlS/8pvntkvzHZAOgMnrCHhlczos7cwHiqjZKK4pTYZO/yesOZH0XgsnS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7mVGbwk; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7mVGbwk"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c999f162c9aso903260a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784844693; x=1785449493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9HODvWBOGd20teJbnv+TM8mIYLLEFiHYOCWHoBz68ME=;
        b=F7mVGbwka7pdu4Q8jMapVzoMRPZFCWTo2yWN6KAUOPhkLCOf0QHENbuica60wnMl91
         4lXX94Z+NeFyXExSfZga9A0maB876DXmuM2eywj7NB9QviFig4D8DpOT1rbSCklowt2Z
         KECm/2KD4B7RKLsPU6CoRNvnavysxJpeYYm1R5kEdjoC0BGXFuc/sGwFy46BN0J4vzfA
         8VE5X6YmrVbhfbPbEfAXMxrtbpHpHVgv06R/G/H9XiJKxgkbUwYITmT8Ij3xD3/GqONq
         YNPheCTYNfwW9e0YTHOplPnSQMNSxkwnZ3EJOoEm+BjrjU/gQ9xz7gEF54TS86TyO86p
         VDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784844693; x=1785449493;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9HODvWBOGd20teJbnv+TM8mIYLLEFiHYOCWHoBz68ME=;
        b=KnmqOGa4SXcR1f9mUronLSVlBLIHRMAwJiSogS7W3nIKyxsD7TfK02hZJ3ksfllfmk
         DKhwvLORydjh9qfaqiVkwbAx/MVVYONUDbzUPnRUDIAHvsGYrSrhtfWZ2Vl1vVCj7Er9
         ZTQY32NB2KEI7+0/56YvVX+CPKkShHxozgRXZJBIyLbwJV2rUQghwI/gmBdgP2M5u+C7
         IvpcVDV6jARvBgGuBybk84IxAAIgI3TL1oqeqfUozVazAXHKJqptW8kM+lbzP6NSPaDx
         0OdHDE1pDs60bBN7iNrgYb2i848DD/br5f8m7+Pb438lGe/7qtFRKk/zgCrCE5r7AVhk
         7D6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpPrn7jjL1pH2yCTe/N86VABNjwI/URwGlewTNQAP1VhO2ujiOee9QD/fTy4at8PO7mC85G9Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf73UYgXMXnOKIMmldyEpKTAR6AI39D9n7wExVaMobN4ZGpKe5
	pAvNUttUwpbUq00SUJh+u6NGtBITugWKh3R5BcbVTFbXzI2QT4wTvjzm
X-Gm-Gg: AR+sD12TmypO8Bvp84luHaU+eQLenPAbolCuLjseHOWVKorPyuHczoBQOeY78G8i3Kk
	QdDh/rBfcONGZdJHWYNZz58vRX09p6u2iH4UjykVmimXQMACsELTXCAKpMbYopFWH5z1l4W578N
	mns4B22MGACBKAVcNDKBnYAHjuEWJxF36KHfQu1T9VENPhbiC8p6YMfjjidEM/IEl6Phr62/iYQ
	hYgt7DptAMH/j9XXjzmKJAgYBpQXJlaPNhwruEs/WZecLl4sq+m4lhX2iZV4eWCwj4cJ1wC7xCe
	8pl2sCvIF8h5gRZZXIqWy2+nQZbnwJrlm+/3Hg+wWKpRDgrTn6wRUXTgnWHdJEpNiht5WdoQMXi
	WMLWHNDWxRYXCK1ag0kWJL1AvxkcRWfMturSqQXqxTvCKefvceH5OKHkNsG/I6ytlIWxNcFCmNo
	ov6E1NQEnQNmC0KYzQhRPGhP8i7WqQ8/gUs5AF8au6tA99rqO7RCo=
X-Received: by 2002:a05:6a20:9404:b0:3c3:a969:2cf with SMTP id adf61e73a8af0-3c44b2110b7mr4755207637.53.1784844692780;
        Thu, 23 Jul 2026 15:11:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::8e12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc8b0cdsm22810333eec.11.2026.07.23.15.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 15:11:32 -0700 (PDT)
Message-ID: <c55b6309-10ce-4074-a70f-64f58af2591b@gmail.com>
Date: Thu, 23 Jul 2026 15:11:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ethtool: add hardware pacing offload
 support to rings
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 Willem de Bruijn <willemb@google.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
 <20260722204454.3234605-2-willemdebruijn.kernel@gmail.com>
 <9c0a0bb5-737b-41b7-828c-1953d885fb1c@gmail.com>
 <willemdebruijn.kernel.9e5ac85b024@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <willemdebruijn.kernel.9e5ac85b024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/26 2:29 PM, Willem de Bruijn wrote:
> Mohsin Bashir wrote:
>>
>>
>> On 7/22/26 1:43 PM, Willem de Bruijn wrote:
>>> From: Willem de Bruijn <willemb@google.com>
>>>
>>> Add two ethtool rings operations:
>>>
>>> - get pacing offload horizon: active and max
>>> - set pacing offload horizon: active
>>>
>>> Replace u64 max_pacing_offload_horizon with u32 active and max fields.
>>> This occupies the same original 8 bytes. Reduce precision from nsec to
>>> usec, which is sufficient.
>>>
>>> Update the FQ scheduler to test against the active limit instead of
>>> max. It is the administrator responsibility to set the active limit
>>> before installing FQ.
>>>
>>> Assisted-by: Gemini:gemini-3
>>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>>>
>>
>> If I understand it correctly, the horizon lives in dev and is read at Tx
>> time, so it shouldn't require touching ring config. But some drivers
>> reallocate rings unconditionally in set_ringparam. Can we highlight
>> somewhere (maybe in commit message) that a horizon-only change is meant
>> to be non-disruptive? I may be missing the underlying reason though.
> 
> What do you mean by underlying reason?
> 

So I meant, beyond just exposing the horizon through ethtool, if there 
is no reason to touch ring config while updating horizon, a note about 
it being non-disruptive would help.

>>> @@ -281,6 +301,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
>>>    		err_attr = tb[ETHTOOL_A_RINGS_TX];
>>>    	else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max)
>>>    		err_attr = tb[ETHTOOL_A_RINGS_HDS_THRESH];
>>> +	else if (kernel_ringparam.pacing_offload_horizon >
>>> +		 kernel_ringparam.max_pacing_offload_horizon)
>>> +		err_attr = tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON];
>>>    	else
>>>    		err_attr = NULL;
>>>    	if (err_attr) {
>>> @@ -302,6 +325,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
>>>    
>>>    	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
>>>    					      &kernel_ringparam, info->extack);
>>> +	if (!ret)
>>> +		dev->pacing_offload_horizon = kernel_ringparam.pacing_offload_horizon;
>>
>> Since a driver may be reading dev->pacing_offload_horizon on the hotpath
>> without a lock, should we use WRITE_ONCE() here? and have the driver use
>> READ_ONCE()?
> 
> Will fix in v3

