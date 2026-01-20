Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166093A89BE
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945417; cv=none; b=ceM3gmhJHHLLJxepBeEkDE7iCBy3xAXHoL8AYg6n20AqM5kjv61NebbsdChJw4DehhhHqSKDwLFgLqHZSAsZMP4NxkxZWYOstkQui6mPkw2SqNZeIIxR8hCD2yTFGYZFPabyMRbhsOJFAynL0Bca4SYcqpDcPbw2yxFZ2rDqpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945417; c=relaxed/simple;
	bh=MP1Mn0bdEKua0x6vIdddeShvw4YYqRG0iiH27fp3yv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueN/54PZB3wa4hLFBIPL2HvNiXACGGUlVFXY2RDvj1Yj2z+3RW/wgGhMHtU3W1kb7vJYm7ZIwNHDcdlb533I/yT2QlUWPGnVRTfZqJSfkxBEkunS57r2XTA3SrCZQ4kQDbANIOmXxtRw9i+JeqKEhCrjLnOO6sZgTkcG7opv5Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+ZIqZI7; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+ZIqZI7"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6b0500e06so6240209eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 13:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768945415; x=1769550215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcboFm7uEzZSR2zuJv9igPZ7gCMqbxtsKchD1qT9SR4=;
        b=T+ZIqZI7JGr2EMmODwJdIgv7Dr2EgM8+B4W23RUWNxJobPATejMR66Oq1utn9f3tfJ
         gH8posvHri7kWgBZCxgYmzDZL2A65hXI7RdW6jMLv0LVWqq/Uu4Zp1r0yh33Jk62XlsA
         0nsQWpogAddL+FDooyRTbGnaiK0/Chm6h4KWtQq5GOosPa0ylnt9ORHeUU5COI3TBAtV
         l0cdkbvqTVNEdN2PqwWlZxdxHA5OVyR5qLPBvkDN6Ak9/JoPPP21Xd6F3CHaTc+BU4JC
         WqLItPlB4swBmx3oecVqmpnHUFpSN+/Jkgqqc4W1VVyxlYYPALVzvC2fM4L9VOh1FRFt
         meig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768945415; x=1769550215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcboFm7uEzZSR2zuJv9igPZ7gCMqbxtsKchD1qT9SR4=;
        b=tLSWISYiFAc3d/ZqLyAC8e2HnQuf+1lz9ib3vmt7LJml48AOt0Wit9nJciLMwxJHcR
         mPiiQbp/FsCkQEsm7TdcV+jRLVgV4vvT/iJjQbWSd1R9YqYs65fT8/7JAFe/ig8xFO6R
         PnT7JoBoUHhLdfqyh1X9jBwwnh/PPf631NaPqE0FjaicJddFxzvcUKAADthW36ECDP9O
         1PAS322gvXbmU4iInKi4p6ngzBtpQbwGf9RvpfjYNle0i7CfNMwuz9xIhHQ571dS1a4X
         /4jENZYnLup1FV5p2+Wa7LOseRU1zMPgqZ59yFLBfWjc0nf0IL0ouaM5rzuTRzmRiXvx
         IO4w==
X-Forwarded-Encrypted: i=1; AJvYcCXCR3Rj+oB6tTxRCZtgVoj+04kMKiopAIUoHQa9PlercCufMN8JW5C52PwhBvh6F6EUzbhdhkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0qkOYnIaZqp6QIqBQMT9WdVoO2IkVokBX3LEW2sLFH4QQiJK
	lBmDyErVV7OB0hDsHVDUbMOtSm4WqLBpj+X4f1tvNv8gClA5q6fue98i
X-Gm-Gg: AZuq6aKRI9DG06U/0hF9vu6fGrnck/AMfsekfWgsTDMP8oJ8TZ8hIe/Mvrg6hmjioU/
	RxKm3IaicxbGRfthEFmuq1T0nTVzgRRtcwuGQT+MQINBLwyJbTfs/KcwtH3oEnB32rJlwKW6yAf
	3DzPxcAW9GYthCHErhjMF/mrzquGp/Cp0gbT4B/6pkAfNWuMcbqFhRxPJJcyd2a+W9jTCcfL0zO
	bNAvhTSDcoA7D8WsgrY/Zjw+8di2wwhOtWMUq3gQqPvoJrwZhxjRpgwbErxLAsKlyMZLyqvOYPV
	z5tWksEtKaAT8SkDaDf9+04gLOVo/NnL9QPytqocvrXtVvHyf+RECaWmcjosUUoYImP2v7tcqgI
	r6wa+esMybZZdctF1FVWwT6TKddvuZSp4nb354uGwwHn4BU6bdjKpBJS9Ethlf9fb7RWeRtOSWh
	KgEMTSYv51GauL6otFqgeSRoiOVQhH8QM0UNrZQg==
X-Received: by 2002:a05:693c:6089:b0:2b6:fcc5:a9b9 with SMTP id 5a478bee46e88-2b6fcc5ae54mr2125948eec.13.1768945414866;
        Tue, 20 Jan 2026 13:43:34 -0800 (PST)
Received: from [172.24.227.237] ([163.114.132.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6c2de1f29sm16776428eec.15.2026.01.20.13.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 13:43:34 -0800 (PST)
Message-ID: <de37782d-a969-4f02-b7fe-355bdbe63d6f@gmail.com>
Date: Tue, 20 Jan 2026 13:43:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 5/5] eth: fbnic: Update RX mbox timeout value
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jacob.e.keller@intel.com,
 kernel-team@meta.com, kuba@kernel.org, lee@trager.us,
 sanman.p211993@gmail.com, mohsin.bashr@gmail.com
References: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
 <20260115003353.4150771-6-mohsin.bashr@gmail.com>
 <d9096361-8f51-4865-af59-531649a5f42e@redhat.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <d9096361-8f51-4865-af59-531649a5f42e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Timeout for all events is now 10 seconds. Is that intentional? Could
> that cause unexpected timeout on flash update?
> 
Hi Paolo,

Yes, we intentionally set it to 10 sec.
> /P
> 

