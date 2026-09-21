Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024B4B3373;
	Mon, 21 Sep 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003404; cv=none; b=B4gZaM2dICcvTEMeIOalfWRvdvtyvlOZjvlSmMS67ZfUpb12cLnrGuMlfTobT7u4oKnsrQlYh14QTrCznEe8JjuPKHqVUpGSZZaYgnIq4MAnv3XdP6HEpMq/ACFt4+QgY/GQCXx1Ge6DQl+494E7/2iXQa92Uje5uPYEOvTq+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003404; c=relaxed/simple;
	bh=qnikWFdO3NwUCcTL7j7yMSnFEjEdsBE1k1k2bh7ExWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBENvF1xkBV/vwjIorygNwaR+qu2i6qFy+CML/QD8tpKX8PLC2FzHk/NIa0L9l1tha/BaTYo+7Jiqzoj4UK2STbYT2+UxiUzZ0zXaKDUoMRAp9PFxpmLalchM585fmyRXbvobg1ty7RWnief7y2UhXfHmcDHE7mXWiLHYbyl1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdVd0uoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdVd0uoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A3E1F000FF;
	Mon, 21 Sep 2026 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003403;
	bh=rQR4A5hzoWo6Aa2g7zf8ZZKW6pdDnrSj4VmXOjSbTO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jdVd0uocH+ziECMZn1V4PZ76QC+xlW7ejQh4fUDBogO5D7kSDomU5/eXchvdgjPHy
	 zbTxNJf/XzQxi9k5/Y9OOH5ZVzJWoxdJ+9P6Wa6VqBsca7bxPV4s+0E2K8PhsJIcbM
	 JBZ+ZMJCH1RQagupXg3uJyziriJ0qMY2JuHefi8K5FMDh1xlxKSUwsr01SMAu0o1Pn
	 XlNiz7MMCXwUGyDqSoDQYYsIa85KMDvPrEVmjXeFLTfkQ3FKKR3lIY5y5vz1wPhpRF
	 YoYbVNwQtoPrN59Y0uSAShoAyb88p9fNc+MSlLSxpkopJyzkOIutnDSY0DYGuGROV+
	 3XUjxDWQquCZg==
Date: Mon, 21 Sep 2026 17:09:57 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: kuba@kernel.org, edumazet@google.com, horms@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	matt@codeconstruct.com.au, linux-kernel@vger.kernel.org, jk@codeconstruct.com.au
Subject: Re: [PATCH] mctp: route: verify socket ownership in
 mctp_lookup_prealloc_tag()
Message-ID: <arFIxOWAvDsz149J@quoll>
References: <20260919212851.3240598-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919212851.3240598-1-benquike@gmail.com>


On Sat, 19 Sep 2026 21:28:51 +0000, Hui Peng wrote:
> When a socket transmits a packet with `MCTP_TAG_PREALLOC` set,
> mctp_lookup_prealloc_tag() iterates over the per-netns `&mns->keys` list
> and matches `netid`, `req_tag`, `peer_addr`, and `manual_alloc`, but
> omits checking whether `tmp->sk == &msk->sk`.
> 
> Because all preallocated tags (`0..7`) reside in the shared per-netns
> `&mns->keys` list, any local `AF_MCTP` socket can specify another
> socket's preallocated tag and cause incoming replies to be matched
> against the victim socket's `mctp_sk_key` or reset its expiry state.
> 
> Verify `tmp->sk == &msk->sk` in `mctp_lookup_prealloc_tag()`.
> 
> Fixes: 63ed1aab3d40 ("mctp: Add SIOCMCTP{ALLOC,DROP}TAG ioctls for tag control")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> 
> ---
>  net/mctp/route.c | 3 +++
>  1 file changed, 3 insertions(+)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



