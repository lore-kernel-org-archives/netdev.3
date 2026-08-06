Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80F3BCD2F;
	Thu,  6 Aug 2026 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041944; cv=none; b=tZyFtsBe+UYbEwTl86C79V/SlynOoWwE3bJsqD+H+9oe2dn9WKS6V4hY0ymyr7kDMdNt3pZxPGXxIDlJqikMdyYbpR21gofGQXiceU5uKVFEDrNmQm4n2xGRrLyDvTl05rhy4pwe4xd/DULcu3rck1XkFgfBGmbdXUwTzIk4oAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041944; c=relaxed/simple;
	bh=mmYwZCVLblw5RblHfpRJ3+aSATX5SI+xmEFi3Pavdpw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=L1SRHpk1hherZPrjNT66HAloJfU3qPJ6dSHgJEYnPRq5D+1GwiOHla7+JlySS5pywl9JkUW4DJdCoTdKC50/Eh/Z6901EZEEaQOqtCOQlT9W5vQ2+0ww92dNHBlshZYEWzdma/n4/RMjtnKLLUGLtDjYBlHffCtq/uD8woXTsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKN/oTrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKN/oTrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEA71F00A3A;
	Thu,  6 Aug 2026 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041942;
	bh=be5qrtsdULulcN86JZ9/ZMtra9kHA765UEgBsvHl2ps=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=iKN/oTrLWIoJPYDdGMUS6LtE0e4tNWjj04EmgRSsW6pUO787srEYiLHnAF7KTMLEz
	 m6dvMBn2ufc4KhrVs2vPeoBYigzPR80Lpbzk7f4pZV7eKOjpxinDh+I0TinVLLzzY1
	 2vAJNBQmB/ForBIfQY7+CG5OZRlynbnojLHdE7GCuPrWTRy5vEAwFQeN1eHHaGX9kq
	 THus2RNnD9A42ADlLjUAjsE2IsgXlksLrq+p6qWXKKLsfqpKR6DrzDIDsCHweV8YEn
	 ufWyt4xFT5xf3AXszHFMFpUMjo26uxysdhBQwmacEmMQ4cbZcs+ozfwVNKUthv5qfk
	 16IRrZM9TCSnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C6D3809A29;
	Thu,  6 Aug 2026 18:45:02 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260806182959.2963546-1-kuba@kernel.org>
References: <20260806182959.2963546-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260806182959.2963546-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.2-rc7
X-PR-Tracked-Commit-Id: b0ce5fd9fabe7c79463cf4602217d4dfeff5b1fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 315f4bd234b3b8a3ed3a71fd4c53b110cf373720
Message-Id: <178604190133.1426643.10166996742526529613.pr-tracker-bot@kernel.org>
Date: Thu, 06 Aug 2026 18:45:01 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  6 Aug 2026 11:29:59 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/315f4bd234b3b8a3ed3a71fd4c53b110cf373720

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
