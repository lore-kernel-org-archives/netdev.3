Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528225;
	b=KzcmOLvegYoC38C18V0EqQmhjNzzJx7bzXK1URvBJWR0V+lXmnuPUU1ffDLNh0l3OZW+
	 8FshOz5r+otFThoFE0s2j+IRcEzBS1UouFY1XYFMnIn6Fg+ftZC5e3tPbPxd13bUgJMxm
	 juVuHdcYephsbFpLtjZdb93ec1i+zYifW3yt/d73OU+adphZyV5W1+pi9ofxJiD+GXMIi
	 6jlZ8cE31aBYp7bXcGuGSN9GcFlO9TZpi9X/viTzy7PjG8tJJ8cXwEKacwTf0R6w3IFvc
	 meTwKx+KoI4wg+w2tw4AFy7D07FX6qUskbw4wfevjrwgokdIxWFTLINvKfIa1dZju3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n3EYCbbbGBOA4SNhncsXBfuKYI2HFyvcvwJsqRBHZ7w=;
	b=MzhIOP64q24OFhxjcYTc4gykq1ogspXLBcRGkgNnfvS/6P4cUnLMO/UgEUJdS3YOkcVf
	 HmalahcucoRx+HRcIJ+Bx9hhaZ3WI9BHyiA5LkD1rlGme2GBl2RNzNrvHN9DMCCBzmvKM
	 IEUovf1Oz68DYX6PeznlRnvZdZk7znGUF3uJmLji4Z65yxlFbuEivXiRBcj93kw+2+lq6
	 sM2X5BqpAF+AlmkL5n9Rnwy/5s0K6PIptOol1/qMvXvbcslseWNm2E6IIy8YvFn7aJVQ5
	 tP6J8IwL1LXptqSBTZw9r3jSt+N+ZUqhBR3O03maK87oA+HUWMunTHL6psHfJG9Zvog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kCtefAz4;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0604606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0604606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kCtefAz4
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso151110e0c.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794528224; x=1795133024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n3EYCbbbGBOA4SNhncsXBfuKYI2HFyvcvwJsqRBHZ7w=;
        b=kCtefAz4/EkDF3Yqj6SgOJsCYDn4NeoTs1if1EcQU9pQ0nzGBf0PQGOPzY8zQBnqBQ
         29pH0NHAWTM0gqPBw6y6GqAE1WZ2cqKxqY50ogebyPwYYSHvRqpl9se8ZCp7nh9196A0
         +0ns0Vik8xHARVqNwSHJLKXF4IUCbBL3oZMhGxUs5FOJJhFCtSfvUH8mj3nwmjQqlj1z
         e4qzoCKyKyKtxarqMzaG8AQ7sK6cdFjvnNskYnFI+714B6u6wLp4OA1NpFUdGFQSihlI
         Zi/KMT6vU6upGejVAhXsGTbA3bKZEw9yO3i7wfNGrEg+h42zv+FrrCqEvtRlswh710WL
         yy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794528224; x=1795133024;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3EYCbbbGBOA4SNhncsXBfuKYI2HFyvcvwJsqRBHZ7w=;
        b=QLMVxM/uW9drG9K4lSclaj6gH+rVQ/FPEmARoRgTEh9X9/ciNKR1aTlmMMSua2Oe+N
         LBnOAPTyUh5Js3jQ7QDj5L1H7wRqe76oUOYuVXNqt2IFUcoNOYsYruVM4y2+3RGE0LqS
         YvPo1Fxbf/87aLaz/HRzUxjntXlzBWG+AJ3injwvoILPJNe8e7UXK6ckSmlOLnFXihW5
         WPiqqfn4LbKn4U/BeLk+ILL0p/yqgeohkXVUZYmIFSQtDZc/AKulw1SYhbwimeB2s3Pl
         dwdGurVsqs8+iq8N7akkPXWXhpMS1Cy/JrLuvaF4eeUg13WCsuTCSpETOKtAy8wh/tk0
         DO+Q==
X-Forwarded-Encrypted: i=1; AL+hErE92X1jbws9fGpk8rDGHFsQdL9UmlPbIi/Z0wTA+LWI3BVRFB9rElIoVxQUP5jvPY/EECBOaHA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/e6d+ErIQ9pXKVbMAkwDD3pCXtPBB+LeLkV6NvdCvHDstnk0yu
	Gs1W8VrHK9d6xSlMfZGIjX5aIXSS/VtFKa7oFIghAcCZ/Gmo4ix7OUqN
X-Gm-Gg: AYBFou13/1PLXyYgclV2zOyBAV2TURK0585yC00TaPOvxqfGQQp7KKOUsHnzHq6oXKb
	GgRHpVEqdR4Ccz+w9OAoTEKq1NbrCVQUv7u30EngtCjPCHvmw2J1W29G3ykIhfBC4PkvugP6qsK
	uPWJRWC/SAgfbBG7XROzUIB/gkdVlGOkRLtc8kyQgnucwd17vd8/SPdIl0wTb5ozdpGC2fJsOvH
	Cay4Tiu9+oU6Kb51ypKqgEedmw0FkilmXwTK7Cbh8ro2gc+nV82DqyEvMex1+538oXr5jiBmUkI
	nqanNSfURTfuG4dbLBa6Tm/cvhZ5Yy9hpq402rOxPhmn2Yt1wwG6mlijiUH9zGA7dNxzZB2hcRc
	RMdtWKWnwRiB4r14l3vYyTnr9vUzUvf5qQqSuv1VnT5WJARkUdIH1gF43C5HQVfpfo2cNTSiCyu
	AEEvPIlCVPT0fzOBYzix5CvWYnLYm5EsPRw5MPziLryTyN4OSutWF1p4xRgD8mVFAAu1hw1ia2t
	q+R3VhPHQoX/8mJdUm4GS8epLOKfkXH7WT+MXW6MTHKjxI9FFhSMl4NiiOR5I5mMcn86LreJeNZ
	oO6lDDfRVRtVIc66CbpPEySCSjuW68eyg/KoamgPg9n32ZjdeYrIvfTPkTNTF06fgmBSAcZjoWH
	t7R3mxhVNcVpfxZ1Pfv4myYHPRxWPccN4nFm0nlbEsC0Uk/GhfMKjHnTEABr9Kyk=
X-Received: by 2002:a05:6122:3295:b0:5e9:6d96:aa38 with SMTP id 71dfb90a1353d-5ee34a72ee5mr262842e0c.9.1794528223692;
        Thu, 12 Nov 2026 16:03:43 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e3137csm349609e0c.3.2026.11.12.16.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:03:43 -0800 (PST)
Date: Thu, 12 Nov 2026 19:03:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 edumazet@kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, 
 Jiri Benc <jbenc@redhat.com>
Message-ID: <willemdebruijn.kernel.27a5f74eac338@gmail.com>
In-Reply-To: <20261112102001.3744643-2-edumazet@kernel.org>
References: <20261112102001.3744643-1-edumazet@kernel.org>
 <20261112102001.3744643-2-edumazet@kernel.org>
Subject: Re: [PATCH net 1/2] nsh: limit recursion in nsh_gso_segment()
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

Eric Dumazet wrote:
> nsh_gso_segment() calls skb_mac_gso_segment() for the inner packet,
> which calls nsh_gso_segment() again when the next protocol is NSH,
> either directly or behind an inner Ethernet header (ETH_P_TEB).
> 
> Nothing limits the depth: a GSO packet made of stacked 8-byte NSH
> headers recurses once per header, and a 64KB packet can hold about
> 8000 of them, overflowing the kernel stack.
> 
> Such a packet can be injected with a packet socket using
> PACKET_VNET_HDR, or with tun/tap or virtio_net, as nothing checks
> that a GSO packet with VIRTIO_NET_HDR_F_NEEDS_CSUM carries the
> protocol it claims. It is then segmented in software if the output
> device does not support the GSO type:
> 
> BUG: TASK stack guard page was hit at ffffcad5c0ab3ff8 (stack is ffffcad5c0ab4000..ffffcad5c0ab8000)
> Oops: stack guard page: 0000 [#1] SMP NOPTI
> CPU: 3 UID: 0 PID: 337 Comm: nsh_gso Tainted: G            E       7.4.0-rc1+ #118 PREEMPT(lazy)
> RIP: 0010:lock_acquire (kernel/locking/lockdep.c:5902)
> Call Trace:
>  <TASK>
>  skb_mac_gso_segment (include/linux/rcupdate.h:309 include/linux/rcupdate.h:849 net/core/gso.c:50)
>  nsh_gso_segment (net/nsh/nsh.c:110) nsh
>  skb_mac_gso_segment (net/core/gso.c:53)
>  nsh_gso_segment (net/nsh/nsh.c:110) nsh
>  [...]
>  skb_mac_gso_segment (net/core/gso.c:53)
>  __skb_gso_segment (net/core/gso.c:129)
>  validate_xmit_skb (net/core/dev.c:4238)
>  __dev_queue_xmit (net/core/dev.c:5087)
>  packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
>  __sys_sendto (net/socket.c:800 net/socket.c:818 net/socket.c:2283)
>  __x64_sys_sendto (net/socket.c:2290 net/socket.c:2286 net/socket.c:2286)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
> Use gso_recursion_inc_test(), added in commit 006c8b834aed ("net: gso:
> limit recursive IP-in-IP segmentation"), with the same limit as IPv4
> and IPv6. The counter is shared with them: a packet with four NSH
> headers in front of an IPv4 header is still segmented, one more NSH
> header and it is dropped.
> 
> The NSH -> ETH_P_TEB -> NSH route is covered as well, as each round
> goes through nsh_gso_segment().
> 
> Fixes: c411ed854584 ("nsh: add GSO support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179443691180.2199510.148246238688217560@kernel.org/
> Cc: Jiri Benc <jbenc@redhat.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
