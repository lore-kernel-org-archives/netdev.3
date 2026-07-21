Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347E4D9915
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646968; cv=none; b=I2uHQgGImEbh+b5p+oR8Pw25RWM5ppVn8YxJrqbzdgbwIsvn8C1zBfb84G1CKVy2UG1GMo8Rg+tSSgrx1Umrtqhr8wIoN6WAn40YM83fC9TGMNPwkr1BkyiOFgZRPeKfcoyWCfNXzpmq1c5tlY+rhTB8id5TJpSKrng7jam0kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646968; c=relaxed/simple;
	bh=XYb58QMV3gFYmpWAYAyAz/ECMLNMF1F7d5jdhkLnj3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNhxkrOo44SSOd5kdP6bxjRnDFIEbqy+zvveb5zuJz54pQwFuoT2HvhMhxgsm/1lqzjLBWQCu15D9OGZBuxWbGxciKfVuT/AYSLnZAopEwBi+g9JZytAlrufjt0waXFv61zgUfRIIwCbVZaHJsqOGpJxN5JgSO7S14J7SEil9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWXAnyBj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWXAnyBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CABF1F000E9;
	Tue, 21 Jul 2026 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784646966;
	bh=U444D0xaAd61zW8eVrpJ0PeYK7qOeTmvMM9yw0GTil4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NWXAnyBjohoogoVhPvX2kZKwloyNxz5LQ1909bPrSnug79mPVN9mYqg9UGrJPLJa2
	 NTprt69W9KNU3342dkhrVyGZOHU40lt47L3KsR9AB6/Tlc22M1Mbl4+YEzUTqTTTTA
	 NJ+wHuD0MCrItvYIE8Hs0fqp08Jm8i8BLLFnpvhSE+32ynYpFU/W+VMK+BUFfzRwgG
	 sWgVSOaRLr3GaZTQtNG608cP8Yz4TE3ONjnN2W6lG61AWCqVIORntBzEv1vvmNghjN
	 6PxVvOpgCHkIp1s+FRwdyH3xyGK/B/jpTobQ/uKqYIhqgUyNzx+NZxYyFa6/1zIHSO
	 nqbLKHXLsiWMQ==
Date: Tue, 21 Jul 2026 08:16:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte
 <laforge@gnumonks.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, osmocom-net-gprs@lists.osmocom.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] Revert "gtp: annotate PDP lookups under RTNL"
Message-ID: <20260721081605.3e86ec88@kernel.org>
In-Reply-To: <20260708-gtp-rtnl-v1-1-218091f171bc@kernel.org>
References: <20260708-gtp-rtnl-v1-1-218091f171bc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Jul 2026 20:02:05 +0100 Simon Horman wrote:
> This reverts commit 0be5c3f0fbef3679f50f345b9237b8f9ea5de4e9.
> 
> Commit 0be5c3f0fbef ("gtp: annotate PDP lookups under RTNL") added a
> lockdep_rtnl_is_held condition to hlist_for_each_rcu() loops to help
> insure that RTNL is held.
> 
> Unfortunately, as pointed out by Pablo Neira Ayuso, the PDP context list
> is actually protected by the genetlink mutex. And so the condition
> is incorrect.

In the future please remember to add a Link: to the message being
referenced.
