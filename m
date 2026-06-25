Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBD38236C;
	Thu, 25 Jun 2026 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352223; cv=none; b=QmmCAUI2kCFO+ncfgEpM6siVnXlSvvX5vNuFt5RFh2EaI+mVKX3Do3IyNHM8551Mfmej+lriCT1RWPKyQLcefPlkLaPS+A1wbxIvD4+B0jC0Tkw4Wfp9Jrzvf5H/IRug6+26Ct6TNrRbI0HlZwLoEoqZQ6xC8xKNnRAqpOZjOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352223; c=relaxed/simple;
	bh=3SSekSvY/kw3gqgvYAAHvbkrEmUCGyGNlJrnEptlnIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fhxgJxLXfXKE4M62qEQbgmJnzOLFHwWSt1AgLmITvoJ+bS7YFPPOvFPMSZ5cQeVkrlHTuF6aRizilriRPUADAZbLAPmclC/GybIB/O7iKfvocJzw4BhZOU976u0FQ5tSowf8yVSJkpcQtyGGgPfm1VaJAXYrqCdNrcB2oLWxBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdAStIHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdAStIHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990641F000E9;
	Thu, 25 Jun 2026 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352222;
	bh=fLr5SBaZROw1uH9V+5+Th0+iftdyQ8kxpUCEzchCZbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MdAStIHMhmy3y12zampdtZNw4a7Gp+afOQhWGehx516Jedz5m9Fjhe6BDo5kHEYkK
	 +kbDqrVYTudTSMRDOXk/yMKX7vhf5kmAyxEwCpb5paM6pVvbMwWKS4S8Rbt+6XyYg3
	 Bvw+QpqHZJRJIE3hdMdGRM0gvTfIYFcQPN2q2ubj4GZBzgbSrWtIblL4KiIm7R7kD+
	 VW+yV8b++jn5ZZdKzhV4kF4q7flOM8+1b5P2Lxm1tSOmHLvmAwhyzGylfYXsFU7EOP
	 114N43SkeVUkc8IE3wP5xTK2DAU+zxDJliz8LXrmAjXFLQUnpVF1yw4hfgJ+Z9rNGd
	 KeIyH5K/Os/HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A2C3AAA6D1;
	Thu, 25 Jun 2026 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] octeontx2-af: npc: cn20k: Fix subbank free list
 indexing for search order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235221055.3075556.4312731991418835345.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:50:10 +0000
References: <20260619095100.1864440-1-rkannoth@marvell.com>
In-Reply-To: <20260619095100.1864440-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sgoutham@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 15:21:00 +0530 you wrote:
> subbank_srch_order[i] is the physical subbank at search-order slot i,
> so each subbank's arr_idx must be i (its slot), not
> subbank_srch_order[sb->idx].  The old logic mis-keyed xa_sb_free
> and broke allocation traversal order.
> 
> Populate arr_idx and xa_sb_free in a single pass over the search
> order after subbank structs are initialized.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: npc: cn20k: Fix subbank free list indexing for search order
    https://git.kernel.org/netdev/net/c/429ef02895db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


