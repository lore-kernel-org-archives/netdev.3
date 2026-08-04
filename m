Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9645C713
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841242; cv=none; b=pFc15UpWhGRx54zKaqjjnl34WY75YzmFI1ga58mECjEFtFhjf3m715nOjcuDRC9VeN0IQb00+qV+vg5/JYtttI084PI7mJpsUyn0004xzf4BCsRhWFku6OsKD+1ke6EmWsCWdTyQao10SrWWneSxqqbJB7Xm6TXkmwzuYjAuv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841242; c=relaxed/simple;
	bh=j4jB2CuktZt9BmmOQZAWYh7FwI+2H94W1au8O2AKvC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9bUoEMEnA1fzZtDma48e5sLvzH7YkNtm1pGeJbJqZg2UHwAFA0HneHDQWm1pyw3hhnodug61/74JgNvqURnVoPBIHpPS6rILIkF42afPs7m4C5rKB6OfUa7ZFZdVN00i99y6lXf8RR5Gz1Kk7LQ6EgBFSkF16jXyXkW0k/Us1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeDsSj7T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=le8lxYNd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeDsSj7T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="le8lxYNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785841231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJtreoVIWq8iraOxCVehJ8SXF71GD0ffstjU1unaYZE=;
	b=MeDsSj7TQnmp0tUIe108r2NvWQwIkyib17yaxWP6v76LuE/SICnNr8B019n8f43u4CGrbb
	Y2zGT9r28ZD2RR6cg6u5bhGgD3vizlnZXMXubqyDx4NF1cCg6yxofKRJYZTVLPX7uWO24N
	q3kI1kzCkyPqfQjUtdzC7CqgGhx2fxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-TmPQ01uENr-5tgzRT-LcVw-1; Tue, 04 Aug 2026 07:00:30 -0400
X-MC-Unique: TmPQ01uENr-5tgzRT-LcVw-1
X-Mimecast-MFC-AGG-ID: TmPQ01uENr-5tgzRT-LcVw_1785841229
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so935235e9.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785841229; x=1786446029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJtreoVIWq8iraOxCVehJ8SXF71GD0ffstjU1unaYZE=;
        b=le8lxYNd1XHTmhbgQvFxMoAZhP2S88v5fspU0/VT8GMaRVkO9R1CFrXvVYMPMy7obE
         n9p92wL6M7kHbIobNWtO/uApGiemuLyLLMiv31Mey4C9aHyhjnscPXzM/z3xacOT5UTh
         FJ3Z5EDvhJoCQUdD6TE+x+O31IK0IdaUuKggmf7KrawSe3mrdxbpiZO6YLPYeOhHNZ8v
         GJM8BkGe6ngCY2wMPQU1zA+ox+bROxAYfjDIffOosZE2j5PVXDhdUGtAYh0d0LFLbUOP
         WnW6dIM+zJLPQnoIeVZ95lHiBmsOWvJL4f/GRyWYCOyuD/qCM+LCzW1IaTh8X3ekRi/2
         +jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785841229; x=1786446029;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJtreoVIWq8iraOxCVehJ8SXF71GD0ffstjU1unaYZE=;
        b=JCXfxs3EMGQfXfsmieukpiZbXmCnDEFZejFL5Dhhqer4PbqFVD83fVCqHpnGMgr/nJ
         KLdD6TP4jPeRen1jnS/5X0GL6MBRBPi6yRlU3H9CLkW6WoKSqwsB5y/l8cVO1d1EXcnd
         BeY2WK6YIkKC5M307GILPJM0idksSsTBAdlLJuIXK1WNcBcLD1pCaJMUpKWNaJEg+Xoy
         JDyPKDsPHBr0zyP+WctqVtDaVlLjpgj7HKc7fWVFGuSYEfhp/bFfg7doGgM0uaQNW3NK
         EQ6dSCJ8bmASJ508mIcLeAVKt3gSopda+N4VqP/x9MG92vfh3pNlrIEAArADXmnX7U4K
         5GoQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVBjcrG4ouMHe22VVItIAMcT3BqdmqQY43la9PXFKBt/JssnJRAaQmkDGxGA3kA4aVv/MHdAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstK9+3vd5zVvwyxX4SDlXHMBamEjf6sOlZ2f/ZnuTlen+n81Q
	x08Wj6E2L2GXtZ8DZRn55Vw+cx0ysdbdiau3VdVNfGUWd6btmED64iQNqT2228cbj4dTE5GsGvW
	tIYYsn4twdqr2pcWBISdg5+hi93AF+b2XSHuYMjuUtFpDalocUT1QHm3fFQ==
X-Gm-Gg: AR+sD13RGPmorWsMODMFgNyCdNGlpT3RxUbq3hSGRnPvw+1udBABgo5E4zdfGKeDPDx
	Jr3/RUFYeq3x/QxrsVHvSXl3M7VGVVCe4hd9i1PaF8l6hdoLx3nC9ET3GSQkFwR3ZTaaLofaQ7y
	/RW9XIdYBGksDFB62eH54L8i8atJHj/aY6GUq/ClM8ZYh9faJvCViraKarMMZfZOsHXdlqG0Kcq
	MM6bXnJMLCCLZ3iQ8zkDuS8IB85O7lQrZabNazJySOu6866a8Wi9bim1nJBFd6nYkNJAP4zADNO
	yl//U8AWEn2lq+RqMM10QKq2uio/p2OaIgB4k28nIqdtUKFrBgLkieFUNZ/Avmlpra4m9UP25pt
	dTBwysJHY2Yt7HwfRqATDW4JrakHPhSy/J6s0PpgCZunV6EaIFhmr5KdkFkPl194v/vECLuIAUb
	8=
X-Received: by 2002:a05:600c:e48a:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-4980c695d6emr213046865e9.19.1785841228848;
        Tue, 04 Aug 2026 04:00:28 -0700 (PDT)
X-Received: by 2002:a05:600c:e48a:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-4980c695d6emr213045745e9.19.1785841228325;
        Tue, 04 Aug 2026 04:00:28 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm41447011f8f.5.2026.08.04.04.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 04:00:27 -0700 (PDT)
Message-ID: <845bb9f6-73e9-4301-a5ee-94e7f7aacd88@redhat.com>
Date: Tue, 4 Aug 2026 13:00:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next] net: dsa: b53: srab: propagate errors from
 init helpers
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260729202953.704662-1-rosenp@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260729202953.704662-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 10:29 PM, Rosen Penev wrote:
> -static void b53_srab_mux_init(struct platform_device *pdev)
> +static int b53_srab_mux_init(struct platform_device *pdev)
>  {
>  	struct b53_device *dev = platform_get_drvdata(pdev);
>  	struct b53_srab_priv *priv = dev->priv;
>  	struct b53_srab_port_priv *p;
> +	void __iomem *mux_config;
>  	unsigned int port;
>  	u32 reg, off = 0;
>  	int ret;
>  
> -	if (dev->pdata && dev->pdata->chip_id != BCM58XX_DEVICE_ID)
> -		return;
> +	if (!dev->pdata || dev->pdata->chip_id != BCM58XX_DEVICE_ID)
> +		return 0;
>  
> -	priv->mux_config = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(priv->mux_config))
> -		return;
> +	mux_config = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(mux_config))
> +		return PTR_ERR(mux_config);

Sashiko noted this strict checking may cause regression on previously
working setup:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260729202953.704662-1-rosenp%40gmail.com

/P

