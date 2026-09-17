Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5C3264D8
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645021; cv=none; b=Z1hJnlTsNhQebclDSvEpnWcj9pIgFaAu1fqfXpMPID8aRIyXZs8OaGHaF/yqUT0KY+7NXe4aKVMTbDZ21ZJ4YQlzI0+r/5gU5kqawWiO9PJ0UeyaGctIx2X+nu9R3zo7Bs0Af9kUL6VuZojs7a3985zVlqLkOVTfVMmhuGAw6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645021; c=relaxed/simple;
	bh=+57GokJSDCGHNK+3MmnA4CvC0wmbFmdFo5bfAjRf2FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCKxaL9C5RsOpwZTpXs85kBIMLIKoJ8iGlvdTkbQ576KqKwGe5LldVCt4BYcgxVNaom8G8ycp2yYTggUWuMCwr+fuB86uCvCFL5jgvU/Vd8g7npAcQyEvbHEpZoI16C4VKcUk58kYLT+eBmW13jJ5nqS5uQWSV0X87fe7lKSY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZzDZqA+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUAb3a0f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZzDZqA+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUAb3a0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789645018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXxnUzgjG7VZuYAvI0ebZRvmp+LpupVUuSh13S/t1W4=;
	b=KZzDZqA+ecw/+Hnx47y1a0giag5hMOzqizZIw1z3MoNQTYxKOSvMijRdZ9vVCw2N7Cs50V
	SNAivmDuHnIZkF9GirwrtWIfNygBE42XKkAl7o5kKYgz511maGUY0hEUN/ITVI7EdPYqic
	AAvGW9uTx1a1IYLdHQcEgGXsNZsyTUk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-2oE_KiIPPMaoiCVoxekOcA-1; Thu, 17 Sep 2026 07:36:57 -0400
X-MC-Unique: 2oE_KiIPPMaoiCVoxekOcA-1
X-Mimecast-MFC-AGG-ID: 2oE_KiIPPMaoiCVoxekOcA_1789645016
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49d156c917cso4168225e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789645016; x=1790249816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXxnUzgjG7VZuYAvI0ebZRvmp+LpupVUuSh13S/t1W4=;
        b=PUAb3a0fig00Dp4jbo0hJ4s5DPOweOFGwkrTSRbiz/bZ4j2snkf5GiRtVS1bmwXWAb
         WsX3bSiiG9f5wo36Ohe20oLRlh1mKTfuDuZc3pevveWqDWtlYve9F1FUKEGvhpn+5ooo
         ScBH9bhyviWgHvaxiyVL7WYlTLX9DfeGy9EhR6liRQDgURDkdDIdlnOKHjv2aObLqxgb
         WzzXx3XcxwzYBw/DcFkTC8g+zARrlytzxogoUS6b3L9k16lv0AFyhAaXPyH1F0MEyBtt
         RAOHMjRWhDdmcQAxpoM6M7jdaDfYG6TiSkeEG6CyvjsuS6YD5yL2adAPU3jnbGkqdQ9Q
         wV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789645016; x=1790249816;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fXxnUzgjG7VZuYAvI0ebZRvmp+LpupVUuSh13S/t1W4=;
        b=hxy+6MZen+GUIbB1e97QebnombZa2kTkRBntsI3QrgDFWd8STvtgXp/ICULGTAFIaS
         fsX7/K61HeBIhiEnc0uPYaHhx9Jgw231FnDxT1vMPu37PhIq1tN7x9mGLQHVF4Nv0oMl
         RInMPtyp57KHknd8xdwlGk40z4ZTTTIGAzJKsCiygCeCZQZZS20VaiZbEEWBaREZUKmr
         MLmM7fhss1Y2ftBp+M88vtcQDc+xlOT5RjdfSShiR5O0SXoczrpKH4PzIJJLhKhxlROi
         t4zbzQZ+DZRCIdkil87IDvjFQyItJ0pL28x2wIAIG5RqRFcMYUuEXJMXWZV3AoeJqsqv
         vPKw==
X-Gm-Message-State: AFuF++nvdYoBGosAGLrRSEm46DlCZ3btwSQn8HALcHtvDoNkdpIWL5AS
	gcuYGqz+/sZ3qtdES2gROSCfvSvfFfgNHuq9UaEDU+aLr+jbr9KjJYnAwi3Q4rUkB7yeAjzIYPD
	gSzDTQe3NEx0v9rXngb3/rcG8gHvmqgeJxKgyiplmQs73FDhiVQ9wN6sgkQ==
X-Gm-Gg: AYBFou3nk/hu3yx7gYFdUrOCgJxtebUgVVrOO8tyPxSWMp2BR13INUPZgWKO/1kjDJm
	ncXxDkUjdgimE5vh5bxVcl4b2qtZ6e8eOVubCtWpcUj2Wu1Jj4mr6L1zkpQJPyleqp6Lhvy/ziY
	///B5lDdkOMD+C2IcSQ/f03KovZwGFiSeWJsq4oZVNh5y1uEs0YGkXdPMxyBzi2uOXEqPoCE7zT
	aABelZZTUU/qwSMI5NqaKyV8MHx4xRyTNjinJVKDU5s0JUJOQ+nN0HmnCZXN5310UxcAMNqmpij
	HQnBULQB2FXwwtNeEDWFvJa/59+G3YX0UmTCgpCYcVTCf8RqRC6FOiu83a+SExbxUsfm3nGWYeX
	nhQ6cvb7SBEzKG9Yy1e18FUpa2TxfGvn8yVcvNChTT/+cyRUpPnxORlVT5hykar2xrw4t9mUM8w
	==
X-Received: by 2002:a05:600c:c490:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49fbd1b7e82mr41476825e9.4.1789645016120;
        Thu, 17 Sep 2026 04:36:56 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49fbd1b7e82mr41476525e9.4.1789645015716;
        Thu, 17 Sep 2026 04:36:55 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbbd83e39sm97196385e9.4.2026.09.17.04.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:36:54 -0700 (PDT)
Message-ID: <1ca84bcb-016a-4dce-b80f-66b9fcdb9173@redhat.com>
Date: Thu, 17 Sep 2026 13:36:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: network dev <netdev@vger.kernel.org>
References: <20260911105521.689565-1-rkannoth@marvell.com>
 <20260911105521.689565-2-rkannoth@marvell.com>
 <20260912105628.B3E251F000FF@smtp.kernel.org>
 <aqdmy0GU7pV6wryi@rkannoth-OptiPlex-7090>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aqdmy0GU7pV6wryi@rkannoth-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 05:15, Ratheesh Kannoth wrote:
> On 2026-09-12 at 16:26:28, sashiko-bot@kernel.org (sashiko-bot@kernel.org) wrote:
>> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] TC offload setup on representors corrupts the shared physical function (PF) device state by locklessly overwriting its netdev and clobbering its flags via a non-atomic bitwise sync loop.
>> - [High] Inverted logic in `otx2_tc_del_flow()` prematurely disables TC MARK hardware offload when any single mark rule is deleted.
>> - [High] Missing cancellation of `stats_wrk` leads to a Use-After-Free during representor teardown.
>> - [High] `rvu_rep_mcam_flow_init()` interacts with the mailbox without acquiring its lock and executes an unbalanced `mutex_unlock()`.
>> --
> 
> I will address these in separate follow-up patches to the 'net' tree once this series is merged.

Note that the relevant sashiko instance for netdev is:

https://netdev-ai.bots.linux.dev/sashiko/

Findings from such instance include the public ones, cross validates 
with additional LLM models. You can look exclusively to the nipa one.

/P

