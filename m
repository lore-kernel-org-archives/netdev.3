Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653638331C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208954; cv=pass; b=MxPRAyjJTl7GD1XfxyTmuuM7WhtsaYnaZNq22D7TopmV2/jPdDMIQL6UEHLHu55AVgk1Gb4thdvD7PjN9Yej03s34jeHSauxDCViSIGGUZpfAnenYcpoGOKI1Mfhv9gnLTHTQAnrhjQf9g+utfZdizDN5YKgHpMlUpwrA1zt+fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208954; c=relaxed/simple;
	bh=+2DRX6ohVfpMYN+TbDH2bvn8pp0/0YyztZkOYdll8xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvsPOSjMywwAqoV8wmYNZI3E4Cg0fkEgByIyreYMs3i/SgopaN+j1JDkTO0uHZYcJ4Jd/qJm8whGv8H0doqJZJ6EEzQa/cog1oHOUWFPMTQOjW/k76D2T6I2XBB+crZHqJTBWReoDLYjYp9kpSliwiPH0bdzbaGB6zyv0ob7JJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tt5EA0Fr; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tt5EA0Fr"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c01c79467so88781cf.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788208951; cv=none;
        d=google.com; s=arc-20260327;
        b=eK5r6X4sEXQ3LXb91MbpTLPK5BdUIOmT8aq3r+EDmLtVzz6jzugHLA3+YblBzruQYs
         7DLIBupj4OmJsFqSVlt9/7SnSyBV/pZ5T7KKWiKb8EVqWBy415tXkFlgU+7Ki8zH8PcR
         8taLO0dRK7XN4VPpw0M6o0Hahrb5DLKwv4L5oEphPeEAeoRH4qPFMhE6/CyWil8Nbi63
         iWtZVmhS2zxnu6I+3ZywSr222o02YtivDy+YciJr5lnssj9lNQpePiX/QZMcrqWKqYDw
         lKcrKU46OX59cIAUNlGuXV9Rp3bJ92icCsTqGXkLeU3R88EJ9sj5KXFHYyTmxNT/HmgS
         pWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3jezNBELpt51SbHBtmRmjdqZRoyOEfGekJU8Ocm74OA=;
        fh=/13xsfn0Rj99Lo81XowRAZW/ZFcAOlyXW750MFC942U=;
        b=Og7Gs+d74X8u37uBRC36BuU1Eofz7HVmgOV9BNKv+sgY/h8hCUN5H3dtqx5es5btUL
         ZEJsZsj2kmBd+HmZUw9R34Q0zWUaFF9bF90U8EelEYpv2UmVUXg27svASo3RiQpTIqS/
         Sy62kQyPH7waYtJDYgahT56IY6DYhjdxWvZml3oe+hHODgDI2M5VyiZILKFptkcr4JoA
         WrnstIR/sWKSvJGE7mbadtUXhXLakj0jqU/rktPpeSkAhhT8ltAbRSl3ECO5/DkHa/re
         8WcdTEyAs7G/t5ze3hP3hyqkkh4FxTy8MdQiqA9Y5Dg2Mvd0oO4I0uos0tpKlGlaRe9O
         XDSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788208951; x=1788813751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3jezNBELpt51SbHBtmRmjdqZRoyOEfGekJU8Ocm74OA=;
        b=tt5EA0FrN7ShiKi1GBTTpImsdTxbTcdQpNwBVV46uHIWDXiuTYaSw1bFcN0CNy0/K7
         c4Ld6uoPLa6pqaSShWXJ3KWwM/2gThMInvDzP0nl0DVCjY7eiAsTw4Nw4FNdCvouAans
         oEVvBW2ookiW3TxzSKe1+NVCCuzTriaYc1OZA07Zxf078DKwpSnpVi1KPDu8qC1Pu3qE
         HDHfzY1US4HgTG1GhwWN1Jt2j3GMM5Vk7o1iHLZ3fs7x+vNJWAWQ2bpv4rDeU8fhh7K+
         8bV9AKvOVR9FswIjaXQsXtTq4jgCuTykUrr3w7Eoo4nCC9g8X8ttbDXKCKA+LXio25fN
         JEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788208951; x=1788813751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jezNBELpt51SbHBtmRmjdqZRoyOEfGekJU8Ocm74OA=;
        b=gYMi3395f/kggS5Tr6NINwTi34bt506r0HIuks++BI5dXMzdoMLM/vz/kToAem8zMX
         cOSgI/iadd+wyjzQBHPRUhzEt+340T3qbUtDYOK8NVvjSCmmAtYNouql+rZzMmbePXKk
         FevAazUGnQXA20XEdg+obq84eGG7Kd4eWMptFg4T1/qId4O8iLDjhXSmx9TJruW1tMUJ
         3vtb8og+OeLmGgZe8K/pdymLJZBbz34lIWJQWjQbk/doQ3u9E9oRJAOIOY1pHD2xYUeV
         0QFPBUQKng9+SRJ0WJY/en5QuDT3OFvX5eNGe64ELP2ougotZmWKthxCCHGfKRspg4sW
         +Z9g==
X-Forwarded-Encrypted: i=1; AHgh+Rp8SG8WGVLqd/q+f2khteUZYWq+xLGqzuV2eYzRr1K5D2tVUxx3zRF7qyaT9Qx+nCsvRyzogls=@vger.kernel.org
X-Gm-Message-State: AFuF++k9UjLBzSqDVDBCllqogKUjetiEKGH/zFPdnV0hpV2mDV2C8iCD
	hBZd1JNaQ/a81u7Kh0OdqN95deTSHIYBnt483N5rgXwSeDcgr7qiJ36dPdG9khSnuJMX/AxMF6Z
	ju2guFyKV19OIA+kwSlCMb6k6BCX492PXC9aE7HSv
X-Gm-Gg: AR+sD13d1K15yZ5a1oJtlMZDZjEyxgE0Di2qg1szV13jsVND/SSzxMv7V6yus538js0
	bbuGOm1mMCERupJOYSLUgTOFxxdPVyKdgboUdVYHjUVTjgJf9E5xruca6tdhfLvxa1PDCROMgGT
	BztdOQXD5FY3IT9nvgASBNmV8WIG8ynJOOBdE4cpUjcM3c92Jfc2nwYPBOrPGW081DDljSl2T69
	JvlgmvbOmJDMqUDa/hmwLiumgwcK4yJt9BqJWnJIwUY1HJivzIngi6b3vcNJRbsg6N+NStvNvyy
	6EqNsCr1lt7hXU61/a0rDZU7wTf993Ioq+qtW3oiAJU=
X-Received: by 2002:a05:622a:229c:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-53024d4656cmr4002881cf.4.1788208950057; Mon, 31 Aug 2026
 13:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813193433.3318288-1-surenb@google.com> <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
 <apVhzM2501wSiGGg@google.com>
In-Reply-To: <apVhzM2501wSiGGg@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 31 Aug 2026 13:42:19 -0700
X-Gm-Features: AcwNN1Va5-U2p_HBt_SoCk7IUhZqXMl0RB6eAwv2hmO5Zse_aoEhwTkiwxqTQpI
Message-ID: <CAJuCfpFLwkYWAsK8GrHwmHT06egrMmNaKYU+WY=5Qc+HnacWxA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 4:13=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Sat, Aug 29, 2026 at 06:56:25PM -0700, Andrew Morton wrote:
> > On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > v2 version of this patchset [1] was written by Dave Hansen and per hi=
s
> > > request, I'm taking over this series.
> > >
> > > tl;dr: Make per-VMA locks available in all configs. Simplify some
> > > of the per-VMA lock users now that they can rely on them being
> > > always available.
> >
> > It's been 2+ weeks so perhaps a refresh-and-remind would be helpful.
> >
> > But it applies well enough and is adequately reviewed so I put it in
> > there for testing, thanks.
> >
> > AI review might have found a couple of pre-existing binder bugs:
> >
> >       https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@go=
ogle.com
> >
> > and a small rusty thing which you might wish to attend to.
>
> The binder bug is not actually a bug. When using VM_MIXEDMAP and
> vm_insert_page(), the vma takes a refcount on the page, so there is no
> use-after-free even if free_page() is invoked without removing it from
> the vma.
>
> Adding an INVARIANT: comment to the Rust code SGTM.

Posted v7 with these fixups at:
https://lore.kernel.org/all/20260831203056.838265-1-surenb@google.com/
Thanks!
>
> Alice
