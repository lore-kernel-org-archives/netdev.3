Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776544;
	b=2tXvUSuMPJc7oyG6W2KUaSXA0T+zx37ARJUuwam9Ng9F/WcKitJP9y43Nfw/w8ttLm7r
	 ymBz4+u+naBPvHmU4iPtYDKxLKwT5I7GNnUutNz03CTIiV9YSswLBiHjyYYDQxlajcDL+
	 gF6dH6iB+POxpI2czQS98dJ5iZTBQxPfO15xn2hSQK2ZFyr0YfFPZtVTewjUrQk1646Yd
	 lamAtrG8Cj4cpC7QwSRoCXhWSkt3M94uVmQUaoXI4VA8Jy56djKBJeIVavcHIiEo7tCgo
	 8hric1c/Oug8DDecfSUUJ9S8lKhACuXyVTuOMh6aDI4KhwMPPu5W1FnRg6qc94jVwxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=BFV/VQ+QWjrP6E459iluHuys0SDd5TGNzyDmCdFINos=;
	b=22QEpW732DBYqKdrekwIUzhNToMDrV1HaE93e8Jp9o3DyrJObiEthWQ5vHYplYRwFIEf
	 /7VJqd6qQzS7P7GzpWehfqAk2YxQJJ4GRKQYpe8diiyUo3HVBQEohEWgNfxD9bwMo+mg5
	 WEUn4JokEaW5EZIekd32lgQLJ1yKG5Yr0VmV+B0doRDgeJbdfjN/9LSP8cXtllOhKs9nz
	 sDbY+4b51hq3bOHCNiIZCUXg+D+ITVm4RTvnlmr000VRQhrQ5yUvAnUofinqcCd50LWRC
	 NycSswHyZJN2gyPdtRYnmXe7LXaO8DkISWhXhOTMtSB4E5Mfk3MQSTIoCmBn4cWg9RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D6JnA8Xk;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58141606A32C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 07:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58141606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D6JnA8Xk
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b07b06027eso630583a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 23:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793776544; x=1794381344; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFV/VQ+QWjrP6E459iluHuys0SDd5TGNzyDmCdFINos=;
        b=D6JnA8Xkhg8aRFrKyK4hQsimDwPxja7zro9JWiX3TCSmx1gbBEUAa/b0LhiIKW6aYi
         L6PL2KSghI8axoIhqEQBdZ31GFpnlIyKhxojS2XRx1Xn6eZR7fXViSDF/woJXfem2tuI
         OI0VHDGjjltM1KyEEVtewpQipHRuaqtEdFTIeAZ0ECyBqJy0+99NrxQ1XaXAEK4zAK5Z
         IbhSkKAFyXFCJPENV+OT5/PnGKpODf10StSDR8AJFPhjsa73WM3PU1wF6L6vL9vAch4X
         +Us19PbHcP/hOIs1fnajNSc56jYOLqpg48AqUCYvdTQs9OFITg8TFdrPsI3JHmIkYvkv
         Nc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793776544; x=1794381344;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFV/VQ+QWjrP6E459iluHuys0SDd5TGNzyDmCdFINos=;
        b=aZMZPK5I584xSOuci8yXTRT9nVvbp/GTPa1x8LkAmSDjOkDFYCJ7NjI0YVGnmdjt8p
         h431yF2+uPYWp8x5yVbTCrdceQSSYmn3f1sY7bmP8qmJoZryYf9jR2fNG+9T0zV37voS
         9Icug02+UPfJc0fv4GWyYzqWg0rOMTKzFygdumPSqOLDvBehEwTY1V9miQJar2whUYFU
         A46KxA3Va2Lc3LSYjsEgTb7Yz3D9XUItTsHGtIH73QMGMqGdmwZwmLupPV28+628cOmq
         0NCnPEjrvyKlc0vAi1Pgs4MxI9lGUUKzghE7yOeS/wX49IX7Y4/OeNfhgKDnjUOT1apB
         zL4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwg6lPN+9SQWXrYca/VC5rmPaEBAaVME9zMapvMzZ/0KSHA7rEswEu/Mifl33fizqkTDo775so=@vger.kernel.org
X-Gm-Message-State: APuU4Z81C5mlrGq8i2gBPG2APioDJc0Zs/hzeTmwujtYBSbddjhplBj/
	EEQTHGsGEMuEQfv3/mlVzNxSAaQvzbyAP7Xipx3Pg2iV/W/O7ZKKaL+hM+Msg3eD/MD4hgB0Mqa
	0YMcR/g==
X-Received: from pjbtb5.prod.google.com ([2002:a17:90b:53c5:b0:3ab:b4c5:c343])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3194:b0:3b0:9781:ee8b
 with SMTP id 98e67ed59e1d1-3b097820c66mr817296a91.26.1793776543321; Tue, 03
 Nov 2026 23:15:43 -0800 (PST)
Date: Wed, 4 Nov 2026 07:15:42 +0000
In-Reply-To: <20261102075441.3771550-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102075441.3771550-1-edumazet@kernel.org>
Message-ID: <aurbl7JB_b0Ytysl@google.com>
Subject: Re: [PATCH net] tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Anvik Loitongbam <permissiontogallop@gmail.com>, Yingjie Wang <x-professor@outlook.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, 02 Nov 2026 08:54:41 +0100, Eric Dumazet wrote:
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
> 
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

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
