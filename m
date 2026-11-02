Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605266;
	b=mJQrTH1eMMO27flsvI9zQMcLalFVkJJwHR5+aWbFi5BxO2NEV+HvB8mTDL2Ws07nvKiv
	 My3dcodnT4hEfJZpCkR+Nd3kacD73EJisC9AKP3P/A9Lt6wHG2HAITe3kM91UgS+/biba
	 SxrJLag7acUxGWGMSkqTEZfAglWhuwGF/icvkrm23uBI4pU7crhAYi/frdd/EZsnnr3li
	 x+npC37VOmEWj3V5ai9zx/HMNONsE4YmCKFyFtCfuraMihxFkEuraPU+MBm+Xy8g+eFJO
	 PCMsyKeK00qcFSsX6UHKzuoclWoHChIUQ5i8I5tvu+EtqlVH7sMh2digN+W9R+7Ye+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605266;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OfgCQoL8h0OQGIBTyFTsKwgv2S5WkrlkH70wsc4VUwU=;
	b=bZFfkbhw0hRuYIrb4BpmleOZRD2irMBZU41x//qMF+Ybwk1DTwvnvl7NbTxA7SsMsIWR
	 ZSyJ9JaOYXykOhGWhiKyeXcJz2wKugSn6HZDQce2lDXqUxJWA5MmN7s4l2Dv+2rYjP5oW
	 GNz4DSN8xROrMbBom/ogTG+XaG5Edb3zMwruqURn3EglLmlXc6ECK80tmmrQJjsFLSVLd
	 QIeG1UkB2/rVQjSkvNnjt3yrNDMJO3H2rFC1aB2Iyrg/bQbBPqTT8V3A+ShNgCTpczfKA
	 uWvLoVTwOFfIrZWQbSpJCeoVUq7GqvSz/WuqrhkPlduLM0BGhuCFMuw9MfBtPnDI7lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qAaai3dX;
	arc=none smtp.remote-ip=95.215.58.83
Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1A60A2617
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F1A60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qAaai3dX
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DZgmR+w0hXnF42goaWJ6bzq/W2wIthHLUmetG/gcZXQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793605263; v=1; x=1794210063;
 b=qAaai3dXugNnqaMvqljDfgxrhRbkO6zBMQKdUyeMI+BjMtNlDl6iZwO2qWGjq3U3+neTyY64
 7QN6YcjyoCXCr0LRSrSRWW5ps5Y/B83buL4GUvOfjLEq53CpvYUx5Zc6Ugl2dOFrhSsojAf9U7u
 EBqRJWAfCGWageqdx7owJBSk=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef704eb15b54ecc3;
	Mon, 02 Nov 2026 07:41:03 +0000
X-Mizu-Trace-ID: ef704eb15b54ecc3
X-Migadu-Flow: FLOW_OUT
Message-ID: <d6ba5426-fbee-49da-b18b-1419fd84fa0f@linux.dev>
Date: Mon, 2 Nov 2026 15:40:56 +0800
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
To: Jiayuan Chen <jiayuan.chen@linux.dev>
References: <20261102035943.9700-1-qingfang.deng@linux.dev>
 <bfbc4b3c-fe19-4070-97b4-4ff8ded06011@linux.dev>
From: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <bfbc4b3c-fe19-4070-97b4-4ff8ded06011@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/11/2 14:11, Jiayuan Chen wrote:
> On 11/2/26 11:59 AM, Qingfang Deng wrote:
>> TCP_FASTOPEN_CONNECT can return from connect() before tcp_connect_init()
>> when a cached cookie or cookieless Fast Open allows deferring the SYN.
>> At this point write_seq contains the initial sequence number, while
>> snd_una and snd_nxt have not been initialized to that sequence number.
>>
>> Consequently, inet_diag and /proc/net/tcp{,6} report the initial
>> sequence number as the send queue length despite no SYN or payload being
>> queued.
>>
>> Initialize snd_una and snd_nxt to write_seq before marking the
>> connection as deferred. Both sequence-based queue lengths then remain
>> zero until the first write starts the connection and runs
>> tcp_connect_init().
>
> This patch looks good to me. But idiag_wqueue can still go negative
> on the normal connect path, since the socket is already hashed and
> diag does not take the socket lock. We always set write_seq first,
> then init snd_una later:
>
>    tcp_v4_connect
>      WRITE_ONCE(tp->write_seq, st.seq)
>      tcp_connect
>        tcp_connect_init
>          WRITE_ONCE(tp->snd_una, tp->write_seq)
>
> Can you try this instead?
>
>    r->idiag_wqueue = READ_ONCE(sk->sk_wmem_queued) ?
>                      READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_una) : 0;

This does not guarantee the load order on a weakly-ordered CPU. LLM 
suggests using this load-acquire/store-release sequence:

r->idiag_wqueue = smp_load_acquire(&sk->sk_wmem_queued) ? 
READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_una) : 0;

Then in tcp_connect_queue_skb(), replace sk_wmem_queued_add() 
with smp_store_release():

/* Paired with smp_load_acquire() in tcp_diag_get_info(). */
smp_store_release(&sk->sk_wmem_queued, sk->sk_wmem_queued + skb->truesize);

What do you think?

