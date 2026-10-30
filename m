Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793325155;
	b=YMz7MZ8P0QfpXB763AxbLO0jusnhNXELfy2dMZ2/Flt1RGsMbCosojDtDrx/RpAVzK/r
	 M0fESwiZ6gcpX/cPcSA7QbGyXgfDcdc+e7UO0RiN2Hkvm4Pm2eJaTk/dQxrRmU5UwWupV
	 wuGGVCehFFvIniMEtVh6qOItVxcuaNBb9GaMd2EA4jHmn0q/CkUcc+DjA5S9tS986/sT0
	 l1jZ8eC0L9HFtPOXp+8GxWQimRf0hFl+V1TQlpbe5IqaL51mdgDs7IdaBYO5ucRLBjTNp
	 yY37ibLDCuDtoDUmzZ3Hfg2VrO80DQGpLPBeiwSeiMcWZ4s+2fi1xqadW9ab7Zfosgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793325155;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iAgZRvEwpiP44xE8FEOSGw6YV/JhtzppiMk/eXM/3Eo=;
	b=0toyzRwU3QOOT5LaUCotvCmEsUpbWa2d1EOUEv4Y8CdpdeFLYSO967mCLcv+MkrcjL/O
	 Gnkd4WnziTqw/vOosQ8TS8gJBHM9Q2f0KU28zncllgJrbAcIjvzzKtp3tnA/sw+opS7QO
	 gi5feZYXAxEXoaR3PsV/Aao0Ch83oRscPLwIZVOQlrLfU5bv9QssbN8czQ2ZOLxTjtUGM
	 IddF/k+sAEnn+WEF1Jbw43eP5V3+wwr6Gzh03CCB0Bux2Nuf5M5zoftcQ3EQm+iUUJqGN
	 Eo0Os7EfLOBj/iOuBhxxzDFD/ZK9gt249WP7KGNJOxA1eypM2twDhod3+XLyLIzkaEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfSkkfsL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD05606A31A;
	Fri, 30 Oct 2026 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfSkkfsL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7661F000C1;
	Fri, 30 Oct 2026 01:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793325154;
	bh=iAgZRvEwpiP44xE8FEOSGw6YV/JhtzppiMk/eXM/3Eo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bfSkkfsL/cfh0KSFeH4FLXYz1MBPgsWaG+0J51mIA4tyaec6k23U3MWnmYHcsmDxS
	 l+ivNQ7JJ4uN60rbSWjlyjWXJVQFNlIID4Z/FBznpJn0gDoccgcgteOYRtfrK0WVMw
	 7dc+23Oe83u9e/GD6lsS2hjMnJMF9qSEmpztZR1d9O8z/O3AEAIJ9ZzsJUDCP496l0
	 cuG6nwRdtEQp9onFv32ZZUCjgA8UXFZyjSCPo0kTju/EKZ3Wo+pHSGz69uKCMEiTyW
	 ntW2UaadZgslUqWd1eb6+LBY5ulWP9eU9tGrMzdWXbc6mwAn8/EhShXI42h6hMiNvP
	 8UvTDeW61MyqQ==
Subject: Re: [PATCH net v2] tls: restrict device-down TX fallback to hardware
 TX sockets
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, alice.kernel@fastmail.im,
 tariqt@nvidia.com, borisp@mellanox.com, linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 01:52:33 +0000
Message-ID: <179332515324.3134.6360748215775582303@kernel.org>
In-Reply-To: <20261027015205.2169253-1-rjethwani@purestorage.com>
References: <20261027015205.2169253-1-rjethwani@purestorage.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes two NETDEV_DOWN/setsockopt windows.

Pre-existing issues:
- [High] This bug was not introduced by this patch, but it is a use-
  after-free write that stays reachable for hardware-TX sockets.

--

tls: restrict device-down TX fallback to hardware TX sockets

With this patch, tls_device_down() installs tls_validate_xmit_skb_sw()
only on sockets that have hardware TX offload. This fixes a NULL
dereference on RX-only sockets. The patch also sets tx_conf/rx_conf to
TLS_HW and publishes the HW validator under device_offload_lock, so
tls_device_down() sees a consistent state and releases the driver
contexts.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 1a5f328d80a50..9e0863dd2f96f 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -1176,13 +1176,15 @@ int tls_set_device_offload(struct sock *sk)
>  		goto release_lock;
>  
>  	tls_device_attach(ctx, sk, netdev);
> -	up_read(&device_offload_lock);
>  
>  	/* following this assignment tls_is_skb_tx_device_offloaded
>  	 * will return true and the context might be accessed
> -	 * by the netdev's xmit function.
> +	 * by the netdev's xmit function. Publish it and tx_conf under
> +	 * device_offload_lock so tls_device_down() sees both or neither.
>  	 */
>  	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
> +	ctx->tx_conf = TLS_HW;
> +	up_read(&device_offload_lock);

[Severity: High]
Is there still a third path that leaves the leaked driver contexts and the
stale HW validator that the commit message describes?

Take a socket where one direction is offloaded first, the device goes
down and comes back up, and then the other direction is offloaded:

  setsockopt(TLS_RX) -> tls_set_device_offload_rx()
    tls_device_attach()   /* sk_destruct = tls_device_sk_destruct */

  NETDEV_DOWN -> tls_device_down()
    rcu_assign_pointer(ctx->netdev, NULL);
    list_move_tail(&ctx->list, &tls_device_down_list);
    /* sk->sk_destruct is left as is */

  NETDEV_UP

  setsockopt(TLS_TX) -> tls_set_device_offload()
    tls_dev_add(TX) succeeds
    tls_device_attach()   /* no-op */
    smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
    ctx->tx_conf = TLS_HW;

tls_device_attach() only checks this:

	if (sk->sk_destruct != tls_device_sk_destruct) {

So ctx->netdev stays NULL, no dev_hold() is taken, and the ctx stays off
tls_device_list.

Neither tls_set_device_offload() nor tls_set_device_offload_rx() looks at
ctx->netdev before calling tls_dev_add(). They only check priv_ctx_* and
IFF_UP. The same state can also happen inside a single TX setsockopt, if
the down/up falls between get_netdev_for_sock() and
down_read(&device_offload_lock).

The result is sk_validate_xmit_skb == tls_validate_xmit_skb with
ctx->netdev == NULL. The commit message describes that state as a
regression.

In tls_validate_xmit_skb(), the device never equals NULL, so every data
skb goes through tls_sw_fallback(). complete_skb() then sets
nskb->sk = sk, so tls_is_skb_tx_device_offloaded() still returns true.

mlx5e_ktls_handle_tx_skb() accepts a NULL tls_ctx->netdev:

	if (WARN_ON_ONCE(tls_netdev && tls_netdev != netdev))
		goto err_out;

Would the NIC then apply inline TLS to records that the software fallback
already encrypted, and corrupt the stream? GCM encryption is a keystream
XOR, so a second pass might even send plaintext on the wire. That part
has not been verified.

At teardown, tls_device_queue_ctx_destruction() computes:

	async_cleanup = netdev && ctx->tx_conf == TLS_HW;

That is false here. tls_dev_del(TX) is never called, and the offload ctx
that holds driver_state is freed. Later NETDEV_DOWNs don't see the ctx
either, because it is on tls_device_down_list.

Does this leak the driver TX context?

The RX mirror looks similar: TX HW offload, ifdown, ifup, then
setsockopt(TLS_RX). tls_set_device_offload_rx() sets rx_conf = TLS_HW on
a ctx whose ctx->netdev is NULL. tls_device_offload_cleanup_rx() skips
tls_dev_del() when ctx->netdev is NULL.

Does this leak the driver RX context?

On mlx5, mlx5e_ktls_add_rx() stores priv_rx->sk without taking a
reference, and async work dereferences it later. A use-after-free may
therefore be possible here (not verified).

Also, with the new tx_hw gate in tls_device_down(), RX-only sockets no
longer crash on their first transmit after a down/up cycle. That makes
the RX-first sequence above easy to reach.

Could tls_set_device_offload() and tls_set_device_offload_rx() check,
under device_offload_lock and before tls_dev_add(), whether the ctx is
already device-attached with rcu_dereference_protected(ctx->netdev) !=
netdev? That would include the NULL that tls_device_down() leaves behind.
In that case they could refuse hardware offload and fall back to
software. The other option is to fully re-attach the ctx.

[ ... ]

> @@ -1326,10 +1333,17 @@ static int tls_device_down(struct net_device *netdev)
>  	spin_unlock_irqrestore(&tls_device_lock, flags);
>  
>  	list_for_each_entry_safe(ctx, tmp, &list, list)	{
> +		bool tx_hw = ctx->tx_conf == TLS_HW;
> +
>  		/* Stop offloaded TX and switch to the fallback.
>  		 * tls_is_skb_tx_device_offloaded will return false.
> +		 * Only HW TX sockets have the context the fallback needs.
> +		 * The single read above keeps the fallback and tls_dev_del()
> +		 * below in agreement.
>  		 */
> -		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
> +		if (tx_hw)
> +			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
> +				   tls_validate_xmit_skb_sw);

[Severity: High]
This isn't a bug introduced by this patch, but can this write land in a
socket that has already been freed?

tls_device_down() only pins the tls_context:

	if (ctx_netdev != netdev ||
	    !refcount_inc_not_zero(&ctx->refcount))
		continue;

It then drops tls_device_lock. For every context after the first, the
WRITE_ONCE() through ctx->sk runs after one synchronize_net() for each
earlier context.

Meanwhile, the socket's final sk_free() can run:

  __sk_destruct()
    tls_device_sk_destruct()
      tls_device_queue_ctx_destruction()
        refcount 2 -> 1, returns early
    sk_prot_free()

The TX-only close and destruct paths don't take device_offload_lock, and
tls_device_down() holds no socket reference. So the socket can be freed
while the ctx is still alive.

The TCP slab is SLAB_TYPESAFE_BY_RCU, so by then the memory may belong to
a new, unrelated TCP socket. That socket would get
tls_validate_xmit_skb_sw installed and call tls_sw_fallback() with a NULL
or foreign icsk_ulp_data.

The patch keeps this ctx->sk dereference for every context with
tx_conf == TLS_HW.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027015205.2169253-1-rjethwani%40purestorage.com
