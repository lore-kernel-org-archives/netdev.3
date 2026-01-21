Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C170500948
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954142; cv=none; b=BCy/iUiz1sDqQYhIq6DNqQugUhuJYI1LRjKqwhdziimNL3lrMcW/3jvDf6T31AjuIUkwdHi0mBQ8hfb8OY0rBc3THDimeSJU1Ye8yexirDCOSZTmjKHychySQf732/BmsEn7ajumE1Vp+fc438Xd4e4IvMN83BxGPQojSqdhsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954142; c=relaxed/simple;
	bh=3JwTmbyn0myxEqeL8FZSxd40AYabnn5WSxDtTt6WF5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTG5CYuesNGictE+QaGB6HqRHm0tLkA9sdvflMGrUHyssGPXvOmGXhsypS44eQgOlBGMajf65bdftK7sK7/fuQlFbgL2B0/qhnz7LJs6nWpl83CfmFyLIj2sGWS/dszuvSIbIhyA+Y0Tv5xGfPRxMTL2yk9eDekga1q+5/wOio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH9FUAgt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH9FUAgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02F0C16AAE;
	Wed, 21 Jan 2026 00:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768954140;
	bh=3JwTmbyn0myxEqeL8FZSxd40AYabnn5WSxDtTt6WF5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LH9FUAgthWkCHDMDkjfvz8TS3gWxdYBSQ2pFcKPNjM5KVveVI+CNU/nEFV6grBaW4
	 eB7CJdT8e3PPS/wsNX3BB3t6yRjm52KjBfRcDYccqzz84dhjYJkeOpnOk2bPWmXCbH
	 nhQ6XOfUErAz/NdjAthyC0rLXiWRonUDlaOZALNjeHsq++4DqTzlrIoBzkOYJaVdNW
	 jpZsTaQHrkboI2yvf3OZwM0AnbJby5dYU7s/l/6ooq4G1Whnwo980wCWrqwX1GZYcF
	 ku2GYTuLbXGiMgeWqmHifwgU8pCEFdAWoqGXt7CPuLJmaeE/4B2GLwRAn1l0OVY+fu
	 qOuZv7Ft3JJ/w==
Date: Tue, 20 Jan 2026 16:08:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, justin.iurman@uliege.be
Subject: Re: [PATCH net-next v3 2/7] ipv6: Add case for
 IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Message-ID: <20260120160858.1b0a941c@kernel.org>
In-Reply-To: <20260119211212.55026-3-tom@herbertland.com>
References: <20260119211212.55026-1-tom@herbertland.com>
	<20260119211212.55026-3-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 13:12:07 -0800 Tom Herbert wrote:
> +#if IS_ENABLED(CONFIG_IPV6_TUNNEL)
> +				case IPV6_TLV_TNL_ENCAP_LIMIT:
> +					/* The tunnel encapsulation option.
> +					 * This is handled in ip6_tunnel.c so
> +					 * we don't need to do anything here
> +					 * except to accept it as a recognized
> +					 * option
> +					 */
> +					break;
>  #endif
>  				default:
>  					if (!ip6_tlvopt_unknown(skb, off,

Transient build failure here:

net/ipv6/exthdrs.c:207:10: error: use of undeclared identifier 'IPV6_TLV_TNL_ENCAP_LIMIT'
  207 |                                 case IPV6_TLV_TNL_ENCAP_LIMIT:
      |                                      ^~~~~~~~~~~~~~~~~~~~~~~~
-- 
pw-bot: cr
