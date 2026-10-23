Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785006;
	b=XIyu6+vnxmc6XBry1Gxt+5Z/Ow+s8/PcgtGrKA4pXVH9jEWTjSUHjmCz0ECsBHkMmKWV
	 H1NkI+/yu5lHff7L5umbZnmIjx8hfMT3H/bOUyd79o9o0vVsFab/dqKQ+ab8ejQM8IZV4
	 xMx4GHJV8j2B9ruI31+iriI+7BgUGZZX9EryW/OqM92hjwkI9mN2/Y6td/rGIyGmaXTT+
	 iOu3XRQDO4t4d33r0s/WnZbZHJBDT6ZpOk7GJGwdYv7uCugHtbA/za/Gfal12W3ZCZfTE
	 /aZgVNXHy7SWpHziK9FrZ+dfKus9HDduI+4qQQGt7vxY/q0eJgm4Gr05FmCrHjitMRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mZkXPAO9NoiT4zn1vRnQZIpkDH56HNVNwT6aUunYgzg=;
	b=5OvKEcu/r3gIv/+RcVX8iUYSeKpIGn7rtzbHpit3KpXqOFItobsDPhcWU6OMPy8e1WA3
	 UQiDlGaSEnK2BN7Yq6j3kfLA+NkkLrm+dp75CBe4UeOepDrqH4v/eR1+3+ZUM82GwTyuk
	 Zfo2KQTob+xexIx0LndVRlB9znPv8rQ90MwppG6JE6SW+4nwhii+mqnrt1FN9teOn436K
	 aAQCtkTDGDdkTtsGbr4/HYGnAIMJrjdhmTlhUnBFoKt5iT2FuSMIMw0tAFxWlecs56oTj
	 SIyFephSwEVfbLcQv5wespuBmSCX5T4ULtAXt52tyTN5SedVCW0yIKhbyURP6Pp1YDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0CX14yf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9AE606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0CX14yf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73851F01825;
	Fri, 23 Oct 2026 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785006;
	bh=mZkXPAO9NoiT4zn1vRnQZIpkDH56HNVNwT6aUunYgzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z0CX14yfgk6VBq0VgBlfV5mt8sfY2E5VAKnk6BheNDTeepk05gPHgn+9x4j5ceV/o
	 udOWwdHKg65y5HifjnEKSu85ccPJDFW8kzN1y1W83bVL5Is825Qaxk90PZwVbIZrOB
	 1SRnbg40CgrXJ/fHOSjMk5Nr0QFGZyzGkR0ELTwicWKU4bqmDa0vJnHkyp8UG0WTm5
	 wpHDPOoMcDM8uxN3Up1wDqUCzHWTfw3CHI1WAjXG/5GPEQeMzdH6sysgHvm57V29u/
	 i0im1GglgMceWwNsqQV4h0WMN9PbSTcjGwFj++/wbaxq7KWi3E73jex+JAFjdDfu2o
	 WtEPyItk9GWKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DED0C391B153;
	Fri, 23 Oct 2026 19:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: skbuff: propagate shared-frag marker in
 skb_zerocopy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179278500482.1232473.12604985616944843188.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 19:50:04 +0000
References: <20261022104217.1852191-1-pointerliu@126.com>
In-Reply-To: <20261022104217.1852191-1-pointerliu@126.com>
To: Zizhen Liu <pointerliu@126.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Oct 2026 18:42:17 +0800 you wrote:
> skb_zerocopy() moves frag descriptors from @from into @to and takes a
> reference on each frag, but it does not copy skb_shinfo(from)->flags into
> skb_shinfo(to)->flags.  A destination skb holding the same page-cache
> backed frags as the source therefore reports skb_has_shared_frag() as
> false.
> 
> That breaks the invariant relied on by later in-place writers.  ESP input
> checks skb_has_shared_frag() before deciding whether an uncloned
> nonlinear skb can skip skb_cow_data(); with the marker lost, an skb that
> skb_zerocopy() built for nfnetlink_queue or for an openvswitch upcall is
> decrypted in place, letting an unprivileged user write into the page
> cache of a root-owned read-only file.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: skbuff: propagate shared-frag marker in skb_zerocopy()
    https://git.kernel.org/netdev/net/c/79dc34beb1fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


