Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786F3F3262
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855674; cv=pass; b=Spd4oT+bmkXrF0RT0/lJlju5av6OaobhF8xrBgHy/TXs5AsOonGw+actx8/pK5wioSG+AWGDHqorWhPBCwNLfmtFFAqmDz/COMIMfwVXbB9fTkKLi+JW8guRY0JCTduIoZHKoKYq5axxD5wnsN6Zv10AIHWa+njJ7DzkTFOj684=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855674; c=relaxed/simple;
	bh=+iGv54DsY+sOjSWQ99isvTZlab/L0ZXXtYmfFcx99S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDQP1aofYpdvcD7JHtPvKeGErdPUhU43hSI1joCfCD+gH2KS9TX00KG3Hw3GWxMXyaig1ndkQU2ujA5Yu5drFlPbERHv8OArWHcKeTnLIClxY5e72cRtfMdHVD2Gdxg6K2jMzZMR2rYdI84Mp2isG+HkwM5PhHK7+nnTeahIVxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8eyUITy; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8eyUITy"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c01c79467so355601cf.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785855670; cv=none;
        d=google.com; s=arc-20260327;
        b=jBGa5eyqbyoCqD3hySA0vCR6tbbE+qVr3BiRN6mCGAKXbKZ86EgoTA/Ei1Nq1bgtaA
         mL9o3XLwMDBAPW46fZY++BA5158O+FFcFKTAYceIyrrf9KWlD9fXVlD782rNwZdT5jHK
         O9RMTEIFVSfneQyJCNe09ChNsRQX30V1ciJTvwB71gC2qBMVDWTACNqX6gkkvnyE2GA3
         X4RaMkkuEzRRA1qv4tzkBskf3bqsTqdNhgcPLI1vajT/9kocORbvYlWv/Z0GFE86+eYq
         ZSIyculjzwCcNECJHjgxDCgFPqsnKBdu4eM8MVTCXmerP+kh868ji+fcKMEuc7Gs6c8E
         p1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=okK/WmcHe/IlDVg3t8yFB+GYShke2LQvsImQ/EEfJDU=;
        fh=3qr/iHtjciJBEX0PcigFsEI0Ye3e6TuiD0JUkp6g0Qk=;
        b=hplQvKANpZAeiAUdo3S/HVok1dJWBdlWMGbkeGdhakvRQGuOPpbeP+AZlHKIyDQSv7
         roFHQLt/lm5hxygll5nLxRoM6nZFynPbI27uQjn6eht9Ea+dRNO11FI41K/SI0vQ8Jod
         d37GXILGtfPXL614UNUv/2n8v7Y7Sg3Q7dneZh1594kJnZFG/tTM50BupiQy3K8FcsSm
         1s08/IBaDzHI3igYdihcgVLwNEEEzgAteIu0FeYXpNLep5/zDBIkp+lZWyYydCh8xONV
         tz0b47i6LihzS2FIyq3KriUHRkNgFe0cOSjEGoZumob4CIUBCIXxnBJ2F2CWEKlTrNnq
         mPtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785855670; x=1786460470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=okK/WmcHe/IlDVg3t8yFB+GYShke2LQvsImQ/EEfJDU=;
        b=a8eyUITyjAlWCAXZesMpw2zPgq3+SJShfSdu1OBq8RLSlPVY6I9T8U/UDcNVGOf9fs
         1j7Bhw6fKo38E85tRgN/ufOZprtUBQELG121GVf73wFGqjb0eO/1auyk64tlGDuzzaUA
         9N+j7Jn4ib2Qs2WWAK6xaR5pVCqKOT+GKohQ5SABHfNjpiAiouVfY5R4M9UbszBHg9u8
         1BG3KKZlJfhRR2qWgndqDUTQNf7yMwbYHfJvelES7PxfVGOXsv9kEwlrKoZJCWpVhwx3
         XVDEYemVa+33Z81xGW/L92gHuwW1JEuezXukYHBZ/kP0TE6y1kwMA8040Q1jFkZx2+VY
         8S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855670; x=1786460470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okK/WmcHe/IlDVg3t8yFB+GYShke2LQvsImQ/EEfJDU=;
        b=cDPS9zgcaFDiVQ4k0oNilRc4wOBwizMMKm/wlV/SMkaepFeYwqKESxXgxqEnd5nxTI
         STbuMMfnGI2DrtYoq65nasi/l0KlwURjSeCifn5uxpAKFliYkwYArBBQSt5KVWj98UTJ
         tFbBL/Zrl9Ybi9Zopuf0DQRPh14X7o0B2JMxTDPFnpHc54Kg0lcQbfB12TwEtzPfe1nW
         Vq87YoZOjD5xdtFAITNAyrk6RF1WLZ2AdlebzexWjpdBbZo8kNo6RlXZMojvxGQ+2lYI
         OpFKVURxHS13x1NLGUQ0NJidEiO1AFX9Eda+wMH+Fy5HVGOqa+3p77jOqo4K/pxNCJs9
         Nc2g==
X-Forwarded-Encrypted: i=1; AHgh+Roz7zzo1mYT1yrlpsyu1DPMIYup5nsq74Hw2ILTMi+c4TI6xH1sLMLU9vogDbMDn0giZqhQdOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfRupV0rLGIw09iVIQSzoPka2NHfISvrCcH7egnQ/OjYjoDDg
	eCky5gDTBaTlmrFR9Tfq4ChCQ3iybUNW+5uMrXwDKBi7kP7Iv5wO2V09Ds1pWgWNUg08lUxMdN7
	S83NxMMJnry/J7LPkRfsBRFiVHjYplHgf3ln2tkkr
X-Gm-Gg: AR+sD12m5JdkpkFRVknaCImzBLxPV5g6vJGPKNrJZk+AvkO2D6tgKXhgH7VyqtqFo/j
	hntpP0HZiNcBd37dq3Bh0gzBuRcYbtD04n+XX9A4LqFVCdatZYlkemNAPXv0Zt7oUqBAkEmLpAT
	trPfkBXUOvLcMX/oeAkDaRdpZ1pVPKfUrMtfcRd5Oq/5ETyRqIM1UJh1ZzRWyVhytGFF3m12Oin
	inRpw23hmpHJ/lXyIYp09VaHubih0V8gWbjBEgR+mIJzDcUFhdBSSV7VcYoN36th3XJMZR96e80
	AwglOoMmY/RX5HlrmxTbrouVdgIdTsNDsCB7dqqlCnkHnXdt5Q6bb7Iblu/AshmBW0AnYVmEyVU
	=
X-Received: by 2002:a05:622a:a95a:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-52ce4064fb9mr2261011cf.13.1785855668889; Tue, 04 Aug 2026
 08:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-4-surenb@google.com>
 <anB4uxEbKsa1Re0w@lucifer> <CAJuCfpGXk8jfRrJ=JwMLvpzxbNnzJUOYRHfWUX5e4vgP5j72Og@mail.gmail.com>
 <anGmhgqk-HjhejJL@lucifer>
In-Reply-To: <anGmhgqk-HjhejJL@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 4 Aug 2026 08:00:56 -0700
X-Gm-Features: AUfX_mwoQHKou16DXo1Jd8x9iBvGN2J9-cFV_FJyi4l9zQdBjRr8a96kthPtQMw
Message-ID: <CAJuCfpH1WzCBgRbp3R5FAxked534ewTaMA_TxPjw1wCkDFZuow@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
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

On Tue, Aug 4, 2026 at 1:47=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Mon, Aug 03, 2026 at 12:01:21PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Aug 3, 2026 at 4:28=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kerne=
l.org> wrote:
> > > >
> > >
> > > Would be nice to have a:
> > >
> > > Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > Ack.
>
> Thanks!
>
> >
> > >
> > > Here given https://lore.kernel.org/linux-mm/af4Zx0gJIWbdDeY2@lucifer/=
 :)
> > >
>
> > > > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > > > index e20d01e8d38f..6ff05e68e61b 100644
> > > > --- a/mm/mmap_lock.c
> > > > +++ b/mm/mmap_lock.c
> > > > @@ -338,6 +338,35 @@ struct vm_area_struct *lock_vma_under_rcu(stru=
ct mm_struct *mm,
> > > >       return NULL;
> > > >  }
> > > >
> > > > +/*
> > >
> > > Why not a kdoc comment?
> >
> > Indeed. Will change.
>
> Thanks!
>
> >
> > >
> > > > + * Find the VMA covering 'address' and lock it for reading. Waits =
for writers to
> > > > + * finish if the VMA is being modified. Returns NULL if there is n=
o VMA covering
> > > > + * 'address'.
> > > > + *
> > > > + * Use only in code paths where no mmap_lock and no VMA lock is he=
ld.
> > >
> > > Well, a VMA read lock can be held which would make this a noop essent=
ially.
> > >
> > > If a VMA write lock is held you're also ok as the mmap read lock will=
 preclude
> > > an mmap write lock, meaning vma_end_write_all() will have been called=
 and the
> > > write lock released.
> > >
> > > So I think you can just drop this line?
> >
> > Maybe instead of this I should say: Use when mmap_lock is not held,
> > otherwise use vma_start_read_locked() ? I think that was the original
> > reason for this comment.
>
> Yeah that works thanks!
>
> >
> > >
> > > > + *
> > > > + * The fast path does not take mmap_lock.
> > > > + */
> > > > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *m=
m,
> > > > +                                            unsigned long address)
> > > > +{
> > > > +     struct vm_area_struct *vma;
> > > > +
> > > > +     /* Fast path: return stable VMA covering 'address': */
> > > > +     vma =3D lock_vma_under_rcu(mm, address);
> > > > +     if (vma)
> > > > +             return vma;
> > > > +
> > > > +     /* Slow path: preclude VMA writers by temporarily getting mma=
p read lock. */
> > > > +     mmap_read_lock(mm);
> > > > +     vma =3D vma_lookup(mm, address);
> > > > +     if (vma && !vma_start_read_locked(vma))
> > >
> > > This maybe warrants an unlikely() given it can only happen if refcoun=
t
> > > overflows? Also worth having a comment to that effect here?
> >
> > vma_start_read_locked()
> >   vma_start_read_locked()
> >     vma_start_read_locked_nested()
> >       unlikely(!__refcount_inc_not_zero_limited_acquire())
> >
> > already contains "unlikely" clause. Do we need to add it in all its use=
rs?
> > I can modify the comment for vma_start_read_locked() stating that
> > refcount overflow is very unlikely. Would that work or do you want
> > callers to have that too?
>
> Ah ok not an issue then. But good to add a comment at least?

Will do. Thanks!

>
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index edd90892f8cc..c3a0c38a3dc3 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -129,8 +129,10 @@ struct vm_area_struct *find_vma_and_prepare_an=
on(struct mm_struct *mm,
> > > >   *
> > > >   * Should be called without holding mmap_lock.
> > > >   *
> > > > - * Return: A locked vma containing @address, -ENOENT if no vma is =
found, or
> > > > - * -ENOMEM if anon_vma couldn't be allocated.
> > > > + * Return: A locked vma containing @address, -ENOENT if no vma is =
found,
> > > > + * -ENOMEM if anon_vma couldn't be allocated, or -EAGAIN if vma re=
fcount
> > > > + * overflow happened due to high number of readers and the caller =
should
> > > > + * retry later.
> > >
> > > I'm guessing you're fixing this up as part of the patch? But it feels=
 a bit
> > > random, I mean fine but you should mention this change in the commit =
message +
> > > explain why.
> >
> > I'm fixing that because Vlastimil asked about these inconsistencies in
> > his previous review :)
> > I can package these fixes as a separate patch or add a comment in the
> > changelog, smth like "While at it, fix the comments for related
> > functions". Would that work?
>
> Comment in change log is fine thanks!
>
> --
> Cheers, Lorenzo
