Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4149F11E
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051853; cv=pass; b=FzCvYZqf+370WiXOfZsrHsUs1BDczMIhNeUisEparf0RMsJWrpkGdRLZED/4OFLauu7aYVzBTUmGxKOQYwj0LyRsf6cbwMPX8K4/3NUDr1EF26xV52GapfyHfZ7FRRoMLNUNE1WTma6/Qd2RRcb+F2HR0VdYhMYjyc7hoNEPYP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051853; c=relaxed/simple;
	bh=7fo5EGqeU1K9oWeUdrFJ6Uc8xV6Lo6ckrOaUTXHreas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCF9ZSEdCr0urtS6zk9i/uqCT3dZMt3YVTNbC9uWdZUGlqTa6IskKK/9R5tidls9qvS3Bbm26Hj1ApFjj93A/lzWDJy1fMmahUBXgGCNNPorgDflPlfvmYdnI4YB5OVxAQzuguYYF+vVSXdvwITRNqHu8ruLEDux2f4MYN7+Q7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ey0VwwYy; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ey0VwwYy"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so282901cf.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789051850; cv=none;
        d=google.com; s=arc-20260327;
        b=RKTkR9B5ubk77yc0BPj05pCEfKfJV0LhSashU8qNC3VNhfFE1OTGZpzTi720ZABMsB
         lRmEXUfXKXIRdBMJwN1KGmH1RA/Stlk1nHpX7OhlxWWWTUB3Gz347ctYGUDp5Yv7Cbqh
         qh7r8P5oBz5owQHyydYGuoVy5fcr6oZBW5UG4Va8u6cZSGfBLCPuZwu32Sr/J//BJ+xb
         CxV4TKOEUXhnK+ZjvCm6ZIYpIIzD729J+mQ2Z9k1lzdWp1PnHs9jQmkDI7HTFn8LinSz
         QQJ+nSh6oSyvtc5ggqDbuzc1bWH+LWo6ffvh9EoYEHeUtkkoq3SLRcDYcOcqcO0/s/J3
         jndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7fo5EGqeU1K9oWeUdrFJ6Uc8xV6Lo6ckrOaUTXHreas=;
        fh=VTH+dQBl392vkaf5d3CO/uHWyY0ATeHXpwgyUchnPQA=;
        b=UesHBMgYVlY4uPmUwBI2OQgYFTTcvJUfbCvxLqbHflo+hTN3fZ5UhwKSTG3c9Jx+Dl
         z15e6MOsFw4Py3Xw2/kjs+jr6Y7Zfw3vAy/4KA3EmMt/B1jXwxbK3ck+qCM90wf8XIQx
         bYGScu4WhDOkM5QpVsTJCiRwV44lmMShw4i4hRibjga81+GvPCzlV6P9FXm2mIYfaEMJ
         vY7YsxwiSuNtO/LmuhpfVeh2/EbC4jOh0FdlOQ99cr5zANlUSjiYI20xWQ0ACVcRoTgi
         D77bnngY8WZIisoCEqYPwl+Cnptvop5ETR/L92JWil7XoWD1P6jpP2VshA2GN9K8QtmH
         EiJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789051850; x=1789656650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7fo5EGqeU1K9oWeUdrFJ6Uc8xV6Lo6ckrOaUTXHreas=;
        b=ey0VwwYymM2EynrUmO0sHPdxZMaO+YPTseATb8MQWKnGge9sEB0SbdSofIxUiosEud
         8h78Ef6KqVgGYFpMNnMLGOhuyHKfApmV8xjrHYcqvcTwlUod8hBEdZETOXTd4GOaONoY
         a6pih5WsOWCFoTkvebSkuTQfexggiPaHWWP5vZN+r0RzB8hUu2BDSB5U+co+3fbxCu4S
         mxOvxdRZVXD7YJZ7ml5dA0j0Oq+eOrgNuomFY1Pd1uCchF1aSsWJEwhTO5MLWI4w45zT
         jyHStFhxcLpjajnQIdaYf33C5oJ5HfVgM96hZKc/SUAeVO2JR79sYj3IqIx8QNuVMs6f
         cMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051850; x=1789656650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fo5EGqeU1K9oWeUdrFJ6Uc8xV6Lo6ckrOaUTXHreas=;
        b=Wh+lGj0DaGxIfVr1nqndIL8PZ/PL+v1iLFzM5kb3STskVRbRprX8tmvbTyc9hUpN+C
         bw+zvUZXieTZg/YKDqeXUdEIq0Ru/DyTNQk9OO4sYmNEtQBhUmLfETI0+k1X3trnXMpq
         azW+D3no9rpUq82BvAeswjMeD10kiRjpFHwmuhm9Hw6kU626ReIJrv+LCFdQWIiUtQP2
         U066v30OHsS+n6C4HwW0eAFcK8qnDrFh1++8c3euzTua28HLpNX5eO03Ho08LrC2xWzf
         YJh1ZiDqw2FgyP30jOREJixZ4PefAEQL15h/PcPkOvg3o7ifaSRc30IFAbXsHPf3Zy35
         ji/g==
X-Forwarded-Encrypted: i=1; AKwUvBwFatgn41KtfcnPPjutwbQaKOmTjtqI2bY3OF/JZs2ej7hUHqR2KD3KsbeKZGsl6fOLLpzlswQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kaJmLZsOtUe/vx6hlaMfz7qL+cZqYV2bOSWuPpB7TbLjUN5jnt
	FY5AmyXry9nPuggco8r9WP7CEjOmg3ZD3CJOGdDoPvAZjV4Euw4h4WbRffjC/5WJn4Y4JNLfXTw
	DIWa6Q5xltCuNYWJXi4yCQwuYVqRvaqWFEHzoYTcD
X-Gm-Gg: AYBFou2YNNEAeO4nh0esB9SkfdwdmTdT1b22+S4w/ZiZizct/DgEgjySHQFJ7WvvHkX
	nR6eqFCUvRuTAW840QFue/TBnMZfzoGcWOQh5+Lzr+fG8qiA97LfcDQNuix5bJbVYpHyi5I1P6s
	QTZOLa+grmoB4sClFl/HcauQRdRXWzKU01D0wd1CyZdA8uAeiBh1lpEga7d/DdUO9Qfo2WWAbnE
	P4YCSk9iqcS+hSEclX7be7fwR2DJnDLT+BkKuKjGWsbeF/mjdF1IvXlVNQ+x1GiIjnQTD7nY6PU
	NPIa/fNDDpTykPVh77YowrqWSBjQAu9PThCObr5cVoqQVJsPVmZZgGAuLWKwVdyU0TR8ySvxVpL
	SUauFtQUZqzoRNFQXPlVb
X-Received: by 2002:ac8:7c4a:0:b0:52d:9d62:6163 with SMTP id
 d75a77b69052e-530b62adafbmr17198241cf.9.1789051849244; Thu, 10 Sep 2026
 07:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831203056.838265-1-surenb@google.com> <20260831203056.838265-2-surenb@google.com>
 <a4d74575-65d5-46cf-bd2d-dcabf2543811@kernel.org>
In-Reply-To: <a4d74575-65d5-46cf-bd2d-dcabf2543811@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 10 Sep 2026 07:50:38 -0700
X-Gm-Features: AcwNN1X_jRm0tBBbAYUSIvnyhEAYCX6eOrOg0SRx_RaTXlhhkG6R2zUlwcvhFQ4
Message-ID: <CAJuCfpEFmf0V0OuAkEPSpzYA-WScAjmNg2b6CJg7Z3WH9h6Qdg@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] mm: Make per-VMA locks available universally
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:09=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 8/31/26 22:30, Suren Baghdasaryan wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > The per-VMA locks have been around for several years. They've had some
> > bugs worked out of them and have seen quite wide use. However, they
> > are still only available when architectures explicitly enable them.
> > Remove the conditional compilation around the per-VMA locks, making
> > them available on all architectures and configs.
> >
> > The approach up to now seemed to be to add ARCH_SUPPORTS_PER_VMA_LOCK
> > when the architecture started using per-VMA locks in the fault
> > handler. But, contrary to the naming, the Kconfig option does not
> > really indicate whether the architecture supports per-VMA locks or
> > not. It is more of a marker for whether the architecture is likely to
> > benefit from per-VMA locks.
> >
> > To me, the most important thing side-effect of universal availability
> > is letting per-VMA locks be used in SMP=3Dn configs. This lets us use
> > per-VMA locking in all x86 code without fallbacks.
> >
> > Overall, this just generally makes the kernel simpler. Just look at
> > the diffstat. It also opens the door to users that want to use the
> > per-VMA locks in common code. Doing *that* brings additional
> > simplifications.
> >
> > The downside of this is adding some fields to vm_area_struct and
> > mm_struct. There are likely ways to optimize this, especially for
> > things like SMP=3Dn configs. For now, do the simplest thing: use the
> > same implementation everywhere.
> >
> > =3D=3D Considerations for NOMMU config =3D=3D
>
> Echoing what I commented on v6 after v7 was already sent (not realizing t=
here
> was a v7 after my inbox got flooded)
>
> Maybe the NOMMU "support" could have been had in a separate prep patch (w=
here a
> lot of the description below could have been moved), making the patch its=
elf
> just mostly a removal of code.

Yeah, that would make reviewing indeed easier. I guess current
structure is the result of me adding NOMMU pieces to the pre-existing
patchset. I don't think it's worth refactoring but I can do that if
you insist.

>
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David
