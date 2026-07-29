Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102031714A
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333640; cv=none; b=O9RXhEMfAMKEjOLI69hXoSV1RMKQbvt1mY1UNb7yBdOUtaQhKvwHQmQ7F9l6+JYsXzEfzf4y8oQy7/MAdHZk8SzBS5yptwcDWD2totS9yIy6NRYwudMa6u/vhTqWQ9tdMRWVFRb2kkQNE/SGnXlRTNCN4P3bZhMl2/871FBCrGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333640; c=relaxed/simple;
	bh=zPUDX8EavNB6kDtnWFabTeX5mOGrsbHzHEtlx4ECyqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjZS2U8ZePdeP7MRMAE6yA0nLWob/OPPKTHw49+M2+y/R/TQf8bTBCZErXRpjS15QaeExUm4spDPDI6qHMAtKKF73WOkFxCVEcmzktUBKOeUP3HTIPShx1quBBH0flFrDJ2arfBJyVcDA1iHs08on0sd3VmJkVY18iLCnyxQscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctPnTpoR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctPnTpoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183E61F00A3F;
	Wed, 29 Jul 2026 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333634;
	bh=3efCrSxEFl4lasQAif6R6Yna8jRKxzEDo/e/UCM1SbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ctPnTpoRow7Ub078I0XSSCqC8iWGCWWRojQwUb+oPXVl3Qc5Ktv5RWjfW66hOnoor
	 aqsG1VVzuOB99gMIwMtbqn07rYG37TyKmF1DTHmiC36VJPUm6sW8SaGgzzQUF5tdgh
	 sR3yHx4vwHcaV29RLlTU9+FiOFgiO5/I0UzryWGobUOV3b/szF3ZAiE8S1iuQXX6pY
	 0Vg16ZklkN21JUo8whUtvsKktSkuj71oq0ktNyx226E2lYdUr9+rqjcvjmiPYlc9wo
	 azc1k1b4mKa6Pd4zs/O+t3z3LWApFsKYbvAP0qHUvqSnvnRUPblBs/vHdTtrQtzrJW
	 4kKwj9GfcXo8g==
Message-ID: <6ddc5919-f001-43ad-8101-d118ad70593f@kernel.org>
Date: Wed, 29 Jul 2026 16:00:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] mm/page_alloc: boost watermarks on atomic allocation
 failure
Content-Language: en-US
To: Jing Wu <realwujing@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org
References: <20260720-feat-mm-page_alloc-v11-v11-1-7376b02c27b3@gmail.com>
 <20260720163719.cf37f6be63bfd88a06965761@linux-foundation.org>
 <90ac10ff-55f8-4f07-8e1d-bb9f3a8cc546@kernel.org>
 <20260729131701.3354724-1-realwujing@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260729131701.3354724-1-realwujing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 15:17, Jing Wu wrote:
> From: Qiliang Yuan <realwujing@gmail.com>
> 
> Hi Vlastimil, Andrew,
> 
> On 7/21/26 17:10, Vlastimil Babka (SUSE) wrote:
>> ... on a 4.19 (released in 2018) based kernel. There were many changes to
>> this area since then, some for highatomic allocations even very recently.
>> So it's necessary to demonstrate the problem exists today as well.
>>
>> And it shouldn't exist in the form of "logged failures" anyway, thanks to
>> commits such as c89cca307b20 ("net: skbuff: sprinkle more __GFP_NOWARN on
>> ingress allocs") that use GFP_ATOMIC with __GFP_NOWARN. So it's not about
>> avoiding warnings anymore, but preventing fallbacks to non-irq contexts
>> (that those allocations AFAIK have) and probably thus rather demonstrating
>> how that improves performance and justifies the patch and risks that come
>> with it (these heurstics are unfortunately fraught with them).
> 
> Agreed, noted, and I won't lean on that log again as evidence for
> current mainline behavior.
> 
> I also want to walk back the framing a bit, because on reflection
> "does this avoid a dropped/warned allocation" isn't quite the right
> question - mainline already accepts that a single GFP_ATOMIC failure
> in the RX path isn't catastrophic by itself. What I think this patch
> actually affects is the *recovery window* after such a failure, and
> there's a concrete, unmodified mainline code path that shows it:
> 
> virtio_net's try_fill_recv() runs GFP_ATOMIC from NAPI context. If it
> can't fully refill the ring, it schedules refill_work, which retries
> with GFP_KERNEL (so it can direct reclaim), and if that still comes
> up short, backs off and reschedules itself every HZ/2 until it

GFP_KERNEL can't really come up short in practice, at least for non-costly
orders, which are considered "too small to fail". I don't see immediately
what order is being allocated there.
It might perhaps be looping inside the allocator without success if it has
trouble reclaiming. Which usually means the userspace workload is
overloading the system.

> succeeds. None of that is something we added - it's existing driver
> behavior. Unlike the bnxt_en/__GFP_NOWARN log I cited earlier, this
> isn't stale: our downstream 4.19-based virtio_net runs this exact
> same retry logic (try_fill_recv()/refill_work, GFP_KERNEL, HZ/2
> backoff) unchanged from what's in current mainline, so the mechanism
> we're observing is the same one that would fire on mainline today.
> 
> What we've observed operationally is that under sustained memory
> pressure, this retry loop can keep missing for multiple HZ/2 cycles
> even with GFP_KERNEL's reclaim capability - the ring stays short of
> buffers, and incoming traffic during that window has nowhere to

So is it looping in the page allocator or returning failures with
GFP_KERNEL? I guess the former otherwise there would be allocation warnings.
Note that why this happens can be also 4.19-specific and not applicable today.

> land. With this patch applied and nothing else changed, the same
> retry loop recovers faster: boost_zones_for_atomic() wakes kswapd
> and raises its target the moment the first GFP_ATOMIC attempt hits
> the slowpath, instead of waiting for kswapd to notice on its own. So
> by the time refill_work's GFP_KERNEL attempt (or the next NAPI poll)
> runs, there's a better chance the memory is already there.

If kswapd can save the day by being woken up earlier, then it doesn't sound
like there's nothing to reclaim. But then it's puzzling me why the
GFP_KERNEL attempts wouldn't work smoothly enough too.

> virtio_net exposes per-queue drop stats via the standard netdev
> qstat interface, so this recovery-window effect is something we can
> go quantify precisely rather than lean on log messages. I also don't

Great, especially with a realistic workload. However I'd still worry that
we're working around some old and long time fixed allocator deficiency from
4.19, unless it's demonstrated on mainline.

> think a synthetic microbenchmark that just shows "boosting
> watermarks lets more atomic allocations through" would tell you
> anything you don't already know, so the plan is to measure this
> ring-recovery-time effect directly instead.

Ack.

> Qiliang

