Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177C4BFE8A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004468; cv=none; b=S0Ji1+3ak/7y7CNsmZehoL9oOQRYL8VAauPZYKuVY/Wz4z+NVIux9TOEyACYfxnFgdbZCgAzvIdqPa/B86cYxcGyTMuBHuX0BEotXC4Rdiz4vAemkeGWYAAv6FLgEAo5gN2UCkzmVbn54RS3zeg4nfpzvONqrOiWJEpEOYJwKtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004468; c=relaxed/simple;
	bh=kAVOytUSdWEPb0Dazw9NS7RCNzWwuHfZdYYz8VQgoMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RVqkiihrZ8gqM/YDT49VRhzVDb8j9CODgQGppmA4MmAsbdo91ORf+f+g3HwKvGc+o0mq/nNeI/o/rMkXToD8U94A8v8Gm0URnWcX2wpXQtmZn7cC/W2iqItS7AHRLnXL+FD3QbS3j2AVWLkIDgMvKQTJyeK/7/Bv/q3dR5C+aTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC9PBjes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC9PBjes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9161D1F000FF;
	Thu, 10 Sep 2026 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789004466;
	bh=yt3pLdkLzDVqEUfgCQDd7GI8yyuUvg9fGZpLcaVnU9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LC9PBjescwAGgcOkkac7NVx/TIqDRad1qRi+rHZg2g57QSClGZI6Gu9C+SFtJhw0w
	 njzpIaa490/wisyRR4FD5IT0ZxLENMdmoWe1vo3udY4A1IxodfcBlFm6Vpb6iJA5bO
	 0YFHO+DVI++svZ74fC4+Sh0pVd/J7mKke+0JSmEtaecB/+kQCMklXegnGKr77bzKvD
	 DnczqlZ4Eurcs4I3uI62eKyUht2lNQIB69nTmWgA2BLaGcoSWDJflCep1aai/MyMVv
	 fqK+W6WNHEbS2gldB480dRc/1mtuV+eCmqWFlkrilr9yXZ55Sz5HdZimLrQ/yTq/uv
	 phsQoUC5bx2Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9390E380CEC7;
	Thu, 10 Sep 2026 01:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/8] vxlan: convert configuration to RCU and
 drop
 RTNL in vxlan_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900440438.1145188.1302299676039586949.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:40:04 +0000
References: <20260906180111.1973188-1-edumazet@google.com>
In-Reply-To: <20260906180111.1973188-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  6 Sep 2026 18:01:03 +0000 you wrote:
> This series converts VXLAN device configuration (struct vxlan_config) to RCU
> protection and removes the RTNL dependency from vxlan_fill_info(), enabling
> lockless netlink link dumps (RTM_GETLINK) for VXLAN devices.
> 
> Patches 1-2 fix pre-existing issues uncovered while auditing RCU and VNIFILTER
> paths:
>   - Patch 1 zero-initializes _md on the stack in vxlan_xmit_one() to avoid
>     leaking uninitialized stack bytes into GBP header fields when metadata
>     options are absent.
>   - Patch 2 fixes lockless iteration over vg->vni_list in
>     vxlan_vnifilter_dump_dev() to use list_for_each_entry_rcu(), and clears
>     cb->args[1] on early returns to avoid leaking dump state across devices.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/8] vxlan: initialize _md in vxlan_xmit_one()
    https://git.kernel.org/netdev/net/c/be83178bfc44
  - [v2,net-next,2/8] vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
    (no matching commit)
  - [v2,net-next,3/8] vxlan: pass vxlan_config pointer to helper functions
    (no matching commit)
  - [v2,net-next,4/8] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
    (no matching commit)
  - [v2,net-next,5/8] vxlan: dynamically allocate struct vxlan_config
    (no matching commit)
  - [v2,net-next,6/8] vxlan: convert configuration to RCU protection
    (no matching commit)
  - [v2,net-next,7/8] vxlan: remove default_dst and use vxlan_config and lowerdev
    (no matching commit)
  - [v2,net-next,8/8] vxlan: no longer rely on RTNL in vxlan_fill_info()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


