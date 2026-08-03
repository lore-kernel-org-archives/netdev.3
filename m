Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD599342C9E;
	Mon,  3 Aug 2026 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773305; cv=none; b=jQ8wI2My+ktbYO/pLdcOZoUEBCFCyX7xVg+Sm9x+F6umSK2MEg38PcfKPHK7zqhPYmdxycqEdohmgmN+Mt73QwsBkxMZcBgkMOChO/97McDG098TJU2b9qe3eaJ2gKc1DrNiUV3OisfyS2mROwKX5VqLoy0z/qP3yVKF8bI0PIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773305; c=relaxed/simple;
	bh=fIOS9gH/ObXju2U1bijIiFnO6dVMlXGYaTa4UALzk90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6vPXVvrg2XrnEG3nGv8OEEbHeHmQDZMGcCdJnLdhMQ3my5ylhr58RQdVHUCH98n/FHwSwBZKXNTT7xickBOs+DBNb+tpJuiT4hEGEdbduX6cz3/uGmriSuEsdk8iuvyBeVuawlmkX4ApeeqHjoJ6UX8/J/b1kBFytlDgKegWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsMJWp4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsMJWp4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F591F00A3A;
	Mon,  3 Aug 2026 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773300;
	bh=fIOS9gH/ObXju2U1bijIiFnO6dVMlXGYaTa4UALzk90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hsMJWp4MQa4KKnkImO2vc3J60puoTWiFPA78upH/01FXTf9FgZ9BjezvmSMIseSHs
	 NgpFTBGpkgo7K0UDrVJIBOA490xwd1m3RUTOq1Y5ybRJYJ+TBtfXlNzha0nK+gdswc
	 sba3GwHf8IK60VLp+Cj4lnGSWeRlT2yNSV2jAvOZxdxsUpeXeVK03erq7UDgNfnNvi
	 G9tBIROKVnplKVUF6L/CiBQbNJ1QASOwJ5mBuH9krhlJ4ymal3J4jWduEJ0NE+kaYN
	 N9knHGhcOp6AL8PSmtBfcNWGRw3LdyAG6APJq+6g0IWr34aK3ElRM0AIGh52bSUezH
	 Vrelgh0NAVcpw==
Date: Mon, 3 Aug 2026 17:08:01 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm: Make per-VMA locks available universally
Message-ID: <anC1iE21eonDK06n@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-2-surenb@google.com>
 <CAJuCfpGezxdaSme_QpHVq-QVeZAUaF360_Ajvkrn3QqDcSQVog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGezxdaSme_QpHVq-QVeZAUaF360_Ajvkrn3QqDcSQVog@mail.gmail.com>

On Mon, Aug 03, 2026 at 08:24:44AM -0700, Suren Baghdasaryan wrote:
> On Sun, Aug 2, 2026 at 2:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > The per-VMA locks have been around for several years. They've had some
> > bugs worked out of them and have seen quite wide use. However, they
> > are still only available when architectures explicitly enable them.
> > Remove the conditional compilation around the per-VMA locks, making
> > them available on all architectures and configs.
> >
> > The approach up to now seemed to be to add ARCH_SUPPORTS_PER_VMA_LOCK
> > when the architecture started using per-VMA locks in the fault
> > handler. But, contrary to the naming, the Kconfig option does not
> > really indicate whether the architecture supports per-VMA locks or
> > not. It is more of a marker for whether the architecture is likely to
> > benefit from per-VMA locks.
> >
> > To me, the most important thing side-effect of universal availability
> > is letting per-VMA locks be used in SMP=n configs. This lets us use
> > per-VMA locking in all x86 code without fallbacks.
> >
> > Overall, this just generally makes the kernel simpler. Just look at
> > the diffstat. It also opens the door to users that want to use the
> > per-VMA locks in common code. Doing *that* brings additional
> > simplifications.
> >
> > The downside of this is adding some fields to vm_area_struct and
> > mm_struct. There are likely ways to optimize this, especially for
> > things like SMP=n configs. For now, do the simplest thing: use the
> > same implementation everywhere.
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: linux-mm@kvack.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arve Hjønnevåg <arve@android.com>
> > Cc: Todd Kjos <tkjos@android.com>
> > Cc: Christian Brauner <christian@brauner.io>
> > Cc: Carlos Llamas <cmllamas@google.com>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: netdev@vger.kernel.org
> > ---

<snip>

> > -#endif /* CONFIG_PER_VMA_LOCK */
>
> Now that I'm looking closer into this, I think we would break NOMMU
> case because nommu.c does not take VMA write locks at all. So,
> lock_vma_under_rcu() for example would always succeed.

I don't think anything's broken actually.

Per-VMA locks was gated on CONFIG_MMU so nothing there assumes per-VMA flags,
but now you have stuff that happens that didn't before but:

* vm_area_free() -> vma_assert_detached() - fine - it's always detached in nommu.
* vm_area_dup() -> vma_lock_init() - no asserts, just sets refcount to 0 (correct).

AFAICT nothing else.

So seems fine to me?

>
> Extra per_VMA lock-related fields in the vm_area_struct and mm_struct
> would also inflate NOMMU structure sizes without them being used. I'm
> not sure if this is an issue we should consider.

As nommu co-maintainer, no it's not :) I won't have that stuff blocking
important changes for real arches.

Go ahead! :)

--
Cheers, Lorenzo
