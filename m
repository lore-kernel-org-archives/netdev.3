Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF637F32C;
	Tue, 29 Sep 2026 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681461; cv=none; b=BjsLXsOM3UvaoZ90bZtXNK4KdC/Qab/veAxIdcQUiR62uVAg6sxDJVSBrwQ5HPz++yIHIPhDfJw4RcWoNhPEZKKLclDVqyqMf1tIUsmJt7Iute6MVD8kZ2gbkX248z9U2ZQd/+8X9ERSC9WjinyKaMYsoGWasI89gRLiHGpAyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681461; c=relaxed/simple;
	bh=W+ZVgUliYhGGTsZisBO1nwgDL7JEz1m/m4fjsMirKi0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qP1FR83EKkC/3Or/cHroeR7+VVssuStj7IKI0RgvWK2RqEMObXduj1/NWKNrDU00I5doc3xRTUX/uSCDFcCDw9EeUPKbMWy41wlXx8vZZthaQjLycL8nrw5uH9FPLnEA5QNoob66mzKxObUrt6zCJPN2JweNNqKREAbw2rClP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXTjp/nl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXTjp/nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8254E1F000FF;
	Tue, 29 Sep 2026 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790681459;
	bh=y9Nhf9RqGyne3G1VVo+zipSl/aAqSVN0tBKw4HZ6eW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SXTjp/nl6zOJRBUjVZi7rqrswDcMdlCGF+YRZznkl0tsu53IECPlMwOZpzkaR8PKx
	 i1ZnC3xVEGclTYjxH7rSUAwrEqwHt4wDFX597uSsC8/PTaIiceMZcy76449+nFoye2
	 OXRBF+zexwJ4Z3cq86JzK2G2z2yg5+vyzZ96tES2dcBY2hbHC39nsrL1oBV0cNJHNC
	 8BAOLaVqSoZKOCshh4ecicR5THWnMqXIBnFEPLzTx353OCQ7FFgPxr1Koq9vjRs3w8
	 9XH1I1s1cAKqODoWOmscnzEd+TZgQJD0DqhA6SuAbbZf/HiwWk4uj4eLFNX0uIGTDx
	 zprRYBCGTUBwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775FE39263B1;
	Tue, 29 Sep 2026 11:30:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] netlink: specs: enum alignment fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179068145828.441753.2003667630829452941.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 11:30:58 +0000
References: <20260925213918.204767-1-ast@fiberby.net>
In-Reply-To: <20260925213918.204767-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, kuba@kernel.org, donald.hunter@gmail.com,
 danieller@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, moshe@nvidia.com,
 kory.maincent@bootlin.com, toke@redhat.com, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 25 Sep 2026 21:39:03 +0000 you wrote:
> This series fixes misalignment issues in YNL-defined enums or flags.
> 
> Changes:
> v2: (got delayed due to conference activities)
>  - Add Reviewed-by's (thanks Jakub, Moshe, Kory and Toke)
>  - Patch 1: Add "fixes" in prose, as Clashiko guessed wrong.
>  - Patch 2: Mention renaming ect{0,1}-pkts in commit message (Clashiko).
>  - Drop old patch 4.
>  - Patch 4 (was patch 5): Remove redundant enum-as-flags (thanks Moshe).
> v1: https://lore.kernel.org/20260911214148.1184806-1-ast@fiberby.net
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] netlink: specs: rt-link: re-align IPv4 devconf
    https://git.kernel.org/netdev/net-next/c/e769837e4e5c
  - [net-next,v2,2/9] netlink: specs: rt-link: re-align ifla-inet6-stats
    https://git.kernel.org/netdev/net-next/c/621524a737f1
  - [net-next,v2,3/9] netlink: specs: rt-link: fix ifinfo-flags names
    https://git.kernel.org/netdev/net-next/c/306df818cc64
  - [net-next,v2,4/9] netlink: specs: devlink: fix resource-scope type
    https://git.kernel.org/netdev/net-next/c/bef8442f5ffa
  - [net-next,v2,5/9] netlink: specs: ethtool: re-align c33-pse-ext-state
    https://git.kernel.org/netdev/net-next/c/fe6a71dc0fbe
  - [net-next,v2,6/9] netlink: specs: ethtool: re-align module-fw-flash-status
    https://git.kernel.org/netdev/net-next/c/a9a98457342a
  - [net-next,v2,7/9] netlink: specs: nl80211: fix naming of enum members
    https://git.kernel.org/netdev/net-next/c/479ecf856c21
  - [net-next,v2,8/9] netlink: specs: tc: fix typo in cls-flags
    https://git.kernel.org/netdev/net-next/c/5fd016f357f7
  - [net-next,v2,9/9] netlink: specs: fix incorrect name-prefixes
    https://git.kernel.org/netdev/net-next/c/8450becb88f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


