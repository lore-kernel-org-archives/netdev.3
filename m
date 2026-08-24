Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65032384CFA;
	Mon, 24 Aug 2026 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596863; cv=none; b=BWWmlRGAdS6aCmjmtJMKkI4i18CrmrWruo+NZvbgTwOPUdMZOVudnOuvFbQptl97W/LgIcE1LCRlMi3XEgO6KZZUfKGUK7OQ/b38qz+DZ+hMZtbfH9coKHwi3DXp3zyuyxI7HoWYiMEWHEZLdCY4a+e8QfpMKFLAjbTzEcDoHnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596863; c=relaxed/simple;
	bh=S2mjxXLo7UJwAI9qOxtghRapebhi14SLwFkEt6DvSW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jHH7Idfws4GXzu0k6TihJi+adeYF0NqX43xnrCF/dI60InUs7E9ZbxCD4qM9saDa5UkYZlJhy7cq6PbVOubdu/U1MM+4Ok3szjYoPisaxkHaiKEeTV6lLY0Kae6BxTc9VeDJyOxhKoxnf+/cNd2Mupuuf6hqn5y5uOVl2/tDQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIgwQwXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIgwQwXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABC21F000E9;
	Mon, 24 Aug 2026 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787596862;
	bh=e5qHn83Xa55QIyGuRkYpwS78yLBda9QapjBZ7EeNwYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JIgwQwXEsV1HA1mO+m7TT0wkE2VpirvQqwfxviIhJfFmaCQZkRq3b28DfpKs1W2XM
	 qp1/sMfuq+eQMhLT/8cb/8idnO8rmDjxXTcagTAn7JBSP83zs+BSIU02wAIzdlWH0v
	 E1IkPb6zgNEw5MQbUgXMRKI6CWKErXd0YI12dBj91PGnppQm70VI7gEBp/MNTGhrIf
	 RVaf7fdxouDn+HWVv8mhpNzqVefyFT/FEPjfTJSvImr6p5aNwK1DSxeakzVwsgwEZS
	 uq0b/Oe+3pBy+aDIRZHRlNYtFiS1r25cgv2tkpxzhTKoATpXuCyXD4SMCW2EIddXTT
	 xovlKIdosz1Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A473924A4C;
	Mon, 24 Aug 2026 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: fix NULL deref in NIX TM tree debugfs
 read
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759680939.3058449.15538562043695507466.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:40:09 +0000
References: <20260820050333.2606095-1-rkannoth@marvell.com>
In-Reply-To: <20260820050333.2606095-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: agaur@marvell.com, davem@davemloft.net, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 wojciech.drewek@intel.com, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 10:33:33 +0530 you wrote:
> From: Anshumali Gaur <agaur@marvell.com>
> 
> rvu_dbg_nix_tm_tree_display() dereferences pfvf->sq_ctx without
> checking whether the SQ context has been allocated. Reading
> /sys/kernel/debug/octeontx2/nix/tm_tree for a NIX LF whose transmit
> queues are not set up triggers a kernel oops.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix NULL deref in NIX TM tree debugfs read path
    https://git.kernel.org/netdev/net/c/ec65631bd5ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


