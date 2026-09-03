Received: from mta1.migadu.com (out-136.mta1.migadu.com [95.215.58.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6200393DCD
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428426; cv=none; b=IJU+aPJ3KtlrWGOedex19BPCIHML31EZ49fXvtUzEcpkE1/1G990RydUx1xdZhsmvx0yHXvdAzE8oMA00WkadqfrTd3J4B10ZJYiMdk9C82t4bMaMJswHdsOGWXBEHyhVKmnGFpc2OYm87cEh9dS86y1Vme2xN6ZvTzXdTiSGvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428426; c=relaxed/simple;
	bh=li0QtrKSoF1w5akDTx2Tm8g+pJQlMKfNm+NiL9GmhYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQDPFKZEJa8oM+g4D0E7pLOMTJKNKDptdF6SB3WyFmqrVBoq+qkbN8yJgzpNbnzvbowbdB5Ch/SOcf0/3FhcJlJUTa8hSHidP8ZIJd6GDsd6e+vZDVqF1PhFKMrdBTIr0o8Aoe4pn/cv9z9pFi/XJKrW3rRTiUAmJaBGZ5s8a5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eZhWx7wB; arc=none smtp.client-ip=95.215.58.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eZhWx7wB"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=li0QtrKSoF1w5akDTx2Tm8g+pJQlMKfNm+NiL9GmhYQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788428422; v=1; x=1789033222;
 b=eZhWx7wBHRR/Ph6P+nMqRG2JBBF2FineSMg+Bv+q5CrDf3Ro2+/s6+6VgP40BUccRsQwIAZG
 DBVT/SsPyhYgIUC9/V54ohrKnpH33QJdX4Y6gS96vrddGPYmUWG1DwVzqUax3LorqYamD7QVotG
 oHrExYWk6z/1O3+2I88ZxRW0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9f4276aec2f9c0a2;
	Thu, 03 Sep 2026 09:40:22 +0000
X-Mizu-Trace-ID: 9f4276aec2f9c0a2
X-Migadu-Flow: FLOW_OUT
Message-ID: <7735a43a-98f4-4402-8bb7-790bee064f7f@linux.dev>
Date: Thu, 3 Sep 2026 17:40:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tls: fix the open record check in the max payload
 size setsockopt
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 linux-kernel@vger.kernel.org
References: <20260901072927.128688-1-jiayuan.chen@linux.dev>
 <2ba43d6b-f521-415e-a4a1-64b313051c88@redhat.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <2ba43d6b-f521-415e-a4a1-64b313051c88@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 9/3/26 5:06 PM, Paolo Abeni 写道:
> On 9/1/26 9:29 AM, Jiayuan Chen wrote:
>> @@ -862,6 +876,7 @@ static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
>>   static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>>   			     unsigned int optlen)
>>   {
>> +	struct tls_context *ctx;
>>   	int rc = 0;
>>   
>>   	switch (optname) {
>> @@ -881,9 +896,17 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
>>   		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
>>   		break;
>>   	case TLS_TX_MAX_PAYLOAD_LEN:
>> +		/* Take tx_lock like the sendmsg paths do, the socket lock is
>> +		 * dropped while a sender waits for memory, with no record open.
>> +		 */
>> +		ctx = tls_get_ctx(sk);
>> +		rc = mutex_lock_interruptible(&ctx->tx_lock);
>> +		if (rc)
> Why using the interruptible variant? the blocking lock just after will
> still ignore signals, and this sockopt will now surprisingly fail if a
> signal happens at the wrong time.
>
> /P


Hi Paolo,


The two waits are very different. The xmit path holds tx_lock across
sk_stream_wait_memory(), which can sleep for an undetermined time (until
the peer reads):

   tls_device_sendmsg()
      mutex_lock(&tls_ctx->tx_lock);
      lock_sock(sk);
      tls_push_data()
        sk_stream_wait_memory()   <- releases sk lock, keeps tx_lock
      release_sock(sk);
      mutex_unlock(&tls_ctx->tx_lock);


So waiting for tx_lock with plain mutex_lock() can leave the process in

D state for a long time. The lock_sock() after it is fine: the sleeping

sender drops the socket lock, so that wait is only for short critical 
sections, never across the long sleep.


tls_sw_sendmsg() also uses  mutex_lock_interruptible but 
tls_device_sendmsg() still

uses plain mutex_lock() indeed, but that's another topic.

