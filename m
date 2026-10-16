Received: from sender-op-o7.zohocloud.ca (sender-op-o7.zohocloud.ca [199.67.87.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2264F85B7
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=199.67.87.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169693; cv=pass; b=XU20d+3x3B5kkWXR9qGxEd2H/DT6pDW0EZj2Y/vp4qDgaa726NsinwFDkYo74TZUxynbWVTvN8Ep3FzP7nOPKR35ueXpBJpxsjYPwNRZUT4j8C2id4FeWtJITzamS16VvRn6Gi6OJ74GGaNRAMr7JgJy6K/qhFCYMEun+jO6Auk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169693; c=relaxed/simple;
	bh=kTayI7LwuIEDvDgixD0K8j3ha14UfHQapmMWNDkh/5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYXP//sy6fHVc5n8KEC/CEvRZWu5147OJUEtMsKwRuj3jqWSUilHGB9FlCob0NdjqKFFgIqR7kDMb/IAarwRW+MtFg5KN2Zm/KNdxyeQGbSX6XLLX4ONaL09UzmHMr3Mj1efYPW2dQfDkPGOMi7wFggGtb40IvA01RSylgCpjks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chasehil.tz; spf=pass smtp.mailfrom=chasehil.tz; dkim=pass (1024-bit key) header.d=chasehil.tz header.i=@chasehil.tz header.b=SsLxiir8; arc=pass smtp.client-ip=199.67.87.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chasehil.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chasehil.tz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chasehil.tz header.i=@chasehil.tz header.b="SsLxiir8"
ARC-Seal: i=1; a=rsa-sha256; t=1792169668; cv=none; 
	d=zohomailcloud.ca; s=zohoarc; 
	b=V3wwxp5bkolg+Fj8zazzRhQu2smYFzvGDj09IYMT3zslRhP24ByRYDE80JOJbJGQuxX3TVNgO3PbRT8NCPSr/I6zFSGnNx8X2lvMlnMSvSD8BTVTkAfAHY9GmMXx8FcyF47LXsN1aKTDmGegzDXHuLU/5JiJd5bBozt7LzrRw8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomailcloud.ca; s=zohoarc; 
	t=1792169668; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hhSrfTTll5Ub10UtJCM54/HOryqKjca9wP4JRMPpmKY=; 
	b=i26gt1pEmUNNcGd4+0dqhn833o6KlgMHzrE1EiaCS+QtHhpQmRdij7aavXkN4Ojm6sOiCCwyixRG8b6+CiuH37cZf/FqvLV9NFjVF21wzAwh52eFtzuvwl0y4BMiyE1uNNJ3cw6OnU+N+MNf3F0qmNMxCWPZQCOGfghU2c6eokQ=
ARC-Authentication-Results: i=1; mx.zohomailcloud.ca;
	dkim=pass  header.i=chasehil.tz;
	spf=pass  smtp.mailfrom=me@chasehil.tz;
	dmarc=pass header.from=<me@chasehil.tz>
DKIM-Signature: a=rsa-sha256; b=SsLxiir8IAC8x2XQSQbpAP3bjqnXgCA5RUdjgAkwkO+81sN6I/U874igeU1wmiQSluW0HMsvP4+c4BDdOq7mGmyTJttCIEJ5VsaDc3LE5uWxsDXXCOWmm6PPssifMFYkc2XhzW0XGt348afHjXGMkmVZkpErOAa8JEnOjjRnjvo=; c=relaxed/relaxed; s=zmail; d=chasehil.tz; v=1; bh=hhSrfTTll5Ub10UtJCM54/HOryqKjca9wP4JRMPpmKY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohocloud.ca with SMTPS id 1792169665694170.7247955204707;
	Fri, 16 Oct 2026 12:54:25 -0400 (EDT)
Message-ID: <180dae0e-6bd5-476c-a12c-619fa1b21f96@chasehil.tz>
Date: Fri, 16 Oct 2026 13:54:24 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: gro: don't chain linear parts larger than
 gso_size into frag_list
To: Sorah Fukumori <her@sorah.jp>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, willemb@google.com, lixiaoyan@google.com,
 linux-kernel@vger.kernel.org
References: <20261013130250.3643916-1-her@sorah.jp>
Content-Language: en-US
From: Chase Hiltz <me@chasehil.tz>
In-Reply-To: <20261013130250.3643916-1-her@sorah.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 2026-10-13 10:02, Sorah Fukumori wrote:
> skb_gro_receive() chains an skb into the frag_list of the held packet
> when its payload cannot be attached as page frags: when its head is
> not a page fragment and still holds payload, or when its head and
> frags would overflow the frags[] array of the last packet. Since commit
> 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack"), that
> skb may itself be a GSO packet whose linear part holds several
> gso_size segments. skb_segment() cannot split the linear part of a
> frag_list member across segments, so segmenting the aggregate in
> software, e.g. when forwarding it to a device without NETIF_F_FRAGLIST,
> hits
> 
>    BUG_ON(skb_headlen(list_skb) > len);
> 
> Fully linear GSO packets come from generic XDP. When the program does
> not support frags, netif_skb_check_for_xdp() linearizes any nonlinear
> skb with pskb_expand_head() and skb_linearize() and keeps its GSO
> metadata. GRO on the device runs before generic XDP, so each aggregate
> passed by the program carries all of its payload in a kmalloc'ed head.
> A tunnel that decapsulates these packets and runs GRO again through
> gro_cells then builds the bad frag_list. This was first seen on a
> router that forwards TCP received over VXLAN, with a non-frags XDP
> program attached in SKB mode to the underlying bond because one slave
> lacks native XDP:
> 
>    kernel BUG at net/core/skbuff.c:4917!
>    RIP: 0010:skb_segment+0xbb6/0xf40
>    Call Trace:
>     tcp_gso_segment
>     ipv6_gso_segment
>     skb_mac_gso_segment
>     __skb_gso_segment
>     validate_xmit_skb
>     __dev_queue_xmit
>     ip6_output
>     ip6_sublist_rcv_finish
>     ipv6_list_rcv
>     netif_receive_skb_list_internal
>     gro_complete
>     dev_gro_receive
>     gro_receive_skb
>     gro_cell_poll
>     __napi_poll
>     net_rx_action
> 
> It reproduces with three network namespaces: TCP sent over VXLAN on an
> IPv6 veth link to a router namespace that has an XDP_PASS program
> without frags support attached to the underlay veth in generic mode
> and GRO enabled on its VXLAN device, and forwards to a veth with
> tx-scatter-gather-fraglist disabled.
> 
> A program with frags support in generic mode gives similar packets.
> skb_pp_cow_data() rebuilds the skb with up to about a page of linear
> data in a page_pool head_frag and keeps the GSO metadata, so once
> frags[] is full the next such packet is chained through frag_list
> with more than gso_size bytes in its head as well.
> 
> Refuse the merge when the linear part to be chained exceeds the held
> packet's gso_size. tcp_gro_receive() then flushes the held packet and
> the skb starts a new GRO packet as its head, whose linear length
> skb_segment() handles.
> 
> Fixes: 5eddb24901ee ("gro: add support of (hw)gro packets to gro stack")
> Cc: stable@vger.kernel.org
> Assisted-by: claude-opus-5-5
> Signed-off-by: Sorah Fukumori <her@sorah.jp>
> ---
> 
> Notes:
>      v2:
>        - Mention the head_frag path that reaches merge: once frags[] is
>          full, e.g. after a frags-capable generic XDP program (Eric Dumazet)
>      v1: https://lore.kernel.org/netdev/20261013102453.3272620-1-her@sorah.jp/
>      
>      Testing, on net b7ad72414c67 in qemu/KVM (x86_64_defconfig plus
>      VETH/VXLAN/BPF_SYSCALL built in), using the reproducer described above
>      with iperf3 -P 4 for 20s:
>        - without this patch: BUG in skb_segment() within ~3s in 4/4 runs
>        - with this patch: 8/8 runs completed without a splat
>      The same reproducer also hits the BUG on Ubuntu 7.0.0-38-generic and
>      on v7.3-rc3. W=1 build of net/core/gro.o under allmodconfig adds no
>      warnings. Full allyesconfig/allmodconfig builds and the net selftests
>      were not run, and no selftest is included.
>      
>      The frags variant did not crash an unpatched kernel in the same
>      reproducer with an xdp.frags XDP_PASS program, also with RPS on the
>      underlay, gro_max_size 196608 or sender gso_max_size 8000-20000: GRO
>      batches there are too short to fill frags[]. A kprobe on
>      skb_gro_receive() shows the 64K page_pool skbs carrying about 3.4K of
>      payload in the head, and the non-frags variant returning -E2BIG from
>      the new check about 4000 times per 20s run.
>      
>      The crash analysis, reproducer and fix were developed with an AI
>      coding assistant (Claude); I reviewed the change and the analysis.
> 
>   net/core/gro.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 29b4d02bf519..ff828a3dce3c 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -187,6 +187,10 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>   	}
>   
>   merge:
> +	/* skb_segment() cannot split the linear part of a frag_list member. */
> +	if (unlikely(headlen > offset + skb_shinfo(p)->gso_size))
> +		return -E2BIG;
> +
>   	/* sk ownership - if any - completely transferred to the aggregated packet */
>   	skb->destructor = NULL;
>   	skb->sk = NULL;
> 
> base-commit: b7ad72414c673ce1fa1f463e807cd4f34f8be9bf

Tested-by: Chase Hiltz <me@chasehil.tz>

I encountered and reproduced the same bug independently on Ubuntu 26.04 running 
the upstream v7.2.6 kernel. Applying the patch on top of v7.2.6 results in the 
crash no longer happening for me.
