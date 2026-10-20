Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488954;
	b=PRV3b5ORGvshoUGCPieGahrd2zvQUXYCEMJGFoARygnXwMc69hxpljMeoSHPrw4VIeWw
	 ihUaualC1Lj1gZI5eVSLcCJd17vQXaZkFd9+Opd6QJp9r6Jkf1y8RFNSR4YcmUW6NuQzI
	 TGWdU/SM0xu4/T/OeIslK/zcYKGSW6GWU7gn16U7kHZ5VmuNPbBZOYLR2rI3Vo6An8fSz
	 P6z0H7jfZolYkYhxAJGN2zMa6+C/YW2HefcsLomo2P2qi66KncE4OZaOjCceNkjiNdmZr
	 2S2LIzmAfQCsaypXGtCQSXBRR4S7eHFOe52HB5nJyn2dfzJmYT8MeagIHAS+m3wANxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488954;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HSmjPI16nvDN8Ul0NAtxX99vasGqIsxArWPRVzPVvL4=;
	b=axmDNX00zdS/lx28xxRUIlOp7LyLM1+cOt5q5B36AI3WenVoMcZMYb6FTCTmarDAEpMC
	 AxMPt5og/8pZXhRz8iaiVuVzXgMaG/y0ZyPqgn7CUT0QPLP0i0Mh85hlHOGeBconoSBqp
	 e2slpfvPP6vsPwTt38+XV8DLikt1wxoVDPHfXTmnUaoJVWJ2qFmz+2CND4jUiso3YqIiE
	 IvbI6cZahbE90C2i7wPHvbLZwuJH321l/c9k8+40JRa7TE5C9r2AIsxH2VWQEjowNQa49
	 Fol+o1HwpKhqkGV7217iswWPRnhw5BhJvazjP/bUTIuKAMJl/q8AsiyCas1oCTdL3Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0LhVunn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE5606A327;
	Tue, 20 Oct 2026 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0LhVunn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AE61F000C4;
	Tue, 20 Oct 2026 09:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792488953;
	bh=HSmjPI16nvDN8Ul0NAtxX99vasGqIsxArWPRVzPVvL4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T0LhVunnP9LkJ49WUDcR9bg/c+SeBVw6wOT7ZN4DiA4Z8Xx179x45rntpoC609Z1u
	 TORpH9toScTu8AeJTwyup6DjDuBZq3Kcyhlr1f/bSq+q54MlYJu/CVEjxYesBObVdV
	 /jiDggaRbY3vtKUp+sj7Im5MJ1DwRmK9mV5+8Htca0m43c6s9epKuTj6cndHgh8HLS
	 t7xhO9rFWJYEoEWHg6JCNSXMGK/z8Q1uz6hoRvZHKoeFq5eKPDvKbDSeV95RlJraYy
	 NzwPjXjjKh0Zb5ew76X63yvHI6mMELqeDLjt4l/IeOdvJ76X0f2ENCN90ZYCHTpSwb
	 q4hbF+74Gm6tA==
Subject: Re: [PATCH net-next 1/3] net: qrtr: do not take the sock lock on
 blocking recv
From: netdev-bot+sashiko@kernel.org
To: chunkai.deng@oss.qualcomm.com
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 tao.zhang1@oss.qualcomm.com, peter.chen@oss.qualcomm.com,
 jeff.johnson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Date: Tue, 20 Oct 2026 09:35:52 +0000
Message-ID: <179248895205.3135.9429539491944688688@kernel.org>
In-Reply-To: <20261016-qrtr-add-shutdown-v1-1-e1cc01ca5919@oss.qualcomm.com>
References: <20261016-qrtr-add-shutdown-v1-1-e1cc01ca5919@oss.qualcomm.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit "net: qrtr: do not take the sock lock on blocking
  recv" fixes a real, user-visible defect but has no Fixes: tag.
- [Low] The concern says qrtr_ioctl(TIOCINQ) (net/qrtr/af_qrtr.c:1234),
  which calls skb_peek(&sk->sk_receive_queue) under lock_sock() only, is…

--

net: qrtr: do not take the sock lock on blocking recv

This patch changes qrtr_recvmsg() so it no longer holds lock_sock() while
it blocks in skb_recv_datagram(). The lock is now taken only after a
datagram has been dequeued. Before this, other calls on the same socket
could not run while a recv() was waiting.

> Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>

[Severity: Low]
Should this have a Fixes: tag? The commit message describes a hang that
users can see. A thread blocked in recv() holds lock_sock() inside
skb_recv_datagram(). While it waits, sendmsg(), bind(), connect() or
ioctl() from another thread on the same socket cannot proceed until a
datagram arrives.

In qrtr_recvmsg(), the lock_sock() held across skb_recv_datagram() and
the release_sock() calls on the early return paths all come from the
original driver, so perhaps:

Fixes: bdabad3e363d ("net: Add Qualcomm IPC router")

> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index e7b3647424b8f..0851763d83baf 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -1109,18 +1109,14 @@ static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
>  	struct qrtr_cb *cb;
>  	int copied, rc;
>  
> -	lock_sock(sk);
> -
> -	if (sock_flag(sk, SOCK_ZAPPED)) {
> -		release_sock(sk);
> +	if (sock_flag(sk, SOCK_ZAPPED))
>  		return -EADDRNOTAVAIL;
> -	}
>  
>  	skb = skb_recv_datagram(sk, flags, &rc);
> -	if (!skb) {
> -		release_sock(sk);
> +	if (!skb)
>  		return rc;
> -	}
> +
> +	lock_sock(sk);

[Severity: Low]
This isn't a bug, but the dequeue now happens outside lock_sock(), so
qrtr_ioctl(TIOCINQ) is no longer serialized against it:

net/qrtr/af_qrtr.c:qrtr_ioctl() {
    ...
	lock_sock(sk);
    ...
	case TIOCINQ:
		skb = skb_peek(&sk->sk_receive_queue);
		if (skb)
			len = skb->len;
    ...
}

As far as I can tell this is still memory safe. skb_free_datagram() in
qrtr_recvmsg() still runs under lock_sock(). The consume_skb() in
skb_set_peeked() only drops a reference on a shared skb.

The length TIOCINQ reports also matches some valid ordering of the ioctl
and the recv. The unlocked skb_peek() racing with __skb_queue_tail() on
the enqueue path was already possible before this patch.

Would it be worth taking sk_receive_queue.lock around the skb_peek() in
TIOCINQ, as packet_ioctl() does? Then the ioctl would not rely on
qrtr_recvmsg() freeing the skb under lock_sock().

>  	cb = (struct qrtr_cb *)skb->cb;
>  
>  	copied = skb->len;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-qrtr-add-shutdown-v1-0-e1cc01ca5919%40oss.qualcomm.com
