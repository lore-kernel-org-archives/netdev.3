Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4842BC56
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780141; cv=pass; b=a3+jA1d4WTaKoypMe0oq80e+5vQDSYBRf7vxLim51jQOPWTL9nSNgPNwZrkUXS/8SEAlm9lhnTWBh79kdPzu/URq/cDwAY6uJd58kCv1U6XsqkjP044gZ6cCKpMPhPEpWuVO8ub0QkE/TYC+lzLf0R2IBEPOsChdv+7iMQaXNTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780141; c=relaxed/simple;
	bh=z7ugPuUEH9pvtG4TP2Jg8TSGni8pM15A3IqbNFNhjS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjJ2AYxUjMK1dzewnsJpWDmn3EzAcjq4lyLQWVw5vH9Reye8O8uFcPT/vlxDNo+po73flJ9+9w31hH/ahUTqe4yC1yTyZ6skwEMVOtmrwX3KH1eeOXwtfixCSVIikTGXB+fJikIHLRLgwGkYUxcwXs7TJTynEFX7GuvMV2/Jo/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljiy/skX; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljiy/skX"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10ed63c0so19071cf.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785780138; cv=none;
        d=google.com; s=arc-20260327;
        b=lvl6vc69+gFRkyKuK8aQMXObU6YlqNmkVGOEzcrjex2KhG/i82Zgu5HoJYGoo3oLas
         gOVUX/Nq9SbdRER+DPo98LsyueVJTQUKZZYLr/+UmgMD5Kd+eEtaHX60sYGFbS56tn10
         ElxfprQaUxCltcDbNIGsIxrx9OoeiGMSodVbsopW8VtLhvRkZQub1tmwaaLPynQSkIV0
         f10W7HREM8vckhNOhGIRJt7lmvj7bVnh+Kxe3Y6AoFrZ+Z6HriA0mFHAtpQ/xjcGCalX
         FBXrkyD53i4bbkgmJNpn8QDLtzd44bQbtY81r5FCEyv753/L1jteRZ2iU6KKdc3XRkSQ
         2PRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z7ugPuUEH9pvtG4TP2Jg8TSGni8pM15A3IqbNFNhjS8=;
        fh=zALViPhDDQW4tFFMIgyNYgYGDjRFYTCWS0hLUGAxSfs=;
        b=deZaY53yAa7N+5MImszluuuVgCjR3Noy7N+V5Z0iJUWbMBXnXH/DonQk08t4XSWNBl
         uLtbbovKNgJyj1viesuu8gBFFVcgDn3xTrtYH9VBKjulsZtYjlWsJad9ZC4oh0hIkY8/
         g3HQV6UMMOaSur3bQKBsfl/dsE2QxZPknlhUq4iv9V4KTwT+wAqJFCskjBdJAyfjsYKQ
         TJGg9wBkovPPSX3YqI5vK9vDvCPArtPAG6fMSXIj8AckvzgX77bPmVoPBsKwOYoGvA4F
         Luf3xI3grDNvqDIPaO2OipaI1pR95T9Wzbmc/EvVtMsk6aEl2GvtXAhPnxyauAMYGaXT
         M15g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785780138; x=1786384938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z7ugPuUEH9pvtG4TP2Jg8TSGni8pM15A3IqbNFNhjS8=;
        b=ljiy/skXWVok6SFgOh6lIcQL3PeOIaHU9ovbAjLf56xl1XJmeawsTaAXEGHucO8VGu
         5T06IUAXVMDY7zidbRyoct3i3EGuCasuRq2JDTLlCk4uf9QT+FP3PuizwW5rZ9i01biT
         eLxfCfxanrFnYf7leA9MCUm1ixU1E4maro3Xq9nOupGtAZ7SWfkJtgnv8hCFLggJ8CDn
         yT2yYJtJZaimT1zYXQY7q7jP94/kF8XlFTGnkb4XnDf37c0XWG4upORc0iJD2H8c/la4
         wfWlkZMvFfWUIdFlwf0pfgjzOfddXauPcZSegTApmEiyHsmKWXAELu27wsMzoT0gDuiE
         +JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785780138; x=1786384938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7ugPuUEH9pvtG4TP2Jg8TSGni8pM15A3IqbNFNhjS8=;
        b=JOXmdV6yTeWU7KPsrYcziimQFdpDVFlyGBFpaF4M2j8A78wtMVs5wvLIwOWmmgC4HG
         9d4CKGw6+fdm6tG87wZqERtfz9CY990aJzlGCZmjDSYiLGOMsb18tFQZJbC8gv00zp7G
         FIpJ7urmnu47pMhw6fWgFYz73Aj+aKt79fBJ9mEwkp6ihnjpN9gcjjn5BYM3UZYlKrky
         /+fXjlbnuavd7Akc0Ya/LBBd3/ma7ZFbObFQDuSwjPqpnHP+0iCl1T1BR2pGK8AjJHkg
         Gcal8/dFtg9JXSSxNulWNS+yv7f8iIl8Lc+IsbbztY2Ql9DyNqjEwTn/yNUAkFf+6/Cx
         oR/w==
X-Forwarded-Encrypted: i=1; AHgh+Rq3c3xX7ApZI7nGtxRePK34xw13XpEBRNsdpd3WLDNf/82Osu62YNAVU1ZvHWRj5TDgTl5Y9mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQNgzSwkArfuxa9DkhD6eoyeU7SeDF9mrLs5ZIBV77h9X7tvuu
	4gT9aJFuM2B0rTRTCFLNd3MB1YKF+FY8vlamrqBZnvNE7OlOhW0uiyqzBPlaaK3oynkjSFXRkat
	9/VnDytXBImIZrK9b16MnxTiL2chrBEfWUWN6C63I
X-Gm-Gg: AR+sD13LWA86G5zj3degg+NeBZqrLGwjoVnmWIE3bPJio2hLs/MSW5a5AoWGrB9Se2s
	tWgsnAauSjXyqlHQtFZEZV8fySwtKrG80KGrAre0fVH3eD6igzU6EigporkvJAZfiIIeIighqmo
	z39bQ9LcFXNehWo3RPiLkKxOe13rxpcmpNQ6cXWLYpHFHYEBpBKkPgviMHvqGI1w/LYi401nPnY
	tRiJGL44P1g30rJC9yP6XqRnM9moVRN3Zwtzzuvii3bvJSTGrISrN2csj8FnfM/WVLxkKpGrJUM
	wOhAVYRdi22G4M1mjW9c2ASw7GMwnd/WyRyjQaHSSMs=
X-Received: by 2002:a05:622a:98c:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-52cd4df7d70mr979371cf.8.1785780137924; Mon, 03 Aug 2026
 11:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-3-surenb@google.com>
 <anBj40CVAhcGMnQ4@google.com> <anByayBh6Ed2bXox@lucifer>
In-Reply-To: <anByayBh6Ed2bXox@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 11:02:06 -0700
X-Gm-Features: AUfX_mxKLrQh72gLoW3UHgMSLtVPwg93Wyi6kzNAycJjx9dt9DeuOOjvi3Gm980
Message-ID: <CAJuCfpFTqK0jkhm6FQ8Q7DrPG+VSeKufV4Wyny-a3bDi-7R-iw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 3:50=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> On Mon, Aug 03, 2026 at 09:48:19AM +0000, Alice Ryhl wrote:
> > On Sun, Aug 02, 2026 at 02:54:56PM -0700, Suren Baghdasaryan wrote:
> > > From: Dave Hansen <dave.hansen@linux.intel.com>
> > >
> > > tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> > > it and mmap_read_trylock().
> > >
> > > Long Version:
> > >
> > > =3D=3D Background =3D=3D
> > >
> > > Historically, binder used an mmap_read_trylock() in its shrinker code=
.
> > > This ensures that reclaim is not blocked on an mmap_lock. Commit
> > > 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> > > support for the per-VMA lock, but left mmap_read_trylock() as a
> > > fallback.
> > >
> > > This was presumably because the per-VMA locking can fail for several
> > > reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> > > to mmap_read_trylock().
> > >
> > > =3D=3D Problem =3D=3D
> > >
> > > The fallback is not worth the complexity here. lock_vma_under_rcu() i=
s
> > > essentially already a non-blocking trylock. The main reason it fails
> > > is also the reason mmap_read_trylock() fails: something is holding
> > > mmap_write_lock().
> > >
> > > The only remedy for a collision with mmap_write_lock() is to wait,
> > > which this code can not do. So the "fallback" after
> > > lock_vma_under_rcu() failure is not really a fallback: it is really
> > > likely to just be retrying in vain. That retry in an of itself isn't
> > > horrible. But it adds complexity.
> > >
> > > =3D=3D Solution =3D=3D
> > >
> > > Now that per-VMA locks are universally available, lock_vma_under_rcu(=
)
> > > will not persistently fail. Rely on it alone and simplify the code.
> > >
> > > Full disclosure: I originally tried to do this with
> > > lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> > > trylock semantics. Claude caught this in a review and suggested the
> > > approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> > > I guess.
> > >
> > > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Is there anything on the rust side that needs to be changed also?

No. I think the corresponding function is rust_shrink_free_page() and
it does not have mmap_fallback logic. IIUC, it just returns LRU_SKIP
on failure.

>
> --
> Cheers, Lorenzo
