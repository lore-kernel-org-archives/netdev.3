Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309632D060B;
	Sat, 28 Feb 2026 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247883; cv=none; b=Z98loKKbQdT+Uy/1MFsYW7v9KKNBQCkPLJY3FoU603CqW0YClq/w637+OZdQEdFtbA3pQKEEsCyu/c3pPWb7KOjkHKnp0kP/p9jPzau/Yhonmponkf/rLQLpSnNNzLNFWf7VDY6xVUxq+8a8GZQ8lMfuTogdjsr+xtWxGimbfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247883; c=relaxed/simple;
	bh=rRuJLJjVEC/iekwBQX86ikOn2y19JbbiL+COLF9Ggko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2TWaIRj9oOcJnUtUofJbk/0h3JtnxtAwUgQLj0xmvXowzgP9pgoxq19lTwlO4T4yW22L4/6Ld4h0zYG9EZo/FI8PGyPInAuIAA2d/Ha9dE30KoTYU6ttpkYoKJSrL40ynvUPayeDREg3W2eVbiKJQDS8WDscGVjGnGUO/yNoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqe468Ay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqe468Ay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE5DC116C6;
	Sat, 28 Feb 2026 03:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772247882;
	bh=rRuJLJjVEC/iekwBQX86ikOn2y19JbbiL+COLF9Ggko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cqe468AycrTejrSZ2zNpH7qZhqpTDEPWcdW/VXH4QsHaR6O5llBbUEK3hhkiTjPuf
	 vHrDzBvjixnK3w/yGGzxbhnPyIQnIK3OfMFtfzwzsJziSz9LESj+s1mhV3QHjWWvFE
	 elrnxA03RpR7vioK5Jt1B7pnfPkDtfuwRWBJo7DF0KA0r8dHMIEAJg5/n1xF+Me9Q5
	 STIcIpwX7BuLdzI8PeSB50idfUMkwbnO9J6aCy0dYVWgdty0imGhRv5fGuYET419qq
	 DxkPWsyMP3hoYHWdpPTTgIhxdpIb0puetuRJNv5O55qiR/H1aAdPvQPyOdchlz1Tbc
	 8yctGVfXjv5hg==
Date: Fri, 27 Feb 2026 19:04:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kibaek Yoo <psykibaek@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macvlan: fix multicast delivery to bridge ports
 with shared source MAC
Message-ID: <20260227190441.0bb7b01d@kernel.org>
In-Reply-To: <20260225100024.38937-1-psykibaek@gmail.com>
References: <20260225100024.38937-1-psykibaek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 19:00:24 +0900 Kibaek Yoo wrote:
> When a macvlan interface in bridge mode shares its MAC address with an
> external source (e.g., VRRP virtual MAC), incoming multicast frames
> from that external source are incorrectly identified as locally
> originated. macvlan_hash_lookup() matches the source MAC to a local
> macvlan, causing macvlan_multicast_rx() to skip delivery to bridge
> ports under the assumption they already received the frame during
> transmission.
> 
> This assumption fails for protocols like VRRP where multiple hosts
> legitimately share the same virtual MAC address. The local macvlan
> never transmitted the frame, so bridge ports never saw it, yet the
> multicast is not delivered to them.
> 
> Fix this by passing NULL as the source device and including
> MACVLAN_MODE_BRIDGE in the mode mask for the else branch of

The change looks fine, AFAICT. But please rephrase the commit message
to avoid making it sound like a fix. The VRRP use case is rather odd
and it was simply not supported earlier. Now you're adding support 
with the tradeoff you note below. We don't want AI-based backporting
bots to pull this into LTS.

Please try to add a test case for your use case in selftests.

> macvlan_multicast_rx(). This ensures all VEPA and bridge mode macvlan
> interfaces receive incoming multicast regardless of source MAC
> matching. The trade-off is that looped-back locally-originated
> multicasts may be delivered to bridge ports a second time, but
> multicast consumers already handle duplicate frames.
-- 
pw-bot: cr
