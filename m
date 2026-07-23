Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECC8374A1B;
	Thu, 23 Jul 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814066; cv=none; b=o9xxhLDLyCsJ+yF7+eATwz0LEasjLuX7uldpeix6ivq19HMNzWnw0PPuUVE5m7bvt2lRS4Zv10Mud5u13cBt/KVqDYm46hVVBJWss3HmRGlOhFPXrWH/wd77w8XN9n8Q/RzKRy0E5EEj0avJrvcLUOmvnpx+baXnL74ubUcvz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814066; c=relaxed/simple;
	bh=4QePoeH5D8LzpkD+m3cFVRrKH33PDwOjnxhMJMgzmC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ujj9GHRM0FexIPeVYSwgjwmHrEvIw00BT6yw+3WepsRk130RyQi5QQzWtK7sH1Zh6cJJvqq0Hd6yeLoTnmDiO3W9Nl3PW0rg6hlm68mvg5RrXtO+VgTKJt2VNJaIH5W9kqnRN/+lbrjM9j30tWrNcOayfql/g9zuesjyjzs6n+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED7C1F00A3A;
	Thu, 23 Jul 2026 13:41:02 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568ED3810908;
	Thu, 23 Jul 2026 13:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-vf: set TC flower flag on MCAM entry
 allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481400989.2245010.5449256971816905423.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 13:40:09 +0000
References: <20260715052007.2099851-1-rkannoth@marvell.com>
In-Reply-To: <20260715052007.2099851-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sbhatta@marvell.com, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sumang@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 15 Jul 2026 10:50:07 +0530 you wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> When MCAM entries are allocated for a VF netdev via the devlink
> mcam_count parameter, only OTX2_FLAG_NTUPLE_SUPPORT was set. That
> enabled ethtool ntuple filters but not tc flower offload. Also set
> OTX2_FLAG_TC_FLOWER_SUPPORT when entries are successfully allocated.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-vf: set TC flower flag on MCAM entry allocation
    https://git.kernel.org/netdev/net/c/0d4d31e3cc5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


