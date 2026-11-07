Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080337;
	b=tb7xPeDKAlGreiBG1zpknNQcVvObFM1uNYEIe5gOGcCS+k/C/CaL/h2Lr6aWv8BIg4Qg
	 W/4hWlWqTywOGEdXGYsy/pD58WLZ5Emp1m915S81FyYwgHWYOAwqddjIGqmVIMuuzJHJI
	 h3LE2AQr6AIn1VGNmVCfta2xDJDQVVHyMjlN5x1X6+r0gCQTIOsHfsLLAZ/h3f8dr1Y6/
	 oTKXIyISd8l1Jf1dTKlYQmqVElEvPFNfmvJpPf+JYxXDcMSqfenrJpaSZO3z/6/rAL3sR
	 yl1x7yaRxnQiNqRNvqk6w5evw49wZwhDrZuVEXhRXg7qqWpzMFQU44rLT9VynMGntYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=tqjlsZmhJDg48N9X3FOqlRV0cdVj2t2jS3/eCuO7plE=;
	b=ppiBGulZhy0Mp46ImShKdp189MZ/foEM02baiA2kUz6dLtF1vPWiS7/bGTndPPZB2+j1
	 tgU85NIghtsKeYkfvG95hdMDsrESaxLQurcBQc9s9bSZ9iDstodTZQOj2OMx+cLBkko0b
	 XcNWCuYI5B44kRPxI+SAMG+A77cWS8WgwoqUd2vYrFT5HOCLLbJ+Xo8gTpeAiufgaDfwA
	 vADIZxIJtphf80krrh/VezQvSYUFVSpIXHT9mFvlm77SiLXsR36RQZ83/1Pbyndf5QFLE
	 ZPwrccQHEhjqPCxsfrLgjAJ8bNRNEmXJ7Fut7ACl2NMbAFlVZXvuKULv+h1WXWOvNNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="mPjGzY/A";
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3C606A32F
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 19:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C3C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mPjGzY/A
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so2414095a91.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 11:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794080336; x=1794685136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tqjlsZmhJDg48N9X3FOqlRV0cdVj2t2jS3/eCuO7plE=;
        b=mPjGzY/APQ1GmdDexbABa6rKO+zeO1GGH6TMbIFEUYyhcBx3ee5FEjn33kr9QVKabe
         ttdyI3l0RO4+3B9bbFp6RXj9pzCQN4omIf5fRThCC4zYJt8h762Yfkwb8aq1wJ3LnJY2
         7SMuCWHHoQxhhigGUFFr4TrFJ0TDZbMvy9Y+m8B8+gKFQI34rjmoMHTjCMg/kwfDwTOu
         AQUs2ttxADDevYMNt9b3SRyhbzlGUgGVrD42gPBrxL6zRV43QTTpUPhQ4KPUognL1hNK
         HDQduHeWjTBfBSI/9gdr85YVNptYxpIZdqrgy/ictr428XclCiX8X3gJG94pVkcV4dcd
         eeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794080336; x=1794685136;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqjlsZmhJDg48N9X3FOqlRV0cdVj2t2jS3/eCuO7plE=;
        b=WqK4fESVn1QgIrA9dFFdgoSHu8AHO0L4yEa8/oodfQQyVN2HhDoPPyAerf7yRiYqft
         22xTsGK69DqO07nWDtA6J63J6Drrz6jPFfLZxjk4TyHPTvkqTqpxZK25fIGk3ZHRJqiR
         /u0rNkNMlm1RgS1czJ7AXKRgMpq11Z5Ku0x5P3YqCHskjReYcYUsEEFzKmWdx/yNa9df
         pMFUBmLurDvJ9RoOcuguRXeiCB4IEarfWoEsX2xCjSVaz5zsu8qlg2hOcQLgMJcKLyFi
         RfA8lGMUDZs2FbR6LB0o44RHSu+knc6qvQd8C/VSMy//nIXv/C67YIwvc0KPw5KQZVte
         T0sA==
X-Forwarded-Encrypted: i=1; AL+hErHZdB1BME8+VbXyMrqfDYXf3kUQlWVjW6qMHbl7uAJ9+GLibm4GgZui9eVbgYZ5BHEpCF6IW30=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xB0iuK/GMx53QN7okSy19WfqLZlVh9iusBFG+Mo01O2cvLzmO
	HmjbEf4spMIKhRImkYrIM6wKMcTruQHke/zuVmduG+/m03S/JXd9sDvbT3tZexTPJwQHTuVgLHO
	pFBixmA==
X-Received: from pglq30.prod.google.com ([2002:a63:505e:0:b0:cc7:d53a:a251])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39ac:b0:3b0:9cc6:62bc
 with SMTP id 98e67ed59e1d1-3b0db6ebd52mr6094061a91.37.1794080335721; Sat, 07
 Nov 2026 11:38:55 -0800 (PST)
Date: Sat, 7 Nov 2026 19:38:55 +0000
In-Reply-To: <au3HMfqNW3_DRMqS@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <au3HMfqNW3_DRMqS@v4bel>
Message-ID: <au9-QgRUrLwQSDYl@google.com>
Subject: Re: [PATCH net v2] tcp: do not coalesce segments after FIN
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, john.fastabend@gmail.com, sd@queasysnail.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 06 Nov 2026 21:25:21 +0900, Hyunwoo Kim wrote:
> A FIN consumes a sequence number. If another FIN segment is coalesced
> into an skb that already carries FIN, end_seq advances to account for
> the additional FIN, but tcp_flags still contains only one FIN bit.
> 
> When the preceding gap is filled and tcp_ofo_queue() processes the
> coalesced skb, rcv_nxt advances to the skb's end_seq. When the receive
> path consumes all data in the skb, copied_seq advances by the data
> length and one sequence number for FIN. If three or more FIN segments
> have been coalesced into one skb, tcp_inq() can still return a positive
> value after the receive queue becomes empty and the SOCK_DONE adjustment
> is applied.
> 
> TCP_ZEROCOPY_RECEIVE is another consumer affected by this state.
> tcp_zerocopy_receive() takes its length from tcp_inq() and follows
> skb->next without checking for the end of the receive queue.
> 
> Software kTLS receive is one consumer affected by this state. When
> strp->copy_mode is false, tls_strp_msg_consume() calls the TCP helper
> tcp_read_done() to consume the current TLS record. In the reproducer,
> tcp_read_done() consumed the record data and one FIN before freeing the
> receive skb.
> 
> When kTLS looked for the next record, tcp_inq() reported at least
> TLS_HEADER_SIZE bytes even though the receive queue was empty.
> tcp_recv_skb() returned NULL, so tls_strp_load_anchor_with_queue() hit
> WARN_ON_ONCE() and returned without updating the anchor.
> 
> Since tcp_inq() had reported at least TLS_HEADER_SIZE,
> tls_strp_read_sock() proceeded to tls_strp_check_queue_ok().
> skb_shinfo(strp->anchor)->frag_list still pointed to the freed receive
> skb. tls_strp_check_queue_ok() then read TCP_SKB_CB(first)->seq through
> the stale pointer, causing a use-after-free.
> 
> The reproducer followed this call path:
> 
>   tls_rx_rec_done()
>     tls_strp_msg_consume()
>       tcp_read_done()                       // frees the receive skb
>     tls_strp_check_rcv()
>       tls_strp_read_sock()
>         tls_strp_load_anchor_with_queue()   // returns after WARN_ON_ONCE()
>           tcp_recv_skb() == NULL
>         tls_strp_check_queue_ok()
>           TCP_SKB_CB(first)->seq            // reads the freed receive skb
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in tls_strp_check_queue_ok.isra.0+0x5f/0x100
>   Read of size 4 at addr ffff888103169ca8 by task ktls-server/71
>   ...
>   Call Trace:
>    <TASK>
>    ...
>    tls_strp_check_queue_ok.isra.0+0x5f/0x100
>    tls_strp_check_rcv+0x2a9/0x400
>    ...
>    tls_sw_recvmsg+0x3ce/0xa10
>    ...
>    sock_recvmsg+0xea/0x100
>    __sys_recvfrom+0x142/0x1f0
>    ...
>    __x64_sys_recvfrom+0x76/0x90
>    do_syscall_64+0xdd/0x4a0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    ...
>    </TASK>
>   ...
>   Freed by task 71:
>    ...
>    napi_skb_cache_put+0x24/0xf0
>    skb_attempt_defer_free+0x183/0x3b0
>    tcp_read_done+0x2d4/0x340
>    tls_strp_msg_consume+0x45/0x80
>    tls_sw_recvmsg+0x3c4/0xa10
>    ...
> 
> In tcp_try_coalesce(), skip coalescing when the destination skb already
> carries FIN. tcp_add_backlog() calls skb_try_coalesce() directly instead
> of using this helper, so add the same check there. Since both paths check
> only the destination skb, a final segment carrying data and FIN can still
> be coalesced into an skb without FIN when the other coalescing checks pass.
> 
> Fixes: e93a0435f809 ("tcp: allow segment with FIN in tcp_try_coalesce()")
> Fixes: 4f693b55c3d2 ("tcp: implement coalescing on backlog queue")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
