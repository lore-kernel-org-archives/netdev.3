Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C32FE042
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128271; cv=pass; b=M5g391cGigA2BLQIS+siYM/YGGSbnQWNfXIXULIE/59mr61vCuNSdSLJvWsfKz7orIAUoTlBnW2KlGmA32KEeruPCBan61xzloVqdnbKg2l5nOor0BcL2ObWk+iAVTQbP8M1zxwJAjJjEgJMd3toblN1ARATYh5Pm3oE3u1Jvoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128271; c=relaxed/simple;
	bh=BTRcAoLz9G3GYaIgNNZe5UyvedxRfE+nhPVx4QlhTAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6Huva5zUo8RL/KVgmNxZJE7gZIoLRmnVK+8fqJJfCEhs1PS+7C/+Cg0Ah2WHDLNh9ZNBFjX32+awpba1332oTraIZcxJ+fbM2w2UG3rcSVKXFfKyKllQKQsYs5qmL7xDxogXe1IIUnmyZMkcka7UJTIsMg5VC3lOuw7Ikr6TVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=KHjFk8kR; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="KHjFk8kR"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6768403e9bbso5356066d50.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 22:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792128268; cv=none;
        d=google.com; s=arc-20260327;
        b=QGWKdbAb9vqx6r1pkZvsxP7IJA8sdYxteuctt7re/YTikPz3MohqHjRTzBbc4F4zUO
         8CZs8Tfzwkj9R/PtZP79B+hXs07Q/R6gLEdxRjkBFcZ1q1RbnH3/oFoqVguURIoFgUJO
         LM8nPmN3bdh6Kx0AazelS1Zl/68OsRLT9mQfapEfv7YDV0SaEVDbmRNG1lSxbW9dg+Ks
         gtfKwP95qk11xStXfm+xzk+vcJmTECak6ewnJG1Xid48xhwCTONp1WJH9NsZoqqLr7KR
         HkwUoq/1sm2QL9RBKZZ1V2/cdVlenTC+2lsjPojpOcWnB5+/KQP5LIJDb5T6hKiiX7s0
         vUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5SLREY56Y75V68L1t/rYBb7KWe+heQEE9CMZN2v5p1Q=;
        fh=sfl5oLa4NciaDj7O/Sh2msbeRXgFjYL6CdVo4pDibiA=;
        b=tDjy7sHxbi93BOEG2arLGDgHBn99wmV1E7V05waqlIJqQxEWsZ1fHkbW7Q0cLtYYNX
         J3eCRLyhTILvhbcLGt3NMU+pfSI8txFtyPzl6ew4nXgQBHUNk0zYJRkDAEiD8enUzEda
         z/uQYRGScQv8Ta1RjOzxYWt/rnwmwwnOw65ebzn5ndA02nOCkGXNCh/RB6tSBYoGJ0eR
         nZoDl8Inu7ZpXlQMaqr8fPTp4iOzf2LfBqVQvN8wyho7AESYZ74X77GUFvBtikaUJlHH
         Bb520UVB0UlF98UaLtdMVHvMLF7IfaqxgriWSmZQtiHOHoNqSe/CQdzi6VgcFmwFP1V6
         Eefg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792128268; x=1792733068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5SLREY56Y75V68L1t/rYBb7KWe+heQEE9CMZN2v5p1Q=;
        b=KHjFk8kRUSaJYwUrFR46vsWj1trK0vQ7AAC+mCZ8TEdAScm7KiB/NhApShU5rDP73z
         eySCGR6LP7fCOkNircLZhOif1Pk+SVTAjDIp9FXuJxkdEhj8brY3lLwLJASG2Z2akJZ/
         r3dMwoKEAoBeWK/E1pSg5wgK949WILrHl/gQAwecs56k8JOB34C+z5lWMsK+IuadUZIb
         +lTQNKyMBLPGhSZBYJ9rAFU11HxWRir5z8C7TxVGh6OXwjpJm6jd2kDe/D+DVF7g6qqO
         r01srOQpDRouKvS07zctGyyJ2wgzvbCryHu2MZ01+5WBAqHz/PD5RtZVmtLV4q0Cp8Yq
         y4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792128268; x=1792733068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SLREY56Y75V68L1t/rYBb7KWe+heQEE9CMZN2v5p1Q=;
        b=FcgAdNrgGVMRu60UXDJXFBfbXjTUZzSG1fKO0nMK5Uvrb+4dnYaydta4hH4B1p/pc5
         uwqvgLrtm4VHsDwoOuWNpT/APDdTtTa1kuIDMk5Rq67bXYpGTofxzPzv75cfin27DkR6
         nw0U3CrtsWF7co6rSQDo1ByjxjgFO+ftQIObtK6HRLSlsYKr2pyMUcJlP15fXtpdfYqq
         IUkU+mUs8zOQe0T+Hs0MB04H01ON0JQ1zimeeIxARUOvvtiSiLcoyJf3nuMWwwuTYzHn
         i8X3U+ZLebUoS4OMePvDKLIfKZE3BzuOawd5lNVBtT075JCeRZO0xXaEh8JchT7pXvMm
         YKjg==
X-Gm-Message-State: AFq9FYLy90meOrBBhYDeL679KBhulszdWL3xTD0tJ+BigS+lyP+iCFNr
	EUdVIHvAoiL7oqRRdQYUPYFwO76KQgpkcow05lEMR5zDwiifnnC9PNdnNJCpX7B4lat/VbxXfTu
	dQyfHRJAK8HzxWNujWCgrxjrNHg5FeOF8oCI3enUZH1g=
X-Gm-Gg: AYBFou2WoXyOskfVrLRoHXP0lrkbO+FIYo5S2iqXHAOoSSUA9kdL7Uw9dUSX8D3KOfM
	Umsx5vpafyBPX7q3NEb2bt6LBDuYG09oCd7l0dxjMadm3GxQ0x8Es9bDaUh4tfV/VrNV/8f2Yfv
	AouQ9HPx3OcoHaM8Wy03994cig8m/CT1240BJuXo5BFyGtpvnkBx9N14Px/y/rtbROcUexEEfqa
	kGXuxbyFJ97KRWLiBPcSOoAFmLX/z0mM9PgeXerUfks9pc9SUeOJuN4nx6kZJ3DqXpwG4HNh2Dz
	De20FSH9cCUfTZr2ZwTKDSBcJiXykB4JzolBn3DdaVtcjtgnN1mnHSRHRFhzxuCv4a6V7+NVs6e
	lR+kl24Z9U/MXWY2PB4P2PA==
X-Received: by 2002:a05:690e:138f:b0:675:3507:46e7 with SMTP id
 956f58d0204a3-67936984262mr8103308d50.24.1792128267662; Thu, 15 Oct 2026
 22:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791980149.git.zhilinz@nebusec.ai> <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
 <CAMB2axNZ=Js_-jGodWE22VoeVmR=9AL2V8jr_t9G38eAaMs_ZA@mail.gmail.com>
In-Reply-To: <CAMB2axNZ=Js_-jGodWE22VoeVmR=9AL2V8jr_t9G38eAaMs_ZA@mail.gmail.com>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Fri, 16 Oct 2026 13:24:16 +0800
X-Gm-Features: AclHuK87alqiyIDJZ3M374_YEDlQ3Taa4gVDZp-YmbWB5v7D8853YUxGknzxZQI
Message-ID: <CANB6i5wK87uZ+jYqVVy4pM_jW4We5Tey4rGmzb9Kx567U473Dw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] bpf: reject raw iteration over managed sk_storage values
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, daniel@iogearbox.net, leon.hwang@linux.dev, 
	mattbobrowski@google.com, menglong8.dong@gmail.com, kees@kernel.org, 
	bestswngs@gmail.com, memxor@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 1:01=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Oct 14, 2026 at 5:24=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai> =
wrote:
> >
> > The sk_storage iterator exposes values as raw PTR_TO_BUF memory. Attach
> > validation checks only the maximum access against value_size, so BPF
> > programs can read or overwrite BTF-managed fields such as __kptr withou=
t
> > the verifier's ownership checks.
> >
> > Reject value accesses when the storage map has a BTF record containing
> > managed fields. Iterators that do not access values, and maps without
> > managed fields, retain their existing behavior.
>
> AI is right. It also appears that iter/bpf_map_elem may expose special
> fields as writable PTR_TO_BUF. Could you cover that path as well?
>

Thanks, Amery. Agreed. I=E2=80=99ll extend the fix to cover iter/bpf_map_el=
em as well
and ensure bpf_link_update() validates the replacement program against the
attached map.

> >
> > Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> > ---
> >  net/core/bpf_sk_storage.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index 1d295a8769fa..b54fd90d4bde 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -863,6 +863,12 @@ static int bpf_iter_attach_map(struct bpf_prog *pr=
og,
> >         if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
> >                 goto put_map;
> >
> > +       /* The iterator exposes values as raw buffers, bypassing field =
checks. */
> > +       if (map->record && prog->aux->max_rdwr_access) {
> > +               err =3D -EACCES;
> > +               goto put_map;
> > +       }
> > +
>
> Could we preserve access to non-special fields of the value? Since
> max_rdwr_access is an exclusive upper bound and record->fields[] is
> sorted by offset, attachment could be rejected only when:
>
> prog->aux->max_rdwr_access > map->record->fields[0].offset
>
> This remains conservative, while allowing users to place special
> fields at the end of the value structure and iterate over the
> preceding fields.
>
> Please also add a selftest covering allowed non-special access,
> rejected special-field access.
>

Agreed. Since max_rdwr_access is an exclusive upper bound and the
managed fields are ordered by offset, I=E2=80=99ll reject access when it ex=
tends
past the first managed field=E2=80=99s offset. This preserves access to ord=
inary
fields before it. I=E2=80=99ll add selftests for both allowed prefix access
and rejected
managed-field access.

> >         if (prog->aux->max_rdwr_access > map->value_size) {
> >                 err =3D -EACCES;
> >                 goto put_map;
> > --
> > 2.55.0
> >
