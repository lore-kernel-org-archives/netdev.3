Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522338;
	b=pYjOSdsUOUKRFhg4M0TI+iNXZS06gNFMB/WJ+U1HvdHZpyFiNdI9lql7LkuKMmdSD5Aq
	 DupH+82Mivqz2N4egQkwgGzSjnPntuaBvtGS9zaek7hI20fcbGKYZjWksFdDgnWAdvE9r
	 ni+M0/w0b4ZX9Bh8EdH+hFHJ0KTT+K8zFY6LeLDPMZuGheou7I/G0LZSB0SjiFQXcp2rk
	 aY0EeLLHVEy2Fk++x5lj2GiYxW7XT8PoMZGB1AuG26s7/wn7T7X/nkRwAq9CBx9M5looS
	 h5Nn48NdHZ1CUAWuV/yVv4zM5gwe7zgfGTtRj9F5hSCAh/bHdYTGlclMxdSvpjAqTrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522338;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=udVHZ0c7sagTgvMG1egb97n6WIhPbLn9o2NBLELr7wc=;
	b=W8r6EdstsSrBvKPCGknXeSC/YsU93Op3bp4wpApj98K36MI0viwjNYrbmXOOqcbmDgP+
	 UPtQfd4YngCnSCyLIYketOTr2suMiRCEwNC0GEToMbK1caA4v5+8+nDS0gEAEwQlqE1f/
	 f0dxAL7+TkAqy7N9+IP3Gp3ZNbOSn034GkckRhPe4fidiC0wOGPlaV9GGwF7vLKvlSzxi
	 3mmaQeBf3C5tyM/kJ/yAmOi8h0GD3TiKhBGsWm1E9b6PfJ7nlOqpt3zvXl/J8rj0UQ6CI
	 LhS9SLlkEUojvpKn+FdJE6OGbs4NT71gAuXJPBqOjVD7753HOka/+7ffX0xtHOYWTJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1a7FmE4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6EE606A320
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1a7FmE4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0684D1F000CA;
	Tue, 20 Oct 2026 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522337;
	bh=udVHZ0c7sagTgvMG1egb97n6WIhPbLn9o2NBLELr7wc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h1a7FmE44vVXZR1ULeENSY/DatA1eOpqL8dRz+C5nwDRNdVIBhngbvxqQkIkoiasv
	 1Vb55xNsC99WifaAETn3ry1XMPPcoNc/brOScszj0gbwExSK1aw2ltPu8d8MHLZajK
	 YCsOS8QykqTPiNFFwV4WUla2gH+XujUPxMezJbEVB25ZGfl/vXgOjuGoTCEqbtyPJC
	 zmb9MChGsRG35ti1ZXKSA057FYn5bKTFlus63BKheFEpizIwfT+FeZWlePWRHG/jxE
	 MykJrAyJi4h47U/8CtdTlD9vXL5UTtKhrkMw9g6NQfvAc2ROLoj6HJ0zFWatxOy/5L
	 A7kX5aStS6U3A==
Subject:
 Re: [PATCH net] tls: restrict device-down TX fallback to hardware TX sockets
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tariqt@nvidia.com, alice.kernel@fastmail.im, netdev@vger.kernel.org
Date: Tue, 20 Oct 2026 18:52:16 +0000
Message-ID: <179252233651.3135.5092184288688157280@kernel.org>
In-Reply-To: <20261016183435.23382-1-rjethwani@purestorage.com>
References: <20261016183435.23382-1-rjethwani@purestorage.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In tls_device_down() (net/tls/tls_device.c:1326-1328), the patch
  makes the switch to tls_validate_xmit_skb_sw() depend on `ctx->tx_conf…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but this sequence
  leaves a socket with HW TX state that the TLS core cannot track.
- [Medium] This problem wasn't introduced by this patch, but
  tls_device_down() calls tls_dev_del() only when ctx->tx_conf /…

--

tls: restrict device-down TX fallback to hardware TX sockets

This patch makes tls_device_down() install tls_validate_xmit_skb_sw() only
when ctx->tx_conf is TLS_HW. It does this so RX-only and software-TX
sockets don't go through tls_sw_fallback(), which needs a hardware TX
context and crashes when priv_ctx_tx is NULL.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f11d0528fc431..15ef6c3c06487 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -1319,8 +1319,13 @@ static int tls_device_down(struct net_device *netdev)
>  	list_for_each_entry_safe(ctx, tmp, &list, list)	{
>  		/* Stop offloaded TX and switch to the fallback.
>  		 * tls_is_skb_tx_device_offloaded will return false.
> +		 * Only sockets with offloaded TX have the
> +		 * tls_offload_context_tx the fallback needs; leave RX-only
> +		 * and SW-TX sockets alone.
>  		 */
> -		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
> +		if (ctx->tx_conf == TLS_HW)
> +			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
> +				   tls_validate_xmit_skb_sw);

[Severity: High]
Can ctx->tx_conf still be TLS_BASE here for a socket that already has HW TX
offload attached and tls_validate_xmit_skb installed?

tls_set_device_offload() puts the ctx on tls_device_list and drops the lock
before tx_conf is set:

net/tls/tls_device.c:tls_set_device_offload() {
    ...
	tls_device_attach(ctx, sk, netdev);
	up_read(&device_offload_lock);
    ...
	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
    ...
}

Only after it returns does do_tls_setsockopt_conf() store the conf:

net/tls/tls_main.c:do_tls_setsockopt_conf() {
    ...
	if (tx)
		ctx->tx_conf = conf;
    ...
}

That store holds lock_sock but not device_offload_lock. tls_device_down()
holds device_offload_lock for write but not lock_sock, so nothing orders
the store against this read.

Suppose NETDEV_DOWN lands while the setsockopt task is preempted between
up_read() and the tx_conf store. tls_device_down() then sees TLS_BASE and
skips the WRITE_ONCE(). It clears ctx->netdev and moves the ctx to
tls_device_down_list, so no later device-down visits it again. The HW
validator tls_validate_xmit_skb stays installed for good.

After synchronize_net(), the tls_dev_del(TX) check reads tx_conf a second
time, and that read can return a different value:

		if (ctx->tx_conf == TLS_HW)
			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
							TLS_OFFLOAD_CTX_DIR_TX);

If it sees TLS_HW, the driver TX state is freed. In mlx5,
mlx5e_ktls_del_tx() destroys the DEK and calls pool_push() on priv_tx.

If it sees TLS_BASE, the driver state leaks and stays live.

Either way, tls_validate_xmit_skb() never matches the NULL netdev, so every
skb goes through tls_sw_fallback(). complete_skb() keeps nskb->sk = sk, so
tls_is_skb_tx_device_offloaded() still returns true.

mlx5e_ktls_handle_tx_skb() accepts a NULL tls_ctx->netdev:

	if (WARN_ON_ONCE(tls_netdev && tls_netdev != netdev))
		goto err_out;

	priv_tx = mlx5e_get_ktls_tx_priv_ctx(tls_ctx);

So it either uses a freed and recycled pool entry or HW-encrypts an
already-encrypted record a second time.

That goes against the comment in this function ("tls_is_skb_tx_device_
offloaded will return false" and "no non-encrypted packets will be passed
to the driver"). It looks like the same bug class that c55dcdd435aa, the
commit in the Fixes: tag, addressed.

The old unconditional WRITE_ONCE() only left the gap between up_read() and
smp_store_release() open. The new check also misses the common ordering,
where the HW validator has already been published.

Would it be more robust to key off the installed validator rather than
tx_conf? For example:

	cmpxchg(&ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb,
		tls_validate_xmit_skb_sw);

Another option would be to publish a "HW TX present" marker under
device_offload_lock before the ctx is attached.

>  
>  		/* Stop the RX and TX resync.
>  		 * tls_dev_resync must not be called after tls_dev_del.

[Severity: Medium]
This is a pre-existing issue, and this patch doesn't introduce it. The same
window seems to affect the driver teardown later in tls_device_down().

tls_set_device_offload() and tls_set_device_offload_rx() both call
tls_device_attach() and up_read(&device_offload_lock) before
do_tls_setsockopt_conf() sets tx_conf or rx_conf.

If NETDEV_DOWN finds the ctx while the conf is still TLS_BASE, it skips:

		if (ctx->tx_conf == TLS_HW)
			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
							TLS_OFFLOAD_CTX_DIR_TX);
		if (ctx->rx_conf == TLS_HW &&
		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))

It then sets ctx->netdev = NULL. On close,
tls_device_queue_ctx_destruction() computes:

	async_cleanup = netdev && ctx->tx_conf == TLS_HW;

This is false, so tls_device_tx_del_task() never runs, and
tls_device_free_ctx() frees the offload context without calling
tls_dev_del().

Does this leak the driver's per-connection HW state? In mlx5 that would be
priv_tx or priv_rx, the DEK, and the RX flow steering rule. mlx5's priv_rx
also keeps a bare priv_rx->sk pointer without holding a socket reference.

[Severity: High]
This is also a pre-existing issue, but with this patch RX-only sockets now
survive a device down/up cycle. That makes the following sequence easier
to reach.

After tls_device_down() processes an RX-offloaded socket, ctx->netdev is
NULL, the ctx is on tls_device_down_list, and sk->sk_destruct is still
tls_device_sk_destruct.

Once the device is back up, the socket owner can call
setsockopt(SOL_TLS, TLS_TX). tls_set_device_offload() checks only
ctx->priv_ctx_tx, the netdev features and IFF_UP. It does not check
TLS_RX_DEV_DEGRADED or ctx->netdev. It calls tls_dev_add(TX) and then
tls_device_attach(), which does nothing:

net/tls/tls_device.c:tls_device_attach() {
	if (sk->sk_destruct != tls_device_sk_destruct) {
		refcount_set(&ctx->refcount, 1);
		dev_hold(netdev);
		RCU_INIT_POINTER(ctx->netdev, netdev);
    ...
}

ctx->netdev stays NULL, no dev_hold() is taken, and the ctx stays on
tls_device_down_list. tls_validate_xmit_skb is installed anyway.

Does this leave the driver holding HW TX state that the TLS core can no
longer track?

Every skb fails the netdev match and goes through tls_sw_fallback(), but
tls_is_skb_tx_device_offloaded() still returns true. A driver such as
mlx5e_ktls_handle_tx_skb() then processes the already-encrypted record
again.

AES-GCM is CTR based, and both passes use the same key and nonce. This
could put plaintext on the wire with a valid tag. That part is inferred
from GCM semantics and has not been tested.

Later NETDEV_DOWN events never visit this ctx. On close,
tls_device_queue_ctx_destruction() sees netdev NULL and skips
tls_dev_del(TX). The driver TX context and key leak, and priv_tx->tx_ctx
is left pointing at freed memory.

Should tls_set_device_offload() refuse to add TX offload for a ctx that has
already gone through tls_device_down()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016183435.23382-1-rjethwani%40purestorage.com
