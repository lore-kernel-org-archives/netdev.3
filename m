Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266EE2836F;
	Mon,  3 Aug 2026 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768926; cv=none; b=c4mZIMl0fRxnEws6RrP7Oe9S5FsaZXSZw+oc1tVq4u79SFrmDP0SUA6rhdtYBeG2uPXllZdaVJGsqqTaCWTFhnw0N312AqzmQLprTbOkZTZ5Bazfyl2abX3SDawMYIHuDAKN7ed7Nl8VZTzG4WcjqB4P5zpfKPoXaqh2z/LFWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768926; c=relaxed/simple;
	bh=LQRFenfGVdGWI4ZkP8e3z1nTGz3x9mN8ovM9HCiSNk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMhbU8uMHuDxtucKbKU7VjCz7+0YJ56pjjrk8AcdAVzCw5Hyq2HfjenaDmb/rH3Q5rce1gAaJIJcCfwXTmGRCkKztbH8b9FqEiq2wD5QaCsO8em9/giZF5TeDjzMf04V49kKMKMJsDrxCv+Nd3sHmIqgWyNYrHZkLb8/mwgekuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcgONwvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcgONwvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2051F000E9;
	Mon,  3 Aug 2026 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768924;
	bh=CLWRn+sbfaY+h1dVlp8U6vCte2tErJ3uVpTL7g5oiCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JcgONwvu01c+nRbvyrdxyR/XTih9TTeZtuU1TBdj+IzBKo8QzA/bgo0dmMt+FR3M6
	 Dbfb0tnoylmbrqE3GA9P71oEnpMsXzERebZ9M5MiFHybdny4NKhJpq2OHE/o6h8JCL
	 vD26OaW55fbAVlTGAFlh1F35RdwdsAJkWPxKB8eF52ksZnIVKG5FnwLgOh4v0q4nBV
	 cMSdvLiegBtY9ZMwyXw1r5K99tM8CM5UC+Ci4zGvjLDkHS2IP+SpfPrt/gCLVI2oWb
	 m5KC8vKOkQ/pLBOEGg7UZTfuGPhDB/vkvF4aEPuWrq9Oaio27mJcceAt454ZJGiTMk
	 NC4G8CPSXwoSw==
Message-ID: <152ee467-b5e4-470c-ad95-c638aa9986bc@kernel.org>
Date: Mon, 3 Aug 2026 16:55:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm: Add RCU-based VMA lookup helper that waits for
 writers
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org,
 david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev,
 jannh@google.com, aliceryhl@google.com, arve@android.com,
 cmllamas@google.com, christian@brauner.io, tkjos@android.com,
 dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-4-surenb@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSNWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBrZXJuZWwub3JnPsLBsAQTAQoAWhYhBKlA1DSZLC6OmRA9UCJPp+fM
 gqZkBQJqFFy6GxSAAAAAAAQADm1hbnUyLDIuNSsxLjEyLDIsMgIbAwUJGtCBUAULCQgHAwUV
 CgkICwUWAgMBAAIeBQIXgAAKCRAiT6fnzIKmZJIUEADFx/tREzUImHrEwVHeSvDFmA7tJysI
 UVrlvrM09E7GIuzphzv7jYmo8n3ANpCczLEVr4G0syYQdTigaZgv3+FQDIIzhKih1IHhu1Ei
 XHlywNWKnQxxQEUNi5Mwx43wQz5XVw9F1A7gtKBKNtfogO511hAbrzagrYajyQacEJ/+sfhZ
 9Da8ltHIXD8pcYaHUfQgEusCgmEd9+KrUwrTbckFKmYq5chuE6yJ4J0EmWknL096jIE6CnzF
 FRslQ3B1UKDjxVsm1ZHfir5NeWszLkTvGFsddFaWTgh8UycESG6VQzKXjjewXu2pG7YQYRpj
 QKm1W5X2TkwWkXRBZTmfmbhxIUMh3+zf5wQ463rSmDN/8v81tdqBtAW6rH/kzg1GvkaTHXn0
 507yEHFzBksk2viAuIxxr7km8+/KARYLIdGtx30EG8cKzAUZOK6WqxtNCsXUJNrVE8CWrCaD
 icoNu7Fs1c5hmPHdSTnU48ce67449DdnO4neLSNhRiGlMHJgfJUmgrxu/hcYeOZ3haWmEQ2w
 uW1Mh01OHi8QZHCEyAbABrPs9GUgccc/4eYXX9hIgxfSkYzn8f+8NuIFPWl/0uTvjgqU29FQ
 SbzOLxHq9439Ox40G5mS5eZXRGxITYR+6TXvRGI6P/264jvflnr/pDGUttaikU+0W+1uxgKH
 cmYbEc7ATQRbGTU1AQgAn0H6UrFiWcovkh6EXVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQ
 La1PQDUi6j00ChlcR66g9/V0sPIcSutacPKfdKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMh
 FmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCTsTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sf
 bAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZOrIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq
 +aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahKtQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4n
 jQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJksLo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8A
 CgkQIk+n58yCpmS2PA//bqN1LfcotmArgElsa+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKY
 HR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVd
 SXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi
 4U9F/trLten/x7bpphDSnDMKJtITbtzATT1Dq7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O4
 0PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwgBF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O
 2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9YplavCMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/P
 wIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dq
 NcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudLvPA/SK8sKoM01IRxSihev/S/5WLazXB1PGem
 OCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLV
 jXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4pYekxJujNeEDkUlky0Y=
In-Reply-To: <20260802215459.2769283-4-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/2/26 23:54, Suren Baghdasaryan wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> == Background ==
> 
> There are basically two parallel ways to look up a VMA: the
> traditional way, which is protected by mmap_read_lock, and the RCU-based
> per-VMA lock way which is based on RCU and refcounts.
> 
> == Problem ==
> 
> The mmap_lock one is more straightforward to use but it has a big
> disadvantage in that it can not be mixed with page faults since those
> can take mmap_lock for read, which can deadlock when mixed with nested
> page faults and parallel writers.
> For example:
> 
> 	mmap_read_lock(mm);
> 	// Another thread does mmap_write_lock().
> 	// New mmap_lock readers are blocked.
> 	vma = vma_lookup(mm, address);
> 	// This deadlocks on mmap_read_lock() if it faults:
> 	copy_from_user(address);
> 	mmap_read_unlock(mm);
> 
> The per-VMA lock can be mixed with faults, but they can fail and need to
> be able to fall back to the traditional way.
> 
> == Solution ==
> 
> Add a variant of the RCU-based lookup that waits for writers. This is
> basically the same as the existing RCU-based lookup, but on a failure to
> lock it temporarily takes mmap_lock for read and waits for writers
> to finish before locking the VMA, dropping the mmap_lock and returning
> the locked VMA. This has some advantages:

Maybe mention that the helper is called vma_start_read_unlocked()?

> 
>  1. Callers do not need to have a fallback path for when they
>     collide with writers.
>  2. It can be used in contexts where page faults can happen because
>     it can take the mmap_lock for read but never *holds* it.
>  3. Its fast path does not require taking mmap_lock for read.
> 
> Basically, when applied correctly, this approach results in faster
> *and* simpler code.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>  include/linux/mmap_lock.h | 15 +++++++++++----
>  mm/mmap_lock.c            | 29 +++++++++++++++++++++++++++++
>  mm/userfaultfd.c          |  6 ++++--
>  3 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index eb32b482434e..fdd8f5cf5722 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -228,10 +228,12 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
>  }
>  
>  /*
> - * Use only while holding mmap read lock which guarantees that locking will not
> - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> + * Use only while holding mmap read lock which guarantees that vma lock is not
> + * contended (nobody can concurrently write-lock the vma). vma_start_read() should
>   * not be used in such cases because it might fail due to mm_lock_seq overflow.
>   * This functionality is used to obtain vma read lock and drop the mmap read lock.
> + * VMA can't be detached while we are holding mmap lock, therefore in practice this
> + * function can fail only when there are so many readers that vm_refcnt overflows.
>   */
>  static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
>  {
> @@ -247,16 +249,21 @@ static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int
>  }
>  
>  /*
> - * Use only while holding mmap read lock which guarantees that locking will not
> - * fail (nobody can concurrently write-lock the vma). vma_start_read() should
> + * Use only while holding mmap read lock which guarantees that vma lock is not
> + * contended (nobody can concurrently write-lock the vma). vma_start_read() should
>   * not be used in such cases because it might fail due to mm_lock_seq overflow.
>   * This functionality is used to obtain vma read lock and drop the mmap read lock.
> + * VMA can't be detached while we are holding mmap lock, therefore in practice this
> + * function can fail only when there are so many readers that vm_refcnt overflows.
>   */
>  static inline bool vma_start_read_locked(struct vm_area_struct *vma)
>  {
>  	return vma_start_read_locked_nested(vma, 0);
>  }
>  
> +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> +					       unsigned long address);
> +
>  static inline void vma_end_read(struct vm_area_struct *vma)
>  {
>  	vma_refcount_put(vma);
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index e20d01e8d38f..6ff05e68e61b 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -338,6 +338,35 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	return NULL;
>  }
>  
> +/*
> + * Find the VMA covering 'address' and lock it for reading. Waits for writers to
> + * finish if the VMA is being modified. Returns NULL if there is no VMA covering
> + * 'address'.

Hm but it can also return NULL when vm_refcnt overflows, in theory.
Should we also return -EAGAIN (like uffd_lock_vma() below), or just retry in
here and hope for the best? The latter would be simpler for the users.
(AFAICS due to VM_REFCNT_LIMIT we never end up triggering the refcount
saturation)

> + *
> + * Use only in code paths where no mmap_lock and no VMA lock is held.
> + *
> + * The fast path does not take mmap_lock.
> + */
> +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> +					       unsigned long address)
> +{
> +	struct vm_area_struct *vma;
> +
> +	/* Fast path: return stable VMA covering 'address': */
> +	vma = lock_vma_under_rcu(mm, address);
> +	if (vma)
> +		return vma;
> +
> +	/* Slow path: preclude VMA writers by temporarily getting mmap read lock. */
> +	mmap_read_lock(mm);
> +	vma = vma_lookup(mm, address);
> +	if (vma && !vma_start_read_locked(vma))
> +		vma = NULL;
> +	mmap_read_unlock(mm);
> +
> +	return vma;
> +}
> +
>  static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_struct *mm,
>  							    struct vma_iterator *vmi,
>  							    unsigned long from_addr)
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index edd90892f8cc..c3a0c38a3dc3 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -129,8 +129,10 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
>   *
>   * Should be called without holding mmap_lock.
>   *
> - * Return: A locked vma containing @address, -ENOENT if no vma is found, or
> - * -ENOMEM if anon_vma couldn't be allocated.
> + * Return: A locked vma containing @address, -ENOENT if no vma is found,
> + * -ENOMEM if anon_vma couldn't be allocated, or -EAGAIN if vma refcount
> + * overflow happened due to high number of readers and the caller should
> + * retry later.
>   */
>  static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
>  				       unsigned long address)

