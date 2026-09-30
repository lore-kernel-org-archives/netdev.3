Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A951B4A9D65
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771412; cv=none; b=DG6bAVJ1BAK8Nv0qMuTZJqegSQ3AELN6T3xm/Qb4+SXYbx9FiyfPMInkmrTuFFBwdJvg5VjQVC60J5iTqLFmZPGrxirpBa4tETZIsNii904qgXvUXsqP5RfC//m/ck14R3ydUVbVAL0gIkRDkM8XF/LjDKkq8JmFi5PHQz0poJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771412; c=relaxed/simple;
	bh=JJpYWCHBcf+0Oio2PaA0hFPHL2ZrOuREv6f1YnazJ7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIBn6lx05iukQ/1LOQvmSlPaIMtDzO0s8Un8qj2oBLGSBzV9PLdv719yjMHHp1G599Ot/o7U7oCNRFkJ1qSPAlhPHOevFwZn5YtZ6xjuNRMxn/teMiErO1SJIOaW261L0+CzwgaMXsN+4FefjJhEixfCx+oNweUG12trCOHMibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAr2pxss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAr2pxss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6E91F000FF;
	Wed, 30 Sep 2026 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790771411;
	bh=gssdwueZdfWJa4GUMTZC8LCY1EZRe/GvkHiIcWjIwxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aAr2pxssQ+CvsJnHuR9Wr3kD7wuKtzqe5t9uanVRNIp9dfxaA5o6QzxZTFDpsG73w
	 gqZ0nEL+JIXN3CbqdSnjuOj3dGfmRLG4Ruc0nfsNwj5Bqbu2lrDf25gpwrcxfeYU0F
	 d6N08cq3wX1fOg+nbxF4S6AN8wZE8wxdSxQPlQy5ZRQxFPJ6XvZVFnpXXs1ujsPxyL
	 6vpwSSkmmVFqPpyZsYAS4GAdOMpGXr0L+nPiVq/sPSTl7lnkieALUy8x6X87d9l4OG
	 QLFs22b9WTv7aLNVWADOYDPKGkErOzjrX2uszdwPlqUh8WLTiLo5Vg3tPipq7c+Kr1
	 zg+fFbxBINKRA==
Message-ID: <855537d4-5c35-4bcb-aa58-82aa981e46fc@kernel.org>
Date: Wed, 30 Sep 2026 06:30:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ipv4: fix IP ID reuse in ip_select_ident_segs()
Content-Language: en-US
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, edumazet@google.com
References: <20260929131247.401104-1-edumazet@kernel.org>
 <20260929131247.401104-2-edumazet@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260929131247.401104-2-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/26 8:12 AM, Eric Dumazet wrote:
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
> ---
>  include/net/ip.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


