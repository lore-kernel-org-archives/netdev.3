Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023A353A61
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196200; cv=pass; b=rsZnH2mmfpXW01IIqR2R7NkMKX2dWyYpwwJrFJljEXgDVhvbrNqyRtr9/uhUQqA8Y8S8UIjPwV0K1mI5v0jnW+0ZTWA4rk+EyyhlInx5+i1IXTue9P3fusXqMT1ZDj2HheuYSQvacCJBivwRhUJdn3KNnHn+wlc/9b3qvCAlX2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196200; c=relaxed/simple;
	bh=P4qwg0zu6453HHZxwwxdLcNfxD7syKh1D8zelwSYPso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9yxFeQuledA3p5P6eJREPd6REmxlT+d9C8jz/vvYD5TnUnAHtU7cHdBBtjFOceoDR6yRKzhob5TiMSclVtGb9qh4THWX/KuPpzbIgYXa4OS+haeMznxZ/+9IGFldAtVl0K3MLkVWWP5KutejwTgw7SHhLbAv2QAFhiHF68yfqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc4umVgM; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc4umVgM"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7ee35c08c3cso492603a34.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785196198; cv=none;
        d=google.com; s=arc-20260327;
        b=P8Bn70FS9j3T/n1kUobmDuOVqJ7UPTB/+Eb5FDjAgxF4hxaesKq18x3qc9wbqYFJ56
         NixIN+2c9ynylBRI/eSuJcIh7FJkCWbjfSHuAsG9FLZMRhKEr9AVUUk/Ut5elC3VS7IO
         Za98Mv1zmv326NQsX25Wcdc0nXG9anRiyHgqfjmcnPzXQcYTEh9Zm42CljGe7PVmmHpk
         20bYR6+Rere9Fs3yIODT4Xl8WZWDpzq2Uh1Hmh/TZlLXTUs21jrdKXcnZ5+c4oRN5lJs
         cYwMJY2f/cIb2xwRnKMywCQ3IUXeVhRTPBxYQs+mNIUMIiZeh5zLHEdvk4Up/US9uJja
         Vs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F7+loWW9DSD0ox8NUj+RM/QeZ/iKGVX9GE3sKR5JeoU=;
        fh=a2zh8GQhBef33jZwwaSivBjTk1ijDku0NX61ghoNoOQ=;
        b=en5htYXPPCrV8q03GOBDvKt/dgUB+zMntXqACY9O5s/BospqIv3RuQAEWJ5/2MqVFB
         hPKHY6zD96v8c7YhrElsrZjZdmhwnA9y4i1t1pXAw92AbLBfd7GYXVrUjHT3Wo+WAVTz
         jNRuqRrJuaROM7NLqkCr96MkRy4YcXtAE9oWDbPtdML0bTlDX/4Afz1pD7AefUxV81fH
         u42TaTW8bkMAswKeN+DI/s7gmp7/fCvxiQWdYIOsQkCaai9+5WZj8AqQDWSVAnCPUol5
         eaQL3s495AyePs7qAWL/xLYOuELKDu90BqrdfO3T+8tUhybWrL/kpIEvqYwEXOT8yURs
         juAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785196198; x=1785800998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F7+loWW9DSD0ox8NUj+RM/QeZ/iKGVX9GE3sKR5JeoU=;
        b=Kc4umVgMh+lLm2DREARopqiJlgoQaIrf3tQlNbPsei4vVUe5YPgP8WtKfD6fk/wkvs
         kpDzBlzTSmbIyh0dY3PU60W5G9N2AwqT1PCjdd1JGt9EABZXvYLEk+2qaHhO9QudoOtS
         Wt8R1X4e0g5tSUHxb9dgicxDmb+kil6oAQwxruGyOHtKYRCCxsnGti8sHv7vbI4CQkfz
         8jXIIaQJONLf/GF7pn/MSQ6qJpgeDfR2GAqtD8PCuM2ZWpgfNTJU6nAxdzTNoIEvRtS1
         zabtdqkhN/Gpf4432aS8ikA9U8F6tYYUFiJvbaVm6nwsacYCQi3JVothUL2KoEosX5ju
         yAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785196198; x=1785800998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7+loWW9DSD0ox8NUj+RM/QeZ/iKGVX9GE3sKR5JeoU=;
        b=WFQ3Yh3m/HG0RJLqMHgSx0KaWJfv6tMelkh90+MRjVOr1O3Q4cezqQnDTsOciA4kPm
         YfvPWR43VTpnsy/NwtVaFoZ5/v129TSALR2qtUYuGlRNdnMaDtkO9uD1t/Zmt3kDQaGq
         llj3RBU6+8YHYkqW1uvB1WOWAKKWzghzTPwgzLcomvrgy+o610363j9ynfNBly413Qbb
         63g7rrbajHRe0mXnHDu1T+//cNrmZAr/4EkRCsnfKtcg2+0XBOHyqzxCLDwZy4V5ag2P
         f9oI5z7fcbs7UxplSxUowZU4XwJwPBIH5M/gjV47+G3VCX7neMVa7oW1I3TprmJ4gHNS
         PkKg==
X-Forwarded-Encrypted: i=1; AHgh+RqmWIVJNg5A9yrhN34dehDATbAWBFYyU7wRqbENnEdBmpic9ektA/gm450hwERcDaywGZoUwDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxFzDjnvCrC5WYawo5dW3ZgfBBnPpz9+4uq31l9Pa8uOwJ4lo
	7TZCWbv/M6w54eM5Gt3zoLtFBRLTkuVKz5o8NjWayW2rFnC5sWL1T7e56lFiTQ/uUJt2JrjSK/y
	4SvX0ijUF28YhhPUTLKIi9H0GVj2zDuw=
X-Gm-Gg: AR+sD12uzsVi8Eg3KVxEgXbr0pfGloof4oFY8C/yjmYId7r4jW33GOQZPkAL74qfLzo
	BwtqfRp/r/bYey5vFqGSYcHnDA3rZCEwt2U3BaRovcpP4x9nj+g7NHxeUkE5VNURGCU6M2GpKzS
	I62eT9q5v/FaJCIDOUbqwNT4Stsbr4vF7fcKnI883iDZvBFgVXmGRu1AI//JReUQiJKE1M63Cvs
	D3NQyE5Swp8yOcwEb3LLPH6ToAAobDcpBxUZIMXUn+VZgf2XIS6ov+bUmWE0bJDppqjdi8PJvmD
	tQ==
X-Received: by 2002:a05:6808:1a06:b0:495:ac16:7afa with SMTP id
 5614622812f47-4ad5bb1dc2cmr8496b6e.4.1785196197728; Mon, 27 Jul 2026 16:49:57
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org> <20260724-netconsole_move_more_final-v1-4-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-4-a5f7691db81c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 28 Jul 2026 00:49:46 +0100
X-Gm-Features: AUfX_mw_iHK5B26o-OQ8q2pIDPaQenXZmjkYeVkcoERLY75QqMGc8J8WxFz29sA
Message-ID: <CAGSyskW6iqoWk8DpLZbi=8xoME1J8LaSnjBNvAbAg6+b8kszBg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/9] netconsole: move netpoll_local_ip_unset() as netcons_local_ip_unset()
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Move netpoll_local_ip_unset() from netpoll to netconsole and rename it
> to netcons_local_ip_unset();
>
> The body is otherwise unchanged, only the comment's setup-function
> reference is updated.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 19 ++++++++++++++++++-
>  include/linux/netpoll.h  |  1 -
>  net/core/netpoll.c       | 18 ------------------
>  3 files changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 3a7a2cafc6276..70f9c5bfb3720 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -351,6 +351,23 @@ static void netconsole_skb_pool_flush(struct netcons=
ole_target *nt)
>         skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
>  }
>
> +/*
> + * Test whether the caller left np->local_ip unset, so that
> + * netcons_netpoll_setup() should auto-populate it from the egress devic=
e.
> + *
> + * np->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
> + * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
> + * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm =E2=
=80=94
> + * doing so would misclassify a caller-supplied address as unset and
> + * silently overwrite it with whatever address the device exposes.
> + */
> +static bool netcons_local_ip_unset(const struct netpoll *np)
> +{
> +       if (np->ipv6)
> +               return ipv6_addr_any(&np->local_ip.in6);
> +       return !np->local_ip.ip;
> +}


This whole checking if it is all zeroes in netcons_local_ip_unset()
looks very cumbersome.
Perhaps instead of storing 'bool ipv6' we could have something like
'u8 family', which would contain AF_INET for ipv4, AF_INET6 for ipv6,
or AF_UNSPEC if unset.

But that would be another patch separate from this refactoring, so for
this patch:

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
