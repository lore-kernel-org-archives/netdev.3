Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793091865;
	b=qHeGuuO2Cb+F4x1DQT94FBlcgST1y5vad3SILLbXS6AB31Dt9ZF7A94udRLM6vX59ULe
	 PATdOFgNQ/hC/FEiY1mf1qzIK9PVxzpK1jIMrMKg7awvwE65cOtql/0H3QxPjecwej/SI
	 qCtblmoNRy6dpNbUuQg+ZOgGmJe8LK4o9ud9lKFIp8h6x9UZCsRmF9EVNIDukIz1XBKru
	 xtiCyu7OL+F5+RPzo8V9VKXQkvTYFbl3M5yI4j9UfuSv11YJ87KZeQMuCYFaq/4IDDc69
	 WfyGDZDXwLAKQZJyDeHv25ygtzikUCguOt/X4j29t30TGj1vMrmwl0VKDXvhWvD0iSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IC4ICtskpaMr1BDvtcg7zj+mYWKpW8yLLny0A2JJ3ZM=;
	b=plmHcUAdxq8CMg5l9lLSLWKDAb0SN8Xhy+d5jrErm+7O9kQTo21Jry3vxrDuvz4hA+cc
	 GLbKNkIGo0p86sV4/pvbcAi8x5YmtPee752d8yf7tStu8Zk0adjccpeVhjBvh2GLOX8bM
	 GGslIpwneFpcBskk/wDwF3Sv6yCZQhpQbWFWQQbHi7u195+RW2ymNqIJkELhpOZfAxRNh
	 tLIqhC9+a0cLw3owqMCLOcYT7OEcM+ku6kU7fZ7DMWBMVqCwcyFp24ncooH21OVknsj7X
	 lBY8XJvxhtCFGUxhcAHB6mhGadFT04191j9QCR+9K9FRfYAB5Vl0FIX8GnMOh8yI29A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nuXcgjgI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A3606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A76A3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nuXcgjgI
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0d91601bdso6320317b3.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091863; cv=none;
        d=google.com; s=arc-20260327;
        b=FDWtRIZodxwbdEu+PvABtSwTXpqwkZEUYhLE8rWxweWoXotYywxE4by22UbwThSLvh
         6/imXjevUSSWSPOgECNt5mO+6VFrnDv4dR+3d7LQ1tdlVpWV/0aCQBSZu8R1hn1/iBlB
         ht1viA7/5euoh8Kw9A1jmpwW4309mQ6xAF1t6YRCr8KfJvljYJzFkUAaQ35QBxI1JY43
         H396zVP/f2Va3emUz2oplSEQhJ/SfdkqgefH7b0D5AvWgJFRPLdIvD+1T9KWdijLDjSU
         mUyKqp+B6Kxa35/R8oUflwMDSEQ7gOu5f6gleQrDjN/N+qB5Q+EnrkjeoMDt255P52hU
         32ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IC4ICtskpaMr1BDvtcg7zj+mYWKpW8yLLny0A2JJ3ZM=;
        fh=h9728ZkkZooPlGBDmaJ5Wk5QX1Bq2LUXxFoNsv7vBFI=;
        b=rmMp/dPZEIr/efbBtVzTRcFbedL7uAi11Sow2/aYotL2wtEMKKFNWWVhdvnWxfF/ep
         YgEkezoa8PIDIsWlXIYO+vfwKKKyRd6nFWTyC6mQ8lttLufLnRhTQkHEdSvkLckydnSE
         DWB9VvM0lfd/eUFdk01GxSKfHtOqoxsyV6DWFm7qPZ4yakX+E6YbcAwSJ5S8/9RX1EoE
         cdd/m9HbwvLd1D9o3YxZSi6X+18m1Ys2TpvaT5c5PMO9pkzVjJKMu770aIZTbQgcHkqe
         rkJud2D0twCyCbqSThYGQXtQNcgBp7c8Yp+2NaIEZvKzzmjE7WNn0rBo5HtMirzSNgUf
         4WBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793091863; x=1793696663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IC4ICtskpaMr1BDvtcg7zj+mYWKpW8yLLny0A2JJ3ZM=;
        b=nuXcgjgImRLpr33nbQdXKUCCrMD6AEqN2Xnpc+EfrpyBTbxxXk68hY0rQmm/6syrel
         u2dPxtll6lq7LM0pUYwkJWqgo/KhNVQdQkBWIwm9Yd0qB9uH6hSuqcw2p0/+CqZk6S9K
         0yQu0+Htg5AeXpEnh4Msr6+u9UGMoZj4NT8IXQZj0MCj/O6qBq0Qaz+DUTD+uq9tmE9g
         kFCUXvOVFVeRROMpTCRF+Odr833ULEPnJge1NfbZN0elhwcGdRQ7qiXcg9u1sAypjdvJ
         LCGMitjTkGnJnD8qpgZ4gxH4BhVcyKwO+bbaK92JN4UVpYBqf0+4EmgmcUkWbQ6d3ePE
         thLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091863; x=1793696663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IC4ICtskpaMr1BDvtcg7zj+mYWKpW8yLLny0A2JJ3ZM=;
        b=mgOoSUjX9QkOMil/byL9AohIORAIvzYAPhxMeBnWxo06NYvKkjyN1a/F8pLmAAmWhv
         sF/8/d5rR3vRkez3UMZNe3PbEwMnVixCwP80polHE8PV4ZMmgB3aZ8XAhRfLNZtLVZsP
         txms/WalzU/ip4GZzy3v5eCKyDM+3qAZHtCi+OJWeXVByegshJPiDeCm52y3Up+UI7Ln
         Uu817aGR2vl5AQkIqWRtJlsxy/MXdyUih5clRg1MQnTAX+40gea4ytrC3CHbm7t69JH/
         5MpCs5uLGbsLSlufIRNAj9dDRM27KzRDnZsqcIswlSpM7Dh2YT6k2u8h0L8LhrVHkn7B
         wugw==
X-Forwarded-Encrypted: i=1; AKwUvBzo1yei0pQl/g8pmlAxfBSwirSMXA6EizF4DeZIzLZBUePx5fa9uciNcLHdE07pFJ4/mJ4kU5M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBgOCEJjczfExgioRD3YnfDfnwa0rkBzHS4FLQB3k4/46mRH+Z
	HwG0/lqmqAg/ivE9K0j0XTtYD3dUALhQdqRS3tLd0KAduwX6g3hs/+XH8mpUb4mV+DHNhLjklrB
	f4xuXfn7v+zvRqi+zgH84o0JrsdXQ5YI=
X-Gm-Gg: AYBFou1jpAPYcPga0wQ9wuHbpPoaoEH98oEBgDzBN9PRDVYlEe6vYY7IP7fhFQQnDw5
	uEehRdxdhYX5kzcNLuE3hP6w0F1H1eOZDwa+37NF8q4FenW0XY5ORCpu7sYZvtOavaZLfZhJN+u
	HQCQ09/y6Im/PHwO8k5ro7n5ZpyMnLoSbaqj9FEqF2FxmipqTcojsbTluY3UJ42rkz4WwYqdcVT
	T4O8aZEOH9K+hTcPMzqMptnuGsmQvyQsuD5WT6g+E3+Ci6g8OEHDirb1zuOsdoitaWYIbIlaA63
	ep4G3pw8SE2Z1sk0SwnSK58upZzWnH/sKi8R4CTwvlWkXk7u+igLkma4r3k7Mc/NAxeL6G9zZWk
	xL5+2/+me290HvVqEbcgVJf5ttQoOj7VTLPc=
X-Received: by 2002:a05:690c:6387:b0:8b1:567c:e7d3 with SMTP id
 00721157ae682-8b19c7985ffmr16596757b3.7.1793091863585; Tue, 27 Oct 2026
 02:04:23 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082405.1297-1-shengshilingmu97@gmail.com>
 <179309014594.3327.16979359855381839184@kernel.org> <CAGGuW1XarBs3ZD7eKeysDs7qGL3=Zgd5-vsY1ReuF57gz8aLFQ@mail.gmail.com>
In-Reply-To: <CAGGuW1XarBs3ZD7eKeysDs7qGL3=Zgd5-vsY1ReuF57gz8aLFQ@mail.gmail.com>
From: =?UTF-8?B?44K944O844K544OI44Oe44OI?= <shengshilingmu97@gmail.com>
Date: Tue, 27 Oct 2026 18:04:12 +0900
X-Gm-Features: AclHuK8kmj6WVIj8zol8TSlhzkemES5oLPxGf7X0ktRixJ_-10JdWdLfo56K8xM
Message-ID: <CAGGuW1UGKtQUGyqY5fKNhBRnmBJ5L+QggeLtbdtvXiaDo+Mmsg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: account for chunk padding in sctp_init_cause()
To: netdev-bot+sinfo@kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The missing tailroom was found by reading sctp_init_cause()
against the padding that sctp_addto_chunk() writes first.
AI assistance was used for that reading.

The bug was triggered, not only found by inspection. The panic
was confirmed on local virtual machines running 7.3.0-rc7 and
7.3.0-ga1c2b1da93f5 (CONFIG_KASAN unset). The symptom is a
softirq panic:

  kernel BUG at net/core/skbuff.c:214!
  Kernel panic - not syncing: Fatal exception in interrupt

skb_put() calls skb_over_panic() before the copy. The observed
pointers were tail 0x6c1 and end 0x6c0. The same panic occurred
for a listening socket, an established association, and an
unprivileged client socket.


2026=E5=B9=B410=E6=9C=8827=E6=97=A5(=E7=81=AB) 17:50 =E3=82=BD=E3=83=BC=E3=
=82=B9=E3=83=88=E3=83=9E=E3=83=88 <shengshilingmu97@gmail.com>:
>
> The missing tailroom was found by reading sctp_init_cause()
> against the padding that sctp_addto_chunk() writes first.
> AI assistance was used for that reading.
>
> The bug was triggered, not only found by inspection. The panic
> was confirmed on local virtual machines running 7.3.0-rc7 and
> 7.3.0-ga1c2b1da93f5 (CONFIG_KASAN unset). The symptom is a
> softirq panic:
>
>   kernel BUG at net/core/skbuff.c:214!
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> skb_put() calls skb_over_panic() before the copy. The observed
> pointers were tail 0x6c1 and end 0x6c0. The same panic occurred
> for a listening socket, an established association, and an
> unprivileged client socket.
>
> 2026=E5=B9=B410=E6=9C=8827=E6=97=A5(=E7=81=AB) 17:35 <netdev-bot+sinfo@ke=
rnel.org>:
>>
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>  - How the issue was discovered, e.g. hit in production, hit during
>>    development, syzbot report, manual code inspection, LLM or static
>>    analysis tool scan.
>>
>>  - Whether the issue was actually triggered, or is only theoretical
>>    (e.g. found by code inspection). If it was triggered please include
>>    the symptoms, like the stack trace or error messages.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.
>>
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
