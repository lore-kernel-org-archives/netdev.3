Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599910;
	b=eQBUL3uZ3SRgfBDqOMwFwQM9QXsUv2ICw7PZHu3NmYLgDnzR/gAgxVMl9NIdkHLlNXW8
	 wYe0j+ahZZG+4Lys4aWbxb7Jf232MMPztQVmb8Od9CFRugv0ZIAcbD5OHMOni6H6NFBIn
	 vqykhOSGy39rPHAKP3lzUyiPEXbVgl6alnOOLFu3FuqLI+GmR9H13+Cw1PEenzUGHVHck
	 95RYXVhscI3ldtNlpfgUV9PPlL5i+27KyqvMZFdu0jQKF3XlDwOjykhpM/jANqT3q28/v
	 GNf8DliEtPUKCX/RokcsM3Yy2b0YpCaYMDL4iGXAQ48fCZgmEI7U+UHmsCCcxjxZMNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599910;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9/+XZluyuQYuL1PPzJIXmb0wYbMN8JEjNGZtTVHdimI=;
	b=3lUFV0y5peyXeE+Ejm82pNmx2hJZWvmrCr37PgE5rrLIxnjx00AQDhDF3dqCQL68r9ca
	 InTGcn+RPr5KwkbvhZc9D+n8T5FYyWa16tB4twyqnGRJuFR77Uns3+LQJnJqlwtaRWaRd
	 vnKRUrAuq62/dhuuo1kTEZgn0iLpK3+GjwbXCkDP2XmsOD3ebbHSyedLkJU4xu0gmJegJ
	 ioOy86QSZ7LeT15ghimC/fNogHF0vdAJFMcTpBkZoscabgXWvmoLJmsK1iSUS32c2bUA4
	 5p0XjrX406nH8rJD3gookMu5Jypf1p1cjqB0G7e/Je93DnRUsdcZC4u4kBf8B/QclGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NAtJJXle;
	arc=none smtp.remote-ip=91.218.175.172
Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96F606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 06:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC96F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NAtJJXle
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9/+XZluyuQYuL1PPzJIXmb0wYbMN8JEjNGZtTVHdimI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793599907; v=1; x=1794204707;
 b=NAtJJXlenW+h0I4eC/Y29Ra0n7wrbkvXBzOBWOM7stgSa/poa+4xZCwdeofPTfBuJj+R6nxF
 9iX9AChKcJMQlgdhW3WsxTQ8COMW0XIv23CIR78ixFuucpfp3bC+JAYoHtz2fZMaI5mfCZnzX6N
 EmJNMqXVeozJu9RapD8eY8xo=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0e361a7862659f90;
	Mon, 02 Nov 2026 06:11:47 +0000
X-Mizu-Trace-ID: 0e361a7862659f90
X-Migadu-Flow: FLOW_OUT
Message-ID: <bfbc4b3c-fe19-4070-97b4-4ff8ded06011@linux.dev>
Date: Mon, 2 Nov 2026 14:11:43 +0800
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
To: Qingfang Deng <qingfang.deng@linux.dev>,
 Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261102035943.9700-1-qingfang.deng@linux.dev>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102035943.9700-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/2/26 11:59 AM, Qingfang Deng wrote:
> TCP_FASTOPEN_CONNECT can return from connect() before tcp_connect_init()
> when a cached cookie or cookieless Fast Open allows deferring the SYN.
> At this point write_seq contains the initial sequence number, while
> snd_una and snd_nxt have not been initialized to that sequence number.
>
> Consequently, inet_diag and /proc/net/tcp{,6} report the initial
> sequence number as the send queue length despite no SYN or payload being
> queued.
>
> Initialize snd_una and snd_nxt to write_seq before marking the
> connection as deferred. Both sequence-based queue lengths then remain
> zero until the first write starts the connection and runs
> tcp_connect_init().


This patch looks good to me. But idiag_wqueue can still go negative
on the normal connect path, since the socket is already hashed and
diag does not take the socket lock. We always set write_seq first,
then init snd_una later:

  tcp_v4_connect
    WRITE_ONCE(tp->write_seq, st.seq)
    tcp_connect
      tcp_connect_init
        WRITE_ONCE(tp->snd_una, tp->write_seq)

Can you try this instead?

  r->idiag_wqueue = READ_ONCE(sk->sk_wmem_queued) ?
                    READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_una) : 0;


