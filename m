Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43C3839B3;
	Fri,  9 Oct 2026 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521265; cv=none; b=oEWeNPWrMZjqxdh3NzvVBYiPOwjQScRj86T17qU11KUJetrMbwUXcuOyHKDkSQOVkfS7W+dX0QskEAc8JPO0HMvQ0+kWqZTXKAis5KByOXTG1a8GT36mkRi9tGdw0y9VGIvu3mNVHQxqsAaGTCvR+QVhHAcrowel66qyzDIshkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521265; c=relaxed/simple;
	bh=ZQtRbvD8B/bkmYT//853VlpZV8VpvzPCMWUVjlVmbJo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TYn16uxQ9JH9/1M9PQMj9uMtHT5fCq/AwNpq1uHsQXjKcUtzghKMF980/GApu8KKrrvYsa3rk35jIgaeT5IKqU9+o7CgyuwGYo5U2OgMq+eHXvcqwZ1tof6NjGrHg1ZHGcI3sjzp1POBIq8n5gxZw0U9/KoD+4VCCZt57m6+42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyeRfNVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyeRfNVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4839C1F000FF;
	Fri,  9 Oct 2026 04:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791521264;
	bh=0tPEbeiwFRkQweFIb+MoQdzqOnJ3tCqXXGPB0nEtuGU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OyeRfNVA8TiOZC51oO4UjdRv1G2SZKXzJfd82/daUxp1vjvPBr+VrhVFvydMZe4Rs
	 nraqNWWCCJzqP3TJW/lIcd6VLxocQHq9Nhh+8vLtQXSDLLGU29qPbSYp7OrU+Tz+NV
	 /3IcCO2E/8UOso4aiQrB9x8EUDFqtliWzjACBUQzt4+BSx1Mi3UHuH8grCgxoa4H1C
	 e4ni/jIkORSteLNW+9aWu18kTRHXb/uWLW7hBJx6TtNErULr4OKWu2MtKvHIrBvkpG
	 1i2IgMSShdaRH4fOfCSIPAroSIUJnpRjgGDExYagUlK4bdIWiEzqihvfo4dK+uQBDX
	 OrMl04xapPaew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A53D380CEEC;
	Fri,  9 Oct 2026 04:47:44 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261008192253.574195-1-kuba@kernel.org>
References: <20261008192253.574195-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261008192253.574195-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc7
X-PR-Tracked-Commit-Id: 37f12441f557468a56c1e27790413aa78c82afa2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af32da41b0327b9c6a37856ba82b6760d6c8d10e
Message-Id: <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
Date: Fri, 09 Oct 2026 04:47:42 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  8 Oct 2026 12:22:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af32da41b0327b9c6a37856ba82b6760d6c8d10e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
