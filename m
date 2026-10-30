Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.237
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349919;
	b=CiwTp/HlUwDrJgaJScmeQC9OVM/H+eIynp7pYvfKGiKLQwjV3sU9TDSH+JAfZ+iLMgpq
	 cfchIFqcj4OGwdf5m2UQub8JhFrvLCxJxscn9dzFHq/3NyStQ6+7G+le5yzwIhsEjilGR
	 JMC0Nj0oFyFv6xuJIUMo96CkZgCqEMcq/H3zecwDFc+wkQoqg4DPWOwnZNt67lFRoBfj8
	 KSMT+QlAOfjR1pDutQmoifvxq1PaqEVIGTPMp/EAFzNzErR6yX/MWxr2Zue9Cc8DPKLmL
	 jfceEZ+hHwytrLCf4j+KXSNbNuQTQq5f47Oz1p40pt/k48QkDWqerwlmbSg8cqwViTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349919;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0+9sBeW1vyk+9Ddsj/hB4uxsNsKIjLd36amOWkiS3HM=;
	b=AYppqE23p6zBDM81JtY95BVRVXPj8mFB5SSzj74gN8JHooXOdoTFOCU73S0n9QsphJg/
	 yocBHHyGr3agvV4oy2ykrfSMeCWGGk/24I35mzqZXI3u9iM2/Gmg8zyzjGBKkpi0K1kSV
	 kQdNITVxZ5z20o08Yv9jktDabsm0hPs8Y0+U4I/x1gmwEe3dBQ1uJTmkrijFWMg0lE04A
	 MSBIjf7/JFkEQEG0SwebN5FchFJs2vu1zOG/1l/UmKxrojt5+iZe0g9Hs6ogSi9ESAqtR
	 KL7hSBbRsRS933gpEHfcID++ZiYJY+/guXh2htYW4QrlFHeI60TBW0+f9o2S3QCqKKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YKIDJjLL;
	arc=none smtp.remote-ip=95.215.58.237
Received: from mta1.migadu.com (out-237.mta1.migadu.com [95.215.58.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5B606A31F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BA5B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YKIDJjLL
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eSjnXQu4aXthmM5PtaY1aJKjYB/mOM0kCLb0GmRBAvk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793349915; v=1; x=1793954715;
 b=YKIDJjLLS/1y6GdCf+zpgMyQ1Fo+7VFpR6ESEM8HIiYj9rNOc3dkxB3S2wkFeTQDxUUZbVXU
 HDzYNNdZH21DAa6QuXd9/QuEEPLfTHrn0mRS753WP++oX9U7HDTUNGUXyfaUZUCo+HIuPQh9XXM
 JiJw3F8/SXwUEBDEXyOL1aNs=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fd11212d7a25847c;
	Fri, 30 Oct 2026 08:45:13 +0000
X-Mizu-Trace-ID: fd11212d7a25847c
X-Migadu-Flow: FLOW_OUT
Message-ID: <2d8bd17f-3d1d-452c-8e81-716ca18a72ca@linux.dev>
Date: Fri, 30 Oct 2026 16:45:03 +0800
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
Subject: Re: [PATCH v2 net] tcp: wait for TIME_WAIT teardown before freeing
 per-netns ehash
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
References: <20261030075843.2567707-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261030075843.2567707-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/30/26 3:58 PM, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
>
> inet_twsk_kill() removes a TIME_WAIT socket from the established hash
> before it finishes using the ehash lock, hashinfo and bind tables, and
> before it drops the death-row reference. A running timer can therefore
> unhash its socket before inet_twsk_purge() reaches it. The purge cannot
> synchronize with that timer, and tcp_sk_exit_batch() can free the
> private ehash and hashinfo while inet_twsk_kill() is still using them.
>
> An unprivileged reproducer using user and network namespaces, a private
> TCP ehash and a FIN_WAIT2 timer triggers a KASAN slab-use-after-free in
> inet_twsk_kill(). The allocation and free stacks point to
> inet_pernet_hashinfo_alloc() and inet_pernet_hashinfo_free().
>
> Wait for an RCU grace period after purging the whole batch, if one
> netns in the batch uses a private ehash. TIME_WAIT removal runs with
> bottom halves disabled, so this also waits for removers that were
> already invisible to the purge. Keep the wait under
> tcp_exit_batch_mutex, before freeing any private hashinfo.
>
> The same window exists with the shared tcp_hashinfo. There, the
> hashinfo memory stays valid, but tcp_sk_exit_batch() can decrement
> tcp_death_row.tw_refcount from 2 to 1 before inet_twsk_kill() drops its
> own reference. This triggers the WARN_ON_ONCE() in tcp_sk_exit_batch(),
> then a refcount_t "decrement hit 0" warning from inet_twsk_kill().
>
> Adding a grace period for the shared case would be costly on busy
> hosts. It is not needed: struct net is freed by a later cleanup_net(),
> after the synchronize_rcu() in ops_undo_list(), so inet_twsk_kill()
> can safely drop the last tw_refcount reference itself.
> Use refcount_dec_if_one() and only warn if tw_refcount is not 1
> after a grace period.
>
> Fixes: d1e5e6408b30 ("tcp: Introduce optional per-netns ehash.")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> [edumazet: only call synchronize_net() if one netns in the batch uses a private ehash,
>   use refcount_dec_if_one() to avoid a false WARN with the shared ehash]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
> v2: [edumazet]
>      Avoid a false WARN_ON_ONCE() in tcp_sk_exit_batch() when a concurrent
>      inet_twsk_kill() still holds a tw_refcount reference, as reported by
>      Jiayuan Chen and Sashiko. Use refcount_dec_if_one() and only warn
>      after a grace period, instead of adding synchronize_net() for the
>      shared ehash, which would be costly on busy hosts.
>
>      When net-next reopens, I plan to free the private hashinfo after
>      an RCU grace period (call_rcu()), so that tcp_sk_exit_batch() no
>      longer needs synchronize_net(). This would also cover request
>      sockets and RCU lookups that could still touch a private ehash.
>
> v1: https://lore.kernel.org/netdev/20261028162510.2180528-1-edumazet@kernel.org/
>
>   net/ipv4/tcp_ipv4.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a7f9242f1e429033da2c1284b7c1a1964b2ab171..0dc3b087665dc09ffbdc5c124c4ea2ce7d813c56 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3549,6 +3549,7 @@ static int __net_init tcp_sk_init(struct net *net)
>   
>   static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
>   {
> +	bool synced = false;
>   	struct net *net;
>   
>   	/* make sure concurrent calls to tcp_sk_exit_batch from net_cleanup_work
> @@ -3563,9 +3564,27 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
>   
>   	tcp_twsk_purge(net_exit_list);
>   
> +	/* inet_twsk_kill() unhashes a twsk before it is done with ehash
> +	 * and bhash, and before it drops its tw_refcount reference,
> +	 * so tcp_twsk_purge() can miss it. Such callers run with BH
> +	 * disabled: wait for them before freeing a private ehash.
> +	 */
> +	list_for_each_entry(net, net_exit_list, exit_list) {
> +		if (net->ipv4.tcp_death_row.hashinfo->pernet) {
> +			synchronize_net();
> +			synced = true;
> +			break;
> +		}
> +	}
> +
>   	list_for_each_entry(net, net_exit_list, exit_list) {
>   		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
> -		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
> +		/* Without a grace period, a concurrent inet_twsk_kill() might
> +		 * still hold a tw_refcount reference. Let it drop it: struct net
> +		 * is freed by a later cleanup_net(), after an RCU grace period.
> +		 */
> +		if (!refcount_dec_if_one(&net->ipv4.tcp_death_row.tw_refcount))
> +			WARN_ON_ONCE(synced);
>   		tcp_fastopen_ctx_destroy(net);
>   	}
>   
