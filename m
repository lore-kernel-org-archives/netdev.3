Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB968401A3B;
	Mon,  3 Aug 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756827; cv=none; b=tXs0lZEa32Tvzf0nJRL3zJeKip4LaXgq9UQGmAvSxGWVBLGFN8mRZruia/Yy+WF8O/GDfGo3bCTzYGsf/LkFo8My7qFAbuP+wI+vQs4PpjL89juWd/2dos32vSEB6trQ+Wnko50qLnzd1egHMq2f5oPeVTG/YovZ8UcDm3EI/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756827; c=relaxed/simple;
	bh=/ur1xEqHbGZ0ceuGWNKgjy4anQ5eYZYxcoOrfwYu+QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g002lLxFzqPtj+GYCJ/zO2SX9n80AzbVJHHNKUXnaflTanToBGM6llryM4KFvsQ343sYxwxc9WlQI+VBXblANwxR4pGyGr8PPL5w4Rwkz0YfZ1EHEjXq9V5qlHSAlWkrIqpnSy2Pwjz6LEcL+G14O2LdiJZlYxDRgZKMPQW9GFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2MyOcr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2MyOcr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D54A1F00A3A;
	Mon,  3 Aug 2026 11:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785756824;
	bh=6H9ABNKNBGb+nR9gQcw6CuEpHYKBwTuTMP0K2puHypc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g2MyOcr4VptcwBPKSfUuEUFJOvDGMz/hq9+8/Dx9ZuBvLmEDbvhc41skeSqj7ZhDd
	 ewcubfC7s7PxTI/tmYcb9VBPzri7Ya5Mn/ooCE21LLZfHkDBhIifaEGdAeg6otMFmg
	 pmOOGOmTpeiDe+g//7MnlKr+cfZ5F89/c1RW2z2I0ILRlLzeKO6z+RsSDldgb/Akmz
	 CUhQiy4i4yJobHTf8SuggknNCCLeutUCf5dh2ae5RyTPR7VaY3G8x7F7S7hj2ZGhOU
	 wcnPnhL5T0zFhPS1rSTCR3IZlOqWQPLLYa3l9l/yuWxdlusqC10A4QGGRX1dUzPICE
	 41+6Xt9PbgZ1g==
Date: Mon, 3 Aug 2026 12:33:26 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 4/5] binder: Remove mmap_lock fallback
Message-ID: <anB7shWzNHUa4poC@lucifer>
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-5-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260802215459.2769283-5-surenb@google.com>

On Sun, Aug 02, 2026 at 02:54:58PM -0700, Suren Baghdasaryan wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Previously, the per-VMA locking could fail in the face of writers
> which necessitate a fallback to mmap_lock. The new
> vma_start_read_unlocked() will wait for writers instead of failing.
>
> Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM, just a nit below.

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/android/binder/page_range.rs | 19 +++----------------
>  drivers/android/binder_alloc.c       | 17 +++++------------
>  rust/kernel/mm.rs                    | 18 ++++++++++++++++++
>  3 files changed, 26 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
> index e82a5523804f..f7ad88a0d806 100644
> --- a/drivers/android/binder/page_range.rs
> +++ b/drivers/android/binder/page_range.rs
> @@ -439,22 +439,9 @@ unsafe fn use_page_slow(&self, i: usize) -> Result<()> {
>          // workqueue.
>          let mm = MmWithUser::into_mmput_async(self.mm.mmget_not_zero().ok_or(ESRCH)?);
>          {
> -            let vma_read;
> -            let mmap_read;
> -            let vma = if let Some(ret) = mm.lock_vma_under_rcu(vma_addr) {
> -                vma_read = ret;
> -                check_vma(&vma_read, self)
> -            } else {
> -                mmap_read = mm.mmap_read_lock();
> -                mmap_read
> -                    .vma_lookup(vma_addr)
> -                    .and_then(|vma| check_vma(vma, self))
> -            };
> -
> -            match vma {
> -                Some(vma) => vma.vm_insert_page(user_page_addr, &new_page)?,
> -                None => return Err(ESRCH),
> -            }
> +            let vma_read_guard = mm.vma_start_read_unlocked(vma_addr).ok_or(ESRCH)?;
> +            let vma = check_vma(&vma_read_guard, self).ok_or(ESRCH)?;
> +            vma.vm_insert_page(user_page_addr, &new_page)?;
>          }
>
>          let inner = self.lock.lock();
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 84104ba04e30..519dcded19b2 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -259,21 +259,14 @@ static int binder_page_insert(struct binder_alloc *alloc,
>  	struct vm_area_struct *vma;
>  	int ret = -ESRCH;
>
> -	/* attempt per-vma lock first */
> -	vma = lock_vma_under_rcu(mm, addr);
> -	if (vma) {
> -		if (binder_alloc_is_mapped(alloc))
> -			ret = vm_insert_page(vma, addr, page);
> -		vma_end_read(vma);
> +	vma = vma_start_read_unlocked(mm, addr);
> +	if (!vma)
>  		return ret;
> -	}
>
> -	/* fall back to mmap_lock */
> -	mmap_read_lock(mm);
> -	vma = vma_lookup(mm, addr);
> -	if (vma && binder_alloc_is_mapped(alloc))
> +	if (binder_alloc_is_mapped(alloc))
>  		ret = vm_insert_page(vma, addr, page);
> -	mmap_read_unlock(mm);
> +
> +	vma_end_read(vma);

Nice cleanup :)

>
>  	return ret;
>  }
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 2633e704c83d..877fad68be9c 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -190,6 +190,24 @@ pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaReadGuard<'_>> {
>          }
>      }
>
> +    /// Find the VMA covering 'address' and lock it for reading. Waits for writers to finish if the
> +    /// VMA is being modified.

This seems a little inconsistent with the C version's comment, should they not be the same?

> +    #[inline]
> +    pub fn vma_start_read_unlocked(&self, vma_addr: usize) -> Option<VmaReadGuard<'_>> {
> +        // SAFETY: We may invoke `vma_start_read_unlocked` because we know this `mm` has non-zero
> +        // `mm_users`.
> +        let vma = unsafe { bindings::vma_start_read_unlocked(self.as_raw(), vma_addr) };
> +        if vma.is_null() {
> +            return None;
> +        }
> +        Some(VmaReadGuard {
> +            // SAFETY: If `vma_start_read_unlocked` returns a non-null ptr, then it points at a
> +            // valid vma. The vma is stable for as long as the vma read lock is held.
> +            vma: unsafe { VmaRef::from_raw(vma) },
> +            _nts: NotThreadSafe,
> +        })
> +    }
> +
>      /// Lock the mmap read lock.
>      #[inline]
>      pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
> --
> 2.55.0.508.g3f0d502094-goog
>

--
Cheers, Lorenzo
