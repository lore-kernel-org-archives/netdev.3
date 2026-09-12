Received: from mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22085192D8A
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195119; cv=none; b=V70/AtRi9NaOP1nElwjGdKh7ctN/7CKOL5oE3yH/GN2zuyR44ZyO/oAyw0Uj3qsB6EXLhnGoJTrskm9ZulTH0CRGzK9EkHlyFDWRCewREiGcK/TrUgK0CpGKKT1X8sIqGZNK8LaPlqoD9yt+oxKVtOUJA11Qu1pHay+d/6UYX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195119; c=relaxed/simple;
	bh=eThVeK9Rdr8B+7Kk33ATnWZVWzlbeKK014LL59XzXs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/gPUyCufvYu1FKYqItmc4FNhxPbitN8i2VcXYJbpuIC0TaUdq/E2EjIgupGfR2T6a8GJL0nq8lliwAV1kc9qPoiOxM+r7oeRU3JrEHqaErOsanmI5znOoijeggxA0GHlfnYrHq/BSZqzaUi8sfxOOodKLtRNuLp3A99+/Y02iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=suv0M7TO; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="suv0M7TO"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eThVeK9Rdr8B+7Kk33ATnWZVWzlbeKK014LL59XzXs8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789195114; v=1; x=1789799914;
 b=suv0M7TOC7sXjytRA75omxo9p9U4ITfTzagF1DseuZ8SdvPg6T/WPEDpxbBKzDxhgnRrzDlU
 LQFuKs2lPTMXvADIvRU/B+gBfX8fZCt779SZYyVOzlC68yewAgyBmh+sYHaYykOIjn2ENnesToW
 ggjXq+VyT/katGzjjQqauOS4=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 55b0e02d6a79e046;
	Sat, 12 Sep 2026 06:38:24 +0000
X-Mizu-Trace-ID: 55b0e02d6a79e046
X-Migadu-Flow: FLOW_OUT
Message-ID: <a53a81cd-88b6-4db2-a0e6-ee3dccfeef42@linux.dev>
Date: Sat, 12 Sep 2026 14:38:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: skbuff: do not leave stale header offsets after
 pskb_carve()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com,
 Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260911114922.621937-1-edumazet@google.com>
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260911114922.621937-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/11 19:49, Eric Dumazet 写道:
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
> the first bytes of a packet and reallocate skb->head.
> 
> All the headers that were present before the operation are gone,
> but both functions call skb_headers_offset_update(skb, 0), which
> is a no-op : skb->mac_header, skb->network_header,
> skb->transport_header and skb->csum_start are left with their old
> values, now pointing into the freshly allocated (and possibly much
> smaller) skb->head.
> 
> For pskb_carve_inside_nonlinear() the result is a zombie skb with
> an empty linear part (skb->data == skb_tail_pointer(skb),
> skb_headlen(skb) == 0) but skb_mac_header_was_set() still true and
> skb->mac_header pointing far beyond skb_end_pointer(skb).
> 
Could you please clarify how the MAC pointer ends up beyond
skb_end_pointer() here? The carve helpers allocate based on the old
skb_end_offset(), and kmalloc_reserve() adds room for skb_shared_info,
so the new capacity shouldn't be smaller.

The dump shows mac=234 and end=384. I understand how the stale offset
causes skb_pull() on an empty linear area and triggers the BUG, but I
don't see how it ends up beyond the new end. Am I missing another
condition?

Thanks,
Xuanqiang

> The only user of pskb_extract() is rds_tcp_data_recv(), and the
> carved skb is queued on tinc->ti_skb_list. When the RDS incoming
> message is released, rds_tcp_inc_free() calls skb_queue_purge(),
> which frees the skbs with SKB_DROP_REASON_QUEUE_PURGE. This is
> visible from drop_monitor, which then tries to pull back to the
> (bogus) mac header :
> 
> skbuff: __skb_pull(len=234)
> skb len=6968 data_len=6968 headroom=0 headlen=0 tailroom=0
> end-tail=384 mac=(234,14) mac_len=14 net=(248,40) trans=288
> shinfo(txflags=0 nr_frags=1 gso(size=1428 type=16 segs=5))
> csum(0x100120 start=288 offset=16 ip_summed=3 complete_sw=0 valid=1 level=0)
> hash(0x7b446c6c sw=0 l4=1) proto=0x86dd pkttype=0 iif=60
> ------------[ cut here ]------------
> kernel BUG at ./include/linux/skbuff.h:2847!
> 
> Add skb_carve_reset_headers() to mark the mac and transport headers
> as not set, reset the network header, clear skb->mac_len, and drop
> a now meaningless CHECKSUM_PARTIAL (csum_start would point outside
> of the new buffer).
> 
> Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
> Reported-by: syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6aa3e9d3.f2639fcc.29487d.0028.GAE@google.com/
> Cc: Allison Henderson <achender@kernel.org>
> Cc: rds-devel@oss.oracle.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/core/skbuff.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index cc3b4b70288b4e3f17984cd4f4e4b7a330353e15..0e6637db6da201fe2640c244e1b0983fca39b918 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6832,6 +6832,23 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
>   }
>   EXPORT_SYMBOL(alloc_skb_with_frags);
>   
> +/* pskb_carve_inside_header() and pskb_carve_inside_nonlinear()
> + * remove the first bytes of a packet and reallocate skb->head.
> + *
> + * Whatever headers were present before the operation are gone,
> + * we must not leave stale offsets, otherwise users of this skb
> + * (skb_dump(), drop_monitor, taps, ...) would read or pull garbage.
> + */
> +static void skb_carve_reset_headers(struct sk_buff *skb)
> +{
> +	skb_unset_mac_header(skb);
> +	skb_unset_transport_header(skb);
> +	skb_reset_network_header(skb);
> +	skb->mac_len = 0;
> +	if (skb->ip_summed == CHECKSUM_PARTIAL)
> +		skb->ip_summed = CHECKSUM_NONE;
> +}
> +
>   /* carve out the first off bytes from skb when off < headlen */
>   static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
>   				    const int headlen, gfp_t gfp_mask)
> @@ -6887,7 +6904,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
>   	skb->head_frag = 0;
>   	skb_set_end_offset(skb, size);
>   	skb_set_tail_pointer(skb, skb_headlen(skb));
> -	skb_headers_offset_update(skb, 0);
> +	skb_carve_reset_headers(skb);
>   	skb->cloned = 0;
>   	skb->hdr_len = 0;
>   	skb->nohdr = 0;
> @@ -7027,7 +7044,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
>   	skb->data = data;
>   	skb_set_end_offset(skb, size);
>   	skb_reset_tail_pointer(skb);
> -	skb_headers_offset_update(skb, 0);
> +	skb_carve_reset_headers(skb);
>   	skb->cloned   = 0;
>   	skb->hdr_len  = 0;
>   	skb->nohdr    = 0;

