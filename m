Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451A41D11A
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560482; cv=none; b=R8CATcKrYTjHafKGGx0fCCS30cON9X4QcS6Yc+kr1+FUzIRHT8JgE7NzTRCO3H0waItpMWfGIWJ42pnFurMZ68E0Z67rrE/mpfbLvoyLXIuoMxym473l1C+y5qAoCL4iZ3/LAB4x/N5PbbMRafYmfz4vu8xUUu4ELDX4/0q232g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560482; c=relaxed/simple;
	bh=V4ctWd6WFoTMdd8YiKIfywVdZ4v4aZwDkn+bo/qeLMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xu2CVk9BlUfdLz4u4/g5OLma0y3gdJxJdnC1IEL9muLRgZUYqAKypPHOx//dwrYoqyEn0NebZvp+tscmGV4cMgziXgAXvRVMi/39RbId47E5GR0+fZ2mHQLTtBNqsVOEbUfGr8cGs4gsqHPYeNzHWchJTKouJV7YfnxhBGUT3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEwkP/+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEwkP/+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E011F00A3F;
	Fri,  4 Sep 2026 22:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560476;
	bh=n+2elqq5p+QhuVibgp6hBvJg93OFzcDqSYm4htkXg4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mEwkP/+G7U5LCY+IFUAFUk2dZ4TI8OZSBjpPCAycdMt0Iw3YwSqUUE8DwJt2n+FHs
	 0FjHf8qvULpdv6mBDbL8Rnd/IGVbonoIPz9EeWcBQsQzbzF1/xItBgdoWOP1wlSbdY
	 TIiPJ7zYoVShyHB4oDHzDHVKTKI7LxXiC47+4AxiuEWknBZGEO+l+jfcZ/mzIPuxEM
	 vMc2ITD71c+bTN3doEsn6An91mpYzjYEyg31VBLGPBtGp3kWvTw6/9CDXImU9lE6L+
	 VYgZCR0lA8XNlA5FnN1te1ySW1mcAadUxRk8PeodyXZ/lbgklQgwaq+rMjHstys6gs
	 jtrO3hUmcoeSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A03924A7E;
	Fri,  4 Sep 2026 22:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nexthop: Initialize extack in remove_nh_grp_entry()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856041664.992241.14927364010425476713.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 22:20:16 +0000
References: <20260903080259.10378-1-idosch@nvidia.com>
In-Reply-To: <20260903080259.10378-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 kalpan.jani@mpiricsoftware.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 11:02:59 +0300 you wrote:
> remove_nh_grp_entry() prints the extack message when a listener fails
> to replace the reduced nexthop group. However, extack is not
> initialized and listeners are not required to set a message when
> returning an error. Neither netdevsim nor mlxsw do so when an
> allocation fails, resulting in the dereference of an uninitialized
> stack pointer.
> 
> [...]

Here is the summary with links:
  - [net] nexthop: Initialize extack in remove_nh_grp_entry()
    https://git.kernel.org/netdev/net/c/5bd9e4e7cdaa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


