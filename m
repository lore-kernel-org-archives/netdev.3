Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E893749E2
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547967; cv=none; b=KdzM0M+nutuPBVy1Y0MoCXX393NNF06sjpuTv2lnbmCS9RNJ4yX/w/999sVsFjPu50/YSufWs3wPPp+CeikBH5l5T1L0rZXBB0w4F4B5w6DbzUxZMrMRw4/jGxEDqtZnvaWuznsyN4zQ7JzMA3rp0OtKq4nVMzefuNIfUrfJGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547967; c=relaxed/simple;
	bh=AhqI7pW+it6FV1TkASwktv44jY6Px+S8/cb9lTBTzBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivSkx6h2Rg9LuRbsuE+gH5LQrFE43LR2ItJyh2vPzvO00/Gn45kKuJ3VQQoPiVnwBtzTjfvFWDL76bpQ00NYMsAoAKcBsMRjnYztDqQ0/yQceoOFZSLVU6+BUBtnAQe9l/Jyw4z0rkXZM1t6XBK8qQeV3guXxCM3Ldid+oDfBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fxt2TtCF; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fxt2TtCF"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8D9502068C;
	Mon, 24 Aug 2026 07:06:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l4_Q1TsqYson; Mon, 24 Aug 2026 07:06:02 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9CB7B201D3;
	Mon, 24 Aug 2026 07:06:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9CB7B201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787547962;
	bh=FORdgh/hS8h6qfhTC6qZcIBhp5aiSyrvfVBVom34u64=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=fxt2TtCFi/sPXltazay0U8WyJhYKm221xc5NUvQgfuod9ufmyjFrR0t/yyvNCPjIL
	 O78kAhdiu/+EXq02IR7n1ficVILYpsfnqYi+4Irljx4yOOvICVEyxRIBoLzLDAVHNe
	 N9VaJAUqoQMmDAxLek+9d9+Zp3fkIeoZWwEKY0v78SlyLoSNdSZZlWvtUPwvyKjgQE
	 bSq29MhUJEe48ltZZqnRR6REsVy3h260mhWDxL4OFBQgGirOfQKsfz7W3KAPZ16PAm
	 rvljmNfnxYoOd/nUxSG+/XLkd5OoAdOvgRqM9Su4gu0gWwkrlCaCFKocLtGtOewq71
	 40n/kOHBPAXzA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 24 Aug
 2026 07:06:02 +0200
Received: (nullmailer pid 657225 invoked by uid 1000);
	Mon, 24 Aug 2026 05:06:01 -0000
Date: Mon, 24 Aug 2026 07:06:01 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	syzbot <syzkaller@googlegroups.com>, Liu Jian <liujian56@huawei.com>
Subject: Re: [PATCH net] xfrm: add missing rcu_read_lock(), skb_dst_force()
 and dev_hold() for xfrm_trans_reinject()
Message-ID: <aovROYy_X-SrDBpQ@secunet.com>
References: <20260807171533.1904697-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260807171533.1904697-1-edumazet@google.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Aug 07, 2026 at 05:15:33PM +0000, Eric Dumazet wrote:
> syzbot reported a suspicious RCU usage warning in ip6_pkt_drop():
> 
>   WARNING: suspicious RCU usage in ip6_pkt_drop
>   include/net/addrconf.h:389 suspicious rcu_dereference_check() usage!
> 
>   Call Trace:
>    __in6_dev_get_safely include/net/addrconf.h:389 [inline]
>    ip6_pkt_drop+0x596/0x610 net/ipv6/route.c:4620
>    ip6_pkt_discard+0x1c/0x30 net/ipv6/route.c:4651
>    xfrm_trans_reinject+0x324/0x630 net/xfrm/xfrm_input.c:806
>    process_one_work kernel/workqueue.c:3322 [inline]
>    process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
>    worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
> 
> When commit 4f4920669d21 ("xfrm: Reinject transport-mode packets through
> workqueue") converted xfrm_trans_reinject from a tasklet to a workqueue,
> the reinjection loop ceased running in softirq context. Workqueue workers
> run in process context where local_bh_disable() does not enter an RCU
> read-side critical section under CONFIG_PREEMPT_RCU.
> 
> Because finish callbacks (such as ip6_rcv_finish) expect to run under an
> RCU read lock (performing route lookups, l3mdev lookups, and accessing
> RCU-protected data structures), invoking them in workqueue context without
> rcu_read_lock() triggers RCU lockdep warnings.
> 
> Furthermore, packets queued to the workqueue via xfrm_trans_queue_net()
> may carry non-refcounted (noref) dst entries (e.g. from ip_route_input_noref).
> Additionally, on netdevice unregistration, dst_dev_put() replaces dst->dev
> with blackhole_netdev, so dst entries do not keep skb->dev alive while
> queued in the workqueue.
> 
> Fix these issues by:
> 1. Calling skb_dst_force(skb) in xfrm_trans_queue_net() while still in the
>    caller's RCU section to ensure dst is reference-counted before queuing.
> 2. Holding a reference on skb->dev via dev_hold()/dev_put() across workqueue
>    deferral so skb->dev remains valid during finish() callback processing.
> 3. Acquiring rcu_read_lock() around the finish callback invocation loop in
>    xfrm_trans_reinject().
> 
> Fixes: 4f4920669d21 ("xfrm: Reinject transport-mode packets through workqueue")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Liu Jian <liujian56@huawei.com>

Now applied to the ipsec tree, thanks a lot Eric!
