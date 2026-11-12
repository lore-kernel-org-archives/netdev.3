Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447713;
	b=zTYAXRyHB+fXxDlLjSGjzht9/a26rmKH8YKtJovLLCDmVmTD/P07kSMzRB0WUCU8w8MG
	 NhMoXYKxPwjDLhdg5BUbE4Z/K4JbMks9EiN3ZU7h7lZg5Y7CUvPhKWsIW2ZuTcCv/gG6F
	 hbH0ntspHBP7PZKM/+TREh8vYJg/q/20dnLzwphimxiIQRjmMmr5LL4vcX1Q3Mz6Dp95b
	 UOU0syxQvT+inEnUaoqoWSx5IQSMKOyJlvmQ47CoYZUlAfZ2x+RdGB1EbA+j9t/QddBHb
	 jRlacsVXYKRBaz2HrqU1KbMZlxnMvn9Z/iycksmCigx+PILng3g6dJDIgXa6Vn36ndQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447713;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B7vMKo6JfWRAhhBt0UMJ7v83fzhGoRaFbcRBVlJ49g0=;
	b=AWrgc3TLtYDytiJ9brnU+LznlxPpzXFemJQMUFZINPEgO5YQ7ld0G1Qdh1vbyQUG8nTJ
	 0BJGFb9Y5mRNPC3XeSfERopc7ztZbPnectfJ/QP3dc3X99AfrCFqplC282RoaqoRxSvyr
	 86OtVJb/uBqVUAAW7U2k2UOPmBgjRSSrvhX7TQskYezFWakSGhh4p9QUtRmeKOSscVe0O
	 u4bGuxSm+2oA4rCZquNZRkJPH8BUAQcXgBGW0k3Br+4p6u7epewFoqBzPopB26haLzJoL
	 t3ikVgixfVe+9fcWPOnaLybrkmI6A6dGhWAwmOkWAyjvVAuEeyf+kAX6Ub1/mo2xa3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpyPzcGC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51C606A32D;
	Thu, 12 Nov 2026 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpyPzcGC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AA21F00A07;
	Thu, 12 Nov 2026 01:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447713;
	bh=B7vMKo6JfWRAhhBt0UMJ7v83fzhGoRaFbcRBVlJ49g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IpyPzcGCE7Qu4Rq1qT8slR/Tp62lxb+0Y0NL/8vObIHP4+/+5gAJcVzX/OReVywLp
	 nwuXdzXESJEXLSAAVVl4ghvBBEgjMrX+xewg+rlrMfovcHhsZCig+W2N/xzLBpF105
	 o1zhArxYwcEf0aVXMq85cmcURWsq6pxPxwCDCfysmYZVLMXpp0Q8SVftSPUaEu5tWL
	 w0VQDIFvVZ19Kap9Cvxqc3QF760sbn0JjFNIQsqdkY4OPzWLtsSAr4L1o9lqPfBn7P
	 0+fyuqjVEIwlfI8eNZOuIoj/YKQH+hc9LWNVI0zYrLj4yXkiTh4YEXZ/tnbY4aQRxe
	 MMjU6NwI5uOSg==
From: Jakub Kicinski <kuba@kernel.org>
To: peter.hunt@opengear.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	dnlplm@gmail.com
Subject: Re: [PATCH net-next] net: wwan: mhi_wwan_ctrl: say the DTR drop flush is best effort
Date: Wed, 11 Nov 2026 17:41:51 -0800
Message-ID: <20261112014152.3352925-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109185731.182990-1-peter.hunt@opengear.com>
References: <20261109185731.182990-1-peter.hunt@opengear.com>
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
---
net: wwan: mhi_wwan_ctrl: say the DTR drop flush is best effort

This commit updates three comments around the DTR/RTS delayed work so they
match the retry behaviour added by commit 10f51f4fb99d ("net: wwan:
mhi_wwan_ctrl: send a DTR drop before it can be coalesced"). It changes
no code.

Link: https://lore.kernel.org/all/179340002701.3131.15535297427661129303@kernel.org/

> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index 7723199278671..3610613e442e4 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c

[ ... ]

> @@ -216,7 +217,9 @@ static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
>  	schedule_delayed_work(&mhiwwan->dtr_work, 0);
>  
>  	/* A DTR drop matters on its own, e.g. to hang up a modem set to AT&D2,
> -	 * so send it now rather than let a following raise coalesce it away
> +	 * so try to send it now rather than let a following raise coalesce it
> +	 * away. This is best effort, a drop that hits a full UL ring is retried
> +	 * with whatever state is latest by then.
>  	 */
>  	if (drop)
>  		flush_delayed_work(&mhiwwan->dtr_work);

[Severity: Low]
Should the comment in mhi_wwan_ctrl_stop() get the same treatment? The
patch leaves it as is, and it uses the same flush_delayed_work() pattern:

drivers/net/wwan/mhi_wwan_ctrl.c:mhi_wwan_ctrl_stop() {
    ...
	/* Send any pending DTR/RTS state before the channel stops */
	flush_delayed_work(&mhiwwan->dtr_work);

	mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
}

flush_delayed_work() runs mhi_wwan_ctrl_dtr_work() only once. If
mhi_wwan_ctrl_send_dtr() returns -EAGAIN or -ENOMEM, the work re-arms
itself:

drivers/net/wwan/mhi_wwan_ctrl.c:mhi_wwan_ctrl_dtr_work() {
    ...
	if (ret == -EAGAIN || ret == -ENOMEM)
		schedule_delayed_work(&mhiwwan->dtr_work, msecs_to_jiffies(10));
    ...
}

The flush does not wait for that retry, so mhi_unprepare_from_transfer()
can run before the state goes out. That breaks the "before the channel
stops" promise in the same way the old dtr_rts() comment overstated
things.

The commit message also says "the drop and stop() paths now flush the
work as well", so the stop() path was considered, but its comment was not
updated.

A smaller point: the new comment here gives only a full UL ring as the
retry cause. -ENOMEM from kzalloc_obj() in mhi_wwan_ctrl_send_dtr() is
retried the same way. Would it help to mention both, as the comment above
mhi_wwan_ctrl_dtr_work() already does?

[ ... ]
-- 
pw-bot: cr
