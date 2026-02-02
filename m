Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAB1D5ABA
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770002194; cv=none; b=ojVvBLpmyTd9/oDzDqwkk2bSMhTldVpOiPp6p7JD4mKHx82LODQArRmU6GyFlTFi0mljYqZqcyPgmW3aYiSxYlGGDzcE8xnF2E+tm1tzBeaAqxFckmTbQyH0wr6QTRodcjEkbt2VaDxxnaX0Xv8jZcBhgKa181xgiCSHj0z3w+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770002194; c=relaxed/simple;
	bh=APLSjY7XtlaA7biH1ibPq1Ui9xlk6846p4bDlKc1NvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3IVBq2AkUho6PdgswLe3POXAFNCSq9l8kK23ZxqTVjXIu80wBNd5vZ6lJKAIaFgPMtRh4S3wEVT1UMJPRkDrzUhgxhVoRaXImVqtbPV7d47+6sMODef4DAkR36VQinUOFOKKCCxk5k/ltVdRWG7U/eoe8LxgZTKcT0QJYKhdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eufYC9kb; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eufYC9kb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770002182; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=LzM2eNvpwqcPDCQTa293morip+HejvfpDC+KkZ5UvCI=;
	b=eufYC9kbF6LpeiE4mo37+QKA+SDQ+Nn7wk9R1AfH0Id6vd8woCV01I5kFO8fPgLmOvUOFssv04WRn+nqGTQnRa9/zU3UfI2khWSO5dKR0I5QqxkF2m+XkJDufN1pp1nRLm450iEvThkvArJ8Q6JlyaIhsFwQGt5XKufBGnK6UxY=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WyIQiA0_1770002180 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 11:16:21 +0800
Date: Mon, 2 Feb 2026 11:16:20 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	dongchenchen2@huawei.com
Subject: Re: [PATCH net] net: add RCU protection to (struct packet_type)->dev
Message-ID: <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
References: <20260131212934.2547995-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131212934.2547995-1-edumazet@google.com>

+ Chenchen as he hit the exact same issue.

Hi Eric,

> Yin Fengwei reported an RCU stall in ptype_seq_show() and provided a patch.
> 
> Real issue is that (struct packet_type)->dev needs RCU protection:
> 
> ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
> to get device name without any barrier.
> 
> At the same time, concurrent writer can remove a packet_type structure
> (which is correctly freed after an RCU grace period) _and_ clear pt->dev
> without an RCU grace period.
> 
> Fix this issue by using proper RCU on pt->dev pointer.
Still can hit this issue with same backtrace even with this fixing patch.

Look at the __dev_remove_pack(), the pt->list is protected by ptype_lock
while prot_hook.dev is protected by bind_lock. Could it make sure the
procfs interface see either the list element with prot_hook.dev not NULL
or can't see the list element with NULL prot_hook.dev?

Regards
Yin, Fengwei

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Closes: https://lore.kernel.org/netdev/CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com/T/#m7b80b9fc9b9267f90e0b7aad557595f686f9c50d
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-selftest.c |  2 +-
>  .../ethernet/mellanox/mlx5/core/en_selftest.c |  2 +-
>  .../stmicro/stmmac/stmmac_selftests.c         | 12 ++++----
>  drivers/scsi/bnx2fc/bnx2fc_fcoe.c             |  4 +--
>  drivers/scsi/fcoe/fcoe.c                      |  6 ++--
>  include/linux/netdevice.h                     |  2 +-
>  net/batman-adv/hard-interface.c               |  2 +-
>  net/core/dev.c                                | 30 +++++++++++--------
>  net/core/net-procfs.c                         | 18 ++++++-----
>  net/core/selftests.c                          |  2 +-
>  net/ncsi/ncsi-manage.c                        |  2 +-
>  net/packet/af_packet.c                        | 24 ++++++++-------
>  net/tipc/bearer.c                             |  6 ++--
>  13 files changed, 61 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
> index 55e5e467facd7f546ba208361ec9fdcfd7a627d9..006d80a387431cb7d4acdd35f4f1990c8c1f3366 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
> @@ -121,7 +121,7 @@ static int __xgbe_test_loopback(struct xgbe_prv_data *pdata,
>  
>  	tdata->pt.type = htons(ETH_P_IP);
>  	tdata->pt.func = xgbe_test_loopback_validate;
> -	tdata->pt.dev = pdata->netdev;
> +	RCU_INIT_POINTER(tdata->pt.dev, pdata->netdev);
>  	tdata->pt.af_packet_priv = tdata;
>  	tdata->packet = attr;
>  
