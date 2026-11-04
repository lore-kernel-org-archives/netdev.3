Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754688;
	b=WK5JmkKAqZMtlMaiwbwaNXWOM4QGU154ryHEoQG9WLwdTBtzaF5MQfp7WQHDgzI3UtCs
	 zBZu/aAbh3618JYyz4+HAoP/aBcSkBgulBz4UQ4mebShsBmZh370I9Z5drbfI08KfoSXb
	 OCTyKX+ZqXgfu5wTiY1LpqrkKYbJcSDCCPpozN5ZA2sqqCfWkFuaQcRCKRof0zcCSa/Er
	 qlIwGkMWSmEj7HfA7T6+gedCUqH8mi4vIRhUGM2APyaod/W2HrMC6AjP7em9GFrzDGDsT
	 Zik+8wJAIi+e5HWP1dQ6ot4TMNE1daaUDXr5rAt9ZSqlNNy8wk+KkHCUW+joZ9NrB/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754688;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0XVsgUYYITlAtYJaSIrHBYVMeYH8vlOK4hQO3FcxViI=;
	b=0evicOgIzbAtyHL035bGVPLxSMQmM8kyxZel7DS03ULiS8vJdfmv+hq8s9PPp3C8n7Vp
	 YP9umSpP0UIkmcjPCvIq4XF0DF8q5S41zulhvU2g3yCZRrL1eK+b+4VEgQ2d+guHgYIdt
	 km/dVIDje9NgT2JliNB+wPUPkcc2U/hP8ZGxV31m5aQX7ms5T4zgCvOHFiuEids5Ae7HA
	 3ZEqUTwyILXxp/M4Uc0UA1yRlobZCidvWvoZc1JdI38wMtzplF3sly62A16qflQKZEkl5
	 eJxGyRRRLHwUfqS04+OkFKaa4hdnJ3llMghKloNMCFVXPCaz02d3efWGHidwsN/M4CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u65yL+6G;
	arc=none smtp.remote-ip=91.218.175.99
Received: from mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB250606EE87
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 01:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB250606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u65yL+6G
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BCkOieLQhI6i5yJANtPfr6lFATiHdKgIYRQJAU8uJZA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793754684; v=1; x=1794359484;
 b=u65yL+6GlXtKpuPTPKrrD5ZvABrSN9p0vnTGckpysXWc7VU553qw9APkkHQvT5mYqviwnTwP
 nRbZmkVdPSX9MtZn21JiQMkxphcFU9nz8TpYBknHKkvsLjcpb579fl4qAJUmjrT4jM2+83eOUYl
 vydNLxAkQtcF2jY5B/asMTOM=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 10e2ba06084617f3;
	Wed, 04 Nov 2026 01:11:24 +0000
X-Mizu-Trace-ID: 10e2ba06084617f3
X-Migadu-Flow: FLOW_OUT
Date: Wed, 4 Nov 2026 09:11:16 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Leonardo Souza Silva <Capleonardo12@outlook.com>
Subject: Re: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace
 period
Message-ID: <auqGNNsCDh-s--lq@fedora>
References: <20261103090011.4128420-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103090011.4128420-1-edumazet@kernel.org>

On Tue, Nov 03, 2026 at 10:00:11AM +0100, Eric Dumazet wrote:
> ireq->ipv6_opt is only set by calipso_req_setattr(), when a CALIPSO
> NetLabel mapping is configured.
> 
> Request socket migration (net.ipv4.tcp_migrate_req=1, or a
> BPF_SK_REUSEPORT_SELECT_OR_MIGRATE program) clones the request
> socket with inet_reqsk_clone(), so that the old request socket and
> its clone share the same ipv6_opt, then reqsk_migrate_reset() clears
> the pointer in the old one.
> 
> Another cpu holding a reference on the old request socket can still
> be using these options, sending a SYNACK from tcp_v6_send_synack()
> or creating a child in tcp_v6_syn_recv_sock(), when the clone
> is freed. tcp_v6_reqsk_destructor() frees ipv6_opt with a plain
> kfree(), leading to a use-after-free.
> 
> Both readers already run under RCU, like their IPv4 counterparts.
> Use kfree_rcu() in tcp_v6_reqsk_destructor(), as commit e3f33b0a1d89
> ("ipv4: free inet_opt and ireq_opt after an RCU grace period") did
> for ireq_opt.
> 
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179369559062.488856.15441115725436277776@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> Found by Sashiko while reviewing another TCP fix :/
> 
>  net/ipv6/tcp_ipv6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index d406cd3c8ceabfdbb66f3e1b4f9e9a74754e8d0b..b1dec5d86d633db67a754c70ee1c63290a9acb5a 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -607,7 +607,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
>  
>  static void tcp_v6_reqsk_destructor(struct request_sock *req)
>  {
> -	kfree(inet_rsk(req)->ipv6_opt);
> +	kfree_rcu(inet_rsk(req)->ipv6_opt, rcu);
>  	consume_skb(inet_rsk(req)->pktopts);
>  }
>  
> -- 
> 2.53.0
> 

Cc Leonardo for the fixup.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
