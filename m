Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962672;
	b=t5SW99mTatDt+DDl7rwr8D1LoduToPo3ovo/7wXUSYDUW16nbL/y3JHgUSyvKobMmYj7
	 SEgBcCoavgkUqEAWXkmRir3JOQ0sAnFABakA1N71VCu/hWg0EoPAH0F38Q59rM3nxCqEA
	 S1ylh0kO67JJIMmIHu/Q2SXkXOLMFzU19A6BK/Uf93H9vPpbS8og/lnJwXvpqzs8BKpZF
	 Ryv0zvAfgVfb8Cvk928HZDcoXEg6GXpvw7SIj0zcJCBkkrmDCbM3vAjWvs2N/yEm8StW6
	 Dw7VDC+tPGScQPpAkh2tysOBOZDsHRpWfuRjP6OaDoi/9kietTch44LyIv7gGOVM4ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962672;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2Qb7doj3jSPWBLU/4mvRuxqnjI74VDd6ce9CLt6laJU=;
	b=XOPO/0GceFFQJmAjsNBhFncoz9HQbqZHuGPMYMs/Su5YYSbJ8Tw10xrlzqfiVVqS1cNw
	 hi7MZ9MFEKNsqLXDW2G9JPRf5834H/R8QI8aic4kjYOtWhf9x1HcERuhPpOA9l17V6O/S
	 9nV83PDwBn1/e3AnuuKXSoZcO56J4WMfVtVy5YeWu/TJNXW+8DGdc+Ozxkgdko2YSPoxY
	 b9Ht/HnYJlNL6K/rLpFGjO29AV7PK4LZ19/mcuykiW4QmlB7XmqrHnFl7drfZoqzJfi68
	 rSAJu4H0siYDutb5JdUuUz+spAudvh9yubybJTr0lHJNplHwu+QSWq6HNlwYYryj0KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eAsEq777;
	arc=none smtp.remote-ip=91.218.175.72
Received: from mta0.migadu.com (out-72.mta0.migadu.com [91.218.175.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D2606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E99D2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eAsEq777
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hcKiv+VQ6SQIjm4bK4mM44F59qrORo+P3Ka3o1CEFhg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793962670; v=1; x=1794567470;
 b=eAsEq777mc9QZCo4W3dsDlArzMoo/ys+k2DpYDPvBGp4l7qAJ2mxATpnYOp4XxBvUWmjKQMo
 SBezp/2U2ruZCku7pxDHLPw2Bz5b0XYA0wmRJdE25ksxhxEI1NE+36vVKJ2TW7Gq0qjuM6++YBk
 7iPN7Q8DVSpNcdWSQM5iNkeQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 82ad70a2456c4347;
	Fri, 06 Nov 2026 10:57:49 +0000
X-Mizu-Trace-ID: 82ad70a2456c4347
X-Migadu-Flow: FLOW_OUT
Message-ID: <24287f78-a962-470f-99eb-2624d8ac3bad@linux.dev>
Date: Fri, 6 Nov 2026 18:57:42 +0800
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
Subject: Re: [PATCH v2 net] tcp: do not resurrect a former listener with
 SO_ATTACH_REUSEPORT_[CE]BPF
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
References: <20261106084300.2029567-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261106084300.2029567-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/6/26 4:42 PM, Eric Dumazet wrote:
> After listen() + shutdown(), a TCP socket is moved to the closed
> section of its reuseport group, while TCP_NEW_SYN_RECV requests
> can still reference it as rsk_listener.
>
> If SO_ATTACH_REUSEPORT_[CE]BPF is then used on this socket,
> reuseport_attach_prog() calls reuseport_alloc(), which resurrects
> it into the listening section of a new group, even though the
> socket is still in TCP_CLOSE.
>
> After close(), the socket stays in that group and the pending
> requests keep it allocated. When the final ACK arrives,
> reuseport_migrate_sock() can select this dead socket and
> inet_csk_clone_lock() clones it. With a ULP like espintcp installed
> while in TCP_CLOSE, the child inherits icsk_ulp_data and sk_destruct
> after tcp_cleanup_ulp() cleared icsk_ulp_ops, leading to a
> use-after-free in espintcp_destruct().
>
> As done in commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions
> between ehash and lhash2."), deny this transition instead of adding
> checks to the fast path.
>
> Only an unhashed former listener is affected. Applications can still
> attach a reuseport prog to a socket that never listened, or to a
> listener (including one that called listen() again after shutdown()).
>
> Fixes: 333bb73f620e ("tcp: Keep TCP_CLOSE sockets in the reuseport group.")
> Reported-by: Kyle Zeng <kylebot@openai.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2: use sk_is_tcp() instead of checking sk_protocol, as raw sockets
>     can have sk_protocol == IPPROTO_TCP (Jiayuan Chen, Sashiko)
>     Add discovery, validation and testing info to the changelog (netdev-bot)
> v1: https://lore.kernel.org/netdev/20261105164830.1682714-1-edumazet@kernel.org/
>
> This was reported by OpenAI Security Research. The report does not
> state the discovery method, it was likely found by an AI-assisted scan.
>
> Validated with the reporter's PoC on a KASAN kernel: run as an
> unprivileged user in its own user and network namespaces, it triggers
> a slab-use-after-free in espintcp_destruct(). No kernel modification
> or error injection is needed. With this patch, SO_ATTACH_REUSEPORT_CBPF
> fails with -EINVAL and no splat is seen.
>
> The following selftests pass: net/reuseport_bpf, reuseport_bpf_cpu,
> reuseport_bpf_numa, reuseport_dualstack, reuseport_addr_any.sh,
> stress_reuseport_listen.sh, and bpf test_progs migrate_reuseport and
> select_reuseport.
>
>  net/core/sock_reuseport.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index fccbdd0430b05984e82c19b17b6b723b0a3a03a1..b9e5648fa4c515a578fffd375c5214b3d5de6645 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -6,6 +6,7 @@
>   * selecting the socket index from the array of available sockets.
>   */
>  
> +#include <net/inet_connection_sock.h>
>  #include <net/ip.h>
>  #include <net/sock_reuseport.h>
>  #include <linux/bpf.h>
> @@ -692,6 +693,14 @@ int reuseport_attach_prog(struct sock *sk, struct bpf_prog *prog)
>  		if (!sk->sk_reuseport)
>  			return -EINVAL;
>  
> +		/* Do not put a shutdown()ed TCP listener back into the
> +		 * listening section of a reuseport group while it is in
> +		 * TCP_CLOSE: requests can still migrate to it.
> +		 */
> +		if (sk_is_tcp(sk) &&
> +		    inet_csk(sk)->unhashed_state == TCP_LISTEN)
> +			return -EINVAL;
> +
>  		err = reuseport_alloc(sk, false);
>  		if (err)
>  			return err;
