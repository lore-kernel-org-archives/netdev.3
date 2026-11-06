Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947453;
	b=EQMIzhNF44R7wLFKQyAFGgs2Jfh0L5PMu06uSHrWfC9e/5abKOmMl0Oj1ZrVgEsQD+zi
	 WxpbHIZxqA0Rg2fYlYtY0w7NYwpU/8oMnV/p8SYmwKJN+8VTFpQH2fp11F5idXzw6GKYL
	 CsXqnylWSvV6B0OqACaKi1KO0CgNwMFQi1ynfcHdycVS+EQ/n8qVemhJu8Dg5sBRuTyw4
	 nz3O6wsiVbsfAxmatw3U+fbdlxEcpCyY3+O1P63LBWnpOd31MdX33iVdS3jgoF9y39Rh8
	 bkRgEsVa1GGhlbjwh6jMCcGWEQIOb06rDZuOxq/ri55+W/733sMVwWlsfKgVhIjou8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947453;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AxmgrFG83FeLWnQ3yZIR//9+V61aHtkG9YgvMh4psmU=;
	b=rlN2FFAgDsw425EdAIQZisy9rdtSFmTsXnPyNCuZA5utzenKSnlPmdsbKcznh4bhYFhe
	 A+WENM2lCYVH0ERQmMlkwPdIZ2xqTO0hdvqeGHXI0Tnx5w1p6dfPce/i1kRLRzk9rJ1GR
	 EsbEWvmWw6pEqI4wcM+cRGOaoz/zcvRBujQGrjULC5GFcaX7nd+obji8vgVcdQj+DeRaO
	 /HHnGcOO5RBJVbeUaI4CBhLhITGwpifmBIs1BiByKbIQWzXzeUTcX+uTlcGuVkuM6wlnK
	 MGcmijeshOzdKZ5rS7BWnRx2PLP+TsRUY4ijvzglrz+qVdLrmPsZwUKJgs/vV4bSY0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="NoaZGc/B";
	arc=none smtp.remote-ip=91.218.175.192
Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69989606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 06:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69989606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NoaZGc/B
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GCAoN3VusxFuVpLq/129rE2eMDtJcAzX0AsYm3Y6aUg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793947450; v=1; x=1794552250;
 b=NoaZGc/BKTFw2PyRMJ8hUdOQGd54h25LZIn6H1Ht257OHK/xr+9ZH4/gMz/9eqqXMJf5WuDl
 x2JpvA0N4qGA+ZcyX8Fz7A7CxyOh50xd1Y5JX1SOD8HoxVzF6JifDpoQQXpxC81U86BkYHhWMma
 I0JLIzX7enCVbcMNNxINEPoE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 67bba967dcfb60c5;
	Fri, 06 Nov 2026 06:44:10 +0000
X-Mizu-Trace-ID: 67bba967dcfb60c5
X-Migadu-Flow: FLOW_OUT
Message-ID: <af79b34f-a941-4d0d-adbf-fe30a09c20d7@linux.dev>
Date: Fri, 6 Nov 2026 14:44:03 +0800
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
Subject: Re: [PATCH net] tcp: do not resurrect a former listener with
 SO_ATTACH_REUSEPORT_[CE]BPF
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
References: <20261105164830.1682714-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261105164830.1682714-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/6/26 12:48 AM, Eric Dumazet wrote:
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
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  net/core/sock_reuseport.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index fccbdd0430b05984e82c19b17b6b723b0a3a03a1..41a25be1bfff6aa486f33ed563a093a264c49344 100644
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
> +		if (sk->sk_protocol == IPPROTO_TCP &&
> +		    inet_csk(sk)->unhashed_state == TCP_LISTEN)
> +			return -EINVAL;
> +


I think sk_is_tcp() is better. raw socket still can reach here and inet_csk(sk) is invalid.


>  		err = reuseport_alloc(sk, false);
>  		if (err)
>  			return err;
