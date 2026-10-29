Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255393;
	b=B2JaDWM/ccApwdU/G59QOKgyoK56lfX/NSIXif0g4u7yFCJve9T4onUMZWwPEeRn94dO
	 aUjvpC0GYtalJKW08NTH8xBuOyn10bg0w6zRJIa8BP0ehuHnGl+hEuOrx0hCMTmbmxgkH
	 5zMPwBh45aJOVXkFGdQQvz7EU/iRhlioBdRtt5+MMGMcvWJC/mE4McklTgVLiimiURqxj
	 HeN5OmtvvcCnVG9hpPdTAhh12qdDoww8qL2u8owojR10S3aXdM0vtiCE5P2S+zrWntjoy
	 OdGXZ0H0+LolfT5zG0gyJFiem3jfAIWXU7Ljb0DobGjxBkvfjb0dEMvDBYtzcvMbDuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255393;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XM52WLL6+WmhSU1Kmh4tr9cK4E766/ebgk/5Kc3aeds=;
	b=IXmO5DAPueZo0BDER25xFpkh0qf1GxksHMy98cSg8WIlg4D+pRRsLLR0EdVWi/tJ3Chq
	 akvDX/ruzVsRdYCfLBhtDxoQEX5WEbGXFWYrG29rNlMpZ7EIBHliFdg9Wab95u9YOiq1V
	 FNitYp4Mimh9DqO5pljR0jR0F0MFH22u7Vglkuw4I4cC1YnEVB3j/0f1XjsSkRlohDUUT
	 mAIjXfcn9EZ8DHZUSJ3m/ldmr18MqJvzJXW5gPSaLYTeAcENUl2N9QBhdy3NxvAfEuWO9
	 v3Nx4zM4W9bvIha6GMxYfJeb8zjbvEWs1EFshD324WkrByQCNtdyBxUagVEwunueEnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nikld6US;
	arc=none smtp.remote-ip=91.218.175.23
Received: from mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68621606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68621606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nikld6US
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z5YFPbwT2/IH0q4mj7WTqYAIPsXNrVek6776CzzR6bc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793255389; v=1; x=1793860189;
 b=nikld6USnT9oetu2Ix6PDdk2pVFULKlWk0Zgo/lv2q/3gM5oPC71QtZKmVjh/woK5NYuKPdq
 i1QbNHlAuYAzPE83zzTMQCz3vwKARfYxyikrilXrJHeFdFSJ8YDyY+SRiFkoop7QvTtor8QfpL+
 VCpt//38U5PeTbVRtWYv+zuM=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0506a1682e0de6f7;
	Thu, 29 Oct 2026 06:29:49 +0000
X-Mizu-Trace-ID: 0506a1682e0de6f7
X-Migadu-Flow: FLOW_OUT
Message-ID: <8abda02d-4adc-4d83-8b07-cfec8e0bbc42@linux.dev>
Date: Thu, 29 Oct 2026 14:29:42 +0800
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
Subject: Re: [PATCH net] tcp: wait for TIME_WAIT teardown before freeing
 per-netns ehash
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>
References: <20261028162510.2180528-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261028162510.2180528-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/29/26 12:25 AM, Eric Dumazet wrote:
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
> Wait for an RCU grace period after purging the whole batch.
> TIME_WAIT removal runs with bottom halves disabled, so this also waits
> for removers that were already invisible to the purge. Keep the wait
> under tcp_exit_batch_mutex, before freeing any private hashinfo.
>
> Fixes: d1e5e6408b30 ("tcp: Introduce optional per-netns ehash.")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> [edumazet: only call synchronize_net() if one netns in the batch uses a private ehash]
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>   net/ipv4/tcp_ipv4.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index ebe5aa70374a3fd9e3305377efebec3004989945..3f8563a36db1e9ea853699ecb547af7ee9491b11 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3561,6 +3561,17 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
>   
>   	tcp_twsk_purge(net_exit_list);
>   
> +	/* inet_twsk_kill() can unhash a socket before the purge sees it.
> +	 * Wait for such BH-disabled callers to finish before freeing a
> +	 * private ehash. This is not needed for the shared tcp_hashinfo.
> +	 */
> +	list_for_each_entry(net, net_exit_list, exit_list) {
> +		if (net->ipv4.tcp_death_row.hashinfo->pernet) {
> +			synchronize_net();
> +			break;
> +		}
> +	}


Calling synchronize_net() only for the private ehash is nice and cheap


> +
>   	list_for_each_entry(net, net_exit_list, exit_list) {
>   		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
>   		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));


But I think this WARN_ON_ONCE can still be triggered, is that intentional?



tcp_sk_exit_batch            inet_twsk_kill (timer)
                          unlink
tcp_twsk_purge()        // does not see tw
refcount_dec_and_test() // tw_refcount 2 -> 1, WARN
  refcount_dec(&tw->tw_dr->tw_refcount)

