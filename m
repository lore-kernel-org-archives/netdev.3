Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932600;
	b=gsmQnzVh6jwu5Rnz3wWUnF7htLi4XP2NxZtZ6DLPTvCEti0vXPWNcp39CGzZjLkDvByE
	 SEDxVbe2aCKaqwKm6oce4AJOMNs/6Owq3PKdwR3ly/a5sgvkA4FKWc++QRhk1KWUpZ/td
	 lmZXIs0o6RRvzrZvoRQAQr6NGxxZVWN/OGBbZtxFR7V9L2708+MtcWp6oELaHLVov++xv
	 XpiprEtrspqEb1xWKUBXBY44Oaz2bmDUDXYH8cJWYGm15zv09wuxpHND0VTtJL01YSjb4
	 TSnWBiY56AcAOgzgDZ5K3ph/UNQCVg3s/2cVkPmvzePKoPz/tZMXHppPgI/OUwpU09A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932600;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=U5JMnvk3LBaHsVvV8Hg86I6jBCuf1ypUiL3oXeSy/+s=;
	b=Hvx3KTlEjK3TzbkDl9qnh1Hh/ZqJT/x49/1zycV9QoosbUwDW6noW4joXQtKYBv/UaG9
	 vR/sLNCMoF/PnJebWZun4Vn0risfXUiKuCcWep01ZShywovWu89xftdXerd6w0uJdjoMs
	 9IOfHheWEcqa+yjs653liBQT7c/+CKsgcCPrSiSYuN84tq0L1mFYm2idpm4+b7iyAtzty
	 G/An+7AxOkmFo1O5Z1wb4ixtP9XZUdK9nssbu6VtQWaiJwQxJCGIfiMFRfuoQX5N3fUPZ
	 0+DWXQ1tYUegd3YbS0ozRxYziY+MXv5W/7LwFfIknzTnI23p8F/VlrJiIPCP+HVa64Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRbnt7X0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BD606A328;
	Fri,  6 Nov 2026 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRbnt7X0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37061F0089F;
	Fri,  6 Nov 2026 02:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932599;
	bh=U5JMnvk3LBaHsVvV8Hg86I6jBCuf1ypUiL3oXeSy/+s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aRbnt7X0R7tjvtfnQBy4R8U5LjeEzuRmJNEr2v4I2quvZUowcLuvriIQwjDrJJb+k
	 RO2lmYD5LU3UuniaBl1uFeuim/D3UOycsO16i9aOmFot4J2wOArqLaohIvLYmqB4yp
	 6af80bQ7ODHybfy/J+3RkzO+HFLBvxmq21NqHP9qndf0IoNpL/YRmdZVLU6SBwHrni
	 DudjgknFmjGPGv2P9PGHmOVUWjFfphPzozH9O7Gxn8k5ue7X/K6RGxEuGVPH6YtVlC
	 uroqCX7SxIwrWl7YRgMwERaCvhtJRNpIzilUakAKyDQYnpdoMnyhkHrYxdvqUUrwvg
	 WwJjGOw/VXUHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D828C391B1BA;
	Fri,  6 Nov 2026 02:36:39 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261105153315.213214-1-pabeni@redhat.com>
References: <20261105153315.213214-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261105153315.213214-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.4-rc2
X-PR-Tracked-Commit-Id: fafbc4051123d5459ea6950899cec08ed946e278
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f66469d9905b39d2c260a15d7d6db450f4db67c1
Message-Id: <179393259831.304043.4367804557327058471.pr-tracker-bot@kernel.org>
Date: Fri, 06 Nov 2026 02:36:38 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu,  5 Nov 2026 16:33:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f66469d9905b39d2c260a15d7d6db450f4db67c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
