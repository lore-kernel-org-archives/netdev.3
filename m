Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262830;
	b=TT0COR/iK7ENBXiuWgv3Du4Eqd32VYmwVMKOx9gwPhr81c8fdg+MgpiZ59bcIe1xQlxN
	 WlpqlRX53a1GlJvNhHBxHy+ugIq07DiZfnF5dwe05jf66YYLE5NMnNWkivgGcVhpIS9+f
	 DoyIzQiP8jMm3giiGC0/JH9ZFwFkebLpYo6Cw7z2EBAvLb/T0Auej7S0uHHB3k/weiweZ
	 4dwK/y+YWZItlHz/HZqRfGa/UCeAoNJJWsGR5Bgs5qE6FiqgwqxgLcQFikO4kOoPqMKz5
	 MjBvPY3feioQa7ROsOrD9y96n9IuEzMIXCsYXBGbdlyyprNQwd7X96Kb8lDZbS5Jo5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262830;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GF7UWaqzBHrRMqf1twL0Wkjov/Qdp3CO2Y5n8FNGgPQ=;
	b=rMee7PlbY828lA2/z2sKnkPVuInMjhsbHFUjP5B3SWsf/hMQZKU4DdAhTFU7DvTHL26l
	 LGYaizoPoHowCrGKuv9HrIJcRAYJbEIaocZmQtZHe6EEsMa7rwKLy8uPcemIoBH0jxSP/
	 OMp03UpmEs/qhk7CRaSaqPkAJ3Z3cVHjA6hSQR4dakwyewAQ9X102/zEtp4D9JeNGWczc
	 CSqqb7m7PwXE/5UuR+R2KfVt3uJPkOmg/iavYsJRBRo5KAj7T0oU/sBUd/X3Ub0/aBZha
	 rTSIxnFnG14W4GQW7MKEK1znCuNnlDqAPe9j4JazD+iH7W7xPMYsbQCRq1gU8ShB4dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfAUxfUi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=j+WJNVJr;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A3606A327
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A51A3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfAUxfUi;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=j+WJNVJr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793262828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GF7UWaqzBHrRMqf1twL0Wkjov/Qdp3CO2Y5n8FNGgPQ=;
	b=LfAUxfUi5dU+9cIgSRWPxki4egR7f9zNbnQ27u0d1TcYQPehQ4qIGOZm7ftRN4V9Ua7yqd
	8FGIT7eawBqxlsb0FrP8HtDNDTSd9DQyDj5qV3J4qtAnUF0Pih+cNcClcPHO5IhorhdUpa
	SizD3z//Ri9TB8gWGZXU9Jq8lGMgsaY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-h2ZeKV8oMiuRulPi-C8cSg-1; Thu, 29 Oct 2026 04:33:47 -0400
X-MC-Unique: h2ZeKV8oMiuRulPi-C8cSg-1
X-Mimecast-MFC-AGG-ID: h2ZeKV8oMiuRulPi-C8cSg_1793262826
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so17210375e9.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793262826; x=1793867626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GF7UWaqzBHrRMqf1twL0Wkjov/Qdp3CO2Y5n8FNGgPQ=;
        b=j+WJNVJrJeOthrTpF7+ttqTv/8eiZafAYmXxM2ShcfqcTYuzqwOtB+Ud7rshGR9E0x
         P87gFoqBvg4QLPSftqoJjYEFC6bKOFLJlngnT6ycGTXV1GUZx/J12BWPpZeWz7xT7F6d
         WblF9GDbprO98YgMdbWEB5EW31AbHsahGeUuiNIEu2O4KZExcw6kg6nNXy9WaqQdL2i2
         0rttuSTRNDra3E/gGmYhFUK2U04PhxkFPeLkCJ6VpTycixibpyTmCfzL3JIS9w+ln/ZQ
         t1tpPu8IoLvp1n1Zm84/LYbaslfoLK3pfiUBGmpvLoafn7Vwz6Z/6s6fUqLtZtxG+pff
         jnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793262826; x=1793867626;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GF7UWaqzBHrRMqf1twL0Wkjov/Qdp3CO2Y5n8FNGgPQ=;
        b=szZGfm4YbCk4P7nwObbtPw34l7x397ad+Njbmo5AmGWKsSKsWCRRek9JOu5IRR2Usj
         kGgNaYgKZJj5dHR1dFwNuD5FrYKaFzq5aTVU4r0iXGoWd3//eeHGMFoeX7tzYzdySDVM
         J8LO7pc7C0zXaUoRFu4eOHaZ3eVv3ROpw3suTNiRSBqIv65VMxgxxHzrI/DwyZIq7+mo
         KwX19gmEf5cJ5ixqhzykyKLr+q02FAbMAAE6Y54aD9mJobDOUgnw2qt//umbnzNBZsgk
         9X+mWASYSgqrXwvHzrtVDQQn8CqjZERsjyUF9Ge5MMbNVQCGIG73f5viVlZ/jDsUM+qN
         HUrQ==
X-Forwarded-Encrypted: i=1; AKwUvByIoHrUjDoVjOTTgErSuwPlRiX06mGcLlmG855s0xj2Ar5gbwSrxhMcRQq/nyY8x5zGdWyxClg=@vger.kernel.org
X-Gm-Message-State: AFq9FYII5I3SYCBk3IFMaM1CLS24/kv71YY+HaFcXQ4itI8e2l+3T0iK
	20trLQfwrSWu0332UQPcHU+aaepj4QEOLszjsW7B2/jg9vCN2J41eXUprh4c6lvXjfLfP3a2LSB
	JSyDcXbYlVrJR/TtDNGtz7GrZt3VhDIgJIK9JW7AQDj2z/rmYxEH74l29+w==
X-Gm-Gg: AYBFou1nfebiX/dYFz1WiszXF68TS9qzwHEOs6kuFIh+Xn1ba4MPN0HroDgqhafyJtY
	nb4bExAPfiTXNpq0egTlFXcAWbHflEkfpW9zEA0sgekQSqilOj+AmPk2Pl9VaZARn92u/VnyhO8
	IE4/0aDRQG8B1fA2gQdkxyToqaTQL+G9z5aIBgod7cNvapUnoS84KsyltIL7UFzLu2n7uQ3TkOt
	SxE1Fm7ZM4ePgEUlbWg4jJNyi1edHQerM/hn/blhkbvk5LqEMtO0VmLwGkTg0pHZYAyGRoz+6xK
	44CkGGLyw0Rw8GpTOsdwILPaHPYyx/sfTtSv+u0TxN2Fs1hxijI60w4RtUQjM4YHeNrSoNBCaKA
	bZZMhBiz7IYdCNCXsQviC49kQVnHPkp88kTXCfWbp22eILjldtqc/vW+V7YxIK4yCjNzIpJhAdy
	QEAgnT+FJoLPNQME5IDQPrb7oKH32wan3652a1OrKncFmhbJA=
X-Received: by 2002:a05:600c:1f93:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4a9663997dfmr100806765e9.9.1793262825673;
        Thu, 29 Oct 2026 01:33:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1f93:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4a9663997dfmr100806225e9.9.1793262825282;
        Thu, 29 Oct 2026 01:33:45 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7c5063e3sm50488775e9.0.2026.10.29.01.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 01:33:44 -0700 (PDT)
Message-ID: <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
Date: Thu, 29 Oct 2026 09:33:43 +0100
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
Subject: Re: Backport request: Revert "softirq: Let ksoftirqd do its job"
 (d15121be7485)
To: Gyutae Bae <gyutae.opensource@navercorp.com>, stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jason Xing <kerneljasonxing@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Minsu Jeon <minsu.jeon@navercorp.com>,
 Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
 Siwan Kim <siwan.kim@navercorp.com>, Gyutae Bae <gyutae.bae@navercorp.com>
References: <20261029054200.97234-1-gyutae.opensource@navercorp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261029054200.97234-1-gyutae.opensource@navercorp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 06:42, Gyutae Bae wrote:
> Please backport the following upstream commit to 6.1.y and 5.15.y:
> 
>    d15121be7485655129101f3960ae6add40204463
>    Revert "softirq: Let ksoftirqd do its job"
> 
> On a production 5.15 PREEMPT_NONE node, long-running overlayfs
> getdents64() calls prevented ksoftirqd from running.  RPS IPIs
> continued to arrive, but NET_RX processing on that CPU stalled for
> up to about 3 seconds.  Over 15 days, the node logged about 1,000
> bonding ARP monitor failovers, with no link-state changes recorded
> during that period.  The failovers stopped after the workload was
> removed.
> 
> On a 5.15.27 PREEMPT_NONE test node, we used a livepatch to make
> ksoftirqd_running() always return false.  This removes the same
> softirq deferral checks as the revert on this build.  Under the same
> load, we measured three 10-minute windows: before patching, with the
> livepatch active, and after removing it.  The number of HTTP requests
> taking more than 200 ms was 17, 0 and 11, respectively.  TCPTimeouts
> increased by 25, 1 and 21.
> 
> We verified with patch --dry-run that the revert applies cleanly
> to v6.1.190 and v5.15.223.  Both already contain the related RCU
> fix 1dd1eff161bd.  6.6.y and later already contain the revert.
> 
> The original commit was intended to prevent user-task starvation
> under a softirq flood.  The revert's changelog points to threaded
> NAPI as an alternative, but it is disabled by default.
> 
> The revert was merged in v6.5 without a Cc: stable tag.
> Syzbot has also reported bisections to this revert [1].
> Paolo, Thomas, Eric: I would appreciate your thoughts on whether
> this revert is suitable for 6.1.y and 5.15.y.
> 
> [1] https://lore.kernel.org/all/000000000000a249880603717c15@google.com/
IMHO such change should not land to stable lightly. It's a behavioural
change with subtle side effects. The threaded napi feature is disabled
by default for the same reason. Also the revert has some soft functional
dependencies in napi threaded cleanup and improvements landed into v6.4,
i.e. 6bb218b5a6e3f3c5e2e76faf8fc976f3f6f72496, likely more.

/P

