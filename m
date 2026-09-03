Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED045FFBA
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435557; cv=none; b=i5j2DOD/LiotpqB2dIT9IDmlJYtPgEbaf3nhkk9Jw23XPJe6OuBHrAAO/NhecHzwifOGnrLeIQs3feczX7l3TXDa6S9El5RTC8907mMAAk4Mtx/Oj0v49aTf+YE4Q2hg1/ecTYYbNVMuaKGBUfC6EkVszZ8mmTn2y7B2gITNmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435557; c=relaxed/simple;
	bh=ro5ycANoLWJJCE9324sTDjhQ6jvDY7a4igZpzbhFBBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EonNJVA/AQXZKP9V/SjrHoxmYUuhf4x/8EmM+1c3UOa1BZdAQ1K/RbXOGJBjKUlc68wwI73BD7rjLFWPUKNN5P+PkeC1t6Ho7C0qiS5+/kezmO0qV54b1o3Unwqsl02ITHO+kshbsV5tHLet/xJbxEOk617YqnjwAu/8c6fj68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=WXcs3L4s; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="WXcs3L4s"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-396bf83d458so830040a91.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788435540; x=1789040340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRU7hLnxNiZ55MaNHqLlZScRyTHKVnmWkFZTM4ExPyA=;
        b=WXcs3L4si6KuoF36NArKZksDtLUaaDRzsPBs6vgmdr3dhPO0GaGg1FPC6h9eICs25A
         BwWj79QoY32YPaAG+WTDJv5q0O3qHPOLZAiiMnxLVJ7B2pcVRMDqlTljyFkKRwiK4zgX
         lbGp0yetCe+EFhcXvym+ZseSffsKNVaUoU6NRt5nfufO1qFwRvhrWCmuhd8ZKS8T/fIs
         cIIEYGkLskaE0Gfk1FX2505LfjfxxmjCDOE7dt8ediDIfzlPKQVhqyY7nLpXv+ces+48
         G/Yak+a3yL30OQK27ubwqavdxv4i7+VjksFeo87EDG1HzYWSyyBKcaNeNYKnXDQYeDJq
         HlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788435540; x=1789040340;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRU7hLnxNiZ55MaNHqLlZScRyTHKVnmWkFZTM4ExPyA=;
        b=THqjrX0U2TB20mC29n9T4l6PtB8szcE/x2MgK7LTakkyUdbzRIBMHkP4xQFIzcSICY
         ilwW3Z8CXbmMDSyGvlN3V9bIhqH1JY0IqzTQwuo1iiumF3vxHjmWc7kSXA2/gfd62jKZ
         2sx/N4qIu472m0xwZenjYMVDrTIR4AUn9hBMzTfTQgVDnfbJh73cDj9zQR0ZHlVVd3BU
         PaSTy43iUyYvYMGeg/WTlkj9Kg25wzX85hrFkqr6Cd7c7ttnEkpRaYm0omfBlGq/CZhv
         9a196/K+68VTK44K5dVE2KdyTQVvwJS0yILJcaxuacX2g1l2ZSpFuHgiFmYiRpVXbmnP
         IPuw==
X-Gm-Message-State: AFuF++kkdmvfPTfXhsKJjIG/VEQjbbKQhkjASe5fUVlu/+0ateijKC3F
	WmwADhDNU6KPNOmR65Cr0PnzKD5zsHqH5fN/T8eR+/O46d/efsz1rOubS1adl6z0N0Sl
X-Gm-Gg: AYBFou0PFf5i91umfOmqaQ1xIXGw94I1lYyorYMpb9pHpO0uKgXYAPtQkw78Xb01K2R
	0BAZVavI88qSGgLR83ZOkbY3UO0PXEFy74Ww1NVtqQjrMYbwnBNu7Kc6e8PLdIndNovam+5jHZ1
	KHsOFAmxdsElVmMqhNKmsRnQ4MRVJTOit8uI/yCTVrXa4oLkx+NH50VzjriC7BeRaA16Ip0b55F
	YjwBXlDzh1CVut0VU1QmYdkylnaOaiHizY3xWfRghcfudKsTD9RQ22M0Qck6Uvk6eiQIe4F1WJu
	6xW6aohi+Yslcd4y5MTQWcgzj/RGHE1QVY5c39lG3Bm0vsTK2QuTM+WFHuIA+b4JwjEqhMiTian
	+5s/honV+sjsrxI1Qtx/hNSn8JxBwNuXzKcdn5fU51a1TrNj23fWda6K20sQvczsg63m5oOf1Lc
	ZSakos/+MS3xgji7Cvino1sMHy41C2lE0LKdgdRTDNWUNvUr9iS63ZHipKD0zV8UmucvrBXTEY0
	wu8KAbI+TbUKOx1UO2epLbX7Bb6Xg7we1mXDuUhww==
X-Received: by 2002:a17:90b:164d:b0:398:c16e:69d3 with SMTP id 98e67ed59e1d1-39aedeb9aecmr17724130a91.1.1788435539824;
        Thu, 03 Sep 2026 04:38:59 -0700 (PDT)
Received: from [192.168.4.59] (c-73-93-246-205.hsd1.ca.comcast.net. [73.93.246.205])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14319922eb4sm5341286c88.7.2026.09.03.04.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 04:38:59 -0700 (PDT)
Message-ID: <e105651b-a773-4a46-80e9-1e2ff0b665f4@nebusec.ai>
Date: Thu, 3 Sep 2026 04:38:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] A Syzbot-style Platform for Verifying and Fixing
 LLM-reported Bugs
To: Jan Kara <jack@suse.cz>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org, frankw@nebusec.ai,
 jhs@mojatatu.com, ksummit@lists.linux.dev, kuba@kernel.org,
 pabeni@redhat.com, kerneljasonxing@gmail.com, roman.gushchin@linux.dev,
 jgg@nvidia.com, mchehab+huawei@kernel.org, torvalds@linux-foundation.org,
 ben.copeland@linaro.org, gregkh@linuxfoundation.org, yuantan098@gmail.com
References: <20260830115546.3942129-1-yuantan098@gmail.com>
 <f73vtlhwpdgrt5klkk2cgxfuqsvwvvlhzti4nu7hgdevwbqhvt@g2udlammqolb>
Content-Language: en-US
From: Yuan Tan <yuant@nebusec.ai>
In-Reply-To: <f73vtlhwpdgrt5klkk2cgxfuqsvwvvlhzti4nu7hgdevwbqhvt@g2udlammqolb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/26 08:10, Jan Kara wrote:
> Hi,
>
> On Sun 30-08-26 04:55:45, Yuan Tan wrote:
>> A month ago, I posted an RFC[1] to the mailing list proposing an automated
>> platform that validates AI-reported bugs and prepares draft fixes, and
>> later discussed the idea at the Netdev conference. After further
>> development, it is finally ready.
>>
>> While preparing to send this email, I noticed that Roman has since started
>> a related discussion:
>> [MAINTAINERS SUMMIT] The place of AI code review in the Linux Kernel process
>>
>> It turns out this platform already addresses several of the needs raised
>> there.
>>
>> The platform is available at:
>> https://bugtracker.nebusec.ai
>>
>> It is currently hosted under my company's domain for convenience. I would
>> prefer to move it to a neutral, community-oriented domain once the project
>> name is settled.
>> Access is currently restricted to maintainers whose email addresses are
>> listed in the Linux kernel MAINTAINERS file.
>> For now, only bug reports from the net subsystem have been fully imported
>> and processed.
> I was playing with this for a while and this looks useful. Some notes I have:
>
> 1) When you download the patch, it has 'From' field set to some value (I've
> actually seen different values in different patches). Perhaps it would make
> sense to automatically set From to the person downloading the patch (or
> maybe value configured in user's profile)?
>
Fixed!
>
> 2) Based on current state of the kernel doc, the patches should contain
> "Assisted-by: LLM" tag although I understand that might be controversial.
Fixed! 
>
> 3) It would be nice if you could "assign" the report to yourself - i.e.,
> you've decided to handle this and don't want co-maintainers to waste time
> on it anymore.

This feature is ready now. Our fixing team will also assign bugs to
themselves. Feel free to remove their names if you think it would be
better for you to fix a particular bug yourself. Our team definitely
won’t know this part of the code as well as the maintainers do, and
reviewing our patches may sometimes take more effort than fixing the bug
directly.

As for patch generation, I’ll make some adjustments. This is indeed
because I explicitly asked the llm in the prompt to follow the reverse
Christmas tree style.

Also, I haven’t had a chance yet to enable fix-status tracking or import
the Sashiko bug reports for the fs subsystem. So far, I’ve only finished
this for net, as cleaning up and normalizing all the data has been quite
a bit of work.

Some fs bugs may still be outside the threat model, such as those
requiring a corrupted or malicious filesystem to trigger. I haven’t
filtered those out yet.

Over the next couple of days, I’ll first run the fix-status detection
for the filesystem bugs and try to reduce as much unnecessary work for
you as possible.

Yuan

>
> Thanks for putting together the service.
>
> 								Honza
