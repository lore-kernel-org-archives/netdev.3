Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4032ED3A;
	Tue, 15 Sep 2026 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434677; cv=none; b=FVp370mR6qbbjxU75qLoEAYwSHlqmKsla+l5R5bekyvv7TfZl6s6GAPU3TvscyAwueSMvXRIVdCf5wRT3I6iEVOmW+p0ZyQSfja/ox5z/aPUbaUmg2EQDhVMqeAjzO9b7gHGNMR0TqLkkCFn4z15pXTqzr86H3fAiqiafAcHVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434677; c=relaxed/simple;
	bh=HiOaTGg6HouYWO0w6AVrwCzUYU7q5KrU94Bf2h2JIe4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SyQIjm9f/sP+6DqknbC1Ri5+d29+DOPfSbMUM40wH74Sc390P+RQqkEjssJzspYCtpbC49gQev1pf9SOcfbAbwx57R9cgPVa/4W4/WxDIDjdEbaSxT9jBGEWWhxGNWYPxL5gP1tSt5umiI09wFbxsioJKBXHzNFMVxxON95+GJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmpYtDAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmpYtDAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7D11F000FF;
	Tue, 15 Sep 2026 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789434675;
	bh=tLhgA32Ri4X7Vu+9VyLSYck5Nt2o2jGtMp6BTr7SdYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZmpYtDApcNihhPqFGXYHXYNTezmUG3LW/oNasoeXe+8PnAuTOifkwJ+Cz8a2s+Qb7
	 XRPelQoHgFqISdqiOeYurfdjG1Onf9SszVG6Xrje/KYN0SfCzEMEiMjSRePn4b7l5a
	 jJEb72SmLGNC69sdVuBS+AUgYckpzKFxzsc/BhCxuNfQlbVNmfIynzyfMriO1Lpkad
	 wkmlJyimH0RcV0ZL2e6gC398tSYf3d8OZSNxH9sHL4pchfcFjExw3+fAZaVrm0BayZ
	 dk4rglPUG0008KhkIcTK6XARuAaEKMa2bWBzWa/XKactDMYH0mt3Al7C1IYuewGVo8
	 ejWOxps627RHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93E163924FFC;
	Tue, 15 Sep 2026 01:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipmr, ip6mr: annotate data-races in vif_seq_show()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943461031.1296630.14538685526248597246.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 01:10:10 +0000
References: <20260910093452.2070079-1-xiaolinkui@126.com>
In-Reply-To: <20260910093452.2070079-1-xiaolinkui@126.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 17:34:52 +0800 you wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ipmr_vif_seq_show() and ip6mr_vif_seq_show() read vif->bytes_in,
> vif->pkt_in, vif->bytes_out and vif->pkt_out with only rcu_read_lock()
> held: since commit b96ef16d2f83 ("ipmr: convert /proc handlers to
> rcu_read_lock()") both seq_start helpers are annotated __acquires(RCU)
> and no longer take mrt_lock.
> 
> [...]

Here is the summary with links:
  - [net] ipmr, ip6mr: annotate data-races in vif_seq_show()
    https://git.kernel.org/netdev/net-next/c/0019aa65bbc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


