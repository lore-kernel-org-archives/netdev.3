Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7344718C9
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076304; cv=pass; b=nzZNfKhNgzx/fgelS8kydDucEI3tRgkj7ukoWoJo7kLqC1+RFdfEgpz4lzcyEJBcGlsYCaQyQh0VrvJwKOpbtKYV3DjZDkh420QCAf218qMG+S9FAGda69rorbOJZ++2x6iQnmmNVssjtjNSPQxCbo4zBKjzN6Kb2lhD9Xtxp5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076304; c=relaxed/simple;
	bh=DJMwu9KTlxT/76kwpOr6QYYOlgkUnIVHv3DhHahv1qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgNUOEest8pS4o4M9txm1xBK8FpGYEZ/x9PfAaXmI1S3ZaR7hswcG9j52A6MDGn3Rr+Apf24ReR4Tim2KktbQPlLAq5r/XvzF/VgpvJhS5nLb0cg+RtG1mopcxVMAuP1qZKMv/+JZ6CRnZ6h8rEXbvr2UfZuJ9W6oczR9ce0W1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbzdTZ5X; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbzdTZ5X"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7fccba9c675so1045496a34.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789076301; cv=none;
        d=google.com; s=arc-20260327;
        b=kXg+QEnupg12rkTQdZvja9vS+78FQfQ7nmdjZaT1MpSmbRhUBNypjbb7yahye5Troy
         SbLmYg+Ns60750+4rEi47v+vfn++hdvAmYvjMjlkwH4GI5mWessQx64VZddhKnvRvHMy
         yLwAuujiPE4Ac7kBN/CUm5DiYZmpaZT0skKs08YvlkyoLajAAwtKJsbbmetN2DhS0kPy
         K+qZM1TFWj4VIhmMGQRGmYjB7rYnXipm4yZrVlnsmfShoiyeavg9wzuB4g6mKyYG9ck+
         GtjYSjq1yN0fX3HcRrmnoKeYgZrVReHnnGENG/RTewLqsJ5x60QRbMQ8jNodfxwCBYfX
         cy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZhQPjd9BPdcyQWyYvt7EkC4S/NWTkTndutMjiDfsSCc=;
        fh=artBnBkVzPwm9iO1NNiH5QZwOcPl5xPqydNWWenpW/8=;
        b=MT6xRonxg+h0lmNoPS+4vel9wCB9PZ0UEnGnO6V1yHAUwbtMGvnvMkybOn9QJP/GoR
         esM9/EKWQO6KmjEzp5IfTJkZN5KPkGOF7gBoZ+zwPpJnDo/tP8UhanmnKEWf11t63LQi
         NwUtX5m6HmQ0QOqtzy9H1udjLw0CM6FejUfT6BOePSKsvyvFqu2gV2xoMMHoYp7qI0i6
         5TB0tg9khdaVJ4vxYkj16F1wDEpL8gyhXTHLRLnxQ9NqzjWT1A7X2vaipoB6+GCsmSpH
         +BN5fsIp4VfPbzTsRiY90+FzkxXV5kzK7DhIsZQodD+5GiDjA298EwB5PbtX/wSkpdzz
         T6sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789076301; x=1789681101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZhQPjd9BPdcyQWyYvt7EkC4S/NWTkTndutMjiDfsSCc=;
        b=LbzdTZ5XQ1WkoTEaSNe7ws0YWNoos28qUbT+itWSO3Oco4YvwShf25bpbvWomd7NKK
         wn6oVOq2XFRKRFJAYZHc81nxaswo/sKTiEl9hxuwCqyuRqR/bocfSutIXpu1rUhP42Fb
         4+zzcM0p76XHAYCV5zaLvhOuUicvu32X3Ho677SOhIJyPUHouG+4hTeSBuCxYFznkD5U
         7AgdXnUMGsStwTFu1XifOful11Jh1ulxuo4NzUvTsyBUhh//4HIzzaRTPJwTkhFgh6Be
         UEgRKduQWDYJXh9PuOrnIxR8sUngioI8hWXT0W1Rt9jXVsNUuBAb9Z2O+WOBGR9qJZLw
         2zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789076301; x=1789681101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhQPjd9BPdcyQWyYvt7EkC4S/NWTkTndutMjiDfsSCc=;
        b=pnxtNjjZAN8mHnwGDBNLJXhMNJapSmtvO3uqK/4Y5TL5H/ZIDlIpK2WMzE35pDgM+Q
         GkSv7j0jm4JnVdnyG3D89JniycKQEJ51T0xxmefzTgG4hFKZqYlVkk8nfW2xxHkEC90l
         y7xtk1xJ3qgKjmsCd6bpRkWmV6mElyaJx+lgpl69MXFX0FZAN61/YJ72funjHcgPXvD+
         ehdPcOXIMD8cEhPmZ67UIGBfj1M2SCcBlFuHxCCb915fxj+5TFgPoMBN0U4icdJKXwq1
         CkSJEzxcGnZE74SASbhlByQNr/IWQqr8uXT+uVoGa1pJUK6kvQvlqC/0Z3PnO56l7mv7
         S5+Q==
X-Gm-Message-State: AFuF++mle46uzX3M4BUqKZbFyiOIQm8G9+nxwMAzP3MNprn+NKTKyB1H
	6p8+zSINr/yJ3nkQYuFZSR14eKho/HTafskAp+uOTXQAI6+VfSA+aLXk+lC8ZQK1VAHsGP+AQPk
	zFXrDnJiCQZ3lBpE8OuaV1a7kElNSgTw=
X-Gm-Gg: AYBFou2fI6ughln1zNzYzTB4V9pmdwlk1dUXDTuY93osxmSDCpXBcXBmCIP6qypYhcH
	uyEazFFZ9VWgiyJJHPwDc0sKMjffg/QpMd0htVh6dZKpVGkGmD/mqI0/KBIo7iRzhL6AV0VmyQA
	IbTeNmUTD9Wkt0NLkw9my6t5YXmR9+KbpdvGfmlhqmopYpivvgMjz3lExty0AhjIkgZk4Zf0Zng
	3H9sXtQ4W+mmpRPkgVDfBoxljw5cSGdb+B19cMGe3/CHy0yFso8Y567h3joX2xwr7KcmZJLRQqp
	nzicBDTUMSefHvogMv1JHbV50117bnmNIkk1mbolLB1FV+JH+BC1PHZ3LAG7jZjkaT1AY2AqlF8
	H5Qn/1ctLxHzCe0lY8pLMc2CamXEJtClIjJNNRXRE
X-Received: by 2002:a05:6820:c0d9:20b0:6aa:1bc8:ae0d with SMTP id
 006d021491bc7-6bf43d7ade8mr2361347eaf.4.1789076301531; Thu, 10 Sep 2026
 14:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909190541.466476-1-mmyangfl@gmail.com> <20260909190541.466476-2-mmyangfl@gmail.com>
 <40e425e2-7d0b-4e20-9880-41e46ff340c6@lunn.ch>
In-Reply-To: <40e425e2-7d0b-4e20-9880-41e46ff340c6@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 11 Sep 2026 05:37:45 +0800
X-Gm-Features: AcwNN1XDhNkpJDZMVPsslJW0cos01vLLBxJyg9QRQFcMH1WDYNbSbJYgMDc0t9g
Message-ID: <CAAXyoMPG6s_z3g8fZ5CAF8BJa0OY7uzzO5PccaR6amfmYrYYHg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] net: dsa: motorcomm: Split xMII and SERDES
 port masks
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 4:59=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >  #define YT921X_PORT_MASK_INTn(port)  BIT(port)
> >  #define YT921X_PORT_MASK_INT0_n(n)   GENMASK((n) - 1, 0)
> >  #define YT921X_PORT_MASK_EXT0                BIT(8)
>
> I'm i right in says YT921X_PORT_MASK_EXT0 refers to port 8, because of
> BIT(8)? And YT921X_PORT_MASK_EXT1 BIT(9) means port 9?
>
>         Andrew

Yes.
