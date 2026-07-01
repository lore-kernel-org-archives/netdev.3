Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2A431E7C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942602; cv=pass; b=oaAAEfR8vgsxt2BBcFxCXUY+qhpsjHpT7jU9k0HKmQuygSmwjrKJowQKs6cSmcppT99tVqVJtCoGZ4bLKXTjqYxkbEJahks7ZP6D249HDeYMXmHgnXrGLSX+dwRWj7PRueaflzo5IYARZV1QWaJYlow9fNt8vfzpXkyDRHZJ26E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942602; c=relaxed/simple;
	bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTMEWRPomA0GUZk+nOJ/2p4oFh73X6/I/ofGY9McSZL1/DPOa421rDoghT8SebCDYoB+Rcn+wXUbjU+DLhFUq26UsuylAykx/K1wqw9HE/ZmBDfD/9B5iTO2VvxNfyIsBQQsw2gNgEfitG0CsMmjPEyoyAZPOzpzT/Q9D7cpOHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jeIKBZup; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeIKBZup"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9b19bbaefso9395965ad.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782942599; cv=none;
        d=google.com; s=arc-20260327;
        b=HRXfBzUSnoiZGdKvttzlDd4yWBUyj+7IIwZel3T1oM285lVtUowCI3g67nPqKtLlbl
         ltKTT8yUO4A3RoTQD+kk3KKenG4TROWItqzPX4NuwNtPp/cVBRSqFocMg0e14zpSgwmm
         fIDBSGucs9MRaSB0fT8VqYXOfYffdn0yiHcE6BflDV+W6M/2FS8AHl5bVVIYgGe54Ear
         4Q8s3zqiWELCyjMaFcw08YZh2eIjDpD3MZmCSZiznpcSqFBrYSvSc2G/FrGtB9AxaW6K
         TZxPfOYISjCSpW4uqX+q3Z6+zhMwYr94vNe4hc/AS/QL9SD6R5WtypLDiqNf2+sZHZFK
         AC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
        fh=x+uGKcILzUzOx5qDT8pJ9PjXiZs94fXVs5XfyPwO1qc=;
        b=E3DE/H3nboRtMC7YSu+uYwjfgjYoYIk/YTsPvUviK0dWAUhPpStNXNna6Q/FvHlh6b
         5LucK1cDX3uO5h2s9xP0NiC9DIt9sQIkQWX6k+OEcHCsrWcKYsSe2VIoqbSb/u44lDp/
         +FURt+lHX3uLO/ZU11uk3PhiVDSM0UjbK7gVQ4ynj6n8cODwHMvuJm89ReoTDbo7sbHy
         z+6RdOb7HhjvH1eUzySE1qSPLt9jPOUT2/C28/nUuZK21SFu71cl4TDmnLocQCQHjt3W
         GGisPcUPhRXKT2jnSs35Uto9wRIfDOrtx+PGLxmxJSr+K+VlDQSadv9c7YdhzmgNxuFR
         xovA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942599; x=1783547399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
        b=jeIKBZupD2uAFmiEql0qVzN7IsZ7fqEk7kqd3Xa8BaERaWr4+og89gsNp5WZcA035a
         ++rqwxuSPoKYVqZOKAl6tEPV1BjifyFxTsI//o6zH+qZM8QMS483DAtQrPyZecFIvAeI
         b4Uv0Jd8aD98+ylnQxMErKttre3lbD4XqRGRybrIwKkjzVvU1zw+nkclM9KnpYIOshQp
         KclDlGFZfHWmgwHqlv2JancioAwF5uQMhBqlcBGlDLeiK6xnRpJPTDdLx5u0tBgEiGSY
         wHvIrbMqOWMBIjdTrJgJ5WJUU6IX3QFIUgQLx7JnLuJp05H3x+EGriKl6O/SAwu6++M6
         uULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942599; x=1783547399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
        b=CdQlyQ4N6FqxK8HSk+FpACHyNQH98lydheQhuQT1fOQbS/8BlaVwxOTJ4HwRX0d/BY
         YfYCVQjfGtpVFlQRNUiRnoL7hDkomjBcoJs9NwKQlnQ1AHJw3UevgXFw1I2L7b0qaUen
         UF+AIQo+1td+Z7BOkpiGyzHy1PXcAQFqpTrgS84GrmM2JFLpRB7nDz57Z6c2sLimNEwQ
         ZaB4WWDiDIkd/rOw/urOjAx9X8qTOED8YfB80cBRGTLAZ8k+EC5Hywk+8kqCmzxJarZu
         LOy+iXSosDuZ8EAOq3KkLlmngtbd/jsvMpIFtj0zdGPN17Sj5Z0pUIEE1VYcITDybFbj
         NzEg==
X-Forwarded-Encrypted: i=1; AHgh+RogS5S6mldxLA4Qf/7cjMAxN9mBOygM+40QL6XNNNlRu2VQr+E68ZyswOGuo0A3qNmv6M+20OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKSYkxMjiddwcU5bbYZfslPpMdrMytU+mHhh991j8SY+lIg9z
	FTSZKEDaxNEwWOs8Iys2zn3a1cp6eHi3/EX8UgIf4thg6131eb5dPURHqv8L5Qwb0U4330iIdE+
	FPDxzr9OHHqqIKJ9pHhnnHXFCUtJu7oWiHNunY4ZI
X-Gm-Gg: AfdE7ckxirtiMh+69Z7ksoTBi+CtNCSVGEA7WT8LnbsgN2KU6AO9yg3JJwB7ySP7NN9
	N/awTJeJWdLUYwVlGpmrSaZFTgTVvQYZyx66zNq/n9BbAIgGd1fjqp1VsaXRlYcvX7LooCwXzt7
	8NymFHgolAzixSKPdbTdCbilJ5U+vwOlgpYjHS0RI3QYIdELAa0xuTnYlbbgHfbk1aBTDX16XXN
	XRnYeprzc5u1btcdsn76lJNj5N6ubEBiwRkKTDKSnmUj6OeaHWe+neeLkU17T0Ob2sZ2AyiiJJh
	Hat+LiH10hFoc7/uFoRypeWSG23D9qCqualoNKGzGibagFB5h8KjVtOYSoNi1w42EJBWZkcmqXj
	Rk3AmBEQ3xe0xyWHXMVoI2xKXdakdj4W9rv8HmnHZfg==
X-Received: by 2002:a17:902:e807:b0:2c9:97a7:71ac with SMTP id
 d9443c01a7336-2ca7e91c1a5mr36388505ad.39.1782942598927; Wed, 01 Jul 2026
 14:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630211808.50440-1-alhouseenyousef@gmail.com> <20260701164222.9094-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260701164222.9094-1-alhouseenyousef@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 14:49:47 -0700
X-Gm-Features: AVVi8CdoooCP65yZagy1IFzbbVt52lLnQXjOFVI1HQAUaxbpxOSVlznX-wwdP2g
Message-ID: <CAAVpQUCfzVMV4NZPnTGB7RFCxrBPHET0sxnAoO6zKuUNZaFTRg@mail.gmail.com>
Subject: Re: [PATCH net v2] mac802154: remove interfaces with RCU list deletion
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, marcel@holtmann.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:42=E2=80=AFAM Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
>
> Queue wake, stop, and disable paths walk local->interfaces under RCU.
> The bulk hardware teardown path removes entries with list_del(), so an
> asynchronous transmit completion can follow a poisoned list node in
> ieee802154_wake_queue().
>
> Use list_del_rcu() as in the single-interface removal path. The following
> unregister_netdevice() waits for in-flight RCU readers before freeing the
> netdevice, so no separate grace-period wait is needed.
>
> Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface=
")
> Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D36256deb69a588e9290e
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
