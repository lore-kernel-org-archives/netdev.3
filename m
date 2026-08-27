Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524B36605D
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823948; cv=none; b=EJak/Ko3A/tvNiDBKhXFedpyH0LT1ah7QdYohA81InNwl0zg+AlRwxt2/2PAG5jfkro2bj9MIrE3e7Px1ntJUSJgxifLn8pF7UXS5TPyB9e/iy1EX7z2ZS8/iyauY2VpgBIaTF0Uz/bvoLoBie7Bctzn4Ca6P2nhx85cs8TSOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823948; c=relaxed/simple;
	bh=BN52aZkxs+v44pi6lLWDjP7RVaOmarflU8MrGUrYdyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z0S3D2g+QQyPB9nQ9l1UYrTzKq1B9VipFNbbLGkfN8C6inqbJJw+yQEkVAnSSFsYmjfpFG9EpKMzjoMDoQYXtWsquWY6120U9cZqp+1aYlzGjF+Ls3iQsorBtPbPqIoR08taPDYs9CPgXfO7evg3FVlI1tcOYYlok6axuDzUNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6pScdwy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=poNQMtCh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6pScdwy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="poNQMtCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787823945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BN52aZkxs+v44pi6lLWDjP7RVaOmarflU8MrGUrYdyU=;
	b=h6pScdwyJvbg/2M8Drd/1XchB4cChi0fg99CMTrO28Z1MraSmMrz4yVKGG8sdN6r0QTNKH
	ZzJ45GweoBx9rIpcyBxIaglQ4Kg7y/WCkWWBN286xwS8nw1vwmfvMrSTFEjeTIZ3RJWCaw
	9fneDmMLyna8C8e0HfWCNyO8gpoDpjU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-VryNl12gOQuGwAQ0JTKcjQ-1; Thu, 27 Aug 2026 05:45:44 -0400
X-MC-Unique: VryNl12gOQuGwAQ0JTKcjQ-1
X-Mimecast-MFC-AGG-ID: VryNl12gOQuGwAQ0JTKcjQ_1787823943
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso13003435e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787823943; x=1788428743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BN52aZkxs+v44pi6lLWDjP7RVaOmarflU8MrGUrYdyU=;
        b=poNQMtChazOmnb/qspJU0+ZRb3qHDEpEgyTODfy/njEZkMRgtQzpLGAaOhwV/ex1S2
         3dr0EcGqWN2o97syEiraYzS/LamfAp0XSfvkru21LTtfXUaRiS2eM6DmVNLhsSCMZPkW
         bo3llG4H0wuC2n4C6Ei4FS4vCryYmAeOuP0HIz2NvzWzCPBYE6IZjKhusV/Z0DR9ngOw
         mkwWVBVzdGXzXlWUc74I17f3RudzzYuGNP4t1qcXz8eLuZqMk4ekMGc0+IccX1lnT7jN
         D1wasQscTziLrCEkSw+ju/saVdUzt8aLS0Tk0Jy42LW8edBUedJ3fdjCxJMSe2Nk9ipz
         2KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787823943; x=1788428743;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BN52aZkxs+v44pi6lLWDjP7RVaOmarflU8MrGUrYdyU=;
        b=olW95Ffaz8NzK1KjYDx3fdmKkTXIw7qxvdhvLz1slX2vqXgvi1uHRS+LeG71HMdGgY
         l1pZVlATOo2g7B+UGIxsJ/430cD9NywOx0jPaF9roXSM188VwsLMuG3qQL2GKkEX4zio
         wVRfJkmjBvPSmt1NRn1CfUlaY/DnALZY61DRpyVqzHExS41cqvhzddZ1gaXtPSrcxHJ6
         deKDdsPJeL8VEQ+5UKViCpWlTobEGLpIz9vw0BhnADMNAiMX45lD9tRSjKFl3y2lqcZa
         IXhGuI7zZS2hUJSESW9VDavfyJNSqgdKa7RX4a/1Dvx2NbOZZ6cCMDGE22h4EvtiocLr
         p+ZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrk/EXtEkgBN2wCceZyNynN16+n4heXIHu6Hl0hxibOHY8fygJtjVxkz1arSqJEnJFqqz17nPY=@vger.kernel.org
X-Gm-Message-State: AFuF++nr/fDl8Me4s1d9h4QWTU0gwWYJOQk4lL8VW3sVIRSyW7FkLAO0
	I8svusviDWhQ4uUNabjqlX97hhvb4ierNxTCi2JBYdP8qshfYMfnb6xjRSyhWmkCkoq/GCRYEqc
	u0+yjxjcTQq2dl/fq4Xxe0hDZlJsT2x/rCYl2zhbGBsmdFJvie3PYDqwVBg==
X-Gm-Gg: AR+sD13PCkC+tw5Tpab4FMvcr1HEdu3k/68NJbIEXvV5fb4jpAnAl4NRVUqFmUDQ+Xg
	d69afQbEOAoP12v7u96VeRM372bah+VtS7VUIyyTEARQ7/ur2LGcBuBIUfFZ5T8wkq4JBbyqTe8
	towbrxzZO6kPK+qHdBVWc2BY9WyVROQJKJH0n+XHwgKj7c1FV+8ATtsVAu3a/KQAfTxvFuMlRqP
	YdVhCNwb/rPwj+OY/9VvCpxnT92S9A0WLKr2k0VspT3hCVITH4SBNKD2jKrrnYjqbk2uFs89oNQ
	DIhcbqvSLpxHiAvWUCsWghNt4vWzj1fCL4/nB105C7H1wTDQo47A4HssjFJA7jL+CKlS8k+h64M
	aWuNEXd9KAR65PWhXUJI42tecmbt7+emqaJFHULiMdV1EnkUu7pAas+C0RNxJSHJHo4Ucn/Q=
X-Received: by 2002:a05:600c:6912:b0:499:cd34:100d with SMTP id 5b1f17b1804b1-499dc703bd3mr170350285e9.7.1787823942892;
        Thu, 27 Aug 2026 02:45:42 -0700 (PDT)
X-Received: by 2002:a05:600c:6912:b0:499:cd34:100d with SMTP id 5b1f17b1804b1-499dc703bd3mr170349585e9.7.1787823942453;
        Thu, 27 Aug 2026 02:45:42 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b0dd3e148sm32580715e9.1.2026.08.27.02.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 02:45:41 -0700 (PDT)
Message-ID: <7d2a4e1c-ef53-46e0-9290-e70e6529216a@redhat.com>
Date: Thu, 27 Aug 2026 11:45:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] net: phy: air_en8811h: fix LED GPIO not surviving MCU
 restart
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>, netdev@vger.kernel.org
References: <20260823130638.1166453-1-sochnev.v.74@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260823130638.1166453-1-sochnev.v.74@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/26 3:06 PM, Vitaliy Sochnev wrote:
> The EN8811H PHY's LED GPIO pins are only ever configured as outputs
> once, in .probe(). Every .config_init() call after the first restarts
> the PHY's MD32 MCU, which resets that GPIO configuration back to
> inputs, so the LEDs silently stop reflecting link/activity state after
> the first link renegotiation, ifdown/ifup, or resume. Patch 1 fixes
> that. Patch 2 is a small follow-on cleanup enabled by patch 1's
> removal of code from .probe(), kept as a separate patch so patch 1
> stays a minimal, clean Fixes: change.

Patch 2/2 is net-next material, please re-submit after the merge window.

/P

