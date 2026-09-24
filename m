Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38933DCDBF
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221179; cv=none; b=THPo+Kd9KoFnQmGdTG0RLDX6+KkEuKpeBU9DcZTksGnpZXvYaq0QTDKN2DpM0FqsfcFmcllW1FMZ6udJ/EGzwYDTH/iSHwjnqLD42qsgHKSmOHfjj2hKfZTE+1QHH6UFf2LioXzhh+gCljWD+fdetXJ8pNhVN3VuVjcFu5xS7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221179; c=relaxed/simple;
	bh=yuq7g0dxHd150MxA8vQc1TM8rfNlDh2xY1atlDlNASM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=I1GJ7+sR7obyn01PvRhqsi8rgsZympkZhjssI4hr7xT4E0uRASaLGHvVPNw789+XMedqTQoyi16MKBBSecs7ZCIyHdwmcagV1HQNmfQ+dxjcWTUNI8sftohJ+GqWAVuwo4BO1D9Bk2zQZKVLMD8ySeL/kf0Zc2UcCjX/RlPdm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GYJXfO2x; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GYJXfO2x"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso253112a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790221176; x=1790825976; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U/uwPpV7MZfyBBinyMNYaUN+l0z1JQ46iqC0RQnG5DY=;
        b=GYJXfO2xjF+pt7roOIwAaWA/NpFDoHOozKbR3GLe7CTZ3e8P7FoVuggyG+zBXTwLWd
         jeJXJLv0n0uUzhOOd7aTJ7dRbBXn58/qTVnNq03PI84wlOfHdURU0mdnCNH1bjwA2duw
         iGX1iNoXHZjYqHHdp4Lt+7YwH7Vbj2e7abVA3+CiGQZrGB1o7Mk7JRRBR6J00karV8bw
         d4H717n2z0YHPw6nyXm50TxsjiSPwKsiq8BAMVHNSvEDhItuuUBO3KsdQHkbhZKsX9Hf
         l8oMiMnjsX8Sd/e8bhGKEd51lRstSohDe8yyGR9749KNJ+R6eITfPQo6DsieAg6WYdDB
         Z1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790221176; x=1790825976;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/uwPpV7MZfyBBinyMNYaUN+l0z1JQ46iqC0RQnG5DY=;
        b=Ue2O2Jxp2d3Ud7fTVQE96TdZ/HUdoESVtQ3g4w2DLhH402hWY5N9BjwXFLIJ8lxPfu
         QvTLALHSGLgTX3RvczGnjNbZz6SHDHd86kftVjVFvOZdgZwSI/cN8T2vzraAyx8TLxvX
         4kWZmwyaX89OrRjwoyj+2srSaoVZEOZM91AaZNKb0Q4xLgkWbF34p/bQ7KIveY9jJyXG
         uL/Jy4woCrpGaXaAlpBG8qSJXkd32hL461YKZsZiX5x2glGLzDJRgByHDeF0N170VKIy
         POGFV5jDymEjvL0tuYspPR9CXmIAVFdUMQKdhA26tFYoeGvxUsCZxASx0oBpLNzmwBlx
         FQPw==
X-Forwarded-Encrypted: i=1; AKwUvBwDaS92dEcXQhVllsNKEa1FWp8LtHNVd9Bw+6ZjFQLyTMZwQwE8Dh3ca0CR2OTZSfTiIF7kZo0=@vger.kernel.org
X-Gm-Message-State: AFuF++mrqFZDDWClU9YBmIO3Zi9xhOj800EQcRUARDFdZ3wMAlHgno+1
	R5DB01Ah085EPMq/hd32ufOxLhcpazL+shWNRYCV+oSrZ0k778WYcjxeFqVSGnRiEJn2Xk5yi9I
	lCIclXnHeMQ==
X-Gm-Gg: AYBFou30ARvtXZajgAu9MfZcbOgkYlslXCzo5UtjJUZDTV4vbZgVDgmBZY2hHWh55Tr
	wrTFsVh7dCrklAPdILBBNVqE/Lm1LKpa/vTIRfelARHJQG88Q+KmHYADmdoMt5uxisfBMLSqMrE
	3/K/q91HJFgnjpERpTqmbiET6PSiU7d7fKo9b/5MgZDuwMKzzSVtjJ8CN44FdwilQxTRZ0zt0wc
	KgUZHgOz9CIPhSijKpP+Rg0R/u4I/5759KIrmBSd9dGqzeZrK4yF9roH2iOv3G8k3yNuVrbfiFG
	3aG1ZhB/0Y6P6K4JvxnHdZwCFpZNb6e9rJ7Wr2ktuueLJeR7LUBobjX1tS99vZZyG23JIOMFg4P
	nbZ4yGMlJBuRoZIMmPexb0RYjJaYZGNj2eQB1rWlygUspU5Ipv6JyPhc3cY73lPuDBCjDA9L4Fx
	DaUd5Y9iR/VFdGM1i+N+qRjdSXjOsJXj8k851GscqMVt3Rca97UUnNSUvzkus4rpy5xOMlaXxEt
	NmVDGsdne0omcNu+KryKouybeRpLqii+A==
X-Received: by 2002:a05:6a20:a114:b0:3db:b3b:5343 with SMTP id adf61e73a8af0-3de0e7626a7mr775844637.12.1790221175707;
        Wed, 23 Sep 2026 20:39:35 -0700 (PDT)
Received: from localhost (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3f0915sm1904582a12.21.2026.09.23.20.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 20:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 03:39:33 +0000
Message-Id: <DLN8FXOO956F.3KNUHU1IEBHCN@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eric
 Dumazet" <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Tenzin Ukyab"
 <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 5/8] tcp: Split out __tcp_set_rcvlowat().
X-Mailer: aerc 0.21.0
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-6-kuniyu@google.com>
In-Reply-To: <20260923213719.224838-6-kuniyu@google.com>

On Wed Sep 23, 2026 at 9:35 PM UTC, Kuniyuki Iwashima wrote:
> We will add a kfunc for bpf_tcp_ops.{enqueue,dequeue}_rcvq()
> to adjust sk->sk_rcvlowat.
>
> These hooks are triggered
>
>   * when the TCP stack enqueues an skb to sk->sk_receive_queue
>   * after data is dequeued from sk->sk_receive_queue
>
> In the enqueue path, tcp_data_ready() is always called after
> the hooks in tcp_queue_rcv() and tcp_ofo_queue().
>
> If tcp_set_rcvlowat() were used as is, tcp_data_ready() could
> be called twice for the same skb, which is redundant and also
> confusing.
>
> Let's split out __tcp_set_rcvlowat() and add a flag to control
> wakeup behaviour.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/net/tcp.h |  1 +
>  net/ipv4/tcp.c    | 12 +++++++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index f2d838bcb0a7..07426e8641b7 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -512,6 +512,7 @@ void tcp_set_keepalive(struct sock *sk, int val);
>  void tcp_syn_ack_timeout(const struct request_sock *req);
>  int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		int flags);
> +int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup);
>  int tcp_set_rcvlowat(struct sock *sk, int val);
>  void tcp_set_rcvbuf(struct sock *sk, int val);
>  int tcp_set_window_clamp(struct sock *sk, int val);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index a714b36a7494..aa7593fc8334 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1828,8 +1828,7 @@ int tcp_peek_len(struct socket *sock)
>  	return tcp_inq(sock->sk);
>  }
> =20
> -/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
> -int tcp_set_rcvlowat(struct sock *sk, int val)
> +int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup)
>  {
>  	struct tcp_sock *tp =3D tcp_sk(sk);
>  	int space, cap;
> @@ -1842,7 +1841,8 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>  	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
> =20
>  	/* Check if we need to signal EPOLLIN right now */
> -	tcp_data_ready(sk);
> +	if (wakeup)
> +		tcp_data_ready(sk);
> =20
>  	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
>  		return 0;
> @@ -1857,6 +1857,12 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>  	return 0;
>  }
> =20
> +/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
> +int tcp_set_rcvlowat(struct sock *sk, int val)
> +{
> +	return __tcp_set_rcvlowat(sk, val, true);
> +}
> +
>  void tcp_set_rcvbuf(struct sock *sk, int val)
>  {
>  	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));

