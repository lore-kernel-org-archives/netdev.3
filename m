Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B6D45563D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788294036; cv=none; b=OyR/2JYx9YJ6A7u2CzelZAWtKqq4Ob7DQcdaS3NbnP8ArwzHsqD2P5+2b8EmBV33nnrAPH2wOTlR37u+siQS4F79YJeXVUnYcwy8/uVVJY+lwp/cniT8R4/4+KIzuacHbRRR53U+ZD1PdbYnECcNozJXyhtM2FJMcbSunFLRhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788294036; c=relaxed/simple;
	bh=istqpQdfoLlF7xgTCn4y2bSZDJfpNcTMy4pIOpgogb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxitEiLsACu8K8vyXgW9MfviOYrsQoogQxQV1hxU5D+kM1Qnlg5Sn5fk9M+TdbrrhCozlbNi6t/1JS4tfgCDNQmVUthDNr/NB8XYHO1FTrdCk8nqzaAm30kyGRC3/DVNTIiqQPU7C5GxKFJqqmhsZJ8VhZT6hw9FtQg9wRCwCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=T60br6uM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="T60br6uM"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so309820a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788294034; x=1788898834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5sPEjv+xwXb+QVAroiu5Lctzd4I6+pfvVTzx8c9acc=;
        b=T60br6uMfahadSaWaftOShlMDdAgjOc6LljjimqKL/51e70XFmx2uPqC2/TfODNuuE
         KNwV6uHAH+ChFgKP5yA5Ril0A2O5Zq2tlNtXD3Xg99f+/iqdV+AJvBiIbOJ4SqBavUrm
         +2pw0fhMxaaRB2YRAEcUi33CY5hjhVugV1F4/29V6fqYJ5R5FgtuLUp8PfSurBxEz1rB
         yxPCpyeiL/FIkTuncFmrgIrfUGWH/8uyoX9YG4OiyO21A25wv35BLLuHXUjGsGzsUOhE
         rww/y5vRqCOixzUrqQ0Fzd0enEMskLYRly6tBMDG0f23PkzrubC/01xPaloUWdcajipA
         KflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788294034; x=1788898834;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R5sPEjv+xwXb+QVAroiu5Lctzd4I6+pfvVTzx8c9acc=;
        b=T+talbkHJgkvYydHe/qeFhNZHI0vsW4dZk4jOX1pevEljBiWLyLOt0HVTI7xdKV9qn
         Yk9u59hZK92hojKNcfVsY+qcVApdjPG6xEbU21sjM6sXKxml17YcRwInRWdWXSgFUi82
         4cCOV0LFiB9++OmqdMzZ4u9vX0zZx7xPdOHfXF6w1u/MV5njbfoZSrT2L7p+TG4641/K
         DHv2fgYzde8yKbBEE8i/X7jPpA+I89htXL4yQr7iqaHMoNg9qCAIMoxT1SaeZXmysJ8F
         6UobdgnuTlMUQlzP3H8IXZnhl3BhObAleDu7a9jLuyDlM7pL68BAX6EhOnQyA8WSujhF
         bIgg==
X-Forwarded-Encrypted: i=1; AKwUvBzw0ydWo0jShjwJE2rQpcQeWMT01EI6ldoiNPS0AOgQwsncwEo9WNjE2A2ZNbSsSLmNlKncOPA=@vger.kernel.org
X-Gm-Message-State: AFuF++miqQUDmhvN3tgSCIfyfcakPXh+XWa5qTcIMERttS/5eNvsAnTJ
	03av/tX6t3UoPbZP2OsMDaTxjuS4zmq/mTGuBXLOGGk/MI/U5Vbgza6Wu7XcVI7H5uM=
X-Gm-Gg: AYBFou2ALPXUnkjP9kW2VOZJhmNW9Zqa3LHMIEM8i0LvrS8/8Q6sfHryDaVOfhNoI04
	ikyqJJF8Cm1d3n1IEffnQIOCXb0gCF9wajKu4WXRmhWoN2pQetj8PNF3NH+3991/5vXTTAmd1lN
	Xs3v7wWPCzyJ7CpWy0LBqq4pcSqDgJdpN7RNC9Kpn6THijg6hTYc9lH/Y0so+aBL7rJCPWFAiYY
	koF1QRT2obtJaGoDlYUMwjTRIGW45lJSMOlou0iSth7Dyo1FwcN8DDp+F/4itSwdB9hneKG+zMI
	q2sW9VEZ41sfYVNXa+Yo19gOVzm8j6lZIVXwRGVtSxpOKax3bv+VDZV6aJt4/xRmOwJPDcKMGvK
	zI2f0LVSFtIs8ehUMM+aDnM8CDWwdy9hEFS5r3wmFqoH3AyR++an8AVg3BsotMUcXN/3Sjcd5Sh
	/W6kdkYMqel72IJmRG5YDWmzoTHyFmnsQ7JKHrh9YbS2TRzsh+y/7r
X-Received: by 2002:a17:90a:d610:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-39ae82197fdmr1091497a91.3.1788294033890;
        Tue, 01 Sep 2026 13:20:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae3c6f337sm1306368a91.16.2026.09.01.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 13:20:33 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:20:32 -0700
From: Joe Damato <joe@dama.to>
To: Linus Walleij <linusw@kernel.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] net: ethernet: cortina: Fix budget accounting
Message-ID: <apczkOm+o+dUqvZW@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Linus Walleij <linusw@kernel.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	netdev@vger.kernel.org
References: <20260901-gemini-ethernet-fixes-v1-0-ee6b09675876@kernel.org>
 <20260901-gemini-ethernet-fixes-v1-1-ee6b09675876@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-gemini-ethernet-fixes-v1-1-ee6b09675876@kernel.org>

On Tue, Sep 01, 2026 at 07:04:55PM +0200, Linus Walleij wrote:
> The gmac_rx() function returns the remaining NAPI budget, but its
> caller treats the return value as the number of packets received. An
> idle poll therefore reports a full budget and remains scheduled.
> 
> Return the number of received packets instead. Preserve the existing
> free queue refill accounting by adding that count directly; continuing
> to subtract it from the budget would invert the refill behavior.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Link: https://lore.kernel.org/r/20260509-gemini-ethernet-fixes-v1-4-6c5d20ddc35b@kernel.org
> Link: https://lore.kernel.org/r/20260512131456.189452-1-pabeni@redhat.com
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>

Looks right to me. I assume the LLM mentioned
u64_stats_update_begin/u64_stats_update_end ? Just feels like there's a lot of
code in between but maybe the only system this NIC runs on, u64_stats_update_*
are no-ops ? idk.

Anyway:

Reviewed-by: Joe Damato <joe@dama.to>
