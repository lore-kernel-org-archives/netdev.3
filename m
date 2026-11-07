Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063868;
	b=BLSbqlRRWlGKbm2m9LVBsu+ZOmEXIpUw16SkXThluPcjrNUzUawadV6bYYKf9S8QPRej
	 Dv7ye1FT+SA4RnYPTgpsgNOEbEaM4fU/ihqhBZ+rZ8Za0zHLPXev67JMIVj+5zZ8nOkI5
	 c6ULKbzKSOzBsk5Fa0Kb3TQmu3mgOvB4mgIgCFQxnQluNDEKK9XVJEGJTvf2/PTNei9et
	 ujCn+sdpbh7dx1pgtF/HI/c+Vhdj2z9l/WDDrNIdws9/PuC34OGYrH9RaHUFbJtK5vHso
	 OnQH7SRTDfEBKuD9Ty/oQG3DycC6dVYGYYiAuRch6Wnfh3idgvm+6upYKcu8KljMnVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vy7ktIeClbyEEG+6rCnQhDLjTI8DqaLU7Mkwveq768Y=;
	b=Y4jIabV5/tvAR15e18iSpVk6+spkmNFH7UQTifdfk80iProBEyi/03pN5T7PTWy1iOgl
	 xHHqXN0MJwHi0xo+GoWn3k71FHGtlhK3FSCzLcPLjKqC9+3/nXfdrRP3CYjlHxKLAwPLZ
	 LAuadTugijQ9EzoWKUk/8JDmVIvpn0dTCQSkDVrfSHdcLnrKHICPyMNXpt/9h8nLN65w0
	 VqkoEEQFfVKWAaK1RnOMqQe/JTL0BTO3/Cots+9yZ8mSkkFZM13+zlmcsgIj4BiYoHWku
	 AKfkJxpxkva8TItlppDz/49ydqGzQm4YqCRAj/SeIuMatUWY0PEOFhvCk+zbpKB/3Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OadxouFz;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03059606CE7D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 15:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03059606CE7D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OadxouFz
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eac01ff101so567621e0c.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794063867; x=1794668667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vy7ktIeClbyEEG+6rCnQhDLjTI8DqaLU7Mkwveq768Y=;
        b=OadxouFzWDNRkM1dCLKi2MyKKY+rORoE2qjdptO5MHzNpvA8wdUE1aj1PzJc/k7xcK
         jsFQA6DDLEsJCjYqtvUpEcGmP3Ytokk9ByqGicDSvATDZ9IniPUc+ogA6+8Bci0dzCQ+
         iVsPAMY48OUYFBxaef01OBVqjqwf7gFj0ZgfH//zMf9wjCz70HTJFNjODCs2SrA/aqsR
         lrLClXacUbzoaBis5qSeRBMOQXIgISur2KPcP2egB1xROOnOIaRk9Msi9I6v+2QZLTsI
         mQNnlC2JL4gGYPpBFdyTt1cmZC4ok8fGX7rgbrSwxp5+sx7KkncRky0arvgIoY5RJzte
         16Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794063867; x=1794668667;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vy7ktIeClbyEEG+6rCnQhDLjTI8DqaLU7Mkwveq768Y=;
        b=2slrIHM9R3AjQSmZck49AP3miMkKy56ePU1WgBg5pVWNVpaGszV7O2W96qErKZmqMd
         NmA7rpSTgqZNP43hPkO7T0JH265dSkF2yDqZTO/zJmaQGRofOi51XtmX/ujuhFDnwmOi
         N8YG2XHpagcvWUqiYsH/gDjJnP2+1IlbhG1nCWwCvUz6SPFOpnMI35vQ8QBHCx0CAmOp
         yvywxeA8V8yr+FAmzDqVjDvq87iSHnH4L55mjY+V/qSKZdLkx4NLmAVGt7zyixbJpOT3
         aRfycF1NTjfkjeVI2WQ2uiH8XgbbmccoRjVyfguG9IJBUUwvQVVi77Sd2nEmq1Ag84L5
         2jyQ==
X-Forwarded-Encrypted: i=1; AL+hErEFldPw/kL47KNMHGey9Z+ovpK7Npqh/HR1e4mlNgVYbyoQ7ZVFFxHnWfSjArxZqYUKIUFEzZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r1cyYsv50SSNKWgogUQwn490i4iYhjUrqRhdB13T2euyfp/ZG
	Jgox0UXFESFQ58j92bcrFcdgYxGLGZF5mrsTvnetiGKfLNA3om/41/cw
X-Gm-Gg: AYBFou07NFSrggQtWKqGLMqnz4oDBZfFkHOO82qinlfPcMueVgcWX54wItbZkmkMV8M
	uP9Ee7AJVeIXE5QbxCWOyDDTzCcL950+xSa7U0BDJCPwTpxs73Tc85xCJGM69c2UFyAC4tR5jee
	S+PCfDXQp7IGT4x6cvxBw31yNQYTLzrrMHErAj+1YzccJ08/slHtBX4RrwZYk07uAE9s3IY4Mjz
	5FVTyKHgvleYrk4DnmFttr0SWyMMNpuynp8Fr/aVCQJ4GjREKJBaHuf9LF18Dx3KcjgEum825H+
	HbQkp0PBTFtCU450Motlp8+xnycQ0omFvR3cfsghpoB75djOOtcFjkB4VMrYs+LUHj6gqr5xVUz
	SOC4VIlU6p9Zv0RjUjprxGiwluHjK7IRMSYhN/kFb6obV5tLGbsrO1e2y2AKfH8aLF/tWeu868F
	SSOtnlRHMlvqixriI/w4VtKoNdI7M6v+z/wjWjteXu3XNcfJFQ8wVvThkZ6ewvKwE3xqihdbchi
	bZDrBQjQKTBJPScYEcr1TOYNFCsjLf3Bz9LcUTYYnaYHTZJg0L5PlTkfu7+DSz/KKTvTE08pYvL
	9rsWUZfX+XqcN1K/iLbOSSdMDljMuy0Ud8Hzs7m5GmDmaVZwyh09oE/2TkfSP3tY6ZrPdIVeiJC
	ir0Pjl1VzI9f6Fp3k+v4KVgSlWgVGGWn76SoDjZfR6d09Hqn7aXaGMHAUPre5VMFOFpIsEOA=
X-Received: by 2002:a05:6122:e443:b0:5c9:a60b:e5bd with SMTP id 71dfb90a1353d-5ecc43f9985mr2270855e0c.13.1794063866745;
        Sat, 07 Nov 2026 07:04:26 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64e8c5dsm3974947e0c.11.2026.11.07.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:04:25 -0800 (PST)
Date: Sat, 07 Nov 2026 10:04:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: shao.mingyin@zte.com.cn, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 josef@toxicpanda.com
Cc: horms@kernel.org, 
 josef@toxicpanda.com, 
 willemb@google.com, 
 almasrymina@google.com, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.703e96022339@gmail.com>
In-Reply-To: <20261107215051120CrLjo_cGXWfdJxXk4ae8s@zte.com.cn>
References: <20261107215051120CrLjo_cGXWfdJxXk4ae8s@zte.com.cn>
Subject: Re: [PATCH] net: skbuff: don't BUG() when skb_copy_bits() fails in
 __pskb_pull_tail
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

shao.mingyin@ wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> __pskb_pull_tail() BUG()s if skb_copy_bits() returns an error.
> skb_copy_bits() fails when the lengths do not add up, or when a
> frag_list child carries unreadable frags (devmem net_iov, commit
> 65249feb6b3d ("net: add support for skbs with unreadable frags")).  The
> top-level check above does not cover frag_list children, and
> skb_gro_receive() links them without propagating skb->unreadable, so a
> mixed skb trips the BUG().
> 
> Nothing has been committed at that point, so return NULL the way the
> rest of the function already handles failures, with a
> DEBUG_NET_WARN_ON_ONCE() for debug kernels.  skb_condense(), the one
> net/core caller that ignores the return, now checks it and keeps the
> original truesize when the pull fails, as the frags are still there.
> 
> The other direct callers that ignore the return do not build a
> frag_list child: xen-netfront drops the skb when the failed pull leaves
> nr_frags at MAX_SKB_FRAGS, and niu, mlx5 and ftmac100 pull at most what
> their own skb holds.  A length mismatch there is a driver bug, which
> the debug warning reports.
> 
> This is the separate change that commit 279877d86c82 ("net: skbuff:
> don't BUG() when skb_copy_bits() fails in copy helpers") left for the
> callers; the audit is above.  No Fixes: tag and no stable marking: the
> mixed skb is an invariant violation, not a regression, and this is a
> net-next hardening in the BUG_ON() removal series.

In the series, Josef reported

  Two BUG_ON()s are left on purpose.  __pskb_pull_tail() and
  skb_pull_rcsum() have callers that can't otherwise fail, so they don't
  check the return.  Some of them would carry on and BUG() somewhere
  else, or push back a pull that never happened.  Those need their
  callers fixed first and will come as separate series.

> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
>  net/core/skbuff.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> Tested on 7.3.0-next-20261030 (QEMU/TCG guest).  QEMU has no devmem
> (net_iov) backend, so a TEST-ONLY hook (applied to both kernels, not
> part of this patch) fabricates an skb whose frag_list child carries an
> unreadable frag, then calls the real __pskb_pull_tail() on it at
> late_initcall time: skb_copy_bits() recurses into the child, sees the
> unreadable frag and fails.  The hook then calls skb_condense() on the
> same skb, so the failed pull must not shrink truesize.
> 
>   unpatched                             patched
>   kernel BUG at                         __pskb_pull_tail() returns NULL,
>   net/core/skbuff.c:2903                skb_condense() keeps truesize 960,
>                                         boot continues, no BUG
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 48f676411724..8a200252ef93 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2900,8 +2900,11 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta)
>  			return NULL;
>  	}
>  
> -	BUG_ON(skb_copy_bits(skb, skb_headlen(skb),
> -			     skb_tail_pointer(skb), delta));
> +	if (unlikely(skb_copy_bits(skb, skb_headlen(skb),
> +				   skb_tail_pointer(skb), delta))) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return NULL;
> +	}
>  
>  	/* Optimization: no fragments, no reasons to preestimate
>  	 * size of pulled pages. Superb.
> @@ -7218,7 +7221,8 @@ void skb_condense(struct sk_buff *skb)
>  			return;
>  
>  		/* Nice, we can free page frag(s) right now */
> -		__pskb_pull_tail(skb, skb->data_len);
> +		if (!__pskb_pull_tail(skb, skb->data_len))
> +			return;	/* frags are still there, keep truesize */
>  	}
>  	/* At this point, skb->truesize might be over estimated,
>  	 * because skb had a fragment, and fragments do not tell
> --


