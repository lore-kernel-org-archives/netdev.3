Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0946A5F0
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855561; cv=pass; b=Cu+7IUOEuLL0cdskj0H2+DB975Yx1ysCjjCZ916q4hfqI3LnL3IvBMBXfs8uB9ZO8KnmB0TQ0SGEAcBcnM1QWKW65+pkauIKQSKzXai1GeWAMKGMv1oLWVW1ZbWyTjEUCOakYSj5fj6Af84rJhBXVLSoO+lghjwUEHiQ/NMXtQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855561; c=relaxed/simple;
	bh=WY0+lRBB6NjKhexB5/j5/ClPsqORPil9n5oGTPwlJ2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxpyIoLIgLh8qBo6jfbXCRNWlNFsNtnrCG1QD2iNYfbWwu260nlDdDR5j5KVYTVEjjVT8rvyvUI45nymDLUu2xTmtyEmJ9hF1l5ywKGqWF8pIcPCX7eUoUpy+XDVawUFRm/9GyCnKxGMNgT5TY31w9iKAwhL0Fx0QepdqrHdCdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SLeE5A8a; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLeE5A8a"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10e86e52so272671cf.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785855554; cv=none;
        d=google.com; s=arc-20260327;
        b=H7IQMH/vkEMu/ZN3lTYhCJ+mejWnHS2esCiAdEmBvBKH1qATN1vbJvqW5JQW1ZuaYE
         EhP8rA8QOHStF5GghTtn6hhD6cU9R3rTrt+enKJRZUFuE9fU9mLID1gl0LuXPNSY9bBX
         aLz1LU8Ak0Rd4uWozlZvbZb6aIRvq2XgkHeM49OfxHqEUnMryjYF0gK5MiSgTteouYtz
         6AH+uaKsXOMPqzxR+aCxbC2CN72cWy+y+1tnfmEGeP59wyuny62E4g0cBin7u7gUGEVN
         zvHsMVuAjIWPHVXy0AhLvalHaq8r3HNPrXfS4ReMw/aDJuLYNQNGbi2S1OM2omThsrIk
         ue4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6N0+o6o8vh4ZAONfoxI8DFf15MDBQKWEc1yozc9H+WM=;
        fh=auBZDoCghOc5fmxIJjcMsQG0o3OWAuJyapB7QXr2Xhw=;
        b=HQ8Kk8YQ/GiKfWd2ivD8lBEEfYwyxMwPIUds8QNyDuVN3jOqfLE0sxJ94hJiSYKo9b
         Z0z1cx6k87POvO32aRh/YtEJXuQr3TEqLJenUjH9DxtrUwgMosUct5zLhE3Sm7Ep0KmK
         DBEPfvtE6L7+vWbX1ATs6s3PH5P1t8IbIRJq7wrA7TklPrLa1gVjMKEUIGnP73/fBgAK
         ob5r3V0i0vjVZUFfxAlPj1jf9mNI/FZkmWDihCLsEuGCAKO+arnfA9Sthz6z6kTRXxVy
         L6xjXyHNWMQVszPP4dggnlb6k+4bC0BozVNmgUuhEiqPhClUhBoqqbraMUZoigpYElIH
         W+SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785855554; x=1786460354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6N0+o6o8vh4ZAONfoxI8DFf15MDBQKWEc1yozc9H+WM=;
        b=SLeE5A8a4Xbpybzc7DNpVw2cmcgGS5mzJBLc8O6SL5/eCxGJwidWJUbYaEv+Zk5ms8
         C5pD6n7CKrGcJd2MaGSlRWHWhLLzjBk902zJ/aLyl+qz4bLGZC8o6SW7opA2jjw7ZjCv
         I8dxMAjs1D7CD0lHBg+1Ph+MeWq4WMZ1nTXlKFXzNvpnAB9CnOnMNFqb7Tw2gkYREyZk
         igMP8JY/6aGVQm2uR/2wV+XvKnqs2P1GCI3+JwjSqWCr5RlQX8L0J2OO+s4+68tXZqB7
         VnA0/hpb17IsOiAU6zsONCqNaKVwu12En+lZTibYnIieawzGmPmV46RQ/BkY/p7qQy/o
         Rf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855554; x=1786460354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6N0+o6o8vh4ZAONfoxI8DFf15MDBQKWEc1yozc9H+WM=;
        b=CyMDLPVNv1hJQCVs++ofIEpyLGyC+Nom8n8mzrQioeTYe8I9ifk57Y51NLwdpLettj
         7JW+g772NHMxDMM44pdr/hECw/DYn4tcUbg+I51L4Gseb/+ClTpsRNz1wONh1jGpsvzJ
         SsTUVLsRH0826cpB5nPQCRkx4rr0bnqMeGd6qFfVB0eqmXXUAovYWb/VUi7vDPz36QUY
         BJSdXyRPJUPWNRzNz1yTi4HcP15BrsCTi8l4YCGvGECxTqLApuH2WyjaD3GbR8kE3EtF
         S7aAqXTH96yjfBt5iuahNVvyh64Dw/Sxk3dgSmtIU7XI3Qf05+awFh59XDhpUq2wLHDB
         5zOw==
X-Forwarded-Encrypted: i=1; AHgh+RocBtH/51nElpkYQbMz5cSGz0i1CAtSTaIdmuZo7oA2StAD0LUyOrCOE1f7W1uJRj3ViFvaJl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJfsvAe4uhpudv0dCIfl0AycTfYcEQR+5gLKi/B3At0OS03NN
	BaalbwXaTvs1j0+yQOBs/LFwzWqlxrYGVeeI9B2VHxGxTQkQ8WCGSQP/N+buDyycfq7lMWijDk/
	NU9D/rwP+29/34tbrOES37xYiQcs6An3SfsxeyUVB
X-Gm-Gg: AR+sD12sKhyrQ5hYmVULi0x0aH54XoeDaTKh+g4w5Ie89D/PJZ26zjPfqOwTpf63stE
	loVJNIcHpe7J+Xh5FmGeeP8WFphQESUCfvszqkIDjA6qRQLcl85vnmYSVr62H97VmxZyScldJNB
	fLzW8wEp//l+No/7dWkZRULd7H0xfb60Bbpe1s8Ss7uX++kvVn1bLfSYBB+jhJlFyFbth6gHibs
	6BqiKfd4mu0tk1/wV91qMR4EQlMzWLSsn2zGgayxw9KLF5e5JOBsx/58qKnqATnRUu1t+jajn5L
	yhS+1BumL2CY8FlMJl7N5JCTvzM/o5uhfTWgRzpTfW/GNf7xHSvnN6LjhnPNp6plv2wDP6Y0cNg
	=
X-Received: by 2002:a05:622a:6850:20b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-52ce4056a53mr2078511cf.9.1785855552922; Tue, 04 Aug 2026
 07:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-2-surenb@google.com>
 <CAJuCfpGezxdaSme_QpHVq-QVeZAUaF360_Ajvkrn3QqDcSQVog@mail.gmail.com>
 <anC1iE21eonDK06n@lucifer> <CAG48ez1=_O0g7rArdpoVwg84jOJuELEAXu5sw=TO_CWBsK=T7w@mail.gmail.com>
 <anGnOHgOd1q1jYXK@lucifer>
In-Reply-To: <anGnOHgOd1q1jYXK@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 4 Aug 2026 07:59:00 -0700
X-Gm-Features: AUfX_mwQTNrlkV3j7o_hqBHBqc6QYgTKXR7FHG-xiWygkBEgZziw2u25uHKbB9Y
Message-ID: <CAJuCfpFCBr127TJEWvanRtYxM2G21h-Y5NYK_hw9y0CrgWQF5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: Make per-VMA locks available universally
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Jann Horn <jannh@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:56=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Mon, Aug 03, 2026 at 11:12:01PM +0200, Jann Horn wrote:
> > On Mon, Aug 3, 2026 at 6:08=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kerne=
l.org> wrote:
> > > On Mon, Aug 03, 2026 at 08:24:44AM -0700, Suren Baghdasaryan wrote:
> > > > On Sun, Aug 2, 2026 at 2:55=E2=80=AFPM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > > > -#endif /* CONFIG_PER_VMA_LOCK */
> > > >
> > > > Now that I'm looking closer into this, I think we would break NOMMU
> > > > case because nommu.c does not take VMA write locks at all. So,
> > > > lock_vma_under_rcu() for example would always succeed.
> > >
> > > I don't think anything's broken actually.
> > >
> > > Per-VMA locks was gated on CONFIG_MMU so nothing there assumes per-VM=
A flags,
> > > but now you have stuff that happens that didn't before but:
> > >
> > > * vm_area_free() -> vma_assert_detached() - fine - it's always detach=
ed in nommu.
> >
> > I don't think that's true, AFAICS vma_mark_attached() is called from
> > vma_iter_store_new() which is called from the nommu version of
> > do_mmap(). But I think you're right that one blunt workaround for this
> > would be to add a hack that prevents ever marking VMAs in nommu as
> > attached...
>
> Thanks Jann, though also ugh god at that :)
>
> (Really the ideal solution for nommu would be a 'virtual' MMU with noops =
for
> everything IMO.)
>
> Anyway, I think we could fix this with a:
>
> static inline void vma_mark_attached(struct vm_area_struct *vma)
> {
> +       if (!IS_ENBLED(CONFIG_MMU))
> +               return;
>
>         vma_assert_write_locked(vma);
>         vma_assert_detached(vma);
>         refcount_set_release(&vma->vm_refcnt, 1);
> }
>
> Here?

Yes, I think so.
I also need to make sure mmap_lock fallbacks we are removing are not
used in NOMMU, otherwise it will fail to lock_vma_under_rcu() and will
have no fallbacks.
TCP zerocopy and binder are gated on CONFIG_MMU, so that's fine. Need
to check the BPF part...


>
> >
> > > * vm_area_dup() -> vma_lock_init() - no asserts, just sets refcount t=
o 0 (correct).
>
> --
> Cheers, Lorenzo
