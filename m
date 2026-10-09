Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8761E7C2E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512643; cv=none; b=AZ6oS+8qImOcF2wfDjFjlcBiSYZt8JLiN6wMm3572GxqIBi/Vyea+3WoJNS8phxCjgWOGCcrvWUsa+y7aGoCqdr0q3GSWx3YBdNHy9dmDimYyINzD+SpJ4QTAM35XZlapu7YAsGl8ELiN9NgQ9kwINIgZpOYFPaiXGN0qpy9zeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512643; c=relaxed/simple;
	bh=2WXVJwmklAa4u7ERRVuvBgEqH+ocivdiloH46r0DQqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8MVoNBBdaJSKEWbUk0CfYo0MgCcq5sMP2gxlhs9p97BqYXHNEME9N/2TKQDe6rK7J6dnIXigCDRptRGse3v0TCkHUYRTI4+uHpa+Q9CzpRb//slHdchprZi2Y2PYy2ySu2p2yjIiM8hUFGAsjqs44AHCP7o1RgLvyLAJ69/+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qe2P+Yf2; arc=none smtp.client-ip=91.218.175.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qe2P+Yf2"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2WXVJwmklAa4u7ERRVuvBgEqH+ocivdiloH46r0DQqc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791512639; v=1; x=1792117439;
 b=Qe2P+Yf2icGy4aZ9s+Lpnh3vY+SOEpZsJZGR3LC0pankUuRGfiiypdKtsoMx1t2aZjCzNcQb
 3l7xcm3C9YJTJO/Z8cqmyc+P2wGHztSeOMGtukRxQaTJXGqxZAfKUtuHRD0oajFGf4ShlG4PQff
 JJtI7IYgcLhA65HXnhgd1wB4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8a2f425c20a86b80;
	Fri, 09 Oct 2026 02:23:59 +0000
X-Mizu-Trace-ID: 8a2f425c20a86b80
X-Migadu-Flow: FLOW_OUT
Message-ID: <9bed4cb1-7b56-4580-89ad-d8a5b427aae8@linux.dev>
Date: Fri, 9 Oct 2026 10:23:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tcp: do not send a SYNACK to a broadcast or
 multicast address
To: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>,
 edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261008114942.1376889-1-theodorlarionov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261008114942.1376889-1-theodorlarionov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/8/26 7:49 PM, Theodor Arsenij Larionov Trichkine wrote:
> tcp_v4_conn_request() drops a SYN sent to a broadcast or multicast
> address. The SYNACK route has no such check. A SYN with a multicast
> source address can reach a listener when it is looped back with its
> dst attached: ip_rcv_finish_core() then skips ip_route_input_noref()
> and its martian source check. A raw IP_HDRINCL socket sending to a
> local address does this, as does re-injection by nft dup or the
> iptables TEE target.
>
> If the SYN destination is an address on a non-loopback device and the
> source is a group joined there (such as 224.0.0.1), the SYNACK route
> has RTCF_MULTICAST and RTCF_LOCAL set, and ip_build_and_send_pkt()
> sends it through ip_mc_output(). skb->sk of a SYNACK is the request
> socket, so sk_mc_loop() reads inet_flags past the end of it:
>
> BUG: KASAN: slab-out-of-bounds in sk_mc_loop+0x111/0x170
> Read of size 8 at addr ffff88800f2b7f10 by task repro-raw/470
> Call Trace:
>   <IRQ>
>   sk_mc_loop+0x111/0x170
>   ip_mc_output+0x355/0x930
>   ip_build_and_send_pkt+0xb87/0xc50
>   tcp_v4_send_synack+0x500/0x6f0
>   tcp_conn_request+0x2135/0x2d90
>   tcp_v4_conn_request+0xa5/0x210
>   tcp_rcv_state_process+0x136e/0x6920
>   tcp_v4_do_rcv+0x339/0xb10
>   tcp_v4_rcv+0x34ab/0x3ab0
>   ip_protocol_deliver_rcu+0x6e/0x3e0
>   ip_local_deliver_finish+0x34d/0x510
>   ip_local_deliver+0x1bc/0x310
>   ip_rcv+0x390/0x410
>   __netif_receive_skb_one_core+0x199/0x1e0
>   process_backlog+0x239/0x680
>   __napi_poll+0xb5/0x650
>   net_rx_action+0x980/0xd60
>   handle_softirqs+0x17f/0x590
>   do_softirq+0x3f/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x66/0x80
>   __dev_queue_xmit+0xa65/0x3520
>   ip_finish_output2+0xb00/0x16f0
>   ip_output+0x2ad/0x4a0
>   raw_sendmsg+0x245b/0x28e0
>   inet_sendmsg+0x121/0x150
>   __sys_sendto+0x450/0x4e0
>   do_syscall_64+0xf6/0x500
>   </TASK>
>
> Allocated by task 470:
>   inet_reqsk_alloc+0x97/0x6f0
>   tcp_conn_request+0x4c6/0x2d90
>   tcp_v4_conn_request+0xa5/0x210
>
> The buggy address belongs to the object at ffff88800f2b7d60
>   which belongs to the cache request_sock_TCP of size 312
> The buggy address is located 120 bytes to the right of
>   allocated 312-byte region [ffff88800f2b7d60, ffff88800f2b7e98)
>
> Apply the same check to the SYNACK route in inet_csk_route_req().
>
> Fixes: ca6fb0651883 ("tcp: attach SYNACK messages to request sockets instead of listener")
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
> v2:
> - Reject broadcast/multicast SYNACK routes in inet_csk_route_req() (Eric Dumazet).
> - Describe how the SYN reaches the listener; add KASAN splat and repro.
> v1: https://lore.kernel.org/netdev/20261008100423.1256884-1-theodorlarionov@gmail.com/


I think SYN with 192.x.x.255 as source can also tirgger this warning 
when rp_filter is disabled.

