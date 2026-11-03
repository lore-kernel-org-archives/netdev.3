Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697381;
	b=kG5Zw85zrlTnOZ2iqkMHECWqO1YijUQWgNMV2lXDIbLFPYDz2rb368iMlpymkQbnwtJg
	 cXEmXQpMpNkPaysXsPGtTPdqUxe/B3vWG/8L97EUd04yCHDjw/2BMMGaTOSGw3mwPSulX
	 dGux/yU7VOuzf/23dLqeqyVyHx4JXhptQ84OuwOW2CGDghWUclgMaIdc95VUU49FWx7I8
	 n7K1jp3E0gJKvzyKYGvwnvXeQBPKmmepsEM/jABpL6r/p5gaSVnG9OYqyZdLBNmgdNm4V
	 JGgQylg9yLt0M/hYfqH8/zKehRUnCgK+eTvU5vrUbzmBUmkCxJ52AsHS5/bannf/bpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697381;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8KH/UMSE6WEWuRloEtHlnOd9aZBURFFHz40IrIUPGbA=;
	b=l+qS+EQNLe8mQPLAiFlp+IkuMQrZdEwur0uA05Wm7XZFZ2HuON8ET9SVwOWwH4YXUOqS
	 aAzcbiS/Wupm9iRf8IK6GUO6zgqbzYnOi519bhEUJfAjzrhX2zlN0/wDEHQiV53H5cEuN
	 EO/i9ocGFt7rDrdBHWXGCyicomZnobHVdDbKoYDJAfHexTWO+HR6PuJ1dTqJs8UQ0Y/WR
	 7MYeh6aEtmLoPVBCFYOpbdZRi9vz+y3W+/Ge+bAx/Srx8Ru/j+QrszzbIE2O7aylkcoOu
	 McDcuB1g9t9JtXnfpDXVKjGF6HDOWO8EIYMPEiVQjWcPso0td4Zg4fTyS8mWHgThmMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=apiHITAi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JfguixSq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83577606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83577606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=apiHITAi;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JfguixSq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793697379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KH/UMSE6WEWuRloEtHlnOd9aZBURFFHz40IrIUPGbA=;
	b=apiHITAi/PIX8iDFwbvOx0CLoES7gUIgKZmGjhOBp1Z0HOEs6Fjr8Q3gauWooiSg+5iPIn
	kDizAOeOAiDslwdUh05f9+eDOY2Khqo5mWuuyaoE6X9wY6y0R6djQTkaTe+jGfgy9cmgnm
	s6znA3mG9nFnSG4edFiWvwUOHu7Gcxo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-FHdRVVhIP4qNK5N4jgTcGQ-1; Tue, 03 Nov 2026 04:16:18 -0500
X-MC-Unique: FHdRVVhIP4qNK5N4jgTcGQ-1
X-Mimecast-MFC-AGG-ID: FHdRVVhIP4qNK5N4jgTcGQ_1793697377
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so38337985e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 01:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793697377; x=1794302177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KH/UMSE6WEWuRloEtHlnOd9aZBURFFHz40IrIUPGbA=;
        b=JfguixSqRu0b/OQ0ojH2zl9rAe6iH6XeTCU3kDv5cd8ABPkKOmt7ItpOslzQaCoPpQ
         KctTQCRBs/r/wt2hlbQHvnsaseuXfWuXx8XXoDO383GRV5qaAX1yAif8CwSyfuFJx9gZ
         OvPEzOzbJNcj0U+vHi5bCCJYT2AzvGmMZoJbX2cycZoc1MTAcJh4oC63vNqed2OQVAnx
         JHpM2QiLpkRk93SThUoegCm7BmiiMg1QJfqm+V2OOzufIshtYi7fQyxeR4H86Mu3bSJB
         UCnOFVtyCD3dUB0aBiBBlVtK3l5hDodfhGjVO1zGUlLK6KomOeGEUDAbuc4K0ypPt5ZD
         aUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697377; x=1794302177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8KH/UMSE6WEWuRloEtHlnOd9aZBURFFHz40IrIUPGbA=;
        b=21xSCESYAjEYATW3+PmDKjSqVNrEdqH8ZS8pLMcCMh+QRhzcXRbczUYLOemi85OCWG
         UYJB4QA1Ygd6ESVKc366mPvFYyF3x07KnAkHga6o+ZH23dwktPyJZH3grM2k12o43RDo
         Uyb3oe6QYBualnNkaYfVjd5Wu8dWXrV6Ay8w+YpD+uGCDQwZClJOcoLuQh9XtBzoVgqr
         30+yHEDAuOUBHXnKLWXE6USlAxP5B4R9TndHNExXnVgUCUFTYlLr40JtbdpYkNyiZFpf
         +pTkBKCQAprU56tKH8MDJiwtToxeR0hrx2IjerjhmQuwMPcAR4buGhKv3RFmxfXYJPhi
         xmaw==
X-Gm-Message-State: APuU4Z9V7jsMIs0WgcXXjrwUpHWm7HlzosKbNdTA1tl2F4Ovg/thmm5N
	gwn/12J8tIowUQCC5VOlDIXBoTBTg9uWYaLU5y15QGPnO9mmwnwnmuEowmuuGDG2pBu+Jy1NujN
	o/BGwQou1/oMj9Ppyq89yGR6mPqL9fDECEX7Zw8LbvPbjHirTpmixySJVog==
X-Gm-Gg: AYBFou0jaCIslFFJP6Mg91qqDMJ9WLafvGZE4jx+E918R0+3Y3oBlort/VSENL4xN7P
	1BVtZAh47lfhfVhX3OmD2JiWM8uGPxXjAeKil3AnQH0y03/rKwp9WOunwwHqcUThvy2J+HFVq8C
	RtbTnpxR52yqWsZCGgwh0Y6jrj7q8no1UBA9KCNRwACaq5OULuGdF/hUQOAFZFsDVnmUvc5mVgL
	NmhDjOsJaKlh0VnYKdS6QZlDL39B7hPUGUU9od9l+xvwzEjr3duRbZ9kXXdovdgkNIIEjD88mhX
	U9LXy/Kv4bM0zCnQ6A1qWu5FEjVb6aa8BpYuT5H/DPi1Aiif7RI7SATKL5UZLgQ055bEyg1wEsT
	myKMyRUyDe8FIv2rTRz5g6xw0w3QQgjia2hzdhe1+k4SaB4eyar/yw85x59c10x4zox6g5zE79W
	368NoYxuUGx/ox405sORRWzApLjKYn0m+zgSOeyDDSnr0=
X-Received: by 2002:a05:600c:3f14:b0:4a3:59ee:86b with SMTP id 5b1f17b1804b1-4ac14ec873emr276978655e9.4.1793697377168;
        Tue, 03 Nov 2026 01:16:17 -0800 (PST)
X-Received: by 2002:a05:600c:3f14:b0:4a3:59ee:86b with SMTP id 5b1f17b1804b1-4ac14ec873emr276978255e9.4.1793697376758;
        Tue, 03 Nov 2026 01:16:16 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7246fsm24262166f8f.19.2026.11.03.01.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 01:16:15 -0800 (PST)
Message-ID: <3edcc63f-aed7-47fe-bee3-703c6becbbff@redhat.com>
Date: Tue, 3 Nov 2026 10:16:14 +0100
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
Subject: Re: [PATCH net v3 2/2] net: dsa: b53: Enable legacy IGMP snooping
 controls
To: netdev-bot+sashiko@kernel.org, florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
References: <20261028235100.3892374-3-florian.fainelli@broadcom.com>
 <179357816089.3131.2008365378649919842@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179357816089.3131.2008365378649919842@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/26 01:09, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The commit message says: 'These legacy classifiers have fixed
>    forwarding behavior, including query flooding which excludes the IMP…
> 
> --
> 
> net: dsa: b53: Enable legacy IGMP snooping controls
> 
> This enables the IP-layer IGMP classifier (bit 3 of the global management
> configuration register) on BCM5325E, BCM5365, BCM5389, BCM5397/5398 and
> BCM63xx, which were previously skipped in b53_enable_mcast_snooping(). On
> BCM6318 and BCM63268 it also clears the IGMP redirection enable to select
> snooping mode. BCM5325M and unidentified BCM5325 variants remain excluded.
> 
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index e54f6d4d1f7bb..957a1501d3f49 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -841,12 +841,29 @@ int b53_enable_mcast_snooping(struct b53_device *dev)
>>   	u16 val16;
>>   	u32 val;
>>   	int ret;
>> +	u8 val8;
>>   
>> -	/* Older switches use different IGMP controls, not HL_PRTC_CTRL. */
>> -	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID ||
>> -	    is5397_98(dev) || is63xx(dev))
>> +	/* BCM5325M snooping uses the mirroring engine instead. */
>> +	if (is5325(dev) && !is5325e(dev))
>>   		return 0;
>>   
>> +	/* Older switches classify IGMP in the global management register.
>> +	 * They do not provide the separate MLD controls of newer switches.
>> +	 */
>> +	if (is5325e(dev) || is5365(dev) ||
>> +	    dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev) || is63xx(dev)) {
>> +		ret = b53_read8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, &val8);
>> +		if (ret)
>> +			return ret;
>> +
>> +		val8 |= GC_IGMP_IP_EN;
>> +		/* Disable the separate IGMP redirection mode on BCM6318/63268. */
>> +		if (is6318_268(dev))
>> +			val8 &= ~GC_IGMP_RED_EN_6318_268;
>> +
>> +		return b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, val8);
>> +	}
> 
> [Severity: High]
> The commit message says:
> 
>    These legacy classifiers have fixed forwarding behavior, including
>    query flooding which excludes the IMP on BCM5397/5398 and BCM63xx.
> 
> The message describes this as fixed hardware behavior. Isn't it actually
> something this patch turns on?
> 
> Before this change, b53_enable_mcast_snooping() returned early on
> BCM5397/5398 and BCM63xx, so GC_IGMP_IP_EN stayed clear. IGMP general
> queries to 01:00:5e:00:00:01 were then forwarded as ordinary multicast.
> The IMP has PORT_CTRL_RX_MCST_EN set, and the bridge never installs MDB
> entries for 224.0.0.x, so those queries reached the CPU.
> 
> This path now runs unconditionally at setup:
> 
>    b53_setup()
>      b53_enable_mcast_snooping()
>        val8 |= GC_IGMP_IP_EN;
>        b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, val8);
> 
> On BCM6318/63268, snooping mode is also selected explicitly. With that in
> place, would queries from an external querier on any switch port stop
> reaching the CPU on these chips?
> 
> If so, these cases look affected:
> 
>    - the bridge can no longer learn multicast router ports or detect other
>      queriers from the queries it receives
> 
>    - the host IGMP stack on br0, or on standalone user ports (for example
>      an igmpproxy upstream on a WAN port), never answers general queries,
>      so the upstream router would expire the host's memberships after the
>      group membership interval
> 
>    - on standalone ports, where the port VLAN mask only allows the IMP, a
>      query flooded excluding the IMP would reach no port at all
@Florian: could you please comment here? I'm unsure how much legit the above
comment is.

Also this series is IMHO borderline for 'net' as it ends up enabling a feature
that never worked. Would you consider it for net-next without fixes tags?

In any case, if the AI comments is a false positive, no need to repost.

/P

