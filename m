Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2F4397940
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253698; cv=none; b=ifBPh1vU6sgbALS9bs1AWCx0WD0m8gFogxyOjaIwxiG9fqkY+pykCse8PGeIUEjSphozU4gp3h6HjLdCq2wStoACiYwBaYBMDd91oSZnDZ2N8p5EN+DPoeFDrRwSdr2O7T3hTdrsMRZEPPtOnvo2LANrg4+gGVAoWNYxGZEjet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253698; c=relaxed/simple;
	bh=SAw3W3Ayz31xG5cd5c1VrfOi61BGDc0IYNBHra77NxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sA/rhtjZ62YUGeNK+0j43ofr6kWtd1NPabjxYHm3hUxEUKxoD/YkvfccCa4QLfh3hGhNdD/W4nSIZAcDEOuZqC3jqC9jn72EpLYtTZ8JXzDnIm/+Wu14v2/v89ogkpdrA/Jyw6UBiEVqhbCAE2RZA9hDGdKrOOoJexRCXMd8/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEn9Ig9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEn9Ig9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC2F1F000E9;
	Thu, 20 Aug 2026 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787253696;
	bh=jJzZ5hecZiDnuLW1C4necTOaCB94dZi353c9FvHi/BE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PEn9Ig9SpTUH1hFTO+2YHCe+PYQ7R1yZ97sbn/8orxusHdWUH+hN6hX7t3zldhgns
	 N9szS3wqg2OUhyysWTVaBbTGZ5rhBrV9+uDXf15bCClFGBXwbCuKjczSste5XwIjos
	 e0DPrQoWoaxSE0dbi1gVo3NWq0UzoZ2NWAvQ9ont+aJ/xkFdidtkyWITZJy/1977ZJ
	 r0IwXUf8SWraobRgXpPa6vqYmGyTdmn+IbQWHDtC5i7d4ik6faHEDGD6ITQElT5Jxr
	 Pl6h9EQpjjUEGnXpCEaw8viC5xoFg0itE1jCdiHTQVleMltJNP7z/0IUrUr5b+cuMq
	 3Cg+OmxwJUWbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56845392444E;
	Thu, 20 Aug 2026 19:20:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] xfrm6: fix out-of-bounds write in
 xfrm6_input_addr()
 when secpath is full
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725364688.443080.9994375691568437035.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:20:46 +0000
References: <20260818092920.653034-2-steffen.klassert@secunet.com>
In-Reply-To: <20260818092920.653034-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Tue, 18 Aug 2026 11:28:32 +0200 you wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> The depth check in xfrm6_input_addr() is off by one:
> 
>   if (1 + sp->len == XFRM_MAX_DEPTH)
>           goto drop;
>   ...
>   sp->xvec[sp->len++] = x;
> 
> [...]

Here is the summary with links:
  - [01/10] xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
    https://git.kernel.org/netdev/net/c/5d9e3bf34fec
  - [02/10] esp: do not unref managed frag pages in esp_ssg_unref()
    https://git.kernel.org/netdev/net/c/21697720ff43
  - [03/10] xfrm: espintcp: fix UAF during close
    https://git.kernel.org/netdev/net/c/deb232e88487
  - [04/10] xfrm: drop ESP-in-TCP packets with no ingress device
    https://git.kernel.org/netdev/net/c/e1d7c5ac1c24
  - [05/10] xfrm: avoid lock inversion in nat keepalive work
    https://git.kernel.org/netdev/net/c/763fe700b7c5
  - [06/10] xfrm: Fix skb double-free in xfrm_dev_direct_output()
    https://git.kernel.org/netdev/net/c/2aed51fc58d9
  - [07/10] xfrm: ah6: validate routing header segments_left
    https://git.kernel.org/netdev/net/c/7bad4bda74dc
  - [08/10] xfrm: fix xfrm_state_construct() auth-trunc leak
    https://git.kernel.org/netdev/net/c/c12cbf56320f
  - [09/10] Revert "esp: do not unref managed frag pages in esp_ssg_unref()"
    https://git.kernel.org/netdev/net/c/0fda52de8bbd
  - [10/10] xfrm: bound nat keepalive state collection
    https://git.kernel.org/netdev/net/c/4e9442ce551e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


