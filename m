Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632519;
	b=E9ldB+UvG8mpDVDlhDwt0g2oP4ncH3TriQtRafNY99cIa4yT9bRF5U5lFzGu46eoenxU
	 eFVQIN1WIPZGMa95SpakpSfMzE7Xfrjk7qQSeRmS2tdg3OTspUG1XyzY7Vf580cBN9Yvx
	 6BuV/CLNa2fMvO58KxWDedd272XQNgav9E1bZ7gfO0LKRPI+gGAlI93+4bhW4EdW+CxXN
	 S1zeJWCmGYgXyEDyIFjbnxI9N5W5HfyiszAXsyYXmBdw0aCl2D/fi6B6IKyJI/8ltKpdG
	 M75i1Uv9yDva4CFVzkF+XOERkHX0xl6bMiA/X+jMZ3HbovaoFEKyd+iRD23lf8hTAxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632519;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kwKzSEXHVuEjJqvTeRRPA4mrqN9EE7qy4XgSv3TiNWc=;
	b=V2RyOd2i1kLNcztaHrjwW/Py7rNrRpDmIkdZ/YA5+8hPWoMJdIOA4xy1qbfe09kth/vq
	 6QVEhPlkfcMEn76Q+T5399Ukma8vRW9N0LtXdoHTNz4AJRw+3Yc003HUzUay9DOGjfZ4z
	 Bp8LZhQfmjwUmKpok5qNDpnrnBf+LSI7FmmMdlZN0aTnD8OveTlnjr30AuL7DjrZ71QTI
	 GCyFVVtheNgpI+62k/GpNHQCxuq/KPsUxzzYGoFbvcGVweFMmvV7HEKjwkiW5Y6RZdwXi
	 AweaVEGQnvX1AR0J8d4ei+Gnlas/OiRuueO4Hrn9Z/enUMtD8SseiwULkIfh4LZ3jJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lXGnMHan;
	arc=none smtp.remote-ip=91.218.175.233
Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3F607A896
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF3F607A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lXGnMHan
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mD1ETE2e7HukgmRWNL4DzC5n+RUd7grBANDiKh/A4zE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793632515; v=1; x=1794237315;
 b=lXGnMHanafhZqGg5hSi5b0aHqHNEOt+95p8arodvEZyTN6I2DAeOz2rSfSbSa6SPX4rdFcJM
 v+2b+brBN2z05VkWQn/evpTSMbcUbxEPoBCEFhLdC53ue8MiUln9BObndAF0uXXQV2kQgbluKiW
 V8q3BX5VhBkSM0WWuKltgTBc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c5af6c99b6d8b8d8;
	Mon, 02 Nov 2026 15:15:14 +0000
X-Mizu-Trace-ID: c5af6c99b6d8b8d8
X-Migadu-Flow: FLOW_OUT
Message-ID: <ae49619c-d2de-4189-b6ac-2a70f8ef1891@linux.dev>
Date: Mon, 2 Nov 2026 23:15:03 +0800
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
Subject: Re: [PATCH bpf v2 09/15] bpf, sockmap: Check the TCP state in
 recvmsg()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-10-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> With an sk_skb verdict prog, tcp_bpf_recvmsg_parser() copies data from the
> psock. Then it calls __tcp_cleanup_rbuf() to calculate the receive window
> and to send an ACK. The window and the ACK need a connection on the socket.
> But tcp_disconnect() keeps the socket in the sockmap and the data on the
> psock. For a TCP socket sock_map_redirect_allowed() rejects only
> TCP_LISTEN. Thus the psock can also get data after tcp_disconnect().
>
> __tcp_select_window() divides by icsk_ack.rcv_mss, which can be 0 in
> TCP_CLOSE. In TCP_SYN_SENT the new peer can get an ACK with the sequence
> numbers of the old connection.
>
> Call __tcp_cleanup_rbuf() only when tcp_can_send_ack() returns true.
> recvmsg() returns the data as before. Move tcp_can_send_ack() from MPTCP to
> tcp.h. It also returns false for a fastopen child in TCP_SYN_RECV. From its
> peer the child has only the SYN data, and the SYN-ACK acknowledges it.
>
> Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  include/net/tcp.h    | 6 ++++++
>  net/ipv4/tcp_bpf.c   | 3 ++-
>  net/mptcp/protocol.c | 6 ------
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 3560adddf821..23a22d70718e 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1845,6 +1845,12 @@ static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
>  void tcp_cleanup_rbuf(struct sock *sk, int copied);
>  void __tcp_cleanup_rbuf(struct sock *sk, int copied);
>  
> +/* Is the socket in a state in which TCP may send an ACK? */
> +static inline bool tcp_can_send_ack(const struct sock *sk)
> +{
> +	return !((1 << inet_sk_state_load(sk)) &
> +	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
> +}
>  
>  /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
>   * If 87.5 % (7/8) of the space has been consumed, we want to override
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index ef2e15de0fe3..3d703f1517d8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -343,7 +343,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  	if (!peek)
>  		WRITE_ONCE(tcp->copied_seq, seq);
>  	tcp_rcv_space_adjust(sk);
> -	if (copied > 0)
> +	/* Data on the psock outlives the connection that it came in on */
> +	if (copied > 0 && tcp_can_send_ack(sk))
>  		__tcp_cleanup_rbuf(sk, copied);
>  
>  unlock:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7a22e9388e0e..d62cfbf2d490 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -619,12 +619,6 @@ static void mptcp_set_timeout(struct sock *sk)
>  	__mptcp_set_timeout(sk, tout);
>  }
>  
> -static inline bool tcp_can_send_ack(const struct sock *ssk)
> -{
> -	return !((1 << inet_sk_state_load(ssk)) &
> -	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
> -}
> -
>  void __mptcp_subflow_send_ack(struct sock *ssk)
>  {
>  	if (tcp_can_send_ack(ssk))
