Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547603;
	b=FNvgTifgHpQGnRNyhid1ZGzrQF2KPOHVqL/JiYsfOzM5cLYxRJm/aWR2i4jFSPkltAg1
	 oKP2OIDUH4oW73+Sprd6seEU2jBVAgry1Aw7WPrfRNUNDyTjgXL2HGnDoZukviCA85qmJ
	 AZhBiWANiMEoig/N2jHMKA2TfTzFvJtNd/A/Bi2pmTCRevGTc0zZRW/Ngln74lPTI5yoy
	 fy5KLfGFzVwinLzMoZ3jjP8f/thO6j0Ltp1fJFgw/lbHfV/xpimDmDywLF2O60roz/2qp
	 bpGSir0ZoDBT+Ly+9PdekfhIRt0i6FibIWlya2+1+sseW1XSH0X1G/HS34a6I6mMGKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547603;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0zaTOm2gabGZSGcUZLYd973mBB0BoYe5ql4/IuZHCDg=;
	b=w4snHTRPR6JsG2r/4xC3NjZQOOhJpc3qJLxwC195YBoN3sDBe4b9+4azl2TmXZlTq9Io
	 W07Y6vhzzWR8w0/ALnaV5EP1Hg6lwHtfXfjcr8WajYeQjNp6fa9ETvFC7MZNVsQ1q2gzJ
	 MT9sZRymuKQhZnNZx446aEVSKcQXfbf+14BXGyCDma+29JldYBqwyLWTpnLiqPfdm0P4G
	 x4PFxGCXIOswpB3nJRNgcYZzwWrQcTDt2olwrfCanXUBiV55AYXvfustRPvcsrhyjHNLp
	 zOeCYzuIcf2uvbgvn6ESb5Ej/0ndXeIEnz3zu+OLpmYrFdEULoTLBkjqndmULhtFzwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAdqq4CI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C1606A31B;
	Wed, 21 Oct 2026 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAdqq4CI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93991F000C9;
	Wed, 21 Oct 2026 01:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792547603;
	bh=0zaTOm2gabGZSGcUZLYd973mBB0BoYe5ql4/IuZHCDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SAdqq4CIHbITapplM4OVDYtuAVJtNhGsum0nw7HoitCnFuscBQc7xcaNacQJJ0pOt
	 KL6pkU25Lgr0NAalo9CkLyBhVdATGfIXeqXQQ165ZtdVkBebJmSVd41s5zfyMcC9/T
	 EEQoOE9AVwtmnVFosn+7dsSLlm2jUmJeuIquhwk4NdGmqvc00s5AfY1rTuGDept2i0
	 9y+P3axukuoFHe0b9chRcg2vEZPArrpgXgm5LI3I8Cb3aWK7O6eunuVey2jeCa6jdE
	 xRFRu8K9+NLUPSLVvFXzIQsMqFOv9sZ+7H7TuAK1JnjihNK19IHNh/5MrRV/k2a7wF
	 MlW034BXHl/CA==
Date: Tue, 20 Oct 2026 18:53:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, Bart Van Assche
 <bvanassche@acm.org>, Davide Caratti <dcaratti@redhat.com>, Breno Leitao
 <leitao@debian.org>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Vlad Poenaru <thevlad@meta.com>
Subject: Re: [PATCH net-next 0/2] net/sched: don't wait for RCU when
 destroying qdisc lockdep keys
Message-ID: <20261020185322.4297d962@kernel.org>
In-Reply-To: <20261019170225.729789-1-vlad.wing@gmail.com>
References: <20261019170225.729789-1-vlad.wing@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 10:02:23 -0700 Vlad Poenaru wrote:
> On kernels with CONFIG_PROVE_LOCKING, every qdisc except ingress, clsact
> and noqueue has a dynamic lockdep key, and destroying the qdisc calls
> lockdep_unregister_key(), which waits for an expedited RCU grace period.
> Replacing an mq root destroys one qdisc per TX queue under RTNL, so a
> single "tc qdisc replace dev eth0 root mq" waits for that many grace
> periods. Commit 7a3cedafccf8 ("lockdep: Speed up lockdep_unregister_key()
> with expedited RCU synchronization") made each wait shorter as a
> temporary workaround until hazard pointers are available.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

