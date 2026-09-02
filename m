Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDF37883E
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335930; cv=pass; b=M7Zjdrn8wZYFtQafQuIKs8Qq74wU3yVkYsk4zS5iCFuyH7lcNRj6K62CmjIgGxLYLvQlnwS82jBo9ybMvwyX2UwZFjsljesAbPPSUBvwA2M4z0bOANdXZVPBRHQijqrJ13tttw0HvtrjzJuvoXzFrcukmbTt4vgIfcq+qU1FzDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335930; c=relaxed/simple;
	bh=rM7qgsXqJrjfU1zB9wCetpM9b1jjkKWvMBpIbuQxQ48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E25M5rklptaS35Wdj5DKl0ppOCJ4cLlDoxkbR58r2oyFvyoFm77SFvm0Diqu6EeufMBlD54a6PC2regxcdlDPdRgryugmsfIU6WBYIwkx5msYR7G1XxvtlHEIxlkJ/LglFmfq5YTb9h5QR8G/6lX6z1zJkY2UYpbKtOsu1rrENA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+s+kP8L; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+s+kP8L"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-939094306b0so74830185a.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 00:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788335928; cv=none;
        d=google.com; s=arc-20260327;
        b=r25zCLsE4aCIakDNCPaAm/caUQatqtBtXGQ+bXzVDbRfyR+Ogw7/5TM9FahrRxRX3m
         ut/xoR1cmz0G3hRXhcwTGOlmxfpH4prypfKXW/GZOKWFcDw0gr9R/VUTxGLNtvIjmBLA
         zv33XqdJrFEqWi5gnYQAAlUUv93IkulCjCFGIP3XYevModGE0n/zVAnqul6F6+RhcCfn
         YYeNsomH3RcmKZ87J8JyoecImvFR6xTGdXVwt+1JruzdQs8SqYZ3iOEVnhAwDCafjPgA
         E1ht3IWYL6JbyvBCenNi+NW5hSu/y6wiKjmq5+Su44IlgGjz1v9lSdz2CEwEKwm+cztm
         70uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/6EqtbHhJWvHC684npzEjTJ8zJmtURSOlMpn6WZ7NE0=;
        fh=MIUQ8In5utPkdPdTNhcncn6BaXaYniG8XRJDT1Sxbz0=;
        b=S/rS1U5tIN5670Ne6kAvsdY79qLu3q5U/h9mvgOQoBCCPWk5DF7xBHLPLm9erF4dZf
         w77WJsabM2+hH06ELK2k2N+2Oyz8bjGhoboOPkL8fyzWYzTnXlF57LACjIpNmpEe7L8R
         SYkL4uWj2C3hx9yRNcasIFTiqhYdqZxuQgoYT+uSoL4BOxTWF5rVugxhuRla09Eyemzv
         NTaDh/DzzEv7gIc/x87aeh6501sBsGLu8BxSgKJi6g+/KPuA4kLC8Tnnm4b30WgAVGX/
         hSoht2StH+uUcLT94NKtV1LrzbKPoeMrE4tgJxlpcT2zCfFSrPzd3tXTnDgEgZhOIPtM
         lEHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788335928; x=1788940728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6EqtbHhJWvHC684npzEjTJ8zJmtURSOlMpn6WZ7NE0=;
        b=F+s+kP8LBn+Slz4DfUKZOjqf9sAniW1GFnkxw9FjD7wieK89Ga12FpQtwDMnB72t1T
         YDASEvjZNVkxkhlj6C8RET9zGdaRf3253JLz7eOASea6uVauXWzutN33Cw7cD+Cb0W0A
         TQTxasY+V2apR9I26f7tCF7PoQhIRL9WEdhOT3sw9wHjtauXs6fr//g29+/nO4R168LI
         S43VT3BvpCKMmx5/8+ebOF3F3eqwQANeuu0Emt72+dIZNhd3biIZYcQ5mJe4vzWnaDW1
         HfzqY7aj5QQUSQ349hpOsW1sBQTOipgNtWGMFjKUThMViYsRylJnC77rRl2n4A4neCBV
         0Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788335928; x=1788940728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/6EqtbHhJWvHC684npzEjTJ8zJmtURSOlMpn6WZ7NE0=;
        b=mmJKU3MZ+mTKng/2K8uk+5Rp8hwLEkzsyWcoUFnn2Lo/kaXh2pgCCrIDWIVhcS6oTF
         XqHd8/zOqtDDg1ugqGxDoO1WxdkzURkYteJ+V3jtuew8RL6a6S9+9bFEmjv6fkTaL5Al
         CORgIYbq53sniK1QG9yQqL7L6aFO3mnuCsFOj9xl/QxrMv2vzmtaggybTcix26ohwLrx
         +VDkCOgz2tDnTx8cP5Lkqd7pDplWL1O5PkNL2BCrdpBqg7PaAUU3ZhQSi7zaBXKW/mvw
         UXRZpOMSnN5+H4wRl8/c6duUxdJOz9AEGYONn9+qXbU841OIdrCrOV/BCD/4KxxgXLNM
         01sg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8fwquifTvW3Ghy/PcR5SZXhPf6ZQtrPkeyz1OhnwMPY0kABd2DDjVuiA5VP3UhpjnOqGslYo=@vger.kernel.org
X-Gm-Message-State: AFuF++lx+cLOVcbym4y0YPzwxBshi4jSciMrOHF2frwrJEaaO5U89rt0
	puMT4Ft1mG8PfOcN11IWQnCvtjhAAZN6c70N7j2wD0OtIkAzE2WNtUTmQu8ekSIzZ6IJdE0ENIv
	PimiP1z+IyqAWYmHjbB6g0RZSNp0IwgGfTl6vmPqSj3cP9g1v/UhJTsJbhOo=
X-Gm-Gg: AR+sD11Y5OonPQOpDxWESsw04HhkE2D1g+1lXkj1S7kw3E1+DKXsf0pNKnzgp28rJUB
	f3l+VSP9fq6rRNrucnk0fhV6WHEK1WIuKIwQZfc2r1+fqirBt83WRjNr8ww/k2OyHDIFHRuqMc9
	bl2UARywupSiu2krWQTCUuFTHRhRl4aW/pJmF9DJ5jgmNMpnFK2l/9pkoBVPSNgnLFrFOM6s3RQ
	iT/0duMSV5qB2xx+69+P4XrVv3jIglQ+yw6qr6Ftf2WkPWj2dPRiypH/mDhpKuH+BTtwW26I/ih
	whmj5//cK+FQqKt4D8JjMsqJ/gR/ZBFMLuaMqHaiEfUqSoJ/IfCvNb3euY6scVerfwP30Ez2VBn
	zWD8vd+pwOSPh2OlMNoUD2QlKCFMX3wCzsZTSXMSCzfMa1IIMJl1rhpEScQ==
X-Received: by 2002:ac8:7fcd:0:b0:52f:4cd:13f6 with SMTP id
 d75a77b69052e-53036bd4ca4mr26722281cf.12.1788335458266; Wed, 02 Sep 2026
 00:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902071900.395567-1-ruanjinjie@huawei.com>
In-Reply-To: <20260902071900.395567-1-ruanjinjie@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 09:50:46 +0200
X-Gm-Features: AcwNN1VS4Ys1X8Nn9iYxHLdlNe4U2Ir54BIpZqJLNxyaWNxqdLeIIbBPDo0rEuI
Message-ID: <CANn89iJ2ppM6+MZhLP0Lu5k1Yka2qXqMvBMVL1ZzEK3nHx0iBA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] soreuseport: publish num_socks with acquire/release
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kuniyu@google.com, pabeni@redhat.com, willemb@google.com, 
	davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:18=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:
>
> Replace the smp_wmb()/smp_rmb() barrier pair with
> smp_store_release()/smp_load_acquire() on reuse->num_socks.
> Writers publish socks[] updates via release before incrementing
> or decrementing the count; readers acquire the count before
> accessing socks[], ensuring they observe a consistent view.
>
> The detach path gains proper ordering between the socks[] write and
> the decrement, which was previously unordered.
>
> No functional change intended.
>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Assisted-by: DeepSeek:DeepSeek-V3
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Split out from following patch set as Kuniyuki suggested.
> Link: https://lore.kernel.org/all/20260901024234.135119-1-ruanjinjie@huaw=
ei.com/
> ---
>  net/core/sock_reuseport.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index 29948cb44b7d..6d3c511d1def 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -125,9 +125,8 @@ static void __reuseport_add_sock(struct sock *sk,
>                                  struct sock_reuseport *reuse)
>  {
>         reuse->socks[reuse->num_socks] =3D sk;
> -       /* paired with smp_rmb() in reuseport_(select|migrate)_sock() */
> -       smp_wmb();
> -       reuse->num_socks++;
> +       /* paired with smp_load_acquire() in reuseport_(select|migrate)_s=
ock() */
> +       smp_store_release(&reuse->num_socks, reuse->num_socks + 1);
>         reuseport_get_incoming_cpu(sk, reuse);
>  }
>
> @@ -140,7 +139,8 @@ static bool __reuseport_detach_sock(struct sock *sk,
>                 return false;
>
>         reuse->socks[i] =3D reuse->socks[reuse->num_socks - 1];

OK, but I think we should fix these problematic accesses to reuse->socks[X]
to avoid load/store tearing before your patch?

This might avoid some KCSAN / AI-review reports.

Please squash the following parts (shown before your changes) into
your v4 patch:

I think that this could target the net tree, with
Fixes: ef456144da8e ("soreuseport: define reuseport groups")

Please wait ~24 hours before sending a V4.

Thanks.

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 29948cb44b7d1a8864ff680aaeb2b4582ede5ff4..8380936fae736337b902f70f0f5=
ebc1155a3bf37
100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -139,7 +139,7 @@ static bool __reuseport_detach_sock(struct sock *sk,
        if (i =3D=3D -1)
                return false;

-       reuse->socks[i] =3D reuse->socks[reuse->num_socks - 1];
+       WRITE_ONCE(reuse->socks[i], reuse->socks[reuse->num_socks - 1]);
        reuse->num_socks--;
        reuseport_put_incoming_cpu(sk, reuse);

@@ -521,7 +521,7 @@ static struct sock *run_bpf_filter(struct
sock_reuseport *reuse, u16 socks,
        if (index >=3D socks)
                return NULL;

-       return reuse->socks[index];
+       return READ_ONCE(reuse->socks[index]);
 }

 static struct sock *reuseport_select_sock_by_hash(struct sock_reuseport *r=
euse,
@@ -532,7 +532,7 @@ static struct sock
*reuseport_select_sock_by_hash(struct sock_reuseport *reuse,

        i =3D j =3D reciprocal_scale(hash, num_socks);
        do {
-               struct sock *sk =3D reuse->socks[i];
+               struct sock *sk =3D READ_ONCE(reuse->socks[i]);

                if (sk->sk_state !=3D TCP_ESTABLISHED) {
                        /* Paired with WRITE_ONCE() in
__reuseport_(get|put)_incoming_cpu(). */
