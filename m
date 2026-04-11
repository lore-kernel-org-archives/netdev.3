Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E91799F
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870382; cv=pass; b=qi96jPtcHbrLtxOgxpmDL8vxb04rdaPYAgVNS0XlgnWag9n8D3r4KHxZ4W7nOEEuwsNiYVOtd/y86lNyp1uY3We67RrOGG7a0HApzvbZIzO5G47ZdmGjvnsHQ2+CZvT0DscBP7Txi87/GlgM++Uso38S9Md5X1Z6xlfaMHi6m14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870382; c=relaxed/simple;
	bh=CglKaT8q8HTeggZFLMd5JWhtMWstH39/dJLglKYh+lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCUh5VHNQCM84IaMcznInDiyW7WUw37wOxw+pKuTpIYZLNhgVLU8JUrqEcMQCmQP97O/lUJz6XPqkGPuOMX0CgPOObsGvPL7TREVaGQ1ONMvqQr+X0t8PpRpzmTqoQylo/TJ/c2d4DD4CF0a3sfgwnbftvt7iN7+zvAI2Su0VzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0ylRXtT; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0ylRXtT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b949bf4easo1576498f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775870379; cv=none;
        d=google.com; s=arc-20240605;
        b=aMuZ2UUlx0OW4yF19DBZmQ+SJSt16mNFc9A1Y+I/UfDUmMvL3ghWaNNqjTzcMmFbjk
         2yM7+nRXz6UFZQ2zaNzF1Of1LMFUkMQmym9G+etyJpelmQ6pkijRhuunxYhmQLUtBmfz
         1VQg2gghqeXcLTyE0qzgNIw3uXCjvKrCp6fNkyH3RIKNq3irxkLJO66iQX9epmg+4OLv
         EJZTdGG0nypycerzeURi+u/nRPaKsI+cRsIxVWXn+1bmJzTy0RDEAdQbpEL263/H2XOL
         F6DenUMS50G/mcF5O3L8H8h1Zj30L67KnATHbnduiotmPzLvrhOdrjfwt1rSyfrqZZr7
         cLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8OZKa9SGoXcu6sayigWJ7uTxhjTe7+OEh9pgBdh/JaM=;
        fh=NTdorCc43QDgc0WdfYyPEAkqmelRmO3XfgRF1l5XZtI=;
        b=NRHkAsW0ykXBp6mgIt296e2w76fnPpVmHDK1CwsV5peJbnxypXXZov0MarmNAl0CHl
         PP1c4tx2bEFmVPmxBvOxNg2OWHUcHHATBFYflIDIojeGbHTlMeMtnI2p7dkdzjnRUGYp
         pMsgurRYhiBBze9yMOPNWNsRQM4qhK0YP+Ir+ie9RX1dirodimUMalt4ApP7tzy5NPLC
         GM0+43Vbm6YmV46Vr892F7VcXezfnOCCQAHLuoT1/t3oO7Y9Rj8WeFPlX4vR7DxRDBfU
         vP2eby5vlFvdu4QAzRQIlHiDYWGLJ00W/y9LfgFuv73pTZJEfC1N2DZWhltXz52HULAW
         fm9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775870379; x=1776475179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OZKa9SGoXcu6sayigWJ7uTxhjTe7+OEh9pgBdh/JaM=;
        b=O0ylRXtTwC1Wt6WFz8nInMhiAN5Mzzto+uwlWOGWlJIJzfacaMfFneaac0uUjfSkBP
         B1Tv0F5EEFZNX/Lcc8fpkysdsG4ptQTCxsZ+Pb8TYZ2cyD+Uv48SB26Gi0xKse3fOfw8
         mGMpxdJm0PsjrAkGeawcH8UEYr8UH7pOuI5wIgxtVEEn+pYJMBWhEEFREfz2Ijmtn792
         D212LRgXh0niheC3HvuVMjTvg4fxQseZ1k6Vme6Pio9LTJiOruguLK1xZk0NLxaU/xs3
         2Nf+Apih/BsUCB3u1/khqw3QkFBkvf/4NyvvrrJEHKViK5ElcO3d4lk3356c8//LRKo/
         658Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775870379; x=1776475179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8OZKa9SGoXcu6sayigWJ7uTxhjTe7+OEh9pgBdh/JaM=;
        b=CA5g5OWu/qbnGkB05rcVK8IdXuvi295dVN6OiZAknvTkl3hFs1WmBzOG28dYLTiRWu
         DbsWCQG8MrVbbC103ZmEgmAUZcQDlbv5IciDBgAejOZ/F8trmLoFGi0ZBFuHimqMkwI5
         GHsdixK/949m8oHZ/yLeSiHDkC+5O9W+3aJ6H56Z4rn8ik8KVl+BuTU4ntRcUIJishTp
         oOEYw09lXLYVMGXAASSNaoW38ZN3pUz54iduqHCvCnAuPcvJPR+pfU6GQ7l223q8m1mX
         Gz51xqkbZHq6dbPaVQqo839AoLsUZNbiLhcKaV55GZcdTRJaw0rOi6EncIwXrIQxfO3z
         c1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF/e+uSqMGHnlJxHgk79uPBsV3wKVus3abyTWlXh6omtJb1++Z0wzdSoFSIlb7vqDX3UFnUK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEk7AToyXJIXovD13NAt+HygeVKf6G1hK8Ec/2OVc81/DTqCGN
	VAvRFs3gUsBrSBV0KWydKMXIcNkek3yw1KIaLJ1SXSvPW6yhGAU+ZUrvaoSZBmr5cYZ3IlwMhf9
	APO/sLhpvrjRqL75kdWv+EJD0d1/kFPh6BA==
X-Gm-Gg: AeBDietjN70YjOw1oScSgSAJCnrnp5tsIGAefBhu8Ss5NjBCgL52YpJGeSPUwZysihs
	/C2ed+xw2YflmYXV7QVzm9IGg+IZPl/VT0Qvhr+TLcFdvLyLRkTt+PvYL8lA6erhWLy0r5UZmvB
	AF6+i00zVqK0n/Cet2VXJVTEDKGMsgeS+pRNY/FzWob6hPofnhK6pQ+A5Qn4U4/fSwYhCobiLP8
	q6uDjdN82mvf7wu8tdnQO3bNXzvg4d2zA4zI27/dWy84uPFcMpFE28VGaqDDUlZ6VZFDVvL3xJa
	g7jPQxWt9dwpzS4wjouhg2+vTYgX9toUrFkqteS6ryV22TKkRLdDEbp1yyn3xxiBV7YwwT3vbvM
	NEaeSg8A8wWJNOuuiabwo+lVeMA==
X-Received: by 2002:a05:6000:480c:b0:439:c153:ae3d with SMTP id
 ffacd0b85a97d-43d5955c07fmr12999815f8f.6.1775870379228; Fri, 10 Apr 2026
 18:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411001711.3418264-4-ameryhung@gmail.com> <9f7e217d9a5184bfcf0bd1112a9075c0f3633266e8eb1026cd1c651a0754edb2@mail.kernel.org>
In-Reply-To: <9f7e217d9a5184bfcf0bd1112a9075c0f3633266e8eb1026cd1c651a0754edb2@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 18:19:28 -0700
X-Gm-Features: AQROBzAd9LCLDqHMq6-LCreyoFS5ypIKBHGiGpbUgkvApPh0SIvT-diMd9Ngt8I
Message-ID: <CAADnVQJ5gSL1XDYYwgKgq6pxLG0m9m6mC1DntHxLCrMmQ8Gp=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] bpf: Remove gfp_flags plumbing from bpf_local_storage_update()
To: bot+bpf-ci@kernel.org
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loca=
l_storage.h
> > index dced54e9265f..9e4f5c45c974 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -188,7 +188,7 @@ int bpf_selem_link_map(struct bpf_local_storage_map=
 *smap,
> >
> >  struct bpf_local_storage_elem *
> >  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void =
*value,
> > -             bool swap_uptrs, gfp_t gfp_flags);
> > +             bool swap_uptrs);
>
> [ ... ]
>
> > @@ -196,12 +196,11 @@ void bpf_selem_free(struct bpf_local_storage_elem=
 *selem,
> >  int
> >  bpf_local_storage_alloc(void *owner,
> >                       struct bpf_local_storage_map *smap,
> > -                     struct bpf_local_storage_elem *first_selem,
> > -                     gfp_t gfp_flags);
> > +                     struct bpf_local_storage_elem *first_selem);
>
> bpf_selem_alloc() now takes 4 arguments and bpf_local_storage_alloc()
> takes 3, but bpf_sk_storage_clone_elem() and bpf_sk_storage_clone()
> in net/core/bpf_sk_storage.c were not updated:
>
> net/core/bpf_sk_storage.c:bpf_sk_storage_clone_elem() {
>     copy_selem =3D bpf_selem_alloc(smap, newsk, NULL, false, GFP_ATOMIC);
> }
>
> net/core/bpf_sk_storage.c:bpf_sk_storage_clone() {
>     ret =3D bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
> }
>
> Won't this break the build?

Nice cleanup! Pls fix the build and respin right away.
