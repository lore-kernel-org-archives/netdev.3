Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEE3081AA
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196770; cv=none; b=lCGnPEPodGxgVH333dSHilalye7+16LUUoed/TP16m+DCGDlSaHT8AU/IHGKMU21tuPAWR6gaqufcukIDvjsAWlu3e0aKhx4gBY7VwW60mg4fmxZMyvYMnfseokuQFK0Vk/IxNDlR8rn23NDY1YzbESJ32teKDu+B6MZkMUGSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196770; c=relaxed/simple;
	bh=y3vmWYbk4h1HRXA77t6bzYrXPvLU83Habs4moXfW8Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfHDJniawFAOKMcpj5o6gu2WA9qrRyFpe5kM6o5Vr2Iap3oS93fTFmsEi3Kkb/NC/4XFrOKqhwgMY9XUbBXGtafL8XWF3GNd2Ak0lYCro/FSERzhxQjila889yBosrNFds4Mkexg94WjCPyFr9aiAkx+X/tvOH7l4kpzRERRwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhevSd2R; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhevSd2R"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so270634f8f.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758196767; x=1758801567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gycJ5qJODrZCG3kCBPYdXIeEesJU0USHkMWdWLPGimw=;
        b=GhevSd2RlNcLqdaV/67YU8fWXwjyhNoAPJEBgN1Vjrj9utz8arMUwd2+NCY8Mj0Hb2
         QfjGgZ10ZLYGTgNM6PsoZ2upJusgY8kexsFexWhj0uX7eEWNrHAs9+m+gphCdKRGpmje
         4t90dYAimOOQcfiqPPok2Gg30Ag4/YxKdC2Mlk4cAuX1BzD0BbcL24APWMmle5HT9DWY
         TQ9wLZEHyytqomrC4M50+CnkjSRIAnRwVjWeMqwdfUf6R3fRjUlx8vWVkv1otVWngPRZ
         NdWj3J2O8cWt1nQwNATHvdEpp2Epp2c4ukqezja3uVQQ+x4YjM70JRYGW/PcSxN7y/v2
         ZHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758196767; x=1758801567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gycJ5qJODrZCG3kCBPYdXIeEesJU0USHkMWdWLPGimw=;
        b=mThFttjab+KxYFGgBsKcQJrD1c0IEFcCUgVCwkApdSieAJ24JOSt6XwFXvCuM+91zm
         qA5hIu28+Z7aC0s/srDqG8rBLOptFUkHmdVszsP38wSnWnkNm1SCpjuqIw3qeIVzoilT
         zRzmjGSd/PLu89/6EWmafsnVz4eG1JrNag7KIQvSQt7gkWcw/B9AD+kIieIW5t4aIEyY
         2ihAVqoBAvDa/0/m3OnbeW6elYHxN2sE8JjKz1k41mFghfGaWWHDAaQDhsCk3oI5Zr33
         wJl9Id6unJOBBDumyHitxEJqcOApb2XR16FyfDV8NhaKJhyKsAGVMpAbO4WxawWsuI7Z
         Cy+A==
X-Forwarded-Encrypted: i=1; AJvYcCVEzI4WDrbDCKRCexa/Yf4Fod1zeoLJkQjrSJfmlpZjKq1CPVXV7IhqnSAb74En+14WxlTUVqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4dMZawCUJa8j8gl32M09It649LzSxjQLp6hoXIuovaL7U+INL
	3ShMVFrAfI/hOCalt7PveNhOtRZcYAAVcarlHkmyGMjfWbzRzvs6PSmy
X-Gm-Gg: ASbGncs/LV8Nmf9o8fa1yYCYNxpup8P9+nPyUbpebkU4T6qATqpWwA8HBOdwGIZ1zQy
	8Ud0dbPImglmCzE8ZT1vHjxEtvGSFpkkW4OofqKJpXGM1JGGqW2NKcrKQhL1RgxKHDQtuATuDjg
	tbadf6tUxc+Jn6Ze+cyMszKOt5CrsOQ2LR57WsM11EJERuEEUzdIL0raTTkBTk+dle3bEFlVyQ9
	jLpqDUu1I9h8i3eJlgf3YUL35FXxyEGmO9wvU0TOymE16am2BdNfeU32BNNdt8F6erh0Jx73GTA
	685S/RTvVucksGEVr0a/cS8A5MmeSIDdqci0ghzF3hpBIPwWSjeFa1F6xPtdBFqfIr8GbA3pSti
	DH3xiFytr+ShvNbBqMXw3gKWOZmZoa9S7U5rS5JkZXw==
X-Google-Smtp-Source: AGHT+IGLNHd9R7zF/iIO0UvPAgOzmoOY1GMD6wCpazanI1epXcO210yKCzUtUd5jIOcnxlYhLvUq0w==
X-Received: by 2002:a05:6000:310b:b0:3ec:db13:89e with SMTP id ffacd0b85a97d-3ecdf9f4510mr4458980f8f.7.1758196766589;
        Thu, 18 Sep 2025 04:59:26 -0700 (PDT)
Received: from localhost ([45.10.155.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d73sm3373653f8f.8.2025.09.18.04.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 04:59:26 -0700 (PDT)
Message-ID: <bc57fe7d-2865-47d5-8add-cb57787d9000@gmail.com>
Date: Thu, 18 Sep 2025 13:59:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 4/5] net: gro: remove unnecessary df checks
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, pabeni@redhat.com, ecree.xilinx@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-5-richardbgobert@gmail.com>
 <willemdebruijn.kernel.d5fd7a312fe9@gmail.com>
 <4b2c5770-ab53-43f6-8c68-7e2f4a912d8e@gmail.com>
 <willemdebruijn.kernel.1fa5cf297a68d@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1fa5cf297a68d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Willem de Bruijn wrote:
>>> Richard Gobert wrote:
>>>> Currently, packets with fixed IDs will be merged only if their
>>>> don't-fragment bit is set. This restriction is unnecessary since packets
>>>> without the don't-fragment bit will be forwarded as-is even if they were
>>>> merged together.
>>>
>>> Please expand why this is true.
>>>
>>> Because either NETIF_F_TSO_MANGLEID is set or segmentation
>>> falls back onto software GSO which handles the two FIXEDID
>>> variants correctly now, I guess?
>>>
>>
>> This is true because the merged packets will be segmented back to
>> their original forms before being forwarded. As you already said, the IDs
>> will either stay identical or potentially become incrementing if MANGLEID
>> is set, either of which is fine.
>>
>>>> If packets are merged together and then fragmented, they will first be
>>>> re-split into segments before being further fragmented, so the behavior
>>>> is identical whether or not the packets were first merged together.
>>>
>>> I don't follow this scenario. Fragmentation of a GSO packet after GRO
>>> and before GSO?
>>>
>>
>> Yes. One could worry that merging packets with the same ID but without DF
>> would cause issues if they are then fragmented by the host. What I'm saying
>> is that if such packets are merged and then fragmented, they will first be
>> segmented back to their original forms by GSO before being further fragmented
>> (see ip_finish_output_gso). The fragmentation occurs as if the packets were
>> never merged to begin with.
> 
> This explicit pointer that fragmentation for such GSO packets happens
> in ip_finish_output_gso, which first calls skb_gso_segment, is
> informative. It again turns an assertion into an explanation.
> 
> I think you jumped the gun a bit on sending a v6 right with these
> answers. I'd like these clarifications recorded.
> 

Sorry about that. I'll explicitly mention ip_finish_output_gso in the commit
message.

>> IOW, fragmentation occurs the same way regardless
>> of whether the packets were merged (GRO + GSO is transparent). I thought I'd
>> mention this to clarify why this patch doesn't cause any issues.
>>
>>>> Clean up the code by removing the unnecessary don't-fragment checks.
>>>>
>>>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>>>> ---
>>>>  include/net/gro.h                 | 5 ++---
>>>>  net/ipv4/af_inet.c                | 3 ---
>>>>  tools/testing/selftests/net/gro.c | 9 ++++-----
>>>>  3 files changed, 6 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/include/net/gro.h b/include/net/gro.h
>>>> index 6aa563eec3d0..f14b7e88dbef 100644
>>>> --- a/include/net/gro.h
>>>> +++ b/include/net/gro.h
>>>> @@ -448,17 +448,16 @@ static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *ip
>>>>  	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
>>>>  	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
>>>>  	const u16 count = NAPI_GRO_CB(p)->count;
>>>> -	const u32 df = id & IP_DF;
>>>>  
>>>>  	/* All fields must match except length and checksum. */
>>>> -	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
>>>> +	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | ((id ^ id2) & IP_DF))
>>>>  		return true;
>>>>  
>>>>  	/* When we receive our second frame we can make a decision on if we
>>>>  	 * continue this flow as an atomic flow with a fixed ID or if we use
>>>>  	 * an incrementing ID.
>>>>  	 */
>>>> -	if (count == 1 && df && !ipid_offset)
>>>> +	if (count == 1 && !ipid_offset)
>>>>  		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
>>>>  
>>>>  	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
>>>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>>>> index fc7a6955fa0a..c0542d9187e2 100644
>>>> --- a/net/ipv4/af_inet.c
>>>> +++ b/net/ipv4/af_inet.c
>>>> @@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>>>>  
>>>>  	segs = ERR_PTR(-EPROTONOSUPPORT);
>>>>  
>>>> -	/* fixed ID is invalid if DF bit is not set */
>>>>  	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
>>>> -	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
>>>> -		goto out;
>>>>  
>>>>  	if (!skb->encapsulation || encap)
>>>>  		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
>>>> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
>>>> index d5824eadea10..3d4a82a2607c 100644
>>>> --- a/tools/testing/selftests/net/gro.c
>>>> +++ b/tools/testing/selftests/net/gro.c
>>>> @@ -670,7 +670,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
>>>>  		iph2->id = htons(9);
>>>>  		break;
>>>>  
>>>> -	case 3: /* DF=0, Fixed - should not coalesce */
>>>> +	case 3: /* DF=0, Fixed - should coalesce */
>>>>  		iph1->frag_off &= ~htons(IP_DF);
>>>>  		iph1->id = htons(8);
>>>>  
>>>> @@ -1188,10 +1188,9 @@ static void gro_receiver(void)
>>>>  			correct_payload[0] = PAYLOAD_LEN * 2;
>>>>  			check_recv_pkts(rxfd, correct_payload, 1);
>>>>  
>>>> -			printf("DF=0, Fixed - should not coalesce: ");
>>>> -			correct_payload[0] = PAYLOAD_LEN;
>>>> -			correct_payload[1] = PAYLOAD_LEN;
>>>> -			check_recv_pkts(rxfd, correct_payload, 2);
>>>> +			printf("DF=0, Fixed - should coalesce: ");
>>>> +			correct_payload[0] = PAYLOAD_LEN * 2;
>>>> +			check_recv_pkts(rxfd, correct_payload, 1);
>>>>  
>>>>  			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
>>>>  			correct_payload[0] = PAYLOAD_LEN * 2;
>>>> -- 
>>>> 2.36.1
>>>>
>>>
>>>
>>
> 
> 

