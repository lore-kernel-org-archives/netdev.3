Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8328B4FA;
	Thu, 25 Jun 2026 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417493; cv=none; b=WqmxLsBPFedeQ+9f9hmQv6XBjTQWc3c8P/L0CYOlDs6D113BW/KdcAwI2VG/rqHX1b7/efYchTHXIhLCXQ71wT9Y6v1tUtaNihljKw1GF/Dl0ZArrO6BLolczcaEYmBkZmLFcUNMHo5w6+AT5I42utYDR+xTFJ+vulS0+QclmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417493; c=relaxed/simple;
	bh=qb1u0vScj7FLjH/sNMNxcd0esd2cUUOBDSYeAlpL+5g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VNxkiXTIX41KO6tzk7CIrT3OfCASrM66CheqG9Vo6JPczUA6vRT2ND/OtF/S9XWk0R4oQqdA3FzWSTp0Up7JlEvMaUd61fiEPqjNIbdtPoWIlahiUNKNnO6Uk1zHIUpzcw6uyZ/D7ndeEaNT38fDipOxvqD3cv/Y5NUnN9tGo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gisNpnEK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gisNpnEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0521F000E9;
	Thu, 25 Jun 2026 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782417492;
	bh=q2o7aNFECAFip6eM+iPN+ixqas1Ic8M2CAKq4FgVv5w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=gisNpnEKJhh1fJ2WlR7hwxTmaGTs/8kapYZXfdIv7OSLSxAJwlGQv0N0YkCmZlxNJ
	 PNmsx33BjjP7hBUDtFDcP/kkLdUn5U9rhIqVWr5zutqHT8npcnvG7Dv5D6376SdEh5
	 Ds7u3UFGJLk6C0/gSrtK5v2J2EnNEBPVzGAo5RJCrjcrEZe0km9GW4T/U9yOwAcAtd
	 LtpUQXFPex0B1PFbUoGQRE0jKk7g8ITkLf4vc5d9/whsLCUvNXCfKqIwK/3h9fvHpG
	 1NXMdd0uaJkt/DP/FPYfcriU7ZM64TVSpl/KGzQ6dSjVFr6SPDfOTukpu3YbZiFNth
	 iX/vbqW+UTDTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D096439387B1;
	Thu, 25 Jun 2026 19:58:00 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260625174511.745883-1-kuba@kernel.org>
References: <20260625174511.745883-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260625174511.745883-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.2-rc1
X-PR-Tracked-Commit-Id: fe9f4ee6c61a1410afd73bf011de5ae618004796
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 805185b7c7a1069e407b6f7b3bc98e44d415f484
Message-Id: <178241747950.135849.13612730708171441780.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jun 2026 19:57:59 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jun 2026 10:45:11 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/805185b7c7a1069e407b6f7b3bc98e44d415f484

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
