Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F413D9535
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366284; cv=pass; b=fzCVEXGIgM1i7mFkXPoxlkfl+1FH/Nt826oz+Do5Df/Hjyzq6yWXzzA5tYsWpbZbZlffPqZs/lM62CmVWC6P7RvgCh6mUd+k1FDi2lmwuqrsIJllTCLLZ4vUH8YJL7hOTgMSjcAgQoJM+lc09D4R7yCr+1pc4j9T6z2Fmswltvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366284; c=relaxed/simple;
	bh=Crv4KgfOE+Xtxush3rEXQDkv5GM/zqtnns5DaHmFCKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwNzieXmRlgbmoyDMl5PH4rslkNO1nkHzCNxhBWLuiooewqQ/0refSHVRxd/DocIBzKsDw3HPiB6/BF2usW4qxa5Ab0eFfS0OSJtEXQzAd64M8agKQC21+x85FS+UWtFKd+KTR2eAR7hiJDE9SVqHhQBFtWcmyNAkKaFmxdVdB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjjB3cVU; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjjB3cVU"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52d354b1061so7642061cf.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366282; cv=none;
        d=google.com; s=arc-20260327;
        b=sm0rw6eNmrbZlnyLtxAqcTnGRU/+UFKFcbGKHFmJN8HDwBR2fzPXOYaHWoieFw/SzO
         Z/lxW87DzX5af0/DtQTABJEYjz45hnJuaTO3sXQ8/fZqwzWQCIXraFDKZeQ2z0QbW7By
         rbrPeU+tRGa6somxc5Cfs74zX9dj+m3YglHLWy9t87UHhczOxm2zq592xteZFTnYuGYi
         RwckrhQkKHXwWZSyTajxm0uxwWWmJ8a69qpzxwU9LSY+HHoTMAPZIg/i0+7PptPHTmJc
         ABYdjL7XGzi5dlgyvbiLL4p2Ag4bMOB0rBynwScZAvixep6KGiw1u8eFOIQ78Oap4dot
         walQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R3rERGLehyZyoa+gmHCa5mwnC48oPkKGAEl7e/XnSlM=;
        fh=NedyThYAnBGNZe5NkXMR3qyS0CgvoPmGw8v+yo6ptvc=;
        b=r7oZJUnaSYVy5Urqywj1Wc1VvB6Z92bcpX4m+I8bBftftbbj6/xI2VDWIIbm040ip6
         CrJ8au3W154pUE44mZEwZ6RhUHEtPrZsOF0+UrSIGuNYBO0izYlagTcTh7ZK+whqdcMG
         u49DaoPSrhWq5yz/nxOINU3hmRpvFsgsZalCvbVjvPYIEICdp5nNL1A3pdB7Xz3XJ85v
         8pdgCiqiqo+u8MHCibFX4vLpdSACynh69Cl+TLrX1g3iemvmzhlMUBJHpvPd83CH52Ca
         oDqYrwk7tOVGoTg3EKKrzNePc1lPetdKprfhJ/NFpBMzogwQ52Iu4BlXqkr+ypCYL71t
         h6/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366282; x=1786971082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R3rERGLehyZyoa+gmHCa5mwnC48oPkKGAEl7e/XnSlM=;
        b=XjjB3cVUmsox+a4nUTF0v3tBKZu7AzWrmkamcQ3/MnWfDZSQ28TWbAzqV7oTTYeR9M
         bSBctF6fmWqSkHnUCW3EejhqFHi/hTWmfckhYNapYLzWDvuBvvNenGRXuE65FuB+hmwJ
         8dEMth8bpKW/TrPJoGnQkyo9BwfIAJIwogSTpq9xSoxNBI2PX5NZHuCcRzCxn9E2LGEr
         VQC5HMk46y9OQb4EYvMXz0Cok4TXN7LqgGV5ddQTQPxBwnYk5rOL//mUVGvB/8ftBzL0
         +s9Tag5IDEYT+9HLuc8x5lO/N0AyI0FQvaxJDIPQq4ZEEjeZh/Oa8A+KkICjxqNDGCHS
         3ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366282; x=1786971082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R3rERGLehyZyoa+gmHCa5mwnC48oPkKGAEl7e/XnSlM=;
        b=LnLIvPuqjTXk4PX5ewaZkw/fUR2U4uUbBUEi70LaeGfvk5x6M8SEytq6g4iwvS5cHF
         LZQTmMVhXyD3IdKfdBrvLhhJbzkueqm6rZiuGuapNWZQ5qlbNbyJg6jKAhqdSvt3v5OH
         ceYjIS9vuGL66o7QTA+nfD5gQ1bm+Axee0W9hEHxlONF/1cxWfJ69FUUNnATCg8cdAbK
         p4E3DKdBbzxkZDjdN/3wbMN/YfLAo+Z23o7iIB1MCHzAyJSpPJh/Ghqf64UzHEqz8uky
         09jK7mMndOxgzod0wHhW2MJrgdK/k7Sa/ZeneqDqhzdSWs/CwXo9PLKcGkeosI6vrhlv
         z4/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrthK1vnHWRyMvFYfDTPFi1UXeISS6z89YE5MHFcczo6YIjjtsQ3WBaVCQuAaxWQD6T1Kg4sRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUo1jLf9F/Rjh+TXM/BuCgkAcjCsntJI7XcJl7I7dNCBLfutG
	CNGm1+AAyiRvInvRospRqSaippnjIIc/g2kcBpFSYrXK+soqBodmAg8GPF3xweCOPeyuuS1plnh
	IB3koNE1pUBwCWvJuXpf7OxF3CtnNSiBsBMK9Xgw2
X-Gm-Gg: AR+sD10cGMwU5Sm0qN3cpd/Mf5wqR3xthubS4UD2KNoykww7xswzayscvSs7VNXtB1K
	Lo6Ziz51hyG0Xy1Pr3EGBhScx4sY7aK5REQPwMLjjXZIiS0oUTxl8H5W4D/aePqEElTZJWkMeuw
	OxOz9JEXjzrUaTQx+aQvRFpbe5+wMH6vwJ/m0MXPqnaVasZUT2Q0PIRv0TJWHuAl+ecA2Hvi5Qa
	rmkqrEjRB9RB0iBfgbK8Kb8QiEEhoVAeIy7ePweJje15vi9ZzrgXm+CDdFnPmPZDi8GVm8BQmRW
	NlZ6qLW2I5qQP/jNjTwKm29bocp1ABNhhtZJgX4mMzeb5KlwB6Aaj+8wbE/v/oj3givofWmnrt+
	y9Ul8RHdGD4bSbiTpMslkude7nvMj5aAKC3CMJ+EqFrXVKlV1+4y8bcPFjPOYtVgdav8keTrjan
	cYrwOEoKWi6oO6Z2owq3SATigQrQ==
X-Received: by 2002:a05:622a:261a:b0:516:d83c:edb6 with SMTP id
 d75a77b69052e-52d0b06e247mr322732891cf.12.1786366281088; Mon, 10 Aug 2026
 05:51:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808110054.6892-1-zhangcoder@yeah.net>
In-Reply-To: <20260808110054.6892-1-zhangcoder@yeah.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Aug 2026 14:51:09 +0200
X-Gm-Features: AUfX_mw879mFwRTQSix6anuup_0juMu7CZx8dbI2qaB8P49iC5I551VZ6p7LZpU
Message-ID: <CANn89iK8KSx+EfuANe6JuP=K0DrgTAiToPDH5L0chOj+uO9NUA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: use likely() for srtt check in tcp_rtt_estimator()
To: Ziran Zhang <zhangcoder@yeah.net>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 1:01=E2=80=AFPM Ziran Zhang <zhangcoder@yeah.net> wr=
ote:
>
> In tcp_rtt_estimator(), srtt is initialized to a non-zero value
> after the first RTT measurement (srtt =3D m << 3) and never returns
> to zero for the lifetime of the connection. Thus, the "srtt !=3D 0"
> branch is almost always true.
>
> Marking it with likely() helps the compiler generate better code
> for this hot path.
>
> No functional change is introduced.
>
> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>
> ---
>  net/ipv4/tcp_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 5b6378b94..a4c4d4760 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -1089,7 +1089,7 @@ static void tcp_rtt_estimator(struct sock *sk, long=
 mrtt_us)
>          * does not matter how to _calculate_ it. Seems, it was trap
>          * that VJ failed to avoid. 8)
>          */
> -       if (srtt !=3D 0) {
> +       if (likely(srtt !=3D 0)) {
>                 m -=3D (srtt >> 3);       /* m is now error in rtt est */
>                 srtt +=3D m;              /* rtt =3D 7/8 rtt + 1/8 new */
>                 if (m < 0) {

Many flows are short lived, unfortunately.

I would suggest not adding a likely() here, and let FDO/LTO decide
here on a case by case.
