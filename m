Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950954B1285;
	Mon, 21 Sep 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003458; cv=none; b=BKcJHl0Q9wC/Dhni8ApGVjY4AbS5BFwUgbIBRpqWIHjKb3552mdMW9Bb4FwJSDnBHlWOKjNkuwu2SSgF3pkrY/R0tXEwpWEo8xxNdFO5eH0ZlCTt0+ad7GcwWWUgJY1OKdY4s3a2nwAhxUKufwbFTmnHnagXEIG344uGI9LSMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003458; c=relaxed/simple;
	bh=RauIa3QTNDKV27qTECWw5pbQcBEftODnWrIgksM1rjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM6GqkHnlMb4OoW8e6WiMKiw0xz0nble7P3k9pUGrTxNlwc9aLlBsZmAXGecueb1vq7SoIAnTI4Gd4CcLUHoyEV5dpEfViReDyOBdkeUAp1iIFDYMhDM5oiMEfVdDtzSEtihsf0ASPidtYOqe6U5EsJHeOKLugwIssYLHZ0W43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB26bgki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB26bgki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719281F000FF;
	Mon, 21 Sep 2026 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003456;
	bh=4UCgcjy3l1V79pnNU3w+GM5i3Dnrb44POIU50ppbvOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oB26bgkiS/d+2PfjS17U4hiiNWvUQ8BNU5JOzkJEkLJalTHww8ZG6ePB65Ux4bJqv
	 1P/T7EmfgDhr1NRNM/3INwtbRBhOPQY28nT8EQ6QJWNyoucqTXl5lTZB7zxsLxJOJl
	 dCV3L+6U94ZtpqiKoDii93nbnUZTA3C/LvXXDAwwjpJA40KH8f3r3m9FXyS3tdeTyz
	 uEKQmFKWutmItlvk09En+fXbBfIp5Q0bRkgmG2FKrPW2UHmjRO3otkFcxA8QQeJxyk
	 jQ6/nFoZStattdsyA37ucE7qHlFz12Yex+HzVS3PPLFIQGQ0UEmN84KHSIP6X3Viw8
	 0k83hUinQUAWw==
Date: Mon, 21 Sep 2026 17:10:53 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, andrew+netdev@lunn.ch
Subject: Re: [PATCH] ppp: fix bsd_decompress() OOB read and
 ppp_decompress_frame() headroom check
Message-ID: <arFI_Pu1GAsn9rvs@quoll>
References: <20260919215233.3470411-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919215233.3470411-1-benquike@gmail.com>


On Sat, 19 Sep 2026 21:52:33 +0000, Hui Peng wrote:
> In ppp_decompress_frame(), skb->data - 2 is passed to the decompressor
> assuming at least 2 bytes of headroom exist for the PPP Address/Control
> fields, and the returned decompressed length is only checked for len < 0
> before indexing ns->data[2..3] and calling skb_pull_rcsum(skb, 2).
> 
> Ensure 2 bytes of headroom via pskb_expand_head(skb, 2, 0, GFP_ATOMIC),
> reject decompressed frames shorter than PPP_HDRLEN (4 bytes), and check
> isize >= PPP_HDRLEN + BSD_OVHD in bsd_decompress() before reading the
> sequence number and header bytes.
> 
> Fixes: 224cf5ad14c0 ("ppp: Move the PPP drivers")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---


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



