Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39352DCBFA
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454197; cv=none; b=aah3NGxrbCTEJb7Dy1EeMwMgd43iauSInHNeb3wT51O+qfTgKqHT+ckAPi7YWU03sNUeChoiRS9+KvW2MaUQWV+iQ0Mow/xtLOmXSLpZGDNBh/j1MQx1s2fZx/X6YYvDkMSOM/doFb5CpOlYWty1QH9X8Hj/3Hu6bP34kziBqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454197; c=relaxed/simple;
	bh=EV61FYb5D/7ZN7WKyu4faP8LVXNRQBmvH2wEtYT2LmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvXy+TCAlPo/miitGRQ0vMs/920ZyHZ8cHUdDxZYCEgo2XA8chZHf69hL9CBskNecNxYBxNm5LVCKwjxCb4qvtbaphVFImqh3b67nzz1Ag56zFZaheI9AxnJviI1BfBe+oL2egV04+qyWNdMQliLJdyNXLnbCJHp2KWJN6UBxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFj2Oo3i; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFj2Oo3i"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a205b0df35so1612328a12.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786454194; x=1787058994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eytp0kWHTMpraBTsJPqytmrRy48FIzv9b11elB9I5zw=;
        b=gFj2Oo3ih2LWB9sX0cOs8ZSvucFrigSyLmQI0TWju/RM/kfml1Ql1JheN6p1glvO8N
         ghvzi735tveXrnStYtlDuqvDVxQKWV3iMEJwS/C6fSokLKo1Bh3N0bWtAdsByN0LZ6WS
         U5mQBmRHFRs5FSwBBwFVKLyhuHZFMs7fSPTFdB+8IAGRqglaZo9RDDJSCNxuOZsN9msK
         j47LdM4ayOpXbiqVfqhsG5DxNoBtUPYOhiT72gqXQ7h7R181ilzV5sKbjcAXlM/srOY6
         uuk1Vot7Y+/s9g8tH8nX2ZBhyp/FuNxKvk2RZ1OnVO7vQWDV30GlL4EE4mTneoz3tqGA
         K8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454194; x=1787058994;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eytp0kWHTMpraBTsJPqytmrRy48FIzv9b11elB9I5zw=;
        b=LlqPvG8/vLlYCcd49UE1swCLvFXmUo2DqciFsz1jU7Ok1tdWX0L457SqSi0YLHs1Iw
         0kkcGU4Q6PL3y2B9Nr1Mk2KgIVpFRnvsduPL2QEdVVkgkkgJMM5PWZNNHpqsk+k8Exlv
         iAJ+ONfzatxQ+SK0zX5eZwOsQF1kEPo1UK++OczF5N4oPnPGht6uoMrUkayHbpyA/g+l
         sSARj3tWw16g+oRDeu2BFPsUj9i23agUrPHobtXkUql+gfSmWY9Xp6YFqSl9+198x1nP
         pdlefhkP3wY4h5J5sCFx/qGE0Oy395cPkY4d86R6fYisvs0FFSANMtH5+toq6tG12oej
         NGRg==
X-Forwarded-Encrypted: i=1; AHgh+RrTTzo+YhLQMWFqxJSg7bpjTldFoGVsPIcMD5/VZ/YJ8ccKG+F8muyF4nC6fdxTpAKF5GI70d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCmamfSzz3GOVzWJDzVwQp7MxQN6FIeDngquOCLeIn1IaNfMX
	C58e0HyjK0OtzKjzd0d9Ga8X/N88rrzYTh1IGSPvRpayQzTGtd41vyTF
X-Gm-Gg: AR+sD13KA1xI4ujP4UnEkLz8xRoz1SPqLYiTCwnZ1rSlTkGd9VEWfw8WyAzon2571wy
	F7DKbFq8tAsTA1lJMkt79OwMB9VxISWN7UasuMCrkda/1b8jKbKDZCvrFVDxnmizleHGDkkRRfe
	pcq9gO07hgWp6v+Y1Gt5jKt2L9RpBJLQQ4aUZIZeYLMbKYYvjPSe5y8Uqa4sGokVQmD/JbxZY+K
	007tOnHqzn+8fSnV4BSp2qKz3Gg5EP+f5ObFnQYodkDp8h5STw4ZC7DEwosp1ayDJ3Ov+e4tojl
	U3lmpbBsB5LaKs3yVAwyOvXybuI9+DnomNdHD/zZCKo99vv2h4Si/HghTQyidiXAQxqsvJmMeEY
	gpNBF1Jb/N4LX2GOO5ZVKWwoNA82bWew8HNDRDXyzRdGOhZsaC4UKiGq84nPdUeuUbB8f8S1HZ4
	xpKVQ3VTEajj7KukiYWJsZgeomLLgxJi4WIstLyRDh2pShGE7gHIwz4lkN47+ye+kTjsToLFkkA
	ajY+3BSftL+BU9EQP1s1SanSptJ3+SvJQxOsTiES3HsjbghKfnp9HtG2BsIZEvWCn/i093AshHf
	HAwAy+ILfcGS5fPyA0fp3TgTliX30nXnSTd/Cu0=
X-Received: by 2002:a17:907:d08e:b0:c1a:5d49:f99d with SMTP id a640c23a62f3a-c20ec8d8396mr17558566b.7.1786454193602;
        Tue, 11 Aug 2026 06:16:33 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e431f414sm50782666b.36.2026.08.11.06.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 06:16:32 -0700 (PDT)
Message-ID: <70b36cb8-bcb3-400f-a3f6-d038bff88723@gmail.com>
Date: Tue, 11 Aug 2026 14:16:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring 02/16] io_uring/zcrx: move RQ head/tail to
 separate cache lines
To: Mina Almasry <almasrymina@google.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1786108672.git.asml.silence@gmail.com>
 <f769116a3f5267f06cb9a9a819d482ddea2e0852.1786108672.git.asml.silence@gmail.com>
 <CAHS8izN4SAUCUQySd+VTbdayX-Stj+eYOqAof+Vhi=EsRb93_w@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izN4SAUCUQySd+VTbdayX-Stj+eYOqAof+Vhi=EsRb93_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/26 18:35, Mina Almasry wrote:
> On Fri, Aug 7, 2026 at 6:25 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> RQ head and tail are currently put into the same cache line, which can
>> cause false sharing problems when refill is run on another CPU. Put them
>> into separate cache lines.
...>> +struct zcrx_rq_hdr {
>> +       u32             head ____cacheline_aligned_in_smp;
>> +       u32             tail ____cacheline_aligned_in_smp;
>> +};
>> +
>>   struct zcrx_rq {
>>          spinlock_t                      lock;
>> -       struct io_uring                 *ring;
>> +       struct zcrx_rq_hdr              *ring;
> 
> Is this not a problem in general for everything/most/a lot of using
> struct io_uring? Should you make this change to struct io_uring
> itself?

No, io_uring headers are usually accessed by the same task,
that's unlike zcrx where the consumer and the producer are
two distinct entities.

-- 
Pavel Begunkov

