Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980739;
	b=RjvhWKwvxKz4XUMhqAAHNJUaysRP+Ouw6HU/mDOfY8ejH9aupWdKdWHWdREWTcHFXJvy
	 fM9CMocXu9NJUosBEvOCCwBtUSltam7w1hI8tQMrkE+OEJtmzTyg3eElYPV/K4rmwc7Vf
	 qlSjRzfZdCwc5f9jflyaglk57U5N7+infIUFiS5tbKDS0niFmht/ftfp9hTjy4Qb3a+48
	 MFxxK30ly51LJ0OaRgvnwDmbXZHNR/c8dZ3CeQCXSb+QFplcnDr2KAbSXUeVuc0ottPgf
	 Zd49ve1+lN2EGjjI/sMLMXXgphR7QNB8a6OqhrQTRx4YcR0Yd+Gf1wAjCg0vihAka9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=h0FLNe7OgMvWwaVPDLaJN55GeCrtAhkwCaQBCaPz6Vg=;
	b=GnPBKRGlUCxXFkaZ9/4aUsajDS1wlrlyrZu5RjMDkhbB4A6FAl/9yL2021+g4v7ZbGeR
	 ox9bsJ0fpDDfv9K0YFgYuxGvXiyN8a2tn4CilhoI265LG9qKKE/7YHm2rVZeqz4iRn4S5
	 UMYOFJEO0GUXb0c6gO3XV/s8jlpgx70ZrG/D2oqy+kF9Oowgdpzj7arxQYFDzl8ccri1z
	 Avfk2a5mz4hza97TI/lQtH85XzhKVnL63w4STqwDCchRynAuXz/K9qPjwYQrqszCB4ULf
	 AAaryfT9WwwMEdyojlObnnEQcKqWEy3LVssMbwCTQZRHL5L3DLF8FfJbIGDkCfWwtSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SY23Fkeg;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D14606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4D14606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SY23Fkeg
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so650848e0c.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980737; x=1794585537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h0FLNe7OgMvWwaVPDLaJN55GeCrtAhkwCaQBCaPz6Vg=;
        b=SY23FkeginpUa1pj1QjrtDQ5LYcZgd7SzbZrJkM+DeVApIkM5UW8gXKdOASjJ/Qfzz
         SUkWTfO7aicweaCxI9b4bEU5t8illAu4sX05P+9MgsqCE3ZVDEvHjT2gdWAhEcj0+s5x
         MWd0aQUHkC00BxSf/Fdwff6utfjsfvLdv908vTQ9QgApaiwaDTHGpkM/FyaDiZTZu2eK
         tzIWFYDKK/3lR/bSb/60oj0oFuzDDHtAmpMzhResVMaVPX+dC/qRlEyhwF8D7jilv5I9
         xQnD2/BAjQc6L+iG+h2SVkfAhe2DOGMdlfSFCLlbZCHhasGZzomBC69JrzZE8jsf+qaP
         XBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980737; x=1794585537;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0FLNe7OgMvWwaVPDLaJN55GeCrtAhkwCaQBCaPz6Vg=;
        b=sjqF7MPxIi2Z5ZFy9UTcNtEF3v4nW7ItzRw7e8bviyhGz/E9mvqCJ4Kr7BeTua/7Ag
         t2n0df4SW6tMQGLUJ2TZLs1IEwXnY6oNhGUxHuoJlTOqJWqEFM3aj4+btZoTmG/HJ9c9
         eMXBLW2SDTIGYXJsNchhp+aYVFXCzWyVDPFOK4HyfIQVussGEnONR8C9xuHxYlS1yEB6
         rO0Sj2la8PQZRxTt9oOc8NtzamyQt60tnTKmeTwdBro10pguL9XYkVipqjleX8/G5K+J
         EVn4tbZFs6HRbIQuF7rt4d6uWj+D9hqn+4PO/fOc09LUjsBbY+pAbIbIRKhZNPiQwDt9
         sSpA==
X-Forwarded-Encrypted: i=1; AKwUvByg5NjBXqcKSM8er3c9M7PHnN9lHdycBY1onFaYrDgQkyClz//j5AjcB6kb5Zi/z3X26crU9wM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s1eFNqatqTz/Fh7Z9ebIjUQWP26zjdsD0WSNnliElwYqYKInj
	nDeb6dX9iVqwG4b3zsrbxiTKTZGY/9GcmFvGGrzrZSuYgUAfLgN6g5ywxQfIAQ==
X-Gm-Gg: AYBFou3zagE3mezWn1QpkJByJT1t00buewGAwkklA38bOcP58Fq6A/y87A0AeVNmmKn
	a2eXePMN28HsCLyzGk2YuJ1HhjasaKNfM7GFiuCZ4QRBC9g7PKkBmadx5JzpJNQDhTI8Uk8vko3
	tnCsU8TwT3+Ob8MymAwaUZRK/bP8YhX003dXf89u69vpj/6L+ydPTd6ive4wgFb/11g9UeYEGdu
	wC9/m3zNU3TrJPHJz2XwxC/RvuEjCEJQRLo5oqBa4h2fXWZXiRX0pSbuf3P3eOHj4DogeO64ADx
	nicPyBfMVCWkQzk8g0i8O0BAG96U0APnLFgXNDASYwF1o5ei29oSY2Qvxxviz/AxyMf5kXPvut0
	ivMJEeEKuttzDw2GX8s79wM+cGrJ9IdQichWs0w/hgLPQM44/ZZ1n5bhOccfDIaN9gFrmOoDXld
	PRBNhSHkRnyVqM/gONily7P5N+AXG+Dmf2IJDHBb+40xUh6pk2jX4mKKoZGJVVpi5Rf+zfUmb/n
	tjOYhHjUg+1vpU3B5NAMAjVxxMOyDumyEYn3bopYx088pwcea2utUdd0SJrK0KyDQm65nczB2zF
	1+553m/QK3H0uqrZ56Z194H9VAvvOVr9crflCxiYomn11MjlML5gJYuRBBIVmL8k82XG/Z0YWLi
	1yu3404FXie7Ks8JdeJNTz4+wmSgOvknfMd0xCvATgezlo2JlvSZBlJzkE49y/NOKxr+2UJY=
X-Received: by 2002:a05:6122:c25c:b0:5ea:be49:f93 with SMTP id 71dfb90a1353d-5ecb428be54mr2464694e0c.11.1793980737461;
        Fri, 06 Nov 2026 07:58:57 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64cb602sm1627480e0c.7.2026.11.06.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:58:56 -0800 (PST)
Date: Fri, 06 Nov 2026 10:58:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Message-ID: <willemdebruijn.kernel.112eb85986c12@gmail.com>
In-Reply-To: <20261103092541.273847-2-jingxuanxie@deeproute.ai>
References: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
 <20261103092541.273847-2-jingxuanxie@deeproute.ai>
Subject: Re: [RFC PATCH net v3 1/1] af_packet: avoid waiting for TPACKET_V3
 copies at retirement
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

Jingxuan Xie wrote:
> From: jingxuanxie <jingxuanxie@deeproute.ai>
> 
> TPACKET_V3 retires a full or expired block while holding
> sk_receive_queue.lock. prb_retire_current_block() takes
> blk_fill_in_prog_lock for write to wait for in-flight copy_bits()
> before publishing the block.
> 
> On PREEMPT_RT a copier can be preempted while holding the read lock.
> The packet path or the retirement timer then blocks on the write lock
> while holding sk_receive_queue.lock, and the receive path resumes only
> after the copier is scheduled again.
> 
> Try to take the write lock without blocking. If a copy is still in
> progress, leave the current block and its metadata untouched:
> 
> - the retirement timer re-arms itself and retries after the configured
>   interval;
> - packet allocation returns NULL, so tpacket_rcv() drops this capture
>   record and accounts it in tp_drops, while the original packet remains
>   in the network stack;
> - a later packet can retire the block once the copier has finished.
> 
> Do not dispatch the next block while the current block is still open.
> The existing lock order and completion ordering are preserved, and no
> new state or worker is introduced. The trade-off is a higher capture
> drop rate while a copier is preempted; original traffic is unaffected.
> 
> Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
> Assisted-by: LLM
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>

No need for a cover letter for a single patch.

And a v4 will be needed, because this is sent as RFC.

> ---
>  net/packet/af_packet.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index cf6429f09477..8fd6372ab59b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -200,8 +200,8 @@ static void packet_increment_head(struct packet_ring_buffer *buff);
>  static int prb_curr_blk_in_use(struct tpacket_block_desc *);
>  static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
>  			struct packet_sock *);
> -static void prb_retire_current_block(struct tpacket_kbdq_core *,
> -		struct packet_sock *, unsigned int status);
> +static bool prb_retire_current_block(struct tpacket_kbdq_core *,
> +				     struct packet_sock *, unsigned int status);

no unrelated style changes

>  static int prb_queue_frozen(struct tpacket_kbdq_core *);
>  static void prb_open_block(struct tpacket_kbdq_core *,
>  		struct tpacket_block_desc *);
> @@ -711,8 +711,9 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
>  	 *
>  	 */
>  	if (BLOCK_NUM_PKTS(pbd)) {
> -		/* Waiting for skb_copy_bits to finish... */
> -		write_lock(&pkc->blk_fill_in_prog_lock);
> +		/* Retry later if a packet copy is still in progress. */
> +		if (!write_trylock(&pkc->blk_fill_in_prog_lock))
> +			goto refresh_timer;

Since this is only a problem on RT, and it introduces drops,
consider limiting the switch from write_lock to write_trylock to only RT.

>  		write_unlock(&pkc->blk_fill_in_prog_lock);
>  	}
>  
> @@ -738,6 +739,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
>  		}
>  	}
>  
> +refresh_timer:
>  	hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
>  	spin_unlock(&po->sk.sk_receive_queue.lock);
>  	return HRTIMER_RESTART;
> @@ -946,8 +948,8 @@ static void *prb_dispatch_next_block(struct tpacket_kbdq_core *pkc,
>  	return (void *)pkc->nxt_offset;
>  }
>  
> -static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
> -		struct packet_sock *po, unsigned int status)
> +static bool prb_retire_current_block(struct tpacket_kbdq_core *pkc,
> +				     struct packet_sock *po, unsigned int status)

again, unnecessary style changes

>  {
>  	struct tpacket_block_desc *pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
>  
> @@ -963,13 +965,14 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
>  		 * the timer-handler already handled this case.
>  		 */
>  		if (!(status & TP_STATUS_BLK_TMO)) {
> -			/* Waiting for skb_copy_bits to finish... */
> -			write_lock(&pkc->blk_fill_in_prog_lock);
> +			/* Do not wait for copies while holding the queue lock. */
> +			if (!write_trylock(&pkc->blk_fill_in_prog_lock))
> +				return false;
>  			write_unlock(&pkc->blk_fill_in_prog_lock);
>  		}
>  		prb_close_block(pkc, pbd, po, status);
> -		return;
>  	}
> +	return true;
>  }
>  
>  static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
> @@ -1097,7 +1100,8 @@ static void *__packet_lookup_frame_in_block(struct packet_sock *po,
>  	}
>  
>  	/* Ok, close the current block */
> -	prb_retire_current_block(pkc, po, 0);
> +	if (!prb_retire_current_block(pkc, po, 0))
> +		return NULL;
>  
>  	/* Now, try to dispatch the next block */
>  	curr = (char *)prb_dispatch_next_block(pkc, po);


