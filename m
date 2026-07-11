Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF4255F2C
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782038; cv=none; b=NtwIems3xp5j2wyIg6ZoO72JVpjQlh4Yj6ZWJya/ozE/kmiIVSGGUpD4P87s+KfDUFgj+pWMovYShInmJJ9yNWMdOkEpn8/YoeOJEmV8jbxsdMZ06UENuUVGEmMp6TRhjervyEK5OoTnAVh8kPVSR1HquGjmn5wELR1RVa1qfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782038; c=relaxed/simple;
	bh=q6/0ee91SdTYyL74lFn1JDDja2kBQezSep4iHVBr2go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trA/dts3SkOIJuDxi0j9IIz3lhH4NrHwN5cF0duX2TafCLTtkX2Xt2QamhJ+AMcF6E06tt04fVSBHOw+lzk90+tw0MvK2rNekzKGep4s98HC9FifvVWJNJXXJTOzVSkVzri19NymEKDStTTuwYI6kukCuFlhH36cdPs7lKigkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p69eOUrv; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p69eOUrv"
Date: Sat, 11 Jul 2026 15:00:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783782024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGF3iX+K0NL0zlGPvkZZrqYfr9pO3LSag2iM3Ynip78=;
	b=p69eOUrvU2OkobEpkcDYVUay9HaMmCCDRZd7GzWYKmNCruMoJ+l2t50eCUHh5Nm4Bo0GaF
	UXWzlCgB9wPeFMHyLFQemxY9Mre+fjQg37hu1Y3Pj9xivNEmaxoFdicWfnN9g5QVqAbglT
	MOkxeC1CORtiJKpDBEd7m1qeg4Ug22U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Ben Cressey <ben@cressey.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
Message-ID: <alJXbCGnSXck4B7e@linux.dev>
References: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
 <CAAVpQUDiLwSYwFStRGpMQkGbm3j8_KJm9LVj0ykV7V3nYQ4YTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVpQUDiLwSYwFStRGpMQkGbm3j8_KJm9LVj0ykV7V3nYQ4YTg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Kuniyuki,

Thanks for the review!

On Sat, Jul 11, 2026 at 05:36:05AM -0700, Kuniyuki Iwashima wrote:
> > +               } else if (!*start_sk) {
> > +                       /* Remember where we left off. */
> > +                       *start_sk = sk;
> >                 }
> > +               expected++;
>
> This should be incremented just after seq_sk_match()
> (see below)

Will do.

> > @@ -3167,6 +3168,10 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
> >         WARN_ON_ONCE(iter->end_sk != expected);
>
> Let's say the batch array was smaller than the hash chain length
> and we reallocate the array based on "expected" w/ the bucket lock.
>
> What happens if refcount_set(..., 3) is called during reallocation ?
> bpf_iter_fill_batch() will see the larger "expected", and WARN_ON_ONCE()
> will be triggered.

Right. Moving expected++ up fixes the sizing. Since end_sk == expected
then no longer holds when a socket is skipped, I'll make the
batch-complete check and the WARN look for a leftover socket instead.

I'll send a v2 early next week.

Thanks,
Jose
