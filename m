Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498897;
	b=tmRwXT/EnQzA2Vk8UautKbtAq4NdvfDaeOda8oM4NKpRILPR1I9h1lrRQDzi1l2xMJyE
	 FRfcnYL95v5Pf0LKB1NHnlmwwgvaELwC+cf7PGt+rhL0TDP86WVoSqZ+HK/M6v1znQT+5
	 McZhei856n1e017Gii/Tw9jotho145pZFBW9Bul2+n8dBvk0mWQx6SRmffA6TA68FpLc6
	 Z6K2vBYzGw/8/Sorzttf0Do5XSpiox+LzeAJiDB/Kv3sg8rgGcKafOwFUE5r2eYFu1bG1
	 IyghlPP8EPzGneCRAtGaBmlh2fz9qnda+iibQM0ZGytre5kKbi/JSUmzPqW8HGjs/Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sql7fN2u0oiP/B/ZCcyfKQoGPFzVaZjeRAmEFew5rYU=;
	b=Q4AGNEuQDzimoqJrW0ZAhmBYIbcWDVyZopdYZyaSnj4xYkcA4I/Ld7fKfpS++/W8t1Uz
	 BqShRoMR/ajbDKGxJNWH/TmLL+ndxlDcfnSVUC86xLyIXsZKHo6V7Hs7LiWEOr5aQdFSH
	 ePYjtm2nvxTd5ilcrnIzO02hcGnXlKLZXXiBQJdgrzn55So56gdudBfni8eA/dF18S8z/
	 owOidqde5QJkLGoo2pHXFEgsJG/B9MvXU/X4j4aKb/ouLoHkD/yBltmPmci9RPR61Oaht
	 qOxSyArov+FUIJ9OjEQQQebt0whJ4OwLQRGXvtNziubdAW1cV5I8jMVsQUAaw6puGvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X03A90sK;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45F606A330
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 02:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B45F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X03A90sK
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-98c6e050c5dso1152340241.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 19:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793498896; x=1794103696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sql7fN2u0oiP/B/ZCcyfKQoGPFzVaZjeRAmEFew5rYU=;
        b=X03A90sKg5M4v43Fd+JTPu9iEHnfiPOBs9njXxjc+qFSOMFst1mJJAzOEX9qvo5XzS
         6LceEMiqyRxR9N2XllUQDKeU9MXb0z/3zioxz/eCRXnAyTLHZWyWBfeX9ne0ZkwMUCbe
         zs5d++5vxLa6eS3Hbj5UNL9t4C7uW06e0k11EGMTjznx/qzQRE49nkGyLQ/S/v6BzYPY
         AWU/QMdyhlQsVAg8KSsv7JKBt2JHLQEO4lN/09XwrD8Cp1FUhT3rDx96X8QAc/y8gsCl
         43SbtIchf6+wa1b7kZp2hOyo8g/3zpEb0AOQbbTXFGZJvTSBDdFxkQ70JwSQ2QwW5/3U
         lyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793498896; x=1794103696;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sql7fN2u0oiP/B/ZCcyfKQoGPFzVaZjeRAmEFew5rYU=;
        b=Uo+Dt472XZG19JVjVV8z3jsEVRHdZNVnf69ZYHxIXz3uLioiqegLHDNwj1aau9LbMD
         pjFXdAEvQa2Vbn+SCaCOac0dWMAGzpMoVoyVVN0wac0IjnZ7v/7NyCOvIWjgDkcA9rH+
         ylZvm2+dY9Wh4fNZqw1WNneBvdfxvEdDkcixWrUTbes6X6kmCgs2qRpc4sJNjzJbkz23
         nLmOguVUh86bYMO2n/5RY0uBIbviJ2VFCdJfBNJ6DKzyeEXAHxoxjMGUkHFnV9QgYV6h
         5JWmPiFdLC27boSqhYG4D9io9IKX51ZhZ9JGc0+OCK0hWHbgycBF6DnqQqazIsAQ9I5s
         ra3A==
X-Forwarded-Encrypted: i=1; AKwUvBzzwXSJzj4gSbZTyDq6uuUivaYh+6wYemryaz4SLEQh8hySO4zxbLnF2FeUK7luwgQeTd9OACs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCY/slwwgxUm5K98JiBog+t3MPUX+Yah/HfucRJMpNgk9rhcnz
	FOgnWLDBTNQwycNXbFDVYcxdTTQbIecaS38RjeFLGfhcPwtHzQQKjXYl
X-Gm-Gg: AYBFou3klHIpgr1752B1cgGtx/fvYZGt57aYwez0K+E/e8jODyeD70H6nK7Bb802lHE
	cTcK3T35rj8IgG5XQSkCi+98jyPDt0m4yIngwQHMiyvUl2vSAwA+b1dUDswMTFKYNgbfi4p/TOM
	pam90h/VFcsy3QqmdHC0R6qW3Mf8cwxXozlrMNRF8CR508Z/DkOIYZQMIlTk0NjnkRXDhiuUAIH
	ve3mZK0lrdqBar5K8JYdY5o8Ukaso8MYsxSHtr4L/IVsdqTbn/BrvPcURcF+iq3XopO/L+1vWUG
	G5CjIvf054UPsI8ynz4v/0UW38gZvQHeG1W0csmiIenzpPsPh2B84TLRwAWqm8bHYL3iE/xo15J
	HIpwfBi+we/1ncMAhyQbv2FlbAh+MRRTGXHbLqZr2YqvshyrXAi+Jah0QoPwH9ThDwyqlX1RE64
	k4FKmJAfrxMvFYvUs8Nay71VcNQzE45JmU1jA4eyvYoNmiqpYkhqf9ONTsFUAMcMlx8JCDFmLVq
	BOu74+Sh9jKZJBtAF9C8JebL1XMmwMm4gaj6GFd+zlq+YY0Vtjxuxvygseo0NnN18BpmaREPSKT
	h3NF452BGjQPgMS0abCUeFFY1iKgivJBcMG1pic1Q9iZWtY+r7zGZXXP+vM9treSrNhqWgb+p2h
	84khnHhxwppCSOsJUNJyKx9H9FumX0ASf7og+A8TXbSD8eREHcgRb+UVQDrGvwlcR/MFu
X-Received: by 2002:a05:6102:8099:b0:7cc:174b:f7c3 with SMTP id ada2fe7eead31-7d072d18c71mr3057576137.30.1793498896062;
        Sat, 31 Oct 2026 19:08:16 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee509f58sm8353663241.12.2026.10.31.19.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:08:14 -0700 (PDT)
Date: Sat, 31 Oct 2026 22:08:14 -0400
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
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.10cf6c1afbcd@gmail.com>
In-Reply-To: <20261031231444.1528758-1-antonio@mandelbit.com>
References: <20261031231444.1528758-1-antonio@mandelbit.com>
Subject: Re: [PATCH net v3] tun: bound the NAPI receive queue
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
> enqueue_to_backlog() does, and count them as rx_dropped: before
> allocating and copying them where possible, and again under the queue
> lock before queueing. This covers write(), sendmsg() and the batches of
> XDP buffers vhost-net passes to tun_sendmsg(), which share the queue.
> Zerocopy buffers of packets dropped early are completed.
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
> Tested with the reproducer in an x86-64 VM: memory use stays flat
> and the forwarding rate is unchanged. The vhost-net paths are only
> build-tested, and the kselftests have not been run yet.

Let's make sure the tun selftests pass.
 
> Still open: the limit counts packets rather than bytes and applies per
> queue, the NAPI poll splices the queue out while it runs so up to about
> twice the limit can be in flight, and the queued skbs are still not
> charged to the writer's memcg.
> 
> Found, fixed and tested with the help of an AI coding assistant
> (Claude Code).
> 
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
> v3:
> - Also bound the sendmsg() paths, which share the queue: zerocopy
>   buffers are completed when dropped early, and the batched XDP buffers
>   of tun_xdp_one() are covered too (Willem)
> - Drop the IFF_NAPI_FRAGS exclusion: tun_get_user() never queues in
>   that mode (napi_gro_frags() is synchronous), so the early check only
>   fires if tun_xdp_one() filled the same queue, and dropping is fine
>   then too (Willem)
> - Recheck under the queue lock before queueing (Willem)
> - Compare with > like enqueue_to_backlog() (Willem)
> - Keep the includes sorted (Willem)
> - Add the reproducer and a testing statement to the commit message
> 
> v2: https://lore.kernel.org/netdev/20261030152540.1409884-1-antonio@mandelbit.com/
> - Cc netdev and the maintainers
> 
> Notes:
> - Affected since 943170998b20 (v4.15). Reproduced on mainline
>   7be4bc52fd9e; the code is unchanged in net/main 94cea342e891, which
>   this patch is based on and was build-tested (W=1) against.
> - Mitigation: disallow unprivileged user namespaces or restrict
>   access to /dev/net/tun.
> 
>  drivers/net/tun.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 770b8fe085c3..df5f0cbd1b16 100644
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
> @@ -227,6 +228,15 @@ struct veth {
>  static void tun_flow_init(struct tun_struct *tun);
>  static void tun_flow_uninit(struct tun_struct *tun);
>  
> +/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
> + * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
> + * like the per-CPU backlog of netif_rx().
> + */
> +static bool tun_napi_queue_full(const struct sk_buff_head *queue)
> +{
> +	return skb_queue_len_lockless(queue) > READ_ONCE(net_hotdata.max_backlog);
> +}
> +
>  static int tun_napi_receive(struct napi_struct *napi, int budget)
>  {
>  	struct tun_file *tfile = container_of(napi, struct tun_file, napi);
> @@ -1856,6 +1866,20 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* Drop before allocating and copying when the NAPI queue is full. The
> +	 * check is repeated under the queue lock before queueing.
> +	 */
> +	if (tfile->napi_enabled &&
> +	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
> +		if (msg_control) {
> +			struct ubuf_info *uarg = msg_control;
> +
> +			uarg->ops->complete(NULL, uarg, false);
> +		}
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return total_len;
> +	}
> +
>  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
>  		/* For the packet that is not easy to be processed
>  		 * (e.g gso or jumbo packet), we will do it at after
> @@ -2045,6 +2069,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			goto free_skb;
>  		}
>  
> +		if (unlikely(tun_napi_queue_full(queue))) {
> +			spin_unlock_bh(&queue->lock);
> +			rcu_read_unlock();
> +			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
> +			dev_core_stats_rx_dropped_inc(tun->dev);
> +			return total_len;

consider goto free_skb instead of open coding.
> +		}
> +
>  		__skb_queue_tail(queue, skb);
>  		queue_len = skb_queue_len(queue);
>  		spin_unlock(&queue->lock);
> @@ -2649,6 +2681,13 @@ static int tun_xdp_one(struct tun_struct *tun,
>  			return -EBUSY;
>  		}
>  
> +		if (unlikely(tun_napi_queue_full(queue))) {
> +			spin_unlock(&queue->lock);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
> +			dev_core_stats_rx_dropped_inc(tun->dev);
> +			return 0;
> +		}
> +
>  		__skb_queue_tail(queue, skb);
>  		spin_unlock(&queue->lock);
>  		ret = 1;
> -- 
> 2.56.0
> 


