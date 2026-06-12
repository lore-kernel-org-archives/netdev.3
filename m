Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA838AC92
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286264; cv=pass; b=SdN3i6vX6DeE+W9PujOKUcm3lMRa9sI5rBb4YwmUD+MGHpVg1pBR6mYbSoKSjWWEwZtqodppNErRnWo3jtj/hSy18ZvjueMNRSbc3M6VrQt+VkBQYZrNJMB4suwRiSC8E2R0VGJWLQcT+F1VrqBH/zNDaIPX3R9m8JIyYWEx8Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286264; c=relaxed/simple;
	bh=ijLezQtdee5QOOGVXSZltymBSD8oSjijy/n9htcyaKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWMvz80a3qAc97GPZSG9qXD5sdLaLcbmTs1pkHvqnZBMqFtFwQOTv1bGZymD28X1Bz8TlOry1yk1cEhspeEmNpegfDTYEkG438xYi7wZ51oEIs5rmveo4POzDsYmXveJd8z+vhc/Hgjg4jMBIPcob/ETX35cj9EHqDX/i90tR6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NowPgVAH; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NowPgVAH"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51765531803so41161cf.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781286262; cv=none;
        d=google.com; s=arc-20240605;
        b=U1uZfB0fB6C7mMkHskHq/jBj4Kx5yDif1FXh+YEASqq3DLgehe2p1y2u99Evjn+9fP
         W0Ldx7IjVsvndTchsF7Fd2ailxPD8F95vmmyMA8zy6yc1+2FTaSwbYGCaVsYoUNPSjVY
         As2aifnRIv5FJvTeCFTD9ro+2MVl8YEXOgJRZlkDD0vIDprJAMassFa2MQv9AiZi9UrG
         QesZ9HMvcTZ46zyPniUHGFt5sm3s/qyVzTKaVYvM5xjISFI6Cwo54IAXf72dB7dDqFan
         6wUXG29WG1rghdanGVeVW04qc4v0bFrz7nQdTQRK8e0z3yiZmButw0Fyd/KGPmCWWWfb
         RZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jvH91KjfgwfGM1w/oZyTbnAZEq6BaV0f63FH1RCgTj8=;
        fh=TSaNCXOCtZeET3Fz7tSSarWtLA+gP3JC+BQhyjhSYWE=;
        b=W+/uuaBqbPPVyfQvM8GL9cVz6swWjnr7Lo6FxMM2/KKrR3onCoHiaJsawo1RiNHZWy
         QRyOizfwVoM6+cYc2WYtS3bgeQd0t8Tx0kmHB5GncyVI0YD68Ap4wmZQsBaPUpKhm6lJ
         KiSPeg1e/N2NoVE7c5zwe0JwlHbw2I8DWGZMvOUzveKQhoi5zCEwPtz59fa5GhewHbJN
         lVbM9r4W5W5Jaboik51bMNXiP/RkL40PLlav1hbvPXzSOBSNF5XFMZGxK5AntT5QI5eO
         hFP7I2Ay4rI2dBPxKItmAGB/IXOMdygX54U9myzQCg24CEv3LpS39PDJN6afGx0tSF2o
         oJrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781286262; x=1781891062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvH91KjfgwfGM1w/oZyTbnAZEq6BaV0f63FH1RCgTj8=;
        b=NowPgVAH4w2A3SgnWwW4R7vZPpHAtXypcZgi1M3AdA6F3UmvceUp63ZbdSxEWfTIws
         yNSj8V+E6Nkd+O+Hoy0FdPatvlb9hbSdEqn8aSQlJxua6AgcQm8HwDn3HUT1/K+NxRYd
         WpxJWKM3YW9eG/G6xwIJjSa3+YpP1XVoP0W+psAWGwDQpzYrxkpHLdU9iVaFb1h6wrVj
         xqNgDtzkC0Ey9sQTGBXTr9H4fqNoqvCe7acffpcvhBIfap6cXy1wOkO9UVNybgvDUaBG
         0qZxNIxXxjcpZ/wvS8iCxoqkc7GNytXyBimtLZaiYxzkIsWjatZ3G1s4o4AqFwDm9+4U
         zVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781286262; x=1781891062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jvH91KjfgwfGM1w/oZyTbnAZEq6BaV0f63FH1RCgTj8=;
        b=dkMYxlcqOnYI3nBz5ITTszNdeQS5Wk0ESd2gZAfjm/8vfKRfB/Qso2f5wJgdFgSZl2
         OSTIL6JzCvEtq/O0XjEaIvkbdiyESlfqf5wb5F9wfugnqd9kzqN3YDXMfhThQoc4p2dW
         zI2OwMNT6tFIZUzbXyEatTbEtjjMaUIwe2SDpjp6fRjSR34J1t4lhfa2R5jBBthD5L+5
         HihKqeA0/9Zf2BvZcPVscIlhhIKixF/D+B/6tyPPxuae9K4VFo+ZlTe3yFMxeHwRSwqt
         vPsWWyvOkk7ohkiv31QSCiTCaxvyHRwHZwR5tvYpCK6TWvW4I0XIde/UXoc9IRDo3bSd
         qjBg==
X-Forwarded-Encrypted: i=1; AFNElJ9h/iPiB0wzObzMo7RhXo6mu5wpzlbDugHfvAW25/FnUti12Ga7U+ZqXQG9SFW8acBwDUeXjWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1suKQiVKS3RqcaExxofz9YDy53mrVO1qbCdlvHV6PL9HaP6eX
	ZfBiR3pDY/7w+0lJ7OCG5maQq7yYZFAjpLolbyHzZ/EbnjDNLNDnty8zPh8RGEu496y2h0V5s+u
	265grxpaUoV+FWjpR9WEmMu0KwYvHcjvYd7vEg01B
X-Gm-Gg: Acq92OHPJcQCuLuvkuc2P3i9EklleSCdCtYNfO1ayzBmBHqriv+gc7rVBWQIhsamp3S
	tMs4kOeFfnb/kxHdJphRXestC4FveNl4TB1ansgIyicIA/OuJe5tDeJzKZonoVaqOna0F66XR+t
	TNwRj5j6X1DnHh/kUQhFAvYTRF7qPJCrRAgoDYxmCafOOK5jIK9AecRWuQpLB0JYLaSapSO1d2G
	xEBtw7pZZjCtMCsWFw/RUtuvTo+a4axm3ChsFRE0/MztMQaxHC684nao8uybwHAN8vy0fYoar4a
	XaZ28g==
X-Received: by 2002:ac8:5a0b:0:b0:50e:41f3:6467 with SMTP id
 d75a77b69052e-519549f51e7mr524351cf.12.1781286261753; Fri, 12 Jun 2026
 10:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230413.D68967BC@davehans-spike.ostc.intel.com> <aipphZ5iCnbXVNSR@google.com>
 <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com>
 <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org> <876077cc-db6a-4517-9d81-cdfbb43e599e@intel.com>
 <CAJuCfpFh60wULMkFc7hzxWNg+qmZ2R_HMw_QZe5CNcDRFuoN6A@mail.gmail.com> <e9e196ff-7428-43bd-8e06-dc2cf0628c9e@intel.com>
In-Reply-To: <e9e196ff-7428-43bd-8e06-dc2cf0628c9e@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Jun 2026 10:44:09 -0700
X-Gm-Features: AVVi8CeRCVUJzted88F_l8zeTuoKptNmS5kyY3W3pYtyspwmpDSJybClcBV4DHM
Message-ID: <CAJuCfpFo_avdhpOviX7EsPqLgDJ3DfeGpth+yu1-ahfawqaSzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 9:55=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 6/12/26 09:41, Suren Baghdasaryan wrote:
> >> I think the key to distinguishing between:
> >>
> >>         vma=3D=3DNULL because there's no VMA
> >> and
> >>         vma=3D=3DNULL because of a trylock failure
> >>
> >> is binder_alloc_is_mapped(). It won't return false until vm_ops->close=
()
> >> finishes. vm_ops->close() shouldn't be able to happen while
> >> lock_vma_under_rcu() is held. So if you've got a non-NULL VMA, you've
> >> also got a stable is binder_alloc_is_mapped().
> > By "stable binder_alloc_is_mapped()" do you mean it would always be
> > true?
>
> By stable, I meant that it can't change.
>
>         vma =3D lock_vma_under_rcu()
>         mapped =3D binder_alloc_is_mapped();
>         <window>
>         vma_end_read(vma);
>
> During <window> it can't go from true=3D>false or false=3D>true.
>
> false=3D>true never happens from what I can tell. It's just plain
> impossible given the current code.
>
> true=3D>false is locked out because when lock_vma_under_rcu() is held.
>
> > Asking because in your patch you removed this condition:
> >
> > -         if (vma && !binder_alloc_is_mapped(alloc))
> > -                  goto err_invalid_vma;
> >
> > So, previously if we found the VMA but binder_alloc_is_mapped()=3D=3Dfa=
lse
> > we would bail out and now we don't. Are you reasoning that this
> > combination is impossible?
>
> It's not impossible, but I do think it is irrelevant. Or at least that
> the *VMA* is irrelevant in this case. binder_alloc_is_mapped()=3D=3Dfalse
> means that the binder VMA is gone. It's not in the maple tree, and it's
> not coming back. If a VMA is found, it's an impostor.

Right, but before your change we were bailing out early. With your
change we would be generating the traces and freeing the page. I think
that's a functional change. Was that your intention?

>
> That's why I did:
>
> -        if (vma) {
> +        if (mapped) {
>
> The question isn't whether a VMA was found. The question is whether the
> binder VMA is still mapped at page_addr. *That* is best inferred from
> binder_alloc_is_mapped(), not the VMA lookup.
>
> At least that's what I decided after staring at it for far too long.
