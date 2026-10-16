Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583C3BF68F
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792183802; cv=pass; b=tlqqP6YoPobUiu9jz9RbZUvEcYHe4vCVUHMUAHK4/u8z9uvvjQhw3J+FkYQs6wuOVCaOY1cN2CBofo3ts+jwXqwVcqL4GA5osBB6eQyvlVVc0iQ69bpzBnnzEZtvhmJ+cJ5x/5Nb1tALRmzrvUCjhMkzwksTFiJ8dER0qmjAPcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792183802; c=relaxed/simple;
	bh=6GJ45C0RD5GXr91xUYZPSAQ37i/pcOONesN2xzX2DLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMMQ92wnrKdqdvqV54GbwC7GmHTuWuJpxnZ5O7Th7wU7ocOUFM5KwrLN4BWPw20Mni7vnzsxu0RisP/FFlwrmujqPbQLLjpUcrBdrPx3O8jPLNoZLS7cchZ5ywBLG1n7b7bE0q5rwDf4kvSqr0OlpIvaPga9ZAiNpInVG5rTvzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlnjagEm; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlnjagEm"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43bf9548df4so340989fac.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792183800; cv=none;
        d=google.com; s=arc-20260327;
        b=Z8fXCBoFYT0sLkfmblgqmvcgxAlYXBGgz3WLLShi+IRPZW2Fu0Q7Pfp+iWajhJS9Z3
         6fw0p+Dxj52I3VGDVH4N1LMGUiH0ix65XDh5zPJtrW6AVAYKg/+9TGaPr4mBtNTKVNhL
         W/GFuzCFDmGhFTRhZ4rwT/OgwclwsuLOB+hfDAGpHjAbYd67G56f+yi/I3tN0PxsNUDw
         BGg6HJ1k2kAzcNZatMv3uqCDAYj63A7KACspmT6fGsWbaNfGJwl4Z+kCJ7sfpsKG+APM
         fJfr0x2pOpQCSI3Mn/XKozmevGQ2DrN0drEGozfSqjnjWAxghKxOe86nuGUfC3/X3rNd
         iObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HuN9JhFHSgD0AI17sHkiTKKDtmKFK6f5ghoUZR3heZs=;
        fh=epXhVirRVD5Wec0AS2Gfug2O2DoV+xpEFPq9XnjEJI8=;
        b=K3NJ9CgLuNa1YT5WntwvTjDcmvHdBavBiVaBS0ElLc8MhYfFAITP0bB9YibS8TUdIH
         l0v5YpBKqzu8o1qrkxj9+k/GDrZb5EfvvrL3uaRQojeiV6WxRxwKFbscZq4yRvBEkEGH
         NDFf76vUj0mYVkK8GYJGqshTk5LMkqdlE8X9Fc0y6xwcCgHlodmTJe1/FaIOO8MvG42N
         brAXpQ0lSuzxGClEIicJEIm25NI+nCsjaEQDU/RxUsHYeTHGzZNI3W2jNw2yiWHfC+YY
         13dy2GVz3wr0i4uT3RMUBAt38v32hvM0eQW/GTSCwhAvdtstW9N6cuvISV9k9jbbzka/
         UBmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792183800; x=1792788600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuN9JhFHSgD0AI17sHkiTKKDtmKFK6f5ghoUZR3heZs=;
        b=DlnjagEmQljtjuIe9Dw+rV9cuK0amR+i0WLhWNxRE6pb/Z/QeTefPogRChxj6UAiSz
         FCpum2MtX1ycYhvl6/pfkqKC4R5YJoYo3pbvFGPWpIfZWjrAKtrsl4fEUeWjLLXxX5W8
         Kz89bJR1j5Idc8TFSkqWWOZ4lT7CefJbpajA5wAOoBqVWYQ1LVV2rs8Vm5M2cfrtBkdx
         XCHTRG5O34e4kLJgEPLLxCc2mBF5OdW3X8r+HxCRrkMWnwO9YcP0XOXSBBCElR7Y4W4w
         8W4T7I6xVMvUCIXMA5tDBxCgET/ZNOt9XwHp4ALqVha4S0ZQeQL7LN5GO6K/SK7D77iv
         bV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792183800; x=1792788600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuN9JhFHSgD0AI17sHkiTKKDtmKFK6f5ghoUZR3heZs=;
        b=yPu6s/YWIDvLNiv1l3t+1Z83JgYN3iydJGgB9Ge73NriiyDDU9qWrU9ZCMIRqTj1dr
         7kea0OtryPCpvKtXeaFQn1HYjDXUqh3iKpKnOIVtplJl0C8OzgBwVYWhcR/RyQhhB60f
         QBFuIw6H7pfM38unG6f7jZyy88qeA75djAfkPyauK9zYIBotiIY/5Kvj+bLr/55u5yGL
         qBxX4QWHpGC0tzawu5fScGS8reFo9QvTS1yeXrnq9NDVd8+JMDK1kUzinnKrvla5/Jrz
         Ajrlp/RljtI1suDHpB/OMigDMWl7OxuBbcbfJA3UWqZCibwpBRMLbEsDLh3tBNrWmmuT
         P2/A==
X-Gm-Message-State: AFq9FYKi1jbxzyXYT9V2/G1H1cdKXsEg1ggkYBicjHs244ggzfE8DQnA
	+aCglZiGO23CchTU3uNBhkY9RfA75jn4IkfHaCaBA8ZvfprU7sZzLuAXyPLoNlDUWU7RYgmiWCA
	GzqXo7qqFvyvndQS86WyfvFny9n84dBk=
X-Gm-Gg: AYBFou17YGChoHE63xVfHaR53odjo8h+V2DRBkjJcrDjQx5EtOWkb/3xjugNVQJvH4N
	Bb8y3a2JFPn6sxm/3+EfYMGsbDAZZ4GTO3Oj1Q0zM1VVipQAnyhelPRN44If5GYHmMwVVR7C024
	c6zc4IIpmUqpfYJUquHdPxYVUGSGrXR+DVM8zrbOzZsDslna9L6DtXBZ2ZBQ5tyNJtlHk3xrZuw
	HaEVRDl+9z+2yq5015hJoVYz/1x0c8SAfrl9wHJCXDr5Q7oTzsIVk+uXgFhtl0t+pdSwUbqt5L7
	kWighiL9oulBkGf3zUfS0801UI02ToK/lFvBPX6dUrNOr/uUPx24QDo=
X-Received: by 2002:a05:6808:1645:b0:4ea:1854:b949 with SMTP id
 5614622812f47-53ccd9ba710mr669164b6e.33.1792183799790; Fri, 16 Oct 2026
 13:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791980149.git.zhilinz@nebusec.ai> <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
 <CAMB2axNZ=Js_-jGodWE22VoeVmR=9AL2V8jr_t9G38eAaMs_ZA@mail.gmail.com> <CANB6i5wK87uZ+jYqVVy4pM_jW4We5Tey4rGmzb9Kx567U473Dw@mail.gmail.com>
In-Reply-To: <CANB6i5wK87uZ+jYqVVy4pM_jW4We5Tey4rGmzb9Kx567U473Dw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 16 Oct 2026 13:49:48 -0700
X-Gm-Features: AclHuK8Ws8y4Bsg87w4p53aNMmTvyPLIoFx8O1kRZMXMasDglrsChmADVt3UwQ4
Message-ID: <CAMB2axNzbr6SGBcGQV7O5ra-Dhjo-nbigopfK389BFCOOadu2Q@mail.gmail.com>
Subject: Re: [PATCH net 1/1] bpf: reject raw iteration over managed sk_storage values
To: zhilin zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, daniel@iogearbox.net, leon.hwang@linux.dev, 
	mattbobrowski@google.com, menglong8.dong@gmail.com, kees@kernel.org, 
	bestswngs@gmail.com, memxor@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 10:24=E2=80=AFPM zhilin zou <zhilinz@nebusec.ai> wr=
ote:
>
> On Fri, Oct 16, 2026 at 1:01=E2=80=AFAM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Wed, Oct 14, 2026 at 5:24=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai=
> wrote:
> > >
> > > The sk_storage iterator exposes values as raw PTR_TO_BUF memory. Atta=
ch
> > > validation checks only the maximum access against value_size, so BPF
> > > programs can read or overwrite BTF-managed fields such as __kptr with=
out
> > > the verifier's ownership checks.
> > >
> > > Reject value accesses when the storage map has a BTF record containin=
g
> > > managed fields. Iterators that do not access values, and maps without
> > > managed fields, retain their existing behavior.
> >
> > AI is right. It also appears that iter/bpf_map_elem may expose special
> > fields as writable PTR_TO_BUF. Could you cover that path as well?
> >
>
> Thanks, Amery. Agreed. I=E2=80=99ll extend the fix to cover iter/bpf_map_=
elem as well
> and ensure bpf_link_update() validates the replacement program against th=
e
> attached map.
>
> > >
> > > Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Assisted-by: LLM
> > > Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> > > ---
> > >  net/core/bpf_sk_storage.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > > index 1d295a8769fa..b54fd90d4bde 100644
> > > --- a/net/core/bpf_sk_storage.c
> > > +++ b/net/core/bpf_sk_storage.c
> > > @@ -863,6 +863,12 @@ static int bpf_iter_attach_map(struct bpf_prog *=
prog,
> > >         if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
> > >                 goto put_map;
> > >
> > > +       /* The iterator exposes values as raw buffers, bypassing fiel=
d checks. */
> > > +       if (map->record && prog->aux->max_rdwr_access) {
> > > +               err =3D -EACCES;
> > > +               goto put_map;
> > > +       }
> > > +
> >
> > Could we preserve access to non-special fields of the value? Since
> > max_rdwr_access is an exclusive upper bound and record->fields[] is
> > sorted by offset, attachment could be rejected only when:
> >
> > prog->aux->max_rdwr_access > map->record->fields[0].offset
> >
> > This remains conservative, while allowing users to place special
> > fields at the end of the value structure and iterate over the
> > preceding fields.
> >
> > Please also add a selftest covering allowed non-special access,
> > rejected special-field access.
> >
>
> Agreed. Since max_rdwr_access is an exclusive upper bound and the
> managed fields are ordered by offset, I=E2=80=99ll reject access when it =
extends
> past the first managed field=E2=80=99s offset. This preserves access to o=
rdinary
> fields before it. I=E2=80=99ll add selftests for both allowed prefix acce=
ss
> and rejected
> managed-field access.

One more thing I noticed. When you respin, please change the subject
prefix to "bpf" as the patchset should go through bpf tree and the CI
first.

>
> > >         if (prog->aux->max_rdwr_access > map->value_size) {
> > >                 err =3D -EACCES;
> > >                 goto put_map;
> > > --
> > > 2.55.0
> > >
