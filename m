Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF22550D5
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 00:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394955; cv=pass; b=KPpVg+v5NIXJVbgsyx5Un2+9IPSp+TFmWLMLlVi5uQ8IH4gf9B5GkH3NxdFmztb0Ya/dgITPSv5rreM6MBWiuyIuX71HPn2K0Pm8NoRhW1/y1kvlwZTNiUMnFALmus6pAXz0CuWhOfdVWQdSdvDhXAS249mQCWQkzo7NU40MSes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394955; c=relaxed/simple;
	bh=yc/XCwDCJJaEjokK4nDQyUrIjP76wGXp/V1y57foybU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvwGadpk4ZdsiIezM5Qi6Ko8BGWmOkn7uNHup0Ny+Mx6Fv/wT5+IUr0SdZr0PH3rjDFNAAHuJLvPHUowOD3C025k7MdM4q+zpRQlDgTevW+L+aBpRtlOttfthAgicuhoWbUKDflUEPAcv+sMst6LpNab9ueLy6S2PXJOsCh516o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhlUgjh2; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhlUgjh2"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84864086bfeso1670726b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 17:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788394953; cv=none;
        d=google.com; s=arc-20260327;
        b=fB/eCSJCjgu9daiP8UCQ/xMrVQaizSCyb3JDLMUDySnJi7WulaGOMLMciS3PlVk8rm
         2X5bMj29kgrGoqZrmcMIoiCzs6WcjWKZgGPpq6TRjUPFUYzIOTyYxi3nf78qYtMFi6xf
         egVDQrShocBKI0an0ne5t1tmjTodG4gNEY6LMwGyuNmaqyvopQenuq0EqRBVFPKOk91b
         DWa6td0sbQZ9U4fGYzYoMY+12CgrBp1bTr++h1qR/8wVebSw6J0dnYsJbRArmVFYfPVl
         zOhamDb4bDz+xeutdrSNAzHmKE/4GrR1gbOjbd/s6TxcFb6PpWEJ8sojLrpPr0psWuSm
         ullg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HSJaIZQ1NlOzwVPE4FelKmhuI0sTnWecrED0YU+uG94=;
        fh=I1HvMFBBc1NzoR+WP6QZMoce9NahhbuwuyBC6EKf9eI=;
        b=C/1swN5CggaCaLwgqiB4xpGi/NjA4sNkwbVSicsEATBU7tf4GXEVAsd+NjPWUlCdFw
         C5cbNCQvOHCBwXPhflgBEm42S4ubA3sWK35eclql2eTi/TASQ0sku0R8BSIKS7h6jMC3
         L2XTKGrSfTyTwCm1qcG17juxFZ3Z1rYakdGp1vLMWJ5+TTMcG6keeVmbdVkPQlh6/XyM
         z3opLCC836cr2mie2oPy9KUAmjevtkXdO5Gro+1AgrQvGze1fJOYedIymMMbMGcfUb4y
         mKkK0UIvsVERVgCsSgniRJ97+hYp54my6A/Il1KnjJ3FD6jn1YEL0gbFDBW2El6ha+px
         O35w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788394953; x=1788999753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HSJaIZQ1NlOzwVPE4FelKmhuI0sTnWecrED0YU+uG94=;
        b=ZhlUgjh2ARxjhBYssUX+RMHmcMDxW+zT86XxongItjLVBLTgQXgwadVJtqdvWIYZkt
         +bjXYUDxIbwq1Bnjs+PkxzBGKSKau0m0ZOrw5XDJPCkHt6+mhFo4rmKG+GHmLDxXTwE/
         rN9YJrx0zGatERU8GtAuDHs7pjY3ltSOtbfq+C70z1aE4Gfcq3yvV5alpC094XZqZzFo
         DeDAmxoTJw//XO7A8yEbhw45AgxveLPeVil6dDFmWevMjrUZw7W1sTgiLDKRgWL0rL2a
         8UbXTqlma/J6tClOSfac7gC33sov3eNko3nt04d7WoWjFiGMh8Uzq5y3vfhwyBX2cwvJ
         IXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394953; x=1788999753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HSJaIZQ1NlOzwVPE4FelKmhuI0sTnWecrED0YU+uG94=;
        b=buKu3tqsv1kE5SHpAmh9yS/zR+PtyXJaFJAKRkPSLW3RAne6nY0DEWqpix7BNeT1lk
         O+uu6m/E7ofVEdTt213cVK5nI820h1ezIkFqHbFnkLAmWM+uMpHnb+38UpApzvsiWCtG
         GFm2s6SS8PHJGtVxqgCVT46k2/wS//kfAeusaZL8msqNJHmTMRDuTRN3wnWOUQe0hS5v
         iIBTtJ7zbUInMkbxhUs45c6uUNfCOAT9QGyx1ohBjJJlR3ziEk4d7OJ4k3B2HgsFwhNH
         2rsxPewEXgxOYVz9YmtjqFVHeDxtVkBUsXWheb/a1h+i9XSmTU51Yalni3u2P/AzUGne
         VQ+g==
X-Forwarded-Encrypted: i=1; AKwUvBzNVAbu4v5TQt0ljoV/kNG6iP6tQ84obYGp1vQr1BY2IBNFqFwO7RILAVOF9hGccEapwYW/DeY=@vger.kernel.org
X-Gm-Message-State: AFuF++k0pntQo6G8qu8am93MGHBrHQAg/6Z4yfARlFm/nBXSRC35LigH
	ghBaZt6bmVNtdMC8nEXL31BUdYJKisrnQ+GYftyRprLY+JCsjui3IL2jKSeUFJF4Q3WYsVxIsjN
	yd8gl3hs+o5eVbC5/UJPRWNGSxqJiIpE=
X-Gm-Gg: AYBFou371lXhVl61Z1R+w8iK8IM2JueIdTI1GXj+mGtein+Jr5bssP4f0CP5ZmehhUy
	vqw5PsQpeKPYlVADNK7pgBYNc5GTasx+9FEO7xfGkEDGw6pxyPHV2kcYSgYlmlrIjVvhOt9bOf5
	nShdeTpfJhOgONXk6rbkDk86MKevF75863QK4lSahm/0Cn/KJLbo/gFxH//qGU4rfx+I0EfKupT
	lkfS8DbqtrmBzukLkoLmNaI92TcsGl82zHbwdLDoE5bPQ+zw+mSXXt9fhj32zCKzQihrqfw+muc
	1bRzWE+7cBRWBtMWgfbYDVv+SVu0vIQxaS7aKNAxyOpz1Z/yGi7QePP8Ge0IK9GFePxrMbHU1ap
	HyPKu5FzjQCLRYY9tbuDcwqnbcJDQoP1cdYum
X-Received: by 2002:a05:6a00:9295:b0:837:e9cc:d474 with SMTP id
 d2e1a72fcca58-85ed1d07a02mr11562973b3a.2.1788394953119; Wed, 02 Sep 2026
 17:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com> <20260901-libbpf-frags-flags-v3-1-4eb6f14968b0@redhat.com>
In-Reply-To: <20260901-libbpf-frags-flags-v3-1-4eb6f14968b0@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Sep 2026 17:22:19 -0700
X-Gm-Features: AcwNN1Uya_EPc8em6u0NWFruh2HqV6gSZQUAP9dd4jBDCAvedMFrqePOxVJvSUM
Message-ID: <CAEf4BzacBUMLREUObGo5544wyD+mm1=y8ZTnzd7OdDL-c==mMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY
 flag non-destructively
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 1:47=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> When setting the XDP hints ifname, bpftool would set the
> BPF_F_XDP_DEV_BOUND_ONLY without looking at the existing program flags,
> overriding any other flag values. This was always a destructive action,
> but after we change libbpf to carry the frags section flag in
> prog_flags, this can impact bpftool loading of XDP frags programs.
>
> Change the flag setting to be non-destructive by OR'ing it with the
> existing flags.
>
> Fixes: f46392ee3dec ("bpftool: Specify XDP Hints ifname when loading prog=
ram")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  tools/bpf/bpftool/prog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a9..8c2f9255b36d 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv,=
 bool first_prog_only)
>                 }
>
>                 if (prog_type =3D=3D BPF_PROG_TYPE_XDP && xdpmeta_ifindex=
) {
> -                       bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_O=
NLY);
> +                       bpf_program__set_flags(pos, bpf_program__flags(po=
s) | BPF_F_XDP_DEV_BOUND_ONLY);

maybe we should just add bpf_program__add_flags() and
bpf_program__clear_flags() to make life a touch easier and code in
selftests and bpftool a touch less verbose?


>                         bpf_program__set_ifindex(pos, xdpmeta_ifindex);
>                 } else {
>                         bpf_program__set_ifindex(pos, offload_ifindex);
>
> --
> 2.55.0
>
