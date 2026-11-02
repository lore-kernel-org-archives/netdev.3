Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607196;
	b=pC2X6yN+EzOHOj0qvdkCu0UqU2iLTWzyVd2hK/qSFC456zzV6FRCCApoqTJaQTw8YiCv
	 Ii61SjWWNTmlsxxI4h6gNdzCuAsl7s4OLY0wzDk3CL0dGgDW98TuubYPGBbyRdtK4A+K+
	 xkm3tM1ihbTdckiPQhUkNZhTbAjv0F4nFR6PcKFhCbHUvTFGCEmpF+VyLJQWFvLA6rEay
	 h9ROLelqbjBqtgqDia5c9/xr7FM3fmAwgOU0I8R7vHFt/bfq/6aYr04dkmpiEvpEjzu3k
	 eDUd8AH7c7uXzazP+qj6TG1DMv66skRa6zJKpMQNX5gweE65Y3VmJ434+fPwKNO+xKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607196;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NR2DG4to3DrgMNw96bT2GuCZ0TZVPXbJYqsaTD914z0=;
	b=5n39f9Utg+VuoWi6B7uBjbzabUPsPwv7XWgeBxzgHa8DtmT8BwX5Ezaxqok3Wl1m7cGv
	 Ce5ClDoII3hl0GAAD8+PgH0oG+tN9qf0qt+vi2L/BTYGhlV86cAS3XSnZWYMCUsBVNeOq
	 cz7gUOROut6lQhFrLj7mDaWBIFASuXAmeooQJa5J9ErReb47EcO8kJJOx8tbHF0IHmp6s
	 kw9LaErnWiAskBizPivNtVeDxuuz50TyOIt4Mgk36c+0liVDiT1YkGfIaSZb7nbbXKTau
	 y14amInFQ3dUZ4VENBzSBaOXQ+utEfeXln4DbymTMT3BYtGAhDsTWtROkj+Ygft8SRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oDr4wuMZ;
	arc=none smtp.remote-ip=91.218.175.187
Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A48606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A48606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oDr4wuMZ
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JQs5O3d34CnsWeVGB2NdzABlZw7PWL1Nim0bgD3pMKQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793607193; v=1; x=1794211993;
 b=oDr4wuMZMH5849UzJ1/G4QumPUQjvw/U32C1N5y/WbL9FgfQSCOux6E4MqPojonTH5G4EwN5
 Q7jAWb74cHew43NTnG2p3yerHs4ulDpIQsZDV1Pb2ATTBYplEveMm7082vQGo9iqbY2ZgEE7SC6
 hGpLM14yZZOB5QUvvi6p5KPg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e2abdf9b3fa2c5ff;
	Mon, 02 Nov 2026 08:13:13 +0000
X-Mizu-Trace-ID: e2abdf9b3fa2c5ff
X-Migadu-Flow: FLOW_OUT
Message-ID: <b8595ed2-6e7a-48f1-8240-3d522776e378@linux.dev>
Date: Mon, 2 Nov 2026 16:13:06 +0800
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
Subject: Re: [PATCH net] tcp: initialize send sequence numbers before
 deferring TFO
To: Eric Dumazet <edumazet@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261102035943.9700-1-qingfang.deng@linux.dev>
 <bfbc4b3c-fe19-4070-97b4-4ff8ded06011@linux.dev>
 <d6ba5426-fbee-49da-b18b-1419fd84fa0f@linux.dev>
 <CAL4Wiio9VXUtGg4UrFFU1kG2JENYL8xi0DzsDmhOp=zXs0DiUg@mail.gmail.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CAL4Wiio9VXUtGg4UrFFU1kG2JENYL8xi0DzsDmhOp=zXs0DiUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/11/2 16:00, Eric Dumazet wrote:
> Le lun. 2 nov. 2026 à 08:41, Qingfang Deng <qingfang.deng@linux.dev> a écrit :
>> On 2026/11/2 14:11, Jiayuan Chen wrote:
>>> On 11/2/26 11:59 AM, Qingfang Deng wrote:
>>>> TCP_FASTOPEN_CONNECT can return from connect() before tcp_connect_init()
>>>> when a cached cookie or cookieless Fast Open allows deferring the SYN.
>>>> At this point write_seq contains the initial sequence number, while
>>>> snd_una and snd_nxt have not been initialized to that sequence number.
>>>>
>>>> Consequently, inet_diag and /proc/net/tcp{,6} report the initial
>>>> sequence number as the send queue length despite no SYN or payload being
>>>> queued.
>>>>
>>>> Initialize snd_una and snd_nxt to write_seq before marking the
>>>> connection as deferred. Both sequence-based queue lengths then remain
>>>> zero until the first write starts the connection and runs
>>>> tcp_connect_init().
>>> This patch looks good to me. But idiag_wqueue can still go negative
>>> on the normal connect path, since the socket is already hashed and
>>> diag does not take the socket lock. We always set write_seq first,
>>> then init snd_una later:
>>>
>>>     tcp_v4_connect
>>>       WRITE_ONCE(tp->write_seq, st.seq)
>>>       tcp_connect
>>>         tcp_connect_init
>>>           WRITE_ONCE(tp->snd_una, tp->write_seq)
>>>
>>> Can you try this instead?
>>>
>>>     r->idiag_wqueue = READ_ONCE(sk->sk_wmem_queued) ?
>>>                       READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_una) : 0;
>> This does not guarantee the load order on a weakly-ordered CPU. LLM
>> suggests using this load-acquire/store-release sequence:
>>
>> r->idiag_wqueue = smp_load_acquire(&sk->sk_wmem_queued) ?
>> READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_una) : 0;
>>
>> Then in tcp_connect_queue_skb(), replace sk_wmem_queued_add()
>> with smp_store_release():
>>
>> /* Paired with smp_load_acquire() in tcp_diag_get_info(). */
>> smp_store_release(&sk->sk_wmem_queued, sk->sk_wmem_queued + skb->truesize);
>>
>> What do you think?
> Please do not do this.
>
> /proc/net/tcp and inet_diag dump sockets without holding the socket
> lock. They provide a best effort snapshot, and transient inconsistent
> values are expected (see the comment about rx_queue in get_tcp4_sock()).
>
> The window in tcp_v4_connect()/tcp_v6_connect() is a few usec, with the
> socket lock held by the caller. Adding memory barriers in the TCP stack,
> on a field updated in many places, to cover this is not worth it.

tcp_connect_queue_skb(), as the name suggests, only queues the 
connecting SYN. So this adds a small setup cost on weakly-ordered CPUs 
(on x86, smp_store_release degrades to a compiler barrier).

If strong memory ordering is not required, do you prefer Jiayuan's approach?

>
> The bug you found is different: with deferred TFO, the bogus values stay
> forever, until the application calls sendmsg(). Your v1 fixes this.
>
> Note that tcpi_notsent_bytes (tcp_get_info()) is also fixed by your
> patch, you might mention this in the changelog. Not a big deal if you
> do not want to send a v2.
>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
