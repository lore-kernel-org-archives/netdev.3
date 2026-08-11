Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636C42883D;
	Tue, 11 Aug 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440071; cv=none; b=ZAaAAt8d5W5scTp1jbij2pIUvsE5PKXREl4fbE+2GrR9amkqT4ugPE+w72zYEOEPONlJ69Zj+p3Q0zWLQaXA8z5rW1bzH1MuEIiA1ml5qMG5c45WR7mPs0ShCDZyzw4Q6DVf9ShqlZgNOTQ6tTIstK66xPiX6dRm4dWPtqRx86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440071; c=relaxed/simple;
	bh=zgxAaNMfzBTPU7sVV5I70jrU83J6qNKI+JpjbvfPWtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmBm0N4UpUlAJkOIJc7pkTD0pQtysOOQkVBp1eVz8hOxfnHtwiXPFPCLMIMPTqr48smMZpZe+OTGKXDC+NykkzsQ9ZamuRV3nvskAv+ooJR+FqOT80Mv7/ck0bJrG12u6b1YpLu0cyLmhY56JuoZ7Jz3JKI6BKZxk8tMaz7YpYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=r7Jo6bFW; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="r7Jo6bFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1786440056;
	bh=3ofstSC5i2pGOfDjbJiArD1lb25U8UMQiGjXV8i5QFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7Jo6bFWjOKeYWuWXLHQ6fqf2jeCLKmfytpJVo3q900LzAZxmHSPAiMFaKD2AuM7r
	 A2Vt1c8nmmU2yU+Utnts+wG2nv+K3Ja1ZNEepQW7FQRanYEFF5IEDC91aTbiApNAm1
	 5IKOtrzi4n8IFXbl7ZpvP9uz3fQQygfyBYd4b+YQMBu2/qhr1+hp3CLNOkFtKwpuur
	 BxlP8Bm5dmMh/Pk9n1Qvhry2TVx+nSm/+XCWMjCFlCxiJUuvfqCYtH/giSwwMbeyUu
	 XjVVHUZuPZqaC+b8MuxacGjXeo15wy7vSOkdHUq6oTUvNQdworhExk1gLCGnDzjT6q
	 dTjNRbVz/OyjA==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id E9A146005C;
	Tue, 11 Aug 2026 11:20:55 +0200 (CEST)
Date: Tue, 11 Aug 2026 11:20:53 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: Harald Welte <laforge@gnumonks.org>, horms@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] gtp: serialize PDP context updates
Message-ID: <anrpdUa_ngVKH6NR@chamomile>
References: <20260811022012.5416-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811022012.5416-1-a0yami@mailbox.org>

On Tue, Aug 11, 2026 at 10:20:12AM +0800, Qing Ming wrote:
> PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
> network device is being unregistered. The latter is serialized by RTNL,
> but the generic-netlink delete path only holds RCU.
> 
> Running both paths concurrently can therefore make both paths delete the
> same PDP context. The issue was found through static analysis and
> reproduced on a KASAN-enabled kernel by a two-thread program
> racing GTP_CMD_DELPDP against RTM_DELLINK:
> 
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: maybe wild-memory-access in range
>          [0xdead000000000120-0xdead000000000127]
>   RIP: gtp_genl_del_pdp+0x1c1/0x420 [gtp]
>   RBP: dead000000000122
> 
> The second deletion dereferenced the poisoned hlist pprev pointer.
> 
> Serialize PDP context updates with a mutex shared by gtp_pdp_add(),
> gtp_genl_del_pdp(), and gtp_dellink().
> 
> Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>
> ---
> v3:
> - Rebase onto net/main.
> 
> v2: https://lore.kernel.org/netdev/20260808124322.5800-1-a0yami@mailbox.org/
> - Use a dedicated mutex instead of RTNL.
> - Protect PDP add, delete, and link teardown with the same mutex.
> 
>  drivers/net/gtp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 9a12cc53da00..8ee516debeed 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
[...]
> @@ -2134,6 +2140,8 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
>  	if (!info->attrs[GTPA_VERSION])
>  		return -EINVAL;
>  
> +	mutex_lock(&gtp_pdp_lock);
> +
>  	rcu_read_lock();

This rcu_read_lock() can go away after adding this new mutex.

>  	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
> @@ -2154,6 +2162,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
>  
>  out_unlock:
>  	rcu_read_unlock();

This can go away too, for gtp_genl_del_pdp(), the mutex replaces this
incorrect rcu read size lock.

Thanks.

> +	mutex_unlock(&gtp_pdp_lock);
>  	return err;
>  }
>  
> -- 
> 2.53.0
> 
