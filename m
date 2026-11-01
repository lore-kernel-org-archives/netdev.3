Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515500;
	b=MntbXz7ffUjRjAx1ELgLFducxxFruxlCSJ8LZa9GCRgBUw7OZReV7ikxpZrsqU16wXvR
	 L610/wRAl8d5GIL4lqbyMH0/hw4TUpdAUwa5lZEyVd32FZyLv/EPKVDbqKs8RCwZW/1qP
	 GxRO/SPDX0wtFZertqtWMGxDinAZf6v+ZYTIMzsPMapiRwakTGnY2pQAkdYPw2jalLexE
	 yH1zDV8q8i+GmPaea/7xzQrKp+tqbb4bto8Z/GZ5/8I4uXDSdwWBwc9oqJQtt8bb7ycDs
	 S5T2sg/5hDb0trNNWOc5MHoUwBQ5XGS9x2y42vKpTsF2hXdmimj2KGzF4CJnTjket/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515500;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MjeLtY2DBxlNulj/2LaRSITduXdqvnbab4uZr8PMSus=;
	b=Z4u8OJQAjjEe0WB+iujmH7G8+vbSE0XI/pq65MoKNU4a4NB9UwWkSctfSepzhTQuAort
	 Rg2tjgwVzhB+k5F2KlQpHYPX5gCWCnLV4vx3pSOQnsNVZpAHV2eZ3ownCQ+neHZn4qoUW
	 vQ/EAOG6yzeQleYFx8C9yc++sBBQSY6AuleY6axeFpq1c89cDVlZaYDHDESH7IWbYBn1q
	 4GABLyqcaSrZG+v5DIyqIwdRe77r03Ip+NlWrOczIKnqTvoP7okQ0yujr4LySB/jHMQV1
	 9h/q6kEFeuPCUQtIQWMZxjAIrVSa+LeNL2nPKQbvPWGqsQnUNfoe8nuTG2rWeFxMrNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=su9O7hYL;
	arc=none smtp.remote-ip=91.218.175.135
Received: from mta0.migadu.com (out-135.mta0.migadu.com [91.218.175.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B4606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 06:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B04B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=su9O7hYL
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=60GCInmN/tX0eq+1oSQw8M2qeJADVFWe9YKgp/0g2oo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793515497; v=1; x=1794120297;
 b=su9O7hYL0nHUAwcQo9+DskVC9BPjURwpfRoPx0e1HYsmnUCa5X13aYYerUrPtLafGHMjnmcq
 gktSyaZVA14RAe+STRO4IFY6GPHf3uMqoxCOxiyHxpul9m2kF1Vuh0bv/Ixg0rGW/Y1/zDy3BV0
 svXw6D0bOtl97ievYBVjdFlw=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8c32165ce84ce8c6;
	Sun, 01 Nov 2026 06:44:57 +0000
X-Mizu-Trace-ID: 8c32165ce84ce8c6
X-Migadu-Flow: FLOW_OUT
Message-ID: <39bb2026-f872-4cad-88e1-ebd07f59f2a7@linux.dev>
Date: Sun, 1 Nov 2026 14:44:47 +0800
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
Subject: Re: [PATCH net] soreuseport: annotate data-races around
 reuse->socks[] and num_socks
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
References: <20261030120956.3026324-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261030120956.3026324-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/30/26 8:09 PM, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
>
> reuseport_select_sock() and reuseport_migrate_sock() read
> reuse->num_socks and reuse->socks[] locklessly under RCU, while
> writers holding reuseport_lock can change them.
>
> Readers snapshot num_socks once, then index socks[] with it.
> Meanwhile, writers can perform several operations, storing into
> slots below the reader's stale count:
>
> - __reuseport_detach_sock() moves the last socket into slot i.
> - __reuseport_add_sock() then writes the new socket at the
>    (now smaller) num_socks index.
> - reuseport_stop_listen_sock() calls __reuseport_detach_sock()
>    then __reuseport_add_closed_sock(), which writes slot
>    max_socks - num_closed_socks - 1. This can be the slot a reader
>    still considers part of the listener region when the array is full.
> - __reuseport_detach_closed_sock() can then rewrite that slot.
>
> All pointers stored in socks[] remain valid for the RCU grace period,
> but without annotations the compiler is allowed to tear or reload
> these accesses. For instance, reuseport_select_sock_by_hash() could
> reload reuse->socks[i] between the sk_state/sk_incoming_cpu checks
> and the return, returning a socket that did not pass them.
>
> Use WRITE_ONCE() for all socks[] stores done while the array is
> visible to readers, and for num_socks updates (readers already use
> READ_ONCE()). Use READ_ONCE() in the two lockless readers.
>
> Fixes: ef456144da8e ("soreuseport: define reuseport groups")
> Link: https://lore.kernel.org/netdev/20260902071900.395567-1-ruanjinjie@huawei.com/
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>



Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>



