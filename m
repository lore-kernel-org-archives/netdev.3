Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D54948876E
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331032; cv=none; b=c7YmZiNgsMfQbGKwnDLF92QIQESrmvD+08gTUDfXMDvyv09k5Ksa6a5Xux9ha5gySvDLMT4MwJKO0hgje4+pUutjMjBXc1T8c/53/+SIxWbJF7yYZUzBnL1Xce84Oks8DqjLyX7JBAqOTDN+AmnHtVuMdU3zqlND89Yo5HKkhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331032; c=relaxed/simple;
	bh=6tP12Y87i05bjXnRUYYPU2Gdo6mBWkEg/IWHRad8HQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnmiNDieIn4Nld2hoy+NNz5wJPi2VKQSuTFAaloS6efMf+zZp3B/SWFc8CmDHhA2ni9XgqGR1cTDX/VyocwBucF3b2wG5CrE8t2Z0PFq31xrgniVvSJJybe1eBuEP3o9titNKgWlS0zwob7Pgryu59ZZH4TdbthSJhH1nqZJ6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ5ZvOR9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ5ZvOR9"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e347638adso960145a91.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785331031; x=1785935831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6tP12Y87i05bjXnRUYYPU2Gdo6mBWkEg/IWHRad8HQg=;
        b=WQ5ZvOR9t4bHgMDCq4FSb9VS8+XZZ6NDqmc7+2c8oeRLUS7JqnLwb2kV4voRxXsqCf
         lnuj7iU/kToZmHjT07AoHm6vifA2r2htqleI9jXVQsYXzYJMoygle7YKz7iSxcHxCPFz
         zZOE2ftvQzy74wDCmJtpcvR6uKr1zHPjOb5JBz6q4j8KUQtSRU5Qmhra27yf4+8Ms0D1
         ZJGBv8eOCsoAYDzB5W2V2UaCnhoqXT5oegObMymBCvlM7zSlvxbRBAcrlTXcxw7QD2xC
         JddfQ0GG1df0ZNWX8ICRAtJVCZJ8hf3c374f/ISDeMQyI6JmjQgWHjMeZMOQBppIfDJe
         BbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331031; x=1785935831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6tP12Y87i05bjXnRUYYPU2Gdo6mBWkEg/IWHRad8HQg=;
        b=JAo2gWywb861b1pO2ldkuUGbMZnBTKOSqEIdRN4/UJJG1iRpiytjpqjnWFnJAPrrSY
         yQR66F1WnUWyOHKT/Lrfxv3OD69iiWsBrW15AkxQKDnGP90fgmZ6gu88L1EAlWvjKQjK
         hH4t7gpV0RRLMdqyCuz/8K9HQ0Zz/ZJ11B8F5QWRVEugZzL9vo7KDJS0zFMU5QQBXc/V
         K7/SNvWGkuca2UpfiElnelQsmdkHdEYryi8Yl6s9jp8RYCHBlt7VUPDiloYvd8M7fRMg
         F3xJ9dXroyuLgyfd9KR73q1FMkgdvkWEK9lVNCuTJr1K/aA3QUorLD0b+0WgMZMU92S/
         zmog==
X-Forwarded-Encrypted: i=1; AHgh+Roz9hKvIt6jwluor5NxlgREtfuydlJ7B74yVNpZUsuB5ftVJMEbXrIfJImZeaXkFODuzdZPWVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HN4n4AEI1F0/DtaXSM5xaGWiWyDh6zy7+NRQFayiCAbc2OXA
	SlT3qujKaHZbCJwtRCBsgPujaVJRM/9E1p4iAbESVPY3pOMetLcvCSSl
X-Gm-Gg: AR+sD112mtbkCT5PwiO/kPpbt91fb4XXzUfrds4aA7fdxLbMOZ3sWbBNyCNgGOWG/Bd
	N5Q1URicTixN6ak3sZntKkXAbYTCwyL7lJk/SOz+5wN6VMX40/7HKxAzFhIIhTgRuFihw1LQzaK
	sguKuhG0IvB8g7HcWnVaRHO1VJBQouai2H3UO/uQ1rrrjxPWx45SwJKrNIUlmB2UYH0hMG1dNkV
	6zD/udV+7D40tVXF9K27FrMGxvBDyObZKbIt/1CGqFzvZyrnjA9IMT2musc2f8hcegXPyh2g3H2
	ZmcXG+h+mYTZhyRy7E+TqkeV3mofn1Fwp1blRLTbWcq7i++KcGVy5XKtHr0Yv81UIiDy3fUhQuB
	rB/5R1klPMPSHMR1an3RfmkNIr+oWSZTVKby/099WQfEkDiah3a7fLzA5Yw0exRkeUdvxb2K0dK
	UiNIyUXiVRATSaqvwatvEVY4YivpwNohplLhRHrqJKTYf7
X-Received: by 2002:a17:90b:270d:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-38f6a41f233mr6226263a91.4.1785331030512;
        Wed, 29 Jul 2026 06:17:10 -0700 (PDT)
Received: from ubuntu.. ([2a09:bac1:7680:1a98::48c:10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504927a7bsm11522373eec.0.2026.07.29.06.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:17:09 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Qiliang Yuan <realwujing@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v11] mm/page_alloc: boost watermarks on atomic allocation failure
Date: Wed, 29 Jul 2026 21:17:01 +0800
Message-ID: <20260729131701.3354724-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <90ac10ff-55f8-4f07-8e1d-bb9f3a8cc546@kernel.org>
References: <20260720-feat-mm-page_alloc-v11-v11-1-7376b02c27b3@gmail.com> <20260720163719.cf37f6be63bfd88a06965761@linux-foundation.org> <90ac10ff-55f8-4f07-8e1d-bb9f3a8cc546@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <realwujing@gmail.com>

Hi Vlastimil, Andrew,

On 7/21/26 17:10, Vlastimil Babka (SUSE) wrote:
> ... on a 4.19 (released in 2018) based kernel. There were many changes to
> this area since then, some for highatomic allocations even very recently.
> So it's necessary to demonstrate the problem exists today as well.
>
> And it shouldn't exist in the form of "logged failures" anyway, thanks to
> commits such as c89cca307b20 ("net: skbuff: sprinkle more __GFP_NOWARN on
> ingress allocs") that use GFP_ATOMIC with __GFP_NOWARN. So it's not about
> avoiding warnings anymore, but preventing fallbacks to non-irq contexts
> (that those allocations AFAIK have) and probably thus rather demonstrating
> how that improves performance and justifies the patch and risks that come
> with it (these heurstics are unfortunately fraught with them).

Agreed, noted, and I won't lean on that log again as evidence for
current mainline behavior.

I also want to walk back the framing a bit, because on reflection
"does this avoid a dropped/warned allocation" isn't quite the right
question - mainline already accepts that a single GFP_ATOMIC failure
in the RX path isn't catastrophic by itself. What I think this patch
actually affects is the *recovery window* after such a failure, and
there's a concrete, unmodified mainline code path that shows it:

virtio_net's try_fill_recv() runs GFP_ATOMIC from NAPI context. If it
can't fully refill the ring, it schedules refill_work, which retries
with GFP_KERNEL (so it can direct reclaim), and if that still comes
up short, backs off and reschedules itself every HZ/2 until it
succeeds. None of that is something we added - it's existing driver
behavior. Unlike the bnxt_en/__GFP_NOWARN log I cited earlier, this
isn't stale: our downstream 4.19-based virtio_net runs this exact
same retry logic (try_fill_recv()/refill_work, GFP_KERNEL, HZ/2
backoff) unchanged from what's in current mainline, so the mechanism
we're observing is the same one that would fire on mainline today.

What we've observed operationally is that under sustained memory
pressure, this retry loop can keep missing for multiple HZ/2 cycles
even with GFP_KERNEL's reclaim capability - the ring stays short of
buffers, and incoming traffic during that window has nowhere to
land. With this patch applied and nothing else changed, the same
retry loop recovers faster: boost_zones_for_atomic() wakes kswapd
and raises its target the moment the first GFP_ATOMIC attempt hits
the slowpath, instead of waiting for kswapd to notice on its own. So
by the time refill_work's GFP_KERNEL attempt (or the next NAPI poll)
runs, there's a better chance the memory is already there.

virtio_net exposes per-queue drop stats via the standard netdev
qstat interface, so this recovery-window effect is something we can
go quantify precisely rather than lean on log messages. I also don't
think a synthetic microbenchmark that just shows "boosting
watermarks lets more atomic allocations through" would tell you
anything you don't already know, so the plan is to measure this
ring-recovery-time effect directly instead.

Qiliang
