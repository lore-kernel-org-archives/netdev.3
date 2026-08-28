Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1EE364058
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939403; cv=pass; b=DHcUKn8zSVjFXakQGl76OSQMmrIZHMJatKxePdMQhM3o/yEO6ur+2kL3OkcZSI9pLRW31t5v4Nm/G4t08yo5YISDfZ+IcbIC/h64GiKzRNkUBlfkmb1DhbW0w/UFIayGTtR4mrjBGKh3kP3Bj+yoz5KvlQiaSYKRwiEo5cBwPyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939403; c=relaxed/simple;
	bh=LQ3fjEooKPETFdFoQWnDo3gh5Lmoo6R1vHkIQ7xHji4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UA3T8a2a3AELrYn2g0T5wr5Q1KFNPNsp0PggiHH6Mu9e8nSDQ64d8kkRennrxq6DFC3yfwkDNN16KKVVneGXOxcr6vDB/+hYFmz4rV/GEqcsNbuWe5QoeFJiWdJliQ5BuabinuhIWRiWcAw102rJkhIW5ilnmWHNefbpkOVhpcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiaVi47i; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiaVi47i"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so1442421a12.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 10:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787939400; cv=none;
        d=google.com; s=arc-20260327;
        b=U9DPQadmw0CtZWHfYfKruEYrimldFR7gKw7Ud5xF4rYzAQcFXQV0JabVAY9Stxs4o0
         EwyLWGovBem9to1cRpXEWLK0E3pwf0v3IQVHUCY71UG0GeeD11I2qDnfRJ9DjQoGykRN
         eYhvbYmUn50PVqYBnqmtTJzlRYc/3w7yIgi3+typKih1BEL9Z/HtPD+7sdPL4q5PAV5S
         XaLBVqJO7vOXLd5z3ImiEYaWm3GPVGJgr8fAUb1c+FmyxHh6Gr2HsLLXDPycneBZ6vAy
         hitdzM8ON3SVtyNHQ8IMGPX57COdirkpAkHDoBH0/m81sMWkVUEEDIhEZdsB9fDASWrI
         Kfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=caNOEyBkHtDSXs15jKiYwMl0jYwy/fOio1tRTmfPcyQ=;
        fh=41ZaPgvAQkPJIxxoXCAgf46aMIeoBdZpOD4yehJGhWg=;
        b=I+DmtqIKDE4FPF2isRY1rThIM1c54LpzwkTs2ZneWmsElT9Y0xcUT0BVJPzwAlfQDn
         Wo2c8tsm21eA3AGND/+sFE90GHAt5S84Jt6PMB967PPwTdtXzKWklNvcCOpF4nUePDlL
         PC+bLhm5GxfZJwbHPrdYkEamrxy7KtXOEKQpZ8QFhCGJjHKZqEqWMxMte6FKBDYlzrHE
         A3LYWJ7LOKwd2zyZ8m6fDkDDKFWmPCuLtv/C/Sl/HQTrSo9J1nk4HTSMsqS1Vz0mSSPX
         Nltk2R7AZFoYCTF2r/u8J+cOnTjg+3q381Kw/ukwnipJf6DYQOn0gThteXXsaoH8T4DQ
         rE2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787939400; x=1788544200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=caNOEyBkHtDSXs15jKiYwMl0jYwy/fOio1tRTmfPcyQ=;
        b=DiaVi47iuaIxIr7onVzlILA5JLViLwHqlP08CqzqSJD/j/cHy9VyF8BwxyBxYXc7R9
         iCH67b3MjMhGH6t/gj108IkA5KTJBGPSJlwTaCZQCzj5AwYSQR90c3VdAQzga+VWnLLm
         fEVvweIfFALBmCIUpc87hthmH1VlGHJZAmtbWYlvHXsHmXQdPi9pUOsci3vP2ctAo9gl
         bmll1eFz2ZhjIBG9L2sXGhgoZ2N/D+TM0oHwJqVdA87wMU48upNtos8fsvuYGDSiATp1
         jPoP6LNcystR8cQS7T9To+pX4GyTW2xCsnSTN8cBfrhU8akVQD6uOdQij+Mha5VL2qn0
         MqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939400; x=1788544200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=caNOEyBkHtDSXs15jKiYwMl0jYwy/fOio1tRTmfPcyQ=;
        b=N0N4WYeBblotqCt2O6E2/OOCkba7/oqaPMXksDxScbIx4+9kF+TVOafNLuo93SXCoi
         ydwtNLFO/kUQpsjDEEfp+WV6MvI3N9UdG3qMz5k84xnPwAqBWnz2RwYClc08hZM89uLr
         qjwE5aLpkJZ6Po8sHQkj07scqB9pBM3jv3ZuSc/nHKBCkxr9QeD+s1NpiMN80zpc/si1
         DhnTUbeytpV25c61gqe3bYiUYQP0V8/mV9f+IUU7wuc9zmpC+yOlnYNoFwVS9SbJs57K
         U0HVRdaVZ0q7c9eOiICkGL1zhqfWR57GEMDje3dxcKJG/qAoDDzeD7EVjRWvASFiX0/y
         fThQ==
X-Gm-Message-State: AFuF++mkHaTTn8G3JVcbwJm2QOWUD6iZTyDg6wrmVj0pbc9AGyV5xeB1
	8hrEsavNMqWp87OAnLeKw5asdOcsfluqaEoJj8UboVZ936EnypwdicDj2dgV1YhmvajYF9poyO5
	RyoMpA8YVgBPJCAYkyz4A7Sx5RWUTdOMfGAeuLP7L
X-Gm-Gg: AR+sD13aCvrPjWiZZzBQyAS1LoQD1NY6jXUPpYdaY5Tlqmolo2GLH4EZsTuXgZnjDzA
	TnbC2iljcooD7v901YZNT2dUaNoNG6TZdbMwUF8zNklkc1OimRI5vKaR4GpJNn9kGxiQTesPL/n
	ydOVgy0lU1rkA2mFDgLgvAff8upvhAYvN5Ohe1Bk6CW1EPSXSTR2X3X6/QIeNCZQKwxsFk3R9uG
	6Vw/uLdt5eU+EYvWwuR8spcd2JaRN0b+aBthaMZbCbrffgIXJ+rFChH/z9gd9oRXq62OkR6MwMu
	poLCFpMs34Xoxg/WowG8C3G0de/6oT/pOL2AiL/LShJmEpdNiV+l2G756lKSDguCTTzIRAfqej9
	3/Jsy+VzRQFYXOXAfWPV6Rw97iELA5F54UC4v6mV/AO5/Hb5R56AgaboIILrGhfgLXnqx3FTWR+
	rOODngM5xP5uk2Qw==
X-Received: by 2002:a05:6a21:a02:b0:3c4:36ef:3dc9 with SMTP id
 adf61e73a8af0-3d26992c505mr19587950637.17.1787939399901; Fri, 28 Aug 2026
 10:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_4AD5738B48FDD2FC84E21FE59338C8DBAA05@qq.com>
In-Reply-To: <tencent_4AD5738B48FDD2FC84E21FE59338C8DBAA05@qq.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 28 Aug 2026 10:49:48 -0700
X-Gm-Features: AcwNN1WiA2DqZa6xhYX9EXD9Vx1_P4xPxzbugNgugTs7I0_MkH5lekI5Z7p3LZE
Message-ID: <CAAVpQUAYOo1hRXD_fFx9oa2bqTV_x17i7Y=vajcx1knYNLjdsQ@mail.gmail.com>
Subject: Re: [PATCH net] net: unix: reject negative max_dgram_qlen values
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 11:10=E2=80=AFPM Yingjie Wang <1075151112@qq.com> w=
rote:
>
> net.unix.max_dgram_qlen is documented as the maximum length of an AF_UNIX
> datagram socket receive queue. Its sysctl entry accepts a signed integer.
> The configured value is copied to sock::sk_max_ack_backlog, which is u32,
> when a UNIX socket is created.
>
> As a result, writing -1 is accepted and reads back as -1, but newly creat=
ed
> sockets receive UINT_MAX as their datagram queue limit.

I'm not sure if this was intended, but passing -1 for sk_max_ack_backlog
is known hacky config to get max, see __sys_listen_socket().


> A nonblocking
> sender can therefore enqueue past the configured finite limit instead of
> receiving EAGAIN.
>
> Use proc_dointvec_minmax

At least, this effectively limits the upper bound to half,
sk_buff_head.qlen is also u32.


> with a zero lower bound, rejecting negative input
> while preserving the existing nonnegative range and the zero-value
> behavior.
>
> The issue was reproduced on 6.12.80 and 6.12.105. With
> max_dgram_qlen=3D10, an unprivileged local workload sent 11 of 16 datagra=
ms
> before EAGAIN. With max_dgram_qlen=3D-1, all 16 sends succeeded. After th=
is
> change, writing -1 fails with EINVAL, while the 10 and zero-value control=
s
> retain their prior behavior.
>
> Signed-off-by: Yingjie Wang <1075151112@qq.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> ---
>  net/unix/sysctl_net_unix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
> index 47660d5..2782095 100644
> --- a/net/unix/sysctl_net_unix.c
> +++ b/net/unix/sysctl_net_unix.c
> @@ -19,7 +19,8 @@ static const struct ctl_table unix_table[] =3D {
>                 .data           =3D &init_net.unx.sysctl_max_dgram_qlen,
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D 0644,
> -               .proc_handler   =3D proc_dointvec
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
>         },
>  };
>
> --
> 2.43.0
>
