Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD9F41226E
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437961; cv=none; b=VYLwFBySmBzgXug22uk4wdPoe4XihsLclI76UMWXI38JlAxVowsFsmeY5VlU5x4XF9+OK9BferprAYzoZCVNb+Mqnw3jCQTayvVTHfOjpeP7o+ltoDeBkpLyrnIdqlZAGIec9Qrl3r4MLD6FQBc2ipFvorqJkz56elPuN5nDVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437961; c=relaxed/simple;
	bh=+07u/nNgcNmBmHGYjeJ8NLRutUqP/VBXzr6CSYRoFUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhPODHyCUeqfgDc+TgWU32mePBbg2+Hh8dz+4xaXt6uGBkRKyff3jMjDapbcpwTFUV39ZrPZnH3gBfQkmFoQFqRlUM76Y6dh3aJxDpvSo4d6VVqLowGT+IEz+jZEwQ3NXqPM1h1Y4bglB5gdllaUR8oGAf/Y6YBH8TtBMTiwWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpuoYDVx; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpuoYDVx"
Message-ID: <04feb35c-ab30-4a12-ae19-a160b451c14a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783437948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xc8+pPqxDfAuJ1FumOvpiqxC63iRuIEMEqFg0qo0IK8=;
	b=jpuoYDVxs1exOhVPPJbvbaHPqr2V28ztfWmXBA5svFN61IKBLzionPglnQQKHAC3w4OQWL
	sYFVOwz0pkfrrB0fG+uPxE4fcxUkABVDdwgG7YtEfDpiG/DS0gJQMwMDRewVyJglLyt+03
	AtNCw4ZSKMq9B2Irxz/3IGfTcgZytW0=
Date: Tue, 7 Jul 2026 16:25:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] tipc: fix u16 MTU truncation in media and bearer MTU
 validation
To: Cen Zhang <blbllhy@gmail.com>, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com
References: <CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/07/2026 19:57, Cen Zhang wrote:
> Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied MTU
> values but only enforce a minimum bound, not a maximum. When a user sets
> the MTU to a value exceeding U16_MAX (65535), it passes validation but
> is silently truncated when assigned to u16 fields l->mtu and
> l->advertised_mtu in tipc_link_create(). Values like 65536 (0x10000)
> truncate to 0, causing a division by zero in tipc_link_set_queue_limits()
> which computes TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE). Other overflowing
> values (e.g. 65537-131071) produce small incorrect MTU values, resulting
> in link malfunction behaviors.
> 
> Crash stack (triggered as unprivileged user):
> 
>    tipc_link_set_queue_limits  net/tipc/link.c:2531
>    tipc_link_create            net/tipc/link.c:520
>    tipc_node_check_dest        net/tipc/node.c:1279
>    tipc_disc_rcv               net/tipc/discover.c:252
>    tipc_rcv                    net/tipc/node.c:2129
>    tipc_udp_recv               net/tipc/udp_media.c:392
> 
> Two independent paths lack the upper bound check:
> 1. tipc_udp_mtu_bad() -- called from __tipc_nl_media_set() (MEDIA_SET)
> 2. inline check in __tipc_nl_bearer_set() at bearer.c:1160 (BEARER_SET)
> 
> Fix both by rejecting MTU values above U16_MAX.
> 
> Fixes: 901271e0403a ("tipc: implement configuration of UDP media MTU")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>   net/tipc/bearer.c    | 6 ++++++
>   net/tipc/udp_media.h | 5 +++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 05dcd2f9e..0926692dd 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c
> @@ -1163,6 +1163,12 @@ int __tipc_nl_bearer_set(struct sk_buff *skb,
> struct genl_info *info)
>                                                 "MTU value is out-of-range");
>                                  return -EINVAL;
>                          }
> +                       if (nla_get_u32(props[TIPC_NLA_PROP_MTU]) >
> +                           U16_MAX) {
> +                               NL_SET_ERR_MSG(info->extack,
> +                                              "MTU value is out-of-range");
> +                               return -EINVAL;
> +                       }
>                          b->mtu = nla_get_u32(props[TIPC_NLA_PROP_MTU]);
>                          tipc_node_apply_property(net, b, TIPC_NLA_PROP_MTU);
>   #endif
Just wonder if this can be done with NLA_POLICY_RANGE/MAX/etc...

