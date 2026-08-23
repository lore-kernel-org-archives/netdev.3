Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D630B509
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787496712; cv=pass; b=bOTISzhNOA4912owdUUKUVmVUwx1bZMGN0fBW0NqJdadgk2FOtcXbB3UjgAw5gb/kz8DmbahjyuJHQsDeMdXy+CdFCxSkWF8OdeUBHnERRVgt3w/9qZSZm8weFYqJ65Ks/7dgddj4DjxxBvx1fonnBWnYMZEudiyxdJHhfIJVhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787496712; c=relaxed/simple;
	bh=Le1qMMXndZqMhyvPrNPrroqdRA/dktc4UX2DKI7dx+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lz6e50vi47XwYX7XKmY9zc6EOeZT2A9Zpi7ZFJdKXLqOpBpGKnpUx5ylz/NAxxObUNQWt/jj80ltVjzlgs4n/aF1/K9ZICMdC3UjYh5kXDtscEh3PT8ZvN0JgTJjjZxb2CkB1X0FUWGR0egN4fsGRY71iNHNO6s3d041TMfvcRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFB9IZro; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFB9IZro"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e7632b193so145179585a.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 07:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787496709; cv=none;
        d=google.com; s=arc-20260327;
        b=N8FAUuggRua4SFh5+wQ+Yq4c//jqzCX0ZVHhQGxsK10IVti3W8E8ztZsbIGEWHJ4iy
         DZ6Jd4NbhN3eWEMSf/t9cwRPYGNXT0SHhpV73DU6zliQcX8Fc8uy86R1kip5viP5LXRK
         mGC15qehwQly7Nw3fSPJBCENK0N0v7DiXQ3PQdpPv2V8VWiWJaoX4oBWNArZlE6psP4h
         h+PA14Vi2n8d57rskupFIuvzmBO7U38hMSMTsGMEQ8V2e7f0/e44nqi1qd31xwN0KToz
         l0SdkKg5BUsM3os56Lw7DjwFoLRVp/K1CYtbVaSy75pmxlEEl6K3SBsBycJApbtQEegD
         3M7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xwG6NI1rbMeiLX/3P+c85FlciFYa4SxM2JUZchrcE58=;
        fh=6/uIM/oxSw6k+K4Pn7E/3JhLie3n6l2yVsXjOTq0g8A=;
        b=pai1PDGo0vJwxt4XWCdw5+1Q4A7meSxPkkPSOWKZ+N4sjAvaOnGJvJvi0iS07MFUny
         XVtvupsZSULugTAxaX/SXAmY/7QF1148OqyAEentD6dLmX1B1dGHMoflBGdbr8q0pWQI
         L0f5b85JxQzHTZueRMqVcbLxm3NpK0QIovRtTV6XeOocwuEHuyGcOGp58Nwfr3+jelhw
         4L582zbF5xmiORpBshZ39sGD+6az9l3MPh3qyWivJ4/6Qn9Q68h3HMJ2IoE5b54vftRP
         UbX/Ur89FX+3WoGSkrPbZak23lWgT5zK2MDMKUXDxzOHsNDCMZ62Nb88wDWUxH/oDBlK
         cXmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787496709; x=1788101509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xwG6NI1rbMeiLX/3P+c85FlciFYa4SxM2JUZchrcE58=;
        b=VFB9IZro2Qw+C8MuStZLwrrWI0Acqv2qTDrmkawNTTBjRcK+N8dVQCZd61Uon+8Fcr
         g7BUn3mMS0lMNn/CmnlRgA93//ulGIl792lyKL86EKM/Auxqg8ZaqfbHNC5BtzpfT87S
         MBI6p9YaWDymQdlELBMZW9+ULcoCHzHwJDeUj9hTMX7zL9Wm6yeK7MXHOUgyBUF51dEg
         lDshmXCe9U5I1Bji+bGI+5VWA29CVZunSQz3JNbqp1RNEaGrEKpe2gB7/tgwmA+bf6Ql
         QpyUNQGdhNLWiiIKYCdGqxIpNIFrd8hsb+UXsoe12PY24C4fqk80eGdCu8ffquDrpaA3
         Nt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787496709; x=1788101509;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwG6NI1rbMeiLX/3P+c85FlciFYa4SxM2JUZchrcE58=;
        b=XBkto9LX0v/Jgaw9jwR5baqyEerYY9WPFWnawFpEOk7zwABGb48eu0jS1Yc0OYubnc
         F0w8sSAqLeo4qRgkYeXDpaLjOPj77+OwJJB+jdutGrIV9seFT48cG5vduuz78IGy6vrc
         E4PoFrtuVm+tU4TEuIIB7tpdj+YEhBS2uOqooF+eZOUSmzVObcB1OIweBUkBq2GEXOtZ
         C0+BMkBL1tS0MuU7nV/dQhpeZbKFP01P3Pbvr/D2CE006B0tUy2NQxaFMqZxs4RVDhi1
         hawWkUbTblylImQLf3tW8FWupq25k5h1coTd4b24QImpSsKxs1iW1J93S7GZSBKzEWOg
         1SKg==
X-Gm-Message-State: AFuF++l9KWLJyCGzZDQ0Xrx0tj98fI6FiXw2XUKlOaSeuarkmh9YyM03
	QX8w6acFBI5xbNoWvQL6dzVDTVtfirlP5oEz7maAAIJtXfkdWEtn9mdVnf8sgQAfgGvf3B1tDb2
	myOW2S3sDFF5FlAKma38TEY87nQZuwS1G+bWSx7RATbnjxyChrDqvBSRbPqY=
X-Gm-Gg: AR+sD10YIf2rfIKZnmtgfRHazew88UoqzNecLppd8cV9giThzeEJeZf8fkW1ASK8QHK
	dm+gIdatXwR1uVqyTF69GyNENP4SXO6DiSiaC0N/3NPRMTbhyeL9W+dZTKpYbCITi/inodIJwih
	32k5Z+hO5aqMcGxQvUYFxfqx1yf6kQFXPiEFdEaqm8aukvorchWx6HB6qs+TQ24ng5jUeOtWLSO
	VaDfpxBWK31ew/67BQeeqmeiIVKsLkA7SVsOJiCEKIKHKlyJWAfy+dsnGC2x8GrZTQyU5K4zNHO
	dLiENI9NxZnVSc0oH51HvaaUK9u/py24YnI0lJz56IWGcng1R/nimWlKf+zcOXsard3OFz0q8EY
	cm000awRqdw9wMdlIO0zEnM56FDS0tcBY2j3WVTXy9La2Jn4omCBY/AXz
X-Received: by 2002:a05:620a:3714:b0:936:befe:42a4 with SMTP id
 af79cd13be357-93739693082mr1777467585a.42.1787496708724; Sun, 23 Aug 2026
 07:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823142620.126424-1-shlomojune6@gmail.com>
In-Reply-To: <20260823142620.126424-1-shlomojune6@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 23 Aug 2026 16:51:36 +0200
X-Gm-Features: AcwNN1UvSqU38SAKixc2_G_TDw1LEOp1jNSBCTwPktQLry4hJ_0mTRvDAKBudgo
Message-ID: <CANn89i+5o16tSTk9MpLE24nCAn+SkMeZvHv0W=MqxnXGZDBBiQ@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: reject invalid pull bounds
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 4:26=E2=80=AFPM Shihuang Liu <shlomojune6@gmail.com=
> wrote:
>
> skb_maybe_pull_tail() subtracts skb_headlen(skb) from the unsigned max
> argument and passes the result to __pskb_pull_tail() as a signed int.  Th=
e
> function does not ensure that max is at least skb_headlen(skb).
>
> This can happen while parsing IPv6 extension headers when an skb already
> has a linear area larger than MAX_IPV6_HDR_LEN.  Once the parser needs da=
ta
> beyond the linear area, max - skb_headlen(skb) wraps and is converted to =
a
> negative delta.  __pskb_pull_tail() then passes that negative length to
> skb_copy_bits(), where it can become a very large copy length.
>
> Reject this inconsistent bound before doing the subtraction.  In this cas=
e
> pulling up to max cannot satisfy len because the initial check establishe=
d
> that skb_headlen(skb) is smaller than len.
>
> Fixes: 1431fb31ecba ("xen-netback: fix fragment detection in checksum set=
up")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> ---
>  net/core/skbuff.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c82a147..33022f7 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5838,6 +5838,9 @@ static int skb_maybe_pull_tail(struct sk_buff *skb,=
 unsigned int len,
>         if (max > skb->len)
>                 max =3D skb->len;
>
> +       if (max < skb_headlen(skb))
> +               return -EPROTO;
> +

pw-bot: rejected

Please ask your LLM not to slow down the fast path, and find a better
fix in skb_checksum_setup_ipv6().

Note how skb_checksum_setup_ip() is fine.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d4382b68d56e0b3b247868b4d29ab383cfcf7440..f77d7480594ca6a1dcce2fea737=
e421d5ea2d38d
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5974,7 +5974,8 @@ static int skb_checksum_setup_ipv6(struct
sk_buff *skb, bool recalculate)
                        err =3D skb_maybe_pull_tail(skb,
                                                  off +
                                                  sizeof(struct ipv6_opt_hd=
r),
-                                                 MAX_IPV6_HDR_LEN);
+                                                 off +
+                                                 sizeof(struct ipv6_opt_hd=
r));
                        if (err < 0)
                                goto out;

@@ -5989,7 +5990,8 @@ static int skb_checksum_setup_ipv6(struct
sk_buff *skb, bool recalculate)
                        err =3D skb_maybe_pull_tail(skb,
                                                  off +
                                                  sizeof(struct ip_auth_hdr=
),
-                                                 MAX_IPV6_HDR_LEN);
+                                                 off +
+                                                 sizeof(struct ip_auth_hdr=
));
                        if (err < 0)
                                goto out;

@@ -6004,7 +6006,8 @@ static int skb_checksum_setup_ipv6(struct
sk_buff *skb, bool recalculate)
                        err =3D skb_maybe_pull_tail(skb,
                                                  off +
                                                  sizeof(struct frag_hdr),
-                                                 MAX_IPV6_HDR_LEN);
+                                                 off +
+                                                 sizeof(struct frag_hdr));
                        if (err < 0)
                                goto out;
