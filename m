Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E6225A38;
	Tue, 14 Apr 2026 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776191766; cv=none; b=u3dtoDeuTfJyT1Y4c6ufL8JYBm0Q+vOdLMElW8s55vBKsTq1XvdtEnUhRzBhdoe9GH/hPP+63x8shjtmP2u7tpNKzdhb0DvUP+5TUouxNl4OTdjLDFjJVp/MBJ6QteS/ezDQDi5685WhnCUtc73EUKMJGAWMG11IDRDUDxds87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776191766; c=relaxed/simple;
	bh=njIuL9iaF8mP4QJM0a1qYdNw0db4rQ3lcyMjQEg/hrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRZzOjZamt8LxatuiC4aJyhRlyjxmKvxW1AjXmZutAdyd+vlE4ew0GUb3v0RTA7jRH1PBsHzbP/tjQYIfKxqoC1lzSuLBPf4bHSBmdJQj8lUcWFzr2eYxe0YJaKrgqkjsSk97MZQbV4t2Xti8Y3UF6V5v8kQqWmAnx5kieNsRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apzYNjes; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apzYNjes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954A2C19425;
	Tue, 14 Apr 2026 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776191765;
	bh=njIuL9iaF8mP4QJM0a1qYdNw0db4rQ3lcyMjQEg/hrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apzYNjesAKL3nQz8/WVcNoxDIlqqaAEpd57gkNvNS4A+bZuQWtzUT1aohQgbdB7OS
	 Q4/FcOLMRprp55O3PD7+e6VJqTAd/6mhf6AEoXohKMnlSq07KmArKvR/rqv6phpd8s
	 77myjtZZUiqjqCEAUP9APpfIUUaYMgZfJBapw9NscGxKdMRSlDVuADg2sr+ELDRsCa
	 B7uJeMk3U1dY7Naz2aksPxuskDxI+KKp4wybtEK/oRkgsuGej1O5CYO5N3Fapsu9l5
	 QA1Tj+2r3/XWUNp42sY5LkXldMwyJ2W1JeJQMvXUugPu3dvEfF+nUDEuhyxwntNtpS
	 xZmdlCbyChPRg==
Date: Tue, 14 Apr 2026 19:36:01 +0100
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
Message-ID: <20260414183601.GD772670@horms.kernel.org>
References: <20260413075740.2234828-1-hxzene@gmail.com>
 <20260414183132.GC772670@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414183132.GC772670@horms.kernel.org>

On Tue, Apr 14, 2026 at 07:31:32PM +0100, Simon Horman wrote:
> On Mon, Apr 13, 2026 at 03:57:40PM +0800, Kito Xu (veritas501) wrote:
> > dualpi2_change() uses a trim loop to enforce the new queue limit after a
> > configuration change. The loop calls qdisc_dequeue_internal(sch, true)
> > which only dequeues from the C-queue (sch->q) and the requeue list
> > (sch->gso_skb). It does not dequeue from the L-queue (q->l_queue).
> > 
> > However, the loop continuation condition checks qdisc_qlen(sch), which
> > reflects the total packet count across both queues because
> > dualpi2_enqueue_skb() manually increments sch->q.qlen for L-queue
> > packets (line 418). Similarly, q->memory_used accounts for memory from
> > both queues.
> > 
> > When all packets reside in the L-queue and the C-queue is empty, the
> > loop condition remains true but qdisc_dequeue_internal() returns NULL.
> > The subsequent skb->truesize dereference causes a NULL pointer oops.
> > 
> > An unprivileged user can trigger this from a user namespace:
> > 
> >   1. unshare(CLONE_NEWUSER | CLONE_NEWNET)
> >   2. Create a dummy device and attach dualpi2 qdisc
> >   3. Send ECT(1)-marked packets to fill the L-queue
> >   4. Reduce the qdisc limit via RTM_NEWQDISC
> 
> ...
> 
> > Fix this by adding a NULL check after qdisc_dequeue_internal(). When
> > the C-queue is exhausted but L-queue packets keep qdisc_qlen(sch) above
> > the limit, the loop breaks safely. Remaining excess L-queue packets will
> > be drained by the normal dequeue path.
> > 
> > Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
> > Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, I now see that a more comprehensive fix for this code path
is available from the original author of the code.

- [PATCH v1 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit enforcement when dequeueing L-queue
  https://lore.kernel.org/all/20260413163711.56191-1-chia-yu.chang@nokia-bell-labs.com/
