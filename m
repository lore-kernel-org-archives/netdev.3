Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693808;
	b=rltPnpL1PZSm0FgD+pLUPF4kOdeGRjsl/FrGOtzQb9d7zi06F0psC0ck3ryTAKYJW28e
	 1ssjqPIVPMc1RhX2sPYwzjaSiYz8ZZmPNytB+lIfzTBdQUy1PCPhAcCb8fhpUeE0UDDhK
	 obYke0CaEDXli2cCGguDQ+qaFPp3Nj0zGM4gUe5nqn+92bIxQrfdTUaIrwv0rekkomE4S
	 rj/cxWfzkU81lgSE/E9aNfQlkiZRMceGe6m3P9Y/Mwf76FZkoaoQATuUbix+6HsbaxKHO
	 peq6SpZklvw+FoZJZ1JfRU+HLsGvvmooauV/6AhLOzqxTWLVxWqZQqMMi6m/YX0gAZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mm3CIEpjoFlJg53ARDMGtP1Pmmn5bpt9P0/yTS20nsc=;
	b=WBdZcAp1Slp9Cme+m8XXENJoHrgVpyPFa3Rjz654bqvYoteH5BSH2wIYdQRAQr3Df4WH
	 kU1pNiUoI4aLRfeL9dcFBpfGL8Q1AhWbsGXg0XLXM1XvN4A9bgK+8aKwfI2FN+IeN519y
	 KCxye2wm4oyf42c3UPOlr4w70ACJbcxPzOtHGLSBcU4JjjgKVZmxVjlq9KP9s7AXzUsy/
	 2lx/WV2/0PNy1NhDui3jYsKaE8FhjiaBc5bieV4GQg16Yb6LyJTBIobzaNON9d7AYIyL8
	 qGgHloo6BfW3AlrmOpCt23g7ZMk+QqiajgImpjkZdddKS01iXBu8i83yAr0Btj8zHSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoYnmCIZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249F606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoYnmCIZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9861F01829;
	Thu, 22 Oct 2026 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693807;
	bh=mm3CIEpjoFlJg53ARDMGtP1Pmmn5bpt9P0/yTS20nsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YoYnmCIZLR+pfDdp1yJMYDFWKU2eKRcq5X/bnL/05ttkJqOHKvWj0lymLSPSGRbkA
	 eBshbX5P/BJlslNSIM7m4SviuoZFftzkXtUg/5vPTcH3J1SPD1MRnBYxveCG8riHSA
	 A3pofUP/WQiYdpQqf4os7cJ5o9jAHredeYAMFVdT62KO2EOm0KXc8sIcquyRcQaXRc
	 NNCtNqoWQDfty9jY7LArkrk4tIc1D4VsA71GmgCR5t0tKTw7qykAFb1h9me+TP/fzr
	 ws1GBGCzT3mLyFDPtaC21e8O90Jdc3TDvNxFKvGmNLeRHBtWAdN1mfYtYEEwY/Ua1c
	 PNWhBq0oQ6/5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8154E3808222;
	Thu, 22 Oct 2026 18:30:07 +0000 (UTC)
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
Subject: Re: [PATCH iproute2] lib/fs: drop unused full argument from
 get_cgroup2_path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179269380620.87273.1808231480893279444.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 18:30:06 +0000
References: <20261021153943.3754990-1-stephen@networkplumber.org>
In-Reply-To: <20261021153943.3754990-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 21 Oct 2026 08:39:43 -0700 you wrote:
> The only caller, cg_id_to_path(), passes false, and no caller has
> ever passed true. Remove the argument and always return the path
> relative to the cgroup2 mount.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] lib/fs: drop unused full argument from get_cgroup2_path
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=eb6a29fe096a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


