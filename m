Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E46446074
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796412; cv=none; b=n9UyLnnea5eFgqfynm8i/ep76TO9++LcODOGq/P6JLQs0kAO0EQgv7is+Yt6osa7gzH/TIiIZI8GNMuxBa5IBhUfrzsueS5YU43b/FcNFEuSN0FVHWUlk2KjLk/JAggAEbgc1nJRmmnMBOxZW373yxRWVa134JJla8lQ4hY3B4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796412; c=relaxed/simple;
	bh=4H+dWSvxr8+UjpRwRI0SHZ16MiF829cfsZgcOenFqDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzz2F23VzdGeb14zb5+TVcTniK4bKaCFf93vmeoLqn9AN0e+j5prewa26RRYJLoBna/yPPqf2Eite7PPlJhCSrplTqbG02gCMjfAK+G8pMZVziftoGBQoI0ZyT+55XeJ2cvHjaq64OBtpG6oCZ+9w+yLzk+UcdxR3JdVpBwhrXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-98c786605e7so816405241.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791796409; x=1792401209;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jPEqW4IX1dV2O20vPEsTLBe6R8QJVWdW6CAGC3CFIBA=;
        b=vwx0P6dbM33tEMO8S/RK9ts8HrGD7pmw2s4tVU/ruwPttGzDJ3LodOMyFDksmm33JT
         xS/b/na2kfvur0t18LgsGeCykUkZ7MlrZtAL09bv6jYfdXaVf6sSv0N/hC11mXnP/tqC
         FHi0aZ1II0ZSwCShfRo009+iBiHsFU4sF3ZuXEUNcHw6yBaD2d/DOqlSbynr4XK7v7Bv
         hF2YgxddOI1wifsZuZCLLDxJfzu39S4+Jynu9A79yJIFLJPCm2qyQ4z2Mk7Nisrtj//f
         9n490bS63OAFiwnPIXpvaapVqpetZsqxN+t8+txskQt0WyHZ4pzOZtIVv+G6tXcVyVF4
         pkdQ==
X-Forwarded-Encrypted: i=1; AKwUvBynfuZLi1SU9DYnPVrzBUI059NN+Ivzw++IVSX2tQcSFPXDMz7HpnpSbv4FY4GoI2IK+WFN0xM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFFBTGgePqSV5L/r2LsB4Uhmy0XeD3luxBwV4DP+K+wp7/9+qV
	88p2TZlOZsSfe2SZCn3UUHVqlq4HRnGSlDCSo6eUafhLVlqtXY+mQy+tFTCYcdQr
X-Gm-Gg: AYBFou0iMkKDQqjyiCxDmpmgkr2jkzZe8b9O7mf7/1ZAIvd416I7nOi5xiqrM8ZS5RH
	RdgzajT2iB7IhytWQ9T0amyWv7E9UGrZegkwatb9s25ct5Gqx39rebdCYDaxtHvtA0DwtA+OPRZ
	YuRDUTTvghpL4MoFT7/c7mzeV2iPIFEvVA+6AstXdXmBzA+pC8cA+CkOA1KMneI8u9tz6TnMWAY
	xNZS32YfnDP9ywq7WR44sHJZ9sDAY7oWN3d34fQHve4601RYjeYe/ue2Hl2vBX1OaSDvg/nhBNR
	5Vzd3Q0KGC8yRe6YIQWDEE7zWeTCAdBq9aEaTRduV4E/Vn6stFpOWtm1ht1WqRHgq1ukvESae1p
	yAGXvERIlV39ljh9O8q3YwDxHydHFhXREMUxwUvIpgCwrKgaj/fgrVnnpJsMYwHgYp1WzufN7Zd
	ihLRewLpVJy9Nd+6q1VUqqdyfZMELdu6eJErAG+4aUTQUPj+6RCtwJ+hiH3fessYGYyQDdPyUhK
	KKv2MRRW/aXYE+7pFJVCkGjaaXUKYvTgYh0
X-Received: by 2002:a05:6102:5106:b0:7c2:598a:9def with SMTP id ada2fe7eead31-7cb37388b83mr3048215137.25.1791796409416;
        Mon, 12 Oct 2026 02:13:29 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003f242a9sm6023972241.7.2026.10.12.02.13.28
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:13:29 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-988c94f1c07so740432241.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 02:13:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxu7TVIWMBBK+SduUaLnD1nwh4mUNDL+nxlrOWZEdCxFMLxxcsPea/6WEb42CEOwyqEYvXxDK4=@vger.kernel.org
X-Received: by 2002:a05:6102:4490:b0:7a8:10eb:96ce with SMTP id
 ada2fe7eead31-7cb3668a4c7mr2485869137.4.1791796407802; Mon, 12 Oct 2026
 02:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002212058.25117-1-kmehltretter@gmail.com>
In-Reply-To: <20261002212058.25117-1-kmehltretter@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Oct 2026 11:13:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPMSyHy4tU5Sq4y=ssFZy8Ktd_OZoFr9L2sj-m-=wFkg@mail.gmail.com>
X-Gm-Features: AclHuK_y85x8cMEVOZECVsvp7GHPU25gGQ7oBbJZUrQ3T9LAbD0GI07OmtaZn9U
Message-ID: <CAMuHMdXPMSyHy4tU5Sq4y=ssFZy8Ktd_OZoFr9L2sj-m-=wFkg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: mctp: Make flow KUnit coverage an
 explicit opt-in
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Karl,

On Fri, 2 Oct 2026 at 23:21, Karl Mehltretter <kmehltretter@gmail.com> wrote:
> MCTP_TEST selects MCTP_FLOWS, so KUNIT_ALL_TESTS builds flow support and
> SKB_EXTENSIONS even when no transport needs them. KUnit's style guide
> says tests should not select otherwise unused functionality. The CRC
> and crypto library tests use explicit ENABLE_ALL_FOR_KUNIT options for
> full coverage.
>
> Remove the selection from MCTP_TEST. The core suite remains available
> without flows; its two flow cases use their existing skip paths. Add
> MCTP_ENABLE_ALL_FOR_KUNIT to opt into full coverage, and enable it in
> all_tests.config and a dedicated net/mctp/.kunitconfig. Both profiles
> run the flow cases without a hardware transport.
>
> A plain MCTP_TEST=y configuration without the opt-in now skips those
> two cases. This is the coverage cost of leaving otherwise unused flow
> support disabled.
>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Changes in v3:
> - Keep the core suite available without MCTP_FLOWS; a plain MCTP_TEST=y
>   configuration now skips only the two flow cases.
> - Add MCTP_ENABLE_ALL_FOR_KUNIT to retain full coverage in
>   all_tests.config and a focused net/mctp/.kunitconfig.
> - Drop the Fixes tag because this changes test configuration rather
>   than fixing a runtime MCTP bug.

Thanks for the update!

> --- a/net/mctp/Kconfig
> +++ b/net/mctp/Kconfig
> @@ -12,9 +12,23 @@ menuconfig MCTP
>           devices, you'll want to enable a driver for a specific hardware
>           channel.
>
> +config MCTP_ENABLE_ALL_FOR_KUNIT
> +       bool "Enable all optional MCTP features for KUnit tests"
> +       depends on MCTP=y && KUNIT=y
> +       select MCTP_FLOWS
> +       help
> +         Enable all optional MCTP features covered by KUnit tests, even
> +         when no transport needs them. Currently this selects MCTP_FLOWS
> +         so the two flow cases can run.
> +
> +         Without this option, the core suite remains available; the flow
> +         cases skip unless a transport enables flow support.
> +
> +         You still need to enable MCTP_TEST, either individually or through
> +         KUNIT_ALL_TESTS.

IMHO adding yet another symbol overcomplicates things.
Why not make MCTP_FLOWS visible if KUNIT is enabled instead, like is
already done for several other symbols ('git grep " if KUNIT"')?

> +
>  config MCTP_TEST
>          bool "MCTP core tests" if !KUNIT_ALL_TESTS
> -        select MCTP_FLOWS
>          depends on MCTP=y && KUNIT=y
>          default KUNIT_ALL_TESTS
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
