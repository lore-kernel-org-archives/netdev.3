Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A29367F21
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032443; cv=none; b=OgGU2jPbAyC6HeskZKFKE1a6p75WT8AXI2PIt/ZE4iL/Dh8hDyumj5uvUdtLlihCDZI0+XRlrgKMRHM0xVOYMi7AOuMIy3bek7mVDTpzGh6h05u7MaA9o7YcE1PGJpWY92ssjOvn2YLKZzI4Dc8huJCief747UNaxXS9hBaaNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032443; c=relaxed/simple;
	bh=onSrGR1DPPS7AniFPeG6y4FBr8zoZ5FvmsyzKudrgSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsEOrN9eLDLUsxNasNi20rm/Cwv6ONnM4PjHP5h/I3F1vxoj5zjGw0rG0gALqbGh7BoosndGlAHy/+5v8HxiREDDa7TM++5wnmfcf9cMoy4ORCQLKPRpNz+Wv96jMpDgOoB19WE57dzWoMEYykgHmyHAy9Axr0pEGqZ3JLG6d2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TAvJ4YQA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1jY1Nne; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAvJ4YQA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1jY1Nne"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789032436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/3XKDJU4nAR84kTuAFEMqKuSOff2uwWs1pjVTD0st0=;
	b=TAvJ4YQALbIeh12WvIBrOYo495Y/hq3GnxZGUp6A/BpDagx8qSqGav4SYtqn0RJ9M2jXxA
	as3PzlCMKHbzHDaYacQ8Tfz/x0O7doSfNJtrChR++I3j681SbFnJoQKFw3kG/CbFbMl0F7
	FYEdf4mwfowqhQU7irPkT9ndm6U6sHY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-z5sbMzFPPBqTYk1VFBoDRA-1; Thu, 10 Sep 2026 05:27:13 -0400
X-MC-Unique: z5sbMzFPPBqTYk1VFBoDRA-1
X-Mimecast-MFC-AGG-ID: z5sbMzFPPBqTYk1VFBoDRA_1789032432
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48436a5fb42so3786515f8f.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 02:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789032432; x=1789637232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/3XKDJU4nAR84kTuAFEMqKuSOff2uwWs1pjVTD0st0=;
        b=T1jY1NneuyhNnBIGlEgbFa8AtzlX9BGuGO5zhN5BDj6UkMlxCUhipMr3EdFwNtfbpI
         2IzHkfI5RLQuqC5AFEv+zFDU2awDaUqbVeLKoArKwhALWnZepoy4N+55w7607vHty7KE
         TH65V6BvH3CpoL1TPFBP8OGbaiGq+vTSZZ0c0GB0GWJeJy3v3uCJAys1u/5oPK5ycpFa
         5dsMqQ0pK8vFIOGt0c4xEIgCim2aA2rG+3bU6im9TUt2TSm00/OKEp2I78sg8Nx3VXaa
         IeO5IAjc2+SGwGyrKJcdfum777DwnnqTGIctF7KA0nWkEk6VAU/OkkwRxAAdy28I956h
         MKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789032432; x=1789637232;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/3XKDJU4nAR84kTuAFEMqKuSOff2uwWs1pjVTD0st0=;
        b=gMqCpdg6YWmvDurnby0x8tupGbWg/6QXM0soDdMuHzurZX7W0pzCRsSSXaPmd1//ML
         5bhdP61NPl4lptt9M5OPHGcz67pd5v4MQH4ziSvox0wS3/169SS5E56NvCIG4yv6OVgV
         EyosbAdrmK15vaY5nZpWpmdJbytiXO5oiuYpfqcR0atr+Le2rI9kSBtiu1Xbw9N7sf+t
         vxME4r1FSUz7TaQCUNldBdK8nsp92h9+3C9KQZmsjAFbE3Kj36fHM92xisFTt5HZPQkI
         4e8FoC5WNdZQ75UuFP+SR/NRbiMOlKBHx4h0jSPL3/ISz0p1RVxYTEi/irMvm4QdTeIy
         mWWg==
X-Forwarded-Encrypted: i=1; AKwUvBykFBDBRXrWRQHBxTUpQhsuz7a9PNU4f62FOdez++XoxKPhLpI0sVuRNCrlyHUysM/COIT28/E=@vger.kernel.org
X-Gm-Message-State: AFuF++kqPFx4yXFo0+y3GNaGvbzEoWZ4pvx1CmgbqJRx2l8Vsn9AV7OM
	ufk7u5dgZXWQj1oKEzAOZWTsOwVn0UPafAZEtw3mY+h4VV9QBBXiDkzvb5lZMc/Xta92LMdXsSt
	2EW2AEqy2ZGbhWCFQkW6gSs7nVuh+pbV01YYODwDTB/mYorcBHaY9m59giQ==
X-Gm-Gg: AYBFou2r3O6xMdcYSud3XbUHDzKU5UyOpeU3t1O3flRZUXzrqVx9oHeJCNHnj3R6ebl
	PgkKiEIUYxInUugKDxebLZ5+GxeZMSxWHsvtF93C7W6am7LC4ZUmQY0wabWZtx5Nw+wVbdyL3E8
	6gNEEharQvdLzCZclAW/WqyYnn1U1ejDPwZCmXgBMyyrLgeeyKvIrJ6AD31mxZFl/H1kADMIF8M
	agbD1E0oexfrJ6dvebricJ70kULzfJiSMQXhltETKw18fRgGzMcxwOtNlnXKnGvU1GPbl8rL+u+
	vPiuuajCvRocyhXuSX67HTzmVycb3kmI/UF7uN6EVqQ9jnP1bF6jfHmikmm26uccRmqmpIqqA1D
	QbEGwNB1Ow+8aXJ6MzUlf0iHAlTho3FGE36FQB0w4XIjML8w4NLl9yleJVWYkl0rmQGf3iIVt9g
	==
X-Received: by 2002:a05:6000:2011:b0:485:b169:54f8 with SMTP id ffacd0b85a97d-485b169569dmr7592354f8f.2.1789032431980;
        Thu, 10 Sep 2026 02:27:11 -0700 (PDT)
X-Received: by 2002:a05:6000:2011:b0:485:b169:54f8 with SMTP id ffacd0b85a97d-485b169569dmr7592302f8f.2.1789032431401;
        Thu, 10 Sep 2026 02:27:11 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883953cfsm41570666f8f.13.2026.09.10.02.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 02:27:10 -0700 (PDT)
Message-ID: <fd286e60-73c0-4a6f-8861-7f6cbc197cb0@redhat.com>
Date: Thu, 10 Sep 2026 11:27:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/4] net/sched: cls_route: Reject handle aliasing
To: victor@mojatatu.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org, vega@nebusec.ai,
 netdev@vger.kernel.org
References: <20260907192133.2639067-3-victor@mojatatu.com>
 <178894934962.219967.16944577524953312446@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178894934962.219967.16944577524953312446@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/9/26 12:22 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] net/sched/cls_route.c:route4_set_parms() — the duplicate-
>   handle scan rewritten by this patch (line 463: `if (fp->handle ==…
> 
> --
> 
> net/sched: cls_route: Reject handle aliasing
> 
> route4_set_parms() scanned the destination chain for the filter's old
> handle instead of the handle it is about to be linked under, so a change
> that moves a filter into a chain already holding nhandle missed the
> collision and created two filters with the same handle.  The patch makes
> the scan compare against nhandle and adds an extack message.
> 
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829205422.854785-1-victor%40mojatatu.com
> 
>> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
>> index 17b0ebb766626..9710b77d379c4 100644
>> --- a/net/sched/cls_route.c
>> +++ b/net/sched/cls_route.c
>> @@ -460,8 +460,12 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
>>  		for (fp = rtnl_dereference(b->ht[h2]);
>>  		     fp;
>>  		     fp = rtnl_dereference(fp->next))
>> -			if (fp->handle == f->handle)
>> +			if (fp->handle == nhandle) {
>> +				NL_SET_ERR_MSG_FMT(extack,
>> +						   "Handle %x is already in use",
>> +						   nhandle);
>>  				return -EEXIST;
>> +			}
> 
> [Severity: Medium]
> 
> Should this scan skip the filter that is being replaced?  When
> route4_change() is called with an existing filter, fold is still linked in
> its bucket chain while route4_set_parms() runs, and f was seeded from it:
> 
> net/sched/cls_route.c:route4_change() {
> 	...
> 	if (fold) {
> 		f->id = fold->id;
> 		f->iif = fold->iif;
> 		f->handle = fold->handle;
> 
> 		f->tp = fold->tp;
> 		f->bkt = fold->bkt;
> 		new = false;
> 	}
> 
> 	err = route4_set_parms(net, tp, base, f, handle, head, tb,
> 			       tca[TCA_RATE], new, flags, extack);
> 	...
> }
> 
> fold is unlinked from b->ht[] only after route4_set_parms() returns
> successfully, so the new scan can walk into fold itself.
> 
> Two things seem to follow from that.  First, for an in-place change that
> keeps the same to/from, nhandle equals fold->handle and the scan matches
> fold, returning -EEXIST for the very filter the user asked to modify.  The
> old code compared fp->handle == f->handle, which is also fold->handle, so
> the self-match itself is pre-existing and not introduced here, but the new
> extack now reports "Handle %x is already in use" for the object being
> modified, which reads as a foreign collision.
> 
> Second, does this newly allow a filter to be silently renumbered?  The
> 0x7F00 order bits are only folded in for the create path:
> 
> net/sched/cls_route.c:route4_set_parms() {
> 	...
> 	if (handle && new) {
> 		nhandle |= handle & 0x7F00;
> 	...
> }
> 
> So for something like
> 
>   tc filter change ... pref 100 handle 0x10101 route from 1 to 1 classid 1:9
> 
> nhandle comes out as 0x10001 while fold->handle is 0x10101.  to_hash() uses
> only id & 0xFF plus the 0x8000 bit, and from_hash(nhandle >> 16) is
> unchanged, so both handles land in the same b->ht[] chain and fold really is
> visible to the scan.  With the old comparison against f->handle the scan
> matched fold and the change was refused; with the comparison against
> nhandle it no longer matches, the change is accepted, and
> 
> 	f->handle = nhandle;
> 
> renumbers the filter from 0x10101 to 0x10001.  After that, del or replace by
> handle 0x10101 no longer addresses the intended filter.  Was that change of
> behaviour intended here?
> 
> There is no memory-safety consequence either way: the -EEXIST return happens
> before refcount_inc(&b->filters_ref) and before the f->handle / f->bkt
> assignments.
> 
> For what it is worth, both halves appear to be addressed later in the same
> series by "net/sched: cls_route: Fix in-place replace" 
FTR: due to the above point, this whole wall of text is pure noise IMHO.
Still there are a few comments referring pre-existing issues that could
deserve some follow-up, please have a look at the full report.

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907192133.2639067-1-victor%40mojatatu.com

/P

