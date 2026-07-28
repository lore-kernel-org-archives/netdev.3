Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AD426437
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239066; cv=none; b=BkXcLuJD0VpuL8PH0OKPvw1bGlh0c8smiE3XwME8GRGqQ+dS1UPdcnxVm5/Bc+WAsjk1egSgD0bgLDopiMQoAttcQ0US22BsZWBu1qGSIRqvWtBLo/9m8hlaA741W9NUCChP0KGAjGpzi0WjSae+iKBs0n5E0GCHm/hzITvmkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239066; c=relaxed/simple;
	bh=7/Xkc7+zUrOjnz4rh3XsfvgPoLEKdqQVaFMOU8hvkfs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Jonk49bJelnCZkHVFM6UBija3p8/7IlsDVPxuyum4aMTT2H+0fZhxKF/6+HW+Eqsm+LvsfpyG1PTvIRAS1yB9t/WCOw14meBBC5k13PkkkMdLCYQ7BVPnKBvVPoVvbKqU5JE/u9IJpPCzeDuMW2jwKQMIZX845IKvSc46AaZBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKox616i; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKox616i"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66893db7bccso4985376d50.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785239064; x=1785843864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tzjEklbPNeeizwk68Nr0fI2IZmujivrnCXR+SQTLNW4=;
        b=JKox616ieHrXL9kU6i1SEoVf7KG7qfRP7R0MO5hf9rO75kxM37xrFOHE3FbIo3BtjA
         WIntWDmcmXlaejI2bCrAg8IlmIibraMnVRyruM+ivZ7mYLFTsSCjXQYZLoPagGRiZOJS
         FezWYK3QzPMAHQPfrF3JFjGIkgHD6i21JmmsdpVA2EXCstchhbw+TGkOcBQdBQydKAMr
         i+ekwWhSG0J/6l8gRRWlXi0SmK0FwzB7imJ6QPlc6lf4EHMWIfF2VoUzyhxiLFvm98NJ
         +B1agqYMXszx/hQvD5r2hehEFCZB9cJ0UHHoH0/MkXeWyHtpid6F2JH5Ww02spsc21XE
         7zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785239064; x=1785843864;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzjEklbPNeeizwk68Nr0fI2IZmujivrnCXR+SQTLNW4=;
        b=gZ7OBQwFv3t/ECYzZ2pWEjAkk189rWtVfKfmyPF0GxVvJLPCT0GQpYi6ggsHNDH2Iu
         w7ev5i6pGCaVH8Tg9gwZY4mRz/e8skr4CC2UL46sj9lvooDBGPF5IPhwUcpZgF9LTZ2E
         mEkRkrG6cScGtvG9HTIR96ZxftwXkLcFQ9vNcGy7I/zypnTfk2twnuv8fy7ybG2bjSS8
         dt4JiQXNFbX+uJNUD91ijS3lIlODagmKEelmwGDXfYeJhcCn41I2MtMwPgAiR5IAvIMQ
         0E/otcrNZbFrqTPfXdrweywaFLdlsywRvCT/wyXNV6h0nqGmPzUNcKEYqkt4Lz4IoEQK
         7Ztg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf7eozpHbht9ZxNaXMsW+yOCV48pgBGONTxC0qVSbu/OXG5GTw3e10F3xhiIlGa14WPJPX1c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzNjj8qXiLEZ0YR3IJMiodEYgT+B3I8Kc8jHHCeWs/W1ryP3J
	dqh0paI/3aDWIMR52mkuaVJW9y9Z2eOc1VTIfkM/kViaMu+CuxlivxV8
X-Gm-Gg: AR+sD10CwQUWHjISOKr/o2+hX3RDN3mz/t+lfcTkZ6pl0/LfKKF7vxU4vlkui2ZfAe7
	/xpHkgw7AFKhOElUY6aCOkIgO5WXLW66QIeYnEjHTVnuS/1KrTb+oMaRUiTZXPNCsnt6UdD2yFM
	qU6Ec7xe2NGXVy0lib+eK9+z+ifoOvDl0N/d0UJnOZLU3C/BcgphLAfGWsN8vh7UHL9QT4uskPY
	B0ZFrjyi/Klmy8iNc1noQOS8vbdY3+jEwVuWKbWrIBrC3DDfRKjP1IEBkw+o109TQASCO8UfnCf
	EyARbG02GvSw6DvwnF9FHTBTfXatoi8l2Ll3a3kpE0/TP7zlYntS0ghihfCAxEfheOSWj/ZoGNb
	qLBp2rcm61sZeAJd2zwdI5zK3aLIPcGpPzNIsPG25i1b/3He3fJBDnXViYsrmgWs3a3I/uuq/Ax
	wtIinLgRuYwUK//sJS0ltn4urfx2lbSL8xpEgfqdzpscSg9NvjMQ==
X-Received: by 2002:a05:690e:4551:20b0:668:16e9:c43f with SMTP id 956f58d0204a3-669058051dcmr521358d50.76.1785239063931;
        Tue, 28 Jul 2026 04:44:23 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6dd722esm4844382d50.9.2026.07.28.04.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 04:44:23 -0700 (PDT)
Date: Tue, 28 Jul 2026 07:44:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ren Wei <enjou1224z@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 vega@nebusec.ai, 
 zihanx@nebusec.ai, 
 enjou1224z@gmail.com
Message-ID: <willemdebruijn.kernel.e559328910e@gmail.com>
In-Reply-To: <f1cd534481c2397a36850ad039dcbfd38c3233ce.1784551898.git.zihanx@nebusec.ai>
References: <f1cd534481c2397a36850ad039dcbfd38c3233ce.1784551898.git.zihanx@nebusec.ai>
Subject: Re: [PATCH net v2 1/1] packet: synchronize pressure clearing with
 ring reconfiguration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ren Wei wrote:
> From: Zihan Xi <zihanx@nebusec.ai>
> 
> packet_set_ring() updates the RX ring state under sk_receive_queue.lock,
> but publishes the tpacket receive mode through po->prot_hook.func after
> releasing that lock. packet_poll() and packet_recvmsg() can therefore run
> the pressure clearing path after the ring has been cleared while still
> seeing tpacket_rcv, causing __packet_rcv_has_room() to dereference stale
> or NULL ring storage.
> 
> Serialize pressure clearing with RX ring reconfiguration and update the
> receive hook while holding the same queue lock when changing the RX ring.
> Keep packet_poll() on the unlocked helper, 

Because it already holds the lock.

> and let packet_recvmsg()
> take the queue lock only when PACKET_SOCK_PRESSURE is already set 

which is sufficient, because if the socket moves from tpacket_rcv to
packet_rcv, the socket is detached and a synchronize_net has passed,
so no new packets could arrive to set PACKET_SOCK_PRESSURE if it was
unset.

> so the
> fix avoids an unconditional extra lock acquisition on the normal recv
> path.
> 
> Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
> changes in v2:
>   - only take sk_receive_queue.lock in packet_recvmsg() when
>     PACKET_SOCK_PRESSURE is already set
>   - keep packet_poll() on the unlocked helper under its existing queue lock
>   - v1 Link: https://lore.kernel.org/all/24f7311aed0c9ff06b8ea982647b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn/
> 
>  net/packet/af_packet.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 8e6f3a734ba0..0107e55de6ff 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1315,13 +1315,25 @@ static int packet_rcv_has_room(struct packet_sock *po, struct sk_buff *skb)
>  	return ret;
>  }
>  
> -static void packet_rcv_try_clear_pressure(struct packet_sock *po)
> +static void __packet_rcv_try_clear_pressure(struct packet_sock *po)
>  {
>  	if (packet_sock_flag(po, PACKET_SOCK_PRESSURE) &&
>  	    __packet_rcv_has_room(po, NULL) == ROOM_NORMAL)
>  		packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, false);
>  }
>  
> +static void packet_rcv_try_clear_pressure(struct packet_sock *po)
> +{
> +	struct sock *sk = &po->sk;
> +
> +	if (!packet_sock_flag(po, PACKET_SOCK_PRESSURE))
> +		return;
> +
> +	spin_lock_bh(&sk->sk_receive_queue.lock);
> +	__packet_rcv_try_clear_pressure(po);
> +	spin_unlock_bh(&sk->sk_receive_queue.lock);
> +}
> +
>  static void packet_sock_destruct(struct sock *sk)
>  {
>  	skb_queue_purge(&sk->sk_error_queue);
> @@ -4304,7 +4316,7 @@ static __poll_t packet_poll(struct file *file, struct socket *sock,
>  			TP_STATUS_KERNEL))
>  			mask |= EPOLLIN | EPOLLRDNORM;
>  	}
> -	packet_rcv_try_clear_pressure(po);
> +	__packet_rcv_try_clear_pressure(po);
>  	spin_unlock_bh(&sk->sk_receive_queue.lock);
>  	spin_lock_bh(&sk->sk_write_queue.lock);
>  	if (po->tx_ring.pg_vec) {
> @@ -4544,14 +4556,15 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
>  		rb->frame_max = (req->tp_frame_nr - 1);
>  		rb->head = 0;
>  		rb->frame_size = req->tp_frame_size;
> +		if (!tx_ring)
> +			po->prot_hook.func = po->rx_ring.pg_vec ?
> +						tpacket_rcv : packet_rcv;

Same question: why this new condition on !tx_ring here, that is
missing below. It looks benign to me, but especially for fixes only
make necessary changes.

>  		spin_unlock_bh(&rb_queue->lock);
>  
>  		swap(rb->pg_vec_order, order);
>  		swap(rb->pg_vec_len, req->tp_block_nr);
>  
>  		rb->pg_vec_pages = req->tp_block_size/PAGE_SIZE;
> -		po->prot_hook.func = (po->rx_ring.pg_vec) ?
> -						tpacket_rcv : packet_rcv;
>  		skb_queue_purge(rb_queue);
>  		if (atomic_long_read(&po->mapped))
>  			pr_err("packet_mmap: vma is busy: %ld\n",
> -- 
> 2.43.0


