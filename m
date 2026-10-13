Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7432E2840
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887163; cv=none; b=VHp0RBCfIlUQtmGcSOqjASe4upFr3euH+8ApFUNz5a8SeY97xnZsWWv/ZhDyUvQS7zoKw/duvZOK0xpE0JBK8QaiepGrozPJZ5hjOlr4B6aren/C9eS54ecRX1jwWbKQCOlV6a6Nf9YUme8Btb0N1tzBJrYZA53eMiWHRLHRsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887163; c=relaxed/simple;
	bh=PhWspvxUuZLK/No+wIlELtNHkbzGGTAu7GurynbRvAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMVIR4xmRQIqohmBF/skRZyGvGfFtcIga8ZNvsur5VCECrUdJKM3sdMHzHa9Zq3E29nkJJ9lj1hzrJrFPxj5UC/lwtneRI7zXQJ9a2UllWdYdM14Ori/6yXBN5zGkbRjQNeee7djjqTrc9B1VODu5gQAuE19hF1Mj7EchP2TFGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cilTQx4q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgFZmnlQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cilTQx4q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgFZmnlQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791887161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stdrh9aF0iw9A+RkWltj8UJ89an/ArnFlZdr2jPOwoU=;
	b=cilTQx4qtpoVuJZszoU6WnqklSFFYHnji3PXjH523Cw/zlKugEBrXiIfHNqMcet8Fps8Ul
	F+NE0LR6o+EU4CYeoqBi1jFvjWafqvtcqBiL+34LAdrHFcitqIBfXtGJ9cwNJh2D4UWEj2
	omdtvJZFRy7xQeAebSOwng/WKNIC3z4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-toI38SFaO3yWgw7sHmqa7Q-1; Tue, 13 Oct 2026 10:26:00 +0000
X-MC-Unique: toI38SFaO3yWgw7sHmqa7Q-1
X-Mimecast-MFC-AGG-ID: toI38SFaO3yWgw7sHmqa7Q_1791887159
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c50ed05abso2571105f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791887159; x=1792491959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stdrh9aF0iw9A+RkWltj8UJ89an/ArnFlZdr2jPOwoU=;
        b=IgFZmnlQKP5OyTeeo9RWnJO+GgaBZRKIh3xjgAHoBktNutpzwFmZloBm59Ee80f1WS
         5kGbdehe6JwyOkHKmegRwQ223OqeIpIj6oJqcgSe8wOFYtHpYifefxAcJrojq2Feb5qF
         7UGFwn9qtE7vIbhPDosgw6/A4lm1nOX/Li6QKti7TsFWCSgZw1u9OTFF9MEPliNWftmy
         ryKH7sdNpcV8Sk3Ed0vhEwYFQZ5fRhUo4FgonChYdpXhFvy2HCSNXnYtDTcQaEkiJ0pB
         fK/lvf1E8g2TnbXIfxIlV57XdMMKQ8zdtRANSUytypKZ0b7szIGiIHskoOWF3Hj1ePj4
         Ce8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887159; x=1792491959;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=stdrh9aF0iw9A+RkWltj8UJ89an/ArnFlZdr2jPOwoU=;
        b=IXVcYLCUXiz+hlI3MipmfsqRY4InTgwEJoLUV18D9vkrvxl7vXzNYn7bxmf261Fkb0
         3QB1xlhOLSyITfPuah+bjrRDK4Mvozve5jogL8E6NU3LhRbrsndcYsCzYSJj5wvknkU2
         2OQhxa8p79j1vP0SxWuwmLeMu7m6jeVtGfEiLAK8U1hZat7cr6KQGk1SEwh8uDG32fv3
         kSUQ2QOXywht901jB4LWscRaW3PBKcOwZDOifgJj+NKGFW5rWCT9j1WcUSvpA7XmFyKr
         Oal2VvsekW1vSMB4RUL1AW/d1SLn2OOY3t9AQyJdXmsf2OJruuOBL275bZlbt2d4+7kl
         gGIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkNOBPwfLBWQ7FewOK9Fd8PkOo5X+ZMm8t1PibPFiF6rsO9sR7YjIWL4nO2vT/mw6DFmyWoZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLn9xBFTnjzEw1YBe+f3ySdi4HCi6diGmWl+WWNI5A+2bXrveOx
	yNPfuzb4YyzJV4yPZw3R54IHBzRGinvxDKjGGkabUVUg3QsZbWsEGtyqJq6e0uN8NfR+7QiaWAO
	ymgj12B+6oJD9StVupluo6uSKdIHXPtOigLzgRo/tzkVn2Qu4mt2ZONXcRw==
X-Gm-Gg: AYBFou2gzxdqbSqr2vUb61j2TOKkQw/lvCxmvmxVeNZcjQnxRBhH+Y0/D26zWjwWy1f
	4xJMaGAQp5s1KM0PYJNw0A8wC4QsfLbf17aI9Vh87kMdJ668Hxff590Aix07RDZ8iF0BsdlCWJN
	NWeAtlr9BkyPL2AdLFw50kXFIeVeYwkoY3uj7an/OQPOpc/eTmXIqIXaVi9ZRq0HrlqQUCwyD1f
	DX7Tixnw+Y+y+10D1H1thDsGoPKGwB8n7j0pTr9NUnNCVSnIStXImOAqrPZwWllD1rYonBXWo9p
	1x1SgsgF7XnTGADKMXtE7yJOnhWFoo1PAVFBvNQV0euGLVtqYVUJuwPOIWD2ZXDB//y/KSnTA5j
	LelttSEx579sjd/1rEyEpu7PFYkAlNDsBVvONe/p/szYM6QT6SYVgDDM8MdXqxd5D9WAh/er0sw
	==
X-Received: by 2002:a05:6000:2913:b0:487:834:9307 with SMTP id ffacd0b85a97d-48dbacf06d8mr24662185f8f.50.1791887158568;
        Tue, 13 Oct 2026 03:25:58 -0700 (PDT)
X-Received: by 2002:a05:6000:2913:b0:487:834:9307 with SMTP id ffacd0b85a97d-48dbacf06d8mr24662145f8f.50.1791887158105;
        Tue, 13 Oct 2026 03:25:58 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5af7sm4525045f8f.31.2026.10.13.03.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 03:25:57 -0700 (PDT)
Message-ID: <43857d08-c4f4-44ce-a0b3-0e7fcc56bf90@redhat.com>
Date: Tue, 13 Oct 2026 12:25:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] Report netns cookie in FIB lookup
 tracepoints
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org,
 dsahern@kernel.org, horms@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, daniel@iogearbox.net,
 petrm@nvidia.com, ferenc@fejes.dev
References: <20261008133158.1438907-1-idosch@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261008133158.1438907-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 15:31, Ido Schimmel wrote:
> The fib:fib_table_lookup and fib6:fib6_table_lookup tracepoints do not
> report the network namespace in which the lookup was performed, so
> lookups performed in different namespaces cannot be told apart. The
> recorded PID does not help either, as lookups in the receive path are
> performed in softIRQ context.
> 
> This is a problem, for example, for netns-aware tracers [1] and
> multi-ASIC systems where each ASIC and its ports reside in a separate
> network namespace.
> 
> This patchset reports the network namespace cookie in both tracepoints,
> as commit 27cb3de7f43a ("net: add net cookie for net device trace
> events") did for the net device tracepoints. This allows filtering
> lookups performed in a specific network namespace, for example:
> 
>   # perf record -a -e fib:fib_table_lookup --filter 'net_cookie == 12'
> 
> The cookie of a given network namespace can be retrieved using "ip netns
> cookie" [2].
> 
> Patch #1 reports the cookie in the IPv6 tracepoint, which is already
> passed the network namespace.
> 
> Patch #2 passes the network namespace to fib_table_lookup() and from
> there to the IPv4 tracepoint.
> 
> Patch #3 reports the cookie in the IPv4 tracepoint.
Not intended to block the above (could be eventually a follow-up), but
I'm wondering if you have considered adding a `net` (or net_cookie) field
to the fib_table struct instead of passing the net as an additional argument
to the lookup functions - AFAICS the latter are also called in critical
path and the additional arg could be unneeded (very small) overhead.

/P

