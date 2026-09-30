Received: from mta0.migadu.com (out-134.mta0.migadu.com [91.218.175.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC6136672
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733006; cv=none; b=mSrbNTGc1Gq+9OICDKuE1Abs1tSkM4drKyw8phC3/A5KCZKwjTznaUSK2tIC0dgriT9YDWRKoDmXhXa1Q24VBsbGGCAbpPfO8+y+ilC5k/UGDz3v/PVeFREfszmqAOH5H9/IO4wpa+zDP1ltXjqV9Xv+WlH/ALIYKnzGqnvb0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733006; c=relaxed/simple;
	bh=OiqdVvsisT8F3wntgu/nAxi4/yGffSNhkcybgU9WYPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNKlXoNqibh23NoNWgRJ1X4M1EHHGsGQXGWfS1EaHcRH2aN055m665CTFAE0C0POz38jPKxGHMv4Qc+fVQfNIJgT8EY+4uI4BYRrv9olsAJQGRIr8hptKnMPy8cVaDj9klHCOKR1faCaDi+BK2I1+yMTuW0nIXJ+UGWUt99x3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eeyO/tMW; arc=none smtp.client-ip=91.218.175.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eeyO/tMW"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OiqdVvsisT8F3wntgu/nAxi4/yGffSNhkcybgU9WYPw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790733002; v=1; x=1791337802;
 b=eeyO/tMW4KZSiaF9TW09N1l0tHJ13W9907NTcFgRX/pqiaaRZ6gRVaNlMWo9zeNtLArfrH+c
 qP65zQ5bYVag3NXetXMjQvxNUT3Nuo+Crah652cU7NyzugTxfa6xc+/jo8sClmrP5nno2W35aLY
 xwrSibE+i5WnE+NoN9LNWrFQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2d28fdec00d830bd;
	Wed, 30 Sep 2026 01:50:01 +0000
X-Mizu-Trace-ID: 2d28fdec00d830bd
X-Migadu-Flow: FLOW_OUT
Message-ID: <88c771ae-4231-4795-b707-ff958ea27096@linux.dev>
Date: Wed, 30 Sep 2026 09:49:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: free inet_opt after an RCU grace period
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, edumazet@google.com,
 netdev@vger.kernel.org, Xinyang Ge <xinyang@anthropic.com>
References: <20260929214351.856940-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260929214351.856940-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/30/26 5:43 AM, Eric Dumazet wrote:
> tcp_v4_syn_recv_sock() transfers ownership of ireq->ireq_opt to the
> child socket (newinet->inet_opt) without copying it.
>
> Another cpu can concurrently retransmit a SYNACK for the same request
> socket (either from a retransmitted SYN, or from the SYNACK timer).
> tcp_v4_send_synack() and inet_csk_route_req() read ireq->ireq_opt
> under rcu_read_lock() only, and ip_build_and_send_pkt() and
> ip_options_build() then read opt->optlen twice.
>
> Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
> into ehash table"), request sockets are processed without holding
> the listener lock, so nothing prevents the child socket from being
> freed while the SYNACK is still being built. TCP child sockets do
> not have SOCK_RCU_FREE, and inet_sock_destruct() frees inet_opt
> with a plain kfree(), leading to a use-after-free in
> ip_options_build().
>
> Readers of inet_opt already use RCU, and other paths replacing
> inet_opt (do_ip_setsockopt(), cipso_v4_sock_setattr()...) already use
> kfree_rcu(). Use kfree_rcu() in inet_sock_destruct() as well.
>
> IPv6 is not affected, tcp_v6_syn_recv_sock() duplicates the options.
>
> Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
> Reported-by: Xinyang Ge <xinyang@anthropic.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>



For the SYNACK timer case, inet_csk_complete_hashdance() calls
timer_delete_sync() before the child can be freed, so I don't see how
that one can race. The retransmitted SYN path is the real one I think.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

> ---
>   net/ipv4/af_inet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 4ce38c99fef9ef2a24edff34cd5b110dddfec193..14ce01092fda65dbcf835662c03d78f4de0301f2 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -161,7 +161,7 @@ void inet_sock_destruct(struct sock *sk)
>   	WARN_ON_ONCE(sk->sk_wmem_queued);
>   	WARN_ON_ONCE(sk->sk_forward_alloc);
>   
> -	kfree(rcu_dereference_protected(inet->inet_opt, 1));
> +	kfree_rcu(rcu_dereference_protected(inet->inet_opt, 1), rcu);
>   	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
>   	dst_release(rcu_dereference_protected(sk->sk_rx_dst, 1));
>   	psp_sk_assoc_free(sk);
