Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87916192B75;
	Wed,  7 Oct 2026 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334809; cv=none; b=gTdT8+OXz2WYJwrVFfltTdTUUQKgl8HQLdWK3W51N4rSh1rdl2hJM4bDpGeJyAHK9Y1znWkUQIA3AIVFX4tl91aq+OcXpaf+ZR+OW8srCXdQY/3xHyPRy+fhE5XT6spu0GJ8sjDPvaYWp6BuyJR6udizRjRtrDh6TExcNBaxIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334809; c=relaxed/simple;
	bh=JUA5xsbq0QK/OZqJfUOvPB03AgParYJpaWlgnS2iyjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DsTJufhIGS0lFB/EOGE9LkMQUZxTBD5yQrojRzStZcgB9hJNuMo/HJi6PWNroJ/iHRPf012Wwus9CG0s8M/wjMgkwvtpeUNtUz0mVmMjaRWmOg2nvElqIgGttZLCEG+PN8y5ucbGlQqFWfph1i1L5ZlRYD+vi3gv7JEfRjvP1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9B7hgzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9B7hgzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064781F0089B;
	Wed,  7 Oct 2026 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791334808;
	bh=WgyeKo20gE9PIwcT9MRnf9cAGj+iWAor5gvBCeDjRVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k9B7hgzg58n1e7UHZohDkva59A5B+UnIIeqsOd+zMCI5ow4o8r6zigrbrxmQKwt36
	 WlsHtJjUDibp/kCX6hkCwbc5rBbz1YXjMJBG7kNJ+av8MMW5MkJRLmFAEdG2oho4Jn
	 Ulyl4f3RYAyZHQ2zZrDHX0SMzhDA8d3S4X8k+1FNtZoHfmH6inU9F+/Jtj38P95UcK
	 dkH4r2mXYlGBvK6IQizByXIPWEAkzzmBOEpChNTE1rFvJRm5obfWUmPhEzP6lhr+vd
	 Y14v6MQR18ZP2/5GU5kYBpvsQ2r//T848BqMrbip/+FAoj03fSnD0M3fS0AhZHWYI5
	 Fl/Z9b15rTXVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F138E3806541;
	Wed,  7 Oct 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: dsa: qca8k: fix MDIO error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133480677.2850681.12615149653260744241.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:00:06 +0000
References: <20261003172405.342-1-yongzhao.derek@gmail.com>
In-Reply-To: <20261003172405.342-1-yongzhao.derek@gmail.com>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, ansuelsmth@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, john@phrozen.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  3 Oct 2026 19:24:01 +0200 you wrote:
> This series fixes qca8k MDIO error-handling bugs found by code
> inspection and the Sashiko review of v1 [1]. I am not aware of reports
> of actual MDIO failures, so v3 targets net-next without Fixes tags, as
> Andrew requested [2].
> 
> The patches propagate register and PHY access errors, skip MASTER_EN
> cleanup after a failed page select, invalidate the uncertain page cache,
> and return management Ethernet busy-wait errors so MDIO fallback can run.
> They apply directly to net-next; the separate qca8k MTU series depends on
> the write-error propagation provided here.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: dsa: qca8k: propagate MDIO errors
    https://git.kernel.org/netdev/net-next/c/d11306ac2689
  - [net-next,v3,2/3] net: dsa: qca8k: do not clear MASTER_EN after a failed page select
    https://git.kernel.org/netdev/net-next/c/2fc23f832e30
  - [net-next,v3,3/3] net: dsa: qca8k: fail mgmt Ethernet MDIO access on busy wait errors
    https://git.kernel.org/netdev/net-next/c/fe0811dd1a33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


