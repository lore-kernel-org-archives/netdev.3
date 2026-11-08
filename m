Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794109718;
	b=CEGcx0MZWR2popS2dZKdunl7soIT7Ald0zoFPvhnF54hR8nPqs2pMuVSPHyaXdGDg2Yo
	 ryOxd9w/GVd84rNfBnH6DX2mgOxlUSMJE8MW9LprzIZTmh0o1gi9q4KuY4Ogdu6YRcIlS
	 mxa0KQ0W3U2X6FHm5evc8iPVs9pQSAAzJaR+THgEvF8xdMeFe7lYV6/THoEV3KS3kH2KW
	 SRMNR1Mu/iHNif1B4Xj/+MNH+LxEwJR5Ij/z9clgHwzYG1ob4jalx7tPTgoxdBsA/1XnC
	 kQh9sJFH8338q1VguOIiWZ5Jn++OaZYZe4GGIDiG72vObjdQGC2Kj8CInpJUhvXPK4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794109718;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=I/6TtzOh0dg9bpRMXuYv8VzwuHBAbLJYNpKCRR1siKU=;
	b=pkAOlAd7xgESW8XMmMrlLBCjGEOtAi5FSmnrsk9Hv9LOwtuk1luVLfWdKmVbSUF+XIFj
	 NyoTaGLQ5kongh0/YbzxRm0t1SUZvm5wzDRw6LDaAgOmT/y5sJqlpBF6fqtPLYzfLJYXk
	 hvinc84Uc094MZoENDBhDiZGaYezlEK4wNiv4DVxY09PtEdYmMIyCx6XbCkbbWAsIMv6C
	 SZ5BLViFAm5Z6mi+uAbi2yDl/FrZ8fwc1OFyEGEv9gV2cQodTT2iV6VtJ5iiHFBjBLo36
	 XSfUDKRqoJUuAZQi7vERY6Aeu8zxFNvn8uVGw1nCoeRZi0AxyME8k2hGFnlcmDjr/LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaYukE5p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23B606A31A;
	Sun,  8 Nov 2026 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IaYukE5p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE16B1F0089F;
	Sun,  8 Nov 2026 03:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794109717;
	bh=I/6TtzOh0dg9bpRMXuYv8VzwuHBAbLJYNpKCRR1siKU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IaYukE5p8fwKmm3MOBOHdULdPcJ2cYrJSBfjgPcmYBH/T8HI7HcRVJMgQvS2oJvFx
	 XYy2vg3Ru0yCeORyFxIKZl1ZOxhA2ymjAOPucWwxQ0v7nF44zqWrSmYeMGhaaHLJAT
	 9P61gLD4G+nZl+MpjmU8UrMU/sQQOTCbVhQEze8btZhMVQXSAo+18e2BJ3jlW2UUtd
	 9onkD4yIlcXugMWPb+YWHZDXPezUp3tAOdQFkfTvRC+efHXpVDv9kf/MdY8nVAINpA
	 cdIOA7b27zikYTlbpgPHWZ5ANdt493cdPwNKDqXulvhn/jGx86NekU1mrjMdD6Aw2g
	 09qS/ofvIDjdQ==
Subject: Re: [PATCH net v8 2/3] xfrm: iptfs: hand the drop timer back to the
 reorder window
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 03:48:36 +0000
Message-ID: <179410971650.994134.10394735070847385045@kernel.org>
In-Reply-To: <20261107111617.21347-3-q.h.hack.winter@gmail.com>
References: <20261107111617.21347-3-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] xfrm: iptfs: negative relative timeout in __iptfs_reassem_done()
- [Medium] The patch re-arms the shared drop_timer for the reorder
  window's slot-0 deadline in __iptfs_reassem_done()…
- [Low] The commit message overstates the failure mode.
- [Low] The iptfs_drop_timer() kernel-doc
  (net/xfrm/xfrm_iptfs.c:1669-1670) still says the drop timer is armed…

--

xfrm: iptfs: hand the drop timer back to the reorder window

This patch changes __iptfs_reassem_done() so that, after it cancels the
shared drop_timer as before, it re-arms the timer for the slot 0 drop
time when the reorder window still holds saved packets. The goal is to
stop out-of-order packets from being stranded in the window, where they
pin the xfrm_state, once an in-progress reassembly finishes.

Link: https://lore.kernel.org/netdev/20260824072851.301644-3-lilly@aronleigh.au/

> If the missing packet never arrives, the window is never drained: the
> queued packets are not delivered, and each one keeps the xfrm_state
> reference it took from its secpath, so the state cannot be destroyed.

[Severity: Low]
Is this accurate while traffic is still flowing on the SA?

A packet with seq - w_wantseq >= nslots goes through
__reorder_future_shifts(). That function shifts the window and delivers
the saved packets:

net/xfrm/xfrm_iptfs.c:__reorder_future_shifts() {
    ...
	/* Remove the entries */
	__vec_shift(xtfs, beyond);

	/* Advance want seq */
	xtfs->w_wantseq += beyond;
    ...
}

With the default window of 3 this happens within a few packets. Under
active traffic, the effect looks like a delivery stall past the drop
time. The permanent stall and the pinned xfrm_state only seem to happen
once input on the SA stops, either because the tunnel is idle or because
the SA was deleted.

The rest of the description matches the code. Once
__iptfs_reassem_done() cancels the timer, iptfs_set_window_drop_times()
does not re-arm it, because the walk stops at an occupied lower slot.

Could the commit message describe the trigger conditions more precisely?

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 0313a43aa8a97..5ea3e77dd2c8c 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -708,6 +708,15 @@ static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
>  
>  	/* We don't care if it works locking takes care of things */
>  	hrtimer_try_to_cancel(&xtfs->drop_timer);
> +	/* The timer also ages out the reorder window, if it has any entries. */
> +	if (xtfs->w_savedlen) {
> +		time64_t now = ktime_get_raw_fast_ns();
> +
> +		hrtimer_start(&xtfs->drop_timer,
> +			      xtfs->w_saved[0].drop_time - now,
> +			      IPTFS_HRTIMER_MODE);
> +	}

[Severity: High]
What happens here when now is already past w_saved[0].drop_time?

w_saved[0].drop_time is a u64, so the subtraction wraps and becomes a
negative ktime_t. IPTFS_HRTIMER_MODE is a relative mode, so
__hrtimer_start_range_ns() adds the base clock time to it with
ktime_add_safe():

kernel/time/hrtimer.c:ktime_add_safe() {
	ktime_t res = ktime_add_unsafe(lhs, rhs);
    ...
	if (res < 0 || res < lhs || res < rhs)
		res = ktime_set(KTIME_SEC_MAX, 0);
    ...
}

With lhs < 0 and rhs >= 0, res < rhs is always true. The expiry is
clamped to KTIME_SEC_MAX instead of the timer firing right away.

The drop_timer then stays queued essentially forever, and
iptfs_drop_timer() never runs to age out w_saved. Because the timer is
queued, the !hrtimer_is_queued(&xtfs->drop_timer) checks in
__input_process_payload() and iptfs_set_window_drop_times() also stop
arming it. A reassembly started afterwards gets no drop_time_ns budget
either. Only the next __iptfs_reassem_done() cancels the timer, and
that call can hit the same case again while slot 0 is still past due.
Once input on the SA stops, the saved skbs and the xfrm_state
references held by their secpaths are stranded. That is the leak this
patch sets out to fix.

The precondition does not look rare:

  - The soft drop_timer has expired, but HRTIMER_SOFTIRQ has not run
    yet when NET_RX_SOFTIRQ finishes a reassembly. The timer is still
    queued, hrtimer_try_to_cancel() removes it, and slot 0 is already
    past its drop time.
  - iptfs_drop_timer() is already running on another CPU and is
    spinning on drop_lock.
  - drop_timer runs on CLOCK_MONOTONIC while the drop times come from
    ktime_get_raw_fast_ns(), and the two can drift apart under NTP
    adjustment.
  - XFRMA_IPTFS_DROP_TIME is configured as 0, so every saved drop_time
    is already in the past by the time it is used here.

__reorder_drop() makes sure slot 0's drop_time is later than now before
it passes w_saved[0].drop_time - now to hrtimer_start(). Should this
path guard against an expired slot 0 in the same way? For example, it
could clamp the relative timeout to 0 so that iptfs_drop_timer() runs
right away.

[Severity: Medium]
Can a reassembly that starts right after this hand-off inherit the slot
0 deadline instead of getting its own drop_time_ns budget?

In __input_process_payload(), the start-of-reassembly code only arms the
timer when it is not already queued:

net/xfrm/xfrm_iptfs.c:__input_process_payload() {
    ...
			xtfs->ra_newskb = skb;
			xtfs->ra_wantseq = seq + 1;
			if (!hrtimer_is_queued(&xtfs->drop_timer)) {
				/* softirq blocked lest the timer fire and interrupt us */
				hrtimer_start(&xtfs->drop_timer,
					      xtfs->drop_time_ns,
					      IPTFS_HRTIMER_MODE);
    ...
}

After this patch the timer is queued for w_saved[0].drop_time. That value
was set when an earlier packet was saved, so it is always earlier than
now + drop_time_ns and may be nearly due.

__reorder_this() can then drain the window with __vec_shift() without
touching drop_timer. When the stale deadline fires, iptfs_drop_timer()
drops ra_newskb unconditionally:

	/* Drop any in progress packet */
	skb = xtfs->ra_newskb;
	xtfs->ra_newskb = NULL;

One possible sequence with the default window of 3:

  wantseq = W, reassembly from W-1 in progress, timer at T(W-1) + D
  W+3 arrives at t3 and is saved in slot 2
    slots 0..2 get drop_time t3 + D
    timer already queued, so it is not re-armed
  W arrives at t1 > t3, __reorder_this() delivers it and shifts by 1
    iptfs_input_ordered(W) completes the old reassembly
      __iptfs_reassem_done() re-arms the timer for t3 + D
  W+1 arrives and is delivered
    its tail starts a new reassembly with ra_wantseq = W+2
    timer is queued, so no budget of its own is armed
  W+2 arrives before t3 + D
    __reorder_this() delivers W+2 and W+3, window is now empty
    drop_timer is not touched
  at t3 + D the timer fires
    w_savedlen == 0, so nothing is dropped from the window
    ra_newskb is freed anyway
  W+4 arrives with ra_newskb == NULL
    iptfs_reassem_cont() skips the fragment

Before this patch, completing the reassembly at W cancelled the timer.
The reassembly started by W+1 then armed its own budget and survived.
The old code could already hit this when a timer armed by the window was
queued at reassembly start. This patch adds a new path into it on every
reassembly completion while the window is non-empty.

There is also a narrower race. iptfs_input() delivers the in-order list
outside drop_lock:

	spin_lock(&xtfs->drop_lock);
	iptfs_input_reorder(xtfs, skb, &list, &freelist);
	spin_unlock(&xtfs->drop_lock);

	list_for_each_entry_safe(skb, next, &list, list) {
		skb_list_del_init(skb);
		iptfs_input_ordered(x, skb);
	}

The soft hrtimer can run on another CPU, either because the hrtimer base
migrated or because hrtimer_try_to_cancel() returned -1 while the
callback was running.

Could the callback then take drop_lock between two packets of the same
batch, and drop a reassembly whose continuation is the next packet in
the list?

In both cases the invariant in the iptfs_drop_timer() kernel-doc ("either
it's the reassembly timer, or slot 0 is going to be dropped ... and slot
0 holds the continuation fragment") no longer holds.

The commit message says the slot 0 hand-off avoids the case where "a
reassembly started in between would then not arm its timer and could be
dropped before its budget ran out". Isn't that outcome still reachable
with this approach?

[Severity: Low]
This isn't a bug, but the iptfs_drop_timer() kernel-doc still lists only
two places where the timer is armed:

 * The drop timer is set when we start an in progress reassembly, and also when
 * we save a future packet in the window saved array.

Should this comment mention the new arming site in
__iptfs_reassem_done()? That site runs on both completion and abort, and
it uses w_saved[0].drop_time - now instead of drop_time_ns.

The comment already left out the existing re-arm in __reorder_drop().
Later in the same comment, the argument that dropping ra_newskb
unconditionally is safe depends on which deadline the timer holds.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107111617.21347-1-q.h.hack.winter%40gmail.com
