Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6641BA69;
	Thu, 24 Sep 2026 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277505; cv=none; b=T+nm3SZ2AY88Blmdd7UswJTjJuWun9pfwdswCdYFwdH1NNESpEsbvI+rfag7kIJJtWoUeLxMJ3v6/uZTer2EXAI3G4dj7uygssWYcUHYazdXRloW7lOQ3Ib9kWy4GvuwlUTW3NuyjuVW9yNvt1f6SxfEs2rHIu1Tfcug+OP0s8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277505; c=relaxed/simple;
	bh=WAwXp/U5tVHU0a9gbCIzP+iepnbgs64yxtHQN5a3hmE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hxsNB87a4yLBNNzie01N+/wq09+WCw13FRGBzISMQKBwvAmSlPwRzuLJOMQ/ev5mMN9uLJtTIOLlGrp6p4x3aCZU4gvDMKSM3DoA8V+gxiR4iR+7aP/jZ2pYem8Q+rXnNsWJvvj8dG93CR0VTo1X/qN2bAakEBeG9Cr6TybSxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp6CAzcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp6CAzcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA02D1F00893;
	Thu, 24 Sep 2026 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277486;
	bh=x09ZqsA6gVtmyCFCOTPNyI+rh9sKcO2Vjjce4oj+I3c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Pp6CAzcqlgqLNh4yWBqqstle0cVISoH42MT6Oq4+ruX6QQZ2ZxgunmajV5XyeU1f2
	 MT9thQ2GiXsME7ZGSq/gO2xDwwIA9xTqG55C947CLqOKcrMIz3SEOsFhYf/gDCAAre
	 1UM6jzUu+4wMezxI6wf/vW3rzjPEl9QCeYIsaLKQSixyUHi3bljMUUPggF63bCm3HB
	 7X1UNz1u9MQrAw8gKjgfZE4U4lbxTlFCiZPdPPPuF8xV2MM2rmJHOFpPXjpmZBut46
	 ATrr3jg6I3duQ40ZcHUw/E8pll8PpOJEBtIDn/Gp6ti/jrnbnO26X0eFFlctOc+qjn
	 KKAWt9/ebwtrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BD03A566E0;
	Thu, 24 Sep 2026 19:16:56 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260924183257.2700506-1-kuba@kernel.org>
References: <20260924183257.2700506-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260924183257.2700506-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc5
X-PR-Tracked-Commit-Id: fc6d80eb504458d6416b75a94188b268c95c6533
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2c53ea949c5048f96b3dbb5a5ee7131ce4ff2de
Message-Id: <179027741534.2162561.9743404400272468427.pr-tracker-bot@kernel.org>
Date: Thu, 24 Sep 2026 19:16:55 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Sep 2026 11:32:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2c53ea949c5048f96b3dbb5a5ee7131ce4ff2de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
