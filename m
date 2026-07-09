Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED9E4315F
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585015; cv=none; b=uydL5YVscYB2HjPfIQUxlKSHRlrEJ8JUeRy4YyTyO6OjSB/Sk/bO6vwHWoMMaluy2BofQgOdgnIXAKqjDGF6EtwebE1bB9MgoIMC/UFbDPe0VdPKk8/Lr5n36n+OXLXhlbADD3QBtVlBwDgpRTmBFleNH2zgSnp+/OQzCakeGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585015; c=relaxed/simple;
	bh=GkCi0jq+alFib4ABH23vFxjXYANz7keEhGkqx46O1lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCUp4MvU1nlGdn4IrZVSxdMbQkVyYHLlVkoGojxdEFJHujxuuCno3+H56MQul9HT70vV1yCPW+KyvHBWWn4etG7ROM7GmJDzHNwaKNHZ6XbzYxyKbBPV3IHj02GSU1fSjF22M4eeQ5frE4iWe5xbJs6XJX0nfTiSMWgN9q/VHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD6OquC6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPuDbNTu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD6OquC6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPuDbNTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783585013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmSpAf4O3dtPU7pc72sg50trHi96xvgnv1EKezlLwQI=;
	b=PD6OquC6bWQ165oMFM9bAZmfWOt/JN5lONx57PlUwrn28iLiOtnH/KTLlkwx4XKfezjraV
	QQw8tnm0VMNcfz3chcQePjeA8eiTiGhAJJLw8yEpGCUPUlHAmUvobj/IRSHYWjXTl642fM
	+PoUAgq8RvgKYJ+qlY+iVAEf5WopbMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-hIJYtNzHMNapAZw3xeL-DQ-1; Thu, 09 Jul 2026 04:16:52 -0400
X-MC-Unique: hIJYtNzHMNapAZw3xeL-DQ-1
X-Mimecast-MFC-AGG-ID: hIJYtNzHMNapAZw3xeL-DQ_1783585011
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493ce08a6b4so6197555e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783585011; x=1784189811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XmSpAf4O3dtPU7pc72sg50trHi96xvgnv1EKezlLwQI=;
        b=PPuDbNTusdhDAILzLDHNy6q6mTgM+6/n6tIpXfEeDmrFBe/PtrXXebQUBOItiFWEOg
         WYQiqODdAqVdlErspYkw5vQj9P/tRc9jebIJsCdJCZPvoCBKbPrVUvkxPJC7cGChNjvO
         TSFL82If6Lt9cPjKHXXZBbc23BDunJZlq8wnnwMz2E5A/owQOxoPOfTjcjOEIOzToBJk
         GMN8Pat6W37zV9C7o5lBXQoKJJlI+IlGuzPQilHOr1DYdkOarH2hTUcelhpArostHqgz
         lwHPV7rxnXJlfxv8btKQIP1Fty+dHE0cDy4CcWz3XOFPcEiTgIQqCWYHR13GMXEzQTEA
         qBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783585011; x=1784189811;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XmSpAf4O3dtPU7pc72sg50trHi96xvgnv1EKezlLwQI=;
        b=buMRtQGfePY9DOHju8kRZDAA6lMF6nac8HIgpbSnp5YV/JqupI0xDcV8WAUxnfZXk9
         I12nKoikYnrI+Gq7qPplqEEbjDtkMq71DLWrZ05Ok6yulikrnV/5GSeNXcR1XMn9vyrT
         KpUn6SykqZMCK2MTWedK5F2LO/wzDdcJXUca1LHHJjwl1Akzjc1iEMPtC+XdDfejOc2T
         YNEgmHRqVeelyBcm3BPAhfQWsjp184/7+JImkPwwld0MeX3BYY34CKYpHaZTBhjf8V24
         9juyt16vQLzsO7/7vLzb1gJMcAlMElsMcLSzFj2DCTUc2lM9v6PcvdhA04ggtDnSRtNP
         s9xw==
X-Gm-Message-State: AOJu0YwU+g3JteRMg5zJyZax6m6cdAG9GZv6JMXoKMNL5IRPnT/5o5zk
	v57QmsV68u8Zi6EZCWglAxhMilyzzCsxG0Fo8pqiEZNHInsdRSGwocWLUW6QLmrbAWTjJr7yrNx
	QAZ7hX/9GyMUkBwS3OBnbHax5K6FOgt9VbqBiQEpa5dR7lJEgmSCuyeH2kg==
X-Gm-Gg: AfdE7clPg5U6c2LozR/TkTTtnK9oT0VUQIqqO8wVIxmTkKb8S2pERJcKgOVSW7H5Ahg
	92PaakNrZThBEHeCd3Ma9+ZrSx4ZiM4PBK44n886SDPykOOPAKNGzG59aXcZRfcy9900zAJoI/e
	TTx8CbBgweni+DFvS8UAxo48UjTd14nLaB99arzWiwT42uV8q1FenCIWHfxEck6azf4Ec7sVlF9
	Z7TDBSS6SJLsQxtS8h0N5RHcgs8kijqg7L45x5LxpktK/CALDc/L7iigwD4V1jZqozj/81m4ETW
	UsmhB2hltR5EtobyNC6JwLsRQU5yI4hy/Hksn9v09Xo7oaBvlyZvEjigmJp3RfMICwiMcMhWVSm
	o1f89ic+M7bHLAte6MfqDRWdKQbVrHF1MndSvNmZRnbQGGZjMMmiqot3gZdrEhhZafaHOc54gYH
	LQAJsJvhMFV8bo
X-Received: by 2002:a05:600c:8184:b0:493:e79e:da9e with SMTP id 5b1f17b1804b1-493e79ede9dmr49876105e9.29.1783585010779;
        Thu, 09 Jul 2026 01:16:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:493:e79e:da9e with SMTP id 5b1f17b1804b1-493e79ede9dmr49875865e9.29.1783585010365;
        Thu, 09 Jul 2026 01:16:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb70a677sm39467095e9.8.2026.07.09.01.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:16:49 -0700 (PDT)
Message-ID: <695fc2fb-606e-4d5a-a4d6-41ba5d1cfadb@redhat.com>
Date: Thu, 9 Jul 2026 10:16:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock
To: Yun Zhou <yun.zhou@windriver.com>, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260709065631.3488067-1-yun.zhou@windriver.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260709065631.3488067-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 8:56 AM, Yun Zhou wrote:
> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
> nested acquisition of _xmit_lock on the underlay device while already
> holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
> the same lockdep class, creating an ABBA deadlock:
> 
>   sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>   ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
> 
> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
> atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
> the sibling device with identical xmit structure, already sets lltx.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
> Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
So this is actually a v2 of:

20260630183702.170798-2-hemendranaik@gmail.com/20260630183702.170798-2-hemendranaik@gmail.com/

right?

please have a look at:

https://elixir.bootlin.com/linux/v7.1/source/Documentation/process/maintainer-netdev.rst#L434

any kind of re-submission matters, no matter how trivial is the reason.

/P

