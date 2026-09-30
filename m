Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68438C42F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749250; cv=none; b=GthkjIIuqbg9Akphcr4tgJtbgNpBgnRpTj9aIslL2mzos9omVV4SpT6trHQ5IPsuxU+l0L5kdPiimmPWYS5WOvtvHJPP7ei6JeXaxWqwehwyBt0DI4HPQ0v0ygYRkbUOonm6+Nj1fYaxroC18o+CGil8OApswoSPkZIlo/Sh6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749250; c=relaxed/simple;
	bh=gl2TVMOc6zmDYM1fGHAqTOwoGML/tEwcv7Pwmr3DucI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8jPgTCnCr48RIj0d51JHYICAy4FOLIisfVmH1+KyDrTNofi3I7BamAvqTd/Uw7QB9XpAN7on6Vmpa68ytGRYh626aR79geZwiKwc2jd7k1eTarYrQHbv2etbWePHb+rr5qzGy4EOILvAAhCuyHHL4Uh7dWGHBLu63o48R/Qw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ShFLQnSF; arc=none smtp.client-ip=91.218.175.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ShFLQnSF"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gl2TVMOc6zmDYM1fGHAqTOwoGML/tEwcv7Pwmr3DucI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790749246; v=1; x=1791354046;
 b=ShFLQnSFhGSIfWRxHFQMiiRd1sUaLZ7IqXyAgrOAM7+RgSOgBE3+ChKBBNqsw2AW6KFq3SAi
 5+H4+QnOkeoGVlw5ZKzuhTeNxzLskG1smAywUkRsgozdyAvtAZxsVMJ+6npBohS1elRql9bnsnh
 vkGL3P3mrX87WkUTgZ/qm+mE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id da0b8b00a1122da2;
	Wed, 30 Sep 2026 06:20:46 +0000
X-Mizu-Trace-ID: da0b8b00a1122da2
X-Migadu-Flow: FLOW_OUT
Message-ID: <09dbb29d-8ab4-4228-9151-dd640449f05e@linux.dev>
Date: Wed, 30 Sep 2026 14:20:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ipv4: fix IP ID reuse in ip_select_ident_segs()
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, edumazet@google.com
References: <20260929131247.401104-1-edumazet@kernel.org>
 <20260929131247.401104-2-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260929131247.401104-2-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/29/26 9:12 PM, Eric Dumazet wrote:
> ip_select_ident_segs() must put the first of the @segs reserved IP IDs
> in iph->id, as GSO assigns id, id + 1, ..., id + segs - 1 to segments.
>
> Commit f866fbc842de ("ipv4: fix data-races around inet->inet_id")
> used atomic_add_return() for non-TCP sockets, which returns the first
> ID of the next packet instead. Consecutive GSO packets can then reuse
> IP IDs.
>
> SCTP GSO is affected. Other callers use segs == 1, and only see
> a harmless off-by-one (UDP GSO has a separate, older issue, see
> following patch in this series).
>
> Use atomic_fetch_add() instead, like the TCP path.
>
> Fixes: f866fbc842de ("ipv4: fix data-races around inet->inet_id")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>



Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>   include/net/ip.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 6f602df72ee621ee4ee45e70beef0a1b5145367f..6a3e8271a73b3669e97c4b389e916dbcbfa9f6ae 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -598,7 +598,7 @@ static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
>   			val = atomic_read(&inet_sk(sk)->inet_id);
>   			atomic_set(&inet_sk(sk)->inet_id, val + segs);
>   		} else {
> -			val = atomic_add_return(segs, &inet_sk(sk)->inet_id);
> +			val = atomic_fetch_add(segs, &inet_sk(sk)->inet_id);
>   		}
>   		iph->id = htons(val);
>   		return;
