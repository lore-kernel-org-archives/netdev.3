Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260C2D781E;
	Tue, 14 Apr 2026 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776191497; cv=none; b=ANtJeTwjG4vL7VatCYyqsWJ0yJAChFAZgb0ivBbzCtnyjWLlLq0tEiS+opCxt74foXb1qAr/pw9K8FA2MB1lg8Tpg83kA1Xh0QoAc3elB8soBoCPISzo24VYiec/USTLmqr2NKU85Jui6AenvljyVf4t4MG8BU+p6OTXg8Y7fMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776191497; c=relaxed/simple;
	bh=LYF4jA4OnTI+Yp4mPc47e5WwaT5oghQ1i8r+evxoMpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRtQi9wPQmS9zppXNTX9k+pR+aO6FTuB/TObrPKRM7y0g6mUAyg3vZo58toVOGzOekD42rE6UqS1W5m45xS203x8hyfhExtDq+Cg9BVrZ2Q8v8uQtnRk5ERro3aw84/HAp5CEZ9mNF5D/NpGsfRdX03IU8uKJZHGoj6N+mP50p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9JYhCbT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9JYhCbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9E8C19425;
	Tue, 14 Apr 2026 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776191496;
	bh=LYF4jA4OnTI+Yp4mPc47e5WwaT5oghQ1i8r+evxoMpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9JYhCbTrfVUvt1xj+72G6aPOXh0Aef/nQuW5PiOT6PADEZAC0VMmJAzh6XDQSKXZ
	 9AADVl5OvLUISDny0JjhaarYdTY/Y1p2AEv//UtzCAFVuEMA25CqCRFwSs9kgNWI8B
	 SQ1666oT38H+CUppWJsZj+hu4UloLRXFhHifoGX1Shijp+1DI4c+I8ZA49H/fGvKEw
	 VpEFq9Q6VSPNopFz7bTKSm9aAKmbh/gmDbaiHE72tcC0N8cpY9y1OEtE9E4izs4a8p
	 g4dku6qauJBCrZ5pl2hYJAhUkoL3ZyqmjmQ7IAxAXbaFCH2Id7cCJl0EXJBTzxnE5c
	 Blbesgw1ud3Sw==
Date: Tue, 14 Apr 2026 19:31:32 +0100
From: Simon Horman <horms@kernel.org>
To: "Kito Xu (veritas501)" <hxzene@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_dualpi2: fix NULL pointer dereference in
 dualpi2_change()
Message-ID: <20260414183132.GC772670@horms.kernel.org>
References: <20260413075740.2234828-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413075740.2234828-1-hxzene@gmail.com>

On Mon, Apr 13, 2026 at 03:57:40PM +0800, Kito Xu (veritas501) wrote:
> dualpi2_change() uses a trim loop to enforce the new queue limit after a
> configuration change. The loop calls qdisc_dequeue_internal(sch, true)
> which only dequeues from the C-queue (sch->q) and the requeue list
> (sch->gso_skb). It does not dequeue from the L-queue (q->l_queue).
> 
> However, the loop continuation condition checks qdisc_qlen(sch), which
> reflects the total packet count across both queues because
> dualpi2_enqueue_skb() manually increments sch->q.qlen for L-queue
> packets (line 418). Similarly, q->memory_used accounts for memory from
> both queues.
> 
> When all packets reside in the L-queue and the C-queue is empty, the
> loop condition remains true but qdisc_dequeue_internal() returns NULL.
> The subsequent skb->truesize dereference causes a NULL pointer oops.
> 
> An unprivileged user can trigger this from a user namespace:
> 
>   1. unshare(CLONE_NEWUSER | CLONE_NEWNET)
>   2. Create a dummy device and attach dualpi2 qdisc
>   3. Send ECT(1)-marked packets to fill the L-queue
>   4. Reduce the qdisc limit via RTM_NEWQDISC

...

> Fix this by adding a NULL check after qdisc_dequeue_internal(). When
> the C-queue is exhausted but L-queue packets keep qdisc_qlen(sch) above
> the limit, the loop breaks safely. Remaining excess L-queue packets will
> be drained by the normal dequeue path.
> 
> Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
> Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>
