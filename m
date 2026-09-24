Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD64ADD9D
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273489; cv=none; b=nF5qMrioPRqA6P7huxJlpGGSX1nbSvR/JQovwy9ebUnrOMXJ14UxOn1x4TjSll0fqNuoP0QBDpyotZ2O7kwZfwu/YVfhscl+IWcNBblS3kzpk6oQ6R2BXcA8GWlktcoxfKN6IbdCDxCTuIXA4BaV8Me8Ed2s3dZRHVJ9KkE53Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273489; c=relaxed/simple;
	bh=x4pfYfzvbPMJGswUxXKpHNRIJ+FOjMz971Qj/p5Cc1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SCy0z/0bDClJlXLDY8ZdzggCHtX6oEmFLO4kDB1w3hJ3J5oaSZAyN87rJH1fBiZZG44OBu7uHqwlq1NRnHegMnN5REd6qRJ5DILKpYLKt04HvfgLjGKuGVKOT6YZiiZM4j1Doo5evwM+FJ4mBnCp/jge4oDuda/w0IlcZwRomFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQCIHUz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQCIHUz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343511F000FF;
	Thu, 24 Sep 2026 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273487;
	bh=8edLSRyqC4WqsEthY/id6a+TiwJNslqzFASjci0BLlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FQCIHUz0swEYPoNkS8JEOgnte0EVeD272M1ryQx7B1MxFTXcqJZDwdVe3izFKl6gd
	 LPYECZS9Xaqi5y9CAWRGd9v3zUvUl7HMDvovJQImGWGLtbqxuNGfXGnoQVo0fvX2dS
	 gDnPWo7EWwBr13MC3zw1eQ16HCJB//dXvq4j1k6U2PdeMHPPWoz7nwda7txzKW863Q
	 D2ra3dzLGNoCFlyuHu5wrWDPR5J6BE3OwFXDRHZpY9Xh4JdB5CbJ+BFeS1EqAqTfOU
	 Fgzjzwv6pTSMZwDwMtCxJAA85YPnXk4Hz+FkgJe1B1iy/fwMmf2vb5rnmCVQ5W0SVz
	 RlcFV3ofgfvSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A503A566DD;
	Thu, 24 Sep 2026 18:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/4] vlan: ensure sufficient headroom in
 vlan_dev_hard_header()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027341588.1690644.9685804588614580590.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 18:10:15 +0000
References: <20260924082951.1599377-1-edumazet@google.com>
In-Reply-To: <20260924082951.1599377-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, edumazet@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 08:29:47 +0000 you wrote:
> Callers that only reserve ETH_HLEN or less, or skbs allocated before
> dynamic device/headroom changes (such as toggling VLAN_FLAG_REORDER_HDR
> or bonding/team switching slaves), can reach vlan_dev_hard_header() with
> insufficient headroom and trigger skb_under_panic().
> 
> When vlan_dev_hard_header() returns -ENOMEM upon skb_cow_head() failure,
> a few callers of dev_hard_header() / llc_mac_hdr_init() had pre-existing
> error-handling bugs:
> 
> [...]

Here is the summary with links:
  - [v2,net,1/4] llc: fix skb UAF and leaks on llc_mac_hdr_init() failure
    https://git.kernel.org/netdev/net/c/72f9dd522f8d
  - [v2,net,2/4] bridge: check llc_mac_hdr_init() return value in br_send_bpdu()
    https://git.kernel.org/netdev/net/c/ac704ff08e51
  - [v2,net,3/4] net/sched: sch_teql: fix shadowed err in __teql_resolve()
    https://git.kernel.org/netdev/net/c/907b978e82cb
  - [v2,net,4/4] vlan: ensure sufficient headroom in vlan_dev_hard_header()
    https://git.kernel.org/netdev/net/c/cd5dd68267c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


