Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB93C660C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233916; cv=none; b=ZsSTIBmvGrIm2VkYBBU1Tvc3SXp561hSgH02oxpwZLBxVjIMKGsMMVgRi3LXRCaubhQZI3417WwcWYagpvsG/z16lrToJ5N1dLMZ/IzuZB5nGTYnBEWPLQKv1XVce5FdbN3U4EEYU0FtzF4jNJ5jQsA7XRywr6eqPlpuNmTdRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233916; c=relaxed/simple;
	bh=9M8gcmoNR1XCaccptQ5bXfDN2IjxU+LkTwaaPEGAJNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5vDXxczDYJpbdQKRUXhtAg9/3WpYu/NKdptgbxwSPNFGlD+JpQpj07o2GJXcBFHYWS60FWLJwaDHXimHy1RZlb2sEZzQzGmoYAraX6qGia6+YlALz5StaHW3ucrQ5X2ORFpi3XEXsOWnUXnINMMe0Cm12WE2WxFjWpxeaFGOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSr+hnLG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSr+hnLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC304C4CEF7;
	Fri,  3 Apr 2026 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775233916;
	bh=9M8gcmoNR1XCaccptQ5bXfDN2IjxU+LkTwaaPEGAJNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSr+hnLGemZv3UtVFqaHjPWBSQnaEgnD2DCC2WK06NGvQpRpflINfzXo09iN6zb9e
	 r5O8xp0zqZOxFEuxLz6TRx1GAnEvU9/NKAu6CQzEHLwk9RugBnaMSLw3h0ar2+K88Q
	 /ENhatK2g9zDmY7GcUMcepBHq1TpU1aLHS2UKDnt4xv1gjG+NIBNu8w/XYGRXKT2NO
	 fEMlKkBCiPEVp4cRxEazEEdQfsVACiBMAmCmoK56MMqT3WXHIGMWfYFdYPOgjfUmvo
	 C8NfOsy3nvFExmAP5aAX6Kn/tfj0/GjPpqneN8GGC+0gOkRcdKE/Y5Ebrturjx4J12
	 yfWqF98LvICwA==
Date: Fri, 3 Apr 2026 17:31:52 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: always inline some skb helpers
Message-ID: <20260403163152.GQ113102@horms.kernel.org>
References: <20260402152654.1720627-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402152654.1720627-1-edumazet@google.com>

On Thu, Apr 02, 2026 at 03:26:54PM +0000, Eric Dumazet wrote:
> Some performance critical helpers from include/linux/skbuff.h
> are not inlined by clang.
> 
> Use __always_inline hint for:
> 
>  - __skb_fill_netmem_desc()
>  - __skb_fill_page_desc()
>  - skb_fill_netmem_desc()
>  - skb_fill_page_desc()
>  - __skb_pull()
>  - pskb_may_pull_reason()
>  - pskb_may_pull()
>  - pskb_pull()
>  - pskb_trim()
>  - skb_orphan()
>  - skb_postpull_rcsum()
>  - skb_header_pointer()
>  - skb_clear_delivery_time()
>  - skb_tstamp_cond()
>  - skb_warn_if_lro()
> 
> This increases performance and saves ~1200 bytes of text.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 4/24 grow/shrink: 66/12 up/down: 4104/-5306 (-1202)

...

> Total: Before=29652698, After=29651496, chg -0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


...
