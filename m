Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E183BB110
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780885; cv=none; b=D3ulmlINZkfGXIvheKJFdc69ctWedrznFUE0w9NaZJXkB5rpenHjjUBw4dqXx4q2goz75BQDrTiRTbNo+EvKwU7mazB/BUjCtWAnxYaLRretxRpJ7hA2XmVRRt0mRSW8gccFShD89ol9yLsif2qw6P1+errC7/8S8/8gZrWY/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780885; c=relaxed/simple;
	bh=R/J+60cmgTifL/lsGdQ6WvokKTU56ekkmz/tlJ1xjd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJfZRsTUBoOd2P10bH9FQZqt7p7kUMxIFxJSYoEEA4SgmpeT5kFqGAyIf1ipNy0lBM0oDtwKqD7Xq+FeHIkRKEh4lxDKGCeVIaeE8fBe7dpINKg3ZMOt/ma6Wabt9fW3NrQod0dxzu/SNTAWHixqjL42Fn28QMtRtE0tEQxYwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR2OFEsk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR2OFEsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E5B1F00898;
	Sat, 19 Sep 2026 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780877;
	bh=vI4HooZ0Rdhh+RM3oa4tFZta9tTk57F4tf1X83TAdBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PR2OFEsktlG3vUWLis1Bo4VhJ3ijkxPOS1xqvXgVwIOY0gD0+t8Xhppbok4M0igG7
	 VLkLwv21XlDQhLMOR4+W/gjRt0Dqa7KgVFOR4SrovkrD/GDgLRFR9sQYFYybxkKGR4
	 IZ+lpitMQCzoRbIQEUeN5g+el02nHVoM7qNReG4zH2HVZgCykdbl0LWFz48sUOB6sV
	 eIm2eL2eB3mFRQElhHqaQIoHEy9OKdkrurdeRMoTrbwpTZQ8VVwhQSWZLoxCq6EReN
	 6s4DmPLCVn2rI8jyf4JQVniIH1xIjoXs42iqsS3sf1x339SYNhrQelk8uDwDqhsrzR
	 2di3AYV/dOQyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5685C381197A;
	Sat, 19 Sep 2026 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/6] ip6_gre: Support per-netns device
 unregistration.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178978080989.1218950.5121197637169322926.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 01:20:09 +0000
References: <20260916230353.367014-1-kuniyu@google.com>
In-Reply-To: <20260916230353.367014-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 23:02:19 +0000 you wrote:
> Patch 1 & 2 convert ip6gre_net.tunnels[][] to hlist as a prep.
> 
> Patch 3 & 4 unlink devices from ip6gre_net.tunnels[][] in
>  ->dellink().
> 
> Patch 5 & 6 adds mutex and support per-netns device unregistration.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/6] ip6_gre: Initialise ign->tunnels_wc[0] before register_netdev().
    https://git.kernel.org/netdev/net-next/c/3e6af2e485e4
  - [v1,net-next,2/6] ip6_gre: Convert ip6gre_net.tunnels[][] to hlist.
    https://git.kernel.org/netdev/net-next/c/3b2813cc6b1f
  - [v1,net-next,3/6] ip6_gre: Clear ign->fb_tunnel_dev in ip6gre_exit_rtnl_net().
    https://git.kernel.org/netdev/net-next/c/28328796e0b4
  - [v1,net-next,4/6] ip6_gre: Unlink ip6gre_tunnel_unlink() from ->dellink().
    https://git.kernel.org/netdev/net-next/c/b7c0d393e108
  - [v1,net-next,5/6] ip6_gre: Protect ip6gre_net.tunnels[][] with mutex.
    https://git.kernel.org/netdev/net-next/c/cce829e2aa1d
  - [v1,net-next,6/6] ip6_gre: Support per-netns device unregistration.
    https://git.kernel.org/netdev/net-next/c/b27a8c62875e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


