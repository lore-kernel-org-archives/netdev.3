Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147437E5D9
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481911; cv=none; b=LQvwj/O7hIeJ584ymAUul8oHvaWvnOEl+/hoUMgXUmsXKkWvnDjB9GAXhpKhTiEgXK1sJsuR1U81NFdnE+rUEPhcyw3Get9aKpWnLwUFiyxdOyf845e21jSEEgppprNyoJsGQUxtqIE2h8ll8hMwyTY81U+XryGm9JJu2BTR7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481911; c=relaxed/simple;
	bh=2Lqjp4IoAhzle7E3CpAhovq77AyB43q81NO2ydbPQ9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgZgkuDEeG6qOmWCX6258I+WIVu5/hUqo66Y4oqNaWLf8nK6HYhDLynh26czXqnwqu23Ql2CkhDdR3tX1dbtq1JWXCCDbirOzxuLVv/NG26wI+lrQI8X4trqxtouR4PqGlctVn2sj+FfeSql5geEqsfDeaMSX7WXdaARHSuhhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=blU+Zjac; arc=none smtp.client-ip=91.218.175.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="blU+Zjac"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2Lqjp4IoAhzle7E3CpAhovq77AyB43q81NO2ydbPQ9Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789481907; v=1; x=1790086707;
 b=blU+ZjacrBZGsBP/dv5+8plfCZnlQkPYERY515jfmoZXwHN5DBfX/IE4WIGHHevC0EKjvRdT
 3Gefn6tZiY6eVNG2Oku9vbKtFQ3ScKMjn33q+fPQZAEMh6XHVMD7oLQPSCBtihg9uOf91/LuI0C
 lSCuBhvrTa5h/D8QEzRP8l24=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 69b62876a93fe4af;
	Tue, 15 Sep 2026 14:18:27 +0000
X-Mizu-Trace-ID: 69b62876a93fe4af
X-Migadu-Flow: FLOW_OUT
Message-ID: <779472d4-fc73-412f-bae1-d3fb9aa653f8@linux.dev>
Date: Tue, 15 Sep 2026 22:18:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: skbuff: do not leave stale header offsets
 after pskb_carve()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com,
 Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260915130423.3956471-1-edumazet@google.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260915130423.3956471-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/15 21:04, Eric Dumazet 写道:
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
> the first bytes of a packet and reallocate skb->head.
> 
> All the headers that were present before the operation are gone,
> but both functions call skb_headers_offset_update(skb, 0), which
> is a no-op : skb->mac_header, skb->network_header,
> skb->transport_header and skb->csum_start keep their old values and
> now describe bytes which are no longer there.
> 
> Both helpers size the new head from the old skb_end_offset(), so the
> stale offsets still land inside the new allocation. They point past
> skb_tail_pointer() though, to bytes that were never initialized.
> 
> pskb_carve_inside_nonlinear() is the worst case, because it leaves a
> zombie skb with an empty linear part (skb->data ==
> skb_tail_pointer(skb), skb_headlen(skb) == 0), while
> skb_mac_header_was_set() is still true and skb->mac_header is way
> ahead of skb->data.
> 
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
> a now meaningless CHECKSUM_PARTIAL (csum_start no longer describes
> anything).
> 
> Invalidate the inner offsets as well. Unlike mac_header and
> transport_header they have no "unset" sentinel, so a leftover
> non-zero value still looks like a real header. Zero
> skb->inner_mac_header, skb->inner_network_header,
> skb->inner_transport_header, skb->inner_protocol and
> skb->encapsulation, so that all the header state is invalidated in
> one place.
> 
> v2: fixed an inaccurate changelog. The stale offsets stay inside the
>      new skb->head, which is never smaller than the old one, they
>      simply point past skb_tail_pointer() to bytes that are gone.
>      Thanks to Xuanqiang Luo for insisting on this.
>      Also invalidate the inner header state, as suggested by the
>      netdev AI review :
>      https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260911114922.621937-1-edumazet%40google.com
> 
> Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
> Reported-by: syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6aa3e9d3.f2639fcc.29487d.0028.GAE@google.com/
> Cc: Xuanqiang Luo <xuanqiang.luo@linux.dev>
> Cc: Allison Henderson <achender@kernel.org>
> Cc: rds-devel@oss.oracle.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks!
