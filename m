Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE8244A3F5
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036473; cv=none; b=XJcM1kjKBkSBlMDIW6+TFWJFg/3xCDjdZ5Zz2bvRS1iCY2JWeZJ8kAiKHH7BzgdtcWgfNhKKjGzP2JLgunAHg6QmynMTiYDczcZPi8wOch1GO9sWSHwXG9e2O0by5Bi88v8CdTgXzG33lco+eWt2Db+U1ggrtT4Keu3pbww8qTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036473; c=relaxed/simple;
	bh=Zdd+b30LqWjeU5kAibT7iNyGDkYXxxfetYFIBAwoZmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLlmmSyHZA4bUgdLKa9kLT0j0IqQV0Bv14W9BfQxEDy9fAw3OvVDR9R+2rkworf/CZS1C4Bv7RD1NPpZywOBPSm1e+i6HMzSv+L195JfaAG91pJmgpb0EBeofO0DbwbhB56xDaRsUMMXS3st2eMfjcvg4e2yOfmMOSG17TF/VHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpAoo9qU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfN462vT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpAoo9qU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfN462vT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789036471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3uWqRxAvQaYFghiDJLdTrTqStP30DYquq+QzgHSX+g=;
	b=PpAoo9qUCpCvGgaLZ66LW+2b99gu1iro8UH6iybPvhNzAA+cmN7NqQ4nTDSEeXunoqiIXC
	4ZaDQaiuAVpm3mSksnODxwzK9oLXnLo1HuB2zIfF5NfUEX3kECg1fjAF1XwsjQKZAWBomV
	DuAI/vQaC1+idbWnfv27cta87vM3wvA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-2Xakd2WoM2uKSRIFuvZAbw-1; Thu, 10 Sep 2026 06:34:30 -0400
X-MC-Unique: 2Xakd2WoM2uKSRIFuvZAbw-1
X-Mimecast-MFC-AGG-ID: 2Xakd2WoM2uKSRIFuvZAbw_1789036469
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccfbe060aso47858255e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789036469; x=1789641269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3uWqRxAvQaYFghiDJLdTrTqStP30DYquq+QzgHSX+g=;
        b=HfN462vTqSWRGFNY3QyFN7fuT44to2Hl8IYgohc7xOhapRgSFGglW6eKYeKgjI2Z8I
         b24x0s2R5LNxcqHJvRrPgaxSJR43wAY5/jaLzGbySV2VSbn74dKuAzJCkWe3TRsrybed
         4zC1knKdKDmSsPynY1wKCOEQ16EEfFaJOcEKJLDjHs8j4aTdbcKzqRby6sbNgvqa/RFT
         6KkhBwaJSkAz7ZXxkqMwSX7zDP+CippQO0YIpOzYf88PZHCZsP19WqCtR3+0Nps4yVbx
         1M5D4KXNCNWsVF7x1vNGGoCze8grjtXzWQhhY0RZCYyCvldewGgiINs6797Xjw/KW4Gr
         eO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789036469; x=1789641269;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3uWqRxAvQaYFghiDJLdTrTqStP30DYquq+QzgHSX+g=;
        b=VHUgSEqZq8OWoaV1XSwuUhd5YKp89LD6Acmga5d/HpnVuvHIPFv/1BjP2DCMJPeBfZ
         xrrkeXdARgUEwMyFZy34+XFjuQ29u7UYu1FCmByRZHL652wafROcNMmXsVQVDyYRU5Od
         XgxiufD8vZ0y+KApNFle1xu9TJXgkr4Vz2Jwg6HdswubKJQGPVMA2aUb0v/HAdu70ZEB
         cEB1/Ye0f+leuuWhj3Ed1cz/MnGiGXzvoarASXvxjo5Qb4CEsNh3jnrxzC5BLBMfEla2
         e02KiX4c3RBuoKgYNuVE1cDuqVj8kUXiGyjIAXmiw5azBUNEmKgplsJhCS17vio4Ua1q
         rgFw==
X-Forwarded-Encrypted: i=1; AKwUvBw2zo+5iOvda3oZYbZINXiErEgVZfa7FOf6Y9AbAKDKEYtWNUg/RTXwqv1rrbq3AtFxIEnYyZc=@vger.kernel.org
X-Gm-Message-State: AFuF++kbzXXKI2Uxa253rzjREvJdVddqFZcv+aWFKAZs65T+Vrpi3Xyp
	e6MM/zCACDYTHRDLA2JPssr4dsRJMm33ooI2oqo/E0uW1GJXNnGZQ/gNuBQuSn8E1NXalkd5nH/
	7DuHxzQkSvCsa7rmqm0ID046go3Dg1gfUad2NzF4hpBxXK+bZAb8qyihIoA==
X-Gm-Gg: AYBFou1p7ke7syaWGzqgHb6RnfJ2Tg2nJKJnl7dzBPar6b3mHc0UkTJ5xJHwDcsXNbi
	VBPpgASwc9MgsTIW6hfDatFbmdEIop4Y5gIS0wdHB8JSe0hLZvdp8+EnorocDae41n8l9408V3L
	QZPN3hWjIb9nAef/ZS/dJFHl8LV4HakycU9a7GFcI8wiaCG0xCUNYhq+jaUs5EMa+E6es8B3Nf9
	lF/9UUYrmkA8vQZjnM4+T2fBee4fxkZXHbfYdw5U/Xh4T9jm20UwFF3bm6YQ4VewyKAfHKdVBFM
	xD6xnLfiMnJ6YL6Czetzk/Ka7/d8dTWgi5PF9X8pggoHUuCS+Mxh/rL++SMfA0YYTI3vkZDhcPn
	B9U1KyR3rthazTzpD5v+ZZAwMRl/i3/uM0Eff6BNpDxW365pl/1nFg3AacdRjrOVXb6SQFNyO8w
	==
X-Received: by 2002:a05:600c:b86:b0:49d:260c:a422 with SMTP id 5b1f17b1804b1-49d260ca473mr48734465e9.25.1789036468862;
        Thu, 10 Sep 2026 03:34:28 -0700 (PDT)
X-Received: by 2002:a05:600c:b86:b0:49d:260c:a422 with SMTP id 5b1f17b1804b1-49d260ca473mr48733565e9.25.1789036468186;
        Thu, 10 Sep 2026 03:34:28 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be3e35sm62375945e9.2.2026.09.10.03.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 03:34:27 -0700 (PDT)
Message-ID: <2eedc45f-1548-4784-82e8-732d1b4b743e@redhat.com>
Date: Thu, 10 Sep 2026 12:34:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mxl862xx: disable the stats poll on
 teardown
To: daniel@makrotopia.org
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <8b861014c836377afab0fdfb66a83fa017e5cd84.1788779062.git.daniel@makrotopia.org>
 <178895415193.219967.5342143627576620914@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178895415193.219967.5342143627576620914@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 1:42 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1 (1)
> 
> - [High] Stats poll can walk a freed dsa_port list on the DSA
>   registration-failure path: mxl862xx_setup() arms priv->stats_work…

I'm under the impression that the above is real, but unrelated. Still
I'm wondering if it makes sense to address even the above in the same
patch/series?

/P

