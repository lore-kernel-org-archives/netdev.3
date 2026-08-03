Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEAD37E2EC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750504; cv=none; b=mnjDYv92T5PFz2l5rMV4lkuoBmLOdRsyS7OwV63xIh0QanYqfJ1Rx+yAnj6gqvMZnYZjZ/C9vDfS6V3ueO3yQqy8WlE4zoe5PH0qX7j+2AXgLotlQYyzM4sNafTh83I5I7qFHZjkuhx20TsGwqjc7HyxBwKzsHRWU4h89cr3Xz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750504; c=relaxed/simple;
	bh=28jkTNwKXjpQpMBWhkJP+Sp6osKrHCBLOjzx6P1aFfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ob36mZ7HuX48djEllGwuhPmUHT0uSUA9iJqLYx9ITCkMaL6PjbNm67HBhU1roIAIRCXmpEGy+i4qCeGnY+N9frhXsMjezZE/1ll15ihs51ETzIvm4T4Jcd/FqZshUHHP995jIsJu22rREC3EEKwZ1dG16Sdjs36f9LzAhbC2iHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBvefgwB; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBvefgwB"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495569acf8dso12689965e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785750501; x=1786355301; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wgBz2SZWInGYkxeV698PRx7vfdGy6WMbWCS7qMcdi/k=;
        b=OBvefgwBbMNRyCwephLkb7d9fRcneDqNrnxz/TpdQb8NMEGKxHrRqky88CKdOp/wrx
         /hoMmZSppcPdcC1HlE5a7HLNt/3IM6bQLZjb+ZjMWMnecpGk9MLedAjpLCmyRy+T7Gkj
         CpZ7vJYp8wg6/AaVDoYPSMuJL/bJIPDba563Rh0a1/lqt50yKoPhYQGHwNveZxrq+YZb
         WoQv536e56em62/F8c5Yh2XpxNxwZtLT9xfcMDEvZYmiOBrPaW2+Jad4QsGvwBYPSkPl
         mG8aEKxzGyAOS7ExIyyoU7amM2X/60lhLEecuPAOZYFfzgWAg120p9vuIjuYePW3q4tR
         AKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785750501; x=1786355301;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgBz2SZWInGYkxeV698PRx7vfdGy6WMbWCS7qMcdi/k=;
        b=mDzDHFZUyekp9a/HyvPmxwQBltADwdsE5uq+/Yrj2SLIuyXPJM6D23cREy5Mcc0EY4
         GfTL7ilq02yWtsfPWBwWtwzzpg4famXTHO6Z1KEVIvkFRKoyt0yqOU+lnEP4Nw/vnVA3
         ZrnI4vrLF26mOSxpTPFtguAGALvLls3Z7i8K4Xf6U8X/esbvhtrZuimStMzxM2dZqJOa
         qjRJMbClxhAbNrzmFc/0QFGyo/OWmgkAHbiGrA9YXuYblJMAsOL/V9O/V8YLfr7qsDjt
         GqxZMTzSZ5pKVWJCUL5anoYcZoDa8u8jeukVDVRxjBQ1gNOg3te12iBcirRaKivcJ/qz
         gfVg==
X-Forwarded-Encrypted: i=1; AHgh+RrfEBSQXUfNNaNTwMAIic4NAR0czvJeyyw4wm+tjKy5yskx+NbsAIgpjIaXT/ar7WwwByfcP9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnqbMLwdsQmZO65jXL3QSZMWL/atelUKA+9fCrlD1iamv1cAM
	std0bG1WrFYMchgbsYGzLl+m46bfqh1ReMBCmXA0Bg+OdOWaY7jbl0qWxWhan7yprM3ICvFCfhT
	B1PdhniwXumERFL5jqA==
X-Received: from wmsu12-n2.prod.google.com ([2002:a05:600c:c3cc:20b0:495:6d4c:6fea])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f89:b0:493:cfe8:5b36 with SMTP id 5b1f17b1804b1-4980c66d7c6mr159543425e9.8.1785750500288;
 Mon, 03 Aug 2026 02:48:20 -0700 (PDT)
Date: Mon, 3 Aug 2026 09:48:19 +0000
In-Reply-To: <20260802215459.2769283-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-3-surenb@google.com>
Message-ID: <anBj40CVAhcGMnQ4@google.com>
Subject: Re: [PATCH v3 2/5] binder: Make shrinker rely solely on per-VMA lock
From: Alice Ryhl <aliceryhl@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 02, 2026 at 02:54:56PM -0700, Suren Baghdasaryan wrote:
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
> 
> Full disclosure: I originally tried to do this with
> lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> trylock semantics. Claude caught this in a review and suggested the
> approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> I guess.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
