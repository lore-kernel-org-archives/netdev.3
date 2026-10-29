Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310321;
	b=pPdOHIqsBBuEnFo2BvNWhHzYQJ0Iq1YZtdzpowD7ISx0u6S8txgNJ9nSYsy/7qOw1eNe
	 4Ghxhx6eOAWFWfJFbkbCNeK6s0mJFC2A8kJuSwhkcy6F9M4DLCKu+uVr7/QVRaiaZrUoD
	 h/F67/on1XU8LAxW/C+rWZlEdgOldXbyXBpPPtCxclIGfEgkwIcFLcdhh2GEKpnxlQZ5H
	 kM7pJMIEkOoyOQfT2nSHzCJBK71lMaMuKp6g5ysu5nJtMbGKcpcGDfuoXecCwyoZeswbd
	 biMv9imSA5CFPBeDlwbQfQfKjrXnxuqK675kHtiAxD9ayUYM0/ut7OVDEF8yiKmbzZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310321;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=Lm1ipuAr6hzKlNyuHma+Iok/XdDJTqsctWrHYpRz4Mk=;
	b=ZWI6IR82GOdncOp8Mrm56vuIB1ouAU0xKb4XbMpkLgMxZrRS+g/et47wc4V0WEVtUTWY
	 xf4YG+SpX6KB0L7Cv+EWE2Ec6ql+09BXMMaOn//n+bEn+kz8nxIlSS+dm/JqyyNEe1Cyr
	 9pjf4gZkezsYdJyu/xFirfD20hEpafPFuD+Lwivl1lIXAjU1hgrCjdWcEqbjemjE+HVH/
	 jhfN1O3ruSpMdkxmPC9pkMydAN7Ky/gixoVEvQEkf2oAeVG7Mv4G9CVZP2LF+43TCPQam
	 LVyBDECBXDBM/sqT6JHDAvRMRW3MoElL9/ueRtUz44RFyxgdMaDlXGTz8b4T+plwAng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=TBXabVTW;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBAA606A31C;
	Thu, 29 Oct 2026 21:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EBAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=TBXabVTW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1793310319;
	bh=4hyCxRY5aiuixBCePuRZOoujjI8mLWrM1H0xLX/JSQ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=TBXabVTW905VLTexygm/a8lMr8AN6K7tvVhOXJszOE+9uVuH8Rrk/wsnSDfauZoeA
	 qyH/hgiIhFdd+3M1ujlkJ1QdBaeyOOd8j03RAPlqeY4pZUUSNnNZ6XcNft1/hL/Bpp
	 N0pz6fx90E1Bkmj53eOsY/sk3dAwfKvDZ2zMjVAY=
Received: by gentwo.org (Postfix, from userid 1007)
	id E042B406E1; Thu, 29 Oct 2026 14:45:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id DC61240112;
	Thu, 29 Oct 2026 14:45:19 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:45:19 -0700 (PDT)
From: Shubhang <sh@gentwo.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>, 
    Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Simon Horman <horms@kernel.org>, 
    =?ISO-8859-15?Q?Jonas_K=F6ppeler?= <j.koeppeler@tu-berlin.de>, 
    Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
    "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
    =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>, 
    cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: sch_cake: skip redundant cake_mq rate
 updates
In-Reply-To: <bb202893-9fd5-4dad-ad69-9f86dfd91cc3@redhat.com>
Message-ID: <bc677053-f438-fda5-defc-a53532262779@gentwo.org>
References: <20261026-net_sched_sch_cake-v2-1-cb1d4e6ed990@gentwo.org> <bb202893-9fd5-4dad-ad69-9f86dfd91cc3@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Paolo,

On Thu, 29 Oct 2026, Paolo Abeni wrote:

> On 10/27/26 05:32, Shubhang Kaushik (Ampere) wrote:
>> cake_mq periodically counts active child qdiscs in cake_dequeue() and
>> derives an effective per-child shaper rate. cake_dequeue() currently
>> reconfigures every tin after each scan, even when that effective rate
>> is unchanged.
>> 
>> The dequeue-time call chain is:
>>
>>    cake_dequeue()
>>      -> cake_configure_rates(..., true)
>>        -> cake_config_*()
>>          -> cake_set_rate()
>> 
>> With rate_adjust=true, cake_set_rate() only refreshes rate-derived
>> state. Tin 0 records the unscaled rate argument in every supported
>> CAKE tin mode, so its installed rate identifies whether this call chain
>> would change any state.
>> 
>> Skip the reconfiguration when the effective rate is already installed,
>> while continuing to update the activity-sampling timestamp and
>> active-queue statistic.
>> 
>> Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across 
>> sub-instances of cake_mq")
>> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> IMHO this is borderline material for 'net'. Was any regression visible on
> top of 1bddd758bac2, e.g. in term of CPU usage?
>
> /P
>

Thanks for the feedback.

I repeated the test with whole-host CPU accounting on this 80-core system 
and could not measure a reliable aggregate CPU-use difference; throughput 
was unchanged. The benefit is visible in focused cake_configure_rates() 
trace, but I agree this is more appropriate for net-next.

Regards,
Shubhang Kaushik
