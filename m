Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5F41F5CC
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649843; cv=none; b=GzddPXxoEuIuess9uNr/rInWVU0LRgPkE3BgkWMMAhtxRfilMEW/ZiMkTCqlAeFUBwA8sQnWZsZ5fjmRw9ZPEuMpKUn5kQbAT47/JDGUwOt10xDzJbwO4IcFMq1pW3sPFzXxkS/qdqjp8QP7hY75nO+0EVwcNTzzXxIPMFjMudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649843; c=relaxed/simple;
	bh=7KDsoIW3COyeBrde74Ek7CWF7tUBKheY7MGV0TN8se8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWkmSan7Djzr38T5EzZcWeWDWzbMRAPWQ+p2BeoyCYJ8lknhae/61mlTYtsaTXL+YGs8/yFoxJB5cjCTThJuHiqDIEmPju6Xsrb0E1UvvzsDXUegA3nMU0F51OQH+tuqCq/MGzpT3sawyzfX5ODJcG2mmmS56BenBaV0fBB0GSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEUtJ4MZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEUtJ4MZ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso33985ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786649841; x=1787254641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7h40fDSJ6LxR0LhSx+FP2dYCuXb3wJxS0vazqn2AKzg=;
        b=gEUtJ4MZw0GvuBUT6OgK817XngSsIgfRmv6lFi4ruWbOQYgLQZk14hP3kuf2JzK/QH
         ZRKlNTHFGrldvpMr2SyUQG/wrPAfiIG5OjfHlLGn5ovZOwbNKKU0mlbHsGFn8W0pmCLr
         01K6GrAJgpmGArzTksXEV2/p+g0WmAZe41BTz5ySfiDuLwFdK+TLNapxDJiIPTsjW8vj
         pwdwLtwkGexLZfR1H8uKdKuNegcdlOsvbI4CvhbPTWxSAUAjjGLn/yhppNYotOXucfNN
         wT9Eu9kqJVbUCwC1c2lUn6TWuHudc63CrxcQoZB9n48JUnChCc80buoX6RcGqIoI6AA2
         aDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786649841; x=1787254641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7h40fDSJ6LxR0LhSx+FP2dYCuXb3wJxS0vazqn2AKzg=;
        b=puA0akxdi2Kuakk1TCxzLFV/pcwKi1XwXEFjQUirmFItsZtlEVBbvGIqIKjKEvaOsk
         EhaS4L1jjvvzdoilEmOFpoW2eeNvD86l0+yNJjZO7FmavfhkyJP4DpCT2z1h1Ed8KDRV
         /0U9e53NEaSFNA1sTdL+bP+2/WwDD5sJu6cBpEu8+1n2TOAcLmXmrmQkPZCfHwvXBoS4
         clcHhdYWM7l3R8VUAstVL7bldio7tnjw90+2Zg0fyZbhgushClp2iLLYNk9oqCXQZIn5
         3KvMKY4/CF0ZrSK1ByGIjZNDb5Vkca8ZvN4o2H9Cb2Azj7JKYT/bnkbW/8lObNkU+RfE
         /bgw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+GM2ksgGyuFESlqBfi3Dyzwn3FIzp84Yk3RGkifHOp9dLpwzVvTs1hyiZX6gHk7jWRPL4JlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfsVl2PU53BEQhynGNyU5Xo69oNgxGbtPiyIeHkHw1nmp+xLPW
	d5u51OAT0oj2NYpKLYisKu8g2amvPWbvvMC8tkyF/Vh7UQHDJDOcvb5u9QgvJvujww==
X-Gm-Gg: AR+sD11jqeSzBqn44KE0eZOoVrs+N86HqzYd8gaZinyvghSnBPFEsyHirkkNrzE+2qh
	tlUJHmijlbQsCePOyHkA5HP46LL81YG2Do3ZlrAdaKBWo/Fgf+a0Gi/SibWHmN7yPHujOolSe2l
	fz1dCA76JEyrGSG9OlEOXUC7iQCYiXcT8dICj6YAInyrJcFdu9Q1/GCIQblxyTiFFk6T+/uFObG
	3uOcHT+1IYiOPjI71vP7cKZ5E7Wmvbl05QpW/Jw3kzQRylmm0cTgl12A3/ClcyDeav9WxDRepI1
	OjtxDRxYhhbAoIqYC+J+GCVKaxzqrKyZnXqP4YMV2wCU3F5iYPBiMGYA8y8e7MM5hBCwJdZS9JH
	EI+qEeKIYqw/A8tKIzb64yhjTTSVjL8aLVMdNBxfxN7Q3BHzwXq7WShGRjxn1X2sNCiGUlpgfT3
	QiBYVs0BsxuArh6awI9ZeAsDgZn2Wf7oAQInRLH6AxMLTFNIKd3gX/bGY/OwZJRcErRhC9oFgPK
	tofwlTgO73lwu9C92e0yAvEGAtE7HMfTNfbksmcEA0kwT39kR7tn6VpF54/6OIHQvjrCxuaV0++
	DSRajBN8
X-Received: by 2002:a17:903:3c44:b0:2c9:b404:b55 with SMTP id d9443c01a7336-2d3af24f3a9mr2081355ad.6.1786649840834;
        Thu, 13 Aug 2026 12:37:20 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b649975sm80193a91.2.2026.08.13.12.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:37:20 -0700 (PDT)
Date: Thu, 13 Aug 2026 19:37:15 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com,
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org,
	jannh@google.com, aliceryhl@google.com, arve@android.com,
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <an4c64xukV16uN_U@google.com>
References: <20260813193433.3318288-1-surenb@google.com>
 <20260813193433.3318288-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260813193433.3318288-3-surenb@google.com>

On Thu, Aug 13, 2026 at 12:34:30PM -0700, Suren Baghdasaryan wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> it and mmap_read_trylock().
> 
> Long Version:
> 
> == Background ==
> 
> Historically, binder used an mmap_read_trylock() in its shrinker code.
> This ensures that reclaim is not blocked on an mmap_lock. Commit
> 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> support for the per-VMA lock, but left mmap_read_trylock() as a
> fallback.
> 
> This was presumably because the per-VMA locking can fail for several
> reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> to mmap_read_trylock().
> 
> == Problem ==
> 
> The fallback is not worth the complexity here. lock_vma_under_rcu() is
> essentially already a non-blocking trylock. The main reason it fails
> is also the reason mmap_read_trylock() fails: something is holding
> mmap_write_lock().
> 
> The only remedy for a collision with mmap_write_lock() is to wait,
> which this code can not do. So the "fallback" after
> lock_vma_under_rcu() failure is not really a fallback: it is really
> likely to just be retrying in vain. That retry in an of itself isn't
> horrible. But it adds complexity.
> 
> == Solution ==
> 
> Now that per-VMA locks are universally available, lock_vma_under_rcu()
> will not persistently fail. Rely on it alone and simplify the code.
> The removal of the fallback does not affect NOMMU case because binder
> driver depends on CONFIG_MMU.
> 
> While at it we also make the handling of the cases where the original
> binder VMA is gone consistent. There are two cases to consider when
> Binder VMA is gone:
> 1. there is no VMA at that location anymore.
> 2. there is now another unrelated VMA at that location.
> 
> Before this change we handle case 1 by having the shrinker proceed to
> free the page, and just skip the zap_vma_range() call. And we handle
> case 2 by having the shrinker return LRU_SKIP. While either behavior
> is acceptable, we need to handle them in a consistent way. Handle both
> cases by freeing the page without touching the VMA (skipping the
> zap_vma_range()).
> 
> Full disclosure: I originally tried to do this with
> lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> trylock semantics. Claude caught this in a review and suggested the
> approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> I guess.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
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
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---

Thanks,
Acked-by: Carlos Llamas <cmllamas@google.com>
