Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B373B992E
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766396; cv=none; b=tT/AiO69cySqQ7onOcH3kSEjhRuMDoVz3Shd/9i0tY3Of06AmuyyCZnOCZEXUkLUFxtCmx5mYeGas8rPYupg1QGPSnyL8KXan/w8gS1fG4U3Z7XmFR2vxetE7C9/mTpQZfVxUGzmCnemKiXFwfQfYIH2vtTy57KH4e5IskqAzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766396; c=relaxed/simple;
	bh=iLShBTObBjfUKeA+fEjxm1zrMqcpnd1Dt0/78RxIBzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYjXdtu1lAaE8lNmhKvptMrmjs5aY4X0bxfW494qyKdR/UYgO3Jmboa7dHhSbl9Vq/HyJE0TI5/XirldAelZ1vVIURc1ZpqhnmVpmRtBVR9VJRlYKk8+IPl+ZVdvy3+ZsCO28VLBbxNWaFeNEp8N4x6ihp3Kz0xkWBWxFKAAmQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrOW/QL0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrOW/QL0"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so2825359a12.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766393; x=1784371193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYrkNwa/f9nT5i8NZf+ZzcLIrhDN6BOEIOCenj+efqA=;
        b=BrOW/QL0cO2o4buJbXMtP04RtK4EhuacU5AlGBhUrcOIqIhyLbpKi5L2w76lm5h9ni
         NtlVxq87ByX11DG0F57V+Ihi/W0vDYWjbqXZdvWk+n9wktnZnOK4a3B8bLn4pdEHyutS
         xO71/uqdHuLb6EUL0Y3saF9WSJ3ddduhT3hqtkAppdC5s1Csr6WZK5bXlhSywTf8yunw
         vdKCXEqzUjvJQkTFgfcGw6ddm2k/igX+q5t7YfepRWHUQSGtOCadtBoDQc6u92xgOgbt
         97R1C0gKJgg1vHnupr0uYsKIlDtqxdChripIaG6xAEhcY5E7I9hTbXqAI9/gL3Ie/tZv
         uFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766393; x=1784371193;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYrkNwa/f9nT5i8NZf+ZzcLIrhDN6BOEIOCenj+efqA=;
        b=MvOnJkeZ0FP0Jg2MGJRlrQzLJ7edMHxsuxbqJP7v8gN0RZ8PTXgfYozQkCzLvT8K67
         UJybF+WdPyGCybapl1RSm4ylDhiHrWE7yuR7NdV0frepfbkzYUliJ1GxVzW244ssT5rN
         PWg0dvkbcqtBrjfCy2e7U7dyeYr5rnzZu3UrIB8diUX9IzKVm0ir3oLoE0vpif/8AJ/6
         no97M/fnPz4zOwtdKysmAke65oCC550nRA5ZW4cwIrJmxcjWrzb50Ad9baBML5VCc7Mr
         NeYr6V8T8nWgUXEC2YfOPYHW3ARJEr4xLXDbECdQyT5OfflRDQ4g9LDmqnwi0NGVVuSf
         +MWA==
X-Gm-Message-State: AOJu0YyQgH9daF8Cco6T2MC70GpZ2VXq9+PSgI95rUxKNfa5vU3tlZmG
	AiMZOQvUEsCMim5w3PZwr6+9F2g3XlBW3O4taBvAQc3YRgjbJQLf9MV0wqurMg==
X-Gm-Gg: AfdE7cmMjcCDFfpwtGUJpdY1MfuC7hMPqv66nLy5iyh5wC0iJbhT29gocBXmxCTY40i
	mor7QRYjx+uhQIbBqkSw5+I5nuyrZIgMnLnMCvFrQrXMh1R1VO1+CBayFpd8EovIXvCpmLU8FIr
	8JnvR96mQJvc9C+U04pIJktrWNSGdQRWXOlYwxHQZslsHsFdqPnXSWhZN6eT4gXQw5idPWF9SPM
	2GdbiEXNZPVDzrXJm2007zEm9YuVccFR2pHfrz+5uA00m8ebbsUc6DIhfJIzkFByOOBhZsg/b1o
	m7ppcjOL4CiNr62Mql3Q/WbkQe4xraPH+nITEbelLl/S65mFAMAROAU6uAhsiOxn1VGmgVBc72/
	Fwq8gDEfoI2l9XkVDVaGRb3a+7UH/um6C7ZZqG01EtzOpJiVCP6EYpTrigeBu/EgmyS7uR+DI37
	JEXDYLm8mBL+SM2sMZ9S1/kZaqytAd1DombyfNe5OHCMbbUfU0tg8q59XA1ZwH6J0g2IqrfMErn
	jk40cLQTsX3+iEB/FpLu+uAuH3f/S6pva1FahV1KSUay60=
X-Received: by 2002:a05:6402:3898:b0:698:c1d9:8134 with SMTP id 4fb4d7f45d1cf-69c5f0c7e16mr1115982a12.9.1783766393300;
        Sat, 11 Jul 2026 03:39:53 -0700 (PDT)
Received: from [10.228.209.141] (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa805105bsm6342929a12.21.2026.07.11.03.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 03:39:50 -0700 (PDT)
Message-ID: <daa46660-48be-497b-98a9-7784160d9fe2@gmail.com>
Date: Sat, 11 Jul 2026 11:39:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH review-only 00/17] zcrx RQ improvements and dynamic memory
 provisioning
To: io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <cover.1783616211.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1783616211.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Looks like the last patch wasn't delivered, I'm going to
resend.

On 7/11/26 10:11, Pavel Begunkov wrote:
> Sending it out mainly to trigger review bots. The first half improves
> the refill queue implementation and improves refilling limits, which
> shows up when niovs are heavily fragmented like with large rx pages.
> The 2nd half adds dynamic backing memory provisioning.
> 
> Pavel Begunkov (17):
>    io_uring/zcrx: scale refilling with large pages
>    io_uring/zcrx: move RQ head/tail to separate cache lines
>    io_uring/zcrx: add RQ iterator
>    io_uring/zcrx: cache RQ tail
>    io_uring/zcrx: coalesce same-niov RQEs on refill
>    io_uring/zcrx: constify area_reg on import
>    io_uring/zcrx: add helper for deriving area token
>    io_uring/zcrx: don't pass ifq_reg to area creation
>    io_uring/zcrx: split dmabuf unmap and release
>    io_uring/zcrx: unmap under netdev lock
>    io_uring/zcrx: split append out of area creation
>    io_uring/zcrx: move freelist lock to struct zcrx
>    io_uring/zcrx: array of areas
>    io_uring/zcrx: pass area_id to __zcrx_create_area()
>    io_uring/zcrx: add dynamic area creation
>    io_urint/zcrx: narrow var scope in io_zcrx_recv_skb()
>    io_uring/zcrx: don't reload skb_shinfo
> 
>   include/uapi/linux/io_uring/zcrx.h |   7 +
>   io_uring/query.c                   |   2 +-
>   io_uring/zcrx.c                    | 445 +++++++++++++++++++++--------
>   io_uring/zcrx.h                    |  15 +-
>   4 files changed, 345 insertions(+), 124 deletions(-)
> 

-- 
Pavel Begunkov

