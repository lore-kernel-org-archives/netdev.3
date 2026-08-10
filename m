Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEEE38758D
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388268; cv=none; b=WCFv+FU4t3/9noWCo1DdbM2zkOQ8eS+NSVypGaTg3yykannwqGaxXbkgnw22rEFrEEssDC9eno6DcZOvI2Hi1CGFC+xQujpj+93BIDrNJb4tnUTOQHv0QmzUYP/ibAzjQnsJVnNo+ZhWdZZIdFwbpM3tm+sw95e/lTePj/qCDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388268; c=relaxed/simple;
	bh=12d/6ewGNujC9HUSogExdbgQR+eqrRrh1/mwtxpRJ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRCt1UVT1/+lXsLdzje3ScDFnDe+TTtTx3czfnC+APsE9PaJ2ThzoExunVBA+57+6k7atNZz+kynnsAqYx05lfE8Y9YbGJYa2qVf32/IvDIpljFNiCKMbOdkpVW3TsE5MIGATABmylYpPdu2g7CxivGc5lxqSGHaz4+xB+CKK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ts/uQXUH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ts/uQXUH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdf36f63dso20965ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786388264; x=1786993064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=srMva8ELPlGiijDY3h4l4HTa6KEy7A4N7csv16dIv1c=;
        b=Ts/uQXUHT/g0ev/J2eK0vIMp9KIoxuEpRFlZsJiAO9ox5R2jPyNpl+1FtGDauYeTxa
         lJhHVAk+Gwyy7cfQ0kBYKG07cYSklqK/sSei4XUksLnQeof9KfrcdTIsMH4Onltbsbfl
         iJJWztSZuh++eotnoNsb++b8cDqWgi8ilXdycPDDNvaPqIi3DUkuFonAK87M46p7aj1e
         5hQovB2bh+A4rBtXP+4IzwAvABdsBidrBlE9g+eC23oRgmoWZJ8EPUyvX8mnvUokCYMa
         ktblQNveFB8+CrOl1PuRxIyh2dOAdtLxkUvHbN7yUqFy4SFmYoZIgq5/7KKz7mJzi/WY
         qF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786388264; x=1786993064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=srMva8ELPlGiijDY3h4l4HTa6KEy7A4N7csv16dIv1c=;
        b=G6ytVhN5dH902hcZc6VH2mWFhDX8UhdVWHE08kG7cO+is+cPkNFTjmhhx7JPcojM05
         0lip2F89MmoVdxXtqh+vYQrBsWANfkiFfxNoCPajJhb9kGuyN5gFNhXKRfJnON9xXFQ7
         LL6ePawyJCdhuZjPWC1SNHQ89Q9mOqMQrVI/G16kCQeruK1n6V6dv0PCMPW4NRnF4pE+
         yVfhdec+Xk5cmWZBtyaqDPuH6JqVEZkS8ckHP5nSs9etOai7qGPFKXwhz4+Dn1tCbbny
         GixyGLmAjkl1xS7ytK5vEIulSmDq3dIXjd7+XtwEeQM9rRyh8ApE06qkorDy+sDOHncr
         L6UQ==
X-Forwarded-Encrypted: i=1; AHgh+Rop/DnaOJDX8paWEDNO/Jab+q4quPAlpqcPzQy+qajE7zoEwq0/a4sIE2xrpIoEKn/tPWP3iD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcLIDUdVDQ43WqEOxWw/w3Db22bBYK0AMiBnDqN0du57jrWhR
	os5RUKcfmSKzRBztY9S3mbOoL0tmUaApBktus3TVXmgI7Q4zS/RYCnhV8i6RfmqjqQ==
X-Gm-Gg: AR+sD13GgccEzBe3GRJ2Neh+ibLMOm5RXsUbEEA9NRim3N3qBUythdN/spAVtFwY4LY
	MTpF0qF8z9/ASoqXXyypKatYnJvlTnmER55gOFxxpPwydRvDXf3mz/OmKQFMcEVeG7o9AmYwf5q
	+4igwthI9RrD9CVaaBXflSlLWlLskx9UntmM4snXHInPXQQslTxGYznWqwqw7P/hb8ZDAogNwjE
	CILsNOyKe70XXcSeqFWRVlC/ds6uYr/a+YmqJJnK6JLXDkPaXU9Km7OcNc1uw/OJldcF+Cq6e/5
	DLcTyr3Ew7eKH0UjeB135KFaOtBciU1dqQKcTUbLrkM+JwHLh1lD/iiUt0hdyZFupSIgeLrmCex
	11gf8O3utqO+jffnQkchuGad8drUeijHcuCEsH0aIx8AlrrtfdJaZkPvDmWHh9+8l5IjfdXrPDP
	MiK7rJrbZekfhWnwiOdodTVqYUc45ivyZ/UWsw/91lP6GBb8uVKjmSxQviH72otA7Ia3/O8j76M
	rCvjdFiFXyxrh7vzGssz+1rLEHOpYb4UyoKSSRo/SrO2NzgNUVa7laDrs4kvCxfYV5d5k03K5fK
	vD01TogB8MeqHN8nhQ==
X-Received: by 2002:a17:902:d081:b0:2d1:1d3d:97c3 with SMTP id d9443c01a7336-2d31088e36bmr1036735ad.13.1786388263842;
        Mon, 10 Aug 2026 11:57:43 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d4050827sm647419a91.2.2026.08.10.11.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:57:43 -0700 (PDT)
Date: Mon, 10 Aug 2026 18:57:38 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	Liam.Howlett@oracle.com, ljs@kernel.org, david@kernel.org,
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org,
	jannh@google.com, aliceryhl@google.com, arve@android.com,
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <anofIoz-0V1imXKk@google.com>
References: <20260806200548.3124802-1-surenb@google.com>
 <20260806200548.3124802-3-surenb@google.com>
 <anoZL76y3WGXMArB@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anoZL76y3WGXMArB@google.com>

On Mon, Aug 10, 2026 at 06:32:15PM +0000, Carlos Llamas wrote:
> On Thu, Aug 06, 2026 at 01:05:45PM -0700, Suren Baghdasaryan wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> > it and mmap_read_trylock().
> > 
> > Long Version:
> > 
> > == Background ==
> > 
> > Historically, binder used an mmap_read_trylock() in its shrinker code.
> > This ensures that reclaim is not blocked on an mmap_lock. Commit
> > 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> > support for the per-VMA lock, but left mmap_read_trylock() as a
> > fallback.
> > 
> > This was presumably because the per-VMA locking can fail for several
> > reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> > to mmap_read_trylock().
> > 
> > == Problem ==
> > 
> > The fallback is not worth the complexity here. lock_vma_under_rcu() is
> > essentially already a non-blocking trylock. The main reason it fails
> > is also the reason mmap_read_trylock() fails: something is holding
> > mmap_write_lock().
> > 
> > The only remedy for a collision with mmap_write_lock() is to wait,
> > which this code can not do. So the "fallback" after
> > lock_vma_under_rcu() failure is not really a fallback: it is really
> > likely to just be retrying in vain. That retry in an of itself isn't
> > horrible. But it adds complexity.
> > 
> > == Solution ==
> > 
> > Now that per-VMA locks are universally available, lock_vma_under_rcu()
> > will not persistently fail. Rely on it alone and simplify the code.
> > The removal of the fallback does not affect NOMMU case because binder
> > driver depends on CONFIG_MMU.
> > 
> > Full disclosure: I originally tried to do this with
> > lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> > trylock semantics. Claude caught this in a review and suggested the
> > approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> > I guess.
> > 
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
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

FWIW, I think we should just simply do the following:

---
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e4488ad86a65..b0b618c1d1da 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	struct vm_area_struct *vma;
 	struct page *page_to_free;
 	unsigned long page_addr;
-	int mm_locked = 0;
 	size_t index;
 
 	if (!mmget_not_zero(mm))
@@ -1153,13 +1152,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 	/* attempt per-vma lock first */
 	vma = lock_vma_under_rcu(mm, page_addr);
-	if (!vma) {
-		/* fall back to mmap_lock */
-		if (!mmap_read_trylock(mm))
-			goto err_mmap_read_lock_failed;
-		mm_locked = 1;
-		vma = vma_lookup(mm, page_addr);
-	}
+	if (!vma)
+		goto err_vma_lock_failed;
 
 	if (!mutex_trylock(&alloc->mutex))
 		goto err_get_alloc_mutex_failed;
@@ -1191,10 +1185,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	}
 
 	mutex_unlock(&alloc->mutex);
-	if (mm_locked)
-		mmap_read_unlock(mm);
-	else
-		vma_end_read(vma);
+	vma_end_read(vma);
 	mmput_async(mm);
 	binder_free_page(page_to_free);
 
@@ -1203,11 +1194,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 err_invalid_vma:
 	mutex_unlock(&alloc->mutex);
 err_get_alloc_mutex_failed:
-	if (mm_locked)
-		mmap_read_unlock(mm);
-	else
-		vma_end_read(vma);
-err_mmap_read_lock_failed:
+	vma_end_read(vma);
+err_vma_lock_failed:
 	mmput_async(mm);
 err_mmget:
 	return LRU_SKIP;
