Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA1C3AC0E9;
	Tue,  4 Aug 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833815; cv=none; b=W5cqJCTc06ggBoCYDruifdBkk8lNgFQ6CKID2Q5ktlOoXxEhOmBF+k8dJ8CST9a0Hix1pnEFvvtuoJa0Bwg1ji/Wzoyl+IlKBCeUjITJmOGXp4rmFjTzB8pM0H+bHZtZ/Fh1K/m0qRtyBiZWkkJYei3hw6sM6Lb/TRZeYkTryzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833815; c=relaxed/simple;
	bh=ubXfL0rzbSyg6V2JnF/YC54T0gsZzcZX8CNA/0rAIKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRBomMJ/upo976O40Ss/yBRJXDlE8NpP23rthsXcEeY6j47MCvY2trqM3Ip0FEEMMXyppGGcID7GeUe3KFdVMMTb8w/430JApAefXV4sqqhV7L15o1EjU1hbMHZ7hRiXb8V4JJj2L0w1dZGdlo4BjtLEeaLn491NNLWuBXFhVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I91AfSWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I91AfSWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661511F000E9;
	Tue,  4 Aug 2026 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785833813;
	bh=77k8mska7791WRTBcjbz7kzkZl1qe52YABFJt536kjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I91AfSWqbeSgI3mhe7mPgsKw5R1AMrTbEzVmLrSjQQbMLVR2u7VRFhRz7z94eKW19
	 yFGexphgqj8s4pNulwCW99infoxMJ9Y1mkuC1GgEta0Do/lZ9ASe0GfzRJksc0tIUs
	 BZCYTMl+kHPw6U8/UgEbl3l2OMo4o7gVOuNZgDed67OLQSdd+/tnFGtgQJygNrN9hR
	 b2Y/U3OKEEMAbELFZcxI3tvO49pTj4/QP963KBTDDmraT9O9gMktJyLzdTVqr0yByQ
	 OfIe9eTmQ9XLeV7ZmvTglhZfrObUmx1MZqDKCqqvFNAt63N1CjP/B7e/qQlWyaFJmS
	 9cWVSW3jaDHqA==
Date: Tue, 4 Aug 2026 09:56:34 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm: Make per-VMA locks available universally
Message-ID: <anGnOHgOd1q1jYXK@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-2-surenb@google.com>
 <CAJuCfpGezxdaSme_QpHVq-QVeZAUaF360_Ajvkrn3QqDcSQVog@mail.gmail.com>
 <anC1iE21eonDK06n@lucifer>
 <CAG48ez1=_O0g7rArdpoVwg84jOJuELEAXu5sw=TO_CWBsK=T7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1=_O0g7rArdpoVwg84jOJuELEAXu5sw=TO_CWBsK=T7w@mail.gmail.com>

On Mon, Aug 03, 2026 at 11:12:01PM +0200, Jann Horn wrote:
> On Mon, Aug 3, 2026 at 6:08 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > On Mon, Aug 03, 2026 at 08:24:44AM -0700, Suren Baghdasaryan wrote:
> > > On Sun, Aug 2, 2026 at 2:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > -#endif /* CONFIG_PER_VMA_LOCK */
> > >
> > > Now that I'm looking closer into this, I think we would break NOMMU
> > > case because nommu.c does not take VMA write locks at all. So,
> > > lock_vma_under_rcu() for example would always succeed.
> >
> > I don't think anything's broken actually.
> >
> > Per-VMA locks was gated on CONFIG_MMU so nothing there assumes per-VMA flags,
> > but now you have stuff that happens that didn't before but:
> >
> > * vm_area_free() -> vma_assert_detached() - fine - it's always detached in nommu.
>
> I don't think that's true, AFAICS vma_mark_attached() is called from
> vma_iter_store_new() which is called from the nommu version of
> do_mmap(). But I think you're right that one blunt workaround for this
> would be to add a hack that prevents ever marking VMAs in nommu as
> attached...

Thanks Jann, though also ugh god at that :)

(Really the ideal solution for nommu would be a 'virtual' MMU with noops for
everything IMO.)

Anyway, I think we could fix this with a:

static inline void vma_mark_attached(struct vm_area_struct *vma)
{
+	if (!IS_ENBLED(CONFIG_MMU))
+		return;

	vma_assert_write_locked(vma);
	vma_assert_detached(vma);
	refcount_set_release(&vma->vm_refcnt, 1);
}

Here?

>
> > * vm_area_dup() -> vma_lock_init() - no asserts, just sets refcount to 0 (correct).

--
Cheers, Lorenzo
