Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763613;
	b=NS2zbk+oylQJ/FU3LiYI5ZpmJOwxth6UMeuWZPJYcS06tcs9sZzLPxOoPOCCFEdrUrx4
	 BlNjF3SQXLVGKE/N2jkn7hCrxqS3cSTDksMWJISeMQtE8W7IMpNkRsBrFPTDx4OnAzQHU
	 6zsIYjRE1eewlJkyebwHyQXJmapzpoHeshv0CmqDBRc6+Jp+d0QpMFlsi5cYc4wLQCjw1
	 O30S0bbirHPhJvm7GkYmXxHBWcyZoyGw5SUHpi+oP4BtAnRB3Y4f9dthNZMLUUbsWcjid
	 GJZfScLJtLdn0jbiTKDjhuaH08N5Zi0RZJHkYhmoQQJIVaberlq4QptP7U5oYxlKLbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763613;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fojwHZCtzaJopBfl5aK3uO3xYsshCiuhr2uf/3RjkX8=;
	b=tCNmIK3xFRtzoC5qI3CIu1TcBbDFpTflyyKvhajAX4pYX2a5L3iQFOYpc0X6HqvH1nJj
	 cXjR/nphcrbi9AK/T7ZjO9UdGpXMUE7vJAZv1ft94HU6i8JNVY+tFaHrktr/bcqYYnFXv
	 r8q8Dhkd8qdSlxp5/0mqnOjEJrUdCte3Txe9PVcI2cWBpcxj2+7b6WuF3QhTRP3j2dttO
	 SS2tBtjwiOv3/s+JtyUUWuZqdbuxf5D4JdNAi7zcMpL4Au9/Jxvyt4fhkYPMWrDqjGchT
	 54kYQLTe4144M4Eayp0+wZJPqO3sSTGaxK67TjaVvli43Bt3ybyOTFnZEUYI28pTpkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=if6ffYGr;
	arc=none smtp.remote-ip=95.215.58.210
Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31489606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 03:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31489606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=if6ffYGr
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Oa9E8MFe8RaHihHbshmtOsQO/uONzrNu9w1E2MrkL9I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793763609; v=1; x=1794368409;
 b=if6ffYGrfXjVCtj4sJCzfLzWgJEmqMeARxDu5TW1Bt/rI1memd839tbrAn/JOfaL8ecg0TEl
 WpaJ1HTlnueuMaA5HLfL6CFuVHN8ozRq3CK/UtFsNWfuc9hl5Oeac76oshRG2DK9DS5tGXFUdF2
 43Y3BAW3oh946Ogadqmp5y+Q=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 83ee575f8c893e61;
	Wed, 04 Nov 2026 03:40:07 +0000
X-Mizu-Trace-ID: 83ee575f8c893e61
X-Migadu-Flow: FLOW_OUT
Message-ID: <6087bc31-42d7-4881-bbcd-b4fcd2497047@linux.dev>
Date: Wed, 4 Nov 2026 11:39:58 +0800
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
Subject: Re: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace
 period
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261103090011.4128420-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261103090011.4128420-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/3/26 5:00 PM, Eric Dumazet wrote:
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


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


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
