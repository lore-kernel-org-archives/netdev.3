Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C663403E0;
	Thu,  2 Jul 2026 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008466; cv=none; b=IPkfHB+LINW84eCoPGT1a3x/czE9AjwI2wf+idCKPw58UzYNw9axsTyOe+8wjQIcnEvFAb46ZS/PVu4CEnPSODzuqffPjKHsYkJ48GuigWu1iO1gdjOhrSjSqnVuzku9fNzy6aigXoqh+Clq0MPSBUF6e4kE5WrOSHfA6Kan75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008466; c=relaxed/simple;
	bh=aCMZrfedDCy2ZiBPvr7bFgfFPfLN66OpswmbceIhilA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RDc1QYYtFHSzuVAr7MHBFEgJCNJh+lmY0w3m9Bu76If99sY+gPgg9969AHrhKnOMPHeRVr7aitp/wxvc1jCB1UIQW5qVH82WYbIi4QSJBxECc00KxcxwRmHAWgK6+Nfz+D79J1P65tz4MLYdx1ood7RSJ6+JbLhvjR/wn+a8728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecE+V5xA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecE+V5xA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E811F000E9;
	Thu,  2 Jul 2026 16:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008465;
	bh=bxRbsHh7DGrBnH/elhn8IT7S7zGFOJNmergori34DvA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ecE+V5xAD3ya91rHi7O6jiAUZ2g5sp2hgTp7F2GGs8h6lfgnSh9+QlaSko4dnIQFR
	 BkPrFv6crSEcpjNn+ESJkChbFCziZTUpBke24yV01WUTVn1cfk98csABkDoUtGbtYY
	 +7+Isx2Ow94PfuS27uxMdIS2chhwuH5+JjHWXuEXkMtxEUDLYbTqXJi9cV2+m57FrT
	 PPnFGnd4A9uV0sNqi9cKFBCsJh7tVc0TtSj5YseiJgDwhaqlpclkgv7HsD6WbKaOOe
	 PabmldopXMMkJQx4FzrTXWP1LQJy2cGvD0P1F65uwwDcDumys5cbhi64CjTwBcsRmn
	 GWrH2YTvF8XKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C123930934;
	Thu,  2 Jul 2026 16:07:29 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.2-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260702125444.230438-1-pabeni@redhat.com>
References: <20260702125444.230438-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260702125444.230438-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc2
X-PR-Tracked-Commit-Id: d8e8b85a85fe21954d303db68034aac4639df88d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87320be9f0d24fce67631b7eef919f0b79c3e45c
Message-Id: <178300844841.1754005.17953259672059371615.pr-tracker-bot@kernel.org>
Date: Thu, 02 Jul 2026 16:07:28 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 Jul 2026 14:54:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87320be9f0d24fce67631b7eef919f0b79c3e45c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
