Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3BE43B3F8
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621561; cv=none; b=NiXoXJ4+ZnMhcU7qklDESXYlO57JPXJI9uWWK9aat4lNkmdAke+ktRoSDeTr9L1iZNLbLBP5cNR6GYKzBIlm/p54aFTwXFACl8WZaUD/hOOyrWHz1ru8LaAD2IQe8oXV4zyhLPIbxQ+oeesPSdLL2l/Qys5Wumfla/c6O8t1Ap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621561; c=relaxed/simple;
	bh=6FQTffWDvYzOcAq6L+iPIF760gNSytTuPOb97cG3yIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blhis7PhU266fGciGk8ZzHS/Kbx8uMqzzt4KrjtjVKts3GCSL/OZSDiGkSY1Gxqc1dM5k33zeTKdtk1tqCa0t+qr5fDKSEZb45d8SLa98LDaXcN2gBBj+RyXu5X0hL5uFmYzIOyt2gsxUbBko74LshWHWGsQ1kqyumh8foSeUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ih0Xm0DG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvKy5iiE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih0Xm0DG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvKy5iiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784621549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAx37NgIikC1yEJzl1y/wDUAlNIlXDU8MqE4p0RIg9I=;
	b=Ih0Xm0DG4z/E74GcCxDrE6DOTPEHqTvJg1DmK/LeNl0pssDBwl2igmZjyhL+Td7M+vURyJ
	ZASsGxXsJxFz5Vb0jctvo5iwC6cWV5SN5xPzfFkdTm6UVuR6srWEGrGze/9L+XeZ2SJvwX
	95h1oUpQQlQnLCS+Pg/09yyDyp5X+tg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-rcl1QKIhNZ-zgAoXNFtOZw-1; Tue, 21 Jul 2026 04:12:27 -0400
X-MC-Unique: rcl1QKIhNZ-zgAoXNFtOZw-1
X-Mimecast-MFC-AGG-ID: rcl1QKIhNZ-zgAoXNFtOZw_1784621545
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47407691804so7696545f8f.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784621545; x=1785226345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAx37NgIikC1yEJzl1y/wDUAlNIlXDU8MqE4p0RIg9I=;
        b=hvKy5iiEOavRVjLmhFU3aNK7P9feaXQSe4yh5WudvBhJouC6wzpoGzTMiaHrFgwk+q
         +VSOVkJp4uZZ/Xrou1vPXUsQb7yyfhKMqwRNwAY+XIDtFYX/qN56tA1ui1hSBZfVNcrv
         VqTYToDREfD/Jcs30sETuzNZfPTg3O438CC3bSsFqi+nT0WCeYdioeK8fDGqJlch+7pC
         EOeG+F7HwqUF5lRA4Hk8vB9yuclS4svbnnuExDGzdSiISVdDOUekW/04mFqyoBS0vI3L
         I+JLiQswfdDeZnR+TS1RWD7ctf3twMgz+8qBngdKr5OFHETyz+znPnJIKEcrSvlePQdl
         kACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784621545; x=1785226345;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAx37NgIikC1yEJzl1y/wDUAlNIlXDU8MqE4p0RIg9I=;
        b=m6g0yffM4h+//ks8hRfga+nTsFZ+qB2e4+kLaLNlwL+YEEU3qRzSgPpjDtLti6xkF9
         3eudJfASClrYbtPi/i7dVJpHq5gZbzPfUKNXOl0pHwlG4Z8cUFr9bYt0vcNUGWiQlUl1
         cTRja3Gr/TtHLT5SBAjBVzAMfFhilqS6db34i3dJhJfsp55L1/5C0w+7khFaF1WjIEpS
         twS6OMGPw0f7GnI/ix3KwVHwsHTESujUh436r2zxfDimic0vzW2rIz0o8bUrenhDfL1w
         sp3+xV/sShcrMAyu9T6nP4L1lhCSSmaCi2DYJjS7I7v9BsjD28itOB17tJ4ZvhkP/gPE
         K86Q==
X-Forwarded-Encrypted: i=1; AHgh+RpRFx5leFDWVS1w/PvL2Qep5aEGLLQxBxMaPyPqnMP14E8fcyvKoW7MFPock25Vfo0a1K6BVms=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6SCTa6Iap8NuAYveZNSCRRQnZkl7V3e658jBMJ93TjbKeShF
	HZFPNizCjK8WV7vL/aKU0VOLSDYs0OCHi5B+gWXhoWx1JxOxvsORBtKhwxj1UeieW0QeWXCQnUJ
	aEn1sRf0MHWUGBEYsTtA0EOWmqZw4kNoABkQKBL8TT9vIZvSPiuBt3ZI++g==
X-Gm-Gg: AR+sD1192REaLtkJyVYJSFb1AySKZUwiiwp1y5rlMN7K1xD8ckrzKFJDL7sZapS5ouJ
	/V9gL9rfwNyajL6VIhDO4zamV9TVhZYS8FCEwteuHJjDQakam+YPZ6Zg2SfEtLBByQ1JOq6nKr2
	ajJ42V6L+UnSqPFDXkIqcufeMvPVbPZFcDXZmRYpN/pE6qyWvhOkrIjvOD6vwOnLkbDqrCAw4BM
	zFk0rn9Hu2grb0H+Ngsc6FiPPkjMaY+XAVQyKFBqB9/aysY3bERHAHwwnvg9T+gJHn3YfqRW69R
	oD4UFAroGJ+nqcF6tmr5EV6ki1qqOtz375i/0s/9RcFrnQV5qVkqZ8089G97qYElGwe6Tjfh9nu
	H/eQ/GvHprZeEhOphEGdA6A/KPZ3qH4VcA7Hchi9WA3aNNf7yW7MMj16zg0EfY7kjqoEe3K5N6H
	TpxA==
X-Received: by 2002:a05:6000:402c:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47f77598aeamr9608880f8f.3.1784621545019;
        Tue, 21 Jul 2026 01:12:25 -0700 (PDT)
X-Received: by 2002:a05:6000:402c:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47f77598aeamr9608820f8f.3.1784621544539;
        Tue, 21 Jul 2026 01:12:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm36838340f8f.29.2026.07.21.01.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 01:12:23 -0700 (PDT)
Message-ID: <2946c0f7-1c79-4890-a4b3-94141f42bc1a@redhat.com>
Date: Tue, 21 Jul 2026 10:12:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: resume PHY before hardware setup when
 opening the interface
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Stefan Agner <stefan@agner.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
References: <message-id-of-your-v1-mail>
 <20260707195425.405989-1-stefan@agner.ch>
 <c8cbf359-e224-44c6-8692-9e1d1527ae0c@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <c8cbf359-e224-44c6-8692-9e1d1527ae0c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/8/26 11:16 AM, Maxime Chevallier wrote:
> On 7/7/26 21:54, Stefan Agner wrote:
>> Since the referenced commit, changing the MTU on a running interface no
>> longer disconnects and reconnects the PHY; __stmmac_release() merely
>> stops phylink, which also suspends the PHY (BMCR power-down) when WoL
>> is not enabled. __stmmac_open() then performs the DMA software reset in
>> stmmac_hw_setup() before phylink_start() resumes the PHY again.
>>
>> IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
>> powered down, and stmmac requires a running receive clock for the DMA
>> software reset to complete (the phylink config sets mac_requires_rxc).
>> On such setups, e.g. the RK3566-based Home Assistant Green with an
>> RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
>> leaves the interface dead:
>>
>>   rk_gmac-dwmac fe010000.ethernet end0: Failed to reset the dma
>>   rk_gmac-dwmac fe010000.ethernet end0: stmmac_hw_setup: DMA engine initialization failed
>>   rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Hw setup failed
>>   rk_gmac-dwmac fe010000.ethernet end0: failed reopening the interface after MTU change
>>
>> In the field this is triggered by NetworkManager applying an MTU while
>> activating the connection, breaking networking entirely.
>>
>> Resume the PHY in __stmmac_open() before the hardware setup, making it
>> the counterpart of the phylink_stop() in __stmmac_release(), like
>> stmmac_resume() already does for the same reason. phylink_start() also
>> resumes the PHY, but only after stmmac_hw_setup(), and it cannot be
>> moved before the hardware setup since it may bring the link up
>> immediately from a workqueue, racing with the initialization (see the
>> comment in stmmac_resume()). For the regular ndo_open path the PHY has
>> just been attached and is not suspended, in which case
>> phylink_prepare_resume() does nothing.
>>
>> Fixes: db299a0c09e9 ("net: stmmac: move PHY handling out of __stmmac_open()/release()")
>> Link: https://github.com/home-assistant/operating-system/issues/4858
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> I was able to reproduce the issue on imx8mp and socfpga. Adding this case to
> my periodic test list...
> 
> Indeed the assymetry isn't very nice, OTOH there's not phylink counterpart
> for phylink_prepare_resume(). This helper was added for the suspend/resume
> case, and only for it as the doc states, it just happens to do exactly
> what we need to fix the issue :
> 
> /**
>  * phylink_prepare_resume() - prepare to resume a network device
>  * @pl: a pointer to a &struct phylink returned from phylink_create()
>  *
>  * Optional, but if called must be called prior to phylink_resume().
>  *
>  * Prepare to resume a network device, preparing the PHY as necessary.
>  */
> void phylink_prepare_resume(struct phylink *pl)
> 
> I think this helper should be renamed and the doc updated, stmmac is the
> sole user, and it's really about controlling that rxc and not about
> suspend / resume. Resuming from suspend is just one of the cases where we
> need that RXC early on.
> 
> So either something like 'phylink_prepare_start_or_resume' but it's long,
> or maybe we can be more explicit about it and simply call it:
> 
> phylink_start_rxc(pl)
> 
> (without a corresponding stop)
I read the above as a possible follow-up more than actual changes
requested to this patch, am I correct?

Thanks,

Paolo

