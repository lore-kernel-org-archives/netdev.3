Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24638E8C9
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779141; cv=pass; b=tU1DaRM2BAaD2YNo2FGkbKfxrRNXuKJxvmJT2tPWpmqQpF4e3+8gfQNBcgxv4DrZ2NmdQTq5hhiDh6E5cJgDeDm8d20UXJaR5ii5Hc77Syi+uQ6xCEmkyATo473CYRWNwDeJ0iPUc5fP5fN/I5nvbTGQZpfl0jPQMiNQAgK/8F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779141; c=relaxed/simple;
	bh=BRpMmWn7ih469Fj36TmA1mRpR7obmZjKnWSavtgAWok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McmFtpRE4OBeoK1Y5EqwBITwUzQTzz4KsSswP+HH4qFFHkge16VJ4c1ZFTMVwGLMnjJamEWTB8sc1VEfgpcRNwmWO4QHZL2J5reNVrsZ8S5EHXaGwRH/YvLdk8vGLsjwyE0ApNMW0C1l6zZ+X21GfwzgeOqEEWd71ZpR+E9+qMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhsVKkW+; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhsVKkW+"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01c79467so21181cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785779138; cv=none;
        d=google.com; s=arc-20260327;
        b=G60vuviEWBHepDVDimrDIFhvUo289n0bMOpCNuUYbLNnnSX/wbNnSPQtZsin6iWHOV
         OseiTm0Fe0vnPfyVQHIb31OzoaMVBfiAsdUDm2P4XN3u1pb8v+U+Qk7ua5lq2F8s1rku
         VZBCSaOPv1aD0rVG7+FCw61oPLNmDpQoPVbQf74BiwSIydbqxRb4S/dAVfnDkiJANPN9
         SJVc/5VUcB6jquRkflE3uKhH46u/cRU32PPgkEo0MFCfhEtEXvJuZyhWx4c/fChgjU/l
         twxL8jFbJnLWR3nADIoBDn0ua9Lk1j5mIScN5cQ8mJsspAFMCoPTIVgnaJCHXzHE3Ik4
         jUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BRpMmWn7ih469Fj36TmA1mRpR7obmZjKnWSavtgAWok=;
        fh=1W8yZBDBu8t9x9IIgFil1wewV503Tsx5egyyeUvSdIs=;
        b=Jrh55youENFAsSB8+6iME7GFRnYdIDvqC4vyXQDNLN7L6Da1fTTSaUbrNpR+ibHhCw
         Lblj4gqRFXCLsWnKjFluOwoGiToNqslT+vktZSeTWOdzoRnJX4W/xDljS/4XEOkrUhem
         ZMGx79XW+qtLB45rVRg0mAfxgfiQYPyU5AhZGsItniNkRnkqS5dgjWrijY5sLwdqjb35
         CdB1EvfxZiCfZBu91H4H+j61lo5WB4EFKu2vbULRXlX4yFnK1SgJUaAeq3hOvP7XBysa
         rGu70xha2eveWyKn2LiehwhPGMxKCmfdpUa80CIP2HhPmnzS37rlOozy70VMJHdascDU
         kTWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785779138; x=1786383938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BRpMmWn7ih469Fj36TmA1mRpR7obmZjKnWSavtgAWok=;
        b=JhsVKkW+s3WHDlACh9TsQfyH9ybyUjGhrndd+Z+16E5X2Nx/+KNV+i9T6JgTI31Ix2
         FEmtqtU/niFkJU/hoLfZhj0M0gZ8Xx54KDqZZ06Ca/Tembinu7NI7Nsoay6n5y7cjm+3
         tTv2U4Qk0fSCZST7AL0YnrE/joZjP/Sj5D7WMhsdfn7wDsPL3BOFDUDdih37PVwLhtS6
         d0HUyqhgUZtT1+YLKZXi+yeaXFSy3qwso2uQCQ1hMqeHOq2a8g/E61xt37yV20D1P3nx
         RjGY+wx+lbsDjuv/UjpdZ1PXmPlhSI8n1naT0oKPzVWzWUbcbzLQCxBrtxlIRf9Ya/ck
         9hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785779138; x=1786383938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRpMmWn7ih469Fj36TmA1mRpR7obmZjKnWSavtgAWok=;
        b=Ga0QlrUuYvnUup1nMgxqKY9dXV64Ns89IX1hZwNwJUjmI6Q2PucYP2y5AEBAP3k6DF
         Zpb6DW+VR07Uu8Cc8+sWyTSer5dn1AGI1Z+yZlIro2b92WSO2oPIUSa2GTQzb1VrE5lX
         shp0Q11UQL/c12rNL9AsOUhbqaLDd6pXswdb6r9uXHPl9zU79HyD1QGURrq/PrDoKC2Y
         2MdaSY71rxzHS3S8ggZt7f7wjHTTTdsEGW/KtxI1zyf+IKvIXmJ9LOB/lw86cbszQiF1
         GmcfRGftDyzF4W/FOaJtLZDi1Wn5QYryJhUY/Nz+ZhNtw6ooMBpCQF/L1noITj1AC73P
         NLxA==
X-Forwarded-Encrypted: i=1; AHgh+RpCI9C2TvgfVylxnKgro6W6RTLkZyIc2DzYDOsavgyjvbpjfGqhCiFsJs+SqfZhpvs/nX3vnog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyaPiUO/A8WnHr91Ff5AuGuJDtouYSf2D35uVYkuIe/wj++PQE
	LegbGa9BennqJ9/jv1Kjx43/Gbd8qPHS87aqNs0bb1OB+cCDFtFECEobWPikHJ2w/4Q15UKZ3KR
	n/6jrraKLRHTbOnWs6X+jBtCjKsshS/q3RgLPHMRS
X-Gm-Gg: AR+sD12AL9abu42f6e8P5YEHxnyeotfPqhFWmwXsbcDByE7Fk/c8R2P3+gtQk15i93N
	CH753vjXjZZAbL+RZOTNfr+MopuHy4jIS/56/bW5dw7IGHGUla/92zXpbWFcjg9WMjs7o0dgiz7
	7H9cc5HKzAVCj55MESBS7vn0KdZG4t6TYB2Y5NN0nfiiI0yEn11UswPrbvHYROB4CkCT3eQTdVf
	DAtMsHfG548Gj6VVG5Het0eHyphkKo6oJJtHE2eotweeROJmV7SnKPMurXfbV9Pf/S0Y4t29b4O
	jIrgQkwuoXx1+MsR5zOqi/JAexAtjNPUEyGhIv0DqhX/iULM2rJ7QQ==
X-Received: by 2002:a05:622a:2291:b0:51c:ca9:3d15 with SMTP id
 d75a77b69052e-52cd4fcddfamr586201cf.12.1785779137391; Mon, 03 Aug 2026
 10:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-2-surenb@google.com>
 <CAJuCfpGezxdaSme_QpHVq-QVeZAUaF360_Ajvkrn3QqDcSQVog@mail.gmail.com>
 <anC1iE21eonDK06n@lucifer> <CAJuCfpHNMHKgmP=JLPKY65e6gO6MRpGE5MjUtjd_-2+LHr2Gpg@mail.gmail.com>
In-Reply-To: <CAJuCfpHNMHKgmP=JLPKY65e6gO6MRpGE5MjUtjd_-2+LHr2Gpg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 10:45:26 -0700
X-Gm-Features: AUfX_mxBR2LOxXxJQ1PIuO4cTsQwU7lloBbSc867VOvDBN4dk3ilj-U4-2El9T4
Message-ID: <CAJuCfpE0xtaXd7r3kHPhscox+5siXh5+c0Ssjbz+qLJUFWA4MA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: Make per-VMA locks available universally
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:41=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Aug 3, 2026 at 9:08=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > On Mon, Aug 03, 2026 at 08:24:44AM -0700, Suren Baghdasaryan wrote:
> > > On Sun, Aug 2, 2026 at 2:55=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > >
> > > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > > >
> > > > The per-VMA locks have been around for several years. They've had s=
ome
> > > > bugs worked out of them and have seen quite wide use. However, they
> > > > are still only available when architectures explicitly enable them.
> > > > Remove the conditional compilation around the per-VMA locks, making
> > > > them available on all architectures and configs.
> > > >
> > > > The approach up to now seemed to be to add ARCH_SUPPORTS_PER_VMA_LO=
CK
> > > > when the architecture started using per-VMA locks in the fault
> > > > handler. But, contrary to the naming, the Kconfig option does not
> > > > really indicate whether the architecture supports per-VMA locks or
> > > > not. It is more of a marker for whether the architecture is likely =
to
> > > > benefit from per-VMA locks.
> > > >
> > > > To me, the most important thing side-effect of universal availabili=
ty
> > > > is letting per-VMA locks be used in SMP=3Dn configs. This lets us u=
se
> > > > per-VMA locking in all x86 code without fallbacks.
> > > >
> > > > Overall, this just generally makes the kernel simpler. Just look at
> > > > the diffstat. It also opens the door to users that want to use the
> > > > per-VMA locks in common code. Doing *that* brings additional
> > > > simplifications.
> > > >
> > > > The downside of this is adding some fields to vm_area_struct and
> > > > mm_struct. There are likely ways to optimize this, especially for
> > > > things like SMP=3Dn configs. For now, do the simplest thing: use th=
e
> > > > same implementation everywhere.
> > > >
> > > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > > > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > > > Cc: Vlastimil Babka <vbabka@kernel.org>
> > > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Cc: linux-mm@kvack.org
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > > > Cc: Todd Kjos <tkjos@android.com>
> > > > Cc: Christian Brauner <christian@brauner.io>
> > > > Cc: Carlos Llamas <cmllamas@google.com>
> > > > Cc: Alice Ryhl <aliceryhl@google.com>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: David Ahern <dsahern@kernel.org>
> > > > Cc: netdev@vger.kernel.org
> > > > ---
> >
> > <snip>
> >
> > > > -#endif /* CONFIG_PER_VMA_LOCK */
> > >
> > > Now that I'm looking closer into this, I think we would break NOMMU
> > > case because nommu.c does not take VMA write locks at all. So,
> > > lock_vma_under_rcu() for example would always succeed.
> >
> > I don't think anything's broken actually.
> >
> > Per-VMA locks was gated on CONFIG_MMU so nothing there assumes per-VMA =
flags,
> > but now you have stuff that happens that didn't before but:
> >
> > * vm_area_free() -> vma_assert_detached() - fine - it's always detached=
 in nommu.
> > * vm_area_dup() -> vma_lock_init() - no asserts, just sets refcount to =
0 (correct).
> >
> > AFAICT nothing else.
> >
> > So seems fine to me?
>
> One place that needs fixing is in BPF iterators. They use
> lock_vma_under_rcu() which would always succeeds even if the VMA is
> being modified. Instead of removing !IS_ENABLED(CONFIG_PER_VMA_LOCK)
> check in bpf_iter_task_vma_new() I'll need to change it to
> !IS_ENABLED(CONFIG_MMU).
> I'll look into other parts and try to verify they do not affect NOMMU
> but ultimately I would like to run some tests with this config, which
> is not trivial...
>
> >
> > >
> > > Extra per_VMA lock-related fields in the vm_area_struct and mm_struct
> > > would also inflate NOMMU structure sizes without them being used. I'm
> > > not sure if this is an issue we should consider.
> >
> > As nommu co-maintainer, no it's not :) I won't have that stuff blocking
> > important changes for real arches.
> >
> > Go ahead! :)

Thanks for confirmation!

> >
> > --
> > Cheers, Lorenzo
