Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7536C582
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014908; cv=pass; b=b1LtsIaqJjIj2sHm4lBZebVDqMTPmSNR//WJ45TnPKT6Oaa+Ld9TW/QLi/F5jVrdQdrLYul4Opd0DTj3riHqTqiVYP6PqFy2m9HuqYjiO12s1DUMxagpga43EJ0Td2/BVCcQK35xh/h7V2keIGYV1X4r7B+f27dkQv79wwaLGuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014908; c=relaxed/simple;
	bh=SLOCQgI2ErXSdd85hQa3lFR65w2KRZdCPX1tctcCccA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZP/0ygBYhTzNVgltMGDQl0j+xG4sc5zQwJw7l+ojsHtopn4Io2STInJmne581BpCnPV5t+zhaqDlPI0Hb8MeNcCiA0DytTZTwPJ8Nt8uoyoDP+oyufPsWqky8+sJBPOVyM0C8vQEOI/EKODHQUmx/HO7J4DtCtsyAb05jTYFqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmbMiNob; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmbMiNob"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359019da8cso38382f8f.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:01:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769014905; cv=none;
        d=google.com; s=arc-20240605;
        b=h1/Q9Ee3u/7U0PP2M0ytO8TUEGLPsR11uCy7PbgtEABcRY8Le7ftYFlplWkgujbSNT
         g73fskgxSTTv9869wsDSYWot7jPky27yqi+2NJCK35418uUSb6D8cO5XzrvsSxuTjLsO
         zL14iVQXlGxg+UpTSkjdQYGhVEqjWoa4vVnj2hL+5ej7g77itC64IiRVhl5KGLmDY2lY
         LPNMkO7rlhrOZ5gzjeCIVsTEU0B796/21/GTr3TC6TemuyAyla9uclmrEi3nHwqeq6+i
         WL+4HBLxvcrBDp+dm8N5LRjNqXboNhfTrOYRj7lYNt8W7yY1zLKvIt/zkfnSAaYe0Sg0
         U6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kw3x/IwmBAZeFPJZDjWdx/Cquty/Ye+Fg3dbgiOuCng=;
        fh=hPLuwSJQnwM3A1MxaaAdaOlTsMXF4Kob+LePDtFB0nA=;
        b=fucRO9cSCBjJGy/Ix0WTmFN5r6RzL6+7vN2RXPiz/PfzjYCRdbg/C0au9YE1Y5yAcn
         SBJAZ1aY25jn1jsFcPXAnuQPGzCBYEPDih9HSdDOEo4zycxXk1R9HjZTGgFjYDdj68Uq
         LjK9RylW+lroW6r4eJy10wsCaYtJaAVjSxQRHDWxr1rcYfWRQ0vxNFLJxh0sOOHokUQS
         nlVZkDSGBiKyNs1/GO49w6zT2DgRDwbtfIda9lQGCIpcOhwoIOtdSEYusuGlqDwAvVS4
         IZQjhs3d9h/Ki3aK2ZwvcrYJeF5mDydYoOZ6JHWhxExyLly95LysDX64C3MpSEd4Mx4O
         FPyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769014905; x=1769619705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw3x/IwmBAZeFPJZDjWdx/Cquty/Ye+Fg3dbgiOuCng=;
        b=WmbMiNobuZmY+7pwondkzhvyQAxVbdBm6w4E/COavfAaCFOk9MjfKbkIwFiG9SmDcp
         jw4MEgkHR17hEnktNiaDSqCS5ycdJT/wdk5ocK+qQSISpY2ZOgEV61R++JE5QZujCjqs
         /PIxGQMPcK/Zflnp040FtztrFB2cAC6CQNOWPipqPv/8i70iKC0unHTnUM4rK49tLjEY
         lnz/oE2QKwhD/xEHOZp/19W1EKPD8Kyw0Aeu4MNnXmTd4kn1eSSWyk6oHi8xCw/6U5+A
         iNJVHVLOrNmfcEnrfq0eoaLsuGcy2gVX1LHEy7kFmVW0LlQz7cUZJKejdfaZ2HeDFZkT
         Zlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014905; x=1769619705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kw3x/IwmBAZeFPJZDjWdx/Cquty/Ye+Fg3dbgiOuCng=;
        b=M2SH4bX4bHk4uMMoDXAEswBuEjGnZjWcAcai1OBz4w0bhUiG6s/gms04d8QxQICkYd
         5L36we3Y2oMPhnsB3Uo5x8hznJFq9xcI8OxB0GxnOn8NLk70OizG4fZDXEgyx6Ori/ve
         L7MTjSIAvNqGXiXSKi5QSFRamuWtL1HfIfuYHVhX54mCJgnRUvS3jeqJoNbuQFUwKC8O
         aUsUGF8FYa0VbUD3yD9UUzt691E/yWzQGRY40gHBFNYPmrCPDFivqdiULAvpNErF85ZG
         8FTGZM3w1dBcPyTpetr6xGoYE44TnxIsN1XHe8Fv33nSpDpj9zHWtyh8pg6OLMTd75/D
         NRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX68XakLlalAQmdyW3oxwkno5BMhUmQXuOzPfIO3Wi2Ic3CpdMvkCvW03dqeRfJvsPPgOsoIfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpbT0ARv6k8jnhEMEd4nld0/Ibs5iTZvdxVGnKOA6bQU/iQLl
	MMyAGwWP3+f73lFc+6osZkW6dSdFRLP+rU98v9M5M1WpyCIqWC4X9LqnT4aYHc9Hzeck3is++xF
	y2xslaLMM7nQKqeExgX3ukj0LbQDAKGs=
X-Gm-Gg: AZuq6aJz81XYcW6RZZGgpRtLTQ+c2P5TdMxKN/5MCyUZqWd2gIp4CudQl/yGxjkPprK
	GxL/n/Sk3D4+K0NwJl69ONJmd/wXmA8sxzkfaQ+7eeLR/47798tk0kYXztZo1REeswT3njT08Os
	sTVCnCdO1sTXSmVolJsRzYkcwrboeJFLOyfPrQy88PaaOLIfDtTOuDz2+vRm6btANiemCg622qt
	PT6uigy1O+PIK/yDulgls/RC/vNhZFXBsDUQp1OOKsZln2vNMV9+oewyoWrG/mx5v+bvq/PSDpl
	vWhIR7RwTa9xc7JHTqy2Fdc8czgzN1N8DWzsyPTB6qS8cKVIyhtRcuCrEW8wsWQs2hOebA==
X-Received: by 2002:a05:6000:2409:b0:435:8e14:9877 with SMTP id
 ffacd0b85a97d-4358e1498b9mr10547200f8f.60.1769014905117; Wed, 21 Jan 2026
 09:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-3-e8b88d6430d8@cloudflare.com>
 <8eb725d8d0878a7a1b582fdfacf05d20a2542304.camel@gmail.com> <87h5sfthoj.fsf@cloudflare.com>
In-Reply-To: <87h5sfthoj.fsf@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Jan 2026 09:01:33 -0800
X-Gm-Features: AZwV_QhJ1NjX1m-MohDCdnXL25Iz6eQYI8PRkmCyiBK89IAx0ByAzxBlEJS-IeY
Message-ID: <CAADnVQJLZX1UsdqWjCB57PxJQQXnXN5ZMY5M+shnxP6t=wT8yQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Remove kfunc support in prologue and epilogue
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 1:54=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Mon, Jan 19, 2026 at 02:55 PM -08, Eduard Zingerman wrote:
> > I think that patches #3 and #4 have to be swapped, otherwise there is
> > a selftest failure when only patches #1-3 are applied:
> >
> >   #281/17  pro_epilogue/syscall_pro_epilogue:FAIL
> >
> > If we want to keep selftests passing for arbitrary bisects.
>
> I don't have an opinion. I assumed it'd get applied as a batch without
> fast forward, so bisect would be going over merge commits.

I think 'bisect over merge commits' is rarely the case.
It's better to reorder as Eduard suggested just to be safe.
