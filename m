Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD18306764
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734176; cv=pass; b=HkzXAaT6C1N0XtXh2l6gjQtBgFe8HufzGq0b9kCCxg5fDB9gq60bRMXBrR3dsLHJOnSfdShimKadx9M2ZXraLck6jvpOCxklcmkHv7zcbZGa64nE7VKK1KPjsHcMEkmNs5HkzXkBdj9DnaUFMpatmy3xh3sKpyIuGzoJ3rib9R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734176; c=relaxed/simple;
	bh=/JK+8oneyHjSUbJbc3j9nJhc1e8XAgMgQI7ekpEsvxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d34dQ5FOslHrvEQfSZvzBM1KzK6Fn7GSKlgtp/+WvceK6naiYa0gX37jk4aFRXU6mDVXipH4EBTE/6rSwEvXD6G74cTLUKJBXaY1HkswKPUI4/GzbhcWYHwX1WiCSgwn7rmY6Wp+ntOl+3kqxIlhPPrf/49iddqzCW2pfxoBdKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTWt42B5; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTWt42B5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso3516a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 08:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791734173; cv=none;
        d=google.com; s=arc-20260327;
        b=AXvI9l9Lo30u1HYEASkcN6Xo//2Fu7d0OcdE64IxV55Fc9gdQ67Ktq3Hn8HxpBnzoX
         3tPeG6PPkWGJRRGM8MuUfpCDfbJPHL9XU2ALX8i83CqtzWS6cnn/kwp1dyOej4yErx7r
         RcLMrL5rpn040CpjH4QvBG9m02BfnGwaVf4rvx8n87Ad3WPg0rTMCppdMYIb6JOhZ553
         Cwthh4es8sekJHC8+ISddZxTF8K2braY2Qz3tgrqWg3tRilxkPyu6ezBdfgu21AZdQrR
         ppWNgx6lfrJdXLOa0Att5g7x30RV/UBeHE3d2P2gAZuHopkQwnXvFHzEebN02KLNNGJN
         RYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/JK+8oneyHjSUbJbc3j9nJhc1e8XAgMgQI7ekpEsvxg=;
        fh=ltYeiUr77P5mKdurc7nSGeZ/Iy9SmZsokzYaOLYuBlE=;
        b=PhgeecIz+GHsQyEHqUpNarHTHnQt+Wl5XGzE3BMU5bPVm6QEXyWVp7wNaJ9Rpded0U
         t4HEanb8cLUVQMGWTSS6B7qCXmv/QwkKrCIdwSZsh/lBCoFtBfC++hZZAUYcAmx2mNNm
         O/5uIk2nmdyC0Ge8p29U2Ef+FhyIvxFKI8JHCU0tfg+rjCqO7cq21T7KUHH9IBtX63LV
         Rii5z+8uZJdxQ7HFIhqhubNnVn9O7zhgE6NwB7ZHw+QUzAzvEP644dJqE0OK/Pc4mrhU
         /06NsuvYn0GO8rMOFw44PiQyZsIqmkU6ZZD1V976bBBHW8oQxXtyuAcRGgtc859o58ib
         AzUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791734173; x=1792338973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/JK+8oneyHjSUbJbc3j9nJhc1e8XAgMgQI7ekpEsvxg=;
        b=DTWt42B5LkI2szJVPHCoQxA+Ac9vBYc6SBWESIZtpg0A6M6a8RT8GcUSfOOWCsGs75
         1ElnUKHWQxBsMojffPmn4/7vrKZGkFGfRej6G80p5Dc8oDiPhOiPLFEzPTZleb0KB1wR
         w1MNTSyitfqoa4yQYzOclHcoYGiCdyObcXvh7WStRl6zZpJEHWljr5qkW8b7ZBtg7NQf
         qkGoifDy2ENyTHLGAu4PegXqs/yleRxehBp1GMlZDcZ8ifc6aLwbOp1mul7RMPKktwfY
         rWVBM6EijA2+WlVAK08KB7NM/7e5bhm5DSzg+AImqIB378URTIAZZ6a5zTmIRxI73JdF
         vf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791734173; x=1792338973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/JK+8oneyHjSUbJbc3j9nJhc1e8XAgMgQI7ekpEsvxg=;
        b=WX7TjDBuKLn3nWsyAQHxPefR+Yr0Mm6iZ3KmnfP6QrhvMBdfk0+N7n8WW/DospKJvr
         H7/zldoMzD3vFB5Vj00qDE6CEKvN14GpejNVf49p7USocRk0ND5Zdw2skxNm+UCINXKe
         Z7nyCbYDteWb3Zv0XanV0nMwH2UMcz7qY23YGXqXKJPxE9XrnBOfN1zEl+lVfFlKsFeW
         SmLcFJ1itjqqVw4VnBJEV/VYca5fJrGFcIBTrCWeZyfOf7booXLJMpKZGyP12B/N5sJH
         zORArAHpdPUxNNmUborqJqBJjDd+fqISlq76y6kalO4W+oSOz3iSTBG/6bnBW9G5NsUd
         mbag==
X-Gm-Message-State: AFq9FYL1AJRq1ZwMH87qKD39UzDztq2FzMUvSnG31KScYyD/t6+X0A7S
	I9IKj4uyzGmGxVs5/Ja9oZnAcMnEYK4JkK8VQRyYVVZV0T8o1QJKP7PGRpIeFT01yl9LmWaoJYV
	AbQ7xggosrSa0bCwLJzMJocvueXO0dUGL9Sh1ahg7OMjmsaI1Y+jOhFRw5Io=
X-Gm-Gg: AYBFou3shOtOfWj7Tpgfqg/9dm2ye5QY18J1dHvVb1MuzK2CMAmmFGwADQQwJUh4/P/
	tnvmlO6WaburKKtHVLXF9KRG4VTnFoYsXrBUEa3KNGotWqYh/nyLDOTvMsbcM18ZoI+8nd6abPo
	q7hIF2EEQsv0dxD0+5xx+9G9uagdbtvVkbMLW4Ff2GqCGuGqpDQWyl6Wyg0TcvRVn4s6dbsZerd
	Yd+IGHQs7GbG5VXHEf2F8B1AWeYvvs0L1/q+Tz3t+yj3AAfqwRssogmhpFchshQztRUGdFmlERB
	LiPn/fGsHaBSnMv7zwBStbq3ri/D860+9HoYLl6JFWjbv4+/5wHkXxzr+nvqOVUp
X-Received: by 2002:a05:6402:548f:b0:6aa:b72b:d762 with SMTP id
 4fb4d7f45d1cf-6b198823fcfmr54337a12.1.1791734172609; Sun, 11 Oct 2026
 08:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010083935.3274178-1-almasrymina@google.com> <20261010083935.3274178-7-almasrymina@google.com>
In-Reply-To: <20261010083935.3274178-7-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Oct 2026 08:56:01 -0700
X-Gm-Features: AclHuK9SxZyeBfW-6W6d1kton3R7TtfUwblUvnT30CCIbrIv1iqXLpJDIRaE5ao
Message-ID: <CAHS8izP58-H+bGw+4RJazukywpeDX5jMKaH9coMwcXh-mFa7AQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 6/6] net: kunit: test netmem, page_pool, and
 skb frag refcounting
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Cc: Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Michael Grzeschik <mgr@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Petr Machata <petrm@nvidia.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 1:39=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Verify that non-pp (page._refcount / binding->ref) and page_pool
> (pp_ref_count) references stay balanced without cross-counter leaks or
> underflows across regular pages, page_pool pages, non-pp net_iovs, and
> page_pool net_iovs with both pp_recycle=3D0 and pp_recycle=3D1.
>
> Cover get/put_net_iov(), get/put_netmem(), napi_pp_get/put_page(),
> skb_netmem_ref/unref(), skb_frag_ref/unref(), pskb_copy(),
> skb_zerocopy(), skb_shift(), skb_split(), skb_release_data() (clones,
> unclone ordering, pskb_extract(), and skb_morph()), and skb_segment().
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

This patch introduced warnings in patchwork:

Documentation/.renames.txt: warning: ignored by one of the .gitignore files
Documentation/.renames.txt: warning: ignored by one of the .gitignore files
ERROR: modpost: net/core/net_test.ko: symbol 'skb_shift' undefined!
make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
make[2]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:2179: modpost] Error =
2
make[1]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:248: __sub-make] Erro=
r 2
make: *** [Makefile:248: __sub-make] Error 2
New errors added
--- /tmp/tmp.UjTzqx5Cgh 2026-10-10 05:13:14.877336904 -0400
+++ /tmp/tmp.2YswE6nv11 2026-10-10 05:13:32.781257136 -0400
@@ -1,0 +2,5 @@
+ERROR: modpost: net/core/net_test.ko: symbol 'skb_shift' undefined!
+make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
+make[2]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:2179: modpost] Error=
 2
+make[1]: *** [/srv/nipa-poller/net-next/wt-1/Makefile:248: __sub-make] Err=
or 2
+make: *** [Makefile:248: __sub-make] Error 2
Per-file breakdown

We're not instructed to pw-bot: cr our patches on patchwork errors for
non-sashiko failures, but it seems the maintainers will want this
fixed anyway, so i'll pw-bot: cr myself and let me know if you don't
want that.

pw-bot: cr

--=20
Thanks,
Mina
