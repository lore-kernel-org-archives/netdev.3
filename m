Received: from mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5E3BB114
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145607; cv=none; b=AXidjarwS4bSe9ZPQUa0BeHfJaUrKGTzlr581vJiBa/QeaTjpvM73D+O/rCg4Koh9//0Dmu1x0rmOIfqSCLgrdtrnzSd7O6YEVRZzmcQF8FMFKXuxP2uiPhJU/ALcXJS+D8U12Ys6/7WCURL/XKgRlbPQ0Nu3E7yzLu6eLjBVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145607; c=relaxed/simple;
	bh=u3VnXRo6HzGth7BuiYLVZgZf3FdnB0NBHCeoCBBDSHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTqboQypZvqSzmNttNwOgKou+MCsEhU5qDlsfFh5y/xo3z1gT8pUiemeIhzOaLgCPneUx+31adZEgJ5d1sgMdeZzPFiudEb9oQkblF6YMeIqFUHfaoPBjJhEO0dRzGGeLBdqkrecpVf6RbLuRBDgpwZ419AhYH+EUACtLAor+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q5+tzrAC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q5+tzrAC"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u3VnXRo6HzGth7BuiYLVZgZf3FdnB0NBHCeoCBBDSHc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792145603; v=1; x=1792750403;
 b=Q5+tzrACFADcg48GosJDBPXLmibSRubGDRAXnINE/s+keYRkPCXnAxa1IbhJovtK0t/0B4XK
 9QkUU/mC5yRlxLFZgnYMb52rMlQk9cXJHA6OKir/SFO5p9/T18SEmPQ51LuF8hNLFOvTzs8rm4Z
 Z5rV9VAdn3Fbi+Ga3RHcHVv0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8f59e590d35fba39;
	Fri, 16 Oct 2026 10:13:23 +0000
X-Mizu-Trace-ID: 8f59e590d35fba39
X-Migadu-Flow: FLOW_OUT
Message-ID: <3108e934-ec00-458b-8720-450554b35b55@linux.dev>
Date: Fri, 16 Oct 2026 18:13:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] kcm: don't sleep in softirq when the lower
 socket uses kTLS
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20261016025059.289202-1-rjethwani@purestorage.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261016025059.289202-1-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/16/26 10:44 AM, Rishikesh Jethwani wrote:
> When a TCP socket with software kTLS RX is attached to a KCM mux,


Can we just reject such combo ?


> psock_data_ready() calls strp_data_ready() from softirq, which calls the
> socket's read_sock(). For kTLS that is tls_sw_read_sock(), which can
> sleep, and CONFIG_DEBUG_ATOMIC_SLEEP reports it on every run of a
> loopback reproducer.
>
> Patch 1 is the fix: KCM parses inline only when read_sock is
> tcp_read_sock() and otherwise defers to the strparser work, which runs
> under lock_sock(). It applies and builds on its own, including on
> stable kernels.
>
> Patch 2 addresses review feedback on v1 and is needed by patch 1.
> kstrp, the workqueue that deferred work runs on, is an ordered
> workqueue shared by every strparser user (KCM, sockmap, espintcp,
> ovpn). With patch 1 alone, a KCM psock decrypting kTLS records in
> software on kstrp would delay parsing and message timeouts for every
> other strparser socket on the system. Patch 2 makes kstrp per-CPU. It
> has no Fixes tag: the ordered workqueue is as old as strparser, and it
> only becomes a real problem for KCM over kTLS with patch 1.
>
> Other strparser users are not affected by the bug fixed in patch 1:
> espintcp is itself a TCP ULP and cannot be combined with kTLS, ovpn
> installs its own ops built from inet_stream_ops, and sockmap reads
> through tcp_bpf_strp_read_sock() and is mutually exclusive with kTLS
> RX (do_tls_setsockopt_conf() rejects sockets with a psock).
>
> Testing: with patch 1, 5/5 runs of the reproducer produce no splat and
> full datagram delivery; without it every run hits "BUG: sleeping
> function called from invalid context" in strp_data_ready ->
> tls_sw_read_sock. Multi-record messages (>16 KiB each) also deliver
> completely with kTLS RX installed before the KCM attach and the whole
> stream queued before the reader starts. With patch 2, test_sockmap and the ovpn TCP selftests
> pass, strparser work runs concurrently across sockets, and dmesg shows
> no warnings.
>
> v2:
>   - add patch 2 (kstrp per-CPU), per review
>   - read sock->ops with READ_ONCE(), pairing with update_sk_prot()
>
> v1: https://lore.kernel.org/netdev/20261013033920.2069285-1-rjethwani@purestorage.com/
>
> Rishikesh Jethwani (2):
>    kcm: defer receive parsing when the lower socket's read_sock may sleep
>    strparser: don't serialize all parser work on one ordered workqueue
>
>   net/kcm/kcmsock.c         | 33 +++++++++++++++++++++++++++++++--
>   net/strparser/strparser.c |  2 +-
>   2 files changed, 32 insertions(+), 3 deletions(-)
>
