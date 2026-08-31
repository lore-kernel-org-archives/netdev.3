Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF537DEBE
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218963; cv=none; b=tIb6tAcfITn6hbp7OOxGR0C74/5tQ6w0RAuP+eT8D+uoP7MUQceUtdXDtw3AvVyiNElWsY33uqIFecZmZwOR5XR3n3EnYmrD7RLKtkhX9tI7xu5xp5DBU2i+rmazdbcyWMuKRUW1+TLrNTEYGGKPOUZz5wPC+x9EhEEVJj6I5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218963; c=relaxed/simple;
	bh=+i2m/TMTDSfo6u7b+++PuDvubIKwXr72/RqiL6m6Dis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9S40lLwpuXPqGVVHLf0Wbo/eLfq4YKn1/Mc5hB1q11mdeiAnq1JIExTYyL2YIyNIqezJ0+eDF/Zs93vnDrSqcMOaoJxymDAE/Z0J1YjofZuWCutiMMpIhuoXQQyj4u/9diHSS6yMAxc+WxgrSwVwz8CZPtSFhEprS1rK3LOplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CoUrpoGr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CoUrpoGr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b445a84fso23065ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788218962; x=1788823762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/n3fvUgG6MbykCjQ/yhTPU59M7rXcCUC3WVx+XsgKas=;
        b=CoUrpoGrLQSGUX080qGjxFrjdRvsrDFUBXmb6ng5+9BHV7xh3Xd+uyrJmG8rCIANEW
         i3YEN7QNpvAcAJcAXLFbqZNCz7YU6FvxfiTaCmVM+nxXu10sDg3IIJxbsLb0tCw3ITgS
         bSaQnAY3ydYnZ9HJLZqTKehabxmR89Dw+TnmHrfS3abOKfm2bxTM8mmY5mB+i1MKp2qL
         NGYvLPppKM+H4+6dSUtnh7WMqED2vR+i4/BZTBbg2O6mGWHYf5+b2NhhvRWy8rwF4IbA
         1+fvphekifp/l7eTBmrPvc6PqbwO/AbPEVR4L076/1yyLnW1hUdJNzyQyVSMgbKT/tVi
         s9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788218962; x=1788823762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/n3fvUgG6MbykCjQ/yhTPU59M7rXcCUC3WVx+XsgKas=;
        b=nOkqfOUR3ctIMH0jfkSBe4xa7H84TA3WLcKL0UaQIt1pXCxh+miZKRBDbZM409is6O
         UcO5MmzXmfvbvojvISYdCs6mlX/5GN781WgRbsGqnPUEgnrYgjgN5XZFOfPCrSjpJJOv
         8ZsZjDkAJSiPzPi8Tv5g5Wg99Ot3R9er/r51i4sNeR+bC9BrG3VwLSbZrsd6vxF1qChD
         3Opsjh9cLVvwhsK2mhLNgTkZRX6ppit8IUPUq2ulH8aiKs+idy735tflJzO2Yj5vu7SG
         KHqd9GzV46D0/yZgo58HKRB1p2+EfcHHfBELHTUdveZNdj48yOtORdcmaTW2auuWewaX
         Y2PA==
X-Forwarded-Encrypted: i=1; AKwUvBwqs0ZG5Vn2LsLmd8/30mzUkl2OgVNIcuSFWb3KRvI3J1hWJM40JzEkjVufNJODbORINnRJNDE=@vger.kernel.org
X-Gm-Message-State: AFuF++mJllNMJIdphjgwj8SIOAF+12wL9lObB7FrxC8Q7mQ03Hy//KF0
	uVJbpd5bsJ3sxmaUX3WxyZYddVmSar4QZ9fRY29j8TS+ofF3pvrvdaO5keUnNsUbkQ==
X-Gm-Gg: AYBFou3JtRueO4C2PfCGDDbHI4wqiPflAlxNCktmcrpw5ogQQQGStBulLNfKKW/mS9x
	Ddia793xCSrw7ipN8QNPveUZFe//1TcrlTTBQmmlw9U+ci8n6TyIpdbNLuzYJyI7x4hu0ZC3P1x
	ifWI1iZjY0Ks06if7fstMIZt/POHnmrah7xVRIaEfbMIBPdGbiwE/UFeCFxsrG/RvDvIQfwuUav
	88wxfgUhVjGuoxD9emZuN65mh+HSFU+5FD04D6XkcLQCKf0yQ595al2D0l9QkBZLIFtpzt98G9q
	WzNDCo6n09/boc7YBXIKSPFtXj1jHvPpFA4NcR5LSs9Uis7q76kEPpLZ9nVQBieqnld6JiHPECB
	1NgCfxpJpA4r3sB5TEgDTKXNAhNfCXrWock+eY/aQ/Q6G9zazRKEVLmhnnLi1iqZZbdLtWoWZPa
	ShCV+USYFar3u6Q7qJoKsTWBqLMeJsLPS8k/SXJuJtWPa+VNUYUOF7nFt7liiJ1LvuixjbwWpP3
	r7d4jaXmSzKhaz7Re9F/WUQ2dV0Kyho6Dl8ELW9Rt9dkBtLsGZiWngLp0skiiVD0ZcEckJUPYgv
	qbmK9VFZ6nFSgG+YRw==
X-Received: by 2002:a17:903:2290:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2d959ba8671mr1247175ad.13.1788218961331;
        Mon, 31 Aug 2026 16:29:21 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be6377472sm154420b3a.19.2026.08.31.16.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 16:29:20 -0700 (PDT)
Date: Mon, 31 Aug 2026 23:29:16 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com,
	ljs@kernel.org, david@redhat.com, willy@infradead.org,
	shakeel.butt@linux.dev, vbabka@kernel.org, jannh@google.com,
	arve@android.com, christian@brauner.io, tkjos@android.com,
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
Message-ID: <apYOTPIBTsuQKUXE@google.com>
References: <20260813193433.3318288-1-surenb@google.com>
 <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
 <apVhzM2501wSiGGg@google.com>
 <apX_r59k4e-XiI-C@google.com>
 <CAJuCfpEDgdC=N8__Ye1xP8rZtUwWrGhKhJ9Qnn0hdV+u5r+hJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEDgdC=N8__Ye1xP8rZtUwWrGhKhJ9Qnn0hdV+u5r+hJA@mail.gmail.com>

On Mon, Aug 31, 2026 at 04:19:39PM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 31, 2026 at 3:27 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Mon, Aug 31, 2026 at 11:13:16AM +0000, Alice Ryhl wrote:
> > > On Sat, Aug 29, 2026 at 06:56:25PM -0700, Andrew Morton wrote:
> > > > On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > > v2 version of this patchset [1] was written by Dave Hansen and per his
> > > > > request, I'm taking over this series.
> > > > >
> > > > > tl;dr: Make per-VMA locks available in all configs. Simplify some
> > > > > of the per-VMA lock users now that they can rely on them being
> > > > > always available.
> > > >
> > > > It's been 2+ weeks so perhaps a refresh-and-remind would be helpful.
> > > >
> > > > But it applies well enough and is adequately reviewed so I put it in
> > > > there for testing, thanks.
> > > >
> > > > AI review might have found a couple of pre-existing binder bugs:
> > > >
> > > >     https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@google.com
> > > >
> > > > and a small rusty thing which you might wish to attend to.
> > >
> > > The binder bug is not actually a bug. When using VM_MIXEDMAP and
> > > vm_insert_page(), the vma takes a refcount on the page, so there is no
> > > use-after-free even if free_page() is invoked without removing it from
> > > the vma.
> >
> > Exactly! I agree the refcount on the page would prevent the UAF.
> >
> > However, we should still reject mremap() because this leaves the page in
> > limbo since it is not given back to the shrinker and also binder can't
> > make use of it anymore. I'll send out a patch to fix this.
> 
> Ok. Should that block this series or it will apply over it?

The issue is pre-exiting and unrelated to this series. So I'll take care
of this separately. Thanks!

