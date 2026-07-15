Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929AE48C403;
	Wed, 15 Jul 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136768; cv=none; b=iXQylsiWBtK8hqdH95VuUym2c8YhXyj87QPTBbGcHyCMCxtHxvAEykO4nBYz5FhpOUXnT/YuPccoCkCnQOk6twmG9crOGx3C8lhvuSH4tjmXwklqa++zp56sCJ5F6kPFBEu+0LV1Kpfg9wKiGc7j8S3I+6u9pNaZSUOOUujsEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136768; c=relaxed/simple;
	bh=mn240lI4UyPIyJqAgEz/ovIwNpUhv63kmSxtyXIr5Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soi5oq5hWpshkziLQlOPFzpEgE4ORiaSf7PC1/JTb6ZxHiqEKypmLyg3zL3U4wEzHzDoO+szxe7MUGryHQedTAvGWm6/MMI66ZT0C+cMoay6muukxVJy1KtMOPYEhQ91hut7AGg+JJOvtDIWeqkjKPIXL19oLzE3+1Nkb0rNdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBb2YQUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBb2YQUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC0C1F000E9;
	Wed, 15 Jul 2026 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784136764;
	bh=1Dp7MQeBKdy4hjyVL340IuVMzKE8KgoaKktYBZqDNhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hBb2YQUuceYL2kzcQFdKQVBakGs2iwhulqiNQTd7XrpEjslPdwpMVXAf3i2pwzLpM
	 jehjnHlLCQ8b75SR+ovoVJHZqe/JTctMnQxPR/486kG8aPQRDkMWunzSV8pDBXWc7q
	 ERfHuI+u0Gm936RQ4moO/sOS3mGmSmNgZBT9MPZNvmQREMELPLHfvYgOvZGdHm1xIT
	 7pgjiyE1NVTpFqa+YlOxPta/PAVznpRJtrINPV/DKbB3sDOCaMflPaetCjHyP7y90C
	 tfdpvlVAiiVONq62kjtfM4wXCHr13RnetI4WIx3vRvnR4K6uiXM5d2S1ka7aWvIeIj
	 3mZKWLQbNN2tg==
Date: Wed, 15 Jul 2026 18:32:40 +0100
From: Simon Horman <horms@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, oss-drivers@corigine.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfp: Check resource mutex allocation
Message-ID: <20260715173240.GA95246@horms.kernel.org>
References: <20260708143408.3168425-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708143408.3168425-1-ruoyuw560@gmail.com>

On Wed, Jul 08, 2026 at 10:34:08PM +0800, Ruoyu Wang wrote:
> nfp_cpp_resource_find() allocates a CPP mutex handle for the matching
> resource-table entry and then reports success.  nfp_resource_try_acquire()
> immediately passes that handle to nfp_cpp_mutex_trylock().
> 
> However, nfp_cpp_mutex_alloc() returns NULL on failure.  If that happens
> for a matching table entry, the resource lookup still returns success and
> the following trylock dereferences a NULL mutex pointer while opening the
> resource.
> 
> nfp_resource_acquire() already treats failure to allocate the table mutex
> as -ENOMEM.  Do the same for the resource mutex and fail the lookup before
> publishing the rest of the resource handle.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: f01a2161577d ("nfp: add support for resources")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

