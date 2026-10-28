Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198653;
	b=VvNkHu0gBK1lBjAgC418Q6H6/kVqfKGKNMx6+g7vamN2HSoDc/YTA+JUc3pAX884E9Z3
	 yJz4M2bVzHDemXKaDjwO44YrHlqG+t9T0pOwe2nFJ2IrIpxv10sioCfQT8V82KyDPHcZR
	 +e1rWB7qeAET0yBlpuKaKj4Z0WbE2BjTE0lUFr1uRlnzfpuuadP7A0HyfeNku/hXNcobr
	 OlAO4UGFCqBonoUvJLT8+YWCOuZzw4z6RhYn07B0LIyyoySupuLJaNkY8JP3BezL8ae5z
	 INvWrXsVuFCYuNsm7tRYmYPkeGM0WQedCkUZ3wVL9Vm/+6w7A3jKtSRqQjMnTdpm8cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198653;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1Q63vKXI7sX2+wwKEnsnoKjs6AlzUnkR62wP2YbR8PI=;
	b=3FQfvlYE0sKSoLCkQFx+SsW3VpsmJirUJvb4f7SKHrmPHmInxnAL7iDKSKvH0DeuwBl1
	 vax4SKono0hJ42Llm+jx+8Sh362fIoNd4w2GJJ/I3EC916LVxrawwgoAFiAlkOhOJ1jy5
	 BWh6t6wms26VyUFfp/jTA/1NNvm/MuRpAgucxZRHuYCwLkuED6NL1yFlWf5w3yVbUcpSv
	 43kfm+kt9221uXp5bfqO3cn1XriA1oVIplEKBdlaB1iwepkL4KbkuJ8W8Rd3u+wkZ7/X/
	 8UdqkPN7a0DCuwGOvDHei4A6FnPjKAfozH9y7/gSqEeDF2gzJysts14Dq9kqI5iLWsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGb5aMol;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B705606A31E;
	Wed, 28 Oct 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGb5aMol
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F50F1F01825;
	Wed, 28 Oct 2026 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793198652;
	bh=1Q63vKXI7sX2+wwKEnsnoKjs6AlzUnkR62wP2YbR8PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NGb5aMoljz5/21SSjR4odbTS26vwx/CGKuiRCOIeiUV4PASm6HyPxqlwerkkE1MH3
	 Y5YRwMYHUWqExx45xZAZYQZcxpfUDr0IHHIWhUE1yEHd5wfl0yao4lvoXpJZt0SV9s
	 xUewWoh/TQAG/AgtMd4kkX5J7jOi4DkmW9KM4t0PLUzuHOCK47gYnep3+m7uLTxU0B
	 rM+zptalztzrW4Tqxbc6LOXQ2zW2JusZZu657UZtlWQzUW+0Gh3KEz5FNrlxq3w2a3
	 zDlLs7AT1D5WC+kYIjdjEFKRwHtmzHXbAAybbva4ZoS+8P1mb5L6YFDJmBnuCggSsY
	 mj/zlUAgUgJdQ==
Date: Wed, 28 Oct 2026 14:44:08 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	linux-ppp@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Felix Fietkau <nbd@nbd.name>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH v2 net] ppp: linearize and segment bridged packets when
 required
Message-ID: <20261028144408.GX257209@horms.kernel.org>
References: <20261026155927.707655-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026155927.707655-1-edumazet@kernel.org>

On Mon, Oct 26, 2026 at 04:59:27PM +0100, Eric Dumazet wrote:
> PPP channel bridging hands packets received on one channel directly to
> the start_xmit() of another. Packets received by PPPoE can be
> non-linear, GSO since commit 55a5d8fca836 ("net: pppoe: implement
> GRO/GSO support"), or CHECKSUM_PARTIAL when injected with a
> virtio_net_hdr. The regular transmit path never sees such packets, and
> only PPPoE, which uses dev_queue_xmit(), handles them:
> 
> - PPP Async reads the whole packet through skb->data, transmitting
>   unrelated memory for non-linear packets.
> - PPP Async and Sync send GSO packets as single frames of up to 64KB,
>   and CHECKSUM_PARTIAL packets with a bad L4 checksum.
> - PPTP and L2TP cannot segment a TCP GSO packet once their GRE or UDP
>   header is pushed, and do not finish pending checksums.
> 
> Add a xmit_offload flag to struct ppp_channel, set for PPPoE. For other
> channels, segment GSO packets in software, using the PPP protocol field
> as the L2 header, finish CHECKSUM_PARTIAL checksums (including SCTP
> CRC32c), and linearize packets for channels without direct_xmit, as
> ppp_push() does. Packets are dropped if any step fails, or if the
> channel is busy, as before.
> 
> skb->dev is NULL at this point for PPPoE (cleared by __sk_receive_skb()),
> and tunnel and IPv6 UFO GSO handlers dereference it: only TCP, UDP L4
> and fraglist GSO packets without encapsulation are segmented, others
> are dropped.
> 
> Receive paths like L2TP pull headers without updating the checksum
> state, possibly leaving a CHECKSUM_PARTIAL state with csum_start before
> skb->data. Reset it to CHECKSUM_NONE, as skb_postpull_rcsum() does, so
> that skb_checksum_help() does not warn, and so that PPPoE does not
> offload a checksum at a wrong offset.
> 
> Tested in a VM by bridging PPPoE (on a TAP with IFF_NAPI_FRAGS, or on
> veth) to PPP Async on a PTY, PPPoL2TP and PPPoE: non-linear packets no
> longer leak garbage, GSO packets (including fraglist GRO) are sent as
> valid segments for IPv4 and IPv6, CHECKSUM_PARTIAL packets get a valid
> checksum, and PPPoE still receives GSO packets unchanged.
> 
> Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls")
> Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260908072135.877364-1-qingfang.deng@linux.dev
> Co-developed-by: Qingfang Deng <qingfang.deng@linux.dev>
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Felix Fietkau <nbd@nbd.name>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> v2: addressed Sashiko feedback
>  - Only segment TCP, UDP_L4 and fraglist GSO skbs without encapsulation,
>    skb->dev is NULL here.
>  - Reset stale CHECKSUM_PARTIAL state with csum_start before skb->data.
>  - Use skb_csum_hwoffload_help(skb, 0) to handle SCTP CRC32c.
> v1: https://lore.kernel.org/netdev/20261022111039.85112-1-edumazet@kernel.org/

Reviewed-by: Simon Horman <horms@kernel.org>

