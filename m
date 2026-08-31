Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44FB30D41C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218395; cv=pass; b=F/CileyEbJxT2vWVLW7qCGNHqUCU7wxn+6imSEV9eHY9aOKjQ89d0Nl/sflbSg6uEImGAZaSnAFc+HbpjlXmPqra/tuMlO8agNSz1N5V+wEGnY6t0RlJ1aPws4ECn894cwdzMDnlvUalDoDDtCEzBzrtB/V8TVmbTJc0XURey2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218395; c=relaxed/simple;
	bh=FFESqevb09AMNF3WZSLfXKBb/pgBxiHfa4nhv+G8hgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXOiVZ4AHYF2Kwo+ldUUlA4VcL0LOojcOfilnqESt0PXXDRDRCDATw6qvykh5qS76n67EX7Vrmm14NDwFRx66hi27dBiekDosEAiGWpsrN5bb5Ot1zoDh/mPCD7bdBIWizhnqizY+ktePH9Qs/okiV0ahQx97e+iKWPwKLbwrkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kz8n5QLw; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kz8n5QLw"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c01c79467so133131cf.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 16:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788218392; cv=none;
        d=google.com; s=arc-20260327;
        b=j587aAsxKVVpeR1UXjl0ouOAKCaIAIHO8Wo92quCpCKBfiy/aEZeYSk0OuUjXgGZqP
         fkcTar91kJw3N0PHRb8h01ZKk2CGqSnEsoc78FidqjDjlxI/BDPXFgrq1KZhiRNnHXks
         YHd2H7WtazyUmbvc24xwYpzAMAr/eNETRPD67ORrFJDXBaNZGRCvTClIFTumsJ6aLtjy
         UK1tG1PhGzHXns6LONLv6hdnTdMEhBwIfk2hQ1ofFr6lzgeavaSvNt9cClwl9dsqp9Ev
         vpJO7O9Df8rsRacq/4YdgFyBXmI5SF+o2bCuRl55uvXAGmvqwiXKv2cv9s6EcNSd3xAd
         AqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zpVrf/9Ez6YwuJe0EFUGtSCTl6wqdMBrnuTW7EDRsDI=;
        fh=ntb3DT78QI9Tu66c1BlyZ0xI6+yG+gCpoHz+wN4EQgM=;
        b=QhHlTM5Kw2ksyMRUQXxUdKFYIA4HdYZK6UK3fHv+ngZk3G+qa1/gsRaCZlDjYRnImK
         W6zNujZxPZlX7eBkWYxwmF1vYdQsJqg8Jmd8vdNMzSbTH8wJdvgsi7yLLAsi3Md9fnBp
         tWG4b9c5v8ozLXHJtfRdbPAe6xeSFrugdWuo6JWzQ2ZJXfMWmKLM+ygCdvMcPl5I1nHK
         LBeevFD8sEQ8zSjQnYLfAPi2dqsDIqnPb/WmZwg9pe9IId6rV4GUIGeRjwZcKPImUnDX
         LMnEmdKMGDKFkWceZt34x1AAfShkDeke9YUPIC4NLmPXGjXdxRSdIeU7ePukfcnOIEqp
         wGcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788218392; x=1788823192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zpVrf/9Ez6YwuJe0EFUGtSCTl6wqdMBrnuTW7EDRsDI=;
        b=Kz8n5QLwWWh0jzSvd1xh5qSdVoqR5eIpciQGFQvGljq/MkP6ulv4HFamcKwNrzQpvZ
         eR/amFREuij/IOGTCN7XGoS30ClElnzjEs5Xpyq39znPRG7ECEBTVmQXbgELpURsr4zh
         dOSNfMoz91LgmJ6y/BRJRsx0JptfjqFh0jc1riK+gfYJSBvPTWNxFgQi9cc10A1PTVzs
         0vmTSWn5x95Zmsc/+0cf+5gqLclvXTbuRfsWGbGobogDi6IfYy3tbc5VLQx8PoXqCJue
         Mo2XYxx0yCo6ARgrqV1hDwoShf8ADbC7y1PTBUjwyHPfWWzy27ThlTiHYI24WhluPlRU
         v0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788218392; x=1788823192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zpVrf/9Ez6YwuJe0EFUGtSCTl6wqdMBrnuTW7EDRsDI=;
        b=KgR0pC1U1W1/cqzxMPL8pswd7JuxRzjNEDAhDepZxrPZEMBWUk8j2N4nU/pHLeDpZZ
         EROUH5BHq8+EXjjCI6vbTespsuDCBMXY79iw1h5ooHKarJx3ManA9zfJqH8FLkNKWQaN
         hkzD08pWi0g+b/eYBal0dqoeFF2VS6BtZ+50ayN07wDGXjMhjWaCXIvshujOD20dw5lv
         zbg70bXlf3g/LagZGYtJkKWKiIQIyUW9VIgDmojfmrv1vY+AGb7Td32pY3jnT8oU3EnT
         Iwk03+v44lUz16m49bV72jNNqafvO5lDT/ygFOq5M7HWbHODeKlRButB+PFDxbnvDbiM
         VO7w==
X-Forwarded-Encrypted: i=1; AHgh+RoZD7eZMPVbcuEvLtsq/6Hw0YImReDlxQf8ejubeiYxqI6fdTaPuv0+0rbkyCcS8/b+l9fdA4s=@vger.kernel.org
X-Gm-Message-State: AFuF++lMei5In2lXfqskvQX3r6JvtZb2PBcdjRjFAbD0NWuw+zR5dbBd
	QgTGXH0R8gy5998LREeMlvZwph23Sl4n98nt9zBes4sIY+99gTWN4CrcTkxDbQSO2hpNNMNyC83
	Gk7BKPmtwz7jWDzPUO3acaH/cqcmTmlHmjjPvkgbE
X-Gm-Gg: AR+sD10fS++YTq6aD9RH/f2utg10D6XEdD/ZD12J6Ibsjjedwq+ldTaCSsz7gTjDCq3
	qrkmTJWQZR1//ukv69FF4RKCS8gWToOqc5K5fUpePPMZ2mKhHf2eZNFYNtVEYZ/BYIaf58Y0XGd
	qve3nzFDz0rUUV4zmOfcZW6NqPUCTJcLxBS3TxdVvu1cSY5cQL7b3qlXVP9iKkSABtZyeyi4AT/
	r4Mu/NMObVs124odASya73H7r9wjqbDqxeCa3cvoGfi8pQDhj6pVtGpZg6Xp61W9fbuGMqlPQrK
	wAhFTKfNGTS2q2RPqyeWokgkwh1hlotJcf2jEpJkNnA=
X-Received: by 2002:a05:622a:1a8f:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-53024b7b7d5mr6356891cf.0.1788218391797; Mon, 31 Aug 2026
 16:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813193433.3318288-1-surenb@google.com> <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
 <apVhzM2501wSiGGg@google.com> <apX_r59k4e-XiI-C@google.com>
In-Reply-To: <apX_r59k4e-XiI-C@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 31 Aug 2026 16:19:39 -0700
X-Gm-Features: AcwNN1WbsxWd5RxMUU7qZ6W1DDnViTQR6rdiBhuB5saanYC5DOsOmY_bHcB3Ii0
Message-ID: <CAJuCfpEDgdC=N8__Ye1xP8rZtUwWrGhKhJ9Qnn0hdV+u5r+hJA@mail.gmail.com>
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

On Mon, Aug 31, 2026 at 3:27=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Mon, Aug 31, 2026 at 11:13:16AM +0000, Alice Ryhl wrote:
> > On Sat, Aug 29, 2026 at 06:56:25PM -0700, Andrew Morton wrote:
> > > On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > v2 version of this patchset [1] was written by Dave Hansen and per =
his
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
> > >     https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@go=
ogle.com
> > >
> > > and a small rusty thing which you might wish to attend to.
> >
> > The binder bug is not actually a bug. When using VM_MIXEDMAP and
> > vm_insert_page(), the vma takes a refcount on the page, so there is no
> > use-after-free even if free_page() is invoked without removing it from
> > the vma.
>
> Exactly! I agree the refcount on the page would prevent the UAF.
>
> However, we should still reject mremap() because this leaves the page in
> limbo since it is not given back to the shrinker and also binder can't
> make use of it anymore. I'll send out a patch to fix this.

Ok. Should that block this series or it will apply over it?

>
> Thanks,
> --
> Carlos Llamas
