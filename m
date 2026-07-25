Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B225346E67
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785012919; cv=pass; b=UtY0i8Hn2aItDHVMVDI0YPie0zsp+sYFf7rav86fsjLE/a+wNvaXfF6NOGSfCZk7VeYeA7TvvlurgW0M8t3PJn/1B29nsXYYmJH8KJUPnyvy3i4cGgZZzOz4VG9pn9OBHH/mg1sfQnzmfyGn/gTwx9IS/7CLx4EKcLptTfFNgow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785012919; c=relaxed/simple;
	bh=zw51gC5xIPlAb+ehmicqnY9g7AruYRjvzVknaMunE54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijN8PG5zPyg5YI2+GUlcwHxXq7cRtNQff40mjO2wXj122Q/1zSB+2W/JgD2k5MHjIEAuz9mp9/M2XIrJoZNn852B5y+Ze7v0GtupBSiiyE7hu40uMD3AY+ELVRXeRsHQcGo3C8Z4YL+1A7U3IKE7FcTd7K+KahxQE+Sl582G0e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCfA16sJ; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCfA16sJ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1094174b3a.3
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 13:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785012917; cv=none;
        d=google.com; s=arc-20260327;
        b=mtcxffk/bu2CiqyT64TWoodL6LQRMgmVVX5FqUL2eEucelkTGnNdYmKcpYXN1vHy4D
         qeZIHuMLEd31v6TLBL5jQwpLacRYyslTez931kwWS+wzpcc/oTKZTlVCQ1WutaKbZDo8
         pcGwzz0h4KMXNe95aoSc92F3eHhMw2/QRjRcUpfOiB7zfB2Ep0W1M3XJw+1zU96u7jI8
         bb/hlClT3jgdMupxd3KmXAJspqWnRcH/WnmGNV6fewwDkh5pmxYBiU0u3Fl2a+oESiWK
         SX5XyMtaHSdVt71zdN1KG5jLJycASR6uyym/QbyFbAkiFDsF1C9ae4lAqa8dKqmn7BLb
         e35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8WOQSahUV2FdjC/IM2f0n66+R/EWHlwNnk6q/oqvWX0=;
        fh=ioQb7YfKkJ9e/pTzOzFbhmF2hGOtqdXgmoXS/K6DiKg=;
        b=SYoIwEj2Ysx0wGk5Cmx7uJ1Fva/BJhYUQODvVFOktxCSgJGD4B/WvmxdGKt52FskV2
         Y7ttFavtUcWF8TQvIqLhAWwq+ajea7fWLxegIfn/cCSk8rxS5yLqU75H/Az+gq56nEkU
         dnHlc87fMcyG7D/7S30tLaDTYnxdIbOxmfjrBa8UV/Fb+jhQCiA8FKlR+4m6SM0qbC8D
         LzjA9p5C5oxtFCPHCBeXhCisBoKu01WnB6sHYvDWoghYTc4aJ+kQH88yAhDUmSJgKT0V
         RNu0XtbmFjPS+qpHplV5ZCzdzGOLUlp3MC1R5cpxc/n/hb+etuByEvRQEdFMAjnbTpJL
         bMjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785012917; x=1785617717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8WOQSahUV2FdjC/IM2f0n66+R/EWHlwNnk6q/oqvWX0=;
        b=CCfA16sJBtgz8hldzWHYxUcyEjDqG0Y36DO6tVDS/ExmfNKDZzPZL53IiAy2HXqw2O
         KGAlALuZKD65GL9IxDdiAKuHMignZ6WXOsZx1samvNlbskdHpyC7TijOlka7b7Ab7JlX
         9DOirbvc9OUcRek2FGlvwCYNbjCSoGUKFnIS+mB249msG4ov5+/MS9llmMgoi6gXo4wR
         SQnOgz2SA+68IAreR4Ru1Uk0nfis315U2LA9sR0U72Iezp+sgkabMYRYXpfdgB4JiNMS
         jEuo3pZ0GvvmCxcqlnHbjxszgy/btfDRvWGt+aeO2Q/am25HTFd9D96Xz6Fy0N7YIeZO
         Yw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785012917; x=1785617717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8WOQSahUV2FdjC/IM2f0n66+R/EWHlwNnk6q/oqvWX0=;
        b=k1tlAVm+YG5v0+Zoioa7txX9geaGKOpKOS+/bjVrql2j3XtRpRfnWsOrkRcXLZQNc1
         19/hvWUiJp389aypeDP4crPjBUrY26IZabnKutkQS/SPSlKVMbSmPgiGU8HxiOVlyAg4
         RdwI/pRT78g3H7QarjFSeRFwT24SL3T8eliNtkIFkhuHS3WKIgnQPd7+W3HsnnmiFw5S
         G1K7O559kYV5NtZhFNsMXbrjSG0HYxR0dXMrp6p6fJikV3+2VlhWNoHeUAbyhEq9xJgd
         bRNPmMwd0+BKksjQEPF6z5emOLRJIEBno1edsUNwypzb5z0MFC3rpu3juY27hShAe0y9
         KbaQ==
X-Forwarded-Encrypted: i=1; AHgh+RonBgIj3RE7WfqkdPaCWDOgctkczSdvaP9HQ8D6XbhjB4L544tpDK9RSyi5zMr/Lz6zzn9oJK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGoZJluyt7c7wRnlsAN1WutZfVLPaTNM5T1gntIj1nxEU4Rfc
	3lT5QaDdNU8avzzME+7fv2ZO35/50lX0gmLH5idWlupnEjLm87+9D6KZIn7GJfz5+3Nnu0cd7qK
	f2wkXuW5JcBPKhm05NtiaGQIwRkp+Kw8=
X-Gm-Gg: AR+sD13GeBdjag6U51oZXmip1khlE5Ob0p+/XKomYMQqzd18f2YSkxe886DcA5aJYof
	6uamHPvdFYnyP1oMqVy5bSNdmA8ZB9PatcuYqnAgTfPORf2dwcSwlTKUYcJODYdC1LYK0wrS1V1
	NYG7K0wvgyacM6XMl5jHs4T+BRyEjf/Yx6CcD9bXg++nTzrpdf7li7NJ2KyGS/XWnhtrw/ItWyb
	tE94mn1c7WM34rRQ1Ql5ii8SgTFUlphJy2NiE6aXGFAM8xPkMKX4YXTVwzFRg==
X-Received: by 2002:a05:6a21:4784:b0:3c3:990b:2292 with SMTP id
 adf61e73a8af0-3c67dfe6723mr2903792637.57.1785012916705; Sat, 25 Jul 2026
 13:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
In-Reply-To: <amOTjPW__CNZui3_@codewreck.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 25 Jul 2026 22:55:03 +0200
X-Gm-Features: AUfX_myV9AV5bwxaPxDCds8CpJSSwUUfrEfnR7d5D_zQ_thbtzqC3K-k805u5U8
Message-ID: <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Biggers <ebiggers@kernel.org>, demiobenour@gmail.com, 
	Harald Freudenberger <freude@linux.ibm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ardb@kernel.org, axboe@kernel.dk, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, io-uring@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, willemb@google.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 6:41=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
> > There's no "tk(cbc(aes))" algorithm in the upstream kernel.  So, it's
> > not possible that this ever worked with upstream.  Given that, there's
> > no regression in upstream for this program, and it wouldn't be
> > appropriate to consider a sysctl knob in upstream at this time.
>
> Bleh, you are correct, it's an NXP patch in
> drivers/crypto/caam/caamalg.c that they've been carrying in their
> tree(s) since 2018[1] and has apparently never been upstreamed...
> [1] https://github.com/nxp-imx/linux-imx/commit/6868c9e49c1854028fb46022d=
aac3b1b10ca2c70
>
> Sorry for not having checked, I was hoping for better.
> (I should be used to it by now...)

Sorry for joining the party so late, you're killing AF_ALG faster than
I can follow all the mails.
Speaking of CAAM, there is a legit usecase which exists mainline. No
vendor patches needed.

You can create a CAAM BLOB (a generated and sealed key) using the
trusted keys subsystem and use this BLOB
later in AF_ALG to perform AES with a key invisible to userspace.

e.g.
kid=3D$(keyctl add trusted mykey "new 32 pk" @s)
keyctl print $kid | xxd -r -p > blob.bin
Then just create a caam_pkey_info in userspace and feed it into AF_ALG
and perform AES with it.

So, pretty please,  if you kill AF_ALG and all this, offer some way to
achieve the same in userspace.

-
Thanks,
//richard
