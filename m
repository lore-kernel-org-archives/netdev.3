Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779380;
	b=IN9OUP22s3rfBoINX6pH3qu0cIIQlYsOtD+DC1uKi4N95y8DnzzAfaiT0oe7i0wHIbhM
	 BJ4g9LxLOHJpQZx2sTDMQOMBj5a+QGWJizfaDQLcgCo0Ofxg9mZIWKgI0uyYUmhZCrtpC
	 nunqzepoWyvEWl8jVkWaDyUe3bn7kqG4WsAYk7Icy0nTbvwe4NvnTe9cbnBLPUf7B0n3B
	 T33a13nSWmGR9b/Mdml36Dl1BE5RdTRPIu+i7KFAXIWBIr8Sdn++22tCWeZyFBs43w007
	 S5oZtyUK5cQPJUUa0rU2hGLQUJTI44K5cPThbYCbmBRKrAJrfETghF1sPK4IC8Mc+cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779380;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ME7uyj6AmS/V46Phb/E5MsyW/NJp6tY4yLlk9UpTPcA=;
	b=GLYHFKIPrTNBxvkUWcXy27Gx7SbyjYXk+4oORc/3qWU518RyjQ/wV8zp6HYFVFEzkfBj
	 zkUv2IuagziaSJWVtDqnauZcuC2cGqpxFJFxTGmR9l3VsINAe1sfIv9er+hIV2MfA/V+1
	 duQUPW6qk4Xhtx6ihY5y6SAXTXoNXBwpo2qpHHhq8mjTCcqf6Dg2K5VClF2lEvNXiblEv
	 6uK+TI4j0nkSnTOz8WfBM5BG3bs8hUPD1df/5TZw10ZSFbItPy3tyaSy06wJJDdBm79R/
	 c/Sw0w0Ds+WZ8uKdT1JUqr5Lb4ZD/skfItSgriIL6Ols76B7D7RkLAdSbbtoFjQkmnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W3i3wZlN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JigAlqFs;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0092606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0092606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W3i3wZlN;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JigAlqFs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793779379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ME7uyj6AmS/V46Phb/E5MsyW/NJp6tY4yLlk9UpTPcA=;
	b=W3i3wZlNRVHVo+6MfHRtmaStFvDS8TDpvpXlcne6LpHMfUSO5FexwhqIb+ssv7HiqvnPrx
	sLsfTNyE3PDDbYRhshhqsTbaGWZt8U8Tci4AcQ1qeUOcjhVHRU/1L5DjRYwdZvNxeOeLsD
	u4TFDah279RdI1fHbppO71EhBdnccYo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-2pk6x6oHOSOMfQQATrhSzA-1; Wed, 04 Nov 2026 03:02:58 -0500
X-MC-Unique: 2pk6x6oHOSOMfQQATrhSzA-1
X-Mimecast-MFC-AGG-ID: 2pk6x6oHOSOMfQQATrhSzA_1793779377
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a77c1cbd15so4486515e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793779377; x=1794384177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ME7uyj6AmS/V46Phb/E5MsyW/NJp6tY4yLlk9UpTPcA=;
        b=JigAlqFsxAWKxPzM4bIsTtDMc0JueOVChu6CA1ylj2GkTzIqtQEdubFrfMgC98XGu/
         PuOw9gKqpYUwfDy7011zz03ZvWctCkm7m0onTVdmYwZ9Ngb2a8prgoCja2jqOMB5/W9S
         zdKDQRacx+cDRhE4iv5wjM4r9qNXBiBGzR495M7FB54B33E/m4Cz8sUVh49j9cJ/bvfo
         XIQ09ai8ij1oAFUNbwJYvTl8dP50l0PBEl5T1kTKj6xRM1yyT5I3yctpGtI9y591CJ1J
         p3u7eDG9Af9t8tKPF/8CtrENllPw/eLKXv1rkqOwENAZmxhF5gUoAPlI64ogHBrGNY3d
         1hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779377; x=1794384177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ME7uyj6AmS/V46Phb/E5MsyW/NJp6tY4yLlk9UpTPcA=;
        b=zRDh5pvUZ43wx4wjWzxHKxltmJH4V4bUwZQjbIDy7xbevt634T3nozhiFVqMDP4Eav
         anChjpZv6evgLvyaPtfF/xa9pgq3olwXKi0tbFlno3c9KaL49R7XVDAADupwe753omeW
         Gtl0t99StE2Eb+IT4ksgVzq/MHiDWuwjkCliXRqYqGOAgxyHyZuEd56sO2by3GEDp4Is
         petdux4EWBKnltVL/4bfShcSqzQWrEJjBaPkkT48k4FByRD+ReEP6qFzk/3ifRsI6u2p
         VntMHEYEx3NeIB9VUXkjrI4lvqgEL4O/1t2GmtzuBL8bS/Vs1Kb8Zm5o3dYgA5r7bU6P
         ZoQA==
X-Forwarded-Encrypted: i=1; AKwUvBwaUQckGafid4loUqtGkbaZUNhNKFjSYfdkzoL5m9Wiuh4++2sg6EPPuTDRCE+yaWUdvHEDY/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dsCLu3B+0yKgZyP5aSnymB0Bt2cvquAjIqBRry5Lev646+R5n
	mkYuRZlcx8DSg/T+l2HG/NMdMovh3RkoT1IBoAOQxHAtbMeoHuAd79IzDrEbM54I1i8oEvmChQg
	rKIER+2VzGe7PrH4oMk4CAee13SjdQTx2qLKFCm/H9YSyNs7y3geRmBe9Bw==
X-Gm-Gg: AYBFou3FFJPdNceoG8rXVnwx7S0hV59xlD0o/QxUuTGCzlbUMiiCO37quoCK13zpIwu
	75nP7c0qpAiqLCXWLLDT4Qf+kYPFAz0fr6JwGKBrpAIMEfg+vUBZXMYr8XYF3IFEAOtnFVPA6tm
	jQotTFsVOLErVLBcY5DNinwmQXKEdQrzsQv5w763QXgtu0nywAWxmiPiEcD7YgiAdwuQt3Pqz6W
	Nv8oipudz+ko6b8hhcUBsd824bGPoDKUziNvGH03Nw7epheMYHRVpqRZBd0+Z4C5FNkilzQhA9H
	Em8/4yneJCPxonz9BeCiYIVlLRJjZj1xkJVotzfyWlRpePGT48usx8e0SKxsS/UUmSzO3dLREtV
	rce9xDF+14iru2Ab2ox3MMosRHftNRHxyXnUprYZdm65Kv2gMgcRgKCGCtJFsNnGFFJcLoL5vhR
	QO5sPj6FPGxkp6ANYkJSDl2RDy2csj47LD9IGcSB/eLpU=
X-Received: by 2002:a05:600c:848a:b0:4a3:59c9:a756 with SMTP id 5b1f17b1804b1-4ac17b2ce84mr385878715e9.6.1793779376463;
        Wed, 04 Nov 2026 00:02:56 -0800 (PST)
X-Received: by 2002:a05:600c:848a:b0:4a3:59c9:a756 with SMTP id 5b1f17b1804b1-4ac17b2ce84mr385878055e9.6.1793779375951;
        Wed, 04 Nov 2026 00:02:55 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43a48adddsm36150375e9.2.2026.11.04.00.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:02:55 -0800 (PST)
Message-ID: <ce3e6832-ca9f-4e91-8302-b5bd7cf2f178@redhat.com>
Date: Wed, 4 Nov 2026 09:02:54 +0100
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
Subject: Re: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other than
 fraglist
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, tactii@gmail.com
References: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
 <willemdebruijn.kernel.2de9d4f8c5034@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <willemdebruijn.kernel.2de9d4f8c5034@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 03:51, Willem de Bruijn wrote:
> Alexander Duyck wrote:
>> From: Alexander Duyck <alexanderduyck@fb.com>
>>
>> The netif_needs_gso function lets a GSO skb reach the device unsegmented
>> when it is CHECKSUM_PARTIAL or CHECKSUM_UNNECESSARY. The second case was
>> added for FCoE, whose transmit path marked CRC offload that way at the
>> time. Commit 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC
>> offload") moved FCoE back to CHECKSUM_PARTIAL but left the exemption in
>> place, with nothing left that needed it. Fraglist GSO, added later, is
>> its only user today, as its segments already carry valid checksums.
>>
>> A TCP GSO skb can still arrive as CHECKSUM_UNNECESSARY without being
>> fraglist. Hardware LRO builds its aggregates that way, for example mlx5
>> sets SKB_GSO_TCPV4 or SKB_GSO_TCPV6 and CHECKSUM_UNNECESSARY, without
>> SKB_GSO_DODGY. IP forwarding and bridging turn LRO off, but a tc mirred
>> redirect does not, so such an skb can be sent out another device. It
>> has no csum_start and its TCP checksum field is whatever the aggregate
>> left there. Drivers that only set up TSO for CHECKSUM_PARTIAL, such as
>> fbnic, i40e and ice, then send the whole skb as one oversized frame
>> with a bad checksum.
>>
>> Have the validate_xmit_skb function mark any CHECKSUM_UNNECESSARY GSO
>> skb other than fraglist as CHECKSUM_NONE, which means the same on
>> transmit. The netif_needs_gso function then segments it in software,
> 
> tcp[46]_gso_segment convert to CHECKSUM_PARTIAL and then
> tcp_gso_segment will send it on to hardware if skb_gso_ok with
> NETIF_F_GSO_ROBUST.
> 
>> and the __skb_gso_segment function unshares the header before the
>> protocol code rewrites the L4 checksum field. The callers of the
>> netif_needs_gso function that decide on segmentation for themselves,
>> such as tap, are left as they are.
>>
>> Found by code inspection. In QEMU with an emulated fbnic, TCPv4 and
>> TCPv6 GSO skbs built this way each went out as a single 11 KB frame
>> with a bad TCP checksum. With this change they are segmented into
>> MSS-sized frames with valid checksums.
>>
>> Fixes: 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC offload")
>> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> With the above aside. Not important enough to respin imho.
> 
>> ---
>>   net/core/dev.c |   11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index f32353b0467c..28b4a652d037 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -4207,6 +4207,17 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>>   	if (unlikely(!skb))
>>   		goto out_null;
>>   
>> +	/* Only fraglist GSO, whose segments already carry valid checksums,
>> +	 * can be handed to a device as CHECKSUM_UNNECESSARY. Any other GSO
>> +	 * skb has no csum_start for the device to segment from. NONE means
>> +	 * the same on transmit, and has netif_needs_gso() segment it in
>> +	 * software.
>> +	 */
>> +	if (unlikely(skb->ip_summed == CHECKSUM_UNNECESSARY &&
>> +		     skb_is_gso(skb) &&
>> +		     !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
>> +		skb->ip_summed = CHECKSUM_NONE;
>> +
> 
> It's unfortunate that we need to add yet another branch in the hot path.
> But I also do not see a good alternative.
I understand fraglist GSO has some use-case, but I'm really wondering if
it's really worthy the pain?

I'll personally think we should consider removing it entirely.

/P

