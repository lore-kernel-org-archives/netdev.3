Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12F14B950
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786237676; cv=pass; b=CWGTu39crsjlENbkDVO0mNpMl9JkeBxab8ianjh6j73Wmgrx4xwY7Pdc7ML/958NgTuwbdQIIt4BWR8/XnFsORqIJLlPCFvBRAu5tKsStqt9G9Cn6gCfaDyislhKHdoWJwma1mRHuDo4zDBpwZEsyttdtbmt1SuJ0PRx5782TEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786237676; c=relaxed/simple;
	bh=Wz29YuHsrfSLhB92Shi2IvHBgMvsUiOJffJiewBxTBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMMIG+WtKzkb/kmlGTlNDPmdoJvdCAXY+Ots4AEmbLeTI5Z7LZZYybSWpd8eBSOgpJHP6Qbr4ycjDF/VqMyA43ZUwjGeMacEWp2RiEWWR8GznlrhjRJo8gXV9atG+gGAtIZCDEQuAXS73eiphUVWzSWZ16GLHssy2ojQ+DCgias=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tERDqAXb; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tERDqAXb"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c01c79467so136611cf.0
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 18:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786237673; cv=none;
        d=google.com; s=arc-20260327;
        b=LPWIen3HS2hMU5iWL4KgotY9g3GmVdFvZVW0NWhI0/NKkSzs1P1WZw+MR7tk5evfu5
         oRCupe5j/IQzEKibOGkakAVPLmw8Iwxv9Yc7PJUjV7VnAZdLzOdkR2FtpCAyIPG/ymzM
         hQ5gQOlo6Z/bw5loSvYHMynsqrmQKK4cxyFPb6VuSOsdH28ISvj1zURfT92xs+F2H8Jz
         fmFI8WvvWS4yOxfsnVQRtFdTZ61TUKmnCrNfxTPUnehb8oMKABb5PKVy9P6njqRW8+Jq
         c8F71VjLDPVMtEvVTHi/7uxGBP+Fl60zrNeJsJGgh/TsVxO4UsbLh37vfvTfiU6nDyaD
         nFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1RIcoRAbFf3341jf2ecw8S5B64UJUijX3gld+wbMh7E=;
        fh=Zda/nrDe7BTgV6Wu+HNq3RRDlB2YATid7crCV46X1Hc=;
        b=QkN2Jbk9kEz63nlDmXdtrjPJQyYouiO+ek2trZYD3gwq/3WjwML6Y7OxTLe+B+38mb
         xzLG2XU51Lmmr1oBAIGHcBFQ2hE1aA9CXKu6ADk9s9SPvQFK9GOPo+kbEDZr95XsYYoF
         aH/7A6MfvnBXeWYiG1fC1CYAQ6oSRPMFub6t9+PgdKv47j/mabFT1scJCmwuGb+2yfAZ
         sHUlUY3/V4FtxIRKAHX8tJmbOyzuJQPG5VuUI4EKtLyDZRkkeIGDxy4JoI01nMsuWTZL
         TQVP8U1F0/AcW4AC7bZi5sbafTJ7wDly36dncSPdJtgpvj1xVELPKEtf/yObVPgumNEP
         e50Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786237673; x=1786842473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RIcoRAbFf3341jf2ecw8S5B64UJUijX3gld+wbMh7E=;
        b=tERDqAXbnlaLTKeJIEzbn5nIKyY+LJg8PG9L551XHInCYfgqcCEqC95s8RFmebYD6o
         oRfHZ7aLoCJz0v1ZkG8Awy8+080h5N7cFGKrXrnokUaKSZ79emu755l9kcovwC8G2kR+
         INZ0DrDyy+t274cxTyTUjo9CK+fWi25GE4hqLmCv1oiLGmRIu2VW5oQgVkKEsw6zBAdV
         FX1Vmx12f3mbYz0QCkde/0LQEQNoVlqAOJHzGWeveW3I58i5xOO7i+580y3Ymqg3ah8v
         nH2k8tpS4clHd3QotKHM6w84nKpRRU0fRKkwzHHoLmgQmce6d7L27X59DlLTuxmj6CzU
         D/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786237673; x=1786842473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RIcoRAbFf3341jf2ecw8S5B64UJUijX3gld+wbMh7E=;
        b=GoFMLZ/ls8konGUuN39xkW5mbyJicYReqX33PfmpGCy6Ey8BQkIQNvNZtkf8bQZAI4
         5gwMeucpiLIL/rUE31NXyuAGRqK2nLNElYpTRblwN4tNZ6lwznTjPIu3XVgIe74BrRc6
         M6a2xQuEFVMwFOPAA2aVjoJpgBmUHk/ITOJGCil5wvdjZltANMkIb7cW5EOjIYQpRbBi
         XqfvbUuCna9689cMVdcxajSf8QuBdiyFB8bmd2jrNLiWOoNLUQ5o1fqk0iYaQwyIi+EY
         iNL1u7mTm1iptBrzIWJ6gehLXy7DQgVB2sH5aEjcmDulLIn25um+opbCtr8kjEu2DhIM
         OXbw==
X-Forwarded-Encrypted: i=1; AHgh+RqxC9qz2hria2acEel5wOqlNw1kSou31t5GOI4zSxmqului26XibyZ3GGkG6KzxY9Nysyd6hVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpO4oaz/7Sm87uyCL/PZ0/MVzDYAhtZpxLe8ptxbEJWTNzUsV
	hjzVP3GNnbulmQIA817MZe1hhJgdk3bR2br3ZYjnnT+QzEklzJ5snP0vs3UW1RfYNb3WFDZcmXk
	KJNBr61ELLg6WS8GmXRSonwHAwJoMIhmcfLBf3lsu
X-Gm-Gg: AR+sD13TKlijN+S6d9ReW2QSKrFa+vTeV6hd2hdVXChfPwnISDy6ex1AfpTDCsxq/AJ
	A7b3+QCr3yZPJerfRgwbOTrfVOKaBuJYjf3O7p2r8+c1HL6L6l6d3VRys2Fl5HPjqhPrXgrP6kE
	7hUrtj86sB9Q2WzcHYUSjOFPHzfE06N+CCwjHfzA8mA4wK+DA7XLZlZhuj1nIT7Gf/d4Yq54oEZ
	IPGdIJcP04mFnyKI38o7Dsea2aiNmWCoQBdDq+X67jjjdguPfJP6BJy2XxIm8NGI6DPCHWQ9cuq
	uN3a8ttAV03a3XP+Gf0fuqL53uKbtk5ps/tVFGiqZgaZk+k4F9NaIA==
X-Received: by 2002:a05:622a:1e14:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-52d23c4d2c0mr17327631cf.8.1786237672838; Sat, 08 Aug 2026
 18:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200548.3124802-1-surenb@google.com> <20260806200548.3124802-4-surenb@google.com>
 <anbZpzFbtYG7Ngit@casper.infradead.org>
In-Reply-To: <anbZpzFbtYG7Ngit@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 8 Aug 2026 18:07:41 -0700
X-Gm-Features: AUfX_myNmlcEkQAwXDWubrX1D1lLUTl8aLYHaNOUsK1z6JmJL0Nh17XQsBbFeis
Message-ID: <CAJuCfpGdyNq10F15G9Z=TrkcGL8my5RB1w+nZMKOTaH1o9mrGA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 12:24=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Aug 06, 2026 at 01:05:46PM -0700, Suren Baghdasaryan wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > =3D=3D Background =3D=3D
>
> I think we can do without the headings?
>
> > There are basically two parallel ways to look up a VMA: the
> > traditional way, which is protected by mmap_read_lock, and the RCU-base=
d
> > per-VMA lock way which is based on RCU and refcounts.
> >
> > =3D=3D Problem =3D=3D
> >
> > The mmap_lock one is more straightforward to use but it has a big
> > disadvantage in that it can not be mixed with page faults since those
> > can take mmap_lock for read, which can deadlock when mixed with nested
> > page faults and parallel writers.
> > For example:
> >
> >       mmap_read_lock(mm);
> >       // Another thread does mmap_write_lock().
> >       // New mmap_lock readers are blocked.
> >       vma =3D vma_lookup(mm, address);
> >       // This deadlocks on mmap_read_lock() if it faults:
> >       copy_from_user(address);
> >       mmap_read_unlock(mm);
> >
> > The per-VMA lock can be mixed with faults, but they can fail and need t=
o
> > be able to fall back to the traditional way.
>
> Umm.  I don't see how this avoids deadlock.  Assuming the next patch
> converts copy_from_user() to use the VMA lock, surely the following
> situation would obtain:
>
> A takes mmap_read_lock
> B tries to take mmap_write_lock, blocks
> A calls copy_from_user()
> A calls vma_start_read_unlocked() (because it doesn't know A actually
> holds the mmap_read_lock() already)
> A does a lookup under RCU, but gets NULL back (maybe it's calling
> c_f_u() with an invalid address?)
> A tries to take the mmap_read_lock again to make sure.  Deadlock
> because B is waiting for A to release the mmap_read_lock.
>
> Am I missing something?

I think Dave's idea was that A would take a VMA lock (which might
require taking mmap read lock temporarily) and then call
copy_from_user() with VMA lock only, which allows copy_from_user() to
take the mmap lock. This was used in the last patch [1] of the
original RFC. That patch is dropped from the series because this
approach has a conceptual lock ordering problem - it takes VMA lock
and then mmap_lock (see explanation at [2]).

[1] https://lore.kernel.org/all/20260429182005.00BF70D8@davehans-spike.ostc=
.intel.com/
[2] https://lore.kernel.org/all/CAJuCfpHBzYUNEe_LBpeERf68_fso=3DHy+UZWtqejT=
Ukm1O4NLfA@mail.gmail.com/

So, yeah. I need to rewrite this commit message.

>
> > +/**
> > + * vma_start_read_unlocked() - Find the VMA covering 'address' and rea=
d-lock it.
> > + * @mm: the mm_struct of the address space to search
> > + * @address: address that the vma should contain
> > + *
> > + * The fast path does not take mmap_lock. Waits for writers to finish =
if the
> > + * VMA is being modified by taking mmap_lock.
> > + * Use when mmap_lock is not held, otherwise use vma_start_read_locked=
().
> > + * Nothing prevents VMAs being unmapped/mapped before or after the VMA=
 is
> > + * looked up, if a stronger guarantee is required, take an mmap_lock.
> > + *
> > + * Return: If a VMA exists which spans @address, return that VMA, read=
-locked.
> > + * If no VMA is mapped there or, very unlikely, a reference count over=
flow
> > + * occurred, return NULL.
> > + */
> > +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> > +                                            unsigned long address)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     /* Fast path: return stable VMA covering 'address': */
> > +     vma =3D lock_vma_under_rcu(mm, address);
> > +     if (vma)
> > +             return vma;
> > +
> > +     /* Slow path: preclude VMA writers by temporarily getting mmap re=
ad lock. */
> > +     mmap_read_lock(mm);
> > +     vma =3D vma_lookup(mm, address);
> > +     if (vma && !vma_start_read_locked(vma))
> > +             vma =3D NULL;
> > +     mmap_read_unlock(mm);
> > +
> > +     return vma;
> > +}
