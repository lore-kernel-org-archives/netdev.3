Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1B35C68D
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534179; cv=pass; b=cwyRMkbuMSzcE2ZZ7crEswrCDcCAnzXxvOO7oYJuMyq4ufbLzQ0wmT434wIWP1aMBCN17J2BL6KUVta5qpJlMHWlGdS3LxQIftI7B7h2tv0Q7xJPDL0OFHP+rqE4JlF84Lov0XVL2uE0/n9mn6NBsX/Ho/Eszr3mCMh62N8cCIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534179; c=relaxed/simple;
	bh=fJm5iExLLNg2dOOnBGa1utNmL4mzcQtyLXlrQky6wCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdmQSbYyFGGktiI72BtYHE98r1DE+BD2REaogHqIbDj4SvgwzIoWCwKeoKySBMz7CrAK/7hsOZwJvxif94NOKmNbbFeZSAM50dKofFJgvG2ZyksFNciLHQ2u8O8Zgb2f5nxIsEY9L5AG+lio7zhnuyrQz+FpXswnyJ3TAw3VGrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZ6NFMox; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZ6NFMox"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1677c91969so186114466b.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785534175; cv=none;
        d=google.com; s=arc-20260327;
        b=Ef7UY6o7XfstrAYi1yGKMARFGhvCKpgD9ltFOJmM/ps9hO9k/Z5Fj/7iO8IMhSHPtZ
         0nu74BFl+Rlr49my+aA3cJhF7pU1PGbTnrTEqO5/fcUgotVAThgPcuqylYcHayIOyNTd
         rEiDu5czGGUElOcwyMPfJ4tv/1EkC75VbCPx2SRy/K7ZjYbPZBT+0uI8TKDWddKglMb/
         /7A2kduZHbWSbB+Wz3A6sES7b+rc6W5BO1Mj8qX3SiCwzyvb2NYEGyGJsu+ZiQJLxvWf
         N0PNP0H7bavK4veCp7onBAyyp6z/prZHd9BY5yDEMQ5aND2pKuHwFXuCfTkLsZnBfoMo
         CJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2w0TLt9QH7s0lqrlMH/OvUd0WbfPEFOdoqJKDBnB5Sw=;
        fh=lxcvVcstduAq+DV4YXUyKjvjB6de3D80WOxEXrupYJQ=;
        b=XjqEcaADVBHFbqjo8bT2LXIQ5hdrKBribdsW0v6YRDICSzDmBQjBjp9MynTPkO5nGq
         zFGYVvNCexP8IzB9Qgybj3j5PB+dcDHb+LXe1mTmTM3D64VdRcrhZzlvA+FRBpY22LLM
         +xCW4HJbKQMVjhs5Fi48S+E0tRNMM35JvwwCyI8EGoaJgjJUDAjQFJ8m0odUBFm2R0Zh
         gxbnsYnP78bydEscSuT35XFQya4QIXbDSUJYgQbHw43Xw+5R7jXNQQqDSKvPJs1UcGLf
         TWeB+rCq3sdetUKv1/QV6jh/yUtbvKAaERg4Y1MXfe2iejt487fKkdSNhwB0H2etrnk0
         OmqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785534175; x=1786138975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2w0TLt9QH7s0lqrlMH/OvUd0WbfPEFOdoqJKDBnB5Sw=;
        b=fZ6NFMoxv1qj8ywFdEG8j0qJ3z1vkQEcIHTRjpbSgu6UfPOMhdo2tCNk5S0QrWLrmG
         hnB4hVOe4IYVkkfGbhuC5Z1AOROqOrJ6WrHGhP+CsylctwAkpxJ4D7LTEoMH9erfXixu
         +BSVViq0Xau9KJ/oiCjfLCcDvucuPjURkz0rWOXN7pinBl0awXIGOU6w0vc6Z3XhadQG
         YtiiYJntJFm6O/yAmN2VuGYVhka7/+Vh2blriRET6xK4/dJKthtwRHR0Ppa2P1/HloLC
         wksQvaguNhfWHgW/03wDdqnvgI0duidERvmiqtMoij0sRocU0R4/bjIpdgTFdOhnNrD2
         gPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534175; x=1786138975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2w0TLt9QH7s0lqrlMH/OvUd0WbfPEFOdoqJKDBnB5Sw=;
        b=XCHN2LEnJnBQfpE0U1DcIjZlpjgvfgNy8kWmkcup7+WZfvJCpGO26YLSdK/OgKGs6d
         IOsDoo4N6NFhZjPK3O6PLniHcxvPYOWxvrFntLEk76W3UFI0I4APc6hmW7ZuDQA4Z7wC
         Nx1Y+ZgeLBD6KYSUSXbL5sVUbelS8pb7ZXVWD0KcGYkPqDTnZ5JFoaMjbRcuqr4ze3yt
         jjQLQhuOwz4mHrvyZQPk0/ZsuZZWcWDFcAqO1AQXqHJo+b0mREdTd2lVFdwmrghB97rC
         g6gKCbgO4fJLuR8npJSY5x3pK7mvrUvgLC6vrMJ4oYnPmVQSZzndA2G1BzNZMcAhun8w
         MapQ==
X-Forwarded-Encrypted: i=1; AHgh+RqX3hOhRx4g63O5R22MwOuYpLMefuiWBWZiVthyreoWTihYBON0rYsWbdL693kev+2VHHZsBtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp14JoeQjsuMWrNRBHblsQHk4L3cPZxfExRc+bYls8azquh/Ee
	0lBgZaThC+k5myJcCpMoYE2gzTXs1cPBmpTC8U+jfCUA/SOpghQz6uoLHYPzdRCXwSBV474rYGs
	3KQXmiWJzK2Mo8yBBUzJ9Y4ZZP4UAnVdMGR+DuWDj
X-Gm-Gg: AR+sD11QbGY/R0xcru0CW/iy+eTCEHyBUlaxJVQvPZWqCjgNkMYEvzW+iPKpT4DhoxX
	ajKYBSPeWaMjrVAbdZv1n1V1qPosbpQ2SH0z3X4twCJCLmiJO81hv0+osyWHt+m16tH9RAymcAi
	FQx0qtZ7qDs0nPzRKU3AlY0v9bSNTUb9gdikcX1Uv4CZnYPwBFIiwCxfoaMxoe3QbyvdOfJvIKe
	2Sdaee5oKT9oYe1Au9e4UOEHNjw+KcsuGsgUvstyQPCytzXfwVWY0iAw/arMynHYFCyUAscx6gE
	96iuSrf1gm6keSS5XReykrwlmpjhrg7BfOiuEHqqJbmHjcFxy5ccr8DaN4hlUiBmCl8rA1DeVWi
	L+FbIBzBHyJziwlFjdjYuA9cXTo2nTt5BbHI82Lshw667MSRBnL1gHIQQeMk=
X-Received: by 2002:a17:907:961a:b0:c16:8aed:cec3 with SMTP id
 a640c23a62f3a-c1fe8315915mr71437266b.58.1785534174731; Fri, 31 Jul 2026
 14:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-airoha-spinlock-array-fix-v1-1-863a7e239a5f@kernel.org>
In-Reply-To: <20260731-airoha-spinlock-array-fix-v1-1-863a7e239a5f@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 31 Jul 2026 14:42:42 -0700
X-Gm-Features: AUfX_mxeDK0UjkpXMoBLEays-SsJvXAu7pPwCo_E4Ldx0HgqctY1Xwd1UgDCFnY
Message-ID: <CAKwvOdm0NpX9LXO9J=u4+S3-VzJN0_jxBMy=aDf6zUi9r5L=qQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: airoha: fix ARRAY_SIZE() division by zero
 on UP builds
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Simon Horman <horms@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 8:48=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> airoha_alloc_gdm_device() initializes the txq_lock[] array iterating
> over ARRAY_SIZE(dev->txq_lock). ARRAY_SIZE() expands to
> sizeof(dev->txq_lock) / sizeof((dev->txq_lock)[0]), but on UP builds
> (CONFIG_SMP unset, CONFIG_DEBUG_SPINLOCK unset) arch_spinlock_t is an
> empty struct, so sizeof(spinlock_t) is zero and the expression is a
> compile-time division by zero (undefined behavior), reported by clang
> as "division by zero is undefined [-Wdivision-by-zero]".
>
> Since the array is statically sized with AIROHA_NUM_NETDEV_TX_RINGS,
> use the named constant as loop bound instead of ARRAY_SIZE().
>
> Fixes: 78a35725e533 ("net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loop=
back to QoS offload")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607311850.6p0ZUVq4-lkp@i=
ntel.com/
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index dba7c52c0896..64619e9a704d 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -3467,7 +3467,7 @@ static int airoha_alloc_gdm_device(struct airoha_et=
h *eth,
>         netdev->dev.of_node =3D of_node_get(np);
>         dev =3D netdev_priv(netdev);
>         u64_stats_init(&dev->stats.syncp);
> -       for (i =3D 0; i < ARRAY_SIZE(dev->txq_lock); i++)
> +       for (i =3D 0; i < AIROHA_NUM_NETDEV_TX_RINGS; i++)
>                 spin_lock_init(&dev->txq_lock[i]);
>         dev->port =3D port;
>         dev->eth =3D eth;
>
> ---
> base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
> change-id: 20260731-airoha-spinlock-array-fix-d239f7841cb8
>
> Best regards,
> --
> Lorenzo Bianconi <lorenzo@kernel.org>
>


--=20
Thanks,
~Nick Desaulniers
