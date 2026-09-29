Received: from mta1.migadu.com (out-244.mta1.migadu.com [95.215.58.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876064AEEF
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660351; cv=none; b=domNXiaCwswQ51KAvEFkSl+VtrP6A3BSBE60Gi6hRG3MrBcyzd7pvjL/eUMJ+GL9EBybrJQIits5sO9j8URuYnF1+EBpN+Okpn5VozLQYRAr29M8IAe4IWeukWM2GuDMIjDRTs7S2ZqJhhT5xpmXoszgn1UW1AxaH4ZcH8unM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660351; c=relaxed/simple;
	bh=y5ovlXJVaSOvb+pxH+S+lOfJKqZySdVR+G72WrcnNP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHAEWkbrgEvNbEfLNJ3QmjQF+7Un4p6BzsGw+DIeqCIWQjppdShz1xyR+Qe9uW9ycOuQGDhk5SJI1GqrtZFyWeHNBjDCHP5DbWA8mNJbBycVT2lDDvjcgooIAUw9/ayzgMpatbuTJvnhdOLt2o7quDw7LOI3D2zuJIx+Z8rA66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bvm9XAEe; arc=none smtp.client-ip=95.215.58.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bvm9XAEe"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y5ovlXJVaSOvb+pxH+S+lOfJKqZySdVR+G72WrcnNP4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790660346; v=1; x=1791265146;
 b=Bvm9XAEeZTSDEqvA2I9hnizt+++kp+grvzY4oV0L/HfnJD52AUOyMddyHMkIo6R1Am9561b8
 pc6jKMVAIeaxjYTvQ2QPdsANwsKZDRDJ+Y0OTvWKYLGOgCgUG/BaRSa6VqauN1Am/jiPKCrESY8
 +yXQLU0KvGp0Y+HjdPRfQwss=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 50b0b3738406d612;
	Tue, 29 Sep 2026 05:39:06 +0000
X-Mizu-Trace-ID: 50b0b3738406d612
X-Migadu-Flow: FLOW_OUT
Message-ID: <ee827cf4-f773-4fdb-800c-e9c86e595405@linux.dev>
Date: Tue, 29 Sep 2026 13:38:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: sr: use skb_get_hash_net() in
 seg6_make_flowlabel()
To: Eric Dumazet <edumazet@kernel.org>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 edumazet@google.com, syzbot+9408fbe0e6452a12e9ab@syzkaller.appspotmail.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260928194524.3617299-1-edumazet@kernel.org>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260928194524.3617299-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/9/29 at 03:45 Eric Dumazet wrote:
> Since commit d58e468b1112 ("flow_dissector: implements flow dissector
> BPF hook") __skb_flow_dissect() needs a net pointer, either from
> skb->dev, skb->sk, or since commit 3cbf4ffba5ee ("net: plumb network
> namespace into __skb_flow_dissect") a caller provided pointer.
> 
> syzbot was able to reach seg6_make_flowlabel() with an skb having
> neither skb->dev nor skb->sk set: a TIPC UDP bearer sends a discovery
> message through an IPv4 route using seg6 encap, while
> net.ipv6.seg6_flowlabel is set to 1.
> 
> seg6_make_flowlabel() already has a net pointer, use skb_get_hash_net().
> 
> WARNING: net/core/flow_dissector.c:1131 at __skb_flow_dissect+0x910/0x5368 net/core/flow_dissector.c:1126, CPU#0: syz.0.17/4930
> Call trace:
>    __skb_flow_dissect+0x910/0x5368 net/core/flow_dissector.c:1126 (P)
>    __skb_get_hash_net+0xe0/0x29c net/core/flow_dissector.c:1903
>    skb_get_hash include/linux/skbuff.h:1663 [inline]
>    seg6_make_flowlabel+0xcc/0x1ec net/ipv6/seg6_iptunnel.c:132
>    __seg6_do_srh_encap+0x320/0xbf4 net/ipv6/seg6_iptunnel.c:161
>    seg6_do_srh+0x4b4/0xa44 net/ipv6/seg6_iptunnel.c:431
>    seg6_output_core+0x164/0x688 net/ipv6/seg6_iptunnel.c:681
>    seg6_output+0x44/0x1ac net/ipv6/seg6_iptunnel.c:744
>    lwtunnel_output+0x3d0/0x664 net/core/lwtunnel.c:356
>    dst_output include/net/dst.h:470 [inline]
>    ip_local_out+0x110/0x148 net/ipv4/ip_output.c:131
>    iptunnel_xmit+0x50c/0xd38 net/ipv4/ip_tunnel_core.c:97
>    udp_tunnel_xmit_skb+0x220/0x348 net/ipv4/udp_tunnel_core.c:187
>    tipc_udp_xmit+0x75c/0x9c0 net/tipc/udp_media.c:202
>    tipc_udp_send_msg+0x214/0x374 net/tipc/udp_media.c:274
>    tipc_bearer_xmit_skb+0x260/0x3b0 net/tipc/bearer.c:576
>    tipc_enable_bearer net/tipc/bearer.c:366 [inline]
>    __tipc_nl_bearer_enable+0xc90/0xfb0 net/tipc/bearer.c:1048
>    tipc_nl_bearer_enable+0x2c/0x48 net/tipc/bearer.c:1057
>    genl_family_rcv_msg_doit+0x1e4/0x2d4 net/netlink/genetlink.c:1114
> 
> Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
> Reported-by: syzbot+9408fbe0e6452a12e9ab@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6abac2eb.3654fce1.1bec97.0000.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang

