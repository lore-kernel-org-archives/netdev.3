Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16F3A3E9C;
	Thu, 11 Jun 2026 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211527; cv=none; b=qR0dLh2ZfNdcOMbYZVPNKbGyzrZE7Bk4ZwFtLTPB2GY4pTUa24m5f0C0EmsQrqR3m8StOKL84XlPKiiGMkmuHFWyOvML+bQ+xMo2oC2c31PQx41RfFLZOfJ3qidXlFqpkFnO9mPCNjXpFYlAu2vd+xUzVRdIIrcV4JOnDn0Ubaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211527; c=relaxed/simple;
	bh=fnhbFUzJ15Ee6bbkZ1nE0abkGJD1TNnkQwErHQMLL/U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kjPfLPfuMCOV4u/1pePzQn+1cHchHERAKH5f2TYmz1FTeolIGlnUYQqqInaxz5BxstgrSQqOQ2gxgbgxqM5SuP2ULsHMO9QGOP7hwHqB4TidRgzfN7V6SxHkJwg4F+xYrHun11tdKvGBxwlbXVxpy+gwSyRPnceV8MkGjBT8oIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7f4WWFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7f4WWFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C761F00A3A;
	Thu, 11 Jun 2026 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781211526;
	bh=VMkDy5SSTKPyifWZCnQOZ95JdFVTYKesLeLPOaI5Kdo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=O7f4WWFwN2smPxrBLA5jdJlZiXznasFQcS+nQT/eU83qGvL1IifzSy23Rr3lDVH/U
	 n2eNAKf11WZmtodURWOVd2XSmEs1gOaSSz8m2tLjhgNo5XOFzV1n2N1ebLSkaY/T+a
	 +IEXSk3HY+CShMf2yyfBdQBXhFGKsQ2BtnYrEzpuQAkoOPocJ54t/1niSMA2eKUIKa
	 6Ry29yxWW4SBNCk+SSvm83RnO/eD/jwexP2c20UfQnk0HeczxGXuUzE3/e0AmTy+t/
	 H1MfsveR3IZf5t+aMSwofCWQ93Z86l7MVoSRo/mBdSDVbFPj+8gVJwJ9W5kt8LuZYc
	 og2C0tPcjAEUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD93930FAA;
	Thu, 11 Jun 2026 20:58:44 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260611133405.310703-1-pabeni@redhat.com>
References: <20260611133405.310703-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260611133405.310703-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc8
X-PR-Tracked-Commit-Id: 7360b96099806396f4ce15233f6dddcb69248d34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22e2036479cb77df6281ebbd376ae6c330774790
Message-Id: <178121152344.362744.17108091307200549626.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jun 2026 20:58:43 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jun 2026 15:34:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22e2036479cb77df6281ebbd376ae6c330774790

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
