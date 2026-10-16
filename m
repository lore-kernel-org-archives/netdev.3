Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB646F4A6
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159637; cv=none; b=Nq9PdjuJymFikWMWwszFsTxlwN+NbaOSDPmBNxoGaaxra/jc38PIEBVmc8aFR2P3eJ1/n9u0CLvsnht2HB/vjtkrqPpQfNDs4Qj/A1BYSCtb8H3Y8xP1y3uyEckX4QzFTcFz+4vo57GfC2pyzlvYb8iK9bA48dH2JS7S0iZQ7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159637; c=relaxed/simple;
	bh=DAh6Fp93qprm/1wlQnubJ77ay2GVKUdeDk6asLieezg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izEVTBICq5Kp+7oarqoDn1ZMd9441J2HTV+nqhVPg/hqC/nzWKowBKowDk68yDXcvUwWf8fyRNvpHNs3gGOedKfGC1jdyJCjBlhI/y5q3ZYk32TMqpZtX18fTShlEtSqgoX/oZcIJ7hfWzBXDdusDV1iFQcdXN5/ze6OCjdixn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF0/7E8W; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF0/7E8W"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-82109f51565so2713230a34.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792159635; x=1792764435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KTVxzuRCuhrQwUoye3QctUW5V1YIHA8YMKvYJ0oRE/U=;
        b=jF0/7E8WeTV9S1k5V4x9gfIV+nURu6pCdyEaN1zUqLuYpHrTZuDhqtHe5jMZR+VNqu
         XgciAbAsmXy2/weNubj4XJ/Mnnoz0Rx9EpjN2VBb6mPItJuukYUZa98OwEMayGf5fv52
         gFFlIGdmDJCBNmQKImQzB9DlY2pRZlIg/huC/HBlSuZpUyH82StnTBxMOTb4a2J2mO+S
         K2pLt4RhigJCJtmJ0i6njyHrCmQ4p0a0h6LeuLkTUz4r89/yvJ3ZhW964WQvmLLAiua5
         XtKb+fPRfMYE4CrgP/nuFHIaR7nZERmCrOVvczuBwfx4gS9qOqSWlCPSNb6TyVN6iN25
         DTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792159635; x=1792764435;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTVxzuRCuhrQwUoye3QctUW5V1YIHA8YMKvYJ0oRE/U=;
        b=KE83Txsw9cP0FbHpfVMI8WpAUkK9FCMB/2kmA0DMiDGqinRSgM6LZKBFlMLQEqnWW5
         8JPdmO2HROSwP+NRGbuu0xw/K0/D8KzdpdCuBRn4ZHcWAsZbHezJ5mLCg6V5qEELP44J
         QWP2ZQbLcC7V5tZfGKxtehnRsIZii4QCqb3MlI2Yg27djWzgiKGM2ft9LKI1gWQ1QnQZ
         bq2pyXGlmYd4cahBhrga4l0tbPw1+//rdi9S+HRhO2Y5QCYpm0Y4FUQ3uDZiagd58hly
         V3Yvmt2RkIFul3qEnNfox85EceKb7JJrXgejJrns+6toM6DfEus1tru4ImCU5ziPFr5S
         W5hg==
X-Forwarded-Encrypted: i=1; AKwUvBxovOVxMH+8drIDGDZcJpzDNurJHbBAJXSPN5HLmuiGlX4PPhC6JNkJ0+hkrtOn7zVDLAjGwCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRbX959ApbIRQFBtwPgqkUGgU/9zQPc+oA52mTm+HDSopJOgTW
	YeO2CrTrqXRV69yQwYFG4jjbut5jxxNBKICrrjdvwR6dAodog0r3g6Ud85Svvw==
X-Gm-Gg: AYBFou0E46oqjiXRQaGfaHM1PU7EvXPrhDJaQ0WlWbxJ/6/XmtvRDvHNCjeE59M5+IT
	KqYu4TZUZPuZANnA4Ra1ZPowvpimaPR6Br196oxWunnwOkVjPubRWvDflSlqpMlhEdggTeiHgyv
	4mwZq1D3yaVFoxi3ZONf9NhHF6VcQA8j4M09cEJU44BUoYxhqE86epKIlRALKGFaZkv1NfeUINl
	tAEApKg5axGUIH8WSSs8TBBxRMBBIAXrBSTpaVTiloJTpTzmmxy3yxzk1NlIlDwUrpRgs3TmkUP
	7ZHcHAKBe/LlBgOvLvzFrrtLcBDPSSmiHsSpWD37vrzfuXVIxtBKsNCGw2YluYQymxwy3udDeZI
	jrxqjWMDoPALhD9yreZ4Roijut+aeKihMP1eB+xkp+U/uznt0W01GftBFQYVelmwsU4KUO4KPFB
	7wjXzSLjJ3ZX3UsktGg2P6ISJoUrxtqF7540DCFRn8L10TlSaCMabs
X-Received: by 2002:a05:6830:6810:b0:7fa:ab72:9e04 with SMTP id 46e09a7af769-83097e59688mr21722042a34.28.1792159634292;
        Fri, 16 Oct 2026 07:07:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a53dac8dsm1989782a34.12.2026.10.16.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:07:13 -0700 (PDT)
Date: Fri, 16 Oct 2026 07:07:12 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/4] vsock/virtio: coalesce RX write-space
 notifications in lock batches
Message-ID: <atIvkN7GJTpsczu8@devvm29614.prn0.facebook.com>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-4-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014115640.184286-4-physicalmtea@gmail.com>

On Wed, Oct 14, 2026 at 07:56:39PM +0800, Jia Jia wrote:
> Each received packet updates peer credit and may call sk_write_space().
> A writer cannot use that credit until the batch releases the socket lock,
> so one notification at batch finish is sufficient.
> 
> Save the initial sk_write_space callback when the AF_VSOCK socket is
> created and require it to remain installed for batching. This lets the
> transport module deliver the deferred notification without referring to
> the unexported default callback. Sockets with replaced callbacks retain
> their per-packet behavior.
> 
> Record the batch socket before processing its first packet so a batch that
> ends on that packet cannot lose the pending notification.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  include/linux/virtio_vsock.h            |  1 +
>  include/net/af_vsock.h                  |  5 +++
>  net/vmw_vsock/af_vsock.c                |  1 +
>  net/vmw_vsock/virtio_transport_common.c | 53 +++++++++++++++++--------
>  4 files changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 26dde6909c4ed..bf077ee0ded88 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -287,6 +287,7 @@ struct virtio_transport_rx_batch {
>  	struct sock *sk;
>  	unsigned int pkts;
>  	size_t bytes;
> +	bool write_space_pending;
>  };
>  
>  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 5549298c1ec6b..9a40960d10cbe 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -63,6 +63,11 @@ struct vsock_sock {
>  	u32 peer_shutdown;
>  	bool sent_request;
>  	bool ignore_connecting_rst;
> +	/*
> +	 * Initial callback, used to identify replacements and deliver deferred
> +	 * write-space notifications.
> +	 */
> +	void (*default_write_space)(struct sock *sk);
>  
>  	/* Protected by lock_sock(sk) */
>  	u64 buffer_size;
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 44cee74519555..fe7f49da6c4bc 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
>  		sk->sk_type = type;
>  
>  	vsk = vsock_sk(sk);
> +	vsk->default_write_space = sk->sk_write_space;
>  	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>  	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>  
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index ff74e805527a5..f4b5f0230493e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1820,6 +1820,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>  	return sk->sk_state == TCP_ESTABLISHED &&
>  	       sk->sk_type == SOCK_STREAM &&
>  	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> +	       READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
>  	       !sock_flag(sk, SOCK_DONE) &&
>  	       vsk->transport == &t->transport &&
>  	       vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
> @@ -1828,13 +1829,15 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>  
>  /*
>   * The caller holds sk's socket lock.  Set @batchable if the socket can remain
> - * locked for another ordinary STREAM/RW packet.  Return true if the caller
> - * must free @skb.
> + * locked for another ordinary STREAM/RW packet.  When @batch is non-NULL,
> + * record a default write-space notification for batch finish instead of
> + * delivering it immediately.  Return true if the caller must free @skb.
>   */
>  static bool
>  virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>  				 struct sk_buff *skb, struct sock *sk,
> -				 bool *batchable)
> +				 bool *batchable,
> +				 struct virtio_transport_rx_batch *batch)
>  {
>  	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>  	struct sockaddr_vm src;
> @@ -1863,8 +1866,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>  	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
>  		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
>  
> -	if (space_available)
> -		sk->sk_write_space(sk);
> +	if (space_available) {
> +		if (batch)
> +			batch->write_space_pending = true;
> +		else
> +			sk->sk_write_space(sk);
> +	}
>  
>  	switch (sk->sk_state) {
>  	case TCP_LISTEN:
> @@ -1931,7 +1938,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  	}
>  
>  	lock_sock(sk);
> -	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
> +	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL, NULL);
>  	release_sock(sk);
>  
>  	/* Release refcnt obtained when we fetched this socket out of the
> @@ -1949,22 +1956,27 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>  
>  /*
>   * Finish the RX batch.
> - * For a non-empty batch, the caller must hold the socket lock acquired with
> - * lock_sock(). This function releases the lock and the batch's lookup
> - * reference.
> + * For a non-empty batch, the caller holds the socket lock acquired with
> + * lock_sock(). Deliver any deferred write-space notification while the lock
> + * is held, then release the lock and the batch's lookup reference.
>   * An empty batch is a no-op.
>   */
>  void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>  {
> +	bool write_space_pending = batch->write_space_pending;
>  	struct sock *sk = batch->sk;
>  
>  	batch->sk = NULL;
>  	batch->pkts = 0;
>  	batch->bytes = 0;
> +	batch->write_space_pending = false;
>  
>  	if (!sk)
>  		return;
>  
> +	if (write_space_pending)
> +		vsock_sk(sk)->default_write_space(sk);

Any reason not to just do READ_ONCE(sk->sk_write_space)(sk) instead of
storing this for later? If we setup the socket in a sockmap program
mid-batch, doesn't this and sk_data_ready (from the next patch) go
stale?

> +
>  	release_sock(sk);
>  	sock_put(sk);
>  }
> @@ -2019,7 +2031,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  			}
>  
>  			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
> -								    &batchable);
> +								    &batchable,
> +								    batch);
>  			if (!batchable)
>  				virtio_transport_rx_batch_finish(batch);
>  			if (free_pkt)
> @@ -2059,23 +2072,31 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  
>  	lock_sock(sk);
>  	/*
> -	 * Sockmap removal restores the native protocol under sk_callback_lock.
> -	 * Serialize this initial eligibility check with that update.
> +	 * Sockmap teardown restores callbacks under sk_callback_lock. Keep the
> +	 * initial eligibility check consistent with that update.

Why reword here?

>  	 */
>  	read_lock_bh(&sk->sk_callback_lock);
>  	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
>  	read_unlock_bh(&sk->sk_callback_lock);
>  
> +	if (start_batch)
> +		batch->sk = sk;
> +
>  	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
> -						    start_batch ? &batchable : NULL);
> +						    start_batch ? &batchable : NULL,
> +						    start_batch ? batch : NULL);
>  	if (start_batch && batchable) {
>  		/* Keep the lookup reference until the batch is released. */
> -		batch->sk = sk;

Seems like `batch->sk = sk` is moving around between patches?

I don't know, feels like if the batching patch introduces
sk_write_space/sk_data_ready bugs, then that patch should probably
contain these patches too. Should minimize churn too?


>  		return;
>  	}
>  
> -	release_sock(sk);
> -	sock_put(sk);
> +	if (start_batch) {
> +		virtio_transport_rx_batch_finish(batch);
> +	} else {
> +		release_sock(sk);
> +		sock_put(sk);
> +	}
> +
>  	if (free_pkt)
>  		kfree_skb(skb);
>  }
> -- 
> 2.53.0
> 

Best,
Bobby
