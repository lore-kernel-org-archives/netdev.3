Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D1355F43;
	Thu, 26 Feb 2026 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128420; cv=none; b=j5ioHDgVfmXtMDZlc0mVqnSe0p0/0nejVsJN6DRoZaXavKqhdAsIhb0a2Pin+24NPPfvjGPjGDrDpBnsygJLpZ6y4/+/c54SPMJFJhlScVmwwFtfY53KbxIQOgQyUGaJ9oBjrUYSJ/Xhu7rdKUlV/g6w1HiK9It+vRoxJH9lAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128420; c=relaxed/simple;
	bh=Xd+5YKu839LfJvfx00zvQchEU5HBqB1+xnhUcdfU01Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LTLsm4ZWDrEVJ6FvshVoy7qmwpwKmsCkzh+qkC7DLLQwuTOSbb4GYVwKk2HpqG45DrmnYYLAbqMr5iyiL8F/ja0LoXFKkeh6hlozKIcwhCXg1+icePgIn7/GkUqTvU/UNVcRXBrmVF50gy9EQHyfpBEWdkWvqAhTbECZlahKxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFfTsZTR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFfTsZTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EABDC2BC86;
	Thu, 26 Feb 2026 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772128420;
	bh=Xd+5YKu839LfJvfx00zvQchEU5HBqB1+xnhUcdfU01Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AFfTsZTRyDrBxsYMIWepYEynjuCJgv1FW/4HqAmzVVjOxDhtXHw2iALMMqhBnXyO0
	 rVJ36y0gadGqqhmD1jOEs7jWm9sRKdoC/u9f8F2Ocs/DA0AnZqvE2+BMbJgyDtu2UV
	 tFyDNm7v+JfsAmPibtOYhBq10oWwXHH91qCZCITb4ccPPlQHgrKN+FSfMN3OwEyPi2
	 ytq08rYUmU78ec+QWJexOEMI2Zim8yXZgK0Bjw/9QHx1oZyQV9vyg+pXPo+2slYC6s
	 YNk8oEhqV6KH+3fVJnzvHvUbXV92n1ENTKjGzDhG2Y7mtcrpM93E8nuscZ/TrhUFna
	 flf7j0MnT9iPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030EF393093E;
	Thu, 26 Feb 2026 17:53:46 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260226151529.259438-1-pabeni@redhat.com>
References: <20260226151529.259438-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260226151529.259438-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc2
X-PR-Tracked-Commit-Id: baed0d9ba91d4f390da12d5039128ee897253d60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9c8fc2caea6ff7e45c6942de8fee53515c66b34
Message-Id: <177212842450.1769138.14012357854011263431.pr-tracker-bot@kernel.org>
Date: Thu, 26 Feb 2026 17:53:44 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Feb 2026 16:15:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9c8fc2caea6ff7e45c6942de8fee53515c66b34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
