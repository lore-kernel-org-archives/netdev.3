Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793799965;
	b=LpuKXzb3X1P34Mr7biiDgLBR5eFIPZS4sx4yiaoZRxhvaS/lxkdgO9n0yTtZcboSIlfo
	 XWxOCiy/X9SPEGL+umgs/CZEcKQoNy6aJ7B6Bz0UlJ21sjoHaL9GQF8YjRPutDXFLpgKl
	 JJO5KcXi4aLUxJf6WV6DshTvaj/ozriNHM6hE2VVs5hC6rsczByOhgvqF72CSmFcdo5ZC
	 738pF6UAyiwThv3Zrl3FiYJCoj1IvMVeV9eMaIGswNGA2HMaclJAXA44mDdMLPF4mESiU
	 orEboZwtq5+V59Samst5PGZJtSURRRotAy+eoGCqU4kY74VbodwdRNsZ68xKi/gqi5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=D0ZsOE+K1pTcz9yTwLm9GxhoridjE+gXv16hTadQYPM=;
	b=142a5Er/xPZBeBsewezLp3RGzSvg83z9cOAidWWh5tyFiwEvnmTfT+3DZSfbcb8vZRNy
	 4yJUPM6emld+Y9OEmDBDL1GdmO/Pi0Ug7DoprGtwsiGZxd53fkolF5h1mXJE8ReMRgZUF
	 fQ5ISAd6Tnnl8Dc6EKxsacQ48L7l7dA4fbyXwkEAHY2zNIDvgXq+n4TE0NsdElM0EXLo0
	 47SoK7oYNpJ8oBzB0Xftpvpgb4KYem3Zb+ovLskJgKtybEAt1fBj2YLI3ATWA+rC+3NhK
	 OFD8EJaZi/UWkkJjqIRU3QIRaZPA6XcvZOlxsgBQzu3lFpXyYQpG2ICADBI14KUtbyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GWnrTbvS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD2606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FCD2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GWnrTbvS
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3514b90bb89so1320606eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 05:46:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793799964; cv=none;
        d=google.com; s=arc-20260327;
        b=pOyIETrn6fr/l0zsdDevSGYraATGgDiWpUtguhxoph2ohbMtRsYBnKeKb1v5nGN7PN
         J26umo0P8lxtaSOMMS1AEDANSYqM7HXs/thO9qwTnB1er0GEBk9+yK4Aoh9/D9e6j1qz
         9dyQXP7r3eZGTcTvzLOho1KRK5I0dZVUyTodHOlnnXB3ZSSNadOeP3OQjYHfyURu+rPd
         kma2oh3GTbYQuJTF3xMAC4mfrp2cQnT8U40ivCzZYXj+oGiV6SFS1EdSCH3mep1JCzBr
         Hg2o4R2OsKdGMllZdjne90h8qBWWfaW87uH1Btq/Gm3MgfgidX8F9cQiAlrYBXSOwtTY
         cBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D0ZsOE+K1pTcz9yTwLm9GxhoridjE+gXv16hTadQYPM=;
        fh=EdFrelh66HymTrWZAFLAyfW+TRLt6HTAc6PG/Ru1I44=;
        b=iJigzfm5elrGfhTrW0750qCxnXR+glid8F7Mkxp7OF/2VVUH6qO7OgrDMscG6sC9LD
         y9cJ4ndVZhomqwE3psxwQf6nVPRR4H5BKJblr3wzmW4YXeuTO4Hq5N5ghSZOxxpwcPdr
         1Plej3yv6ZhgQwQATt77uE+V3R1x7KXXClKnm2VaQyYr5O6yT0g3AdCb5kAWffcTf/w5
         pH4Cq0AkUNXk+3NeRe4TUPNyguZyDWBcnEGz655k/AWhlRVtm16QB8OGDT/fIMB0R99e
         pGZGQTyrI/+MHvkSaxlUm5qjfF5bsz+sqRMaMOgPpqXbnrgZd1X8i8woj9w38QkSLW4l
         U1hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799964; x=1794404764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0ZsOE+K1pTcz9yTwLm9GxhoridjE+gXv16hTadQYPM=;
        b=GWnrTbvS0F9bkzFJf2YKx2DDnNs+0A1dHAWUjES1lhkTBtV9QDnEi8sSDNDKgZPDIK
         7v2jIJ3TXFbkvjS8dNnV/U9d0chBoDIlAD8hefNyFrl3FAW/IT285psEyhx7VYr7hJmo
         VjHW6gmKDMXjunXTyuFWf+1YrfETdOi4Cj2lW+rhV+L7i/EZr9aa+gBWkJqBaI66+bar
         XZHSydiJQGoS0TRYPKJQEw56ivHiy+j4xOrLSCAcxrN6paJJ6z6Hm0g/cKSubnG0YV2v
         IAdNpWaA36s8MIFqY1Q4nmfAfZWgcL9n2+YpIySavEqqke2iA2YUwU84UVoR2kv3SbvQ
         nAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799964; x=1794404764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D0ZsOE+K1pTcz9yTwLm9GxhoridjE+gXv16hTadQYPM=;
        b=ocPyCCGgSnkqokogVKbLRIrPEyDCBDhjeabhHRZbMrHzB5fvoHzWAEU8+jhKVmleTv
         dpj+Aaos6cEJFp6BOUWMWxrDaJRJEYxd+CxAYh/NLjYg7vAECCe5icvSixpMgBxYEsXW
         Eu8eGkQ5yoGJrrS+yj3gtB+fe3q5OScIgB7qFKd3YZKtWdOPaH/MJL2WHQHOwbANJ7Gk
         9QYpcbsT/6BEIRw/hj70NHsuKi7hkUgT9fdHS5uDtqTZ8tv1GlW00ZFm94j0UEHSSJx1
         PR39pLdjlw+WUk5K+0chvn7hQDuzUsFTbB7jc3sudcSGg8aYCeDtnRBrrocAFIbXdzBl
         GCoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqMQa2YbsBQ5jrXa5t5MLwcc7zwmJVL+BKW89vWeX+kKRXyyXVy59jcc4yCLClbN5BS+BPTuE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R65W7iub4l0aXxuBQ8uphG88zlmmA44SzYHlXA44Bet8E4AM7
	4Ko/SLFS4hbpNHWUyJKD+phqR7Jr0YrykSKPYdDBzGJmwAiFWARfA5I6hctdLpAMBs32dnI5sdT
	H6LI0CeilQpcpY68qqmHPk1G1vcx7iJA=
X-Gm-Gg: AYBFou1lxZ7YhXniUQ40ZKXmNHwWaNVme470ULIGWiZ4pRm+9Up+p9bwoSMOSajaIqs
	9jUVLrHqlhjtQkgbBX2qqApOnzRF+Gm23uvxfwYj9vZpcbjxjN0CTaMaLRoNd7FmrtA2rlWMsZy
	ZH/1f6YmMlrLo6vDsvf5lVfmlxd0SFyHOZxfc3guiYYCC0+LvOTORPRMRL8naaECN0ZUOE+2Sgw
	PgdPqu0boKBL+37Vh7Nc819BHzlh2eiBtsv/fSSwDGbkZNetmWyJLaIPnF1yqZndtPN1ZStWVUI
	v4uoooHuTGWoALgiMChcezrtLD79uBynUPGJAtDYKyzv9mEhfBsIChyTL+Icq4zO+bR0imlVtE+
	lk7NKRUmScB1UiuHZXmFTKPWvswuWXG9csL9fu1zB3duRsiN/sPNWTfyjwNOrWl52t/5MOjvjl7
	8XFcHsh2tMmisFfP9liEyDdltiN9TRs5qsjI+jUHS+fcEy2VQmYt3Uf7hCHBCv2sy2HpXBanVRq
	0WBtGU=
X-Received: by 2002:a05:693c:88cb:20b0:36a:1e50:e45 with SMTP id
 5a478bee46e88-36a423624d5mr22803491eec.9.1793799964016; Wed, 04 Nov 2026
 05:46:04 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103163921.641347-1-sashal@kernel.org>
In-Reply-To: <20261103163921.641347-1-sashal@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 4 Nov 2026 13:45:52 +0000
X-Gm-Features: AclHuK9zoI5ijuNEFX4IBI1jXKyfQ9YWFXRsUdy_iBMcms1sD0iTaUorTso-rIM
Message-ID: <CAJwJo6bgZKyU5zWzTG7-zvFCVbh=A4bd_qCmHEj9NTOMJ+_5EA@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: tcp_ao: don't shift a size_t by 32
To: Sasha Levin <sashal@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 16:39, Sasha Levin <sashal@kernel.org> wrote:
>
> gen_tcp_addr() shifts the size_t n right by 32 and masks it with BIT(32)
> - 1. On 32-bit architectures both shifts are as wide as the type, which
> is undefined:
>
>   aolib.h:230:40: warning: right shift count >= width of type [-Wshift-count-overflow]
>
> Convert n to uint64_t first and mask with 0xffffffff.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks!

> ---
> Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
> -m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
> KernelCI's 32-bit arm builds show the same warnings. The changed files
> build without them now, and the x86_64 builds don't change.
>
>  tools/testing/selftests/net/tcp_ao/lib/aolib.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
> index 53be1744237ee..71ff975533089 100644
> --- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
> +++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
> @@ -226,8 +226,8 @@ static inline union tcp_addr gen_tcp_addr(union tcp_addr net, size_t n)
>         union tcp_addr ret = net;
>
>  #ifdef IPV6_TEST
> -       ret.a6.s6_addr32[3] = htonl(n & (BIT(32) - 1));
> -       ret.a6.s6_addr32[2] = htonl((n >> 32) & (BIT(32) - 1));
> +       ret.a6.s6_addr32[3] = htonl((uint64_t)n & 0xffffffff);
> +       ret.a6.s6_addr32[2] = htonl((uint64_t)n >> 32);
>  #else
>         ret.a4.s_addr = htonl(ntohl(net.a4.s_addr) + n);
>  #endif
> --
> 2.53.0
>
