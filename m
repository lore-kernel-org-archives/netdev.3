Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07A42C4E6
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226582; cv=none; b=P7YTC7f2Pm6buGHs/DARYmG+EMBmIEaC8dIn5pF/vGPKeMuVGqJLOG9U2DB1Q190SW0wtHgciKRmTo525rKx1Q3iPR2UQTlBRM/gIXKfSL045IO0qepj0jS/ldNADyAFqMz5RNfMKefSt5kdxle7e/7d9y046NOV1vCfWd0B3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226582; c=relaxed/simple;
	bh=bl0WggYJHQcRBL/Oj0BryfftEHgfrnVqyO54aAETY/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NT1vJ5QONN6pseSkQJAUoB0uKffqUAK5U48MG1JWg2Qcva1cXUasHLGWycEzqPZ7Kz4BJXlDEqMKxIVe79GqcsSNAPLSG4mdRyxEP2m4nTv5cBgjHUA2hQUhiHWpo92dgNgJDZXpOwz4HsIw2QtkZTs1VEVMR51CqcYWwY/VSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=coiSP3Gd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBoQFDjs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coiSP3Gd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBoQFDjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787226580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4InsbEuz38UlO6o4la7QKLe0Bq1AWg3NL4Zc06nTVR0=;
	b=coiSP3GdQP25vBykqrWdr7xSBrQkpJjP8DCj5+LFezCovzu1e49jgqSsf/jDWuQzYa3+OS
	TXqaNSv9hD+kYyEMZEwD53+whUF0JUopYtt41uwEF2cfJXPvs5Wn4fC8tlXNltbC9mjLiR
	K3kR3bWji84afs7Su8y6VxIrAt3/gZQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-TEQom28TOoixLpH1X3yrGA-1; Thu, 20 Aug 2026 07:49:39 -0400
X-MC-Unique: TEQom28TOoixLpH1X3yrGA-1
X-Mimecast-MFC-AGG-ID: TEQom28TOoixLpH1X3yrGA_1787226578
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c16740eb587so167781966b.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787226578; x=1787831378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4InsbEuz38UlO6o4la7QKLe0Bq1AWg3NL4Zc06nTVR0=;
        b=cBoQFDjsdaMqzKFPuoHD/b4MpnHvyHlhgYBwvyhV70WHAiyT0D2TIAw1VUDHU1oLxY
         UInHHK3uKx+9ZlMoWH0vR/KngsrM8i5t60xSmGHALrDZr6uf5TsjQJIdKFVxMjypIY1K
         L5mHqwLYXEYXFnl7gA1C34ScD5Ii6Ar9AAZcfbnQZWHEPvSyBRWbUKK+oK1ijcv5oKFA
         ZxrziD4PGL7JSbhQgqbAqxXd1X4YkwyAS4VXLyKClBUv/+TRFtLdQXEciPpDJQVKcD6r
         zh3gAmca4e+lqKtXeSX+Yrh3BHjShsdscD6FTF/DTpcowNkX0JqShQSMdMwrjDPh6lFY
         u6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787226578; x=1787831378;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4InsbEuz38UlO6o4la7QKLe0Bq1AWg3NL4Zc06nTVR0=;
        b=OMFyGVRkkN0X5gJwsiCM4/bToR1aI4DNAGX+bJAzNsRYVT2LwIBKdPgUG/c2wzbwWG
         VnfoJsJdnoIi/da7Bl52aBx42oxVOg8iwHNaEfpre/9Zk+XR6s1X3/Vf5DR5QOQXiPTY
         eI4Ww3nxqTwXF0HmE0gkrtvAMYcnVlWFXc8r4DKt6/GFqt/XDWPJCYK87jtAoR0AgUeK
         Q6i4hqFbfe1WlgqHTfDhebO9LyGPivIzXq+nsCrjEKwtLBFp8iGG2H+7EhAGamjzv13d
         8adnkSxGLqbJBNd2bbZGo2EruJplWt48xFDCSelhG/IGCsNzUNbCi0YoSVmjYtOsj5ir
         4snA==
X-Gm-Message-State: AOJu0YwnmYEfkJlf4IKBzNu1C9bC0TjXOMlHQNXent+ozFgm1DBqhlYb
	nY3EalcHPizZ2kkqb9C/ao/j1TOKS1cIvd70AyX4wpHTXB7BP5lD9uIaVh+rF1XmDRoT1Qydit4
	SrvvFRvIoHjh3plZdTWM5C6qQuGWXi3mr31LVvZFhqDHgEX8LFh+xCEE8vg==
X-Gm-Gg: AR+sD13y2gKmMl1lCiuH5vJtdYQcYD2MZR7oItZ47+PU6uGIq8S1+zJBONpwMK7YKSw
	4Kfainf45f2s0ALCi2cPFufrRhm2mRMin9ifonGZj3+aYaXxultIr9EVRn2pyVM5xBssCXGCpRl
	hiIZZVg5jfkd23H9somaA3kXPsFY0bxhrIDD9ngBfXOLKO9llW7vkcL2wYoEZ6f3fOFdwEsCXeo
	lGSiiFrfscRWEKKBcKF1m46r3lIS7zspZfwzTfVkmfRBBvak3/WovlC4T+1jmnjNbTNBPxKlFam
	JkEJecKtayVYUVd9o+XhV5PjwZnVGiKEPm9VgJ0EGDAxrQ5pOUPaANDd/3fsG5ymfkxEoJgeV7c
	m6OUsj3mkPw2DItoz/1diXduaFnTb1Nkqifd2OLiCpf2aKXZBhjJtwHzCUm0pt2nSlMjPsqievp
	s=
X-Received: by 2002:a17:907:d48c:b0:c20:83b1:396c with SMTP id a640c23a62f3a-c242e1d0eacmr931170566b.17.1787226577840;
        Thu, 20 Aug 2026 04:49:37 -0700 (PDT)
X-Received: by 2002:a17:907:d48c:b0:c20:83b1:396c with SMTP id a640c23a62f3a-c242e1d0eacmr931166166b.17.1787226577395;
        Thu, 20 Aug 2026 04:49:37 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df739sm57323266b.49.2026.08.20.04.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 04:49:36 -0700 (PDT)
Message-ID: <5ae54784-8076-4b3a-a2fe-14fe64485571@redhat.com>
Date: Thu, 20 Aug 2026 13:49:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: Avoid uninitialized
 value on MDIO read error
To: Ruoyu Wang <ruoyuw560@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260815151713.3757248-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260815151713.3757248-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/26 5:17 PM, Ruoyu Wang wrote:
> mv88e6xxx_mdio_read() applies the internal PHY model-number workaround
> before returning a Clause 22 read error. Since the PHY read may leave
> val untouched on failure, the workaround can consume an uninitialized
> value.
> 
> Return the PHY read error immediately after dropping the register lock.
> Successful reads continue through the workaround and return val as
> before.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Assisted-by: unnamed:deepseek-v4-pro typestate
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

