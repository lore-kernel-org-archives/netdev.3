Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624073;
	b=cQQZXSPeuk7tBBc7X2R0MbL8lhcIIZuIIcqUjLALzjBqN+FpjUbY8zcFGVfIrjs7YtTP
	 9eGKDNRVAAt9fBjHnri9baV5M6mmPPV9QnI95JVjVl3ykopIDiiyrmEsWzgXis9H++Pt8
	 yaKVwmjBlKb0IXv2y2MYFTDwjcPycITpEef0USU3E5VLeKDSKAiFDBJ4rxPITuXhDmbKO
	 cdYn/Khql4ffEsZxBaxF2U0pWD0uQZuIoAVzaS8uWBPUL9R/is9gEET5vnsaL0T39dIoy
	 ZxI7Z+sHb1STKPdZEp0YeC4m+KUajygQ3+S6gALrwBtds9/QbbDyq0OsxJ1fe1Cx3Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624073;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=T1YaZ5CVMpRh5cBJyHT2XXxbUm0f+Lg1DdVX03Xf44w=;
	b=nDx/UNrQNQap9kvjU9NhHIh+NtZSu6hKgL5/iyPS4NH/JR0iORDkLA05rHA3IVkO9l5r
	 f0CIFG6FhxTuttl5+WVM1zFRdX2sVFwzbWp2PZZJVwXyM5DQYAatfL/H9WeZ1IuRUCRMQ
	 2/eTZqSAfuJtuHJQ1nt/bxWrcEOFoDngMWx+U1NYl3PrxQuD0ED/1Z/4np7SdE9vVMv5N
	 7d8l3MOEFUxDQsPCkOJXnBWU+TBKkppZjweeojeKOnuq8L/+hGs2/XOVjmIHd3GIckIgB
	 0+9OubO/fwHuvYA0DeqII9AZp/5cAC60kjPvtxuy9YpV6oe4KHEcX0GaBc/O47qrVAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="CBoNTm/0";
	arc=none smtp.remote-ip=91.218.175.103
Received: from mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC14606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC14606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CBoNTm/0
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f8NRbaKzFnIAovB9R1DkWIJvuMxfGpSyRGnC9JEfYgA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793624069; v=1; x=1794228869;
 b=CBoNTm/0wYY66KVTGoqmZEpP+CTkY4BxVtiIhtgXQVmBFuRHyyupdrgR6r+BvDDOtRzq1nff
 vIBLw3x71ZY8x8fhag4zHDEZM9C60Jr+fhgE6A/pN9Rv5hrEyCN2H2gUzRHjRkmLzU2ZKuxMFQU
 9e8Yf2Q9Ik+cBqOR7Z12mTEE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d66616fbbe63938d;
	Mon, 02 Nov 2026 12:54:29 +0000
X-Mizu-Trace-ID: d66616fbbe63938d
X-Migadu-Flow: FLOW_OUT
Message-ID: <40d46734-8195-421f-b14c-b4b07adf3380@linux.dev>
Date: Mon, 2 Nov 2026 20:54:21 +0800
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
Subject: Re: [PATCH bpf v2 08/15] net: Leave sk_stream_wait_memory() once the
 socket is dead
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-9-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-9-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> When an sk_msg prog redirects data to the egress of another socket, the
> sender calls tcp_sendmsg_locked() on that socket. The sender holds a
> reference to the sock, but not to its file. Thus __tcp_close() can call
> sock_orphan() while the sender sleeps in sk_stream_wait_memory().
> sock_orphan() sets SOCK_DEAD and sets sk_wq to NULL.
>
> After the sleep the loop continues and does not test SOCK_DEAD. The
> subsequent sk_set_bit() can dereference the NULL sk_wq. The tests of sk_err
> and sk_shutdown do not always stop the sender. sock_error() clears sk_err,
> and __tcp_close() can call tcp_disconnect(), which clears sk_shutdown. The
> sender then adds data to the write queue of the dead socket, and
> inet_sock_destruct() warns.
>
> Leave the loop with -EPIPE when the socket is dead after the sleep. The
> function already tests SOCK_DEAD before remove_wait_queue() for the same
> reason. A caller that has the socket open never sees SOCK_DEAD.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/core/stream.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/stream.c b/net/core/stream.c
> index cb255e2a3a5d..334124d683a7 100644
> --- a/net/core/stream.c
> +++ b/net/core/stream.c
> @@ -150,7 +150,11 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
>  				    (sk_stream_memory_free(sk) && !vm_wait),
>  				    &wait);
>  		sk->sk_write_pending--;
> -		if (ret < 0)
> +		/*
> +		 * A sender which sockmap has redirected to sk does not keep it
> +		 * open. A dead socket has no sk_wq.
> +		 */
> +		if (ret < 0 || sock_flag(sk, SOCK_DEAD))
>  			goto do_error;
>  
>  		if (vm_wait) {
