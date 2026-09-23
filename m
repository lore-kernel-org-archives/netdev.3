Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2862E229F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203343; cv=none; b=OJsh4bEtZFVxkBn8aXSJcBce/o5piqSquXQ3yo9YnoWy7l8oHv63RdNgbE91OCTc+lQS1fUewYmrHVsC5Hzqd/fxfqiwxoWz3y7z3J7lAhM2fM/Dy+S9j90h1Mf/+bbO41hF0j5RMHRTdlTOVWfmdPCefIOMwVAucXaOzkTpzlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203343; c=relaxed/simple;
	bh=UnZEx8aHCIPn3Bg4pux2aTwrjxpwghYteodfvETUJ7o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lHmHQ4bpvM+czAtjfi8BDbz9/BdMP8Naps+iqmvJRIKRWBhFHc+gYwyYximBxJQhiCmruQi9YUkzaRt1MNTzEFXdN2I6j0XwnJFkpiVLJG5sfYVi66mfQ4uvjtKp6/7Ry4+MiS7kVC1Se467f7W30WD2C+eNqJ03e0rqVtjmgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=xPv8aaI9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="xPv8aaI9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso17668255e9.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790203339; x=1790808139; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/MSFXEUGzGSgqDfYv63QRmXAWeyAGViAhpSz6ju5KtM=;
        b=xPv8aaI9Bko8IZZSfojUmU+0YDvN1p1Yt8JdgPccfa2vFDnvC2KTBBPUJfZUAsaxgw
         n2Rez327Rm+4GtrQLyG6SosWJcy5NxXX398Dzbl/i/yEH09lvwSvDsWKzcKUuKeMJ+OC
         ocO1JEtl80qgPGoUwyHeyAOo07jnq8yEHIZPV09i7t6ZTBQkqCFfn4s7nnUEmT6LG0Fr
         ewi1JHFYxzmd5IgZ/ANUrnGPNQVdPYLhlk8cjEQCYDiQ3AaaIrMAHE25MDtSOov3KxoF
         NQiaPKD4GzG3cjgTmga1Hd4ZCQhtz6bm90idgqCMILZz+xGOEU3lyc0y+8HN9mIUSGWQ
         ACyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790203339; x=1790808139;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MSFXEUGzGSgqDfYv63QRmXAWeyAGViAhpSz6ju5KtM=;
        b=pKdWAVbHxybFEYvqC4ttaSrHRmK16zJnOvywAWiNm0bCvMKju64zYTLYrvNFIaoMDo
         0GSLUj7B9b7jT4gFI60Xq5WTkOcGKv3nUmeorSyNUJNV/xxvkhJdz4wKjwO04dxVyCU2
         nRYaA+A/lTKEVSNaOSxTcDrCR+rKKkvUY8e0Ggqn4T7F/RjaxRlk9jNsSvGOmYBxbdZP
         Kj9CNo4oY8Zoismc2vaFYl4xNyQ3NNgX6PIzNhFgyo7z5+cwZxakfZk8xQ6CRi7rplcS
         kWVCHl9LrxwLueBYzBkwkwsg1Fjr+aP4HLecUVsp4iZIahadO2e5BkUCzFXkwVoBG4mc
         W1CQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgeix7EApEzpN3WWZxAkFlZZvVqWuw/g8XNh9XiSVFZ9mCi9/TOlFv5Xih5HsGR3BoZTsJxLk=@vger.kernel.org
X-Gm-Message-State: AFuF++kJDhKPNaaycQKWRvxXKCPYUaaCHXy+L+DrS8xSL8Nx7T6HjHYR
	soMA5q59bFowwN4TUwlGHb7hyfxd/jlwy0qNuTPqJFJcvVbDyj4Y31s5heh7mG3Ybn8=
X-Gm-Gg: AYBFou058yMsSYImG0zBPVde9nwjYQ76Uwr+2cuJOQWeD6ST3XK3MOqv5wNMo7KAP4N
	bX/Nc6Vgd9AOwWZL0F8xJAwTqg2EXlid7scDe5s8sIruzneyhlxmvFT7mVnXsTyTqb8ikN33VOj
	wYxw0BOygjBtaCrb5HcWn5TX/RoNCM0Yr95OvXq2gto4nQsRyHMzyq4BO7mB7DgSD3M/nyWrSlC
	qg+V/rvmI9dtHZ6Zz8nYq8jEXNqoYm2YSH6ngcmRBgqt6/fO9laugtvvvEpW8kHoU7C6aaqOeus
	cXcJBku+giPjx2qA41Rurzd2ckBrcwE9yyCEygjdWpakZT7kGj29ac60/nWVCPeWid8L6z86Tmh
	hgwCu7oVSJfYSgdlc6egMBqaTuOWEeSPswW0HpF896qO6QFxRp9mhevr6AHM+ockI5kqrGtUF51
	7eNGZxBwult3ZefuKZVQ7boo4blRNLltaaPEonb51YbpmWlowFpbcEoPA=
X-Received: by 2002:a05:600c:138f:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49fe66d2700mr9496345e9.8.1790203338580;
        Wed, 23 Sep 2026 15:42:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:5e5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dff204sm27425415e9.14.2026.09.23.15.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:42:11 +0000
Message-Id: <DLN248ZSNGXU.1ZF8YH5Q1A4XE@etsalapatis.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eric
 Dumazet" <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Tenzin Ukyab"
 <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-4-kuniyu@google.com>
In-Reply-To: <20260923213719.224838-4-kuniyu@google.com>

On Wed Sep 23, 2026 at 9:35 PM UTC, Kuniyuki Iwashima wrote:
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
>   int flags =3D BPF_SOCK_OPS_RCVQ_CB_FLAG;
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
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/net/tcp.h              | 18 ++++++++++++++++++
>  include/uapi/linux/bpf.h       | 11 ++++++++++-
>  net/ipv4/bpf_tcp_ops.c         | 10 ++++++++++
>  net/ipv4/tcp.c                 |  2 ++
>  net/ipv4/tcp_fastopen.c        |  2 ++
>  net/ipv4/tcp_input.c           |  4 ++++
>  tools/include/uapi/linux/bpf.h | 11 ++++++++++-
>  7 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d61ee00052e3..f2d838bcb0a7 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3053,6 +3053,12 @@ struct bpf_tcp_ops {
>  			      struct request_sock *req, struct sk_buff *syn_skb,
>  			      enum tcp_synack_type synack_type,
>  			      u32 opt_off);
> +
> +	/* Called when an incoming skb is enqueued to sk->sk_receive_queue. */
> +	void (*enqueue_rcvq)(struct sock *sk, struct sk_buff *skb);
> +
> +	/* Called after data is dequeued from sk->sk_receive_queue. */
> +	void (*dequeue_rcvq)(struct sock *sk);
>  };
> =20
>  #define bpf_tcp_ops_call(op, sk, ...)					\
> @@ -3144,6 +3150,18 @@ static inline void tcp_bpf_rtt(struct sock *sk, lo=
ng mrtt, u32 srtt)
>  	bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
>  }
> =20
> +static inline void bpf_tcp_ops_enqueue_rcvq(struct sock *sk, struct sk_b=
uff *skb)
> +{
> +	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG))
> +		bpf_tcp_ops_call(enqueue_rcvq, sk, skb);
> +}
> +
> +static inline void bpf_tcp_ops_dequeue_rcvq(struct sock *sk)
> +{
> +	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG))
> +		bpf_tcp_ops_call(dequeue_rcvq, sk);
> +}
> +
>  #if IS_ENABLED(CONFIG_SMC)
>  extern struct static_key_false tcp_have_smc;
>  #endif
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6330b7d745c5..fe122242b096 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7148,8 +7148,17 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> +	/* Call bpf when the TCP stack enqueues/dequeues payload
> +	 * to/from sk->sk_receive_queue.
> +	 *
> +	 * Only bpf_tcp_ops is supported.
> +	 *
> +	 * It can be used to adjust sk->sk_rcvlowat and suppress
> +	 * unnecessary wakeups before sufficient data is available.
> +	 */
> +	BPF_SOCK_OPS_RCVQ_CB_FLAG =3D (1<<7),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
>  };
> =20
>  enum {
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 1ada3b781bf1..c963e2cc21b5 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -76,6 +76,14 @@ static void write_hdr_opt_stub(struct sock *sk, struct=
 sk_buff *skb,
>  {
>  }
> =20
> +static void enqueue_rcvq_stub(struct sock *sk, struct sk_buff *skb)
> +{
> +}
> +
> +static void dequeue_rcvq_stub(struct sock *sk)
> +{
> +}
> +
>  static struct bpf_tcp_ops __bpf_tcp_ops =3D {
>  	.timeout_init =3D timeout_init_stub,
>  	.rwnd_init =3D rwnd_init_stub,
> @@ -90,6 +98,8 @@ static struct bpf_tcp_ops __bpf_tcp_ops =3D {
>  	.parse_hdr =3D parse_hdr_stub,
>  	.hdr_opt_len =3D hdr_opt_len_stub,
>  	.write_hdr_opt =3D write_hdr_opt_stub,
> +	.enqueue_rcvq =3D enqueue_rcvq_stub,
> +	.dequeue_rcvq =3D dequeue_rcvq_stub,
>  };
> =20
>  BPF_CALL_4(bpf_tcp_ops_store_hdr_opt, void *, ctx, const void *, from,
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index a4456b419412..a714b36a7494 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1610,6 +1610,8 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
>  	     "cleanup rbuf bug: copied %X seq %X rcvnxt %X\n",
>  	     tp->copied_seq, TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt);
>  	__tcp_cleanup_rbuf(sk, copied);
> +
> +	bpf_tcp_ops_dequeue_rcvq(sk);
>  }
> =20
>  static void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 471c78be5513..4939bcbc81d1 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_=
buff *skb)
>  	TCP_SKB_CB(skb)->seq++;
>  	TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_SYN;
> =20
> +	bpf_tcp_ops_enqueue_rcvq(sk, skb);
> +
>  	tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
>  	tcp_add_receive_queue(sk, skb);
>  	tp->syn_data_acked =3D 1;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 6ac6f9d5b6c3..c60c61bb0a71 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5344,6 +5344,8 @@ static void tcp_ofo_queue(struct sock *sk)
>  			continue;
>  		}
> =20
> +		bpf_tcp_ops_enqueue_rcvq(sk, skb);
> +
>  		tail =3D skb_peek_tail(&sk->sk_receive_queue);
>  		eaten =3D tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
>  		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
> @@ -5547,6 +5549,8 @@ static int __must_check tcp_queue_rcv(struct sock *=
sk, struct sk_buff *skb,
>  	int eaten;
>  	struct sk_buff *tail =3D skb_peek_tail(&sk->sk_receive_queue);
> =20
> +	bpf_tcp_ops_enqueue_rcvq(sk, skb);
> +
>  	eaten =3D (tail &&
>  		 tcp_try_coalesce(sk, tail,
>  				  skb, fragstolen)) ? 1 : 0;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 6330b7d745c5..fe122242b096 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7148,8 +7148,17 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> +	/* Call bpf when the TCP stack enqueues/dequeues payload
> +	 * to/from sk->sk_receive_queue.
> +	 *
> +	 * Only bpf_tcp_ops is supported.
> +	 *
> +	 * It can be used to adjust sk->sk_rcvlowat and suppress
> +	 * unnecessary wakeups before sufficient data is available.
> +	 */
> +	BPF_SOCK_OPS_RCVQ_CB_FLAG =3D (1<<7),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
>  };
> =20
>  enum {

