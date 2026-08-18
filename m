Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2230E82D
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058425; cv=none; b=SUqeu8eNOGoNuAE7E1vcfdGQHZiqjM8alm/MR5YKQuqc5sFU7OKxnOT9TN/qurKslvaMsBNYDc4kNSL4n9El3KV5lUM3kO9tTMaKKPz9YtUE9nZy0fXe55V9lQVR+k5BXMV9evr/TSK6XQtgpJGbmviXEB/bQLifgmvhNzHx80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058425; c=relaxed/simple;
	bh=Lr2w9IXbYxpbFpQSuAKStGPPX8TW/VF+EciAbzTXQiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLMIM5w55xfqtQf5sceUgKiNSMV5VZ5d14nu5sSF2wrIc6kAx9sxfqa7yCUKln7ALUpWXNMdPw0m77dEMhME79waVgjd+7t+E1sbpKTjCrDFATN+UqSLuAQ1hVWR8AZQjOoCYd1yTs5DHZZ0oe/wuX+VThmJnx9Jh0kHqjCZjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2022323c37so579692066b.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058421; x=1787663221;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fBVB3ojX0XqGX6y8ulL4F2m4TqvrNnncf78A4xqUgHA=;
        b=Ag/MHbBpA6I87L6p2dTBE6KsnhVaomFA7zSonvLLVOLBJ8xCqPjyuzJaeWxR0l+IDt
         ItFgEXWqmlvQdrJIYJ8SkUcNhv3YyRJjBDU2M0naw2M3KHIGzy4HcDLUkucdcQ0iVCh5
         +thRIjhpPnvt0z9DCVXi7LdkP3MBUZdcXhzsRR889x3UxZ9aTOZeYtB8VXyfoQZUy2OK
         mIkRrWPJn8BmfdZy34QZrr8VYAJavPtRZz9x4Yf/eJYQ8qbkocWTypHEY+bp/1/hjISx
         8v9C3nXXD8N6AJdw2OnUi7/COc7UOgjdVvtG91AAE9zJqL7QT4K077LYU6Tmct5yeax8
         I9xQ==
X-Forwarded-Encrypted: i=1; AHgh+RpH5GE033D0+5/2A7DBnW6V8F8uSo/e1c4lmfp12gZ0MTm+4soPGBH6hTU7cUVMBnUrsZwaNvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdjGXDTQDw87IeraLmC86mihWQIgAsywjI8lZW5VcZfBQ5kDd
	hiYIwQj7Iw1jQzZW/brqJ8LG/8d+T8PVuB8Kf1Q1eHd17SoPHcofSflmXcFaOFviGBc=
X-Gm-Gg: AR+sD119WbJQUy3dcfVuTE1hQ6Bx6+i2R+DyTFkl07ARvgiSj2zhwPhctO05ZBRtMrO
	lDRGr9c3WhVoHBVWpBBSSVKsB7uRMxzIKH3Xm+PuGKnySv0zTOm4+svFFluautxFI40urJu1+8+
	i5CXotsNUlLZE3R1RZScEuZyADRJm+KqVAffwSWvOxHgYUICrBLzlzXVAVE7TVZ5oCVvkZ7iOmg
	EyesNoYCNpTJwOuA1ErrBcuvWqQkHkSVAiYbnSp6FJPyF/WdwkMa2mqYDUGqpRlmipF8QEuEEAh
	bpru6BxiYjkwLapdpMOTGoN6qBuNZWfHoNS6nqF/ZoZr28qZIcrpMLbOUYwkISedwylRwvmycGs
	1lHfDAjeauQtGHYPI1o/kiaxRv2hnyhXddW7RVGlMzSfQCWkgynO5wSzjyXUMQpRy6kPppQhDzu
	f6r1E+/EU2vqkHdOeFL6IyIS829iN8tWi7t+0hlZFKXtOMpgjh1yzv2B9ir0yNH1CP3JNWEFnia
	HFLIOycJC1vEOZr/HJaVOJG3g==
X-Received: by 2002:a17:907:c17:b0:c16:13e7:fd63 with SMTP id a640c23a62f3a-c21291fdcfcmr1624234366b.0.1787058421258;
        Tue, 18 Aug 2026 06:07:01 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b99167sm143236866b.48.2026.08.18.06.07.00
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 06:07:00 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso6927655a12.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:07:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoO6yHSc55OqSK1xH6yuu/carS+f89BijOCjHehcnvAdYQsEMfFe3CBTDE9nGyOjxIdxhLUSqU=@vger.kernel.org
X-Received: by 2002:a05:6402:249c:b0:6a3:8586:9b73 with SMTP id
 4fb4d7f45d1cf-6a38a926287mr16210086a12.6.1787058420304; Tue, 18 Aug 2026
 06:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_2EBD0396FF7A54CAD61F16E942D2E8FA3A0A@qq.com>
In-Reply-To: <tencent_2EBD0396FF7A54CAD61F16E942D2E8FA3A0A@qq.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Aug 2026 15:06:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKDLSKJcHaKdn3Vigi8YDLCLnNSwgwimDBymqWf2yjng@mail.gmail.com>
X-Gm-Features: AcwNN1UxeX0gJVCFIuYBZOc1kAkUVD16y3L5ZDWVp7YzSofvA4LIsWhA_juMV68
Message-ID: <CAMuHMdVKDLSKJcHaKdn3Vigi8YDLCLnNSwgwimDBymqWf2yjng@mail.gmail.com>
Subject: Re: [PATCH] net: renesas: rswitch-main: fix runtime PM cleanup
To: Jiawen Liu <1298662399@qq.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jiawen,

Thanks for your patch!

On Tue, 18 Aug 2026 at 14:44, Jiawen Liu <1298662399@qq.com> wrote:
> From: jiawen <1298662399@qq.com>
>
> Update renesas_eth_sw_probe() for the confirmed driver lifecycle defect.
>
> Keep the change limited to the concrete operation shown in the final
> patch.

Please write a better patch description.

>
> Signed-off-by: jiawen <1298662399@qq.com>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
