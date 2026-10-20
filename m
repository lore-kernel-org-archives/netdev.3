Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488956;
	b=3Z7LQiHmHHQsaJ88RpC+DsJwZJeEY64BzxB/j/VqQLarJUrTr7dEJMgZaOfDokBUDEYt
	 batIGB1oVcvRTzYRUY+dvgDh6o5WKoJSMfsofvw/HQXdYriwZmrLcUG4kgY4QmSM90hc8
	 rPI4I8l4OTQ2D17dAYeDesDZ/F5G+Lvj5E5hwJYtyI57KcYhqnrlZ/A0lnxFZ8IcPCQCe
	 qRDY4yAk5Vwxo/r/xsCGD0vQaElqVJg9a0kijRtJvktrZq9NgFALLuMT4bc6DhiKlNRa2
	 SCi7g7WIbMcBbXveE+hSx6TI9QaFBCQcHoYt4sfJOxVakR9zMjm8Nii1CP1/5B6fuVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488956;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DmBZqT4kDURn/Q/aVDSwiHBGADQ7218v0k2fMHT5IG4=;
	b=ZtBH5ZVvVBWxtATynUU8H3MT747S0WfQZQJEE0Vnle5RgHDI656KJ64QT3MaBkbUySOq
	 RhaYnRQGIEXCN7zMJVGdhqc5jc45J21TnFfceYqB5n1GR6PsSASYyDPG/iIvhLbHovsQ9
	 g/wdqfcykSFbp/wgxRPvpVclmezjGDbcScI7enEyRlhyPpgoHDgw00rW+OVC50LdWjUiJ
	 WitYMnNtWVjYSihmCqvSoojEzbjPc+8CTov39skhJBIcIWAA9Qa8TwSQX+Wtd+WO1hF12
	 Vf5KHPabR7lar2XmnidosjVIFMh/3CdFUhAvE7gcQ0fwskstbzl7WgLas7lU3OOcXEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/n6xe59";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B56606A32F;
	Tue, 20 Oct 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/n6xe59
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA5C1F000CA;
	Tue, 20 Oct 2026 09:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792488956;
	bh=DmBZqT4kDURn/Q/aVDSwiHBGADQ7218v0k2fMHT5IG4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G/n6xe59JHFjBkoLCQ5PZ5cvrjM74taW5CSYGC3gZeiyPLlCjonLaXlzkS284Kpe5
	 LyDjZCx7jKRo4zBy0UkeCDPzIPSSnZfc9zrNn22Mi11SX62Mr3sbuy5XjLm14VYVSM
	 QRfkHngjo5gKylr3QFDf+Vb+U3+NBW9jfzR+Qd/NhI4uOYMKq75holjS/sqLjnzynr
	 9e1DEakPN/fOu73gR0Xpd+Zig3JtaxLYoZRYPKEedLu/yHl3IhCnuTnxyDqe/DrREx
	 h+lpt0iL3N1ISCBgI6a802kzG9BXFRRyeLNVtA6UP7P66d2lDyyvy86aYH3jR0RSKb
	 MSYLh91V/C8Uw==
Subject: Re: [PATCH net-next 3/3] net: qrtr: implement shutdown()
From: netdev-bot+sashiko@kernel.org
To: chunkai.deng@oss.qualcomm.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 tao.zhang1@oss.qualcomm.com, peter.chen@oss.qualcomm.com,
 jeff.johnson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Date: Tue, 20 Oct 2026 09:35:54 +0000
Message-ID: <179248895481.3135.9231497728918795508@kernel.org>
In-Reply-To: <20261016-qrtr-add-shutdown-v1-3-e1cc01ca5919@oss.qualcomm.com>
References: <20261016-qrtr-add-shutdown-v1-3-e1cc01ca5919@oss.qualcomm.com>
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

- [Medium] net/qrtr: shutdown() API violation leaves sendmsg() threads
  hung

--

> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -1193,6 +1194,36 @@ static int qrtr_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  	return rc;
>  }
>  
> +static int qrtr_shutdown(struct socket *sock, int mode)
> +{
> +	struct sock *sk;
> +
> +	if (mode < SHUT_RD || mode > SHUT_RDWR)
> +		return -EINVAL;
> +
> +	/*
> +	 * This maps:
> +	 * SHUT_RD   (0) -> RCV_SHUTDOWN  (1)
> +	 * SHUT_WR   (1) -> SEND_SHUTDOWN (2)
> +	 * SHUT_RDWR (2) -> SHUTDOWN_MASK (3)
> +	 */
> +	mode++;
> +
> +	sk = sock->sk;
> +
> +	/*
> +	 * Do not use lock_sock() here: sendmsg() holds it while sleeping on
> +	 * remote flow control, which would block shutdown() indefinitely.
> +	 * The spinlock only serializes concurrent shutdown() callers.
> +	 */
> +	spin_lock_bh(&sk->sk_lock.slock);
> +	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | mode);
> +	spin_unlock_bh(&sk->sk_lock.slock);
> +	sk->sk_state_change(sk);
> +
> +	return 0;
> +}
> +
>  static int qrtr_release(struct socket *sock)
>  {
>  	struct sock *sk = sock->sk;

[Severity: Medium]
With this change shutdown(SHUT_WR) returns 0, but a thread that is
already sleeping in qrtr_tx_wait() from qrtr_sendmsg() is not woken.
sk->sk_state_change() only wakes the socket wait queue. The sender
sleeps on flow->resume_tx instead, and the wait condition in
qrtr_tx_wait() only looks at flow->pending, flow->tx_failed and
node->ep, never at sk->sk_shutdown.

The changelog does call this out, but it breaks the common pattern of
calling shutdown() from one thread to kick a blocked writer out before
joining it. That now hangs until the remote hands back credit or a
signal arrives. Before this patch userspace at least got -EOPNOTSUPP
and knew it had to use some other mechanism.

The stuck sender also still holds lock_sock(). So the close() that
normally follows the shutdown() then sleeps uninterruptibly in
lock_sock() in qrtr_release(), as do ioctl() and the other
lock_sock() users, which is hung task territory.

Would it be feasible to also check SEND_SHUTDOWN in the qrtr_tx_wait()
condition and wake the relevant flow->resume_tx from qrtr_shutdown()?
The flow is keyed by node and destination port, so it is not obvious
how to reach it from the socket. Did you consider recording the flow
the sender is waiting on, or is there a reason to leave this for a
follow-up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-qrtr-add-shutdown-v1-0-e1cc01ca5919%40oss.qualcomm.com
