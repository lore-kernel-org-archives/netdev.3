Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.208
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624445;
	b=sP8XE5BvR/b66bs7cevJs2K2ysIaHlRJfst8CAUQiimfdX21IcRpibCJ83iLe6cnEFDE
	 lZvayU05SP3Y6I9wTcbXy7AJHSwScnVjhuWt4DoGzmUaq1dfDr/A9baqKtXUD16NZ5Cry
	 bPFYyHt4Y3aElrkSvyK++bnzu1+OWqplsmgcf9YzogiSw6aV6qwC1Uho6L0OQ3Gijnabk
	 2TQE48d2u+V2uirz+xDUc2cobhN50ersioVv0+eFlRDKdf2LPhkbJ62ySwbOifcIJwp86
	 y4ZPwt24z8BehCc3PuXmF/Vijm1IcMNa7BMUdPWWBVUcXNI+SxboJUvtdu42BDDRd+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624445;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=21gt7xEfR2u3AUi1YN0gEZzmBDhKnP/sCxBQCob5mMg=;
	b=Drf4J+i0x1/nCLdXKjucEIoZSlsz06AOMLpQsQhsbHkCXZex7YSgRno7u1oO4x4SU4E8
	 W9pqHv9CZCOorVCDTmBZAYP2BbjwV4PYVGmq2Ew1k1fJnJP0//DH4hTeiprTb4O93Gm8N
	 iUnX+Aq1wgbZ1jVXWilku1G8HWaeosFjRyrKqgkCuklFzBkmdfop7LdJFbPgFMIH4i90J
	 2htDGEp5hFXsrsoE4dPaoXlq3DBPNiq1LQDWdzKaysNa62YqW4AM7DQ1fBENIFzCWCsxZ
	 qfaR6UfOlmtcPDBLf0uqTONF2Yo/VbuSJG/p00MHdtqIcHfDNCiNQ8T7WipCn2YmVkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AXMwqlWO;
	arc=none smtp.remote-ip=91.218.175.208
Received: from mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E78606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E78606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AXMwqlWO
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jThf718hluzGgF+y7XM56/xWJWlb1Eyj+wKob1SacCw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793624442; v=1; x=1794229242;
 b=AXMwqlWO5jrcsIs1sBO+mlrFosOYHkMf8qzVXdcHOUqSit4ODziPJGp9JhYxthwSQ3itw2n9
 RYJjnqmkv9Iwt/Ow0C/VmsHh8xhokvcf9MiwT/ctviHxJMaT147C6NtscX05FYzfCqrms9ViHvk
 IDDOV+1bev4+8a7Pvy/po2Dw=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 96670a589e3b8f7a;
	Mon, 02 Nov 2026 13:00:30 +0000
X-Mizu-Trace-ID: 96670a589e3b8f7a
X-Migadu-Flow: FLOW_OUT
Message-ID: <3ee84772-9aa6-433e-bac7-40adc599f90d@linux.dev>
Date: Mon, 2 Nov 2026 21:00:24 +0800
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
Subject: Re: [PATCH net] tcp: ipv6: do not read ireq->pktopts from
 tcp_v6_send_synack()
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Anvik Loitongbam <permissiontogallop@gmail.com>,
 Yingjie Wang <x-professor@outlook.com>
References: <20261102075441.3771550-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102075441.3771550-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/2/26 3:54 PM, Eric Dumazet wrote:
> When IPV6_FL_F_REFLECT is set on a listener, or the
> net.ipv6.flowlabel_reflect sysctl has FLOWLABEL_REFLECT_ESTABLISHED,
> tcp_v6_send_synack() reflects the flowlabel of the SYN packet,
> reading it from the skb stored in ireq->pktopts.
>
> Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
> into ehash table"), request sockets are processed without holding
> the listener lock. A cpu can then process a retransmitted SYN for a
> request socket, and send a SYNACK from tcp_check_req(), while another
> cpu receives the ACK completing the 3WHS. tcp_v6_syn_recv_sock()
> consumes ireq->pktopts when it wins the hashdance, and the first cpu
> reads a freed skb:
>
>   BUG: KASAN: slab-use-after-free in tcp_v6_send_synack (include/linux/skbuff.h:3152 include/linux/ipv6.h:110 net/ipv6/tcp_ipv6.c:582)
>   Read of size 8 at addr ffff88802b08b608 by task poc-ipv6-pktopt/5076
>
>   Call Trace:
>    <IRQ>
>    tcp_v6_send_synack (include/linux/skbuff.h:3152 include/linux/ipv6.h:110 net/ipv6/tcp_ipv6.c:582)
>    tcp_rtx_synack (net/ipv4/tcp_output.c:4719)
>    tcp_check_req (net/ipv4/tcp_minisocks.c:762)
>    tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1826)
>    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
>    ip6_input_finish (net/ipv6/ip6_input.c:534)
>    ip6_input (include/linux/netfilter.h:325 include/linux/netfilter.h:319 net/ipv6/ip6_input.c:545)
>    ipv6_rcv (include/net/dst.h:481 net/ipv6/ip6_input.c:119 include/linux/netfilter.h:325 include/linux/netfilter.h:319 net/ipv6/ip6_input.c:351)
>
>   Freed by task 5074 on cpu 0 at 15.412249s:
>    kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2780 mm/slub.c:6630 mm/slub.c:6757)
>    tcp_v6_syn_recv_sock (net/ipv6/tcp_ipv6.c:1528)
>    tcp_check_req (net/ipv4/tcp_minisocks.c:934)
>    tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1826)
>    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
>    ip6_input_finish (net/ipv6/ip6_input.c:534)
>
> Request socket migration has the same issue: reqsk_migrate_reset()
> transfers ireq->pktopts to the clone, which can be freed while
> another cpu holding a reference on the old request socket is still
> sending a SYNACK.
>
> The SYNACK timer itself is not an issue, because
> inet_csk_reqsk_queue_drop() calls timer_delete_sync().


Unlike v4, I don't think this part hold here:
tcp_v6_syn_recv_sock() consumes pktopts before inet_csk_complete_hashdance() calls timer_delete_sync()


> Save the flowlabel of the SYN in the request socket instead, so that
> tcp_v6_send_synack() no longer needs ireq->pktopts.
>
> As a side effect, the flowlabel is also reflected for SYN packets
> reusing a TIME_WAIT socket, as ireq->pktopts is not set in this case.
>
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
> Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
> Reported-by: Yingjie Wang <x-professor@outlook.com>
> Closes: https://lore.kernel.org/netdev/82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
> Initially reported to security@ mailing list by Anvik Loitongbam, with a patch.
> Anvik Loitongbam provided a reproducer.
> I was able to trigger the ASAN warning before the patch, and checked
> the warning can no longer trigger.
>
> Yingjie Wang also sent a public patch later, very similar to Anvik's one.

I was just looking at that patch...


I think that misses the syncookie path:

tcp_v6_do_rcv
    // skb is final ack
    cookie_v6_check
       // inc ref
       refcount_inc(&skb->users);
       ireq->pktopts = skb;
       tcp_get_cookie_sock
         tcp_v6_syn_recv_sock    <== consume_skb() removed, and ireq->pktopts still point to the ACK


Then the same ACK is delivered to the child
tcp_v6_do_rcv
   tcp_v6_cookie_check
   tcp_child_process
     tcp_data_queue
        __kfree_skb(skb)       <== frees it regardless of skb->users

req->pktopts is now dangling, and tcp_v6_reqsk_destructor() will
consume_skb() it later at accept() time.


