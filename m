Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827C355F5F
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430411; cv=none; b=T9F+uZmddSFYmWzN+IYjODhZCnUTqg6Rb+CPxUPUYZy3oAzQMi7ch9zhRotY1XawJyOwzUsk2LNYbi9nV2ORNx/nb5zPLmGG05R0tGOwzAAq4KhIlaAivTabPD2Yj6exDFZSsx3Fw2RsPyHSJtXYzoFvs6pT1Rw2JkDCNcE5SkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430411; c=relaxed/simple;
	bh=+vm/fM11RNgnSDKFXiPqjgE60RyESaMVLmVqNLybSxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZpxmJ3iZ/m2l4fL3MAU5vVDcg36vtBwg9b2vXibDp76cOf9hGY3VePZ6Fg7CG9mmjTaE9AVkLCWEU+hrRCdPbaTFzBFeNi9SyMujA7woD8dakRWVLCrEI5GmaaBrTMuJzPpKfxpGkA56lZSHaZ1v8ewqgDa7pvQRUL1HKVXpzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAMPwuSZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uFhUl3LG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAMPwuSZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uFhUl3LG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785430409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=666E0JTI4XSrUOgv2QX80bhV9mM8ZtA6RAw8TOJxm8o=;
	b=GAMPwuSZjRTLNf5ApBoZeyRWH2/h9piPv+Mj4G3lA79iuyP9EJSMUbVYU8I+4QXm6ZxyE9
	9WGiScBjLJKAD9BLa9qw8mKOdce4o+v32TFBz1hODvq0m0Q2ycrOLwxdjEyDA53vWUDarX
	OhaD5jZwY4SrpZjWkAuFeTDun/Nor7w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-flEQVwZqOS6TUop28D6laA-1; Thu, 30 Jul 2026 12:53:27 -0400
X-MC-Unique: flEQVwZqOS6TUop28D6laA-1
X-Mimecast-MFC-AGG-ID: flEQVwZqOS6TUop28D6laA_1785430406
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49560dddaa4so14133915e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785430406; x=1786035206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=666E0JTI4XSrUOgv2QX80bhV9mM8ZtA6RAw8TOJxm8o=;
        b=uFhUl3LGQ7LLCE9xuCBZTT0PSjuVHqsP2aN2mjzkLo+SnCMk0UzHHQgJpgUC6WxOZa
         mG7J9vMLrPWCxyYLZr1DGi+8Dgxl3gz1FrTtiWJF2L1ZiyrnnFYL7NiWsLbxseDEO63Q
         NoLwMM3L0jd3fnJRhKwWLCO025NV3ZlKOuWVe3lCefhyraGjJ4ngR4bUxjZB8sQcVe9g
         zC92s0atvv7rkA8Q0peWzFcZTIPgBQoXN71xH4XYSY7a8Qb2wBlU4RRTNpzdFpJMdF+3
         DpOeBTXVvSjSsPnCLuNwGr3Ilichf2DdFrP77h1WxrYteHB81mh5Iq/MKAZ36pdnQsrB
         HdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785430406; x=1786035206;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=666E0JTI4XSrUOgv2QX80bhV9mM8ZtA6RAw8TOJxm8o=;
        b=noGkiCqCrI4w+5kW3AkpuEI2k9mH/S6PJVLygQQ25jqdXS3SXeKQaKB5gIG88jg+Bg
         QSw1cBT1dGi7QVmlNlesTZR0HBb2fS4FqXjk/6asCzn2ewCC9GjpB98tvM8Rl3t1x6Os
         HfgJ7FD41lw2ctjgk/fGFOBnYDm2q/RTzubi8P4+/mBLJvkLXD3se/fu3Al76pU8f4Ei
         /dNFLbByxWTERHkRjhkWfy2w0D+oCpLoexYNsscnlSzJiTxDFoGGvG8d8G0eZlQ+BTUV
         DK8fgkzPD89VTMOQolPLw/FnM/OpJ6h36mmUYZlUk0uLCoS8c3dLipyeSTyy2sLzNsTz
         KZmQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3aC+XS0jlQcbOwH4bNocu5eiU4FaOUCIYRmyWWbhwyCA/I6ez3au0MGpwaQRszmGIGGnkHI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOWcxOV+FUckRgMf4g6v+W9LAB+ArznBNjK0vGKmukBOQNJZl
	OSbfwsRXEBFMS1GV4WPRO3/ajsRM5qMqq1r6bcxMHwmb39z7PuBziUpcXQ31DBLkE9/cgIVZjKv
	K32WAI8+6M5seQWhTGdKsVhD5JbjE12DDmf6jHmNwIm+F42DptzNTqj5RHA==
X-Gm-Gg: AR+sD12Z3HzErTx1GCbtSaVew+7NsQ2A6R5oaRkxuClwjvGtADBTCkOjmsMrFgmw5wq
	TCyriC13wKYMnwV22RQHiKnDpX+5YuCAZO24/9gngMGwfvpWYM5Dym2iNrlVI368pfzOUaSMSsN
	cnd6dYHZQaKCIIOAzk1qv4X1f4CCD47rolCcLA1IgeBduhkXbNXh8djOcTkrI2cB3lHEUsCh75m
	2O48yoY0pyMDbSSjEF8WpEXd+IludL+kceOiNcD66w4AG0tUvPtgu5mJ8UfjYPIYWmYVtxgf/Xm
	4epIYGwm5OnCymG3yhUKBzeFb2qRs2+7BBcWxKbEgBqHlCXf4D1RqizqYoJ9HiOi6M46E9TLj/H
	tmxYaQOCZnmEb3jKzJjiSyjuDLWioGAtWcXQ8XlJwnOhhMAdFVp/jRYMC/TbBg/0UlokmsgFqNQ
	SsSg==
X-Received: by 2002:a05:600c:6099:b0:496:c18c:f998 with SMTP id 5b1f17b1804b1-49800ea2197mr49123405e9.19.1785430406188;
        Thu, 30 Jul 2026 09:53:26 -0700 (PDT)
X-Received: by 2002:a05:600c:6099:b0:496:c18c:f998 with SMTP id 5b1f17b1804b1-49800ea2197mr49122985e9.19.1785430405750;
        Thu, 30 Jul 2026 09:53:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011e4ed5sm71887185e9.1.2026.07.30.09.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:53:25 -0700 (PDT)
Message-ID: <99bfe1fe-d031-4a42-a0a8-5f39c6390788@redhat.com>
Date: Thu, 30 Jul 2026 18:53:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: Add a missing config option
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Alice Mikityanska <alice@isovalent.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260723140241.132120-1-alice.kernel@fastmail.im>
 <47b580de-9d11-46c9-91c5-55eb13c00bc4@kernel.org>
 <CAD0BsJVqmQRz1yNKMMWH1MT+kgVEh=wY=LOTy_ObeTDCsrhHFg@mail.gmail.com>
 <606acc01-e22d-4e69-ad26-a8afff262b98@redhat.com>
 <349c582c-73e3-468c-91cd-ad6cc3562700@app.fastmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <349c582c-73e3-468c-91cd-ad6cc3562700@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 5:46 PM, Alice Mikityanska wrote:
> On Thu, Jul 30, 2026, at 10:46, Paolo Abeni wrote:
>> AFAICS the target packet number is independent from KSFT_MACHINE_SLOW
>> and the actual offload setting. Possibly you can tune the target value a
>> bit WRT the mentioned variables or skip entirely pkts number validation
>> in the slowest permutation (note that the self-test will still have some
>> value due to code coverage with sanitizers enabled).
> 
> Hmm, the above makes sense for the failures like this:
> 
> https://netdev-ctrl.bots.linux.dev/logview.html?f=/logs/vmksft/net-dbg/results/754376/28-big-tcp-tunnels-sh/stdout
> 
> 971 is slightly below than 1000 (even though it's typically 1600-1700 on
> the CI runners, in this configuration). Tuning the thresholds can help.
> 
> But I also see failures like this:
> 
> https://netdev-ctrl.bots.linux.dev/logview.html?f=/logs/vmksft/net-dbg/results/751124/21-big-tcp-tunnels-sh/stdout
> 
> It's a complete zero, so lowering the threshold won't help here. I could
> reproduce it on my machine, although it requires hours of retries. I'd
> like to capture the tcpdump and see what actually happens in this case.
Ah, sorry, I haven't seen such failure yet. I *think* that one deserves
a better investigation. Are you able to reproduce locally that kind of
failure? If the such event frequency is low, perhaps it makes sense to
improve the stability incrementally?

/P

