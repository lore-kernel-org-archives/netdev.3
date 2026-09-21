Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F64C10FD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023815; cv=none; b=BX+V9KVagR6bTGDw6ZEBqR5ZM+LIq1O3/+HO9dRdj8F1aLifQGI0U6AwZYV4p6YIhImzcdL33VVQSUD5JE7Pd/xHwMCFh6wE3mvV0lq5+R6G8HK6rJEE2+SnxD/XGzIaszNMuBtNuBt/rtVYpEjDBW473O/6Grr/xGMVYjRBajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023815; c=relaxed/simple;
	bh=vlkENVdozsVqVSjosZ3KQV6LiHJqMFBwgNffTSH0dCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/VF6N2sIKye2qCMWecbpADHS2lmSjxLGJrSh+t5G2TAKFEpRlwMpnOZvJf+6Y+T3BdAcSUNnr/bJwC224V7zMUqpFVeXArg8fMb/H1MRkFMir68+Pdv7GiJ/fs7uhJF/ZRMG2l5aEZhmLY9EczUoh6HGEGUfCKBSInBrHThBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h09THmb6; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h09THmb6"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-39e59dca659so2104658a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023810; x=1790628610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=puqw9YXrTSSXRyl2dtnaKSSgPoWkcox7GAe8T6ATYE0=;
        b=h09THmb6gyb6jszooC3snbSxWyfLMMaN6yEySOMoSOuN9zn48iakb23XWN+2kgKTca
         eL2BKpZ/e6vsz3k/J1PrTmnWbh9Wyek6hcrKGl2knvyz88CvcloGe9GaSYBbn9fHEicj
         9KZPInlobIRo8yBXtufxi+7jdUqCLipfnx1p7pp0+aFFU0+E96pwBZdtleeKtF4T2C5J
         tPJs5Zj6PxbDby6PmBUEV++CINoaVTp9h7KQd8lmOgLm/Jzt/qwGSygmCLrMybQQDUIN
         M1uvsXfcKU7R0RdFdOND4EiYUqUBS915/06/wMV8kD4WIpegcY0WG+53uXGg8NnUbsjQ
         e1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023810; x=1790628610;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puqw9YXrTSSXRyl2dtnaKSSgPoWkcox7GAe8T6ATYE0=;
        b=AEPdYqzNRrVgnb9pf7q7IBGwx8bI6d2sZjdgS1cYXJ7aHQvlJ9PR40GXQZ4cL49bpn
         gkKrtc1eRzLPYzwLj01cvozuYCOveeEnDtWaN3/zA68GeMwY+wERQiZTsODH2ZAni4+E
         ImdPiIkUNMYJomK2Z5c1+fthrHzmOgcCS2LbJ6YXWISfGR8oYTc0kPA2JO/9BCXPw9uw
         5a8JZE6n7ncrG5Gf2amuabLNcDnSw5ib9f99D//hPqpZFIra/JSGijz+/7tTn+d2xT1S
         0WvXLWQUn/a6Tofv2fN6MBhLJ2JkNaC+S/ueYdqaxwqW/YKHQuzHzs4uurBEp24ZDzqO
         JXqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwEQAXEgwQxKR+g/tq8iQl6x+cja0MhVenwTN7Utco+IGD0RlfKgHVl2L4ETTZ2CE9ahpUgrEs=@vger.kernel.org
X-Gm-Message-State: AFuF++m+7CHZGkGoyNHbFl23MRB6SvtRo2JLRyzFw3phpfD6U2gGavyB
	1/RNB4uajKO5wjEBacTknT1g5QA75AX7VfOBzedliV2n+MPD9ycjg/v2
X-Gm-Gg: AYBFou2z0Q2YKnTsgG8T/SQXgWGdLDrokbELgX4XZwx0KFyldB+T36QyoeUSvCisFYy
	EOTTPv57MjIjyDT38lkqO2X0JzctGMe8Q8NuO/H8iKg0zz6gVdEvI65DebnnoBcEeHkIB6FOh4J
	W0Fj28Cl7Nl/yzAW0o7Xpje9ekoL348j5Wh0oN+f9aeTjzjdDauQGwrVZCVEJI75mvjEz5R4+Qt
	mSi5jqoMprHHrrn5PQlFbCIQrVGXw4vBH4CuU3sB8+g8n7qPY5bd+3GsgdFSNvhwBEx/QtGzu+r
	NObBoSMueJ37T/cdhysXmR+gIKum5Rgr5DgmZpv2qwKK8ZStY2JG0FP///ZPVfyDFyPRcClVV3q
	1s3c94xak53kTzx/EMPnoNY8hEyJszPyoR/Z5/CSdnYLHqY9xzMJGcF7DVmVq//ftt80CNIPlpS
	SoZJS+soHzUDBi2Qi1SGh91q78saraWYTU37GA2CcZjJEioiG8KRShNFXOsuV+zyzp
X-Received: by 2002:a17:90b:440e:b0:39e:6c69:7777 with SMTP id 98e67ed59e1d1-39e6c697978mr11174081a91.32.1790023810006;
        Mon, 21 Sep 2026 13:50:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm963556a91.12.2026.09.21.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:50:09 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:48:25 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/7] bpf: tcp: Introduce
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
Message-ID: <arGYDmJHhcm9LiEs@devvm7509.cco0.facebook.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920195633.3033620-3-kuniyu@google.com>

On 09/20, Kuniyuki Iwashima wrote:
> Waking up a thread per packet is expensive when an application
> processes variable-length frames (e.g., RPC) that span multiple
> packets.
> 
> SO_RCVLOWAT can defer wakeups, but because the frame size is
> encoded in a fixed-size descriptor at the start of each frame,
> the application has to:
> 
>   1. wake up and recv() the descriptor,
>   2. raise SO_RCVLOWAT to the payload size via setsockopt(),
>   3. wake up and recv() the payload, and
>   4. reset SO_RCVLOWAT back to the descriptor size via
>      setsockopt() for the next frame.
> 
> This requires an extra wakeup and two setsockopt() syscalls
> for every single RPC frame.
> 
> With SOCKMAP, we can parse skb and suppress wakeups in kernel,
> but SOCKMAP adds overhead and also kills zerocopy.
> 
> Let's add lighter-weight opt-in callbacks to bpf_tcp_ops to
> replace that.
> 
>   .enqueue_rcvq(): invoked when TCP stack enqueues skb to
>                    sk->sk_receive_queue
> 
>   .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
>                    is dequeued from sk->sk_receive_queue
> 
> Those callbacks can be enabled on a per-socket basis by
> bpf_setsockopt():
> 
>   int flags = BPF_SOCK_OPS_RCVQ_CB_FLAG;
> 
>   bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
>                  &flags, sizeof(flags));
> 
> or via the bpf_tcp_ops-specific helper added in the next patch:
> 
>   bpf_sock_ops_cb_flags_set(sk, BPF_SOCK_OPS_RCVQ_CB_FLAG);
> 
> Later, we will add a new kfunc to adjust sk->sk_rcvlowat from
> these callbacks.
> 
> This will allow the bpf_tcp_ops prog to parse each skb and
> dynamically adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN
> wakeups until sufficient data is available in the receive queue.
> 
> The placement of bpf_tcp_ops_call() in tcp_ofo_queue() and
> tcp_fastopen_add_skb() is chosen to provide the same snapshot
> as tcp_queue_rcv().
> 
> For example, if bpf_tcp_ops_call() were called before updating
> TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> need an extra branch for the unlikely TFO case to strip SYN.
> 
> In addition, the TCP stack can queue overlapping skbs into recvq.
> Once rcv_nxt is updated with a new skb, BPF prog can no longer
> infer the previous rcv_nxt from skb->len.
> 
> Lastly, dequeue_rcvq() is placed in tcp_cleanup_rbuf() rather
> than __tcp_cleanup_rbuf() so that it is not called for sockets
> in SOCKMAP, where calling sk->sk_data_ready() from the new
> kfunc would otherwise trigger infinite recursion.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
