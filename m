Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A883CF1F6
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300561; cv=pass; b=u5eBrFxHe59DFaZF1WCjsLurFgan8vHXBP1zDhikH35wWOozHXb+2p7WOZUtwML+tznPztwOZ3ilwdsn6hnPgtKlcdrphgYqrEJu0P2Dkom7l/f/oKcYe2+8VGnGXcZCt2X9jJ1GzJuYzg7oMDudccgYj4lmMgB3zNtRySN8OSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300561; c=relaxed/simple;
	bh=qEEbW5Acjjjf6Q9/Oa8dExLb3VE6TgkjYNNxPelfcwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaPX7BZDU1FxNPKBdWvGpurM2CR9TjEDUcwc49dzq+PiZSjLJ34m4npFkPdrTO8Ivj+lbXogjYpbaiZ1Hpe5CFxfug7pWke6JkgHTOBQthO5NQhlJOqup5b1WPgFw0DugcqwssvhTqZodXVF0JxcWE3K1sZpI/Lq8VzZ7SY17D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kddbrOsD; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kddbrOsD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84830c774a0so3786708b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784300559; cv=none;
        d=google.com; s=arc-20260327;
        b=jmobXgNwegyoO0acGYc37og6G8XPrW2B8o4VCv0tLQM/Jsts3qTXeua/wU/7A0ojTW
         MjiFT8gEcj5LCDTTUwnx0uCycIve1y5uZT1OS4zWuHNnWKX+/CjTw70KmuXlVvFDhjtF
         HWAkfOYcIKegoLJpZBlgqlANGrv/UxY2V0YLFEZ1KrBKchNJLF3B5ICteV5+TTom4kTw
         kL9wd4Nv8LwCgvjcmW7JVHtwSwvo1O38C3PKylikCXPOfWlongeZZJcb0HFJ0HOSybyL
         lJVN5x8SaqzqZX0eMTe7wLWZ4ImB5vL+NBPDFkbpBOF5KW+MSCAaFH4rIFKupL+H50NL
         tZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lsvXjKCWrpF297T2YIQKbIODIw6O/FQfqb+0PfdFweQ=;
        fh=pbdXBS/N/b40Bye94mNArXY7W2q/hpJynBhmpm893iw=;
        b=MgRxS5NKsz2ptVzxm8jeJhJKwHEaTROiPuzkgdW117DzRph9/XP23JfwryGgUNH8xX
         TEqR29D+FKE/lroklyZ5QjhjqqgLMwfoxUOE28egijiiDuvY8peaaVm5Lo7wHgxSzBPT
         BELVb/hgpCvD3k0+nfJqczcW+ZQ5WLS+vvUgWs//2kcg+w7Y+zMSufQJu2PCac2zlk8a
         VCwVFhh02bSEN8GD2UtM4zAwp9t6k0sHetY61O+EHdEzqYKOILAHJvp3pzCxk+99IOcM
         +ErOLNIUXjLCrnL6dewsoMgcNG/lviAQqgQN4uFPumRbD0UeovaTSeKh2DXPeyDIA8fq
         /Cqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300559; x=1784905359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lsvXjKCWrpF297T2YIQKbIODIw6O/FQfqb+0PfdFweQ=;
        b=kddbrOsDvGBqhN5YyHQxaAKtXdVy56KoED0YOAQksrB0aMen8mPYotbQIftI3ONfr0
         UvIiB3zHdnkgVlNqo313nplKrpIXF8JlvufFEqH4q84XDWOLHBGYclCmUF5XmezwfBex
         aCMn3AOJw3WdxUp546M+dIlShAL0wasbedY01EJr/aMQg+35A0FHsZz0vzPdEIRJUI+D
         nCHHu+NOQz+xtj3DU2TIl9MTknZJ2WIA5wriU+dLMqJSi8b2OczLrjGsEWPmI6cXdczS
         8051/v2i6+XpxnlDyyw5/HT48Sipe6NJhxCtPsGnpGlbSKUUTq6u3pJTyAnC2Kfl6PCA
         ZtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300559; x=1784905359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsvXjKCWrpF297T2YIQKbIODIw6O/FQfqb+0PfdFweQ=;
        b=NGCMufDtzu9319EIsmerczBr3y1IJaOnWU7uDoggtbvEd0x9kHe/Mwcxw7j187RnJa
         iubqdWaW0nBCFvvUWTmdshe4onhZWieDRWVmiX5hGey0cbGnZoBb0eQhT/Vyi0S0DVsX
         Ixyxqsb2jd9V2eEKBDw6cxct88TCzTXtfe5uKXpu6EIDuIoPaJZY4dm+bukXSHrJQ4nd
         1A65rG314IWdebpbOkM/g0lOQCa0062YAAE3B1AGxT3zoBVsxPCHXN1zFVl2bccd19iW
         ZwGZceYqXk3UzIVyFuQIhMwLIYYh/ETB1Q3drxs5KFGZGEQp8Um9wvO0VFyS4dU2IQFq
         dlZg==
X-Forwarded-Encrypted: i=1; AHgh+RqOwpgCN8+ELLMV7MkpwYL8eVmUZdwob6jbtvOojX8kK9m0hZ1T+DLhJp0/FEA0agT69o1GG/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpqO5LljE6WQF7U4R/mOdOYeFhMV3ONlZcrtFJvSgw+nViT5o
	9orrDqCY8POCYQ1FlR3AiyV43PwcyTJNw+HY4B6mJ0Ytxf+630SYI/R13Vun74g/slkR/I5qUsK
	9zR/qQmPz2yZIDHKtVmx2zWr0ZOJ6BgQ=
X-Gm-Gg: AfdE7cnlxjIZqli8VIGFcQKtC5xymKZx3vdwSQZDle6S5l8pQuryeVNXF/+4uujTfg9
	Xiu75Cu1DoHokdbTqTYFcVhxXongs67x5o102+hZyk76Rmkxsc8i2pd+5si7gNN+xRykNb/6iP7
	HxjI0pI1Jsn75yn496V4V55NLz88g8FlSvw+2e3Bd9g7IFhYWFPsheqP27TeJE9q2p4GAWfzdHp
	xar1FUAui6CcDSvT05n04kSNknqZ6ym1bj99aFfKgfmJjJAgYvYjv8TgTszKxenlE4qruvAOKAm
	iAy6C3VIZwiXCj2PI7stpLtomQ9mXy6pqcWReqP9rNvUFkW3EQQfQgjsinY2i1svI9w94WwkUA=
	=
X-Received: by 2002:a05:6a00:139a:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-84c2922a528mr3225540b3a.6.1784300558445; Fri, 17 Jul 2026
 08:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716100407.1490724-1-l1138897701@163.com>
In-Reply-To: <20260716100407.1490724-1-l1138897701@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 17 Jul 2026 11:02:27 -0400
X-Gm-Features: AUfX_mzacL41_5RI_8RBYLDXx8x6p-ZqvJM8aDbApEfo8clW9MVUixLT8Q53joM
Message-ID: <CADvbK_e4StN7-vSRjYC_FPMN-_3xjwhCxYUb+Jddz-akO-ryPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: sctp: socket: Fix uninitialized error on
 socket shutdown
To: luoqing <l1138897701@163.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luoqing@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 6:05=E2=80=AFAM luoqing <l1138897701@163.com> wrote=
:
>
> From: luoqing <luoqing@kylinos.cn>
>
> When sctp_skb_recv_datagram() detects sk->sk_shutdown & RCV_SHUTDOWN,
> it breaks out of the loop and returns NULL without setting *err.
> This leaves the error pointer uninitialized or with a stale value,
> which can confuse callers expecting a clean shutdown indication.
>
> Compare with the generic __skb_wait_for_more_packets() in
> net/core/datagram.c which properly handles shutdown by setting *err =3D 0=
.
>
> Fix this by setting *err =3D 0 before breaking when the socket is shut do=
wn,
> indicating an orderly shutdown rather than an error condition.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> Signed-off-by: luoqing <luoqing@kylinos.cn>
> ---
>  net/sctp/socket.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index c7b9e325ec1c..ea7050b27715 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -9117,8 +9117,10 @@ struct sk_buff *sctp_skb_recv_datagram(struct sock=
 *sk, int flags, int *err)
>                 if (error)
>                         goto no_packet;
>
> -               if (sk->sk_shutdown & RCV_SHUTDOWN)
> +               if (sk->sk_shutdown & RCV_SHUTDOWN) {
> +                       *err =3D 0;
>                         break;
> +               }
>
>
>                 /* User doesn't want to wait.  */
> --
> 2.25.1
>
This patch doesn't really fix issues, please drop it.

Thanks.
