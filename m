Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA40156C6A
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640436; cv=none; b=rmT9McAnbhX3Dc741qrvKMJ+vLo5P159aR32CSy/EFCjO57dNCudMWtFK61deGZVM4SPFFUocTvXrn0GnnX+0XRgSvg/j4NKEEuonsmOwE1PHfxeu47NQTeummhCbAN21RXBCkUcKxuzkTbGnsHKct3OxQNxpoVaXAS+7SPCazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640436; c=relaxed/simple;
	bh=mFW2G7qn0tHQ11P8dLXCXVHqgsu1POvtSpam5UrfvYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZmmDmL0/smJw/Y0+X7BEj8afrrJQOVLHY4VWxEr4rJ4Q+w5m9zzD4eMfuQq5du6AK6N8qJldqe/OBwJexl6v9VeyJBjitmBYef9Koa63pXP6I05Jk51qUJYA9SbVo9L8VqMsNsJG93oCni9kxUFfxS9lqy54GVhD7EGp2Anffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=fXZuPleP; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="fXZuPleP"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so16134635ad.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790640433; x=1791245233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MUvDYNeKYtEGt6nLpxNjasM9TEF3xIAo9jyaMtWUr+o=;
        b=fXZuPlePe/1+hQK5WLcvsi8xWoFygtNAKFpPwHuRIxzJ37kolZqehuJGpR4ILZbcF0
         NjaPGn/uWqDvsAmd2TI07oVxE5AbRQ862G9OkLjQFnAHh1SqCFmv9MbbYTCbq+krwLRY
         h6G2zMufRV0Q3vmZqxkupekuotOhOpu8LmLh9Tjw1/33qTuVDPqfPU+/170tnZ+/ruIu
         ZxyUDoIwjvtEDqlLOKYfuZbAnL2NUJ1bZnFWKhAp9YVo6IEzb3vvfl2ZAFVQVF86pmZ2
         Qv/gF2VmGczX3bWNK5pUPvLLPoU5ZAkc3zoqyOUNCImNSIxvpMm7rzMm5zZvPADnDXra
         gO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790640433; x=1791245233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MUvDYNeKYtEGt6nLpxNjasM9TEF3xIAo9jyaMtWUr+o=;
        b=pAuAaj5zEUcjgcGtQU4ma/NiKp/G9bfjgVfEb9ivcjOiElreKG8dDBwkFEMte5mAjk
         GznNOqlL2sKf5QzLScwmW2vboh8unWYaPKq/agEha0ZnrV42gP6Kc1Bzw5Mi4rnyNjJO
         BmCUedP5zrMy+IGs22Ia95YmXc2oAZblZAYsWGXna802gOoHAqS0T5byhP4+uQk+SeaX
         4ClRode8e4XlmmuoMNoBoxDQhXeCS37/exy86AUE0uhLzgQoSFDT+sa+uWRcBbP7ScYP
         VazbKj3kcW0gWtjfGREObacsthqpohRCDcGMMRshnlmlze0m5/KRRoZkwSVv9eexd0uF
         8/RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZP3YrDVhFSQxcJ/BlJWwYzBt5Lx9rfSJbgTKfYhNTEDjyki04tuBxodfYq6iLe0vhsXOmin0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVDcC1yLwoxRMv2UGFkU9wz8yfYTRkj5FcRvZpFn550jXrZW+y
	Oq4VhYW11EWw+QcSeZ5Z8G5YPfJobqMbwNsWVsrNtZ7DxsCsv6VTLozrLeqnxYsw7p8=
X-Gm-Gg: AYBFou1d2KjHx1n62UA2qAD4FdrFxCHT9KLn6fQ1jCsyt4pW9i/h2EyZGTEj9oDymKc
	HoX0S/wFAP20YcDKFL5AIAztr5H7SXEFcOLh5Gl9KeYpXS4VWgCLMPpgM/C6mkmua01gq8sZKpv
	DUkaSVvxLTkFYiMlA1fthv9pPgoecST8YwZYblD0eCYP4cp8o1g6uQwQQFXj0TBvoFRDJybmSsP
	gFpMTYjDuAfhMLVNEFUErtKQQZRAJi4u0YSPEuPti0n+jvP2Rn0mfLyvcNyW/ymSASsBFvMfrCI
	yIz/OOIBrN822s3uPCCFu4e7BK6zuC/k3jx9XMKtPRaIhj4sz/OH6jKAdejrC9+QCeEeVXxkyPt
	2bUnfdlZgIgo+4DS5lk2jsuyMyTHBmLXl4yjFXq8mGPYg3H9cHF0tBQTY81K4DJw/QSckLOqzkB
	nsmrHcKfsHdzNvQUE2/ZbbJ6BezykMXJjPw91HYE7XoiDu+PxxHM5EpHQ1At23TKlqbflI1zT8K
	c73pvw/nzQ=
X-Received: by 2002:a17:903:17c5:b0:2d8:d4d0:792c with SMTP id d9443c01a7336-2df7da6ccefmr117603485ad.16.1790640433612;
        Mon, 28 Sep 2026 17:07:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913e23ecsm48165595ad.18.2026.09.28.17.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 17:07:13 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:07:12 -0700
From: Joe Damato <joe@dama.to>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: Introduce a helper to check
 RSS support
Message-ID: <arsBMHaLVLylD4zV@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Peter Robinson <pbrobinson@gmail.com>
References: <20260928145043.1228968-1-maxime.chevallier@bootlin.com>
 <20260928145043.1228968-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928145043.1228968-2-maxime.chevallier@bootlin.com>

On Mon, Sep 28, 2026 at 04:50:41PM +0200, Maxime Chevallier wrote:
> The RSS feature is only available in stmmac if the hardware reports it
> through the DMA caps and if the platform glue sets rss_en.
> 
> Introduce a helper that checks both.
> 
> For now, no platform sets rss_en, but there's interest in the topic so
> leave the door open instead of dropping the feature altogether.
> 
> No functional changes intended.
> 
> Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 5 +++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
