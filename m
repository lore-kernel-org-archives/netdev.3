Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C43D561;
	Thu, 12 Feb 2026 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770868733; cv=none; b=ODhFHZExtRG7xCH2muBxrvQAnEjwHyiMw90w9f+5OF59BAh/vG8ufwrNZaktEahn8no868IcvT/9CaE2ASzJHggQSaMM4Z8KqDHW7/il/uYeJDNdbFPMt4e+OsffMCPuymi6XXf7KupTJblqktbyZmd/7/wRFqMP4Uwo22TRiAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770868733; c=relaxed/simple;
	bh=iuud4dfBgWcTWpYzRI2WcBkPDt2etLmopew1nqbZRao=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KgqLSB6gFDeYzj4BDm2yjrnar1z9ZoXR8qEHVB7MxK6EVyBnJj2+Apy+w+h+NG9QXjrTuOsBk+9rh34amH6/jqyHXxF/+S8mLDiPaYbS99uTVUjWTj7U624I6XKa4xgKD75yoohzHWfe/dm4tBgGS/PenEd6CEpD/kl4JHgm+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd7Rc6cz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd7Rc6cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A12C4CEF7;
	Thu, 12 Feb 2026 03:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770868733;
	bh=iuud4dfBgWcTWpYzRI2WcBkPDt2etLmopew1nqbZRao=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wd7Rc6czyGQR4iZ8xSMinWh/LQ22d6OujDplmz0mlH3kJRpdN1xlHgZ1nKpOebBcI
	 NBrmxsgfe2+n0j52MqihMMuHuUgpvSu3PAJLYV46xx7tO3H0ElSxHHfKTo4EXd6gRv
	 xGS/rPtiQNd/+txuVXV+mXzBcai7Ux6Sczlr2EBENYRbyAD2fGO05oQHoF4sw9F0It
	 DzAeQHS7VY46G3xjDiML5hFyxvPulpuz0fPdjCyr833v3Uy3PhcaXbFfWVJwKYWNKe
	 LrX/Tr2k2zJT4BdSMzQ8iB8FjD0NrsZJ9/ZHnYOjl3E1HSbpSWNc0BIyVsH+QRJQHn
	 NJsRWvLonZsKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AFDA39EF966;
	Thu, 12 Feb 2026 03:58:49 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for Linux 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260211173015.327542-1-pabeni@redhat.com>
References: <20260211173015.327542-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260211173015.327542-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git net-next-7.0
X-PR-Tracked-Commit-Id: 83310d613382f74070fc8b402f3f6c2af8439ead
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37a93dd5c49b5fda807fd204edf2547c3493319c
Message-Id: <177086872768.893578.10908851126305335061.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 03:58:47 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Feb 2026 18:30:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git net-next-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37a93dd5c49b5fda807fd204edf2547c3493319c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
