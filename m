Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2777376466
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788239641; cv=pass; b=qcqfGY9B9UwMtHDz1fg/mxLw2DOTOV3doN98JObsGSGmhGIPojg/gPC4CUvST2u7d9zVp1oX60+Dd1s5NAJyNPVfEIxJRGnwSfMOvfAFO4eQXnSXgH7Ow7VCDEfyhYvhkfIAPjVgobt7NLnjzq4Pzvy3fDe7ebqBya3FItW624Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788239641; c=relaxed/simple;
	bh=MGXKjt72OLD/ras8fqx5jaTT4+zOPbm9SCSoy5yVl+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff8LxDUFPRXttbq2f9JzTPbJHxMlDgwdc6wwy+JWdJnbMYiCxNsoVDmQrtyLbQC7cBHfV9eqNopz8U2Bd12ykJKzTg/8CLbS+aIYJopEZUiK9a6VePtlZt38Hzh8Qp24OGcSssnQ80qLhFh8cPpUUQGVUxDfaeFeQgNzXHvDT0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pktDAnUK; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pktDAnUK"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52faa58bff5so170271cf.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 22:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788239639; cv=none;
        d=google.com; s=arc-20260327;
        b=EhsrFDLRq/ibCPoln5H3gRuAQ+W2IUJOD94+pU/og0DHeQaHi3J+xEgXstk4lMDXxE
         wHNo3wTgnWoJFIA4JeWO90i36ZNWvkIf1EN39426SaJJmYP83kYjBUhryTbsbTipmayU
         X9mPq00K6ry4vSCEoXXwcU/9At6P2oiEtn1CTTa7ODrSBM4MWmGBx4Kgh0EEMk5z0HJo
         nCM6w2FA0agw3BfDPdRAspBEv27gpKLrz/wLWmwJJD73a9uN38q+aaYXvOKLEDS6mrEP
         hngyceCbrrMLy0BliueIqYwMHQ693IHxVZQWOv+sM7GdDCNbkI3y8vAI+81XQ7dw8+cW
         JZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UUD1uKVBIV0lE2LKCNu8RAcV892bBW+atBki9y53O4I=;
        fh=0c8k4zqLytw5aFV+Qo3t4S6DnfDng7FjEJu9tdIpGnE=;
        b=Vd2i94ks2m1HysggE1hZqlj48tbTwCcRZtHcRABIw8e92h5kRa/GbSKsoOU+43LQ3/
         q9uC0brSNFsZ6aY8byIfUZMcz0TAPJrUgSfM76DafVWYk/5ey1y6FNwye9MbjZZyroVe
         rN9TzxC684GwnxVQWodkSRW63Wt3pOb3kC3rcmyJA9hFqrcI1mUUb2PbAIx7fQ0jqEVb
         vD8Ypd4e0ZSgCGidJ7OVjJj4CIZwP4pRW4adKj+nicYH5YiSK/D2Bes608Zb8FXMuF/f
         7MgKK3ymOT91JgeG/i6kux3kNZVOinYtvSs/BBxdCm7db0Qmgr3Rl8M6Ba4ph7T6rdM8
         oBpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788239639; x=1788844439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UUD1uKVBIV0lE2LKCNu8RAcV892bBW+atBki9y53O4I=;
        b=pktDAnUKH3TAolfpX3GfFgcO9Xs6nnEooduDqnz245GkWBZ0wGgB5wbhMTLpilo6qc
         HALfbGKzzC5sbpj0vnEBAipI1srvl/hmdCSBF+vHt3Nt3LAo6i4bM0vzXjtz2J1/wmDy
         j6E0nPy427oqzkR7llHk4EOCgJVCoDHyWg17UHAZU1VA/qQphKvmfUTmsZJSOn1EDXZb
         bvqY6BUETR1Z2DO6aAfzL3NB5CMxVo3ctRh7k5CKmrVx9FLRduq+kiNBQgpPAk8FfQB8
         GbuluHPxqY5H4zISs64PZYhVQ3qvDl+Wt+WXYd6OfnnwZpJ9XW7awrEz69qhzlwj4+9P
         zfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788239639; x=1788844439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUD1uKVBIV0lE2LKCNu8RAcV892bBW+atBki9y53O4I=;
        b=rARXvovoKC7cn6kdVQO23Q07yRZOXRmb0NxS0o3ip8g0saDZfzYITNp5KAn4y/d/Tx
         SKLUzFhHluRT5av/4x4s9z09z/lgDmbzh4wZSUPSJn1ridIzkMPfKTfEerwzLddvIwl8
         QshhMLDznSz7iMnVg+zW9AKYcLEDLgca/QKshgIT2BbCfiCg3GrlBPpxTPZWue7dG2D1
         hNToR4/SwJjnFS9tkz+VKESx2MCoSv2GAvydg1K6KoJl/rYJjRjQSULa6XoGAX3jLOXd
         CMP+cjmlyFB/KPDjEi8qqYl9WLToDYdN8qRNC1kiudcmIt5HO1iS6joU9E+3TsMG8xiF
         4L5w==
X-Forwarded-Encrypted: i=1; AHgh+RoFh3wIFe+1Bka5xH2tzgMZOOK6S6PBPhpqXCg7VWhpTRJH9UWGoW9BqEeqqp4Q7pInxuJ7sqI=@vger.kernel.org
X-Gm-Message-State: AFuF++kuNcPmzmcUO0ufG77fJTwH6CcuJNWlalKBHHvLQ3J0xdTzAF35
	BXBUHt6LMTr4Ii16s4oTO7ojztoXXFOs3NRJC2F+T+7WBPyR3g1YM7IQpPcsxdvx/VGpE3OWCIo
	Eir4eNfKI3Cr2fyc8mfzXwUGp7FNLL/9nlAnreAbJ
X-Gm-Gg: AR+sD11cNZpSrTF8T4vpDksHmlA1uTTk9upLk3SIpy9gJeXEAQws6yCKrtT8fjXfze+
	+URtjNBW4fSpmtPfm+aUU8cqwNkJlP23OFWjx+0LzLVaPQFLNf2ERUznZ7KXgxuqRPxltiedpK2
	95y0gi8EXVq0H8jOxGfjCrXUps58BSOweO3/xcvNEeX7kl7KuOlx63xkg3bt193IOeYCreUbhz4
	fmHuM8kSrEsBe2UpIxoMtOvY8QUECqI4aFtkcQAuPnjuen0TJfQqU75d3xwT4r9QRm1H/ennEPI
	QJT/hX9ZoNDG3+sUeTyR6HYKC2DNici65zpbu2/tX+U=
X-Received: by 2002:a05:622a:428b:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-53024be8e1cmr8537361cf.0.1788239638146; Mon, 31 Aug 2026
 22:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813193433.3318288-1-surenb@google.com> <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
 <apVhzM2501wSiGGg@google.com> <apX_r59k4e-XiI-C@google.com>
 <CAJuCfpEDgdC=N8__Ye1xP8rZtUwWrGhKhJ9Qnn0hdV+u5r+hJA@mail.gmail.com> <apYOTPIBTsuQKUXE@google.com>
In-Reply-To: <apYOTPIBTsuQKUXE@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 31 Aug 2026 22:13:45 -0700
X-Gm-Features: AcwNN1VAaOHg69O9ZoXyWul1qNpWHuewW8j4AbDLbUQZo9pKosyw0CLlNI76Si4
Message-ID: <CAJuCfpHFsjmGwfmhmOaGdnwJkyzMNdUqRne4W0GN0DDkpMkExg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
To: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org, 
	david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, arve@android.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:29=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Mon, Aug 31, 2026 at 04:19:39PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Aug 31, 2026 at 3:27=E2=80=AFPM Carlos Llamas <cmllamas@google.=
com> wrote:
> > >
> > > On Mon, Aug 31, 2026 at 11:13:16AM +0000, Alice Ryhl wrote:
> > > > On Sat, Aug 29, 2026 at 06:56:25PM -0700, Andrew Morton wrote:
> > > > > On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > > >
> > > > > > v2 version of this patchset [1] was written by Dave Hansen and =
per his
> > > > > > request, I'm taking over this series.
> > > > > >
> > > > > > tl;dr: Make per-VMA locks available in all configs. Simplify so=
me
> > > > > > of the per-VMA lock users now that they can rely on them being
> > > > > > always available.
> > > > >
> > > > > It's been 2+ weeks so perhaps a refresh-and-remind would be helpf=
ul.
> > > > >
> > > > > But it applies well enough and is adequately reviewed so I put it=
 in
> > > > > there for testing, thanks.
> > > > >
> > > > > AI review might have found a couple of pre-existing binder bugs:
> > > > >
> > > > >     https://sashiko.dev/#/patchset/20260813193433.3318288-1-suren=
b@google.com
> > > > >
> > > > > and a small rusty thing which you might wish to attend to.
> > > >
> > > > The binder bug is not actually a bug. When using VM_MIXEDMAP and
> > > > vm_insert_page(), the vma takes a refcount on the page, so there is=
 no
> > > > use-after-free even if free_page() is invoked without removing it f=
rom
> > > > the vma.
> > >
> > > Exactly! I agree the refcount on the page would prevent the UAF.
> > >
> > > However, we should still reject mremap() because this leaves the page=
 in
> > > limbo since it is not given back to the shrinker and also binder can'=
t
> > > make use of it anymore. I'll send out a patch to fix this.
> >
> > Ok. Should that block this series or it will apply over it?
>
> The issue is pre-exiting and unrelated to this series. So I'll take care
> of this separately. Thanks!

Perfect. Thanks!

>
