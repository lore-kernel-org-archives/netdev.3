Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D3472069
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039672; cv=none; b=IIsvOP1ipVyuXf6m51tuBL979s79VVQ4Tyo2Q7sGC3IhJ+rzijzZ9xzJO26lJ/84o2QZqpWpFCCaHLufN2YeWMgvQBR8NOivUZMBDENIrONqc4U1RkbI0Py/INNqGwpBPVj16efLiMdPp5VV5yk6HmjWjpeyWO7QDwrjhmyPVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039672; c=relaxed/simple;
	bh=4CrwJ5iXW29xR1B9ic/OTu6MoVXyZPeG0uhyIiSglP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abT4veVrZ2RSitmJEQLeifwGmltCYNmFDUAdn0/mjWCpSoZcJx+ewhQY6Cfmbi6RBENHyHQQDKTgtlexjzppOk+Vy88KiS1Scm6S9OFG61JmV6Kj4PGcmfENPEXXDKxYIXORHIlcCZI7GUsa175GTTM24+D8G50kmoh1GIaClMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlwMQ8X8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=izux76Sz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlwMQ8X8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="izux76Sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789039669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CPMSwBIbKMNx+ykYOgoG6podj5+4wemD8bUPdP/A1E=;
	b=YlwMQ8X8ICcYTY5Sy3fk25xH5pCWE8Y+4C2JlYuLxw5mjhJVZR36Kn3H3VYOjfu9c0pAYP
	6sMhZcXJhyX046lI9fD8jVWwKGL+MJ2zeBLUJk2KuyZObOGB50jK8EY2AlcwsX87lDkJpO
	5bAKRlmiiGz6+WiK2s0fn8ljFGmzuwc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-6Nsa6NH9Mtq9m1MrphohPw-1; Thu, 10 Sep 2026 07:27:46 -0400
X-MC-Unique: 6Nsa6NH9Mtq9m1MrphohPw-1
X-Mimecast-MFC-AGG-ID: 6Nsa6NH9Mtq9m1MrphohPw_1789039665
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b7c1dc61eso55867285e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789039665; x=1789644465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+CPMSwBIbKMNx+ykYOgoG6podj5+4wemD8bUPdP/A1E=;
        b=izux76SzTENHbSScXgbbMmRTlrqgdhguBEAikDl4vkPnICRo3adFI9u86//LjMm33q
         DKiUX0a55TYWClXDZ1xZ3rn5HDrHwDnBbLxILzJRmRyCe41Wnly7QDEHoiIAQSCrveo1
         mSBH2XtJe+2h3FiSM4n9muKLZYvGTDTwkq3i/ZiXKlLqQav1ebmkfft59OHyIoWpJSSA
         vRb3fQxpdPYOfecic7kB5GG70aAFiDFJR/lINDdLwToB9fSR0+7yZLkRKZEkB74pPhe8
         1XOxviH8qyGzo6MKES0Hf3o/6cJofGZMra1J/Af+23ZQkvpgHlIvKvUsRcxqX4E7Esj1
         pjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789039665; x=1789644465;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CPMSwBIbKMNx+ykYOgoG6podj5+4wemD8bUPdP/A1E=;
        b=n6rm1GbzfIlJ3f/kDDAM5joe/iT11ZECuqVZOVY822ERpBhlw+JPdKXdhte2zioCE+
         wVVGCouy2l+TU81uXEly8z6I4FY0v8DXfvwcpGDneL3xuyK28OsO/sZk4/F5/BSQY6Us
         OpopfSWPvNYoLMfLHl9RYiN87fCdAYF4n49CEgcItZI2sFBXJXDfze4wvm2SVPtq+ETO
         ls06G9iwmsk/dp5OPFsSchlFsdmy2EKYC+ROPf1Y+CUSle8JEmRqlV6TZan0NPucl7+H
         keHpFwvp/ITpD/nJFxnSIhGPOUlAnomx/bog7Koo2/UB6vfdDCG/2Y1ppGTWp/G+UWFO
         upFg==
X-Forwarded-Encrypted: i=1; AKwUvBw5nylVRnKlnawF0vj/tU10dm2MeLeHMPOfVowgPU++PQRYLDDz6EcJZqRb+SxxXP/2XRB/Ja4=@vger.kernel.org
X-Gm-Message-State: AFuF++m++JI2EncZQHHO/msLaeHVxTtyTcsWLQkPxiMRfgomoIuqYbo0
	rHvrjx8efJzc3ngQcmuMQJ87kLLehWpd5ySIic0SyLpsUjZroniX+8ESXEV6dBDnjhvruSn1AvS
	hIOHBAioChl9YNAyE4S1LZupWjrAO++nIeIp80O/zNroxY489YP8y1Nmpbw==
X-Gm-Gg: AYBFou2m2lwBvMzKQysuwzjw3Metw0T4UggENkOAxEQcJmsJCiWCICzDjoi46sHmPYZ
	ytqudPyiEmFeThWN2jyg28uM33JdEOAiR05uFi/s/b9azH+iNffhzzyqxryIFlEVQACydxKaHvO
	Rplti8lbGOqzddbiWd+eiE+ORiEUt0009UboeIFT8nDHqwQ1lSNX/Cyvx+GOYLNBmx3MYm8noM2
	gAZk7yZmEGtryAaIa+bmZyh00Xt8TCdIfPPap18ncDPten5Juue6uYKkgOiweEMw/W+LHWW50qG
	bQC5ImQCaN8IgyKncwlA30CZUIcL5CbDe49uBSSY2osrVmyZAzj7rJyhCXcmdt5H9dnC0SKw6Fs
	8Vl0IHVleUTOxn6jeBbm886VyoRqP01dVyQWgsyMI8HSZM+ovob6kX6HioiXBaQahZsJNsS0gyA
	==
X-Received: by 2002:a05:600c:1385:b0:498:952:e276 with SMTP id 5b1f17b1804b1-49d258d85c0mr59112755e9.8.1789039665433;
        Thu, 10 Sep 2026 04:27:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1385:b0:498:952:e276 with SMTP id 5b1f17b1804b1-49d258d85c0mr59112385e9.8.1789039665038;
        Thu, 10 Sep 2026 04:27:45 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883959f0sm53665292f8f.10.2026.09.10.04.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 04:27:44 -0700 (PDT)
Message-ID: <013fffd2-6d59-4e99-8214-1377b1cb46bb@redhat.com>
Date: Thu, 10 Sep 2026 13:27:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 arnd@arndb.de, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com
References: <20260904-wiznet-link-gpio-v7-3-69f01b70c96f@marmottus.net>
 <178895754151.219967.10801079239966954315@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178895754151.219967.10801079239966954315@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 2:39 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 2 · Low: 1
> 
> - [High] On w5500 the carrier state is now sampled exactly once per ifup
>   (and once per resume) from PHYCFGR, with no polling fallback and no…

I read this one as 'with a bad config/devtree the eth could non functional'
which does look a big deal to me...

> - [Medium] `w5500_get_phycfgr_lnk()` returns a tri-state value (<0 on
>   SPI/register read error, 0 link down, 1 link up), and its consumers…
> - [Medium] The carrier state is computed and published by two
>   unsynchronized contexts.

... but the above 2 looks relevant to me. Note that ordering the irq
enabling and initial link detection is not enough, you need explicit
synchronization.

Finally please note commit c82ff94592fb68f529afe63ca7f5ddb7dae4ba83, you
should explicitly handle sashiko's comments.

/P

