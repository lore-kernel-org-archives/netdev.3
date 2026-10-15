Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9D3ABD90
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052389; cv=none; b=EljtvG6wQhWpK836yqdKInIFzXQ0fxNEaqPB+fwCpX2VAKKkdPrhadhimshdP4KBo/1h8m9qsxbMgtDyJ0Bg/pmttIrjFYn49QQyYwT4QB48rBFC/UBocKX8HUXHdafPfoscRNttjV3e/aGIKzWyMomdrhZp7eMUWxI812/pJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052389; c=relaxed/simple;
	bh=fKCu3EsmIOBjdZC4wMaJ8QoHplYkJtG581Mefg5DaB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ru7JYNGxfmeC6WyrMuNCKcnGeKhGn5gGKpMDKkh1xutqRHCw8uVti+BTOtpMujG4XMYixKKShvlDwHU86xtwaCyT0yVJJeTiSa0e08ZCIg6bjfKbYUvWnZfdFbz/zBsCI1yffkfib4A9aGXVWC+ozoruaVFB6yYjCKzJrH5T3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsTLh69z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sipnewb4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsTLh69z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sipnewb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792052386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eddayEIfsUE7x2Kqd5MK7LCEtyH8/gmKjsVjC4N83e0=;
	b=gsTLh69zu96mnIhr3b5n6PYhACAt5vjzzY1ILAwcFh6RR2n46oIpfyp/rzF729U4OQOgWF
	KFBzbLtmvasxwmPDP9zvXtyM/g+TUH8T3h7rSV/KPl64zcRq7LmCoH73ZOnuQDycZI8CIv
	MyAwL4jnNiiL3xAwq/6pBPgPDymPDgA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-zM23ZUOjNuqmUV7vCdbGrg-1; Thu, 15 Oct 2026 08:19:45 +0000
X-MC-Unique: zM23ZUOjNuqmUV7vCdbGrg-1
X-Mimecast-MFC-AGG-ID: zM23ZUOjNuqmUV7vCdbGrg_1792052384
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df5b058ddso212969f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792052384; x=1792657184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eddayEIfsUE7x2Kqd5MK7LCEtyH8/gmKjsVjC4N83e0=;
        b=Sipnewb4eF21xmt1ZapteyhK9JBEyzvG9x656dZ9m8TG68mXynhj/XmfZK62IUbWwg
         05be2s6PnnMrS3FKDu9Zu7LgAJEgAUcIR2lOdn6a8Vk/Fx2bki3VB8augdJ4gGdhAwxF
         CKRXjCDNB6D2Wu3wRAf1wtC7rT1a7no53Ablvbg6Bm0YVVpJ67q3FZN5okdZEq/OItQl
         A5n9a4D8dQyofV0fWw4xa1KVEd2BevSmPYRy4C+htjVqAkLHtmh+xNFF3tl9UIjElg8D
         tGWgIFqTX+ajoKTucXL5nOCFgH8tTERoAzAVKlP/SbIRlzTITao+K/U2PN/ABWyKvTD+
         BVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052384; x=1792657184;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eddayEIfsUE7x2Kqd5MK7LCEtyH8/gmKjsVjC4N83e0=;
        b=UG3t/ngXbvHQoSZTpxdeKcJy18+vuav7oxPYB+YEHmwCJskEPMi2qUcXANHefgtyLA
         s7qUMJWOy+Wm2LsbFII0hEyaEt8OcHELMC6PDz14I4Ma6gYbcCZNv+WynNuo75gHWJEo
         NhnPVgYIVz2cqCK9HrAJcj1fzSAWG6tLU5KJKVNTE9Ht+8Ff0m1lxrFY7XaOQDrCQoC9
         GMGdyHjglKQ2OGvwhfaAiZJO4IgD2nOvuG538VA9h37mjAIwX6kaThrBhG9iEFa908aN
         8NpS0Ryysd/vubZvASYu9fjWIoGlIzSumn55TFYWBeZG89F8lheVWLnw/CJOerZdIi2V
         gPkg==
X-Forwarded-Encrypted: i=1; AKwUvBxyrjU5PaKEaxkQQi1rMK+Qf/GsJcrADII68l9HZ6W4LHxyAs29jcbAFYbVeIz/KYkmHiF4neY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJE5E16nNWTMsmRggR5QSsAgj+KnyjAqZTV0cTaJYSvx4n3FJcC
	RhndIT6VnKsOp0gbA+Gieh+3zhD2qqhaB0SmK0pxZcMYgcDLNLMKWAOSVJ4WQHElP+TW9vjq0k3
	NsMCPXFrvqm6CFKxOCd2sRmKIu8KhhnjMeXH4BeBaOmWLzyD+vO0HUBePGg==
X-Gm-Gg: AYBFou2l8onLPUaZbhqZjClIWTnGuKIF3qs9beC3FyVMR5U79XK/8xyQC+dFshq3Ge2
	zV+xUvwT2rBgzy9IEZqs7YWDI6Ppjwg37iiNpi7XvBIYwTXFrrqcqV0Gdteclx6mbK1UmhRwkx7
	zwHuWdqnmVDTTvBRV4L6HjjI98BMEcunY7zYZivCkm7tXGqwHVqYGTkw7Qt2YDwZpqt5lXwBVPL
	zct5dij6V2bqx8oZOJeHUxptLhODcKTrZgSHt/oypHvaqC8eLGf5GWDwfWyxc8K94wkbA5fhB7l
	6CGKU3uJRb/4BROAG3zgbmneqxrbZcCPcRWsKt4Qim7xAt8zVRM7KWGCSvfZvQZ/1U+lxot+ZuH
	Y60IaLa4Rc3GhSx4jlmCVyHejmQiB/GJKgAFG7lnr6Idk6KYmlxe0pwV7DP9BnpVzv1LoGnM7uA
	==
X-Received: by 2002:a05:6000:ad1:b0:48c:77ad:d52d with SMTP id ffacd0b85a97d-48dbacf5882mr27137756f8f.43.1792052384276;
        Thu, 15 Oct 2026 01:19:44 -0700 (PDT)
X-Received: by 2002:a05:6000:ad1:b0:48c:77ad:d52d with SMTP id ffacd0b85a97d-48dbacf5882mr27137717f8f.43.1792052383818;
        Thu, 15 Oct 2026 01:19:43 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48ded185de7sm8723936f8f.31.2026.10.15.01.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 01:19:43 -0700 (PDT)
Message-ID: <9df14e56-633a-4771-82b5-03e3feb227a1@redhat.com>
Date: Thu, 15 Oct 2026 10:19:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] veth: clear rx queue hint in veth_xmit
To: Toshiaki Makita <toshiaki.makita1@gmail.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261009040412.14571-1-jiayuan.chen@linux.dev>
 <65a3e29a-24e0-47b3-a189-903b1a33c336@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <65a3e29a-24e0-47b3-a189-903b1a33c336@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/26 10:14, Toshiaki Makita wrote:
> On 2026/10/09 13:04, Jiayuan Chen wrote:
>> With more tx queues on one end of a veth pair than rx queues on the
>> other, and RPS or generic XDP enabled on the receiving end, we get:
>>
>>      veth1 received packet on queue 2, but number of RX queues is 2
>>      WARNING: net/core/dev.c:5212 at get_rps_cpu+0x560/0x1360
>>      Call Trace:
>>       <TASK>
>>       netif_rx_internal+0x1af/0x4c0
>>       __netif_rx+0x99/0x350
>>       veth_xmit+0x713/0xca0
>>       dev_hard_start_xmit+0x166/0x5f0
>>       __dev_queue_xmit+0x1797/0x42d0
>>       ip_finish_output2+0xa34/0x1f40
>>       __ip_finish_output+0x510/0x7e0
>>       ip_finish_output+0x2f/0x320
>>       ip_output+0x17a/0x3f0
>>       ip_send_skb+0x1bc/0x220
>>       ......
>>
>> Easy to hit with "ethtool -L veth0 tx 4", "ethtool -L veth1 rx 2",
>> rps_cpus set on veth1 and a few flows sent over the pair [1].
>>
>> veth_xmit() uses skb->queue_mapping to pick the peer rq, but never
>> clears it before veth_forward_skb(), so the rx side still sees the tx
>> queue index. Everything on the rx side that goes through
>> skb_get_rx_queue(), like get_rps_cpu() and netif_get_rxqueue() for
>> generic XDP, takes it as a recorded rx queue and warns once it is out
>> of range.
>>
>> Clear it before handing the skb to the peer:
>>
>> - It is the tx queue index of this device, it says nothing about the
>>    rx queue of the peer.
>>
>> - The two sides don't even agree on the encoding. The tx side stores
>>    the index as is, the rx side stores index + 1 so that 0 can mean
>>    "not recorded". So tx queue k is read back as rx queue k - 1, and
>>    tx queue 0 as "not recorded".
>>
>> - Commit 710ad98c363a ("veth: Do not record rx queue hint in
>>    veth_xmit") already decided that veth should not pass any queue
>>    hint to the peer. There is no tx->rx queue mapping to preserve, so
>>    nothing is lost by clearing it.
>>
>> On NETDEV_TX_BUSY the skb goes back to the qdisc, which looks up the
>> txq from skb->queue_mapping to decide when to retry, so restore it
>> there, next to the existing __skb_push().
>>
>> [1]: https://lore.kernel.org/netdev/156834bb-8e40-496e-9443-9d515fa18eab@linux.dev/
>>
>> Fixes: 710ad98c363a ("veth: Do not record rx queue hint in veth_xmit")
> 
> I guess the splat can happen before this commit.
> I'm not very sure but probably it has been possible since after 76ff5cc91935
> (with ip link add numtxqueues & numrxqueues, instead of ethtool -L)

I think the above is correct; I'll update the tag accordingly

For the same reason I agree this is net-next material.

/P

