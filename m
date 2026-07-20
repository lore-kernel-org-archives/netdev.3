Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB537F75A
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547092; cv=none; b=qb+sZb0rQQ47mKQ4aZUS+2dI1JKRf0jvP1hoQjiq7z9B2hb/bHHXP+ilmFoV2oVyFOYsT6ih7bkdzJgXnO+tWo5J5/WYqMg3u3ZRfTgzChk2CRLTTsffWsk8vXI2rylJoYGb1PhOG/XLE3H5VRbxsBcIdsZ8NmjB5/tnaBG7AgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547092; c=relaxed/simple;
	bh=9Ryl1qPOYFgFDJ1CxOWNCYl2FLMr2LVh3Deo2OWD3N0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CaSxvKFJfZSO/+eTj7bl8P8kf0PneFdCVGqtHuGwkRhabmTYpen4IHkSZLGE8N6LRzjsDJgCQxlJsVFy5HouUocrMp5/uOsUYRerYXBFnjaYhos9drHliuwmQBoFtgylEhSb2UD1biRQSwKiZhDpFDQozF+Mn7QBXlSiVxm/prw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV3L9s3I; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV3L9s3I"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ed2a06b9eso44758807b3.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784547089; x=1785151889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NPWEZrRfY5rMao6IgbuSiFe2UoYl/a8XYmEbz/tZoRA=;
        b=HV3L9s3IdPsw66FCN223qshp9DXKeNbCRmHokSdcCKa5Rau9U2LkMBPd571l8mtlmC
         41myBvQBr+gQys+qXXY1h4SQVDr1niIX5/E0eg+o+RUjejhCI+BOQQcU9nw/HFg7dRYN
         XhleUTNq6GlyyfCgE0hV4NjD24edwSPOz/8+4u/fXhUKG87p+Avf9WsOowJ8NSTfhbKp
         18GxA/rkkTY9HJfoRUCuvHRlHk9uQ4zdl7RwoiTpsvJf3E8O5CJXSrt9RwYpdI7UhVAc
         KPaC/MOCC8jkBLoRKXDkM2FZrjMu04UZ1a0yFGc4DPan+UYx+/MFxfm3cJHFTapp58Rs
         ZTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547089; x=1785151889;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPWEZrRfY5rMao6IgbuSiFe2UoYl/a8XYmEbz/tZoRA=;
        b=qj7xoThKYG4a0n6FbelYwNk9qc+SEDN5AFJu7qyRq1v+3haeN6tI8gt2J+n0YXX98p
         t+etuNsoSKWBHn1n98U2sPWUJs+ZGeeZfP8sp1O0pRHgR5SpJeSZaPLJ8LLy9ccNqW/I
         2J/+u+pGY2nADYrkprDBVCgzQKbvjk4cC5jDBmck7cQdHNAdH4ezKKWS1UB9/ZevfYC+
         +zr5gw279Tt6yCmKzYFftzH0TCk+x7keFU8Ws78fmVIZhrFiRB3iVnpyMmNNAwGDsJOI
         60HZUNoZ5y6v+nEVe9YO3h7NonlQtTEkuTmFM815Kf/mUGoirupui3y8bxYA8PsNhP4O
         iaGg==
X-Forwarded-Encrypted: i=1; AHgh+RqNTxGLBH0tHfJoe3fiR0eLChrFEog/9wMS8nonnx9Z2ysfpBhzQdmYkJ7T2rDLGRtN7pChnoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK1COi5x669tPelbGXk/h/46NhYsYnH0HcALDHJ6g2c1q0bw9H
	r2/VWxzVikH/zb5HFao+IUFhDuprnDx5A7AF7qmUqTt+nFVVzKpdIPG9
X-Gm-Gg: AR+sD12hLfow0PGkD5qfpMzq6iFGnKWj+gxnYDPwOvvYGDsWEjKKmy4nY3rFRLlYp7l
	ESJrpm6Humm0UQ4584NCOZ4veZyl4Yzy1BxUgxYTBd2E9yL0cql/2RuQKICz7sb0FwMTTu+uQMD
	QO6QN68DS57FOsKIPKn80lZmZhvD4p6dQwX1HFAlrLvF78rP5WLIFRUS/DUBWPO7W+46gBeIKPe
	n7j/ZJ8GrwLLfUDJePLwjdQUO4xy2V3ds5QurVe4UufiTU+Qqy+kfmYRcHKLRKqk5N68lgjrKqh
	mSZ7AZPKv08Ahfo3x8J3cqK9/+QBXPw2iBLNp2SOS7SYZdNfuL3FNCz9X+MbdkreAb9rzjuBBOo
	PoBLuuGBx6wBa9coCdxfqPkEhIbDdW3IpRr6SI7bcfDKTpCxrxcTFZBkY0ua7l3NrEqLeClq2Yi
	E+6hZrT1yO+IsrFaxWhO28xHwRimyf5S9urNOOHpWBx5Bxr8SwjGP4Xzs=
X-Received: by 2002:a05:690c:4d47:b0:7ff:1e22:d187 with SMTP id 00721157ae682-81ef25bc619mr42302297b3.37.1784547088959;
        Mon, 20 Jul 2026 04:31:28 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42ae657sm48668367b3.35.2026.07.20.04.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:31:28 -0700 (PDT)
Date: Mon, 20 Jul 2026 07:31:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ren Wei <enjou1224z@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 vega@nebusec.ai, 
 xizh2024@lzu.edu.cn, 
 enjou1224z@gmail.com
Message-ID: <willemdebruijn.kernel.27f52c79de4e@gmail.com>
In-Reply-To: <24f7311aed0c9ff06b8ea982647b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn>
References: <cover.1784454541.git.xizh2024@lzu.edu.cn>
 <24f7311aed0c9ff06b8ea982647b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn>
Subject: Re: [PATCH net 1/1] packet: synchronize pressure clearing with ring
 reconfiguration
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
> From: Zihan Xi <xizh2024@lzu.edu.cn>
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
> This keeps the receive hook decision consistent with the ring state used
> by the tpacket room checks.

Thanks for the report and proposed fix.

Ideally we can avoid taking sk_receive_queue.lock an extra time in
packet_recvmsg.

packet_rcv_try_clear_pressure only accesses the ring if flag
PACKET_SOCK_PRESSURE is set. One option may be to clear that in
packet_set_ring, after detaching the socket (and thus after any input
could set it again) and before swapping prot_hook.func (with a barrier
to guarantee that). E.g.,:

@@ -4528,6 +4528,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
        WRITE_ONCE(po->num, 0);
        if (was_running)
                __unregister_prot_hook(sk, false);
+       packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, false);
 
        spin_unlock(&po->bind_lock);


> Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/packet/af_packet.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 8e6f3a734ba0..b369f44b4065 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1315,13 +1315,22 @@ static int packet_rcv_has_room(struct packet_sock *po, struct sk_buff *skb)
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
> +	spin_lock_bh(&sk->sk_receive_queue.lock);
> +	__packet_rcv_try_clear_pressure(po);
> +	spin_unlock_bh(&sk->sk_receive_queue.lock);
> +}
> +
>  static void packet_sock_destruct(struct sock *sk)
>  {
>  	skb_queue_purge(&sk->sk_error_queue);
> @@ -4304,7 +4313,7 @@ static __poll_t packet_poll(struct file *file, struct socket *sock,
>  			TP_STATUS_KERNEL))
>  			mask |= EPOLLIN | EPOLLRDNORM;
>  	}
> -	packet_rcv_try_clear_pressure(po);
> +	__packet_rcv_try_clear_pressure(po);
>  	spin_unlock_bh(&sk->sk_receive_queue.lock);
>  	spin_lock_bh(&sk->sk_write_queue.lock);
>  	if (po->tx_ring.pg_vec) {
> @@ -4544,14 +4553,15 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
>  		rb->frame_max = (req->tp_frame_nr - 1);
>  		rb->head = 0;
>  		rb->frame_size = req->tp_frame_size;
> +		if (!tx_ring)
> +			po->prot_hook.func = po->rx_ring.pg_vec ?
> +						tpacket_rcv : packet_rcv;
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


