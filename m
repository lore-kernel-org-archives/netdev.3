Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CD3F44FC
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201711; cv=pass; b=pXhw7fyeyVUgPl1S4V51aU/MOY9zsucZh/CCT3Kf/6HRCH4GssTebuE1o3Os1KJWsPLH47ugTom5pfv19QZlWmxLWsj9VQTrBBL7uQyyzfRNKqhjJp8pJLc90rezHWt6Zs1q1+LUdHJ7dlSVZ+Va2eBpkJyMMDWyhEGqWFH9vvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201711; c=relaxed/simple;
	bh=2g36lJG3U42LVhfO3LNLyoyHEf6Sd6nntXHxonOuu3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7uTJ87ggHyw2Irv77/jeb+8ZZxsuFj2A/cC38n7H/whNvO0BfhciOMo4Rc5MtNNHZSMUny18arvU4rWTwj+69qGVGrKpSKgeFwT6asRMZxqCuMYBbeC7zUjzdUeuO0BErXNQTOAOiEJ4uUQVxjN4hraJQZNRNhmu3+NXH0/9KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sH6DVVXq; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sH6DVVXq"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso5286162a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784201708; cv=none;
        d=google.com; s=arc-20260327;
        b=oGYKAxPhd53vs23SJ7JcxzsWrWzeq6E2g8CGQHSmJHz3HXjU+DwdHcJg0SQBmpyDPo
         AJeZGX8L9ubEx4z84aqUTpQoFa6vv6TpfH6tvyt5mAjyKmHr0gX8PpO46nBTnFkLCx16
         HZFi19S5HX+UJetCntRPNaKyP7WhBayafsdyxAHvBrsJpcF2nk8+SYBMthTiIBoNNS4e
         U0lo+66Y/chbsG+rHyc2NVNyxuWjH6YsCuthHVw5mUpYmiq+ISpFH/PZO9WMnhuhbtNy
         IEsteNEZLm/oLVaq4MtUmncwCJaFwYxVKGBis+Tce8MIIeURMC2XvSdtKpw4NeTWqQ3k
         hr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ysGs6NJRebtieFYvmOhVVH9xTxOC+fxmBEZ2c6/Mloo=;
        fh=AKuqX7GEdYxfUzlvycRbWvYtARwWhXG8H7GBDFfL0bo=;
        b=Q6DqKv5XIbnzDCFyOkWupNc0mWBxCsL1jZvfBGdAG72XAzB+gDcTyUyObsqJIzKPTd
         dkmq84TiEfHHRuQO8ma9TdUbOLfIAoJcN6PaxA+mvtsRNND7RaVseK0YlAr/D8v6GjsY
         +PYbdGSuGpD+Zo9e6tV6Mvv/9U+xZxf0Wsuef2MHmm3GeegVH2nvfE5hvSr6TYbtNQgd
         MsE0kbZloihU86Sa9Q3M4/LpgNknuJpG3c9cPkdgcrgRgWIxLBVdrYKl7c8qJrqbuhlx
         ZumEpZZGkDW6jE2UUjTxpjtwF96UcbPoyAdTWeNUzmrKznBWqXVueMzR1zvgbDGqelPu
         c+LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784201708; x=1784806508; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysGs6NJRebtieFYvmOhVVH9xTxOC+fxmBEZ2c6/Mloo=;
        b=sH6DVVXq+0bg3bPner6VRTSqoa2TnmHudaeImn8Q9khwE6G+Wj/ZRDZQCNMvYMGE6c
         U0Jc2n2nTwe28DA90oSUI/88WWw+vm0zezAwWXQDekmVbUEjKui8EcgZuDwgzDRFf3lI
         NvwK1U6x1WNnf4xyZxH+Uoj3f7zDUvGJkDuo9xlWqxM6mbSbqVDf9B/FxDrInBek/6dg
         2hXrFapKo31BWuZnufLfLc/xkepV4JWiLPxhgI/d2hNf7bT9pOpML7e1W2glo47PUl42
         nCyhgutrfnWV71ebMaVGA8tcod4ZSL1Ng/FjndAN0owl8CRTmggDyjc7/VKtMIsjV13I
         0+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784201708; x=1784806508;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ysGs6NJRebtieFYvmOhVVH9xTxOC+fxmBEZ2c6/Mloo=;
        b=ISV6fwNlLLYIcwQaZVgklRMnYkYiWmNzULaRONuGZGv5qZ0HI0khNntUHJAbU4fK1u
         Lv3UIC0rS4/98OeEGFRe2QIx/cdemc8vXR3+jlHPmiOZ+MMX4o89wD0qindRyDqOBKuB
         0cIX0T22RxtKavb3Zz9+dklnwqs7zPIi+JQRWA02rXW/jxwukXOAYPqeei+Gn84+bjPE
         gRjIgXTMC+r0JZg5Z5YRc0zkSPJJQJcbnTADMXHACsDRCMvboeAxqwwWd3Q4b1WAB/uh
         +StZiz2z5Y1apx3fO76d+iiiVQYua/mEpw6bWSfScO7uTy8tXDpOS44oA9Y7oEyWBQs2
         Bzew==
X-Forwarded-Encrypted: i=1; AHgh+RqZHLA+XE2UtooHG+1gyq5uG8EWjP82vCMe0ZJLTYDGuwOpi3HQ5Cqx8GqJTgw0KN0KP5rm9NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1isZPmPj6NMl/w3cYoDYhNhdaqvYA4o26PhnH7ApQm84Bf1yw
	A0ZITDzC5bnxI/P74OEfkxgsEzlKLXapaaR2hd7u4DEArbX/P5X6xkrf88TktPH3eXfcz8nwifE
	pG8rZwQEjcHqQAQW9wuVmOUIkxr4b294=
X-Gm-Gg: AfdE7cnxsKNBV0ypWgpUdxrwfKcWvlU9uJuQlAFoGSCPBHfIyrKcIL1vi9nb9+gL1Ri
	K5NWbosIdfRL7vbFIycrnURGwzUdXzCngYOnyX/znehUutJMmnoxrU5HHvb7eCEHBR3BcBISMi9
	6IOCufE/iTaZ/cbJOsnUY9zx+DbtshmIUiuYGNsb/W6QmSKtpLHa9jzxAzLFMJgFxInv4Km3F2O
	jfNqfWXvVUDSCx2maDeuy7XVneJ/LxciMDYd80pT8JXs6kv55SwaTxoYjIw4OfrOt7lblfqj302
	Z+/3npdmgASUlxxNvvRm
X-Received: by 2002:a05:6402:320d:b0:698:50ea:2d97 with SMTP id
 4fb4d7f45d1cf-69c5f1043ddmr11746132a12.20.1784201708206; Thu, 16 Jul 2026
 04:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714020340.25014-1-akiyano@amazon.com> <20260714020340.25014-3-akiyano@amazon.com>
In-Reply-To: <20260714020340.25014-3-akiyano@amazon.com>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Thu, 16 Jul 2026 14:34:57 +0300
X-Gm-Features: AUfX_mzK79CIL23jkyupbgkP8ZJeyWpMZHgLpxQaHMyTfs3qKuX1sAZ-6xeJP9M
Message-ID: <CAHfVqdWNk0QmvZBXi21eUKcU34DpXXZBNyJVUep+Tx1n52ihAg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 2/7] selftests/ptp: Extract
 print_system_timestamp helper in testptp
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, 
	Yonatan Sarna <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, 
	Alexander Matushevsky <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt Wilson <msw@amazon.com>, 
	Anthony Liguori <aliguori@amazon.com>, Nafea Bshara <nafea@amazon.com>, 
	Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal <netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, 
	Benjamin Herrenschmidt <benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon <darinzon@amazon.com>, 
	Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik <ofirt@amazon.com>, 
	Amit Bernstein <amitbern@amazon.com>, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, shuah@kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"

>
> +static void print_system_timestamp(int sample_num, __kernel_clockid_t clockid,
> +                                  long long sec, unsigned int nsec,
> +                                  const char *when)
> +{
> +       switch (clockid) {
> +       case CLOCK_REALTIME:
> +               printf("sample #%2d: real time %s: %lld.%09u\n",
> +                      sample_num, when, sec, nsec);
> +               break;
> +       case CLOCK_MONOTONIC:
> +               printf("sample #%2d: monotonic time %s: %lld.%09u\n",
> +                      sample_num, when, sec, nsec);
> +               break;
> +       case CLOCK_MONOTONIC_RAW:
> +               printf("sample #%2d: monotonic-raw time %s: %lld.%09u\n",
> +                      sample_num, when, sec, nsec);
> +               break;
These three printfs are also kind of duplicated, I think mapping the
clockid to name first would save a few lines.
