Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EC34968FE
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811754; cv=none; b=essqPfm32FjVfwvQhcA+TsRRNsXhwHX8bzBSEamAKHqCMJplgHfQEeFbqwUL5DYfozZOkuBJ8w1DFxTRAkvwK8A+t4PznTO8sFD0kEtMY6llcWGrYdyBBmdEErnUYjdY4n+FiZIaoPLpJztaADAaofx85amawmeUV/RxST3lmp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811754; c=relaxed/simple;
	bh=07uF5rL7d5aKsdRkufqv094Ri7PWzAEpa6mJZUA5QXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8HuaCghX6R1sYCdSAtuyMnzHqKerPnDkuQ1+mQeDLkmNnNrcMX+8bxXXZI9EUXM/YeDpCIzX7nGw7HSKuE4kwRYC75fMfMi0CV4BpDH8iL/5/RvG8aFibl9y2aHRZHg/xB0Y+KEBV2QLRt5zy/u94J5Kr4+glq+W/6SV1/iRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=IoSvxWvj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="IoSvxWvj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceed7018c8so4546395ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784811748; x=1785416548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lMFDKKyt9GdKFeZbUjldfucgXKXS6SFWpdSFPP3BCA=;
        b=IoSvxWvjoKnKHtJ5r0aSYkv6+CWiRNOzLtVPbbd0RHNoPRcSaEsxrwerQKDLVjoXDA
         FRaKb2SNA3/9y2iikuU0PsJ3U7Vu1k9CAaSbLz5n0l2EEolE5MmezN8A+42sid4/IeHN
         FmOWHycw+UHSb2DWYxy38L3EJiCbIW7i8AAXgLKx6+pOpI07S1PEnJKiRtjNnYfBY8ee
         Lah3a8upNhdpTgA6BQJqMAOKcFLA1fCBLX2omgV3CeXIj0MAiAvsK9qXRQVaqzqT1XO9
         Yw9lyLYL+LUlhxjsdWInfDWr3ZOUob6McqSMNNCWhJE17TzwJMVAGwqT3uqOpTWhYDNZ
         2uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784811748; x=1785416548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3lMFDKKyt9GdKFeZbUjldfucgXKXS6SFWpdSFPP3BCA=;
        b=fVYckN1wXB/Pes10yZXdYu/Zmt3/dES3S5V+XzXsyhdi/VXlgNjTeJyIxNErugTdkX
         QNQr5pIhBwa5XU3z7SKin42/uG9YuFUtTGuCaRAOA4KDQADQAwDhRj9ZLOrpLUHd4zSq
         3VSlVJUql7EgwOJZMnpNiLZaPbJwrgpfjbQZHIsX4DdGgc6SqK91wAUphfv90kx44ss0
         VH6PLxrVEaTy6pvXR5xCCaiXSCq7um/qiBlZJlP3SLvlWJflCj43HSPe279zYOm6XsZa
         7FWKb9i5ZB+X0Yfzi1U6zHHtLCaGGDmkeL2yi8Ehk0zTu0Kx8EpDHFWxfK3gkvPMG3Lu
         /8ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrODMtjHXq67l2RanNwG7KDDdt/UQPmbUPQKNODbDONm9g9LUqm7x96kDy15ZXFQySJ35XWx/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2trNhFI7YoIpBMvM3BLoslkwf6eQQSlkHhD6aliuAedbEMbSB
	zH871SWs28MPp3CIUGL897LxyYJkdx/G6OGu+8I+Vr6OGQgQtJbBmWSFKrljUdxr2UYV9crOwAV
	eg+uLc+7m05ew
X-Gm-Gg: AR+sD12vZ5hDGKbPLPcYLsAoXuVLtNxYac22+RbAxg+BqtzH6nQFphJY1uiNwwZv9uF
	nmUSBJJP3nwivPsWysTpK2a2HDRgW42RbCfFzJLUYtnLZ5hfnLA2B9fzpsNaSF6LZSZvp6rxunZ
	aXGrgeedFLpjUOzn3tggG5gH4y45vVdoos2CO1HvCMl01phRMkK7F3t/WuSgjrWFHbE+Ub08XwT
	DTW273MJPV3SFf+ANYa0qdXtjtPZ56RI3SUIRWQFMcXoUcJDmRS5zb95RVlpj5CIj7ByyOmoqHH
	X/VnRlw5nJqfN9LnM8BQVUgpKsF4nH4cM/Tl9pTbozE7SJEP7pNod24aYGCJJ4aX9b3jhH6Q7pD
	jMVYVTtQ32QCfISMzNYOpaeHsvjgv1hhnvztC2q5WRnTLrouMJslKZO+/aDI=
X-Received: by 2002:a17:903:184b:b0:2cc:307c:51fc with SMTP id d9443c01a7336-2cfa6bb32a4mr34615355ad.21.1784811747711;
        Thu, 23 Jul 2026 06:02:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f350554sm33032095ad.66.2026.07.23.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 06:02:26 -0700 (PDT)
Date: Thu, 23 Jul 2026 06:02:25 -0700
From: Joe Damato <joe@dama.to>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igc: Remove unreachable break after return
Message-ID: <amIQ4QWie1boPvEk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Hungyu Lin <dennylin0707@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260723070451.6545-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723070451.6545-1-dennylin0707@gmail.com>

On Thu, Jul 23, 2026 at 07:04:51AM +0000, Hungyu Lin wrote:
> The break statement immediately following the return statement is
> unreachable and can never be executed.
> 
> Remove the redundant break statement.
> 
> No functional change intended.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 2c9e2dfd8499..6252d4b68f88 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2528,7 +2528,6 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
>  		if (xdp_do_redirect(adapter->netdev, xdp, prog) < 0)
>  			goto out_failure;
>  		return IGC_XDP_REDIRECT;
> -		break;

Hm, from Documentation/process/maintainer-netdev.rst:

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work.

I think this patch probably meets the definition of patches which are
discouraged.
