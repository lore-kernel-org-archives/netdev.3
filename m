Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C15349B1C;
	Thu, 28 May 2026 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001917; cv=none; b=dkxjT1EIWKP7gnxeaDAqFuZSMagP5Mz1rI8Pty4KIkyZ1gfhbjc6GA4YJ3yOqhrEFDnEPEQzYxB2ktYJ/Eh0h2Hpmwfd1pgc18ZCbOM3TEh9wO78fdJ43FEDHoaePxrU4ZYHxz3NN/46sEeLoi6hN9ci1lX+NumGArAmnsKnP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001917; c=relaxed/simple;
	bh=vfHceFHEZmyoFgy6dn3oTiqQUVuPza/cLfUdRnjc71Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tG1CcKP0Qqc5dV9W9+UPUy6+zsIMVLi683v5xC/kFKpQ+g6KFNzGSG5/zo6m5jzmK0/Dt/z063uyMNGDHio7POXV0AB2aHdiXwWxcG53Bl1ZKLlKuEa0d3KbRHj42viwHWSfJ5fpYF6se2iacZloTI2QTdntoqqdMHvx8qQe3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBqp0D66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBqp0D66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4021F000E9;
	Thu, 28 May 2026 20:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780001913;
	bh=yPgW/NnYfr6ga2rIrqUt+HCLe0OJTmOw+dxM2oqQ0gs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OBqp0D66IhhRG48/kQyXiSMzSiQaPRCOCQ+XNtvmHwlKgE4DEdypPN6cGQlj22mpx
	 GR6UoxazXZxT8xZjigYlIrNp33iY/sbsdEcQk3OyUjKa87mtNu35p2waP4ioynyq/6
	 RBjlZyNEkfjAP1sx38v3OoxRyrBKfjqhNS5Z3KVeZTs8WqSju4AQ79vE2FTumOwxPG
	 sPrMad9c3pXsCUKsM80lYGYNjKW4BQOOpSFh7GMBTPDalEAZKGQR8epQj0Mba6h1S8
	 5cwNGxqCNjV1MuJn1TpgB0KgW8AyTCVTQqOxj5wQVdATGsE6hezk7qtiv9+ArTmTyo
	 y3aooQS2ArTpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F7E381196D;
	Thu, 28 May 2026 20:58:38 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260528145004.323168-1-pabeni@redhat.com>
References: <20260528145004.323168-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260528145004.323168-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc6
X-PR-Tracked-Commit-Id: 8d26955ea5a4697c1e21a3869ceb36b90389b051
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e20009988e2470063824c58b19d1c80816cc46d
Message-Id: <178000191753.1510087.799289167734356662.pr-tracker-bot@kernel.org>
Date: Thu, 28 May 2026 20:58:37 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 May 2026 16:50:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e20009988e2470063824c58b19d1c80816cc46d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
