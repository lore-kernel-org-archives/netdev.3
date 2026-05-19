Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63853F54C6
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182955; cv=none; b=M3IQ2TdxRHB2VH4CDVC+jw+ff8HJ3aP+/sQPL4/kXI/YWJT6ySRMNOrwmJZsr9BGJxnSCZryfxLCAsJHddf7BNwM/U/hDy6h/m5TreqHm4HLQjKHFNjyYQlZo3DZcO551UiJRZN2pY3g7+5fyzrvQEc1LdwXMjIC3tFF+afeKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182955; c=relaxed/simple;
	bh=tCjZjgBY3r9OZllLAP22YI2f1t7uM28nGSzAOg+D+qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqNbr+H2KlNdZNlSWCr1OE7YH2XIXA1SklZIK9okXyCXL06L48MowV6Tf6PRcZLAFYzrJrhpFwIRipzDEKu30TgqCwwmtXM6niPHMuZ4r9HHokRAuKH4DzoPJTMUiQKzGCIx+HUABGl+nj8B9SHnKwCebUwMvj8c0+NIi2pTJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDSG61+i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ab2SFtRZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDSG61+i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ab2SFtRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779182947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WltqGyX6LSgbCxoNJFtaPsurvESE3OwLgIknpaUUGUA=;
	b=cDSG61+iNJxw3fpNbLApEVbHBRcYuThhBFmX9dgOpvxffazG/X9XPfbJ39G+HVnRv/zbeR
	BnaxY6yprSmUUIM33wJRE4aFjb1FpsPS3W3vg42r5rgjT+enV6J4V58UbPvzzScmS3/s9R
	f7rZ4lticuwJvOUNiwQkDgiNAKcX+eU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-rU-oae5KPA6XmHeqj-cyyA-1; Tue, 19 May 2026 05:29:06 -0400
X-MC-Unique: rU-oae5KPA6XmHeqj-cyyA-1
X-Mimecast-MFC-AGG-ID: rU-oae5KPA6XmHeqj-cyyA_1779182945
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48919890a95so17647355e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779182945; x=1779787745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WltqGyX6LSgbCxoNJFtaPsurvESE3OwLgIknpaUUGUA=;
        b=ab2SFtRZ/aUymUZUeseGZxWW3HwrKtlly5cy04cAV5CiTR9HG0xC3bca3h8R0bmd1U
         IkIUdqhHuhkGiNKVdpXmfprJiFw3E6JGcVL764sMHP196X9Pu6HdNiIdDezXV1wY7FUA
         759iG83jlzXt+oi2Fu050BVFzMV1OeqVpPebln5/yLqze0Tk6vavDLG9OfWf5lXkeYHB
         MwuQ1SZT65oeVY0mBXsbmrbq5vINX01xTG6z25Pr+GIyqFXW/r6Dgjc1kpFHOGKhW4dp
         yfo8sxnJgvjmEAC03O04yYdlffkJll21gWbwIlCzuuwolELbc4m5fEvZdaj9P7Ri0LIX
         itAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182945; x=1779787745;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WltqGyX6LSgbCxoNJFtaPsurvESE3OwLgIknpaUUGUA=;
        b=AsSbEQpNVAgLjlxAkjY7sU3v2kP3FvWBK4I488/NQSgq4cWIuGhdKjvp555sjpcUfV
         xVDe5MYETztL/XI1NwzSZncfsh4HEncvMypd420MfK+diqIr/Svdzjcu0QlEaTVifYds
         /7yXATpeXnD/jSPq0yDGyJHmxOHiljiYhfKFE+IlmjT2IuNQmS5AGo10ZhAYfna0geol
         hBXphb8EsExj0Y1c3EV2PUus6EW/i75VHTxB/+PzM0a6QR9uS//Z7ms49lfyyw6NNwzT
         yD+FVkoHqXfoQXI5Lp7ZwzX8nF+5QKvMVYUsWA3VP7QW+vkU5PxNqjjYdy91tSk41/ri
         8Hng==
X-Gm-Message-State: AOJu0YwdILItMQU2DnbNNlMjJzZW75zRTlVHpRD3w0F1lEl2yjh34B38
	P0cPOM3+7t67+/GEw3KTEXxErNBbTJzwvQ1KhCYreE0ddQvM68CRrJ3nhf1S5nO0rEwbz2MCmfj
	vpgIwk8IvlWYn5Hqa17qBjnklXprtxZsd5GunrrFS94Opzostu3fd7b9O6A==
X-Gm-Gg: Acq92OHoSWr6Nncty7mA1XtLS/vZux1LIzWwEtK5mzeFW3IU/4scQUxHWM3zR7gOVMU
	QJVAh+g0Fd4VHyXBnp2Cs8dMnjzQiNk0cuQGCMC07BNU8ywwS0cxzugK+WwYgXVl7sIFi1OHHLG
	hYSvyIZxyAmvhcH6NZr9igBHKtuNOEv54oVDgR1YcpXzbU9BQ+mviEfVGLctMK1goGQfrCpFxd2
	yAjLLXewQU1mBHny9ozVy8PYpoYEuWKY5RXga6fhAAK2QxNk8vmHlYWK7nCwB7XzVfxBuOMs+S5
	4UeVX997tGX+cLTRq/pqUVkKifo3vrZvup4PW+Ar4djULqMYVGFwmRGiO8vldc9Ud+aSBmEVFB3
	zOlIso1MGqk1D4V7QDAJhJ9lyhASFxw2H7jZZEDsbSaF5O8z0zrRS02g=
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48fe59b047bmr317369575e9.0.1779182945107;
        Tue, 19 May 2026 02:29:05 -0700 (PDT)
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48fe59b047bmr317368795e9.0.1779182944663;
        Tue, 19 May 2026 02:29:04 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf81970sm144760595e9.8.2026.05.19.02.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:29:04 -0700 (PDT)
Message-ID: <b0e8121c-e2aa-476b-b8b0-3c799e712e90@redhat.com>
Date: Tue, 19 May 2026 11:29:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: ti: icssg: Add HSR and LRE PA
 statistics
To: MD Danish Anwar <danishanwar@ti.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Meghana Malladi <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>,
 David Carlier <devnexen@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20260514075605.850674-1-danishanwar@ti.com>
 <20260514075605.850674-3-danishanwar@ti.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260514075605.850674-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/26 9:56 AM, MD Danish Anwar wrote:
> @@ -201,6 +201,16 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
>  	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT),
>  	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW),
>  	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
> +	ICSSG_PA_STATS(FW_HSR_FWD_CHECK_FAIL_DROP),
> +	ICSSG_PA_STATS(FW_HSR_HE_CHECK_FAIL_DROP),
> +	ICSSG_PA_STATS(FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES),

Sashiko noted that this statistic name exceed the ethtool string limit.

/P

