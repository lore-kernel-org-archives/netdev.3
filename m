Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631238A700
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224469; cv=none; b=lRRMglYoL6Ss15TByGyuOZtdXtPktfYoCBUPlY1zFfHvKuO9BWvdFjJMWbt78RKwczz3NuPmQ9xjUJkL4ujiDfk3JlFlph4oNOJ+weB9+r3rXPr3TI8MSrCL5M2oS77fBd6OYVXc7uOXUYO2c9aq29vPz/sb3wasaDEY3EWA4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224469; c=relaxed/simple;
	bh=XDGacn4PA9HOg4GlRKEllwGfFbnf8tJtfSmCeQqjJMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bwd70UPY4DGT0KtFHG4620fDMn4+vMg2GfaaxRbvY0kDjoXKeuIrPGnnw3CmabqYO/fDxO08NSOO9nDsq7HxiarMOvTI5rlxq8cscpWfz9wNMJRz8ekyRr8CMWvSGAs0mCXg2BHoCj+MC2IqLJq5Srgl3dXgLHwAe1VY+P++W8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLQB9xID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLQB9xID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D0E1F00A3D;
	Tue,  1 Sep 2026 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788224468;
	bh=1t3ps1vpOh+Ct8PvxICzNXkN2Gd7gMoY84biDtDKVgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CLQB9xIDNcdzZwe/a+Kv7Np/Oh94wZLJx45V4smp7DZ6uwtm+EtYe9Rqu5Ku26tWK
	 rSosCOOQJB67Co3vrENrlUTBOJe2K+/sVF833VvVsRtlG67axSOJnOJBm/qJHKe40Q
	 ww5HVqnonw0ydF17/Vla2CI2MGmDsX1D0oVBJtaXDpBpRr+eH+w80oUIxHHQYpjQ6y
	 kKQWjLqY6KK6ZoZsAjs4BTCiA3MGLZ8UdBFM4ll4h4klyk4zAZP0BnejXWDXPvdhk1
	 cTY+nAj4Nvf8F0ouVf1m52Zj/Mb4Vtk1pNJDBMSYnJq6xGP/KjILOHucOFMuYug7Mh
	 aliMMqmm/Gtwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567EE3924A40;
	Tue,  1 Sep 2026 01:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] igmp: convert struct ip_sf_list to RCU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178822441089.861275.11689681327779869610.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 01:00:10 +0000
References: <20260827160656.903003-1-edumazet@google.com>
In-Reply-To: <20260827160656.903003-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 idosch@nvidia.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+3d99fb01bcd740f2fc1e@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Aug 2026 16:06:56 +0000 you wrote:
> Commit 23d2b94043ca ("igmp: Add ip_mc_list lock in ip_check_mc_rcu")
> added spin_lock_bh(&im->lock) to ip_check_mc_rcu() to prevent a
> use-after-free while iterating im->sources during concurrent deletions.
> 
> However, ip_check_mc_rcu() is called from RCU read-side critical
> sections in packet receive and route lookup fast paths (e.g.
> __mkroute_output(), ip_route_input_rcu(), and __udp4_lib_rcv()).
> 
> [...]

Here is the summary with links:
  - [v2,net] igmp: convert struct ip_sf_list to RCU
    https://git.kernel.org/netdev/net/c/2987ee196c88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


