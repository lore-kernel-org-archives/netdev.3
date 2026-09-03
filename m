Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67850C2B4
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469275; cv=none; b=Qqfz2zwq8xGNvnRoyqLxJD4/4mlWcVzVLEHJOxhTcPKOU/BdemV1o75arPfsbWBgcj1MojcIFBztHuoNnCNTiwCcQ4UZQWTnPYon/Jqp9jPYJ2vrAfAEP2glJE0NrimCy+qcM7Cjz9t7YGayubNz4qOuCBEcfPH8XeDaELV9M2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469275; c=relaxed/simple;
	bh=JSc3hB5pLYdZH8UknDATBVIxmfDjkSlYj2vg/FKzkkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkX4x+kCF1VGB97x0qfWIHlBr9p3xlnxYBb0Ixdx2zdVt4Dj1vSeL90QUSEW/dzRpWmeO8goiEBBAKbdLqONw/3UzNnNH+qh0ICxlDaE3YPMzcR5B045j97Wnc4LV7u6KbIrq231e4FDCXLhABLrnyyzc8b6Gq7e0Jl7KJSpTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLrOJ3D8; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLrOJ3D8"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so6565ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788469266; x=1789074066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8WxM8+POfE1P9m9JpepW1Kq4nxPF3SUoeDA/+jcOrg=;
        b=tLrOJ3D8Xf9pEXkzlFAA12n9KJmB8pQ12FPmDGiFN9+LvanFJBtmbd+u/ui9C0BB08
         H/eS4u8OGdcnCNN/QfcyEgqWJ47KCMFV8kGzFBi55Nr6UYEgWbD/YzMckJ1Usd6dfzbJ
         tBSlY+bLcA9+j3QFuQdnekE085ea0SYviVoQNYkWFuxcjVj70Za8PxMdTqi0SviZ8fKH
         u6rIUQgpq6dtFY/ohEv6CCIFO+eJFI2xSoFl1bkiBHtKCMo0Ch8BepeNZ2FLRvOoYl2n
         Q5X2gQBCTjVEAREjxNf5kp1Pq6uRoQuAEoMqpvxGzR+Sh/uDXB/dd0ms0HCBzc+INSLN
         v+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469266; x=1789074066;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8WxM8+POfE1P9m9JpepW1Kq4nxPF3SUoeDA/+jcOrg=;
        b=gjKeuJDz7TdPNS/yErNcajQB5cBnWivVBqenvKLWvUHr28uwtm1vvHa4eJ0tgklFcw
         Xb50j3rt8z+sov7JCphLW2fwCWULaV0wFVk+WPpd+Y7Ipvfr8hbbrOpxnPctb1pwrUNB
         eFoGfh9uBCA3UKg765d6jIY1W0HJ9h+51FmMNAVTFNmwVVNO33Dvo5MUbVMAjERVqp06
         mu1WTCjscqXaNQZ04o5HUoPbQ9Y+3kqa+2SacorO0Yn94pY5X35qgLVQ3b/HXPU8m0qg
         dJ/nWNWdraSDs8Z6svT9vOJ81G3SdO7bm5QlWyaTIqJ/792wSQEeTFwb6mDpts8UrXTi
         BHUQ==
X-Forwarded-Encrypted: i=1; AKwUvBywLkVKPU6QRwztlDpCYZpgfhJrPoQsoHcr870vWo1Vpkh8b/DeVRQ9iJoM7ZeeEIHtBQp1E1A=@vger.kernel.org
X-Gm-Message-State: AFuF++lmjpQ147y3BKuRRPA15B80y3J1SUKL0IN+tSoy3vnqhBt39ct2
	++fgZfTy2Jc5urbOUBvhPN7XKQLrUEkNdvEGtcUwYiNOknRuCS/W6wQOYWiL2TlyEw==
X-Gm-Gg: AYBFou0FDDeRBpKNAiejD9lDKAT2v4kSPY1/mPzMWaPAOcrk72W80qswAldlvYEpOm1
	yGNNdzPVGfmj/bn0BPFkfix/pZMS+pSsYhJULOrBWawQGgXw3a0L9Imzc5LPLThua768bFODRVF
	YKU9F0mUksO2JsSvbD0kazOpu90U+k/U+uhEg/DPqgxFV0IKGnEaznedylOLzbn6w7oZeANqEJt
	0TG1XBcyIDibfnz0JaBc9gVIIh3kNmnp5YZhWL1mFgd8C5aGalD7aKsVpzTxma300cGJU2KQqwm
	fAGAcEB2pDm1iO7ybN4HwH4+8+cAuu98eohO8BoT5a9tVoWNKCfDnfwU6xpS0CeAkZKXkqVH0h3
	vh9S6x6ouhiLRy1VS2jyc1V0V0n80u1G0sZ2a4yS07hOWhRtvb2AuvV/J+jfpP+xRfWmavc4NqO
	dNvLdXO5FvM6tNLWAn2yjVMYZzO/Jh59iJwOHIdOMsYIimxXhZgsw51Xtwr9uwMofXc+MShzE/x
	TgScR6mx7j0O+lbctthXxDQef0lECaaYT2ekJywFIO/aM5lMbhmrbEvJoWRRdBfR1FNZWXCx4dY
	fBqX9OM=
X-Received: by 2002:a17:903:287:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2db155f53d6mr1113975ad.10.1788469265229;
        Thu, 03 Sep 2026 14:01:05 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc454e22cb8sm100218a12.0.2026.09.03.14.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:01:04 -0700 (PDT)
Date: Thu, 3 Sep 2026 21:01:00 +0000
From: Carlos Llamas <cmllamas@google.com>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>, dave.hansen@linux.intel.com,
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com,
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org,
	jannh@google.com, arve@android.com, christian@brauner.io,
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
Message-ID: <apngDH-dLve0HvgG@google.com>
References: <20260813193433.3318288-1-surenb@google.com>
 <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
 <apVhzM2501wSiGGg@google.com>
 <aalhqe37szvcitr46c4fk6xcjtjjzm4zfm7ltrno2spipvq2q5@7svyjfbegb3s>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aalhqe37szvcitr46c4fk6xcjtjjzm4zfm7ltrno2spipvq2q5@7svyjfbegb3s>

On Thu, Sep 03, 2026 at 04:48:31PM -0400, Liam R. Howlett wrote:
> On 26/08/31 11:13AM, Alice Ryhl wrote:
> > On Sat, Aug 29, 2026 at 06:56:25PM -0700, Andrew Morton wrote:
> > > On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > > 
> > > > v2 version of this patchset [1] was written by Dave Hansen and per his
> > > > request, I'm taking over this series.
> > > > 
> > > > tl;dr: Make per-VMA locks available in all configs. Simplify some
> > > > of the per-VMA lock users now that they can rely on them being
> > > > always available.
> > > 
> > > It's been 2+ weeks so perhaps a refresh-and-remind would be helpful.
> > > 
> > > But it applies well enough and is adequately reviewed so I put it in
> > > there for testing, thanks.
> > > 
> > > AI review might have found a couple of pre-existing binder bugs:
> > > 
> > > 	https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@google.com
> > > 
> > > and a small rusty thing which you might wish to attend to.
> > 
> > The binder bug is not actually a bug. When using VM_MIXEDMAP and
> > vm_insert_page(), the vma takes a refcount on the page, so there is no
> > use-after-free even if free_page() is invoked without removing it from
> > the vma.
> > 
> > Adding an INVARIANT: comment to the Rust code SGTM.
> > 
> 
> I think you are correct about no UAF here, but the page isn't exactly
> pinned to the vma - which is what I thought you were saying when I first
> read your reply.  It's sort of misplaced in another vma by an mremap().
> 
> vm_insert_page() will increment the ref count, but if the vma is
> mremap()'ed with the same size vma (ie, not expanding), then move_vma()
> will relocate the pte and the old vma will be closed and set the
> binder's mapped = false without a change to alloc->vm_start.
> 
> Binder now thinks there is no mapping but the mapping has an address so
> it can't map anything new.  You could get around it by replacing the
> vma, but I don't think that leads to anything interesting.
> 
> So we still have a ref count that's okay, but now binder has an
> alloc->vm_start that's stale and a mapped = false which leaves binder in
> a bad state (one might say a bind).

Right, binder should really reject mremap(). And partial munmap() too.
The is no use case for them in binder and it only brings problems such
as the stale alloc->vm_start you mention.

I sent out fixes for these issues here:
https://lore.kernel.org/all/20260901205250.1638304-1-cmllamas@google.com/

I'll Cc you on the next round if needed. Thanks Liam.

--
Carlos Llamas
