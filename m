Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526103;
	b=RWDkBcf96bbmozysPXYcwwBitHWCOBzFxLZ685VQn1YuiIyiEhhrzDUT7BsRcivXnn1u
	 rcMQ4YLtrJabwJ/Qf4rZa21XkbrR4c6pZCsz7bX+VP77qH8YF3VsFf7V8couN6adCuKSy
	 +lutPhnxeR2uyUcivVld7/6h+6CtjH5LV73ohwjOmddoCwLxEzkBSX5WuAdHpdDJdgySe
	 Q8AYaTI/j+qag9PSyQ1cdaiTdotVkUF60jITVMqc3IYiytwaw0I6cal1cjHhd+ooJbs08
	 QP+MCXW9zF5AHH5WEq5B8kD5uDZHYoGMt3jj1+23Zn1af0moxX7Y3xVvjJaTE1mLvUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=321hEoTB1Au38FVGyj1DRnrNhfqydglF7rtHdrBTmUI=;
	b=1fJS8yvcoeNtnz0BJloM+RW4UPhZneMW6XXwBsvPUDziP4EtoRQ18tPlbFN6QY8MO8ir
	 hWssD2mt21wtKe57sEFj1ReTRF0XlKDdC2ssIAC9d5hM7eZKtVFHq/wg+ZSygVp27YICd
	 /QfMMtsKtsJWnNU1kpI6loa58HjI6MA//1r7BNJ2qsZ0Mq+THuVZgLi82UDh7kxwjxA4c
	 alWQ4OYHu+PVZ27LjT5uEfBEMX6vAhJYYxHcfBH0G6dMJeqVxQ68DT+Zg6KWHrFjv19ZH
	 s/Rx5MQ3ovhxbvyj6e3ba7VggPcAMsoZ4qvTWzGtKWkCrZbEMumPcHv80pgyUs9PJEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eBdtJTAm;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CA606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 893CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eBdtJTAm
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so1488471e0c.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794526101; x=1795130901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=321hEoTB1Au38FVGyj1DRnrNhfqydglF7rtHdrBTmUI=;
        b=eBdtJTAmC+M9LYFUf/Wu4ODRuNS7Scaz4O+i9hrNh1RKfBFAEzYLRvlB1wHXZVnmE9
         dW/CLZQSWmxPDxNp5y1KRpVXJRW9XFaXC31UlCawwNAjALB+EDdWHg1TqQ1BxsksDU6y
         8oCzvZf+EPxymHlQM3+3EpWTUmX30Jsg45cM9fqI3XvNNJrMVzYM5o1NRhuvuUiQLLVQ
         ESI+THZljIAj9VEUSNOqwyM9/VOY9HSbLvNfvTUI39xQ+OV0THi5T1OkK8tDE82/wLuf
         AUbeBDaIB2QcprF1Lo3lU06A6lc46jHEGH9rPvsSJV26ycuOBEGzv5UcXoSwzGSZh92P
         9cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794526101; x=1795130901;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=321hEoTB1Au38FVGyj1DRnrNhfqydglF7rtHdrBTmUI=;
        b=F3ekZM2imwFFpCCLAenTSHwPWMUCh4GpI2GkBz0gSFwIqVGq/4YY7tJLc90j3vWdDV
         QNiAsBIBn9GLs21/pZBLMt4RrpaefEs8+4zZBc0v1A68FM9YvKo+loiZcaD4HTMMI5Cq
         uNaVPPN1opZWS6rbjKfquY9/QdWIM84UyH7qKrNvzFngxEeorvILDaYFCb8mDflfhEcN
         Y86kkpw8b79E65i2VqxmIeguYbG9fPke8DLiykG9xaHsy2PoFOJte2U3sDZLXG3RjYtN
         Pv1lFOy1C5RE7B2QIP0Ss5ZFCln3nnjmCNRA5Ogj056xUHK8sPVh+MqyIsN1H//QK3TI
         PNAA==
X-Forwarded-Encrypted: i=1; AL+hErHNwTTDrVye3PAdFdyY3dvHQU9sfVViT+2hfCZ9Kp6ESRQZvl2JiPf3nkGsgeSrKRw1NLEalc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8phrkv3oFb3eijBcfCqI1a4Gp+2hYYshMuqnv5v5eDDVTuBUKV
	N043mMwCHlOEb82O9EH3Mcbiy4AegNKnDoSCpi4OnxnnR1unHa4OjA1B
X-Gm-Gg: AYBFou0irYFdgLgEztE/86WWcMXQHjKQ0exXUlP52xa3K0D0Xs+nv/jg4IJGFBIdj0t
	2XPv1qpXizJQ7b4qR0JEkqzzPAEyNpMz79c2TrpXbX8bUxZqS9r/tQvjQhS3jrHFwKqnLB+XzlX
	tmQG+fOIZioC9bWXdGC1/xnj92h0uY9i+Mpjn/zRUu4vB2+8LBZ0vwqajOwlQDd+qNcj89kBsHe
	WoNjVNArRSFhgQTj0zAlx+Or6lAO6wyK5AZLoWEB5t2mC/4XQXNIF92Mm/fZa9LHvT2jFT9f2A6
	CbC4dbKZcI+qAHRQ+w5bWN1iLfLPW5+HI0hxyUhKnGUoem8KjXerKFiGxVboS31owYX6SgpYpgb
	NEP2APbBoBxVEt5x3KXlWabTi9Ytf42B5KGEcQ/+TdKUYfPHkR+v1BSvW4xo1X5unUT4kWLEejJ
	9oFD2QfKvK1nqfi6Y+mnSUAsxRaOEocDCpuycg7CzfenimhdeWQPDQyhZPTVECym9xFBZ6k52ns
	Wyza+QPuU5FdZakauuNLuD4nJARF/j3GyGl+tCra+7N1uV+CKIeSR/NEzAL2ei1hE8YvoHk1Rfo
	drdrrvjGL/p1u5UCoYGh+eNJDcrm/izM83AimAyPs7r/D2/k71nbGavTB1dNyLhQxLSA1GmU5Fc
	esd/hK4ULWXZG0A7tEt3wL7rb7tQwxTSuL0U5JLpmwDEr5F5h0X662jzJjr6NZRI=
X-Received: by 2002:a05:6122:20a2:b0:5ea:c984:5ad4 with SMTP id 71dfb90a1353d-5ee34678788mr153566e0c.2.1794526101301;
        Thu, 12 Nov 2026 15:28:21 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e3255fsm343341e0c.4.2026.11.12.15.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:28:20 -0800 (PST)
Date: Thu, 12 Nov 2026 18:28:20 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 shuah@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1122b304c2dc4@gmail.com>
In-Reply-To: <20261111014208.1795777-2-antonio@mandelbit.com>
References: <20261111014208.1795777-1-antonio@mandelbit.com>
 <20261111014208.1795777-2-antonio@mandelbit.com>
Subject: Re: [PATCH net v5 1/2] tun: bound the NAPI receive queue
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antonio Quartulli wrote:
> With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
> an unbounded list. When the poll runs asynchronously (threaded NAPI)
> and is slower than the writer, the queue grows until the system runs
> out of memory. An unprivileged user can do this from its own user and
> network namespaces, and the queued skbs are not charged to its memcg:
> in a test VM, a uid 1000 process limited to 128 MB caused a global OOM
> in ~6 seconds. The socket send buffer cannot bound this: tun sets it to
> INT_MAX, and the build_skb() and XDP batch paths do not check it.
> 
> Drop packets once more than netdev_max_backlog of them are queued, like
> enqueue_to_backlog() does, and count them as rx_dropped, before
> allocating and copying them. This covers write(), sendmsg() and the
> batches of XDP buffers vhost-net passes to tun_sendmsg(), which share
> the queue. Zerocopy buffers of dropped packets are completed. The check
> is lockless, so concurrent writers can each still add one packet.
> 
> The NAPI poll moved the whole queue out, processed up to its budget and
> put the rest back: while it ran, the queue looked empty to writers, so
> with the poll on another CPU the backlog could still grow without limit.
> Take at most budget packets instead, so that the queue never looks
> emptier than it is.
> 
> Dropping because the queue is full also schedules NAPI. vhost-net sends
> with MSG_MORE while it has more packets, and tun_get_user() schedules
> NAPI only after the last one or once more than NAPI_POLL_WEIGHT are
> queued. With a netdev_max_backlog below that, the queue would not drain
> until vhost-net ran out of packets; with zerocopy, vhost-net never
> would, as it stops sending when too many queued buffers are pending.
> 
> Reproducer, as an unprivileged user in a new user and network
> namespace, without kernel modifications or fault injection:
>   ip tuntap add t0 mode tun; ip addr add 10.11.0.1/24 dev t0
>   ip link add d0 type dummy; ip addr add 10.20.0.1/24 dev d0
>   ip link set t0 up; ip link set d0 up; sysctl net.ipv4.ip_forward=1
>   install ~500 iptables FORWARD rules and a MASQUERADE rule on d0
>   open t0 with IFF_TUN | IFF_NO_PI | IFF_NAPI
>   echo 1 > /sys/class/net/t0/threaded
>   write() 1400-byte IPv4 packets for 10.20.0.2 in a loop
> 
> Tested in an x86-64 VM with 1 and 2 vCPUs: with the reproducer running
> for 15 seconds, with 1400 to 65000-byte packets, memory use stays flat
> and the forwarding rate is unchanged; the tun kselftest passes, as it
> does without the patch; and the tun_vhost kselftest added by the next
> patch, which drives the vhost-net batch, copy and zerocopy paths,
> passes, while it fails without the patch.
> 
> Still open: the limit counts packets rather than bytes and applies per
> queue, so with large packets and many queues (IFF_MULTI_QUEUE works in a
> user namespace too) the queued skbs, which are not charged to the
> writer's memcg, can still add up to an OOM. This is hard to reach in
> practice: with large packets the writer's copy is slower than the NAPI
> poll, so the queue does not fill. With 64 KB writes the reproducer never
> reached the limit and memory use stayed flat.
> 
> Found while analysing the performance of the tun write path, and tested,
> with the help of an AI coding assistant (Claude Code).
> 
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
>  drivers/net/tun.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e601..396e4295589f 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -58,6 +58,7 @@
>  #include <linux/nsproxy.h>
>  #include <linux/virtio_net.h>
>  #include <linux/rcupdate.h>
> +#include <net/hotdata.h>
>  #include <net/net_namespace.h>
>  #include <net/netns/generic.h>
>  #include <net/rtnetlink.h>
> @@ -227,6 +228,16 @@ struct veth {
>  static void tun_flow_init(struct tun_struct *tun);
>  static void tun_flow_uninit(struct tun_struct *tun);
>  
> +/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
> + * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
> + * like the per-CPU backlog of netif_rx().
> + */
> +static bool tun_napi_queue_full(const struct sk_buff_head *queue)
> +{
> +	return skb_queue_len_lockless(queue) >
> +	       READ_ONCE(net_hotdata.max_backlog);
> +}
> +
>  static int tun_napi_receive(struct napi_struct *napi, int budget)
>  {
>  	struct tun_file *tfile = container_of(napi, struct tun_file, napi);
> @@ -237,21 +248,24 @@ static int tun_napi_receive(struct napi_struct *napi, int budget)
>  
>  	__skb_queue_head_init(&process_queue);
>  
> +	/* Take at most budget skbs, so that the queue never looks emptier to
> +	 * writers than it is.
> +	 */
>  	spin_lock(&queue->lock);
> -	skb_queue_splice_tail_init(queue, &process_queue);
> +	if (skb_queue_len(queue) <= budget) {
> +		skb_queue_splice_tail_init(queue, &process_queue);
> +	} else {
> +		while (skb_queue_len(&process_queue) < budget &&
> +		       (skb = __skb_dequeue(queue)))
> +			__skb_queue_tail(&process_queue, skb);
> +	}
>  	spin_unlock(&queue->lock);
>  
> -	while (received < budget && (skb = __skb_dequeue(&process_queue))) {
> +	while ((skb = __skb_dequeue(&process_queue))) {
>  		napi_gro_receive(napi, skb);
>  		++received;
>  	}
>  
> -	if (!skb_queue_empty(&process_queue)) {
> -		spin_lock(&queue->lock);
> -		skb_queue_splice(&process_queue, queue);
> -		spin_unlock(&queue->lock);
> -	}
> -
>  	return received;
>  }
>  
> @@ -1856,6 +1870,24 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* NAPI queue full: drop before allocating, and schedule NAPI, which a
> +	 * MSG_MORE sender may not have done yet. Lockless: concurrent writers
> +	 * can each still add one.
> +	 */
> +	if (tfile->napi_enabled &&
> +	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
> +		local_bh_disable();
> +		napi_schedule(&tfile->napi);
> +		local_bh_enable();
> +		if (msg_control) {
> +			struct ubuf_info *uarg = msg_control;
> +
> +			uarg->ops->complete(NULL, uarg, false);

call net_zcopy_put

even if the packet is dropped, the entire operation was without
fall-back to copying, so last argument is true.

also stops vhost-net from falling back onto copy mode
> +		}
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return total_len;
> +	}
> +
>  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
>  		/* For the packet that is not easy to be processed
>  		 * (e.g gso or jumbo packet), we will do it at after
> @@ -2561,6 +2593,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>  		return -EIO;
>  	}
>  
> +	/* NAPI queue full: drop, and schedule NAPI so that it drains even if
> +	 * nothing in this batch gets queued
> +	 */
> +	if (tfile->napi_enabled &&
> +	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
> +		napi_schedule(&tfile->napi);
> +		put_page(virt_to_head_page(xdp->data));
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return 0;
> +	}
> +
>  	xdp_prog = rcu_dereference(tun->xdp_prog);
>  	if (xdp_prog) {
>  		if (gso->gso_type) {
> -- 
> 2.56.0
> 


