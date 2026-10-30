Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397136;
	b=iZNskNTBzl2aRIuQMZWV8SQ/TG7dC447GVz+/wVX49TfNe+9B4Vbv7GpgJPlgj5nL0rq
	 3k/98QJmOrbC+i+y2IK/n5ASj4w850jqg/6kfM0XLtFMApCcYZEraVJslt5GFYBKtcOR1
	 DUnsXATfWMEvbEUPY/KrugIu5vDS8Wv/meFjgekhRg/FiqjId7ugdGO8skJvhD07nD68w
	 LZcq/mILe1VkMs3Tufy74fzeZBtGzfvl9opEdF0FwrJq7i3wlCFi0+RB1nyeu7p1boZRe
	 YZZXoqqThDpKrwZwooYhBULCuwVg/FfLTTNCiUWrxpL9U57MAvBzvMEZ9/OQcQIRuiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IwMOb/LL4+tPG5EISzxH9OS1Wpx6RvsDfo79paVWmtI=;
	b=QPi6oofrJWT5QphNP09D3nvJMgd66m2fK8EclBO4ZszdZenSD+LzWBGV+cC1y1y6WvWj
	 QbOp+XHO6EMvTpUtpbw8HWsAa+H7OuXvftlMTQBmVVopos+WhMRotEWal3cOhmGON5kbr
	 X1BeBqNhBTXNUVY8oNAOgtWNumpXa/0CVx3u6JFmpwY6T4IwAU46P5CzsUgRRzrLsbRSF
	 SlKPaxtrOOjbY1vnAwfmWdp0aWThLaPLKjZdX1d/XfM6/iethWC+6B9Mpat/Lvr0uUWp8
	 Q4Vnc1mt2qAafp0msFjjiX/D12EXmRkRO97ziP6OCnv0XehE0XGaDide9GvBe3cYCNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f4rdtJBx;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB75606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB75606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f4rdtJBx
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e948e56af3so474521e0c.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793397134; x=1794001934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IwMOb/LL4+tPG5EISzxH9OS1Wpx6RvsDfo79paVWmtI=;
        b=f4rdtJBxJnY1OOb4UuBttnhUEEHz6dYBSxO/kjASBUNx6wpLhJJ2vhhMN3sexd4g7f
         22WpF6PGbPzU6f/+7iUVy6n/LJWwa8Z3ZOS+S9hJbmixjn0UMRf+WsxPSIB4xUTMrf69
         /cC8IEyYlBMzKnN6SOP+hGbQDVjyyhPiJjrBD3SlxLq77C7Fvr37M8seDlDumNbt77or
         TklQptrGfj/sfD35K3YxjWZEJaEgeykXFfGeSaUa0/cMv1C/RfFT+G4VY2MezGxMBS3M
         0MLBbGOO61iKe2T1BXDyd3q4uGDcqRiVtJji71E61AKBP3nI6zVdkswA0mwT5qrraNio
         4GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793397134; x=1794001934;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IwMOb/LL4+tPG5EISzxH9OS1Wpx6RvsDfo79paVWmtI=;
        b=1gtGEOo9++Vqc1ED9cpW9HfEg/M1tuIYpEc3IIQ6snBANTR107SzXU0+89uR/JO3Nv
         wCP+k7IFkxoyKi8sHWmQxTCaXBTAtO3gHBfKVTXrijGWBfkGaz5TL1oCEKb/291WnsSj
         5t/gPK/3eI96CGbs9xqDMW3CjOc//3/v8+okL9C1OengBdeNQfGovbSjk9evInEidVam
         v5QTQNByPXGOWyyKFRdEsnRGv0aHaNXpc+yafB7t+9WOVqr6kR2Bt86uJ5argouwqIrZ
         b8BuImQ1OH2BWvYlieJrEkygCXTX+A2E5JeW9vG/V9TTaDJ4vzF7aS2r/YEyGEnAsyC6
         rNaA==
X-Forwarded-Encrypted: i=1; AKwUvBwI7/XE82APCPJiPpZSs9Q6frJxNjl3mZdeHzTT0Mmbs4IdaW5BRPg97dBeHlbYZbjC3rPOA/Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVx7QswrYqBaIJvu3VYj/Y6ub/n/vEUgDfKFNIyJ00XisZMri0
	VZCzyPAI2EOdyc+bFyB6Uw5/Um1s5XwJhQqjkPMm3zZ5J46JQAb4eFpY
X-Gm-Gg: AYBFou1DK8fK+a8pajCA/8N2RQKto5AfhzUT7dH9fHfjGRoJvAVp0upG11jL2Oxubqw
	s9pWvUWh62fWc8uJg7Dl06Axy8+Ozp77+U4AfUvcZtq2A10QbUptqifltwxYfpZfkZvyVtmBW0X
	jEM51515WWPosdaJ89ZcGisVuT7M8xq/lXcoZhvDS2xuGvinOoOuDrD6O4HwFCEsCa9V9DOEnTe
	cvTa/WWwsWultlhfgaebIgURikZgz4KrwdopGSpmm3Rl/C+4eGFQnKmyLSFMfWQlYqCIaGdGNAt
	gIb1jM++12vWsCnqAwoMl0bIUQ4IQMsmm/Anttky9wFvR8p3bnci1uGrqTJdbP2sQ/ewhXjEvbi
	iJW5ghJBtxagrZvOIvSSwYLdEXcmmSxJZ8QHV2tji2wkuPWOdwzWDwByZce/ebgO183YqdQLv79
	GwqpvdDby4o3CKS84koxRMCBhJqOThE4vMEG7nF3pa1rikV1DrzlYTSmcC+Qr+C7lZPtamnaEGE
	l/U4sUR0bZRxlVsM5lkk4QzLALYvYWS/NzkvwlzRIY7N1rsp8t+7egnzF3eCN95YH0LZBxy81nH
	bweg6M5RGNu0ktug9SS2FRyzwbykZ+xJBjJ42rApYZq6imABUy5EvN1zWsCkdecYoiKk+oaKx71
	tdLtn1W4ZBlUKUnRKiQ/2bM4e4j9qWTFTPRqsK6JPan1B1v+IFil8FVxkeY5viKgDY8Yg
X-Received: by 2002:a05:6122:298c:b0:5bf:b3a0:388c with SMTP id 71dfb90a1353d-5ec6882f8d1mr1888484e0c.6.1793397134616;
        Fri, 30 Oct 2026 14:52:14 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3753194e0c.14.2026.10.30.14.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:52:13 -0700 (PDT)
Date: Fri, 30 Oct 2026 17:52:13 -0400
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
Message-ID: <willemdebruijn.kernel.1805eb8882e13@gmail.com>
In-Reply-To: <20261030152540.1409884-1-antonio@mandelbit.com>
References: <20261030152540.1409884-1-antonio@mandelbit.com>
Subject: Re: [PATCH net v2] tun: bound the NAPI receive queue
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
> in ~6 seconds.
> 
> Drop packets written while netdev_max_backlog of them are queued,
> before allocating them, and count them as rx_dropped. The sendmsg()
> path, whose callers pass zerocopy buffers, is left alone.
> 
> Still open: the limit counts packets rather than bytes and applies per
> queue, and the queued skbs are still not charged to the writer's memcg.
> 
> Found, fixed and tested with the help of an AI coding assistant
> (Claude Code).
> 
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
> 
> v2:
> - Cc'ong netdev and maintainers
> 
> Notes:
> - Affected since 943170998b20 (v4.15). Reproduced on mainline
>   7be4bc52fd9e; the code is unchanged in net/main 94cea342e891, which
>   this patch is based on and was build-tested (W=1) against. The
>   before/after runtime tests were done on 7be4bc52fd9e.
> - Conditions: unprivileged user namespaces allowed, /dev/net/tun
>   accessible (0666 with the usual udev rule), threaded NAPI.
> - Mitigation: disallow unprivileged user namespaces or restrict
>   access to /dev/net/tun.
> - A reproducer is available on request.
> 
>  drivers/net/tun.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 770b8fe085c3..1ace0c1f22f2 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -60,6 +60,7 @@
>  #include <linux/rcupdate.h>
>  #include <net/net_namespace.h>
>  #include <net/netns/generic.h>
> +#include <net/hotdata.h>
>  #include <net/rtnetlink.h>
>  #include <net/sock.h>
>  #include <net/xdp.h>

Keep alphebetical order


> @@ -1856,6 +1857,17 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* In NAPI mode packets are queued here and processed by the NAPI
> +	 * poll, possibly in a kthread or ksoftirqd. Bound that queue like
> +	 * the per-CPU backlog, and drop before allocating and copying.
> +	 */
> +	if (tfile->napi_enabled && !frags && !msg_control &&

Why disable if frags? That is still using NAPI scheduling.

Same for msg_control. tun_chr_write_iter calls with NULL msg_control.

> +	    unlikely(skb_queue_len_lockless(&tfile->sk.sk_write_queue) >=
> +		     READ_ONCE(net_hotdata.max_backlog))) {

Nit: consider > instead of >=, same as enqueue_to_backlog

> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return total_len;
> +	}

also best effort: more robust would require retesting once holding
the lock.

> +
>  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
>  		/* For the packet that is not easy to be processed
>  		 * (e.g gso or jumbo packet), we will do it at after
> -- 
> 2.56.0
> 


