Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D094756D8;
	Tue,  1 Sep 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252561; cv=none; b=T0WZNzIjfOwzWju54bvZ1nf2xGdIgf24zMraPxW1jEkq9Bx3DpRZwN2HQTkyPi7eLRd+p1XBlYoQidiDHBuqUGPMvuB5IdY5mLctOGI2w9Fn4JrubsCFqov+rZbiomwPb/kOT+58kzD0j76S8nVR0Ox8WQ3pqA33kpe8RSjWGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252561; c=relaxed/simple;
	bh=QTlcHTpowKWsQovdj1XGzRdJ/ZDJt6zGIppnB6xPRIg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3k9wUf0vkCYVkj9QLWUqMDWZYFCgpyqgGXgovLr7GAedXPAVf4p/o/Y63Q0jXKI2eUEMENeYWNrjZLLyo51519BLP77xjtpNXp+bOxiXxFamu8pfXMHW9sqUBKcfFdzcbLxfVEzFQBywk+giZAO4253Rw6uD26LuaoyVVc420o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wGC8CcS8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wGC8CcS8"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8EEE120799;
	Tue,  1 Sep 2026 10:49:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OOREstNd2N3Z; Tue,  1 Sep 2026 10:49:15 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5E8BB20190;
	Tue,  1 Sep 2026 10:49:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5E8BB20190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788252555;
	bh=b46sx9/wbMx+9rxKsV8IbfLLdVKgYWfbGTeZ3rXxF5A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wGC8CcS8L9j36kszjNZxh8O9t8VZwmhYaTwVs2Gn7R1rlZFmL8lwlk/7qbJnuamQI
	 DDRgMdoYjH16HtpIvF4WxFsnKIV9j5Juom3desm+IVF5vjEVieT0IuTdns9vqk59lo
	 L4tMYwcj1JFTmRV4o5ItLCncgr20637joCiDu+k5S/r6cjfl2/TQL9Y+rc3rUN4Hc/
	 SiZo0b+p2ZJ181v57H+4L06Kmv3T4E19v8egs2ty4NOwzsIdMijdPCEW2BkiyB5Pqi
	 XkNRlCF7mLBMMHjoSOkRQUlGvcKOMvxQJ0XDW/1/Vkkip+d/yZLCtHfuZfHi1dmR1/
	 tFm4aHoxHrxCg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 1 Sep
 2026 10:49:14 +0200
Received: (nullmailer pid 23536 invoked by uid 1000);
	Tue, 01 Sep 2026 08:49:13 -0000
Date: Tue, 1 Sep 2026 10:49:13 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Lilly Aronleigh <lilly@aronleigh.au>
CC: <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Christian Hopps
	<chopps@labn.net>, "open list:NETWORKING [IPSEC]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] xfrm: iptfs: avoid canceling reorder-window drop
 timer
Message-ID: <apaRiWQn54Pr9hpm@secunet.com>
References: <20260824072851.301644-3-lilly@aronleigh.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824072851.301644-3-lilly@aronleigh.au>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net v3] xfrm: iptfs: avoid canceling reorder-window drop timer ---
commit c07a5e7c7c7f82df32e93a21827b1fe442840cc7
Author: Lilly Aronleigh <lilly@aronleigh.au>

xfrm: iptfs: avoid canceling reorder-window drop timer

This changes __iptfs_reassem_done() so that the shared xtfs->drop_timer is
only canceled when the reorder window has no saved packets, with the aim of
keeping the reorder-window timeout armed. Two observations below, one about
the resulting timer deadline and one about whitespace.

Link: https://lore.kernel.org/netdev/CAFrrV-O1fesaza+5_WqH8OciXRu9KKE4UsB6RcMamDu0j2-nBA@mail.gmail.com/T/#u

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 597aedeac26eb..c0d712b594a37 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -699,8 +699,12 @@ static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
>  {
>  	assert_spin_locked(&xtfs->drop_lock);
>  
> -	/* We don't care if it works locking takes care of things */
> -	hrtimer_try_to_cancel(&xtfs->drop_timer);
> +        /*
> +         * The drop timer also drives the reorder window timeout. Locking makes
> +         * a failed cancel harmless.
> +         */
> +        if (!xtfs->w_savedlen)
> +                hrtimer_try_to_cancel(&xtfs->drop_timer);

Discovered by: opus-5 � Missed by: gpt-5-6-sol, sashiko-gemini � Confirmed by: gpt-5-6-sol
When the cancel is skipped, the timer stays queued with the expiry that
belonged to the reassembly that just finished, not with the reorder
window's deadline.  Can a subsequent reassembly then inherit that stale
expiry?

Both arming sites decline to arm when the timer is already queued:

net/xfrm/xfrm_iptfs.c:__input_process_payload() {
	...
	xtfs->ra_newskb = skb;
	xtfs->ra_wantseq = seq + 1;
	if (!hrtimer_is_queued(&xtfs->drop_timer)) {
		hrtimer_start(&xtfs->drop_timer,
			      xtfs->drop_time_ns,
			      IPTFS_HRTIMER_MODE);
	}
	...
}

net/xfrm/xfrm_iptfs.c:iptfs_set_window_drop_times() {
	...
	if (index == -1 && !hrtimer_is_queued(&xtfs->drop_timer))
		hrtimer_start(&xtfs->drop_timer, xtfs->drop_time_ns,
			      IPTFS_HRTIMER_MODE);
}

The sequence, with D = xtfs->drop_time_ns, all transitions under drop_lock:

t_r: an ordered payload ends in a partial inner packet, so ra_newskb is
     set and the timer is armed for t_r + D.

t_w: a future sequence is saved, iptfs_set_window_drop_times() records
     w_saved[].drop_time = t_w + D but does not re-arm because the timer
     is queued.

t_c (< t_r + D): the missing sequence arrives, __reorder_this() flushes it
     plus consecutive saved packets but at least one saved entry remains,
     and the flushed packet completes reassembly.  With this patch
     w_savedlen != 0, so the cancel is skipped and the timer remains armed
     at t_r + D, which is earlier than the window's own deadline.

t_n (~ t_c): the same flush ends in another partial inner packet, so a new
     reassembly starts, but __input_process_payload() sees
     hrtimer_is_queued() == true and does not arm t_n + D.

t_r + D: the callback fires.

At that point iptfs_drop_timer() takes the in-progress skb unconditionally:

net/xfrm/xfrm_iptfs.c:iptfs_drop_timer() {
	...
	/* Drop any in progress packet */
	skb = xtfs->ra_newskb;
	xtfs->ra_newskb = NULL;
	...
	if (skb)
		kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
	...
}

while __reorder_drop() just re-arms for the window, since its own deadline
has not passed yet:

net/xfrm/xfrm_iptfs.c:__reorder_drop() {
	if (xtfs->w_saved[0].drop_time > now)
		goto set_timer;
	...
set_timer:
		hrtimer_start(&xtfs->drop_timer,
			      xtfs->w_saved[0].drop_time - now,
			      IPTFS_HRTIMER_MODE);
}

So the only casualty is the freshly started reassembly, which still had
D - (t_c - t_r) of its budget left.  If its continuation sequence arrives
afterwards, iptfs_reassem_cont() drops the leading fragment silently:

	if (!runtlen && !xtfs->ra_newskb)
		return data + min(blkoff, remaining);

with no statistic incremented, so a valid inner packet is lost that would
have been reassembled before this change.  Before the patch the
unconditional cancel left the timer unqueued at reassembly completion, so
each new reassembly armed its own deadline.

Would re-programming the timer to the remaining window deadline be closer to
what is wanted here, for example cancelling and then:

	hrtimer_start(&xtfs->drop_timer,
		      xtfs->w_saved[0].drop_time - ktime_get_raw_fast_ns(),
		      IPTFS_HRTIMER_MODE);

Related to this, the resulting state (timer armed with a deadline belonging
to neither the current reassembly nor slot 0) does not match the
iptfs_drop_timer() kernel-doc:

 * So, regardless of why the timer is firing we can always discard any inprogress
 * fragment; either it's the reassembly timer, or slot 0 is going to be
 * dropped as S0 must have the most recent drop time, and slot 0 holds the
 * continuation fragment of the in progress packet.

Should that comment be updated, and should the commit message mention the
new case?  Also, the new comment says "Locking makes a failed cancel
harmless", but the concern with the shared timer here is the leftover
deadline rather than a cancel that fails, so is that rationale the right one
for this change?

Discovered by: opus-5 � Missed by: gpt-5-6-sol, sashiko-gemini � Confirmed by: gpt-5-6-sol
This isn't a bug, but the six added lines in __iptfs_reassem_done() are
indented with spaces (eight for the comment and the if, sixteen for the
hrtimer_try_to_cancel() call) while the surrounding lines of the same
function use tabs, so the function ends up with mixed indentation.
checkpatch.pl flags this as "code indent should use tabs where possible" and
"please, no spaces at the start of a line".

The added multi-line comment also opens with a bare /* line, while the other
multi-line comments in net/xfrm/xfrm_iptfs.c start the text on the /* line.

>  	if (free)
>  		kfree_skb(xtfs->ra_newskb);
>  	xtfs->ra_newskb = NULL;
