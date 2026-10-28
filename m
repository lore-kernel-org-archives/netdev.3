Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200365;
	b=YNqXbXZBTGNEQYeGDxyprz/z/onx98f9cOSa3TF+wsSGUZrOuqpa/UQwj14G8baWaXcL
	 8QTWHIPPe4smUW8kHvl2Bon2pvYEPGRxwpzmjJLBIuLbEOVZ40ft90yuMSUAIDhVUZbXJ
	 +Ct/WsURbhLW8V2ZxwtbeREHKSRB8bXgwarKFf9HI//Sivbzs3K2qy6hwFb6lWj+Afxar
	 F9enpM4iyMNNqClvfjNFMmsyfMPmrKkhOyIeg0QGN0Lo2PMG9ARx8ev/P2omqLhH4wYPg
	 sbr9VXrU+X5c65+Cym02fnJt6IwpvDOUhNIDy57ZN5J1GSjheHsYIhtHmt7Qf1Jl0Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=C5xQd1xIwUtBJyycWD3+XcISdDlmOWmJGD2rjg0it4c=;
	b=AdTaPnVMpngI0rQxzc8Wki72ciEAG0zVJoXPwlL30skaGCu5rCZZVYl3Cdm57IHkO1Ii
	 6BLWcdghMqPnt6PJyZPCxVxZ0hQcu1Hd9hIoE/nX3bSOn16acKaZ+sBWMsXncgU5aRGy3
	 BJqKxD3Q6riUZyOWVrGY1PmZqwoZB2VOtJWZ3TW065mHqyVnlY7AczaS1xY0XFEXflciJ
	 iqN9TeYSEUGy4PPnNBwBNMprK1rQZrBnyJP1z6qRyO7wI6uaUwZT+DElg55VkaPueSmIs
	 16JcWN3/ySygd9YZaWYmN0g78DIngY2xHZBJtbNcL7nl1bbuY3DdjQ5D6rT7JNSukFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m03FeW/k";
	arc=none smtp.remote-ip=74.125.224.139
Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E22606A320
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49E22606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m03FeW/k
Received: by mail-yx2-f11.google.com with SMTP id 00721157ae682-8b170e27cbfso1533497b3.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793200364; x=1793805164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5xQd1xIwUtBJyycWD3+XcISdDlmOWmJGD2rjg0it4c=;
        b=m03FeW/kbbVO+stnbit8ASYFjId3lG4TSvHhfOXq3a6uw8L9jO13zltFNWD7EK966I
         Aa9AxJf62YvyAd/5ADLndNx4MXyVvZQzIFdmyN3U2wtCIwWcSq8dx8Wfi7gpnaweyjQ0
         vSY5dxW2nQq6/dyCYl42nl3ut8l3w88C8sgtFCmD5PB1dSOG16NvtzU8Hjq1/pRlWWhe
         33+GBGQhf3CRVe4PaPwAgpMvbiSyMSbRG/JG7NtZHq8eCRlvlNK59njb3AjJ5gre6YE+
         4JIj28Y+tRI045M9MHlUIMVL7d8A/2xSb1IcfrGmyUGrXynTSR3ENyGZcRKSYMopBxOf
         E+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200364; x=1793805164;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5xQd1xIwUtBJyycWD3+XcISdDlmOWmJGD2rjg0it4c=;
        b=R0ja8nSNaY/nb1bcxqNgSCkpT6rbodfqK8R4wdRe3UMqdR8p0cCI//E5YST0Ea1J3v
         90TD9zgphektMZmYNtfkAVGBjhj3Yj76/K1fvbWirCykYecAmzM+25XiqU2KFkT7AMgw
         cc5T4ycqTRL4gJfsuyQfkXi4T2Zaeom/VIwOw4Dao1TAVNLXwadVX1SgGovRFkdkNsTb
         MPFlmT4yKRGomDj8TGso2Gyw/Nq145mILgX/V5I+Ohfts2rvtwvCnSvXZxEiq6/0YNkl
         jn9vz7bQ/dORyKLYg+zs4f50A2kFlG6ktyrSYGaKpPWjjCzne3twve4p7dixHLxGRInn
         fqSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgYpeCqjTZW7YKwtuWL/TuOfjC5431LK4zE2KvVliivv/WxTpB54fFq536SaPvKAY8kCMhBRQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIoO88F/qmjThMcksFcq6Ml6WWynfnNtxWifszvKimLRCNqzgJ
	HzjerqJn3B629CRf67CeDX3DFyZLMqOAnl5LBHaoX3eyR9RGijZHzzl/
X-Gm-Gg: AYBFou29FKi+upUj2hmJDrbQsV/XgG0IWPk63LNL7WeGu1WGrx5pFNk19If52s9/kTj
	dTwMyiS+qWkPVviARnPXod+ooXcDaR3ptqb/DcDJEqi4RSPijOzUTs/v2rZEEg6QGJYecsJV+qA
	3mtMuwg2dMV0mVqu4H9cMiHfRNr0UCfBT4cAh5Xr76utKMCHewzJgMvSNiAxAHaTyhFuFHOst0f
	s5cY7IZR9lXSJLEu9i4EllWhggVVc/37A1NrmxJixPN5AJ0dn8FTR8i9vlFSow0/pLNVWygsxiI
	GkX0r237L+SfZdWOwhVXAcxdaynOiAXG25cuH/58UYofpRCCgbzb9Vd5NSF3lb6zeZNe5iDEePh
	76qegxyRKfzgIDVk8nI9/qKQWDsaKaajkzeIzoM7lX0+LjSjv8dEgCvx5eu7VjNHgF1oOarV/qi
	oQCJFJDLqjEvs4LVVnNUgAe5wOqpwV2fjS7ajQOrV6rFsN7voTIlZghJItIXr20aEsGFokoLXNQ
	KBSlZk2sLrKptrnlrD0h1vTkfAu2Ljf3a6HPzBfRdORnnrJMC87sOijEITkZ9g/jNITQpbBfQ4p
	KgS6tI8H/q/SylOaKqIRMRUMb8QYot5nNKs=
X-Received: by 2002:a05:690c:386:b0:8ae:dfee:cd30 with SMTP id 00721157ae682-8b1b5b457ffmr18430047b3.56.1793200364364;
        Wed, 28 Oct 2026 08:12:44 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e539e34sm29934517b3.9.2026.10.28.08.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 08:12:44 -0700 (PDT)
Message-ID: <e674379f-819f-4334-99b2-7b8dfc89d1a0@gmail.com>
Date: Wed, 28 Oct 2026 11:12:43 -0400
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
Subject: Re: [PATCH RFC net-next v2 0/5] tls: perform TLS 1.3 KeyUpdate in the
 kernel
To: Chuck Lever <cel@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>, kernel-tls-handshake@lists.linux.dev,
 linux-nvme@lists.infradead.org, Alistair Francis <alistair.francis@wdc.com>,
 Martin Belanger <martin.belanger@dell.com>
References: <20261028-keyupdate-rfc-v2-0-eb5143b4c487@gmail.com>
 <76ccd502-f1d1-4135-b92e-d783f259a687@app.fastmail.com>
 <3544cb56-e43b-49ec-aa94-beafe061879b@suse.de>
 <CAPG1HMsnUDa=Q5O4fwZOU=Pd+m7ahzu574Cs+mWoB_9KUT5ASA@mail.gmail.com>
 <097a2d7a-af80-47b0-b800-238396e6e662@app.fastmail.com>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <097a2d7a-af80-47b0-b800-238396e6e662@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/26 11:01, Chuck Lever wrote:

> 
> I get that dropping the connection is bad; the current weak-ass
> implementation is meant to handle KeyUpdate until we have a proper
> spec-conformant implementation.
> 
> My concern here is if the current design is malfunctioning in LTS
> kernels, the only mechanism we have is to fix it upstream and backport
> the fix. I don't believe stable@ would be happy absorbing this full
> series.
> 
> Your commit message claims the connection stalls rather than getting
> replaced. If that's true, that needs to be fixed before this series
> gets merged. Can you confirm? I don't expect such a fix would be large,
> but the ordering matters.
> 

Yes, for nvme-tcp. Since 6.7, tls_sw_read_sock() returns -EINVAL for a 
KeyUpdate record. nvme_tcp_io_work() then stops without error recovery, 
and the queue stalls until a command times out. Only the timeout handler 
replaces the connection.

The fix is small: "nvme-tcp: start error recovery when read_sock fails". 
I posted it on Monday, and Keith applied v2 to nvme-7.4 yesterday:
https://lists.infradead.org/pipermail/linux-nvme/2026-October/066937.html

The queue now starts error recovery at once and reconnects. It has no 
Fixes: tag. I will ask Keith to add Fixes: be8e82caa685 ("nvme-tcp: 
enable TLS handshake upcall") and Cc: stable, so it reaches the LTS 
kernels before this series.

I have not checked sunrpc. Does xprtsock replace the connection when 
tls_sw_read_sock() fails, or does it stall too?

Martin
