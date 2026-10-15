Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC60468C37
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049767; cv=none; b=UZDy1CTlS94rSoFS87zYT8GoFfAn1MF0DZwYkGHk0jvVpbntxwvd/zhsYWU7NmGgBZXV7OoVU9K+TuLtv5nnXopoynjrgNJbEEOIOG+DsGMcjc/JxxVfUXSUd3MhulgCopSA1OMzyEFUZEBY2eIiKC/WcSSK+3FOIUmrT6uReB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049767; c=relaxed/simple;
	bh=BrUMaNbKO8ygteLmODp3rVHRMVxLpGCR9nWZ0qz2Bfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHEaUMg8niMLnWx/eIpJ6io2YAk6o6ZfQLApAIW/H0Dd5XAWb3d8ncGp9jd4RIvaF2N2EdN4/LOC9JxvXjUFmIscxzdmofULoWTwBRNrolz4fW97U42yxUyk7V4OfshK3OMzgCglGuItnE8at/yZpjAwGQ8zX3rPs4lhgX2XGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLEy61tZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFf3iknW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLEy61tZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFf3iknW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792049764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfFy6KfLE+4KLuU3ZwrUcLBflPtmLzVW3MEDG7MNIAc=;
	b=jLEy61tZ/tMyiWMIv3YT6nOCuMilmaLF+trr2Bi1zTHEvyRhfzJCg4ezYNMFIpHnsgJ3P9
	3s+g6Q/vQE/+1AAQ7ALIRUjsdFBz2VTd1HzAxAXkarxH7qwf+Je85dLGu/7JdbzMm/Tud/
	oxpCWg8p9Mtl2hgOgqxHdOrqd1w/bdk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-7OO15aW3O5O-voeDEUlrLQ-1; Thu, 15 Oct 2026 07:36:02 +0000
X-MC-Unique: 7OO15aW3O5O-voeDEUlrLQ-1
X-Mimecast-MFC-AGG-ID: 7OO15aW3O5O-voeDEUlrLQ_1792049761
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b02d63407so2963651f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 00:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792049761; x=1792654561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AfFy6KfLE+4KLuU3ZwrUcLBflPtmLzVW3MEDG7MNIAc=;
        b=IFf3iknWoDsFHg27E0yVz4+bZ9Lu6Oi/YEs0WwxKcHfql6LXVevs03QVvEk1QYVcLI
         vBt8A00djwWu0A+E2/kvJxoFPLNDtAoGmmHdCUI0H++T4mR8tcNsyljso4H/9g6CJxde
         3sOg1yUav9EIUZcaM+y+ldf84qnJk+frr80Tal4OgVpdXKKPKpzLtBkbTe30GUT4hvRy
         XRv09VsMYhcqFrUMKCNachokuv3yQhP7CQEsyDUAjAiziyzEKqBwuH68Sr27W92dXqiW
         ULcjiTTlaDg6oArPKG6FXluqgkPy8r/cesFMGt9Yakk62TiaEfcJnpPRbMgB1eZC7GYh
         j9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049761; x=1792654561;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AfFy6KfLE+4KLuU3ZwrUcLBflPtmLzVW3MEDG7MNIAc=;
        b=NRLqyTMkKzoMTY8Hw9atSeWiNlCbiXPFJMZKoiqCBaqSOBI+gfuXug1SJp1w4rSuTG
         ZtE3aCkqe16po8rpBRrIDv8vpcOAYP3YlnXUqoOfDVCrvxr79460cluFDrFYLUwDYwaN
         3Eu+2Gu2H3w4qu0g+0X6DF9bEGnVpCI4VnKPkht4jj1szSsgcwQ/Scb5Jy4c3lGW/BVb
         qGzor5TS29IVPRNSrjl2EgkF9NmSBY5BM9fboRm6ZlTx18t2U6mi2hfSlprXfVkrDs5L
         /uNQiwveUnEiH+x2zPILaOhCFniQp6JFQ+YiXKk1rbwdA8q9FuOD2jx/DBWyzfRRGRfi
         tayg==
X-Forwarded-Encrypted: i=1; AKwUvBx9qnJ8KpiDOwiGUyjb4l2Up8bJAxsjP5pU8FMP44qEfYpU5SLgI0vnYDum2Zs4PqnZ4+ASYEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5em6Xh92YxF8eJ+kIexEQjP0WrCz9cVQY8VphVD5rXdXKMSP4
	p+O/v7JlS/8uWSsr8CYzZ5blE9diVTSA8UHQpk34xVAIRUkx8FBe+rg6HsJcK1kpgXYD/xDIUsn
	alXcnMKvbC8kTJJurxfVX0ORMfD+tZjw5P6gANOvQXuI0uBvd/vSdk+NBEg==
X-Gm-Gg: AYBFou2A1Y67Mz0LtK2qNQMep2CUkMW1c8n/Dx5G/Aq3Tb8bmu4GiYcSHiHji+VP6nK
	F5EcituVyDQQO26odyoizjf+jq0c6J2KSd11H1N2Qk+lJGm62VUnP2Lq88/CblCJchENxWG7F5Z
	IrA2LjeXVi43HctVSHRwC5CzF+ZUwJyJvfeA0TnuzY3QthtNR0gSokrgqdPsH/nie822H0jE3xC
	9sVbruWyrsI7cZsrF6kNY0+DpNXDGKBRLbf3PV28azCXXncoi6geWaNyhOi0T8JdjUGqJ50Ih36
	IyaKY0OQbrgD3gXjyPIPKr2vAt2QxTmuOrFHxyMo9Cd7d1zZ+NarG9Scl48j0J3AT61jQi0Gfmb
	4sIhxloGQ2vqdn5X8nmXaApuHIH3L2Owc00Q1kyWwk21grPK460I83cuxlOiCT078XW2UBA/lng
	==
X-Received: by 2002:adf:e013:0:20b0:487:930:8acc with SMTP id ffacd0b85a97d-48dbaaddbd5mr25917373f8f.16.1792049760940;
        Thu, 15 Oct 2026 00:36:00 -0700 (PDT)
X-Received: by 2002:adf:e013:0:20b0:487:930:8acc with SMTP id ffacd0b85a97d-48dbaaddbd5mr25917342f8f.16.1792049760546;
        Thu, 15 Oct 2026 00:36:00 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm17520870f8f.51.2026.10.15.00.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:36:00 -0700 (PDT)
Message-ID: <d832de5c-a01a-471d-b935-5ea00d1c5794@redhat.com>
Date: Thu, 15 Oct 2026 09:35:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
To: Daniel Machon <daniel.machon@microchip.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, Joe Damato <joe@dama.to>,
 netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 daniel@iogearbox.net, jacob.e.keller@intel.com, suraj.gupta2@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261004083759.1016519-1-maimon.sagi@gmail.com>
 <asQ1pF9AAqOiEo3r@devvm20253.cco0.facebook.com>
 <CAMuE1bGXcNwKKX1firkq6eEzymkrDOp8PnnowMzz97SibtpoSQ@mail.gmail.com>
 <20261006180210.03a15e52@kernel.org>
 <20261011084652.c5y3zj7wzmj53ur4@DEN-DL-M70577>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261011084652.c5y3zj7wzmj53ur4@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/26 10:46, Daniel Machon wrote:
>> On Tue, 6 Oct 2026 06:44:55 +0300 Sagi Maimon wrote:
>>> Agreed on the helper.  As on v2, I kept the fix minimal for net, and
>>> will send the helper to net-next once this has reached it, with both
>>> axienet_dma_bd_release() and axienet_dma_err_handler() using it.
>>
>> Let's do this now, trying to keep fixes small is a bit of
>> an anti-pattern
> 
> Out of curiosity, why is that an anti-pattern?
> 
> I'd think that small fixes are, in general, easier to backport to stable. Is this
> more of procedural question - if the whole fix gets into net, it will get merged
> into net-next by the end of the week anyway?
I'm answering here because I can only guess how scarefully long is
Jakub's email backlog, and possibly this could get lost.

I think the key here is the context. This revision is incorrect because
in order to be minimal intentionally adds a significant chunk of duplicate
code, but such duplication must be avoided, the 'keep is small' is not a
good argument to allow that.

I guess a one-line alternative implementing a different solution
(if existing) could have been ok.

/P

