Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA8440631
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231240; cv=none; b=XTxB3D8aA210WTSsr8P/cwn2uCyOjwAj05FamTjnC4ITsBvRKtiZ8FjVQ4CTPmDSbCV46LJqL8W4FZtfS2UxnRQuJ1ebUeyRwKB2+sTEVg9KW4f0m5u8OpJcf0CWPtC8HFh65N5eYGeLe68EKtxSo7LQNjC2jlJU7q9Qmzckv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231240; c=relaxed/simple;
	bh=r+O40+jJn36t1mYYkZBI2G6CBbYv0T/fUPRph1eKGlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xq2KMfUHSzXXn/DPnyCJ/3PYD+XwtDWQIjYAhQ7bea8Pr/SdQ/K9OGwvEixzpNjyD+k1ayB2WBE6cWoWDzeIFl9OZVqtS5mjkIb4Xdp2Pr8FMhMlnSXz/IjLngmmqG3+/gWTrcl/dEVP9++dwPgm4nCLNC2kmRsvqEXwdLm1W4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ui1Qyx+r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ldv1zDWz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ui1Qyx+r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ldv1zDWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787231238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WeVXudguVsuHtNFC2uAD4H7Hns3vZwhNpfP4RIg3Bw=;
	b=Ui1Qyx+rMvOgh+ry54SG48VC8ZD9F7JlsN/KigtYTcSQ3AjxEwtuT6kDiVWfktJeEhwqpS
	COCw3XpCujiZ0N2Bp4+KLjPjD4Qviken9C3pCXN3Ta/NlTGzjUdWXX5FBopH1vbuaG1Zof
	dkaVumIsPKZEhWtl2eIZ8s5nyQXleL8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-U-WIY2a9NQuS0OK0mlPn1Q-1; Thu, 20 Aug 2026 09:07:17 -0400
X-MC-Unique: U-WIY2a9NQuS0OK0mlPn1Q-1
X-Mimecast-MFC-AGG-ID: U-WIY2a9NQuS0OK0mlPn1Q_1787231236
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496b61bd846so14856705e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787231236; x=1787836036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5WeVXudguVsuHtNFC2uAD4H7Hns3vZwhNpfP4RIg3Bw=;
        b=ldv1zDWzQH4ML+FF0TUkmDEHx4wsA55wTfupkKIIfejd2+HLtUDazdNqyXxmkrPOg5
         kXpSMSi/7JgraZ+HTMyM8xU5TVH8EhcMFx1X0ZpNPd0wQO5oNZBAtWcu4FwmfaIm2EIy
         kX21vYaLycUydG4TquzZWOC1XKhWOgyrlQVi018ojCBrlDUZbJ0SXG4MLJIpbSXDB7m/
         XjU8FQ9enRZQKBReiM/nZiAZr/V/n3MEdJgwv0yGMWbsin1d/So9bTkwQnZ3TRu12Jd7
         lm2t7/H4a6wwsuArZe7DarvhelQEh2v2jWSK1nnqJBh718OUfCt296EzDvEBY4tHEgd3
         7jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231236; x=1787836036;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5WeVXudguVsuHtNFC2uAD4H7Hns3vZwhNpfP4RIg3Bw=;
        b=lzqHwWuakFEnKOvLOlp4RiMbO8oWWKxKiwt8b8Z260EOvM0U+0p01OuPVyt3YU25sE
         xx1WuGp2avDxYWJx8E+9GsESSHZyhVgidjMYHPHRq42mescoB5juyxmnO+BbbTooMqLE
         FssPLLs8nGywjyGviXAFsdKt8K17NNAe1eRLUQneP4WL5JxnHoXn/HzjJljliAJuYb37
         rys1/ycf6yBTDt6ip9Pp7DPAR6E755zSx4AAJWKtLS23H7LHv3FByFrmnh/cWwJMTNlz
         RrSZbmXblhur+Y64x+t7RAJxaMGG5Fx2WOij5kD4GhiRTaZprC1NI5WFLXP9dchTL4Bq
         hCqA==
X-Forwarded-Encrypted: i=1; AHgh+RqW6cJhiYED54KHOieH0z8CrdjDbeHLEEiIZ1lItpOjbrb+hsHAmrk4bs2JP4g/CIE9P9qS9Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwduSpVPeO8UhGXx4vOj4ki4bEYj7P4rGbdMQKd48COraLCDh5P
	zLyzfCL6Eu0qF2ofmDrLjJG7owlN6K5ry77dbSBDaU+toxtn/QdPB47c5HL9/xwlBc5XB4fvezm
	fovJR43JOPc2P6uX1Z12Zg54isvEWaJ0xKO6ND4YEqNgS7Q0daSJbmoHL3g==
X-Gm-Gg: AR+sD12wg/HZeXDrXl8V2+7rUmruJuJH+dGSOLEA42cT03nBNBSA6d09UyMyegVL6zg
	0v6zxTVzNHIwy0iK44LX+0n+uiwQt3SBy3Tpxwc3biGZJ2LiIWHSjJjyAMbbLAb8Nk0ToL8P+/o
	GWFUuY+tBjNC4nTG1X7NhfwvZqKWmonoGtOY7RbeHZTjbvfJL9q4acgPeGxn005F779MoDJ4sLP
	2Cd6FlAtYDJjg9e0fD99Vvg22o9qtd38Dfr6LU9E2ci8gAwzDsBT9IH67gxxXFpFDaY2saHPX/l
	iuGujWPrwdGFX/cnhwmgz/PIPZpvTH712WbE1a9M9CnS/oLKwJzfEXw8QvBE4POvIJk0kqUvDu6
	vUepLqboxPodz6Ahdtl1oEocRxVM96CMyowogiDGDAElkNGLrWT4Z98DZGTH5QmAkPn0TJIZgXX
	k=
X-Received: by 2002:a05:600c:8b81:b0:499:8ff5:8ec4 with SMTP id 5b1f17b1804b1-499aa1802a9mr248051705e9.3.1787231235965;
        Thu, 20 Aug 2026 06:07:15 -0700 (PDT)
X-Received: by 2002:a05:600c:8b81:b0:499:8ff5:8ec4 with SMTP id 5b1f17b1804b1-499aa1802a9mr248050695e9.3.1787231235530;
        Thu, 20 Aug 2026 06:07:15 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aaef1665sm148727235e9.5.2026.08.20.06.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 06:07:14 -0700 (PDT)
Message-ID: <531993fb-2485-41fe-8ae0-dfa170a9001a@redhat.com>
Date: Thu, 20 Aug 2026 15:07:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: sch_cake: fix autorate reconfiguration
 throttling
To: ooonea <ooonea@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260816012109.2865223-1-ooonea@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260816012109.2865223-1-ooonea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/26 3:21 AM, ooonea wrote:
> CAKE's autorate-ingress path intends to limit shaper reconfiguration to
> once per 250 ms, but last_reconfig_time is only checked and never updated.
> Since the field stays zero, every qualifying capacity-estimate window can
> call cake_reconfigure(), causing avoidable rate churn and scheduler work
> under bursty traffic.
> 
> Store the current timestamp when autorate actually reconfigures the qdisc
> so the guard enforces the intended interval.
> 
> Fixes: 7298de9cd725 ("sch_cake: Add ingress mode")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: ooonea <ooonea@gmail.com>
The SoB must contain your real full name, and not a nick.

/P

