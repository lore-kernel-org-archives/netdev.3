Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9D72C11E7
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297685; cv=none; b=QtFrXAbxzjh+nMkOyg3CU/TBXGbNir8oCbGpC3PNEhkEZCr9Vkv0/Ph3/EJL1g2x/oHOxICJ90EJMHaHxjhwYwErTXJYsfbrXEQzJn3UE/bEiThjAyOkC0FEupDjWLUAD14RhnKdWmG5hgG61E13EViY4j5fSkkSWPNmb75PlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297685; c=relaxed/simple;
	bh=c9qMwmCt/iy2GnXvOyHjy8P1f1SEsB0yA2ABh3fEVQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYtKNYKU/q38asvRqb2207djWcwUUjQts7cnPW9XK67vopMcpaJw7MSxUsA8hWAuOITLXPFD2T4w8NcfqaFKOywqZ1tX54dCeTlIT77T4Ix3mfwSY2u0SGAcsZ7ADnVemCGMDzJcFG/d1vIvfDZeuTenvAr4VkwUUABtP8T6GbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s3JwpXA/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s3JwpXA/"
Message-ID: <95a719af-c9d3-4bce-995b-c6ffce15739c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782297681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncPNYn+/b9unbk/5AZNDdu13Zw0UIm2rwxmBuVx34B4=;
	b=s3JwpXA/x2whE6OsjbHvojTNqey8UL7QJoBCGQN+1df5w9hUHLL32gatIdFTK8TFIWrBgl
	fwfmLfD/PLpVIThZnoTerzlXmoji1gBHReJPh/hvctI8ZZs+lM84cGALgrqTChyL0xsbZ3
	c57ni2lAZHFFoI/ngRiDzlmme8RDBPk=
Date: Wed, 24 Jun 2026 18:41:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: clear transport header during tunnel
 decapsulation
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+d5d0d598a4cfdfafdc3b@syzkaller.appspotmail.com
References: <20260624073209.3703492-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260624073209.3703492-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/24/26 3:32 PM, Eric Dumazet wrote:
> Syzbot triggered a DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) assertion in
> pskb_may_pull_reason() called from qdisc_pkt_len_segs_init().
>
> The root cause is a stale, negative transport header offset carried over
> during tunnel decapsulation. When a tunnel receiver (e.g., VXLAN or Geneve)
> decapsulates a packet, it pulls the outer headers but leaves the transport
> header pointing to the outer UDP header. This offset becomes negative
> relative to the new skb->data (inner IP header).
>
> If the packet bypasses GRO (e.g., an untrusted GSO packet flagged as
> "unexpected GSO" by udp_unexpected_gso() due to missing tunnel GSO bits),
> it is flushed directly to the stack as GRO_NORMAL. On ingress, Layer 2 Qdisc
> processing (sch_handle_ingress) happens before Layer 3 IP reception
> (ip_rcv_core) can run and reset the transport header. Consequently,
> qdisc_pkt_len_segs_init() attempts to validate the transport header using
> pskb_may_pull(skb, hdr_len + sizeof(tcphdr)). The negative hdr_len overflows
> the unsigned cast in pskb_may_pull(), triggering the assertion.
>
> Fix this by clearing the transport header to the ~0U sentinel value during
> decapsulation. This ensures that:
> 1) The ingress Qdisc safely skips validation via !skb_transport_header_was_set()
>     and returns early without warning.
> 2) The IP layer (ip_rcv_core) later correctly resets the transport header
>     to the inner L4 header offset.
>
> Introduce skb_unset_transport_header() helper and apply it in the main
> decapsulation paths:
> 1) __iptunnel_pull_header() (covering Geneve, GRE, IPIP, SIT, etc.)
> 2) vxlan_rcv() (covering VXLAN)
>
> This restores skb invariants at the decapsulation boundary without adding
> overhead to the Qdisc fast path.
>
> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> Reported-by: syzbot+d5d0d598a4cfdfafdc3b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a3b853b.52ae72c2.136ac7.000c.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Assisted-by: Gemini:gemini-3.1-pro


I think a negative skb_transport_offset() should break something else too,
so the Fixes tag looks wrong, but I couldn't find any actual breakage 
(luck, or I'm missing it).

Hope sashiko read this reply and confirm it....


