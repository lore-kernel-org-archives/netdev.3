Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CA49A3B4
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842579; cv=none; b=HKdEsuI8L8KYoFH1Kl09A2dE5zF78b+dSvtTYNfri1iHjSQwLriDtSb8O8p2tqFaTNCZ7SAgfW+YjBE+8g/4QXYIfJOfbtrnJCsse2jqg29kp/xUSMUcfcYeTXQDIA0J+TpdTx9Ha1pzSEMKt1H7nWM/MxxaYeTn3GWNnqoFaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842579; c=relaxed/simple;
	bh=xrEfK09sOgKPL8tRakdgdLoY5A4I63z1FJ2ZQnHI7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuU1lCcb+wVLfDD06d0bwA7V77mnddshru+McxfMP4a7LqQ7tdn66MTjLxW4fREcelwmK4DvoagAKYFcc37O+ZSObjalWez7hLH5bUXJnL4Wx2vk0W1EYRrNtzFfL8s6Y7S5EPQBgNMd9EdHybGipLUEjtBKe2ZYKUpBLQhvZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRiydYkw; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRiydYkw"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-824e6e6ed71so1961394a34.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791842575; x=1792447375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I34AgC3qXFsIWry2eO2C25CSCiy4N0N7n6VOFiD93pA=;
        b=kRiydYkwm255TVNGaaXvWy0gF4ej5bPf3TqHDwP3qKW0UQGyjZQ780kY3RNVw4HJup
         7FWZPEJde/7aULp3ql+ntkK990fXm/oUCr0HaTgLyKms9PnoQVCl2iG/tULiR4UBQFnq
         ylW+eb1e+rPaNKFkzqApVWG2dHMFnNBsxACTFeCYL0KpzlLT4Qt4jSlpm7i0kcJTWW5B
         OcOJt6mQwDfU3fUU6Lq/UqZRaBmRZl1o7GcaHzUh6ADz16dTNwoWs8tjvtByTesE2+3L
         yK8SWpsslmB23wVOL8Y2F4wAyUyFKBBd9gkkuvveLznuZwf6OJLWdIS5W9WXbmvbfrtt
         SKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842575; x=1792447375;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I34AgC3qXFsIWry2eO2C25CSCiy4N0N7n6VOFiD93pA=;
        b=x01OlNvOu5Bcp518LI0RBXgtOrZ4aG6/+pQnviOuUVjnur7zmfyn6xDihUVnSYBngR
         +JiMY3ge7EWJ9BDMygVCctSWzsGxypYvYkn8y5GoQmVPsKpbwtdMllfQTSzSQAwFFDw2
         1/F5ulQAoVpI+5vg5LZOz4hZqyi9mgI7UvCjgwXASMzR7QyQnIz/axyNNcIIiSro6jJM
         tOdkU+w4y/TUVD3KV5qH2Rky4eFSMuf3O95vrEi06YKHiHoQ/0ZrGZQi6zNgLqvBElV8
         Ccq6uvbcOKVY2ni9OMRJMnOKBkRiSnzJ4J6uRKMsczO2kRlaz+OLvcUHlRB2SgkOIQgp
         WEKA==
X-Forwarded-Encrypted: i=1; AKwUvBx2FCAruhqptn2UFWgsqgaTbur4riYbycoPM2t/tfuLvjOzVcsJ3ttcfvFGXXjQHhVKxEviXSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcjgz5Pi1fRfz+UxA6SNjB7O5VW9JU4z1zOvHC4rJOE966V3Qh
	fuwdZPXrz0hokZzOZyNDW07KfT4Q1PuEBqffJfU3Y1qYuK73ynE9dJR0
X-Gm-Gg: AYBFou3U9eqADzvja4LCO1Af8bopk+9Zj2Fg+ql5gtSRKZ3gDP1GRG1IRDC4TIjZXFT
	q3/14he2miMHqqBnlIZQou1dnRRsf1QJCkxR7mSjoptKmQ/jnylACM7WoVw34++sMet/Nlq+CAt
	o351ey9zhYN02GQjT9rHJEUTWajo10ojOzAEzsJ74akU1ve7EeJeWNCZ8JknDMG9N97Pijv5Qfv
	3BkGFUG/UFTjQNdokw564IIKXo0C9jI+Hwk3YNLj40FG2fNtUF7WBDABlD/dHwivDlfNV66ZXSw
	xUX8w1sgwsQhNJ7ddnE8EeXV/f5/ZjIZyfBFOpVshACNZylCvgILBJUGfnplHdnEcWHCOEMD0/C
	3/rmS0UtClbO3s/BZmgAhLiGSE3+skujFGFT2nuNCkN8nDqFpHYTaSr/E9Zcy6EbGlLuJdTBmDD
	98OvhRT6f4cnUyLXI+8rvfV6qMaoWqP+8pWMEo2l8c624W21ZNHST0TVUKu69OXKmgwWm5Vgj+y
	PFmYUeI71ObX+sq4B3ZEC4Nki1v9w==
X-Received: by 2002:a05:6830:43a0:b0:81c:4784:a5e2 with SMTP id 46e09a7af769-83094e738d8mr9929561a34.6.1791842575557;
        Mon, 12 Oct 2026 15:02:55 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303494f64csm10655830a34.3.2026.10.12.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:02:53 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:02:50 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010142247.99223-2-physicalmtea@gmail.com>

On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> Split virtio_transport_recv_pkt() so socket lookup is separate from the
> receive state machine that runs under the socket lock.
> 
> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> Pass the source and destination addresses used for lookup to the locked
> receive path so they are decoded only once.
> 
> Pass the network namespace and decoded address tuple through a packet
> context to the locked receive path.
> 
> Preserve source validation and failure handling. Keep the lookup reference
> separate from the skb owner reference so the locked receive path can manage
> the two lifetimes independently.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
>  1 file changed, 96 insertions(+), 43 deletions(-)
> 

[...]

> +/*
> + * The caller holds sk's socket lock and must free skb if this returns true.
> + */
> +static bool
> +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> +				 struct sk_buff *skb, struct sock *sk,
> +				 const struct virtio_transport_rx_pkt_ctx *ctx)
> +{
> +	const struct sockaddr_vm *src = ctx->src;
> +	const struct sockaddr_vm *dst = ctx->dst;
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	struct net *net = ctx->net;
> +	bool space_available;
>  
> -	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	/* Check after acquiring the socket lock. Listener sockets accept packets
> +	 * from any source and are not assigned to a transport.
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
>  	    (sk->sk_state != TCP_LISTEN &&
> -	     !vsock_check_source(vsk, &t->transport, &src))) {
> +	     !vsock_check_source(vsk, &t->transport, src))) {
>  		(void)virtio_transport_reset_no_sock(t, skb, net);
> -		release_sock(sk);
> -		sock_put(sk);
> -		goto free_pkt;
> +		return true;
>  	}
>  
>  	space_available = virtio_transport_space_update(sk, skb);
>  
>  	/* Update CID in case it has changed after a transport reset event */
>  	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> -		vsk->local_addr.svm_cid = dst.svm_cid;
> +		vsk->local_addr.svm_cid = dst->svm_cid;
>  
>  	if (space_available)
>  		sk->sk_write_space(sk);
> @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  		break;
>  	}
>  
> +	return false;
> +}
> +
> +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> + * lock.
> + */
> +void virtio_transport_recv_pkt(struct virtio_transport *t,
> +			       struct sk_buff *skb, struct net *net)
> +{
> +	struct virtio_transport_rx_pkt_ctx ctx;
> +	struct sockaddr_vm src, dst;
> +	struct sock *sk;
> +	bool free_pkt;
> +
> +	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> +	virtio_transport_trace_recv_pkt(skb, &src, &dst);
> +
> +	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> +	if (!sk) {
> +		(void)virtio_transport_reset_no_sock(t, skb, net);
> +		goto free_pkt;
> +	}
> +
> +	if (!skb_set_owner_sk_safe(skb, sk)) {
> +		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> +		goto free_pkt;
> +	}
> +
> +	lock_sock(sk);
> +	ctx = (struct virtio_transport_rx_pkt_ctx) {
> +		.net = net,
> +		.src = &src,
> +		.dst = &dst,
> +	};
> +	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);

At this point the socket lookup succeeded with src/dst/net, why not just
pass sk which already has all of them?

Best,
Bobby
