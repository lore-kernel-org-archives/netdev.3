Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D93F58F1;
	Mon, 18 May 2026 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113939; cv=none; b=XI3Y39Jf1HPh2TnCbDF6tBdrSiSAU+to06Rn1iBbw6hSmb0P6AN42Uz9abbtwysLMEmHZzzmcdrp3AjeT1MvQIC7rixUbZv4GiEQ3CJm5/oa+mpFWu7KHDIo6pzRNbDg/PSzP8yBwa5gIMk5H3IP1CXZCR+X9v/MSv4Cyc2uFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113939; c=relaxed/simple;
	bh=xEvty+SNfuwEBnANkS9+nIKNWcEqJfW1amR6blsoroo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDSezQQTAkf0oFDMBnMvCwLaYqgqmrREy4JcmNvZJos8tdBcTntxhldGJaTDqN21YEUBxgmrYI+8FrwfbMNlpo0MBt7Bx3LaijBZ4cS4oKaWdHjhHIpl1m/YqMUjt0IXk7GNAELM2MIYB11dEHbNZ+WXg8TV6ekzIXif3kCrAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pfz5BP70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pfz5BP70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EE3C2BCB7;
	Mon, 18 May 2026 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779113938;
	bh=xEvty+SNfuwEBnANkS9+nIKNWcEqJfW1amR6blsoroo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pfz5BP70XZ/nRCuwxkVWEvWOCWGqcmu8x0Mw3d6PgOlBWi+9rWULGLwhq9VtVaajz
	 Misc3g5MND9WBQQqVdZVGM1tMGhifJlc9+8mxTxo6YWRZNJJ/ForCIS8ydg0BXMj5S
	 ZI7L6tOczLp7pmWSk1rDE6ExhrVYamsY2junGiVu8pv3CeMM0l/66QwaQ/4rxLT0px
	 PlzC0q67AITHNMAfrfa0SEQtFuXvjK5o014mUwuDYDBEpZPBoKSMft98XFe3sv0R/T
	 H12G/Y+WXibReYdPtH/o8nOxR1TlPD4TESkyeYvs8A+qXpSsTucIYwRMSNAtce5JKT
	 mH/zEt0tz5k3g==
Message-ID: <ddefecf4-0a2f-4382-99a9-26012f9e943a@kernel.org>
Date: Mon, 18 May 2026 08:18:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: rpl: add NULL check for idev in
 ipv6_rpl_srh_rcv()
Content-Language: en-US
To: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alex.aring@gmail.com, justin.iurman@gmail.com, bestswngs@gmail.com,
 stefano.salsano@uniroma2.it, stable@vger.kernel.org
References: <20260518140630.24280-1-andrea.mayer@uniroma2.it>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260518140630.24280-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 8:06 AM, Andrea Mayer wrote:
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 03cbce842c1a..a4af6e63349c 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -499,6 +499,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>  	u32 r;
>  
>  	idev = __in6_dev_get(skb->dev);
> +	if (!idev) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
> +		return -1;
> +	}
>  
>  	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
>  			     READ_ONCE(idev->cnf.rpl_seg_enabled));

ipv6_rpl_srh_rcv and ipv6_srh_rcv are both called by ipv6_rthdr_rcv and
both of these functions check idev. Moving the check to ipv6_rthdr_rcv
which already has an idev lookup would simplifying both paths -- and set
the drop code reason the same.
