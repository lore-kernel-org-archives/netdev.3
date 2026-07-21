Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64A29B781
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646657; cv=none; b=MvC9cJz4axRkXE6mEZGLT4O91aP5UXhT391UK9OHljkT8rWcS/4OEquX98w1ffDq2zq1IrLSnOD+/dko1lpcjtMb3+MvXyxOyY9wT3VVptMMUpQ9TTqNXLd6lCWDPqmfqBf/lQapoW2dBXOwrP5usDpxpYpFfSj8ivsataV6Z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646657; c=relaxed/simple;
	bh=GmQpqGWeG9PStULBAPtaXE9CCmdLxaO4tnqKs0+BDdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ht8fGimV89dHTaj4JB4I81lxNbjwa3XxJCPBFBv5DpGtMYgvAMeRn5W0n+Wm2ZKqRzmBqm7ltKwr2xeLGokESIkE5TvZbD9m+bF8GwK4XElQOFqe0X5mW2jKXaQxoFZRvkw5mlZzFCiZOfmBXv5Pi1v1W8yBcU41AZkNIKYX7yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRkIgmV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRkIgmV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3FA1F000E9;
	Tue, 21 Jul 2026 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784646656;
	bh=i+MuZxGEHdGWhR2/x4aWx+5ZZGX5D1JjvZ4SNfK6fXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TRkIgmV3a6fmaM90f8yfAidSUKA18x5PnInLqE3+vYD5iB7i6QpRy/WLg2rR1VbVE
	 1FzJ7KXg+O/lDjJuOJ7pkOlKniMfyJj8aHmuB++X3m6oJb4O1Ah/TMRPBuPqafmcup
	 0MWflMQrzUrUGNdBdci2LD8Op0DqDFAKcu4tiHjno4uZHnh+3JLTyOzXFZqMO6TV2k
	 QUzfVjf5Bk97ev0oXzBfFGeyNnvKO4/eTE/Nm0bAd4Cx/geuHYyRwaPFHMdrblXsmX
	 K3naTFnohKeX12SgKhnbyPq1QGxOMc3jWOidqyB2nxwzIbte1CzX2g7C2AQA+NcNMT
	 xoZCc7C1PTmpA==
Message-ID: <90ac10ff-55f8-4f07-8e1d-bb9f3a8cc546@kernel.org>
Date: Tue, 21 Jul 2026 17:10:50 +0200
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
To: Andrew Morton <akpm@linux-foundation.org>,
 Qiliang Yuan <realwujing@gmail.com>
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
In-Reply-To: <20260720163719.cf37f6be63bfd88a06965761@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 01:37, Andrew Morton wrote:
> On Mon, 20 Jul 2026 16:15:48 +0800 Qiliang Yuan <realwujing@gmail.com> wrote:
> 
>> Atomic allocations (GFP_ATOMIC) are prone to failure under heavy memory
>> pressure as they cannot enter direct reclaim.
>> 
>> Handle these failures by introducing a watermark boost mechanism for
>> atomic requests. Refactor boost_watermark() using an internal helper to
>> support both fragmentation and atomic paths. Apply zone-proportional
>> boosts (~0.1% of managed pages) for atomic allocations, while
>> decoupling it from watermark_boost_factor.
> 
> Thanks for persisting with this.
> 
> You didn't retain Vlastimil's Reviewed-by: from v8?

It was Acked-by: and I asked for it to be removed due [1] to significant
changes in v10, which was acknowleded [2] (thanks):

> This is very much a networking thing - they must have considered
> similar things.  But my not-very-energetic attempts to get input from
> networking people have thus far failed.

Yes it would have been useful to have their input.

>> This failure signature keeps recurring in production: a host running
>> a downstream 4.19 kernel logged 144 order-0 GFP_ATOMIC failures over a

I think first only in [2] and now here we learn it's motivated by failures
observed on a downstream 4.19 based kernel.

>> 4h15m window, all through the same NIC driver receive softirq path,
>> across several unrelated network-facing services on the box. This
>> confirms the underlying problem is real and ongoing.

... on a 4.19 (released in 2018) based kernel. There were many changes to
this area since then, some for highatomic allocations even very recently.
So it's necessary to demonstrate the problem exists today as well.

And it shouldn't exist in the form of "logged failures" anyway, thanks to
commits such as c89cca307b20 ("net: skbuff: sprinkle more __GFP_NOWARN on
ingress allocs") that use GFP_ATOMIC with __GFP_NOWARN. So it's not about
avoiding warnings anymore, but preventing fallbacks to non-irq contexts
(that those allocations AFAIK have) and probably thus rather demonstrating
how that improves performance and justifies the patch and risks that come
with it (these heurstics are unfortunately fraught with them).

> It does not by
>> itself measure this patch's effect, since the fix has not been
>> deployed on that fleet yet.

That makes the argument for this patch even worse, but also due to the
above, it wouldn't really be relevant to do that with that 4.19 based kernel
so I can advice not investing time into that.

So what we'd need is to demonstrate that current mainline has a problem and
how it's fixed. A synthetic reproducer suggested in [2] can however be
misleading in the form of apparently confirming that yes, increasing
watermarks by 10% can succeed 10% longer bursts of atomic allocations. But
that alone is not enough to justify this change.

> We'll of course be very interested in these results.  Do you know
> if/when they'll be available?
> 
> Anyway, let me get this into mm.git and linux-next so we can at least
> parallelize wider testing with ongoing review.

linux-next means mm-unstable? I don't think this should be headed for the
next merge window given the above.

[1] https://lore.kernel.org/all/e011c6a8-cda5-42ce-9d42-b23d1c81b26b@suse.cz/#t
[2] https://lore.kernel.org/all/20260720033804.3862547-1-realwujing@gmail.com/
