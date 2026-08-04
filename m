Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3B3E63B0
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886803; cv=pass; b=FN0lUsMo882+HV2fCwIlsnZmcREDNanDJ0d6OvcUAtUagSPAT1dU2241myQAKhnB/maEDCXZKd35Cw5/T+Ji3Z4QtjOssxA9b2MCrkpdLdck8alx+HOVzHvLx4tSmGvXC2m7BjlIK7YEhgKV10BTgkXCobzD3shczdEWMqd+Wjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886803; c=relaxed/simple;
	bh=uoWCewIAZ9hyxMRAN9wvtPH2p06arJIF2GepBNWFaiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULVN5UgV7Oe/DQV9Ic5DUN50Ua/kc1WtOJNd5akIhKybSbdnjgKQx1m2G9GLmDWPdyVdRt5K0jd/ud5r9gX9xXkcdtth9y2IPjkSELu7aZ9nEEt07v70DR09aNH+YJl0ah8NK8mSDR0VUARC3vzenr1OCx3xoXtb9mb/X2FwxIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgN4ihYa; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgN4ihYa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cace91f112so5262105ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 16:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785886800; cv=none;
        d=google.com; s=arc-20260327;
        b=YYh19yaO4mWurpL4KT2Yq7EWf8fmZqXj3wQTW1twU8yWqHdoVwNdaIJSftRxe/LBtq
         Zq1YxvgxZPS4JyUu5QBa1zt+xXQUpNgn9iGT+vfGVIIG5gnl/pXeMHPWNNvfReXgphvp
         DOHTNTdbDBExfsW6//wmCYYJXrRTMyULtSrRwzCrgSjpNNnO73vH+j9YsCU6ctguw/k9
         P94NxK0+dbP/xJgoKVKOaRwvfo5APFDao4+lFUntzWI2fCIrRGJc4eN/n+BGNREDXCrJ
         RNZxT7DviUVVCRnG2L8nMWlb1stxIPuKo893TeGt+YHxs/rMnTQ7fluSr/e5CrxE4CQx
         BUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PRVM8hQUlMTlXsPIs4erLL1+dRInZl3+7seIzd4uNV8=;
        fh=3ZlGI3nIty48kJ3ewmvCvYUlLfvYT+IHUqtdRiFxcsI=;
        b=gemUDh/PrIvbjkSH1iT8/quBswvBhMbjOjS8GNglq2lfSOIdUSkmJX9sXpcMzw/XYT
         laO98HWFnK0xbNPTYuKqWTsoYZs1W/jrteXugDygbSGF4j4md7T2KCZIRuqzMgZEWwa7
         Sm0/60YCJiQggvQ3K3xh1xJynTTDM5/jY4P58sbWArH67JjKVhBFXqUoJhDJHs+9iwwO
         9Oju+rRdpMOMFF2DGvF8ySM/ulVjifrWuv/ZBYnNHq0+BJGCdx3cz/lNK/sKyaZ1z1Zg
         4+Ra1OEjSWvOvgrNXpUIZXLWjJjsHAPSWpOq8pcUYauBokQPB84wnwhm1latVum/dQH5
         9rAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785886800; x=1786491600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRVM8hQUlMTlXsPIs4erLL1+dRInZl3+7seIzd4uNV8=;
        b=sgN4ihYagqnkBGz0+ICStRp9gi+GUDtvg3F5Mbo/cdEZAGr09gLesahGSo/2aLxznP
         kEYFia/Ce7Qit49nangIUnpdB0VJLRhLc78wY4NCnPzPYpucQyHk92Uhh+U6Uxx4r21y
         Q5ezAhEwQlFk0NthXkB7u2OLLr10uzKP5ZZeeELTfuIOPcnF2WLaCnFKiuUTdXCduTfi
         jfJHOFBEap/OLh078EkucT5UV6YAeQymxtybebZJhdrP04MlxZAr5aKqWIi7NVweUJVo
         w1qvVI03rhIgMfflygEyc7lG0W28Rw9w8+4dD4xwj5ZkEGx0BYRmaRaUw6ipWyN3/4vU
         q0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886800; x=1786491600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRVM8hQUlMTlXsPIs4erLL1+dRInZl3+7seIzd4uNV8=;
        b=GeqEm95MRhMaKzgv6YwASuvvNLrJQMbTRkjnOJvOCGBIe32GlyOpZANP9/upY4g5LZ
         vbDd3errdkLtUFU8zkBf0yDfYJjgFwWwbsOr4COqvhZKfZUufTKGxopaYRyC/VnM+kg+
         VLHa+jsqfikFoLd1pjF0Blo7YHYzP9a8MzxpWkG5UodOk5hccGf8yZzpAPsMiPb1NrBP
         X82wH6RcTDueZx+xIUnlipIv9HiS5IQ7nJem2PAVUJuNfWDlQX3Svg8P43+QTwO/VgRI
         ATCulMBvSzFIWlu0lmOxxSDKgxnBlkZJcA32Wcqx4lAoxgMCM/t6C20ryNOHg2kU0rLw
         Ek+w==
X-Forwarded-Encrypted: i=1; AHgh+Rq1xgro7XdVjc6Aa7DUvcNpGL9O+IMqJD3eqvqLBa0dVDvzL3iXokwtPsxf9+H7/spSTwqK2zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIatcGCikckjlVVCkBHVFH86DLXugmMuex7F0Z27OweZtSTPL
	ndyy7wufw87Cwsh86iQoLTlzam4Mz0wP7RzJR67d0Em6GJ4Vb2d3XfJk6St2v4Oy5yhSGkov1Jp
	xvB/MNB13U0LFdOLyIpsR/mloOw2ufS4=
X-Gm-Gg: AR+sD13kDFqnxM5ehtc9MbA1rM1CyWNjSb/vh9Tu73iG1SJNfNqdLamCWxPyZi7suxZ
	ts5zADroHC5KGi6X4KxwFR8t4McRLTGel4qavpOTS2a82dG8zzYjz5pE+9MoW0LDhzhb+Qjda+x
	wAMkM1HVCw70OQr7f9zQ3exEisQ1rgpJaImkNXrabmnE5z0LxNyrQ7iC8A1bINkaO/lYfMaRAJ/
	YQ00kOuY0anzEn+tWFEMSX6zFBj+RFMT5KsUgv/xEWbgv9yUoeAELq6Uvm349tcvv4lVn632Bvm
	dACp+XHDtT+beUJF2fWGGwBXnInp5xohUWhtbggHpZ+jJ9GEipt/aQYe1/7dyQcMsQM67oQ2893
	Tdlvuwey3BibV5VQpv/yWgL85UXUV81pO3KlCi5cueLPFxAMXMdpN
X-Received: by 2002:a05:6a20:c79a:b0:3c3:af85:85e7 with SMTP id
 adf61e73a8af0-3cb860767d6mr2645020637.34.1785886799943; Tue, 04 Aug 2026
 16:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804145710.43062-1-leon.hwang@linux.dev> <20260804145710.43062-2-leon.hwang@linux.dev>
In-Reply-To: <20260804145710.43062-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Aug 2026 16:39:43 -0700
X-Gm-Features: AUfX_mww-a-GnHSPAMD6NdZrovu5pLCa3Uv6H92muVbZPcm4_2Im8TywcmphJxE
Message-ID: <CAEf4BzY0=ZL5MD9j-tLewfuLhRVMipAYnRJ2CD5Biji9iiZG7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix sleepable check for tracing prog
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Sechang Lim <rhkrqnwk98@gmail.com>, 
	Varun R Mallya <varunrmallya@gmail.com>, Viktor Malik <vmalik@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:57=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing pro=
g
> is allowed to attach to '__x64_'-alike prefix symbols.
>
> It is because the verifier does not verify whether the symbol is a kernel
> function or a bpf prog. That said, a sleepable tracing prog is allowed to
> attach to a bpf prog target whose name has '__x64_'-alike prefix.
>
> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
> prog, and copies buffer from a user pointer with bpf_copy_from_user()
> helper. After attaching the XDP prog to lo interface, the kernel BUG
> could be triggered by 'ping -c 1 -W 1 127.0.0.1':
>
> [    3.460756] BUG: sleeping function called from invalid context at kern=
el/bpf/trampoline.c:1324
>
> Fix it by disallowing sleepable tracing prog always when its target btf
> is not kernel's btf.
>
> Fixes: 16d9c5660692 ("bpf: Always allow sleepable programs on syscalls")
> Acked-by: Viktor Malik <vmalik@redhat.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b274004fccfd..7bb541e343b2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19019,6 +19019,9 @@ static int btf_id_allow_sleepable(u32 btf_id, uns=
igned long addr, const struct b
>
>         switch (prog->type) {
>         case BPF_PROG_TYPE_TRACING:
> +               if (!btf_is_kernel(btf))
> +                       return -EINVAL;
> +

see sashiko reply, just move it outside of switch and disallow
sleepable for anything that is not kernel/module BTF, regardless of
program type

pw-bot: cr


>                 t =3D btf_type_by_id(btf, btf_id);
>                 if (!t)
>                         return -EINVAL;
> --
> 2.55.0
>
