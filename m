Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663639;
	b=l7jkT3W2HFs7DSfUmDwhw8WWQvk6BASHOG7NorB93UKFW0PB1CSRxjVMgIoN3Gj4NI+6
	 J426uEB2WBqVXOj2Q4VdNUNf5eCvigV2oF772O+iscAe0hBMN7xohdXthZVr++D6UYJor
	 /8NKBR8KDuH16S4M6egLGiu8ticYFsNDTArxPAVB0UvDbzjnKRQ59iEup6CVyFEdnc5Pp
	 7I+or3shEqaHuAytfL4sb3o8+blLluTVKntKqQoRtmVw61XIpfRTVcD1ZdTzt310tNBPM
	 hAUYb2ViiwV6DdVBCW+pJbxRVSaY5sSMsAqpFEKFsbpZ/SLZ2ZtWzCrRWIecpTIa7ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663639;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ll4SV3bdtwckm24BNpifgTpXaQLWXCqLJuIxLlH5XTc=;
	b=wEQToudJlkv1KFnOJh+ikQJosuzthfiXLdqzLzdTqUlHulk5yhJp00ImKkEvPvQ0Mb4k
	 n+OZOKO+xTlZ9foq/yxaTuIlQScAt859R57B9rlkVVaEwUVZgIXtBRy1L+gfnJkIRz942
	 ddb0AwDvkpQ5NH3XSB7ohntCq/OAN+7dFq1R6t+2tee33n8r/9EYZ4tCk2PYJymbvZry9
	 VDI4uCacPYj3T6pd6taBucFVmeaLn3BaYHIsNjExffwDyspVO7ZJPB7cYulNhVH4/JZdc
	 BQOIX4494JCdmISvAzsrgyEBaJjoEaHQGcQXBDPQYBmOm66ABMlR56bJjgSEgVD4ijg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UiVFB9BP;
	arc=none smtp.remote-ip=95.215.58.52
Received: from mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF02606A323
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF02606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UiVFB9BP
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cUVZFAauvYfdrMN84AtZG9D1SbyolDZQ3ZjIcFK8qXg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792663636; v=1; x=1793268436;
 b=UiVFB9BPDPcE4Dx3uDCvucjTrKhPfvN6NXrH/lVzcQ0i5Sl82+NlJyzQNtsaDE+FfrWv33zH
 mbF73QAU1rMPGi4hvqfzoCE1BI1tgcS9f9e2i6o7dc4zzhkogSEgn6IVc09V+4j3u9xUUeaBNL7
 RcfMZwPrqxgxhnfISVVY3k+4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8363c2b801802ffb;
	Thu, 22 Oct 2026 10:07:15 +0000
X-Mizu-Trace-ID: 8363c2b801802ffb
X-Migadu-Flow: FLOW_OUT
Message-ID: <677e01d0-6226-4670-a4d5-8900f8a88cde@linux.dev>
Date: Thu, 22 Oct 2026 18:07:04 +0800
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
Subject: Re: [PATCH] bpf, sockmap: Propagate sk_msg_memcopy_from_iter error
 code
To: Rui Qi <qirui.001@bytedance.com>, netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Levi Zim <rsworktech@outlook.com>,
 "open list:BPF [L7 FRAMEWORK] (sockmap)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261022095853.1829161-1-qirui.001@bytedance.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261022095853.1829161-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/22/26 5:58 PM, Rui Qi wrote:
> tcp_bpf_sendmsg() stores the return value of sk_msg_memcopy_from_iter()
> in a local variable "ret" and jumps to out_err on failure, but never
> copies that value into "err".  The "err" variable therefore keeps
> whatever it held before the copy: 0 on the normal allocation path, or
> the stale -ENOSPC left behind by a partial sk_msg_alloc().
>
> On the first loop iteration "copied" is still 0, so the function
> returns "copied > 0 ? copied : err" -- 0 on the normal path and the
> stale -ENOSPC on the partial-allocation path -- instead of the real
> error such as -EFAULT.  A blocking sendmsg() handed data but returning
> 0 with no errno can drive userspace into a busy retry loop or be taken
> for a successful short write, and the wrong errno misleads recovery on
> the other path.
>
> Propagate the memcopy failure so the real errno reaches userspace,
> consistent with every other out_err path in the function.
>
> Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> ---
>   net/ipv4/tcp_bpf.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 97541acb3cce..8cf63a9e7fed 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -578,6 +578,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>   					       copy);
>   		if (ret < 0) {
>   			sk_msg_trim(sk, msg_tx, osize);
> +			err = ret;
>   			goto out_err;
>   		}
>   


Thanks for your report but it has been fixed.

https://lore.kernel.org/netdev/20261019082214.102398-1-dmantipov@yandex.ru/


pw-bot: cr



