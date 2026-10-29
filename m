Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269470;
	b=mI3eD0N25FJDLZ3G/ZfjM+xJP8F5rY65v72W3rV0bQJy3V24Zz7f9opeNfTwUok0EoWk
	 Ep/Esmlp1nIjYbORV0KmtGJ4qNgKd0ClbuXzM0+TSP0sbLSaC+ZTxS7kVXV5m6DyofqJ5
	 JC3pVcVOFpeu3kegj3uEEsnnZww+GFlzJJNLG5i+oe7Ml5iLdqgDDNcD+ILZCyG8pLO+T
	 u1MXiMYvvOhByYh69Dc/qW/ao2I7YI31zlO37jMNJHKqzL6f1+cLT3fYDBQBRd53PSMjI
	 YTtrI/CYOPam/QodKbJ0xf4b0o4hN5QPThLHFXv3rd09j74kaUvLWIihaCsR1cwnECQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269470;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=foACqNTou6WaxjVswdP0rg9NJ/Jpun+aF/kRBHAU79E=;
	b=QMSgSSqzsLbp9UIR/PpOtTNkhPJ0wq/46djTaV4K1QnauPOFhCLag0reeYAy3YK3yVPu
	 9PlD5hhUDGGOUjbELFbLvHpHVcg013ftMnfQ949K+HQ4TLAyo7Al9tBjt8tcAi3/zNvPd
	 tsFg+HFpvoD6ama+lw9IWCi1I9wQTUdzhRXcusX3XPvn7TF/XalmXDjCqc5Z6C2/YezcJ
	 HivSShloLzHQQaqc0+VPR5QGvIuxHzZ56VIBmnlHX32BJzAoRBM00C9HDfE02yKPh678w
	 /CyfhTW5yhVZ/LrZ+ZzDn/C4uY2GlQAes2dvgue7odhucvdCbhVX3dlrhSqeyPK/kfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVHeQ5xu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U0QCF0NH;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D3606A322
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F8D3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVHeQ5xu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U0QCF0NH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793269464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foACqNTou6WaxjVswdP0rg9NJ/Jpun+aF/kRBHAU79E=;
	b=fVHeQ5xujY1im3YGkG724ck9iYIDYAeI3QwFTKAS7Uc0Oewq59NxnI+162yG2ZjnH0V4du
	QwMK5N+A28c/X+nN9fPORbwkr8iN8N5Tl/RTXBnYkbmV9PmCdGGl7ruzo5ZevZR2jaSGDc
	mK1OybVtbaiGnUfrY+ngPcpXDXZIm9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-eeY2TEnnPrimis3pY9OokQ-1; Thu, 29 Oct 2026 06:24:21 -0400
X-MC-Unique: eeY2TEnnPrimis3pY9OokQ-1
X-Mimecast-MFC-AGG-ID: eeY2TEnnPrimis3pY9OokQ_1793269460
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c430f0f01so1627185f8f.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793269460; x=1793874260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=foACqNTou6WaxjVswdP0rg9NJ/Jpun+aF/kRBHAU79E=;
        b=U0QCF0NHNwmseoKO1ccCw6zFVqKtN3PwI0CAkdhsK0BSNj1JI5uNdJYsA5+toiZ4+I
         zABX4aRqZBmQY/O5CmgkeH9AsC11+DGchomCsMBt7qCxzmuL1Lmu9b95v4jGegtp3G+S
         mKmHvGmDk0s0/qPxB1g9lGh7YQ/bQwfwHmqjHKTAiLGrjHViQF5xd9e891tenpnVEYpw
         iafYXTNKIxDsCNtPZcLkCW34qr6qJej1kvrpNocTEVfbnG87g4Gx00adKSQCCamXaH9+
         mZNesZIXgWUEdJsIUzQA6yzWruXm8hHRgE8Bzr6GWr2PM+3P5stgDO6EalPNgOGGVZd8
         ck/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269460; x=1793874260;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=foACqNTou6WaxjVswdP0rg9NJ/Jpun+aF/kRBHAU79E=;
        b=fCsR602iOfKrB6Jp0AkO5YMNt+QxZ+NkCZ4TLQQfH0g5+839CK1gqcJObHzftZ5ipB
         WcopC4IrKYpjz2CVbvW7kf+PXd7OWKKV3MUvqwu315WvvcdQliWdD/0XshUI+CEunluk
         X3bkFZjyxkzDNk78SAPq5b2GqHzCUkC6aLqtTUdLHt5JBcYbcUOWO3zwMdJ9UKxaQag5
         fU3mNCCRnZtkp8lAmMV3TccAOkgb/7aTOjqC/Mf6C4hECvQiZ6eF7h629qor54As40OI
         cSynKpP2zh5qzyS+ELMUA4gxJFhOI+mjbIHaOPHIqwseuch3FqXwscUC5ltD1dVgmMXE
         sWhg==
X-Forwarded-Encrypted: i=1; AKwUvBzAF/GTrs8DorvLwGnpds1KhsHyzqV/MT8vOKnVKLR6pU9Unojfw2n2WEs1DhCA2Z7Bg3wtw3s=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8AbslJ+nfMCwaimHOU7zUccJPrgsZ2kFJyXvfNAQO76QBd9Xg
	hxXQPEGVFpHWX9noNajlRtWjEtMeEkXZma/bDVKypxtfq7cOinPrQ05CqXt2jhdIz9vJS/aXuyt
	xzS3fUEWL5RQmeFxUA83f0v+obbIaY6E5uSN7XQ4Tuf57F2YixTGeRnV8Fg==
X-Gm-Gg: AYBFou0gVXQvAt6MRpnnquUVn4coytYGPD6htOTK8YIFB9sW4i/VaxqgzV9lMGIaILa
	kxdNk4fT1a2RIQ8q9flxQSm0loVJiBcTVUA8EVzDx3dDrq/9h2FzxYIUXwlaeUePl20+N8gwneP
	1VHFEU+pTHZvdo/hDNqCCNA/q2zwSKHqtkwyHCy/+mVYiN0j23Mcle7bbxnG6DsV61bP4+ue94q
	6M8RzT1mPi+wU5XsqkxOZpVlo2KLySACE+xiOJlNdYCWxOzczH+t2X/2s5FkGjqbNsh6jXbWpng
	XI9z9M6Jwj9zjEEAdgCWxoSvyOxrQ1KH9ocs6JcN8dA3wQBBlyEFTMvyPyCsfyEVsXmg/GPnxJG
	Y7AUA31XSLFg6FgoChFpKfqrXUZL9dSN6YhRPRmcKws4cXpT6xStVVqT/7x8+Yiaqnp/5Or1qvI
	Gpe0PqawUlSAfpzovAmGCNPjP7rWveNA60W5wn3s+5ZG/3KZo=
X-Received: by 2002:a5d:5e8d:0:b0:48d:f464:6989 with SMTP id ffacd0b85a97d-48e5d45a4edmr11994839f8f.27.1793269459784;
        Thu, 29 Oct 2026 03:24:19 -0700 (PDT)
X-Received: by 2002:a5d:5e8d:0:b0:48d:f464:6989 with SMTP id ffacd0b85a97d-48e5d45a4edmr11994775f8f.27.1793269459257;
        Thu, 29 Oct 2026 03:24:19 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3705sm40661159f8f.45.2026.10.29.03.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:24:18 -0700 (PDT)
Message-ID: <3fdea60e-abe8-4ecc-bce2-672f4e3d6b47@redhat.com>
Date: Thu, 29 Oct 2026 11:24:17 +0100
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
Subject: Re: [PATCH net-next v6 0/4] net: stmmac: fix DMA descriptor ring
 cleanup issues
To: Ding Hui <dinghui1111@163.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
References: <20261024071319.875921-1-dinghui1111@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261024071319.875921-1-dinghui1111@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/26 09:13, Ding Hui wrote:
> From: Ding Hui <dinghui@lixiang.com>
> 
> Hello,
> 
> This series fixes the NULL pointer dereferences in the stmmac TX/RX
> DMA resource cleanup paths and the associated error path issues,
> found on a DWMAC platform whose descriptor ring allocation may fail
> under memory pressure.
> 
> Patch 1 adds NULL guards in the free helpers and makes them clear
> the pointers they free, so that a NULL pointer reliably means "not
> allocated" for the long-lived priv->dma_conf.
> 
> Patch 2 makes the per-queue allocation functions undo their own
> allocations on error, instead of leaving the cleanup to the outer
> error paths that would then walk partially-initialized queues.
> 
> Patch 3 releases the descriptor resources through priv->dma_conf
> when __stmmac_open() fails after copying the temporary dma_conf, so
> the long-lived configuration stays consistent with the resource
> cleanup.
> 
> Patch 4 holds RTNL around the descriptors_status debugfs reader and
> skips queues whose rings are not allocated.
## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

