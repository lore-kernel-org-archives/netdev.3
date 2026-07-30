Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083F53F65EA
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408155; cv=none; b=BjA8yJdIfDViExW2D1ltsl/jOIzhYy1thxVQuBClSQT/kLSFq/LQNluzBMPoUUnx2Zlcr3wiA5CgPqypFjqKE1rO48Jg8SquF5Nf3JuJzMWe6p2KIa9v6NbSTktD32A5CvaX6C2NSswT2X/qVknf89+suYQHv3pIVy42Cwkdd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408155; c=relaxed/simple;
	bh=bfrQOiVQvTUnYFy1FSie5AqCT8BOViyPdm9hFUwKUno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tw9Pp+fcX1zOkYu1wO2PFrZdW/teBlqSmnuDkvygnwcEz33aLjm3uUYt0Mmg9ppC9M8BG5aOoo5PWa7ZhVzXnwRD5XqiJnWNlS5w/I3kCdsWtEqoRxZ9e6uVl1S22q5j0D1N8TQPll7NXl2ysXxRPeSge/LiCp770HlqG3eWStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKhXWHCP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQ/E7tzu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKhXWHCP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQ/E7tzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785408153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skFtFcwx8b5l2wacD0WV/S+9EulcMqhDFXk5x/epEsg=;
	b=aKhXWHCPJbfz22TPjjIuekhxgzme2PUSRYHZZ9z4yIj4mVXRJZ9FKZnA5UDdKbdwrbpmI0
	wmQoaf1W21Ch/urIsJ16QQ3KnHnSmqkYPooKPhB3wcd/kcrxPE1qLkcmF+vCb2CMWpCbVq
	sLIrIR/NxdV5HRfJkb4oN2nRI+kTMpg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-UVZePJUBNtCSdWgJqCdx0g-1; Thu, 30 Jul 2026 06:42:31 -0400
X-MC-Unique: UVZePJUBNtCSdWgJqCdx0g-1
X-Mimecast-MFC-AGG-ID: UVZePJUBNtCSdWgJqCdx0g_1785408150
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f7039fa59so1728761f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785408150; x=1786012950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=skFtFcwx8b5l2wacD0WV/S+9EulcMqhDFXk5x/epEsg=;
        b=dQ/E7tzuBD1IHilev2QpnZldyjBTzIatCcZD+AFTQSd4NbVoMit6K70wPF9tfKGqXt
         pwU2fq2f0H36AR2DQ7izbjnn3+pKP17OqW0m+j8ccazdJRAqs8a7q9x2OfIr68K1gnhM
         OLZyoZfmUprOU3S8GsU9Hlo55N0vGrvMXahL5Wv7jaqSz+fFYs6eq7XQUnJe1Ip1IoQ5
         bEjMsL4emGYI0ubZt9hM0NDUncJCwHG1o+BD1j7faa74Tf2tWNduDSKl4t2YUjEXba6p
         8ewZ7L/aKYicMtbuJY/Z6TwbUcBEQNxiI6DWSHcCjXIuxs86aE8/BlxYdAGriXje4/wq
         xhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785408150; x=1786012950;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=skFtFcwx8b5l2wacD0WV/S+9EulcMqhDFXk5x/epEsg=;
        b=KLMPJBHqxn5iEzJ1aKQjiEeqo5ngIT3/tUYNut50l2hAEvAw9QgV4eWOGVrpjhQTE6
         1ECUvtkKaTi1ffINZgTb4wmvV3z/gWyXERiMOICoI8X5r4gQA8IVkUAB7TWCfazHzgq3
         jdDk4n1UT8cog4hHDZ3kOB8y6qcFgIDOmI4HTgYa8lQN02brxsc0s89nVoSqCvkqy02W
         lR/KyZuXYUWhDe8QZiHbvY4lAVLTpnftS4yve0qEVPXRYjeLJb/kYspLJMK9akveSZtj
         GATIPNsAor95g1wZ/XjwklbyxxynsQlQHa1LyNpBy+N8F18mnzmnavPdM8/L+ZwR1+UF
         eCog==
X-Forwarded-Encrypted: i=1; AHgh+Rq3dklTgAz5ZD8k4dlOyitW0Ko16SaI8dmvxWSGpqugnT0iLkUN4uz4Ltq4O9swiAQu4xXj/q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXEZ1DBgRbMGlQyl2ljiINFj/GJCHU413CDSSx0B73X7kmgzs
	F/y9FjGEj2igm0kS7d2czas1LMCE4YhkZUSOZV+GFAdURH2aL8zgPYcZw6CXlEuHadY9f9fsFPJ
	uOZqVWHe6DNLdVtQcf8XvEoJz5so3b1QvQZYdUjp7bucGGIdUYIgNhmGaOw==
X-Gm-Gg: AR+sD11ayGZ5KeuaBJVuiS9aaRvspM4bkY06xWOH14KTcZ4b1rtvV8JeToI1n8wpoK0
	HlRFZ8bGOeeT26cOq+1JuLxcwBRLxkgXhG0F+Ene69xeaByYcBwWRYLcPx9EHTd0X68ret/2KNs
	ZZSztaO90rBCDiMNZ42QieOHZmQWdZkf+uOOcObWjKYs7HeytjljCKsURs+MRpXFtOqy+eUQ6Sk
	OJ86NKM3qXg0gBID/ZQ3wqoiyLxN38r7ARyKijiYX+PflHz5np5eoNCfgO3/zoEWYLHVLIP5Wx+
	P2tF2Hip1zeWbpID6OvwWLS1Bi9RMBRMGIa0adTRWTgPzoQxHOEtj70i2UL4JRbLcXXDBu235fH
	uril9koZlp+lDjl7R9sU9HY1bqIzA1CdLCzh77t+lFO670KR+LTy9kQ0pYRJ+/kiwa2kSq2ZRRQ
	zGfw==
X-Received: by 2002:a05:6000:220c:b0:47f:9629:b897 with SMTP id ffacd0b85a97d-47fc82003f4mr2694939f8f.49.1785408150171;
        Thu, 30 Jul 2026 03:42:30 -0700 (PDT)
X-Received: by 2002:a05:6000:220c:b0:47f:9629:b897 with SMTP id ffacd0b85a97d-47fc82003f4mr2694901f8f.49.1785408149758;
        Thu, 30 Jul 2026 03:42:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc892cc6asm5740715f8f.18.2026.07.30.03.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:42:29 -0700 (PDT)
Message-ID: <de7fda89-3fcd-4e01-88c1-74e64479759f@redhat.com>
Date: Thu, 30 Jul 2026 12:42:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/3] net: dsa: motorcomm: Add LED support
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260726162731.1005803-1-mmyangfl@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260726162731.1005803-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/26 6:27 PM, David Yang wrote:
> v8: https://lore.kernel.org/r/20260725045008.858692-1-mmyangfl@gmail.com
>   - limit the led port number
> v7: https://lore.kernel.org/r/20260723195335.806002-1-mmyangfl@gmail.com
>   - rebase
> v6: https://lore.kernel.org/r/20260709014812.1158178-1-mmyangfl@gmail.com
>   - per-port initialization support
> v5: https://lore.kernel.org/r/20260707064752.1030345-1-mmyangfl@gmail.com
>   - improve trigger selection
> v4: https://lore.kernel.org/r/20260703165241.542195-1-mmyangfl@gmail.com
>   - fix some reg op typos
> v3: https://lore.kernel.org/r/20260701155519.273212-1-mmyangfl@gmail.com
>   - fix null pointer dereference
>   - support polarity auto-configuration
> v2: https://lore.kernel.org/r/20260629183137.541341-1-mmyangfl@gmail.com
>   - allocate LED structures only
>   - eliminate double locking
> v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
>   - set up polarity correctly
>   - do not set up .brightness_get() to prevent dead lock
Please note that the cover-letter must contains some reasonable
description of the series, beyond the changelog itself.

/P

