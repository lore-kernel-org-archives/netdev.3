Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA462318EE1
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806860; cv=none; b=px7kDWOHpZUR30P5UeLAQEFeAmAVcqGLY/oqkodFCKhtxgUoLTJ8mfLfsHj2oVWFXR/4XQbK6NNiXBEQDBf1XgICMe+3H5YHLfiGG6dEAvJ4L0ewcVCh/aK5uJvQZ39+hew1T04OKGfmGZWvSC8Jfyu/Zuc8yGHR3WTmufv/2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806860; c=relaxed/simple;
	bh=948U29XZRbu+3EAj5majYTcVnJ9Ilgv3324VueONyyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rErVE0yDnw+TnUIFSNy78Z3vN3w5+UHieOuN955i36LdzAJbZfSHblUJE/25CpGvFWafi/XkmyV5Iea3pkleO7OAadNbts+C3C3vflV2mVHHj0t2YLmix0z+VyqvpgLtrvR7nVFZUS+XKIRzn/zOUWeR3VmTfWnQKHykeIF1hN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7/MO6pM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7/MO6pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7929CC2BCB3;
	Fri, 15 May 2026 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778806860;
	bh=948U29XZRbu+3EAj5majYTcVnJ9Ilgv3324VueONyyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O7/MO6pMm9M01jE3h71J3keUfwq55Ti8fg80BX30X7MqCUh+sD92lp5UEZVmcnBXh
	 wH6E0gvNVHnBj0kYSKOIb7GiEmIMTc2g8FJka3QPBsje4tR1lWfFewLa5nIPuD8sKV
	 11YgP85ycN2nI4Phrg5f9cGaj1ew2WAGWvku+p9NlqMM3DxmBzLJ059HuccP+jtTN4
	 +pUxmJNrp3eFTgsh4v5yX6Z3+e+UaG+hYQoQ7xu5bPNhTcaI+Sb4AkJv7wThdOuN04
	 PUVCxQdxPc9z/TyYUReFRn+i85VAHIN8aXDKpj9GrRJ/WEC3qYj0byBoEmJQ4iWXn5
	 2NvM10bhT5l9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC939E4DB5;
	Fri, 15 May 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: skbuff: preserve shared-frag marker during
 coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880680505.144258.11032558972341805059.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:00:05 +0000
References: <20260513041635.1289541-1-vakzz@zellic.io>
In-Reply-To: <20260513041635.1289541-1-vakzz@zellic.io>
To: William Bowling <vakzz@zellic.io>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dsahern@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 04:16:35 +0000 you wrote:
> skb_try_coalesce() can attach paged frags from @from to @to.  If @from
> has SKBFL_SHARED_FRAG set, the resulting @to skb can contain the same
> externally-owned or page-cache-backed frags, but the shared-frag marker
> is currently lost.
> 
> That breaks the invariant relied on by later in-place writers.  In
> particular, ESP input checks skb_has_shared_frag() before deciding
> whether an uncloned nonlinear skb can skip skb_cow_data().  If TCP
> receive coalescing has moved shared frags into an unmarked skb, ESP can
> see skb_has_shared_frag() as false and decrypt in place over page-cache
> backed frags.
> 
> [...]

Here is the summary with links:
  - [net] net: skbuff: preserve shared-frag marker during coalescing
    https://git.kernel.org/netdev/net/c/f84eca581739

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


