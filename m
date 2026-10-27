Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094508;
	b=byqodsGkTD274yyYwooQANnSMVmLqPGR7DCxzKfpHP0iuOBmA/EmRqZQxCrYHomXozQv
	 cC6GbBI8UmVrPxiPCNF2sl4M7IFZG0NLMs2Be6GKqF7XKoXAs8KNJRyc/e0T160pUSD4+
	 N0O61diMIow0+2dLIoRqiF3COK9EG14F5IeF9M2AP8b0jHKDPEXxu3hGpQZlviT8E9WgI
	 ffvWLQ84X7zmVkek8xtriji8thJTjj5HiiDcd+ElQUBwMUSHg7jtSFBk8sR9ebljCTav5
	 rulHc87yEjHEpA0jIf1AKmQIwYCeK2uMSBKfDeX4pwmTz783mGldDlpPR3N9iSlWk6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094508;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hN6IaSi79CtO/UskRz9mQUpYRTUKNgf8UtA61dpwAMY=;
	b=Qs0pqBshy7WwoGKZxKx8J5L+KSEdnoWVsM35CE6GA6wd5oajAmOFIJZ0kVXh0wmBedQ7
	 a5cBCbgLxQD8xQgM3xDCrPOwA3u2SlsKbBOj3x9TypskOdHrmVTAevnXo1SSmRnll71MA
	 zO7NhsnYsCPko5K74kw5kUolKpph5PtKejUVqg1JSPmT8QoX2vs6KRLlMVBSBEroGOXUo
	 KyjH1RBJNTTEMupuX7ndha2UxkJC6Ypg0bnJrE+3LmzCWcx72Xg1dwX0FNC3oY+NhRtp/
	 dgifz8cKLvv0m4pKealr9fgPe0i9JCYHMPBmQ4PdxGh5L6FuZ14mTSdSUK0BE2j8YVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LIXyyDmq;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oekXwW2w;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743C606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6743C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LIXyyDmq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oekXwW2w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793094507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hN6IaSi79CtO/UskRz9mQUpYRTUKNgf8UtA61dpwAMY=;
	b=LIXyyDmqT8MEvNMSIdKWinJIB5j6Sd6XyR04mQcgB9UKb2SJf/1BSLnxr9Z9unLPMKQz5v
	Hxqdy5upsLoGpLOg5qkzJjo90d2kRBMKBgsSFtRRAE0moIG48vdc89zeiyxQUyjDdhTapD
	sw6qbo7I+ihnF3LiuMaMSGbaAbq23Zg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-tocI7aZRM0Swrxy0zf5g2Q-1; Tue, 27 Oct 2026 05:48:26 -0400
X-MC-Unique: tocI7aZRM0Swrxy0zf5g2Q-1
X-Mimecast-MFC-AGG-ID: tocI7aZRM0Swrxy0zf5g2Q_1793094505
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2001e85c8so28832925e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793094505; x=1793699305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hN6IaSi79CtO/UskRz9mQUpYRTUKNgf8UtA61dpwAMY=;
        b=oekXwW2weRvQxMQZ2i9Pl0RRbkA0dHO3QQRUs1+GBIH4Kw+pIEjjxpGy7ZXSskrxNA
         tYHudpVsTSUCI8TTy7NmCytEgAzGa1hb6Ft0xX1VLPTqKvbw6LJ7DPiPBcp3FsmimtA+
         J4pC4LirLDl8VjSKrUHY9sFoGvjM30FdzftpjAnl2MpOf0uNaUKb61g0LRprgszM7yF7
         SLFhvOrlIezsnSk8u+lnR2F0R474AUxrxEUyLy8uBDYtOeq7WCyE09U2ZzweF2rtIJ4O
         G/5hQ7vU5gEX09mNpERpC/8BO9xTfcp1PaZ19m3cR4ebqNdsVOpLsrsm8zLrQPCJkhIm
         jG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094505; x=1793699305;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hN6IaSi79CtO/UskRz9mQUpYRTUKNgf8UtA61dpwAMY=;
        b=c01swsqt0E3jbsG6HrNmajjule7/QBeLRKgDFJjuo5KET1590CgtVoX5bnW4uGusTO
         GPeoMOjMedByRSHZlxdQWxX3900lN5FSeZD9kWauB/n6ZehhEGi5DRPnIDhBhKcmsBwR
         ZsyG6K2pAlpQ34xPioXNqQXqeyhTiyKzCzCymWAoHdw+Hu/5zh3w24MSkgqROYPXMPGh
         0vWrbhy6ns/jZEa9W0ZAfKuzjPLCw8lyBfpcXtkmgupjZ6M5Z1j6iTZ+M1kPorXuJkre
         MFUFCTg1bHXwmCitJJIFPVRDF+o4RjYTiMA3b7gl8SKs111+zYuOGEpgTzlnYKMH6OUO
         Hdsg==
X-Gm-Message-State: AFq9FYL3zd1BTPyZSY7RAP0MeiYyx4ULjRpU3soS28M7uMHIjC77fuwg
	/8SQ1H9gF2s/0ZPZbj5z5QCymJcKUaOozhmvPBJlG459QHbtSDj18l8g1ChicOmEtj6bfjaJYkh
	sPaoAk+zYZN3cVcEAqMADWk1JGKPYxECifbiNl7Sjk3u+0+3i2T0TypYvxrWHQvgDwA==
X-Gm-Gg: AYBFou0ZWxMG1o8OOvRswweqaBTKCbKilA8vnTlMiODCL03A4s9k2L1HcDSbrv6AJ/6
	8gTGPpCwYWZ9B4N7tviczeT3XUnQXTIZfG0maNoDF+k6qNIpZErbp4txcFKvKIQ/W0JwM2kOWOh
	fYclId7RsoadrHOlk9vYMX5csGYZjnX3oFWo8dJEq+FT4+N5olOK1z1z3L8IgQd0Da7Q/6QM/PP
	Ga/Ox6NmPVdWh0zK5vj/Vxgq2fVq0/hPVpnMiPrY2DcbKMHkz0BpbgJ2bGSjR2yJ8UDxJmzFEkJ
	vDOtBSfr1kraPWAg1y2pSshgFyqOZ/PdKFTgsY1Byt1rUQuCk2wgWgAhj65w84ovzfTej+EgkHV
	prYbJkas3H1NTDv1F77U/qZkgLeLyA8cLhaGPmfY0JdI1ty4IiTxzEFliFzm5vn4Wss63TBLO/A
	==
X-Received: by 2002:a05:600c:34c9:b0:4a1:f625:2108 with SMTP id 5b1f17b1804b1-4a35acebc28mr171076975e9.33.1793094504727;
        Tue, 27 Oct 2026 02:48:24 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:4a1:f625:2108 with SMTP id 5b1f17b1804b1-4a35acebc28mr171076625e9.33.1793094504325;
        Tue, 27 Oct 2026 02:48:24 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm22428503f8f.9.2026.10.27.02.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 02:48:23 -0700 (PDT)
Message-ID: <d03b1d1d-b7c1-434e-afde-8e2cab55e706@redhat.com>
Date: Tue, 27 Oct 2026 10:48:22 +0100
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
Subject: Re: [PATCH net-next v8 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
To: netdev-bot+sashiko@kernel.org, jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, horms@kernel.org, victor@mojatatu.com,
 toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
References: <QDISC-BA27.v8.r0.20261020063241-4@mojatatu.com>
 <179286304080.3134.13197757888201893950@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179286304080.3134.13197757888201893950@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/26 19:30, netdev-bot+sashiko@kernel.org wrote:
>> @@ -1784,12 +1811,49 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>>   					 QDISC_DROP_OVERLIMIT);
>>   	}
>>   
>> -	/* choose flow to insert into */
>> +	/* Select the tin and extract the keys before segmenting:
>> +	 * skb_gso_segment() rewrites encapsulated headers, which
>> +	 * changes the keys.
>> +	 */
>>   	b = cake_select_tin(sch, skb);
>> -	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
>> -			host_override) + 1;
>> +	cake_hash_keys(skb, flow_mode, flow_override, host_override, &keys);
>> +
>> +	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
>> +		netdev_features_t features = netif_skb_features(skb);
>> +		struct sk_buff *nskb, *seg;
>> +
>> +		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
>> +		if (IS_ERR_OR_NULL(segs))
>> +			return qdisc_drop(skb, sch, to_free);
> 
> [Severity: Medium]
> Can this qdisc_drop() report a bogus drop reason for the original skb?

I'm sorry forcing another iteration, but this looks real, and should be
easily fixable.

Thanks,

Paolo

