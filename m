Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81249359A6D;
	Fri, 12 Jun 2026 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278877; cv=none; b=axyEgoXzxvj+BGZNHIZ1EviCx7wWR7yqqSq+XMEw3vwufxyP9EnLapuPE0fpsBSX/XHeYIj/d+uWVvcuqGjw9C79xM7K+GzaGbf+/S0SRDcg1Ku3nDkWTAChi7WCTkTcWqTwaTyAqtdsoLovtfEintC698Neno1GpWJTIhEHMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278877; c=relaxed/simple;
	bh=XNeFapLF8+/RBPA/ZVCtmibPU0fq4KCsCNrJOE9rfNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUlcvTZRGzbvPn95cSlHSqGZTv8BRtEwkCjXp6yagsvmsy44sBzmQ3+TX8lYtf/Rg5eoxYWNCMNLvpivXGdAMS3+VzBk+Id/EFWQPdIfMvbeEbsqA1t4xp0hi66zL+18bupNXAO1sXKV8ThnIcL2QzkwT9ieT38O86jzTaFIk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed2AGfRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed2AGfRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9A11F000E9;
	Fri, 12 Jun 2026 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781278876;
	bh=Ja63WZ46rzJ67VfjbHNx4bPZEFzgcU5OVzx2QaMxKAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ed2AGfRby4X4kInzQ78MD/8c54OnWZDqulxwLeAlsEFvtUwq5htPe+d9+nanp71eg
	 AUfM+2++iuzjs4iHMi3lcfg1c4ZEteQOUUC33m6X28zClZLokLo0TX5lZHhQuqtWqH
	 BYG6wF6YBxJorQtLg49geldHGxJ079q5MW9kY+szGITSxWstZfWhjK16IpSPhsNitL
	 6zfoYgsgOYHh7ytOkXv72GFdVcskiwzubsfqSTaIJkdZBBSu/gxaIzbg77nc+lsPPQ
	 JC6jiTCwQNB0k5j2ccHfXboYBs2lx250MwE5A98//hlLJmkMou7z8/iPl6WZxb15EA
	 tZGVgC0U20dnw==
Message-ID: <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org>
Date: Fri, 12 Jun 2026 17:41:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOl?=
 =?UTF-8?Q?g?= <arve@android.com>, Carlos Llamas <cmllamas@google.com>,
 Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org,
 Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230413.D68967BC@davehans-spike.ostc.intel.com>
 <aipphZ5iCnbXVNSR@google.com>
 <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/11/26 21:59, Suren Baghdasaryan wrote:
> On Thu, Jun 11, 2026 at 12:53 AM Alice Ryhl <aliceryhl@google.com> wrote:
>>
>> >  b/drivers/android/binder_alloc.c |   26 +++++++++-----------------
>> >  1 file changed, 9 insertions(+), 17 deletions(-)
>> >
>> > diff -puN drivers/android/binder_alloc.c~binder-try-vma-lock drivers/android/binder_alloc.c
>> > --- a/drivers/android/binder_alloc.c~binder-try-vma-lock      2026-06-10 15:57:55.274412018 -0700
>> > +++ b/drivers/android/binder_alloc.c  2026-06-10 15:57:55.277412124 -0700
>> > @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(s
>> >       struct vm_area_struct *vma;
>> >       struct page *page_to_free;
>> >       unsigned long page_addr;
>> > -     int mm_locked = 0;
>> >       size_t index;
>> >
>> >       if (!mmget_not_zero(mm))
>> > @@ -1151,15 +1150,12 @@ enum lru_status binder_alloc_free_page(s
>> >       index = mdata->page_index;
>> >       page_addr = alloc->vm_start + index * PAGE_SIZE;
>> >
>> > -     /* attempt per-vma lock first */
>> > +     /*
>> > +      * Attempt per-vma lock. This is essentially a
>> > +      * "trylock". It can fail even if the VMA exists
>> > +      * for 'page_addr'.
>> > +      */
>> >       vma = lock_vma_under_rcu(mm, page_addr);
>> > -     if (!vma) {
>> > -             /* fall back to mmap_lock */
>> > -             if (!mmap_read_trylock(mm))
>> > -                     goto err_mmap_read_lock_failed;
>> > -             mm_locked = 1;
>> > -             vma = vma_lookup(mm, page_addr);
>> > -     }
>> >
>> >       if (!mutex_trylock(&alloc->mutex))
>> >               goto err_get_alloc_mutex_failed;
>> > @@ -1188,13 +1184,11 @@ enum lru_status binder_alloc_free_page(s
>> >               zap_vma_range(vma, page_addr, PAGE_SIZE);
>> >
>> >               trace_binder_unmap_user_end(alloc, index);
>> > +
>> > +             vma_end_read(vma);
>> >       }
>> >
>> >       mutex_unlock(&alloc->mutex);
>> > -     if (mm_locked)
>> > -             mmap_read_unlock(mm);
>> > -     else
>> > -             vma_end_read(vma);
>> >       mmput_async(mm);
>> >       binder_free_page(page_to_free);
>> >
>> > @@ -1203,11 +1197,9 @@ enum lru_status binder_alloc_free_page(s
>> >  err_invalid_vma:
>> >       mutex_unlock(&alloc->mutex);
>> >  err_get_alloc_mutex_failed:
>> > -     if (mm_locked)
>> > -             mmap_read_unlock(mm);
>> > -     else
>> > +     if (vma)
>> >               vma_end_read(vma);
>> > -err_mmap_read_lock_failed:
>> > +err_vma_lock_failed:

This label is unused btw, which is related to Alice's point.

>> >       mmput_async(mm);
>>
>> If the vma lookup fails because the mmap write lock is held, but the vma
>> actually exists (has not been unmapped), then this code might "successfully"
>> remove the page without invoking zap_vma_range(). This means that the
>> page does not actually get freed and will just hang around forever until
>> the process owning the vma exits or Binder needs this page and maps a
>> new page on top of the page.
> 
> Yeah, I think if lock_vma_under_rcu() returns NULL you just need to
> jump to err_mmap_read_lock_failed, like we currently do if
> mmap_read_trylock() fails.

I don't think that will be enough as well, as the current code AFAICS does
something meaninfgul when mmap_read_trylock() suceeds but vma_lookup returns
NULL because there's no vma at that address. Now we would just assume the
trylock failed even if the reason was that vma lookup found nothing for the
address. The problem is that lock_vma_under_rcu() can't distinguish those
two outcomes, so we would need something that does?
