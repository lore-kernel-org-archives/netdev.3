Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5493C8719
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912291; cv=pass; b=HdTm6icNpUaCW76MJKc15PyducxZt2GJEG4HFTEk+djwuxVQEFYzatyWMYe1yK3oH9fFECEWS4cYn83wjwFNT9l7UMQGF8ZQ2QqSZSlpMLQ5ssj0Ia8zOlY6E6/9+k69CIgjUtYlCeVyVx/s746EzCUfLMzTmEiuzmxMHIZuC5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912291; c=relaxed/simple;
	bh=NVI8llz9v10RN8PHuc1M+NDDa6T12EnpuL8qipbj3F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puoUFLIugu93SjlLHaQ6TmKJ9LrrTOnqQ02hOSvv+6hYuP63c+o5NXn9mBUDsFfdAMd+eo2Wa+qf5ww+WSaQHtRDxZjkne/mgIzErAn37btI2lPJP5rMa/k5KEWTE36xf/ATIGY59dR3pZHPC06KOsxgb9B7dg66m+Z/k8GqZJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6v4SRb+; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6v4SRb+"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52b3934af3fso6073361cf.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 23:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785912289; cv=none;
        d=google.com; s=arc-20260327;
        b=De2g1V9SpvSRZSYxU64dmeNTgNslzyTtNMRdoTYHtOz/IJZKJYI3ZLLFTAnZyiDcHc
         bTlPw/mYoDPdtQessI84dM9TvVncsJU73YSomD898IqQ/AFRjWrpyirrVSMXsLQl/SA3
         HZoyR/eYKBJN2HH1e5J8vGpHQO6aq8OntsqnOGTwl5P1nmE92KCPjBy0nvfvIFvlgiXf
         UecFOgnBrJy3kicA68Cs+931UlvsVR28+By66UdkjsDFp2y5jQyaQqZeFvuORHC68LYR
         BPJlEglAWUbBriIE+0wgaNmUCQ2hwpNYI4Mv+1ZF2lzcJvCPWiUnptKgeU3zcDeIxZQv
         geeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+TxrCDW3CSJUXb9UYw/RUKQeMrL/gBrIfRmc+wRrU8g=;
        fh=PzP458soNLWPeopJciEcE/6nCRIlWvY0bC7ins/C//U=;
        b=L53RhuGhIL1agpj5rgxcq9OfL/7xSia/ZdZio99Hkymoe/rL4dz5rOBJEna/JbP5DE
         erS7sdGWbCzURREZbk7hGKCImDHzIpU2X4mvnZAhGQnvBTyKFgwnJGHwPYnFmXtf+o8k
         8ZW4170lNniwA8mWk6wAi4bgAb9vyBVXrVBE7BJIBWek25qxwWBH3xwUPV9AAp9f+Wld
         T+ihygRP9OP46i/XaGTofZqkMTceTTLHwZa/+5xSIbCk6iciTZPaUVw5fqbGcC4oEqrM
         uP511EljyFyXjdv1bgUJFv9ieWSqbBHTLZXkYqTb7ffIzOg/rLougSpuSxugVev2+zBm
         fovg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785912289; x=1786517089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+TxrCDW3CSJUXb9UYw/RUKQeMrL/gBrIfRmc+wRrU8g=;
        b=G6v4SRb+dQLxM3FPBdn/mJXXN4spMja9Q1YXnDFzcUdgFu2fy6YxUmwI/OoHqaQ3e1
         sF7nZ673bIWNEiobtIKwAgE7F2MFVU7FwXDNJUw+OZRwQxr9a/e90FzBwqqNDu8tzHeA
         apEg8QoEO/oFwu4kx74NMSKMVnnIyFKxsCRskPzQ0Ah0aCINaw+8Qo6hLbpkCL+6fSAC
         F9YkmvHE5jApQinxboElbQI3c+p4JIteOexlNVvis4+9g1Vg/iyQoAXIWv5P6pP0rJZK
         2AwvgRu83cDR/cYJsxMwxpOQXyPQE5SGy8y59XpvJYpYmYEMt0g/eE4GlpGondcCNWPR
         HhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785912289; x=1786517089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+TxrCDW3CSJUXb9UYw/RUKQeMrL/gBrIfRmc+wRrU8g=;
        b=AbCE40FNieE6ZQrDAcAnFG2JamsZCDkHLnOzNZWjsYSyHwfqGCXV3bW+Acea86zQeK
         9NV6vy53khBKmMJN5+GJZZDq57H4QIn8zKNcxg71+iQAmhT6X5c94VXZBjR9Vz9QE6bc
         tqDU9O5FxAttsvnbjRT4OreP5CQHbN2OIDui3RjkkYSw1X799vG2dxEFph1At7pxxjGE
         1y5s6Eu8fvr+QR1tblqe96xWpyv1CaLPcRBbc+GlEWDSIRvKxHF2U5+dRFDbAq8puoDI
         zSFTzAzCKZhVUCXTJZ8eQWjtDqpnblYS5r+Cf9aIiTnlzg6cA68bWorS3WaQjoXESLJU
         EJeA==
X-Forwarded-Encrypted: i=1; AHgh+RoE6OY0BaXwVlqgVd/AjNynL+glv6FUHL8Mj34Fjrih60fgWo1mSyLuXaQkdPbsjmCiZvBlRIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBTnHj5mE/5lbdP/B7lizApFrn2YPI9c1gqxUUOAVae6TLHn0B
	CiUSLMI+iFBGAeJG2vm3qOSd8pkDwhM9Fh8UEreJUWLTXeIaGxBfLr3lz1UeCsJaHcztYSiU28w
	/q40zKrVkBRndlwTNO/TpEMDQ1XDejpvhUb4szRrg
X-Gm-Gg: AR+sD13TS5CETNjZRsgKo+zosFj4Ekk1x+pXzJ365B69hjI+4/dfGzozlLnE6cQOWBA
	SqepQ1rV2tPigJZX5jSBz0i+ZVz6//pAHqCygWFNnmAn00SFoFXMvn8EMy73pUhY7ZtO2zaJXy/
	bfzYnrJ/+uyqFHwHbkjuLaCfUdM5l2g+twVv3x4rJRMNPhYEWeWu48wmZ88QaUSS9s+U1rQZV1H
	YILsDq88Cw8ndnK2H2YvQil/tUft8/O3FXr4x1p3Qj/GTv0e3w7NIWAB2zGuk3YpY0aSsKUdtB7
	fQ8o7/b5D5A/oQ5YEshZuMErF1IkcS6P/hGgeQVMrXb3y8C9orC+rDQgV9me/wVxjlQZQK7aH68
	ARIPIl0WtjDGsgWHfMYL2y85nha2vcTuauWONLMnRRQP1dSVulqzHYg==
X-Received: by 2002:a05:622a:58f:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52ce607a854mr38824911cf.6.1785912288166; Tue, 04 Aug 2026
 23:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804145806.2112004-1-edumazet@google.com>
In-Reply-To: <20260804145806.2112004-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Aug 2026 08:44:36 +0200
X-Gm-Features: AUfX_mz0nM5F__ohWRNz_qgVbkNt5Y19l8d5wHnmgS0wSGDfu1QmzBeTcgxxjBA
Message-ID: <CANn89iJrPf9BdQM3acoQB25YWBiSa9v8h_fJJMicBXZQG9LVag@mail.gmail.com>
Subject: Re: [PATCH net] net/atm: fix slab-out-of-bounds read in vcc_setsockopt()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+6c98d6eb7aabb6b1ad39@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> vcc_setsockopt() never checked optlen for ATM-specific options (SO_ATMQOS
> and SO_SETCLP) and called copy_from_sockptr() assuming optval contained
> sufficient space for struct atm_qos or unsigned long.
>
> While copy_from_user() previously copied from a user buffer without check=
ing
> optlen, the introduction of sockptr_t and cgroup BPF setsockopt filters a=
llows
> optval to point to a kernel memory buffer allocated with a reduced optlen=
.
> Because copy_from_sockptr() on kernel pointers uses memcpy(), this leads =
to a
> KASAN slab-out-of-bounds read when optlen is smaller than the expected st=
ructure
> size.
>
> Fix this by using copy_safe_from_sockptr(), which validates that optlen i=
s at
> least the expected size before copying.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+6c98d6eb7aabb6b1ad39@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a71fd31.9511d2ce.1fc5b9.033c.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/atm/common.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/atm/common.c b/net/atm/common.c
> index c7f92405daf050ecd2a507e41efdd622ab8dc6a8..6a0c5184c0d6380deaa95f68c=
b97c7745b4f7b56 100644
> --- a/net/atm/common.c
> +++ b/net/atm/common.c
> @@ -722,8 +722,9 @@ int vcc_setsockopt(struct socket *sock, int level, in=
t optname,
>         {
>                 struct atm_qos qos;
>
> -               if (copy_from_sockptr(&qos, optval, sizeof(qos)))
> -                       return -EFAULT;
> +               error =3D copy_safe_from_sockptr(&qos, sizeof(qos), optva=
l, optlen);
> +               if (error)
> +                       return error;
>                 error =3D check_qos(&qos);
>                 if (error)
>                         return error;
> @@ -737,8 +738,9 @@ int vcc_setsockopt(struct socket *sock, int level, in=
t optname,
>                 return 0;
>         }
>         case SO_SETCLP:
> -               if (copy_from_sockptr(&value, optval, sizeof(value)))
> -                       return -EFAULT;
> +               error =3D copy_safe_from_sockptr(&value, sizeof(value), o=
ptval, optlen);

I will send a V2, because @value is an "unsigned long", while a prior
check uses an "int"

#define SO_SETCLP   __SO_ENCODE(SOL_ATM,0,int)

I will change @value to an "int" in V2.

pw-bot: cr

> +               if (error)
> +                       return error;
>                 if (value)
>                         vcc->atm_options |=3D ATM_ATMOPT_CLP;
>                 else
> --
> 2.55.0.571.g244d577d93-goog
>
