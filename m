Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692882;
	b=SHnOXT2j31FJISCwcpN9CC/le03nYG7NrqXs0hl51mWuTpww1YtSoFSvO25WCjk5h0TD
	 QbT7+OLbMdMHH1dBHz/NX5RfopTba1d2DoaQRH7EvcoIZj8M98yR9DuvIcVHR2keXufqG
	 E8qL1lVjzfuD9oWViugeJhm6AQWm275Y62coRSxCii+qNM90e6Hsokunn7/+d+O2lf/dS
	 w9vhM/n5FlbGyKH/izMABVqW8OrvVwT1bnYPiSpy+zjh8hPBBRL5LSc95FRpMcnJWepRX
	 iA0ogAbzjBYCVqZXRC4vWVjcS+4pGhgeqNaqt6dOCTi9QBHbXlxTqX3t4o53XWwOoYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692882;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Date:From:To:CC:Subject:Message-ID:Reply-To:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 Precedence:Priority:Organization:X-ClientProxiedBy;
	bh=AulrUU0VFXvSrJAGFo85zXAc23lwBKp4vP1wSVUq+Rk=;
	b=3HaQPBZnG9G6VXUOSjKR0vRvm37yKEb2KTZnbtZxvLW2QStRL9YlhBWg1j54bIqPyxrq
	 hWzpx7zirjaJtEiRyQEJiCux27ROC14umT5+AFx3Aryq/Wcq1L+zTKakvydODIcFQ5wsx
	 RPPdX5E86IKZ8ahpho4yRJumyim4U/huRe4L4b594ckpToL/ITTdKCIZFT8uT8+pqGykj
	 DfSW8yB0n62BE+bVmlleOBR83naXk91CZb4QvBiIZRim8NR22iV8vkp08sQeugITft81g
	 eQAuCwMYf5fZmifpA6WBt6QLn8Mw5bsyf0mD4ZAJz+a4jvSQCI/0hJnfWFvCC9KJirQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087EE606A338;
	Tue,  3 Nov 2026 08:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 087EE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D95BC20748;
	Tue,  3 Nov 2026 09:01:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dr39lHmud8xT; Tue,  3 Nov 2026 09:01:18 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3A42F20190;
	Tue,  3 Nov 2026 09:01:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3A42F20190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793692878;
	bh=AulrUU0VFXvSrJAGFo85zXAc23lwBKp4vP1wSVUq+Rk=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=LTu1W9I/GERA4yBvnwWR9m32ftaX72hSnQcQBoqua3IbiVOBtaHJa0EV1Dn8O6vRr
	 0uOAckMZOiqwuKFvO8Yaau64/ZxMd2VvxKErJhbPw0zMsA0JukabvI6RBg4TyBbkAS
	 KLTO+dEvenFCUudvf5mbKkrsiDhBBXOeRSSP+kMBVYOoMwyIM9KfWN+pVmlb7W6wKJ
	 MrdkzXSPAWbnTGSZwfDpqAIFCZnEVZTSahJle16uxs+LPWNGB82OrTOZzudOJqK494
	 KM2MJ6YME6mkn5rKYP/XChnSql4CB/4fmxyQFcFEdtWtNj3BpYSB6PwoTcisFTGIRr
	 H39dvPsYdVtgQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 3 Nov
 2026 09:01:17 +0100
Date: Tue, 3 Nov 2026 09:01:06 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Cen Zhang <zzzccc427@gmail.com>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <antony.antony@secunet.com>,
	<baijiaju1990@gmail.com>, <jjzuming@gmail.com>
Subject: Re: [PATCH ipsec v2 2/2] xfrm: use cached offload ifindex when
 migrating an SA
Message-ID: <aumUwuVWsOOQdMG-@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-0@gmail.com>
 <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-2@gmail.com>
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
In-Reply-To: <pm-xfrm-core-objects-candidate-0050-v4-3c6b8c5369a802e9be0e-2@gmail.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

On Sat, Oct 31, 2026 at 11:28:49 +0800, Cen Zhang wrote:
> An xfrm_state reference keeps its offload record alive, but does not
> prevent xfrm_dev_state_free() from clearing xso.dev and dropping the
> device reference. xfrm_do_migrate_state() checks xso.dev before
> xso_to_xuo() dereferences it to obtain the offload ifindex.
> 
> With XFRM offload and migration enabled, XFRM_MSG_MIGRATE_STATE inherits
> the old SA's offload configuration if the request omits
> XFRMA_OFFLOAD_DEV and does not set XFRM_MIGRATE_STATE_CLEAR_OFFLOAD.
> Device unregister can flush that SA between the check and the read.
> The supplied report used a scheduling probe to delay migration in this
> interval while in-tree netdevsim was removed through sysfs.
> 
>     Migration (xfrm_cfg_mutex)       Device unregister (RTNL)
>     xfrm_state_lookup(): hold x
>     test x->xso.dev != NULL
>                                     xfrm_dev_state_flush()
>                                       xfrm_state_delete(x)
>                                       xfrm_dev_state_free(x)
>                                         xso->dev = NULL
>                                         netdev_put(dev)
>     xso_to_xuo(&x->xso, &xuo)
>       xso->dev->ifindex: NULL deref
> 
> The netlink configuration mutex does not serialize with the notifier,
> and migration takes the state lock only after this read. The result is
> a NULL pointer dereference even though migration still holds the SA.
> 
> Use the ifindex cached in the offload record at attachment, as state
> dumps already do. The SA reference protects this snapshot throughout
> the read, so serialization no longer depends on the device lifetime.
> Annotate the binding check with READ_ONCE() to match the concurrent
> WRITE_ONCE() in xfrm_dev_state_free().
> 
> Oops report as below:
> 
>     Oops: general protection fault, probably for non-canonical address
>     0xdffffc000000001c: 0000 [#1] SMP KASAN NOPTI
>     KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
>     RIP: 0010:xfrm_do_migrate_state+0x1f06/0x2c50
>     Call Trace:
>      <TASK>
>      xfrm_user_rcv_msg+0x3b3/0xc20
>      netlink_rcv_skb+0x133/0x390
>      xfrm_netlink_rcv+0x76/0x90
>      netlink_unicast+0x504/0x840
>      netlink_sendmsg+0x7f7/0xcf0
>      __sys_sendto+0x425/0x470
>      __x64_sys_sendto+0xe5/0x1c0
>      do_syscall_64+0x115/0x6a0
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>      </TASK>
> 
> Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Reviewed-by: Antony Antony <antony.antony@secunet.com>

Thanks,
-antony
