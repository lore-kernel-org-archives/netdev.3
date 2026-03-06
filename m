Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DC39F190;
	Fri,  6 Mar 2026 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832606; cv=none; b=Lp87xwyLbuoI0D/bDPCTj2wKKveV6rwMRD7X58dGhsT4X0YxSLjmEz21dyXyhux9vLpdVDL2B+n2PD9YhAztTmQ/yWaE2EEwuIyZjla9/G37OBaLjde/h+Ya33hkUHtmAQ4ImsLOy4GqOzEh+i1vcCWbUM6rHYRghxiXMiXZ1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832606; c=relaxed/simple;
	bh=nGBtxW+NexuqnWTIi8pax7D3YZzdb4cisjdbTkAVJ50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=epvxbeyzWR2DCN2xy/IxgWjxK0DXZPXC+Kr80l4vsnkQsvmdO5VhPq/AZHOtSVYM6QwraHlhihHAhNm5ZUYBBlMbqK1qq1T80mZcqV/nF7cFcgCkuwPOQ8JljLAMhREYDazqLkxLhiUfejh4aoX4cExLYkxl62xa6m+GbCWZQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdRC37sP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdRC37sP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900D0C4CEF7;
	Fri,  6 Mar 2026 21:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832605;
	bh=nGBtxW+NexuqnWTIi8pax7D3YZzdb4cisjdbTkAVJ50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YdRC37sPE+NKlWYysRi5XQKNojNNDUE61ohS0LkEKed9mjszhxGerQKRf0KyVs8dR
	 /mIqScefvughLcYkLrr6rZbkRqrEuZ0TF3IW15CiGimCQcw9AyKhf+D0vUpO1aTrpy
	 /3pNGng5LBl/dpoizKW7wKTUYLvq1s9G0YCHdC7CsXxiNHC9Ok+7TjXt9bvCX7MBp3
	 VzbkN98K4q+mlT2NAib65b5JmhCaYVcIE2eG5tSPm2hIjqlfh1z3uyQNDUjr4jQGdI
	 z5qfQ5NET84Itym/t+tc6j2DnaqkO3iJIK24CVbA3WmVaMvfK3tJCEiy/SDOi5CB8E
	 a2rWvMq8HKAkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D8E3808200;
	Fri,  6 Mar 2026 21:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing T7XX reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177283260480.58743.5861072453468006740.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 21:30:04 +0000
References: <20260305172806.3118806-1-dave.hansen@linux.intel.com>
In-Reply-To: <20260305172806.3118806-1-dave.hansen@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, chandrashekar.devegowda@intel.com,
 haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 09:28:05 -0800 you wrote:
> This reviewer's email no longer works. Remove it from MAINTAINERS.
> 
> Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Cc: Liu Haijun <haijun.liu@mediatek.com>
> Cc: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Remove bouncing T7XX reviewer
    https://git.kernel.org/netdev/net/c/0e16181704e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


