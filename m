Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693487;
	b=nZNFtxqsv8o8vomEBTWfTNgTVlgtAKzFLbE/p9sHK0NKGwXks7xVKvGC4aJTKhQUsUgz
	 pQzSbdIOAUMToFvB693V71aCraslbb2+tVapHBT9ogOLef4VJHhlS2GOmv7xAprdwDR57
	 Apvn7XmGBshTf+QLa586HN+IS0+YOJzb6OJVLVNURx0NG3Ol4rk/YbY8W7S5ogkPRFYqK
	 JmyAwASo6i6rzWTOnMAgFzI3Jwg8xnocR7metBNjnLloikc1O2HOVGxv/o9ssWfWSGW9E
	 EYaVsj6DbdZe85ozwSxLzBql8PsNU3wyV716Y3Vnf2y8fCs0cOYQ5aDQl6TozCKo1OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693487;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Date:From:To:CC:Subject:Message-ID:Reply-To:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 Precedence:Priority:Organization:X-ClientProxiedBy;
	bh=zT0f4PvbCr4r5VS4Oh1OUE+0x2bvV57yfBEnSmJkkf0=;
	b=c1xkqwNmgqdAfx+e30rLQJtX1cTrktnxyGFiun7Yx/YLXBxFq7VzrGfjcmds5CmzRWWT
	 S458XA9cfBw4U+QV0m2J35hV4uJ5szwSs6lX7kMSjfpcNdBf/pkUE+j4CGrmR3Ws5agMb
	 Jt9V3BxLh/Hln/zFkoOmP/tn46MLUEO1FQ8ykKw6KkKWcxZh4q1BiuXzv4ibolbJKOdOz
	 FpzUVopVOjmMlcbvOuTp2iDA+g2KjWEpq969/KafgK55DHEPeHwgfayqS20pb7PGgiMGh
	 YXQKn5uP80p54rNAaT0+mhe5d4woYMGd0RKTAkk3zhmPxx5F6XM7LhXIxSB3STS/rBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=LrABKWx3;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF7606A32D;
	Tue,  3 Nov 2026 08:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7BF7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=LrABKWx3
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 960D92074F;
	Tue,  3 Nov 2026 09:11:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wUIxuHlB8fHK; Tue,  3 Nov 2026 09:11:17 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 59D2F20754;
	Tue,  3 Nov 2026 09:11:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 59D2F20754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793693477;
	bh=zT0f4PvbCr4r5VS4Oh1OUE+0x2bvV57yfBEnSmJkkf0=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=LrABKWx33jr4cPA+a747TfoyaEQuGM93Xvd8cFXkwHhcOihUrFBP26hU/iTZEyQRL
	 iy+HjgwjPu2PCYxCeQMmnxAoAZukP9Ubns5KuLneuKoIMZvFE0pwENzp0zG8p5bPUv
	 S4zPLZW5qG4UT++Xez4aNaXPXwWRWWtDFghjZn0X+FS05ZzGr0KQswuLHpyBilp6c3
	 gBkVwX69lwI4JzEe9GHTZRAgvyn0HD7fPcuv/WOXu+Bsr/+ZJCOZBI2fDRH2L4oHk+
	 /C8mmfQruM+cQ4lzEXTVmY+OXKm+qS6FTD0Gm340ps+YuHOBdyE/TZBRf+LP3M/n5g
	 fRCrXILhBllwQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 3 Nov
 2026 09:11:16 +0100
Date: Tue, 3 Nov 2026 09:11:05 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Cen Zhang <zzzccc427@gmail.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<baijiaju1990@gmail.com>, <jjzuming@gmail.com>
Subject: Re: [PATCH ipsec v2 2/2] xfrm: use cached offload ifindex when
 migrating an SA
Message-ID: <aumXGU60BHG30DEm@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-0@gmail.com>
 <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-2@gmail.com>
 <aumUwuVWsOOQdMG-@moon.secunet.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aumUwuVWsOOQdMG-@moon.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

On Tue, Nov 03, 2026 at 09:01:14 +0100, Antony Antony wrote:
> On Sat, Oct 31, 2026 at 11:28:49 +0800, Cen Zhang wrote:
> > An xfrm_state reference keeps its offload record alive, but does not
> > prevent xfrm_dev_state_free() from clearing xso.dev and dropping the
> > device reference. xfrm_do_migrate_state() checks xso.dev before
> > xso_to_xuo() dereferences it to obtain the offload ifindex.
> > 
> > With XFRM offload and migration enabled, XFRM_MSG_MIGRATE_STATE inherits
> > the old SA's offload configuration if the request omits
> > XFRMA_OFFLOAD_DEV and does not set XFRM_MIGRATE_STATE_CLEAR_OFFLOAD.
> > Device unregister can flush that SA between the check and the read.
> > The supplied report used a scheduling probe to delay migration in this
> > interval while in-tree netdevsim was removed through sysfs.
> > 
> >     Migration (xfrm_cfg_mutex)       Device unregister (RTNL)
> >     xfrm_state_lookup(): hold x
> >     test x->xso.dev != NULL
> >                                     xfrm_dev_state_flush()
> >                                       xfrm_state_delete(x)
> >                                       xfrm_dev_state_free(x)
> >                                         xso->dev = NULL
> >                                         netdev_put(dev)
> >     xso_to_xuo(&x->xso, &xuo)
> >       xso->dev->ifindex: NULL deref
> > 
> > The netlink configuration mutex does not serialize with the notifier,
> > and migration takes the state lock only after this read. The result is
> > a NULL pointer dereference even though migration still holds the SA.
> > 
> > Use the ifindex cached in the offload record at attachment, as state
> > dumps already do. The SA reference protects this snapshot throughout
> > the read, so serialization no longer depends on the device lifetime.
> > Annotate the binding check with READ_ONCE() to match the concurrent
> > WRITE_ONCE() in xfrm_dev_state_free().
> > 
> > Oops report as below:
> > 
> >     Oops: general protection fault, probably for non-canonical address
> >     0xdffffc000000001c: 0000 [#1] SMP KASAN NOPTI
> >     KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
> >     RIP: 0010:xfrm_do_migrate_state+0x1f06/0x2c50
> >     Call Trace:
> >      <TASK>
> >      xfrm_user_rcv_msg+0x3b3/0xc20
> >      netlink_rcv_skb+0x133/0x390
> >      xfrm_netlink_rcv+0x76/0x90
> >      netlink_unicast+0x504/0x840
> >      netlink_sendmsg+0x7f7/0xcf0
> >      __sys_sendto+0x425/0x470
> >      __x64_sys_sendto+0xe5/0x1c0
> >      do_syscall_64+0x115/0x6a0
> >      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >      </TASK>
> > 
> > Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> 
> Reviewed-by: Antony Antony <antony.antony@secunet.com>

I forgot to mention another thought. If you send a new version may 
be remove xso_to_xuo(), and directly call 
xso_to_xuo_ifindex(xso, READ_ONCE(xso->ifindex), xuo); ?
