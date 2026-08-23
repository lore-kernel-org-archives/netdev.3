Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39443382F15
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787500727; cv=pass; b=rlDPwRuP7lKSQyy1SffI+iDilEd5Gv8IDFZxOYssGFzLv0xnJbn4O1ESjdAkZk17K9lHWxMhGgHEK3PJYSul5zL+UWZ2Hsb/zFhOWr575JolgAMmrYJ8xODALf3GH9zwEZfp1PnS8XxPzClm6Ot3E0TN4BOAgu+/KM6NtURJ6+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787500727; c=relaxed/simple;
	bh=EqoSXCozohxVBrBNNKAf60wsGKLZ51hu6DjyLqv81EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wxbybo8ioOPt4hOABOOCYJU216jnmzfDgsbM7DRhB9cHqdwuMM4/JQ6QyR9RCAtUiQPVCjUG5wC8LBOAcyZHujhzvKlg3ZPX8fx7gAg5Jn0eZAKFu1PgVfdRo7+TPTJLqFevgJW0f4loJrvJ2sOAZMpVT0OPiaZkuBys/Xq1lZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBnGSZSQ; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBnGSZSQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so9259a12.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 08:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787500724; cv=none;
        d=google.com; s=arc-20260327;
        b=RORZ0AJdOi6EOytcfY1h+FGknr8lFEHkstngFLB5/y4nYsBQm1agq3xZcNhtmhxewG
         BHdSioxEsn380u4EhB8NaiExw5N5/7boY0v5OjJ159ts0VKZqENNVOP/1vg3+2kth9iF
         IGEQDkiSU7MJLK8zx04LAJ/eKNuMiopVZNGhCsv0usdf4u93iI8K4n5NuS8FPQH7rU5j
         bFGnifjg8PBC+W4/iV6ZsB/NExNNVUa9txX+cE4S5fabbJl2ENTSBCFYKOws9iGKuapJ
         Slip8dr0ny+XkyCEQ0+405Lkl3AOqOfngV2lZqCh4vIATF5Wgx9yH8/wm330lphvrMW0
         h2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EoeLz4yQvLM3SVqMjn2+qrE5zZs3IbINfOVKPk05JlM=;
        fh=OddXH0vAx8Bsp35UvR9YV3S7YluMvxgaN63Fe+Dp7YY=;
        b=qOcb1aFTHI1M6+BSbJ9+tHNkf0mCjqt1oHTxQonQQB/cNiXYU9gHfIFrqvClyWuHkz
         66L0NpoCwUMzZ+MDy0E11mXnaFaGttJvyMHxcxpQVazvBYgb6+0wgcNa3s2r1MefFL8t
         SXBy17CKJF8xLkOev8T3NRROUeV8GdzF3IZYa5hl6aint3/qVt34ZM95j00LYVpJ33nP
         X8DGWE6a5E8X+o51G0ONddpW249sxsIjFHY92Zqit85WxTh7Xng9O1d6Lo+28ADhCtrT
         ZFqrUWVhsacamc41jWta0b28TIgvNOTpyDBUHIOwjOycFq9n/JZyao47xKL3lGV7Uv5a
         ByoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787500724; x=1788105524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EoeLz4yQvLM3SVqMjn2+qrE5zZs3IbINfOVKPk05JlM=;
        b=FBnGSZSQYrMfydsUSlgKQrY/QhpkEgFEAiv5CL52kjIB4CGGfEsMCgqEoJ/4RWeCYB
         1klEUqVznVcYLaPRav8Lbf27JXIVTREtk9kOMcQarbe0B+Xr9efxVjrw/ayGlqXQwmV3
         Q7eOyaiFdw53cIJNI++WCiQXqFzJnTL3q4TqcVx8ZYbts6Mcr/Qfn4HaEf/WJxZO+X5b
         hubtaZp6U+p2yV2p67oOO6g/JGK337I5dDTRkPd8/BuL4S1CsHy7PjnC53/91v8hNTUJ
         31gTDahhqO76YhrVPRP/eFfGqij9ObX9qShy/nHdpyV/n1xFY9sUYvZfrjAZLOrs5pj1
         av8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787500724; x=1788105524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EoeLz4yQvLM3SVqMjn2+qrE5zZs3IbINfOVKPk05JlM=;
        b=W8AkwlIm8kkIsIPxDJCZLmZVza6BxNdOPopUHdEyqQwTxGtmYqQ5tVTr435if5z4YH
         w0VAzQxGestOfxBpkxecQEq9I1L8J2JCpoTJVbMv0N92L2kVVZYxUc+MMmM4rBlnG5mk
         TNq7FYAheioeLXvfD//EE2sX18nU7yAaO/pe3/kn+VPZraMgY4JcFPuW8trqHVAbyqRC
         j5ERpFhKOAE2P+enwCoIfJuenkNn87U5VJ6XRZAUelZ8GTpJGyj+Z4gBZrkPuOTayIgA
         aaRvmv0NqaAzemfcED2IygmWLANDWcEv3r62WilXovDlPEHL14xDhBMkBtg4NacKJLpc
         CmrA==
X-Forwarded-Encrypted: i=1; AHgh+RrYOqhyCnyabbkc4UkTIRljTZJks0x+JLKveNepdLmilTX/EtdO//ssvczN43Y1xRxbhS0V0jg=@vger.kernel.org
X-Gm-Message-State: AFuF++m8GiQzBazDLtS5DVCsv8WKGgvFHOjgRSGVqDtd9KReP07bV9E0
	wxj0OY3gAfnsduqpNzbuxrJegD/F6qDRnG3Xd+er3yBKdOnImGhUMwaAb0DzNTYL+8ngVAXeyNF
	nD3PDlOuutYDkm2/Xig24LmOcZQG0UxakJZc86+Hs
X-Gm-Gg: AR+sD12MGQOQGq1BAxHA9Gky3Y8ygMsGYNIbhf9bYrtbTU3GT3RzHi0GloYo3ALugNy
	fhl46UUa6UBsVvsJwboJUS7vggvMveC/tAF293/xENvQ42eDIVfcQe5jN6sQEGP0eewwyagVDka
	fv4M+dT8NOIeOQya/BonfWVwyAmaJwx8jAo7qR/wPvjQ0O42ilc+gPM7Yx2saVuGhrEXxn66u4b
	mqcC/7bcD/CMU1nHq1eamVj41uZoFvfkQKk9S28vYssPvMcZRlV0dprpwictfMhs4dhW6pSCWtZ
	I0Q+kYtyu1Hnho3QVLowTieZ2XXu22pl5pKjUpHHMDs=
X-Received: by 2002:aa7:d50b:0:b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-6a58292831emr41884a12.8.1787500723593; Sun, 23 Aug 2026
 08:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddb2d77e49974232b7f379851dc9809c953a6649.1787396169.git.asml.silence@gmail.com>
In-Reply-To: <ddb2d77e49974232b7f379851dc9809c953a6649.1787396169.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 23 Aug 2026 08:58:32 -0700
X-Gm-Features: AcwNN1UWE1pxjGV7yl7UEId1Id6bQpQzQyg1xpt5sB0Kt_FWRHozG4lHzalknPE
Message-ID: <CAHS8izMLw5EwR8Fr-0F6S8V0dYgyGe6UW0dmy0EurfHU5TswoA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: reject non zerocopy devmem tx
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 3:57=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Device memory send doesn't work without zero copy, prevent
> tcp_sendmsg_locked() from falling back to the copy mode for devmem in
> case there is no NETIF_F_SG. Currently, it'd try to copy from iovec
> filled with dma-buf offsets, which would normally fail with EFAULT, but
> it's still better to handle it more explicitly. A recent net-iov / page
> mixing fix also needs this patch.
>
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  net/ipv4/tcp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b694..f403830af65f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1162,6 +1162,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msg=
hdr *msg, size_t size)
>                                         binding =3D NULL;
>                                         goto out_err;
>                                 }
> +                               if (zc !=3D MSG_ZEROCOPY) {
> +                                       err =3D -EOPNOTSUPP;
> +                                       goto out_err;
> +                               }
>                         }
>                 }
>         } else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size) {
> --
> 2.54.0
>

Thanks, I was indeed putting together patches to fix all the
pre-existing issues. I think the code assumes devmem send means
binding is not NULL, and the fact that we efault on copying is lucky,
we should not even attempt copying.

How about we reduce the complexity of an already-long
tcp_sendmsg_locked function by combining this check with the other
ones? I was thinking this:

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d6..1e34f50770446 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1170,7 +1170,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct
msghdr *msg, size_t size)
        }

        if (!sockc_err && sockc.dmabuf_id &&
-           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
+           (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY) ||
+            zc !=3D MSG_ZEROCOPY)) {
                err =3D -EINVAL;
                goto out_err;
        }

It will return EINVAL instead of EOPNOTSUPP but I think that is OK.

--=20
Thanks,
Mina
