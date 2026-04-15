Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1005175A6D
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263744; cv=none; b=DhldKHfwfbc2TaqyX0u2rWhjPRH653b2QPOrg6gAZ97e/qiQCuOlC4V0YCFf0FBUsNLnyf010LNU9n4eyqpewyoIgXiwTlg3knQD5YFKEXNSoQk1pKLSwge9IAH8AO/FVgt6bW5C+EuLQhFYNLCG2cdytRfvP9VMkmVYNhnTe/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263744; c=relaxed/simple;
	bh=1do8zuwmueGammtnlQgxq2NJR9/2s9G1q7s4RuMcbUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLDxUVikl0WaiRKXE3g8MBRR/t+uVZdtoPKDoYy/mAcYMqH1sfk464U4pEifzjisjxRcuLg5mYViYKNIYj9rwVaOR+xvGk9+0T+KkIik2V6zz7B15HYQa5bXGW2xZH0Pe6Gt0PqtXR0DAEMFLUrWpBaMW11fpg6/lHyeEPICZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2CamLXU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2CamLXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3623AC19424;
	Wed, 15 Apr 2026 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776263744;
	bh=1do8zuwmueGammtnlQgxq2NJR9/2s9G1q7s4RuMcbUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2CamLXU3EyJxJ5CpOL/42SRbSHiajTEgPFaho4EMjBPZ8HTSHoTxqB9gPHBvtF7w
	 1xQkQtDMdnbPH3R6NWKj3slUBvTSqryGpEWAqckyay0ME7Jkg5rYEYt3vjZl0EMiT6
	 5CkLXo62m+sKaMaBVOWczyLG56BM6Wh4LA0H+XeCMuWkjutwfF75KgGWdZaZs9aM3T
	 usExckLumSQIifbHxGEr+EMseMQ+UKWmNzW8qxjjlH/E7ItGQIlD9ENY+kXseUSGu+
	 Mbdl8/1TjyFpyiNg5Hmi3VwEeCq3hrr8UGvHyizaCzbcbSBG8Oz6mfO5tBnW9+y/4G
	 K8z3/ReP7cC6Q==
From: Simon Horman <horms@kernel.org>
To: phx0fer@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Subject: Re: [PATCH] xfrm: iptfs: fix deadlock in iptfs_destroy_state
Date: Wed, 15 Apr 2026 15:35:20 +0100
Message-ID: <20260415143520.809464-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413085138.72623-1-phx0fer@gmail.com>
References: <20260413085138.72623-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
xfrm: iptfs: fix deadlock in iptfs_destroy_state

This commit resolves an ABBA deadlock in iptfs_destroy_state() by moving
the cancellation of iptfs_timer and drop_timer outside of their
respective spinlocks.

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 97bc979e55baf..11291b87158cb 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -2708,8 +2708,10 @@ static void iptfs_destroy_state(struct xfrm_state *x)
>  	if (!xtfs)
>  		return;
>  
> -	spin_lock_bh(&xtfs->x->lock);
>  	hrtimer_cancel(&xtfs->iptfs_timer);
> +	hrtimer_cancel(&xtfs->drop_timer);
> +
> +	spin_lock_bh(&xtfs->x->lock);
>  	__skb_queue_head_init(&list);
>  	skb_queue_splice_init(&xtfs->queue, &list);
>  	spin_unlock_bh(&xtfs->x->lock);

Is it safe to call hrtimer_cancel() and skb_queue_splice_init() on xtfs
here if it was created via iptfs_clone_state() but failed initialization?

If iptfs_clone_state() uses kmemdup() to shallow-copy the xtfs structure
from the original state, the copy includes xtfs->queue and the hrtimer
structs (iptfs_timer and drop_timer). Reinitialization only happens later
in iptfs_init_state() -> __iptfs_init_state().

If x->type->init_state() fails during __xfrm_init_state(), the state is
destroyed via xfrm_state_put() before iptfs_init_state() is called.

On this destruction path, does calling hrtimer_cancel() result in a
regression where it operates on the copied timers? If the original timer
was queued, the copied timer has the HRTIMER_STATE_ENQUEUED bit set, but
its rb_node is not natively in the rbtree. Calling hrtimer_cancel() might
call rb_erase_cached() using the cloned node's pointers (which point to
the original node's parent/children).

Additionally, since xtfs->queue is a shallow copy, its next/prev pointers
would point to the original state's queue. Could splicing it here lead to
a regression by modifying the original state's skb queue? If the original
queue was empty, it points to itself, and this code might dequeue it and
call kfree_skb() on an address inside orig->mode_data.
