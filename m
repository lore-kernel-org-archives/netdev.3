Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737A36DA13
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513006; cv=none; b=XRkCe8EYaft/Z/mYfqQkHaVKmyor8GDTP8mBtl1+LYg2IsWJ/EuQiCbJbgww/KM0GFWzK3N4+cpK0lV9yMjJi9ZBf7uaN5cr/oBPNrzsfFf49OB4nP6VsrWeXhqsT5GCs3vtA7BG07CbWknvFNHVj4Ly365VYY1MQbovt2eXocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513006; c=relaxed/simple;
	bh=nEFnZVqL+LDXRPQtO/HgdeszxPxPEhdXuBzRZy8hvP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLU+VXXs2uzYeI5c9cekgiqGMsGAyRYbmFEalMc8tk2LIJj+A3B/ZdhsIL+eWXlr4MENhWU13IKZOXQrwGIclyUUXod2Mf5sWtg/EJukfh1bigBPZVR/5+ShBfROxiG7GWpit+43rpBA0rt2BvQjvwukH0nSX73SSTAqDWxc9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWYQntTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWYQntTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6331F00A3A;
	Mon, 15 Jun 2026 08:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781513005;
	bh=pTEAVceORCrEk9ppHC+HAlUIJDS4sYHs3Plc5as2XXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WWYQntTc6lsKuaKUC8x6s9bjALKtVjwPNzO3clPG5F0U14PajZfHbFAsgaS8h8SUM
	 Uch+KJ1cVkz2r6QYHK2ay1rEFvn3N5UP09CN/0Ko7vzbTmFPHmyY0l0VZukg5vL53U
	 R1iPJdd/frlfdOCGh5Sr+9S+MbGsdlJltf3dLE4XsNlrGsFv9WIKHK+4bRd/4fWpOu
	 65KFvkBq+TdXhQ9K/z5nNKqFh3I9ney0lVODLTBwlpM8qzzNDETBKiPWfQ70o0oyVE
	 HZsO6llwyZSANhV+t9nUqNlyp3FNcrCbAJQkLYL/zuZH4Dz4Uk9Nnq6jWQusdoDT1i
	 TIBqMVZC/z95g==
Date: Mon, 15 Jun 2026 09:43:21 +0100
From: Simon Horman <horms@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
	Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] xfrm: Fix xfrm state cache insertion race
Message-ID: <20260615084321.GE712698@horms.kernel.org>
References: <aiuSE5J-U8SuoZnk@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiuSE5J-U8SuoZnk@gondor.apana.org.au>

On Fri, Jun 12, 2026 at 12:58:59PM +0800, Herbert Xu wrote:
> The xfrm input state cache insertion code checks the validity of
> the state before acquiring the global xfrm_state_lock.  Thus it's
> possible for someone else to kill the state after it passed the
> validity check, and then the insertion will add the dead state
> to the cache.
> 
> Fix this by moving the validity check inside the lock.
> 
> This entire function is called on the input path, where BH must
> be off (e.g., the caller of this function xfrm_input acquires
> its spinlocks without disabling BH).
> 
> So there is no need to disable BH here or take the RCU read lock.
> Remove both and replace them with an assertion that trips if BH
> is accidentally enabled on some future calling path.
> 
> Fixes: 81a331a0e72d ("xfrm: Add an inbound percpu state cache.")
> Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Simon Horman <horms@kernel.org>

