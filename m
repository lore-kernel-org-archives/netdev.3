Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956969;
	b=V9udbh4ielcEEyshhQmQa1KB9ut7HbJ3X9+c6Jq0m7Ev9/3z8xEYtVqGrQtUnU7/kf0n
	 0BBlwCLACEZcPfMohbesEL8cT2h1mwbzD5IxuOfqsqgdAL/CB99M7/zVVMb2R0mU10jVH
	 GktiCtvv2a+zyrL3+DXrICf5hK/XoMmpoAOYhitYyfQJpIAWbPfTxBor303tbNlLL0cqh
	 Kf2LWQjMcO0K7Zd6h9iZS34runv7wg1ByCmYtpHzW1Ln/yi3wu+juEgUxqIwelKywXl4E
	 YmKhAThjCwtTqhMK++UGspGNg+WpM3wnpvAmjhOv+8z/O8xUJiwJNZGUVx6ADBDHYMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B2VlpYxIyrjBwpfsYj6tday8nvUyo3/23/5HWi7DkJA=;
	b=Uj4KRAKwrOM4dHungbn9dq/gCEm7PNbfoOk1TqK8fKz3qGRWVZqQiKgfiC3xwe4fHoBL
	 DOTq13BQ3kvdUZ0P0Qo5a40DrcwzWhwuZctCCRvvAIpNjI3diQfoesv+DimYF6DohraKM
	 Es8qWhfQe96XYF+ZzX6mWtG/yjQKBx6LFrFDXzXUKYNLUcwd91uFGlhB6cGueVhDy9jtK
	 6BW+eoXDpqeyyD3wuP6CKVMegx99Sf5lv2Uh28HP4OyBQnzNKqjVD2iCkrp2L0zttiiHb
	 HOotNl5Q0sGboo0R/CDd4AhBnMKpJodEacfp70C1XI9nUPKCwIvjZmr3uumgr+2q0Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ed+zaeMM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B5606D813;
	Fri,  6 Nov 2026 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ed+zaeMM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81F01F0089F;
	Fri,  6 Nov 2026 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956968;
	bh=B2VlpYxIyrjBwpfsYj6tday8nvUyo3/23/5HWi7DkJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ed+zaeMMxZkk0sMX866f+hgUL+LQdcH7o/qgyoCCXq+vPhec3VXmkvw9H9xDLigWw
	 UY59NgQpfozxZ25pJ/8Qp3Y5hEdCF2kdkNTJ5B2MucLA/3E8ng0Wu3PnU1+gE0FSmt
	 BMi33657UPtzIj6cpgeskuDgJH/84aPM+MoqyBa1+cVAkwhijctC2I/DVbGdVgYkKV
	 m+M56yMwhFwDD5wSM8d/QfYvFNONQo6b7EiQMaUSm3gpmeHGevg0deKPMUxWX2Rv7n
	 YQkXB0lwcKfVPiIluNdn/qZXDQaiJPNjFwS3NJLFi9pDniyKA11Sp2ciLyv0ng2bSe
	 I3AhH3FJxH26A==
From: Simon Horman <horms@kernel.org>
To: thnkslprpt@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ptp: Report clock removal to poll waiters
Date: Fri,  6 Nov 2026 09:22:06 +0000
Message-ID: <20261106092205.1168004-2-horms@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102122340.1160733-1-thnkslprpt@gmail.com>
References: <20261102122340.1160733-1-thnkslprpt@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102122340.1160733-1-thnkslprpt@gmail.com?part=1
---
ptp: Report clock removal to poll waiters

The patch adds a check of ptp->defunct to ptp_poll(), placed after
poll_wait() has registered on tsev_wq. ptp_poll() now returns EPOLLERR
when the clock is being removed, so a poll waiter that consumes the
removal wakeup no longer stays blocked until timeout.

> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index f63b45f5ee6ae..01adc70ad97b4 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -593,6 +593,9 @@ __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
>
>  	poll_wait(fp, &ptp->tsev_wq, wait);
>
> +	if (READ_ONCE(ptp->defunct))
> +		return EPOLLERR;
> +

[Severity: Low]
This isn't a bug, but should the other accesses to ptp->defunct be
annotated to match this new READ_ONCE()?

The only writer still uses a plain store, so this load has no
WRITE_ONCE() to pair with:

drivers/ptp/ptp_clock.c:ptp_clock_unregister() {
    ...
	ptp->defunct = 1;
	wake_up_interruptible(&ptp->tsev_wq);
    ...
}

The other lockless reader in this file, ptp_read(), still uses plain
loads:

drivers/ptp/ptp_chardev.c:ptp_read() {
    ...
	if (wait_event_interruptible(ptp->tsev_wq, ptp->defunct || queue_cnt(queue)))
		return -ERESTARTSYS;

	if (ptp->defunct)
		return -ENODEV;
    ...
}

After this patch, ptp_poll() and ptp_read() read the same flag in two
different ways. Other code in this subsystem pairs its annotations
explicitly. For example, queue_cnt() in ptp_private.h notes that its
READ_ONCE() is "Paired with WRITE_ONCE() in
enqueue_external_timestamp(), ptp_read(), extts_fifo_show()".

Would it be more consistent to use WRITE_ONCE(ptp->defunct, 1) in
ptp_clock_unregister() and READ_ONCE() in ptp_read()? The other option
is to leave the new check unannotated like the existing ones.

>  	return queue_cnt(queue) ? EPOLLIN : 0;
>  }
-- 
pw-bot: changes-requested
