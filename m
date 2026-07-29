Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1D14399FF
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362789; cv=none; b=V//nRiS/kSBez1bxIv+qT4c43e2QHgJx8NHFL+BhPLxpgpruVCzebbJoLHtRnlWoyqU2Pu7CzRwJ/oxVFGAKVUaAKUH+X7/KTMqAPjGGMC+CgstS8y0vm6NyYDQ6kSZb3vuwj3uV5luDQfkac74jNRihdUUcLHc4b1f41Fntiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362789; c=relaxed/simple;
	bh=bdk7lMS+Lep0YKho1RtnTfHyn3IFIU/nnkvv4fPKjII=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MDbUkgjNTFku5nzDlapuU99ojgKFC9PonXDsI8osqoDUXCrN5jrD9fXInisJ7l7zYvhWPaeT5zj+UbeggfkGsImQC93eklN0QVdSDgYzmQIuuG3gw+sipKrG2ftdVeFz1ozIuzV/arRduAb+7G8oP2CYh8msJSKNqdjiIOJNKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=msBlxX2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="msBlxX2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905401F000E9;
	Wed, 29 Jul 2026 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785362781;
	bh=ATTw859Gg3zuAdifQ00tcJbnF2HfpI7aClAv6SCcxUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=msBlxX2c5tI9BPwZ57G1PEv9Wmfd5AeoBrTFmKCEuVtGP9O/3dCroPI0Fgi3o75Z2
	 UPcQHwKtSRaDIC8bT7VGa2JIP+QddhOGgY2ozuDbXFF/i+BzPKQYlWsUvs5LGlcvMU
	 RlqHJRF7H7FJDC6KN3bn2e3NlrNgr1UMB/WA2lYo=
Date: Wed, 29 Jul 2026 15:06:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Jing Wu <realwujing@gmail.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, Brendan Jackman <jackmanb@google.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Lance Yang
 <lance.yang@linux.dev>, SeongJae Park <sj@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v11] mm/page_alloc: boost watermarks on atomic
 allocation failure
Message-Id: <20260729150620.7631d856d938d657e60547d1@linux-foundation.org>
In-Reply-To: <6ddc5919-f001-43ad-8101-d118ad70593f@kernel.org>
References: <20260720-feat-mm-page_alloc-v11-v11-1-7376b02c27b3@gmail.com>
	<20260720163719.cf37f6be63bfd88a06965761@linux-foundation.org>
	<90ac10ff-55f8-4f07-8e1d-bb9f3a8cc546@kernel.org>
	<20260729131701.3354724-1-realwujing@gmail.com>
	<6ddc5919-f001-43ad-8101-d118ad70593f@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 16:00:29 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> Great, especially with a realistic workload. However I'd still worry that
> we're working around some old and long time fixed allocator deficiency from
> 4.19, unless it's demonstrated on mainline.

Yes, 4,19 is soooo old.

I asked Jakub Kicinski about this patch.  Off-list, reproduced without
permission:

: Most networking drivers today use the page pool API, which should
: provide a cache of pages circulating between the TCP stack and the
: driver. If the system is in dire straights we recommend the drivers
: allow the queues to run dry and get refilled from a watchdog once
: system recovers.
: 
: IDK how good the code looks from MM side, but from networking side
: there is a lot of unanswered questions.

So it's quite possible that this change simply is no longer relevant
for drivers which anyone seriously cares about.

Clearly the next step here is to test a modern kernel and a modern
driver then decide if there's still a problem to be fixed.  Please.
