Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609157;
	b=ZfxF9qrjTmX/cDGyBzIRoDZwrFhf1w8EeqjfiCsRYYNQyw0ACWb4uToDieWeS1nWO+LI
	 ToINtXfxDTXziROc/wmJ2hpVsXOr+u6tI6kYceKzHQZqcbjVeXdNSJeU5UTRrnYti4Zof
	 lVn6Ff98ozv2UQNpkCzYHddoJCpRJ8ZKoRaUemO6hoB1HQJu1Huzq77Aj74qCOHrkVlz5
	 eChC7MRpuasBe7m2E1RabU87eWoiPLNlgUNgXs07OQDm2wYnCNJUHU/9hzsJXbbFctfMb
	 gUns1z5V8DL1Y6PWynZkWLQ/7hjNbIST+EjI3OSA4dTK+M91TLJB5q9F65kQEvk5Tew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609157;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jx4qlQkPxS7DAszsO8FykZUqEui3HDCIXlBMJeUNy0Y=;
	b=J2rmxOHmlsuNYzHXBoS38hdB3W2Dbe+yv+3vX5gMUaCmtpOTC/t3BXBUYrZkPC/Q7xiT
	 xAVnz4WiWP6OJnHoR4uaYWEc9QnEJL5i8zZ0eiKuYsdmbo8u/n44h5OUjQ2nalhwUcp/s
	 SQ2JoJ+lVBvbI+zvxqqRG5tvrlAfjV9sNzM2j2YhFn7dsL4OPNuNsrUenGvOIVqWkWt6r
	 1bw1yQdlGtx0XLUSn4X0xydSvP73TYJBymP946l1cWePuUd+8SyF/5nCyX4C5fgckzlXJ
	 lPB2JoKx65ZV5xXJNy/h/9LyvYKcUs/bEJUMBpJz1DV1CRshFB0KUjFVnCfGQWOS12g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.215
Received: from mta1.migadu.com (out-215.mta1.migadu.com [95.215.58.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385F606A32F
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D385F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xxE5inaPrVu+F+7VswAWI/5YBh6Q8RuY05CNRqyPUa4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793609154; v=1; x=1794213954;
 b=cjHN8xeysAL5ALPxZMu2qazghWYfyhOK3oO2LxRICrgbvHbJaHbAmgL4XyWaCJGsdL+Tp2vw
 NPjjSBXOjlHy6J1rzNqwgbVnEmiwkGBgcI84XPFJTyIe+e5rRR/mXCJtGOFo3arFF94Fw1JW969
 1LAoqiHbd/H4CLbp7oH8zysY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2b7e906160719b9f;
	Mon, 02 Nov 2026 08:45:53 +0000
X-Mizu-Trace-ID: 2b7e906160719b9f
X-Migadu-Flow: FLOW_OUT
Message-ID: <bc3366e4-3429-4826-b04b-ca1ff20b9686@linux.dev>
Date: Mon, 2 Nov 2026 16:45:44 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 02/15] bpf, sockmap: Don't let an SK_DROP verdict
 stick
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:20 PM, Alexei Starovoitov wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> The verdict of an sk_msg prog is valid for one message, or for the bytes
> that bpf_msg_apply_bytes() requests. These bytes can come from many
> sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
> psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
> that resets psock->eval is after the switch statement, but the __SK_DROP
> branch returns before that code. Then sendmsg() drops all subsequent
> messages with -EACCES and does not run the prog.
>
> Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/ipv4/tcp_bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8cf63a9e7fed..d90bcc911b36 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  	default:
>  		sk_msg_free(sk, msg);
>  		sk_msg_apply_bytes(psock, tosend);
> +		/* The verdict holds for apply_bytes, not for ever */
> +		if (!psock->apply_bytes)
> +			psock->eval = __SK_NONE;
>  		*copied -= (tosend + delta);
>  		return -EACCES;
>  	}
