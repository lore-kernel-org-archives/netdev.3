Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794207015;
	b=NiBm1ZpKHMe9ylhOxgTifKvbuF4+iE1GutkHS4ejjURGCoI49+FnZ9R8DxugAFb8exqK
	 siHbX/YQoHDBJma6epyxlmLU1KgUjOBL2ROw4iwG1mYxQPoRta9xyQruwvw2g56SmMy8U
	 2XbpK12noRtp8wfafeYI1H7GKr9l1JKi817vqWvl+mNyCDhJz3OpGBEXrnWxcaOz6PBaB
	 6pSkPpxWJQq6kgsm55XZ5ZbAx1ZPgE/aFuHvD4AZO41htOZwuUghNWwZj4qPuRBp8WMWH
	 QT2WQwMV1icLsEZnHWH6oHrrv7T41VtgoT9OvFE3OuF0qCcgjTQY8cB3wR1cyOHnbig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794207015;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nLRn9E9rDIIqHMb+z0GXGKtvDcL0o8fvdbUF/jWiy4U=;
	b=clefNAwAQmEjzs3D3/B/GXqOfrglHxKeQyc5qUXcRhdT3xKrgRfWOvHqHXNOvVfIhJhX
	 wp4h2JDNr4fMHKeicGSaEwVj+VEoJzm7/z+g6o2HXGAMorv9GjY8FI4RtIeHDwusUaV9I
	 MooGljMl2+uWs+jeV/pkrJBDgzBkH5vpgqAIoIA0EBK6Htrb3dNSnNPXxpXHbOsHsoEtT
	 Ax8tnMBfAN/g8GLg+fjA7b5SmqDobibD9OXNtcKGQRuZ/f9qAxW7MNSbo8vheSkCqMZ3D
	 pRAZwsaQ88QAY7+FPqBMziBZVLZha1VnNQeZZgiA+Qg26bRocrwDY+Rzrl1k9bY02zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IA2G3smf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7A606A31C;
	Mon,  9 Nov 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IA2G3smf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287CD1F0089F;
	Mon,  9 Nov 2026 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794207014;
	bh=nLRn9E9rDIIqHMb+z0GXGKtvDcL0o8fvdbUF/jWiy4U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IA2G3smfFVuLKysbcWlAyLcyFL1drRq9FoD1+450npPyiPn3XnkckqTAyYLpBGLmJ
	 C1Qw5jkTDR6jDtQRWxP669xmAGulhB872vL0RD7qEJng1KJ3XQ9FiufrPtPVEOYnKu
	 uF0soySFszlao09vbeZU2XMAyzGt3LAQ9uzpf6m+VxXEsoocDIM+jX+DbJA47Ab/Ao
	 vWzI7cbS6QISmwmXkfbzLJUnBy2WhcjFaOa86dpG3azpF7tVEqt6r8XjBH3ZNFEliX
	 kR42xBL1bsqhO/ZXQ/f9m2NQjRCGM73bNM6GFS7il2MMG1uv6ecjhDVRz/NueD8YvE
	 +ZxH/RmVGO81g==
Subject: Re: [PATCH net v2] ptp: Report clock removal to poll waiters
From: netdev-bot+sashiko@kernel.org
To: thnkslprpt@gmail.com
Cc: richardcochran@gmail.com, netdev@vger.kernel.org, horms@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de, john.stultz@linaro.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 06:50:13 +0000
Message-ID: <179420701368.994134.16970520289562773534@kernel.org>
In-Reply-To: <20261108064928.1931917-2-thnkslprpt@gmail.com>
References: <20261108064928.1931917-2-thnkslprpt@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is incomplete for epoll waiters registered with
  EPOLLEXCLUSIVE.

--

ptp: Report clock removal to poll waiters

This patch makes ptp_poll() return EPOLLERR once the clock is marked
defunct. Before, a poll waiter could take the removal wakeup, see an
empty queue and stay blocked until timeout. It also changes the defunct
accesses in ptp_read() to READ_ONCE() and the store in
ptp_clock_unregister() to WRITE_ONCE().

> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index f63b45f5ee6ae..dc5865e95f775 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -593,6 +593,9 @@ __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
>  
>  	poll_wait(fp, &ptp->tsev_wq, wait);
>  
> +	if (READ_ONCE(ptp->defunct))
> +		return EPOLLERR;
> +
>  	return queue_cnt(queue) ? EPOLLIN : 0;
>  }
>  

[ ... ]

> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 47ffc773065a3..67f53ab4df61d 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -523,7 +523,7 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
>  	get_device(&ptp->dev);
>  
>  	/* Wake up any userspace waiting for an event. */
> -	ptp->defunct = 1;
> +	WRITE_ONCE(ptp->defunct, 1);
>  	wake_up_interruptible(&ptp->tsev_wq);

[Severity: Medium]
Is this fix complete for epoll waiters that registered with EPOLLEXCLUSIVE?

wake_up_interruptible() expands to __wake_up(x, TASK_INTERRUPTIBLE, 1,
NULL), so it wakes at most one exclusive entry and passes a NULL key. An
EPOLLEXCLUSIVE epitem is added to tsev_wq with add_wait_queue_exclusive()
in ep_ptable_queue_proc().

With a NULL key, pollflags is 0, and ep_poll_callback() takes this branch
whenever its epoll instance has a thread blocked in epoll_wait():

fs/eventpoll.c:ep_poll_callback() {
    ...
	if (waitqueue_active(&ep->wq)) {
		if ((epi->event.events & EPOLLEXCLUSIVE) &&
					!(pollflags & POLLFREE)) {
			switch (pollflags & EPOLLINOUT_BITS) {
			...
			case 0:
				ewake = 1;
				break;
    ...
}

__wake_up_common() then stops walking the queue:

	if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
		break;

The remaining exclusive epitems on tsev_wq are never called, so their
epoll instances never re-poll the file. They never reach the new defunct
check in ptp_poll() or the zombie check in posix_clock_poll().

After this wakeup, ptp_clock_unregister() calls ptp_disable_all_events()
and tears down the kworker. posix_clock_unregister() does no wakeup of
its own. Nothing wakes tsev_wq again, so the other EPOLLEXCLUSIVE waiters
stay blocked until their timeout, or forever with a timeout of -1 unless
a signal arrives. That is the same symptom the commit message describes
as fixed:

  "remain blocked until timeout after device removal."

Plain poll/select, non-exclusive epoll, and the wait_event_interruptible()
in ptp_read() all use non-exclusive entries, so they are always woken.
That would explain why all 12 test waits passed.

Would wake_up_interruptible_all(&ptp->tsev_wq) be better for this final
removal wakeup, as sock_def_wakeup() does? A keyed wake-one such as
wake_up_interruptible_poll(..., EPOLLERR) would not help. EPOLLERR has no
EPOLLIN or EPOLLOUT bits, so it still lands in case 0 and sets ewake.

>  
>  	/* Tear down the POSIX clock, which removes the user interface. */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108064928.1931917-2-thnkslprpt%40gmail.com
