Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE83909A6
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784634; cv=pass; b=ILVqq1ouH+0Yhf5XhzSLmEc7zRpq777L635ts7O5Vt0SXa+3+ihe6EDhmReGOYVwV3EqQCninGGqgSaP6Y/wxJBjBqd/U/3Zl+6iOvEDVRNmTjjBNqZSinki+pRo0bZvISrdS08kH4WXxEIBQreBNAHsvnEM5kNHSLiJVpscPQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784634; c=relaxed/simple;
	bh=bPZPpPndDRRkqqMLvBNnzbSEhWxpMsQNMCc/VRsGspw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFT3JFryOZjBXMFMesuZ4dTu8bbprXZOjlqFxgJytHrrFTMo0B7AeLo6+KZPSGW/6mnZ5/LDshkyMUuZLBMKfduGieBN72SHj1qQ9PUnsgkKURhUlxWUwNLpGN3HgTegYxyc8+J0pkxNAClP+Y+IfkZzAD/XzE5YFfn+sfI0Hzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oT2JutMy; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oT2JutMy"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c10ed63c0so44651cf.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 12:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785784630; cv=none;
        d=google.com; s=arc-20260327;
        b=polLvmz4GFe0TTyfRy6cPTyXP/vI0St1B035tXesu4bKCBcMqRimCfW9yFB+g5LZUB
         R3DI9hLhw5Sv8Y9W8iB5tWE7Hkl5NDIwHob4q8OlxLjk9U4yExMWB0KDGuSRyKjXvT1e
         u+uZSu5JcRS0csgjc1I/HQtb5qJXwq4NL25q4hpgWI6KhZ4C9QMr9UXkr/yzoCHDTThV
         AL6JYfyEZtBBN8oNazaiiWDm5b/pAXlv3zt1fpTlovfvmGuaqkb76yGAJNkRho1PZaoT
         LALXRXuLZGD+c7bEJMRXcXhiq9CT0GzjleYDib26FCYYLdfiNCJ4/0pL0peSxs8CsRjy
         uyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNIAfYo4GwsoTuLWmj2sTbEFVhYgxiEUZM7PCsadCHA=;
        fh=jUYdjKUvLqXBCNk+E4UbrvSM0uK0yfBYK/Mfc5xCYQ0=;
        b=ZXyNdCz4FoflV7WLe1Xusx1U5WKyOfQqxsmX/I9RVRS9jQr4B6cbPgaz/RQVYZXqiP
         uX4iaOGZ1+s5k0FKrGLT7deQWNZoWWss0sDV/trkMt58JCRKr+Zr3zdx/tdzDdpzgx7C
         0TmKuDFki7bOy/+nuQjM62a7arMmmKhyoABbSTKajBLwPSa2C5hiLd3RQGrEgf+0WLDg
         XxS9MXSxcfHySBBov6sHomD/GaHB0hqfzpv/n7m8TJCgD4Gz3RZ3+FyKpkznDcKMbPOc
         RQKeiyNrCTSY7ViSnX2bkOQ3BXe0sO8YQ7y5gas0/iaHML74moSulKk1POONGYjc6Mqq
         +X+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785784630; x=1786389430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNIAfYo4GwsoTuLWmj2sTbEFVhYgxiEUZM7PCsadCHA=;
        b=oT2JutMyuo8uDPa2Dl854WpkoPVzccj0AQZNTFnz9jAeaEMLbV+KQX44GhCwzVoUtC
         QrYnMwrBWuUAXCCPOeBHY273ilW4uCVuzIaYvSrWvhBuRZ9optgrc9bm/EfL6Hs88oZi
         uzopnOt8PlidcjYCnRZcPCfUjyxs5O9YXtHWANFrSIomKWFEZ6QHRugWC936bQpbWoIv
         wQBlOfF9lowN9EeHHX/5rl/eqaoWCl1W5D4f1YJRHci7eZMelXoNZblzSFIkptX5lfaD
         EDStuu4VW717qwmk89p1b9vD3UOXntqFe83V4iNXXst5u0vw147uj35f7kqCxKGFHeic
         gvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784630; x=1786389430;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNIAfYo4GwsoTuLWmj2sTbEFVhYgxiEUZM7PCsadCHA=;
        b=aIHVzpwqeazHFxMcm5cltNcZeSxGSedKrS81lJPlR8Bf7p57+Eqk9J6fnBQnTEugnh
         FNpgKmul9om4WtDTCmJIYtDSRJxH8oDb9dYSJbG9nOeoySXCTGUk9XM9FuOSfIwIXOkf
         NMexFwysw1rNYsWozc+XDkiTjJ9I+y5kgqYf0V80IV80S3TUb1yJKeUYgz5mdZjzI4mH
         IZ8J8RTnKW10U4Kq4b6MZoW5f3IWKylaGfhslD8SSWEE0F0uP/u1DYUqFKNqS2IvSEUs
         Em+KXXUcPWHrkL4RZJETVhIW0QI0jtqT2G3F1iUF1MCpSPI3XiIzI9BcuWp2o97aHzVt
         Shqw==
X-Forwarded-Encrypted: i=1; AHgh+RpBtAYBi2A7UMS3/sEwZ9v3QnH0YRkjPrRnOzkhNWFRnV19/oXEt6asGvRk9VbCu5i3mV+UWQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mVLPhiYNFEkTDmSapxeeLv4muR2249m7CHuHfkcMf2C18c3c
	A3O7qo9BNHU9kE7t+SatcpqqaHcc4maITXlx6GFJz6YmJ7VRzMaEpQVOgcZPTc7GoCbJyHPAaPV
	hHhAEDf8AbZHW4bQDq9t9AI4DSVXp0A4sEHRN9jJ3
X-Gm-Gg: AR+sD114TvdITDSMT9CoKSt6/NH9y6KjZMThY0ZEmqg2tUxOsvrSOmeOjM4raF/rHSe
	Gkl6GONa0g9BLexg9UoYBSjZclGbhxDyq2iIze3KQDfrPb8WCVTPkiwhO1IlXSoa6SgBpi2SQG5
	gxmKkEEhY+dHNicwOkN9UV/W6H8ft4Tv63H+XXJaeH2o0s023z8W2pGrWbJpfzU+x/Y9jw284Me
	MJZJ2BEgmv6mKJY/6M0dqyoRmLYBRB89pW8ZA+Pu20Bnu7s50PxJglZwGv38hx4wDn/stRJMUNW
	mGpKiiAZzR2iOp11F3pSsEBAP8JvKmurnbrXDRBaaUXdh0JEnYeczw==
X-Received: by 2002:ac8:6a0a:0:b0:52b:806e:2633 with SMTP id
 d75a77b69052e-52cd50fb3a7mr1807921cf.1.1785784629587; Mon, 03 Aug 2026
 12:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-5-surenb@google.com>
 <anB7shWzNHUa4poC@lucifer>
In-Reply-To: <anB7shWzNHUa4poC@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 12:16:58 -0700
X-Gm-Features: AUfX_mwQH4Pvuvudr4leJ9DstYfBHWpHm3T1TlhK6nWezd5tB43ondZfCM0sUQk
Message-ID: <CAJuCfpHMf3v4aD9CkeNJ9t5cN=8iWW1WCJsJfyzTs3xYb_6JwQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] binder: Remove mmap_lock fallback
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

On Mon, Aug 3, 2026 at 4:33=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Sun, Aug 02, 2026 at 02:54:58PM -0700, Suren Baghdasaryan wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > Previously, the per-VMA locking could fail in the face of writers
> > which necessitate a fallback to mmap_lock. The new
> > vma_start_read_unlocked() will wait for writers instead of failing.
> >
> > Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> LGTM, just a nit below.
>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks!

>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: linux-mm@kvack.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > Cc: Todd Kjos <tkjos@android.com>
> > Cc: Christian Brauner <christian@brauner.io>
> > Cc: Carlos Llamas <cmllamas@google.com>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: netdev@vger.kernel.org
> > ---
> >  drivers/android/binder/page_range.rs | 19 +++----------------
> >  drivers/android/binder_alloc.c       | 17 +++++------------
> >  rust/kernel/mm.rs                    | 18 ++++++++++++++++++
> >  3 files changed, 26 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/android/binder/page_range.rs b/drivers/android/bin=
der/page_range.rs
> > index e82a5523804f..f7ad88a0d806 100644
> > --- a/drivers/android/binder/page_range.rs
> > +++ b/drivers/android/binder/page_range.rs
> > @@ -439,22 +439,9 @@ unsafe fn use_page_slow(&self, i: usize) -> Result=
<()> {
> >          // workqueue.
> >          let mm =3D MmWithUser::into_mmput_async(self.mm.mmget_not_zero=
().ok_or(ESRCH)?);
> >          {
> > -            let vma_read;
> > -            let mmap_read;
> > -            let vma =3D if let Some(ret) =3D mm.lock_vma_under_rcu(vma=
_addr) {
> > -                vma_read =3D ret;
> > -                check_vma(&vma_read, self)
> > -            } else {
> > -                mmap_read =3D mm.mmap_read_lock();
> > -                mmap_read
> > -                    .vma_lookup(vma_addr)
> > -                    .and_then(|vma| check_vma(vma, self))
> > -            };
> > -
> > -            match vma {
> > -                Some(vma) =3D> vma.vm_insert_page(user_page_addr, &new=
_page)?,
> > -                None =3D> return Err(ESRCH),
> > -            }
> > +            let vma_read_guard =3D mm.vma_start_read_unlocked(vma_addr=
).ok_or(ESRCH)?;
> > +            let vma =3D check_vma(&vma_read_guard, self).ok_or(ESRCH)?=
;
> > +            vma.vm_insert_page(user_page_addr, &new_page)?;
> >          }
> >
> >          let inner =3D self.lock.lock();
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_al=
loc.c
> > index 84104ba04e30..519dcded19b2 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -259,21 +259,14 @@ static int binder_page_insert(struct binder_alloc=
 *alloc,
> >       struct vm_area_struct *vma;
> >       int ret =3D -ESRCH;
> >
> > -     /* attempt per-vma lock first */
> > -     vma =3D lock_vma_under_rcu(mm, addr);
> > -     if (vma) {
> > -             if (binder_alloc_is_mapped(alloc))
> > -                     ret =3D vm_insert_page(vma, addr, page);
> > -             vma_end_read(vma);
> > +     vma =3D vma_start_read_unlocked(mm, addr);
> > +     if (!vma)
> >               return ret;
> > -     }
> >
> > -     /* fall back to mmap_lock */
> > -     mmap_read_lock(mm);
> > -     vma =3D vma_lookup(mm, addr);
> > -     if (vma && binder_alloc_is_mapped(alloc))
> > +     if (binder_alloc_is_mapped(alloc))
> >               ret =3D vm_insert_page(vma, addr, page);
> > -     mmap_read_unlock(mm);
> > +
> > +     vma_end_read(vma);
>
> Nice cleanup :)
>
> >
> >       return ret;
> >  }
> > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > index 2633e704c83d..877fad68be9c 100644
> > --- a/rust/kernel/mm.rs
> > +++ b/rust/kernel/mm.rs
> > @@ -190,6 +190,24 @@ pub fn lock_vma_under_rcu(&self, vma_addr: usize) =
-> Option<VmaReadGuard<'_>> {
> >          }
> >      }
> >
> > +    /// Find the VMA covering 'address' and lock it for reading. Waits=
 for writers to finish if the
> > +    /// VMA is being modified.
>
> This seems a little inconsistent with the C version's comment, should the=
y not be the same?

Ack. Will change.

>
> > +    #[inline]
> > +    pub fn vma_start_read_unlocked(&self, vma_addr: usize) -> Option<V=
maReadGuard<'_>> {
> > +        // SAFETY: We may invoke `vma_start_read_unlocked` because we =
know this `mm` has non-zero
> > +        // `mm_users`.
> > +        let vma =3D unsafe { bindings::vma_start_read_unlocked(self.as=
_raw(), vma_addr) };
> > +        if vma.is_null() {
> > +            return None;
> > +        }
> > +        Some(VmaReadGuard {
> > +            // SAFETY: If `vma_start_read_unlocked` returns a non-null=
 ptr, then it points at a
> > +            // valid vma. The vma is stable for as long as the vma rea=
d lock is held.
> > +            vma: unsafe { VmaRef::from_raw(vma) },
> > +            _nts: NotThreadSafe,
> > +        })
> > +    }
> > +
> >      /// Lock the mmap read lock.
> >      #[inline]
> >      pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
> > --
> > 2.55.0.508.g3f0d502094-goog
> >
>
> --
> Cheers, Lorenzo
