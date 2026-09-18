Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE466511E7E
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748097; cv=none; b=LWtWBUw8QRrWQeQizbiel+TDjhAD2+95tSPYedZDreCOfLJS/j23MsAH6dUFn4bSRjw7uJH7LwW3fjsmmvb9nxV6Ng0bMWkQlWvFOZDujsgKVWufqELxSMBTb/WzZPol+0vjWcDWclGOWPjDgwyQNwTIKkkUJnoraNN+G5Rvs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748097; c=relaxed/simple;
	bh=bFp+EXRjbodHLK7YXfpdqCEEkZtwzgjrFXgpcFW3BuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMZxRz0PflD1lySJmjGFHgAoFmqpgK5Z9gGTJDZZiIlWiT5XCXqp/7diINH5Hu2hCbfhDiBYSjIYRt7hj5B7lDNthSIy1tR6MkcuiemGaSE4T2gj3pEcfpOVudZultEmggxQskRuk+k8Lz67FQN8aR9PMy6U4+dl/EMkZvT9tAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuA1r+Xg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuA1r+Xg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A350C1F000FF;
	Fri, 18 Sep 2026 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748095;
	bh=nuDJmR7ZuiY8ldekJiLAdEyyeGn5S8iUUxFuWoF7QKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AuA1r+XgprVK9aLY1Kg+m9Hrum+Z+J1nD7OV26cHpP29469DfzJgKn7TqY+lj1+iS
	 mW9G6TbmSkjbjRRU0fdcZD5/qvaqqRCqNjcy+Q4h2QCqgbQRLpScWbzc7F63Erai1R
	 D//FeBlMA306ZZbvrImbh5RqvfEmw3PftHrvHXfkbQs0jKjmL5MnyJC0Aex0RhJu7+
	 C1MPNKmSDo4/uwHv4IWOthSKYTo0TBlRaAzMmMKsBfn/PtVIMgTSYelJy62gLgwdAI
	 HyMcXoLikvqLBiT49qQMjMDcYHMoFqs9fTxLC1UfhpnNylZFgDf7fDuQbMGE8Mk0/z
	 LfPQGK80jGeOQ==
Date: Fri, 18 Sep 2026 17:14:51 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com
Subject: Re: [net PATCH v2 3/6] eth: fbnic: use the Rx queue napi pointer to
 find the napi vector
Message-ID: <20260918161451.GS51261@horms.kernel.org>
References: <178942021136.7700.4391219358260544104.stgit@ahduyck-xeon-server.home.arpa>
 <178967952944.22033.10329187569173798096@kernel.org>
 <CAKgT0Uf2xJr5hD_yAtNg67-2t5XS5d-QBf+gPscPJe+L1Miydg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Uf2xJr5hD_yAtNg67-2t5XS5d-QBf+gPscPJe+L1Miydg@mail.gmail.com>

On Fri, Sep 18, 2026 at 08:11:04AM -0700, Alexander Duyck wrote:
> On Thu, Sep 17, 2026 at 2:12 PM <netdev-bot+sashiko@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:

...

> I agree that this is a pre-existing bug, but I wouldn't fix it in this
> patch. I would probably introduce yet another patch to resolve it.
> 
> By my count we have 3 pre-existing issues that aren't directly related
> to the original problem. If possible I would prefer to address them
> separately, otherwise I can tack on 3 additional diffs to the set and
> resubmit.

Yes, I agree that is a good approach.

I think that in the age of AI-generated reviews finding related bugs it is
best to adhere to a strict scope for a patch(set) combined with follow-up
fixes. Else a patchset may drown in scope creep.

Reviewed-by: Simon Horman <horms@kernel.org>

...
