Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792729842;
	b=rJNeTBrqavNeRX9R6VD3AOvVYH4gyDVeRXx8cq8OyQ7mXDV+frIwaIOF18zcy70ws9Ac
	 0CwYEA5GbL31g35QpZDfJu5U6f2/wiIonKg4YzgfWDpRMIB3ciz3gHZyLgVso2zgc4s8H
	 zGvXKWySuobaZrnI9fIFV9qi9cHZ4kzX+SNfSJUzBqChGkW/FRKIk7WYyQfObcHEhXGQx
	 oxf0yOhAxaF6VjB/u2s4BtHVFjvLrEh8xGjqu96PBcWBb/Iii5NZ4ub0MrW4VrVOmFGo8
	 OjYVRN2/tT74JSEJL3vASzdZ0SpZL2cifeZF+teMOK3KXuxSZRS9nJGFJ0TUxjJlEVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792729842;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=SZonGDeYkiVrpAok1a08VJJlBwfGQXXk9/9sOW5ZJx4=;
	b=w5XII5ZjcgvAK+PySBBjJH0LaE53va0A/e5SGzeJnaAbKs1IXTNHSbz2yKq3KPm+bqxI
	 FDw34IwaZIUr8BTWmYXBLmwRio28nNI9tF4tBrLThtZSvmXnnJK66SKujqyZ6SlmGKNle
	 9RIp0VJBwgmPWxD/p1trNT5M70yCr1iEJa+bf9iWWava5dVLUT6yIjJjc5u0xSYdZAafc
	 EuwO/y1boBV8khD7wzWEuIRNmLsRV8bBEbGboZywhFVwsOhkpIcaR6xoUNZVXKLFKqBYv
	 hjrIyOQEWVBaVEOli9n2YQIMfpqkRUETh+zO5LuCFJdgZkWgJnIduwq9ZEGREGRldow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZ8kDupO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B7606A31D;
	Fri, 23 Oct 2026 04:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZ8kDupO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE2A1F031E0;
	Fri, 23 Oct 2026 04:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792729842;
	bh=SZonGDeYkiVrpAok1a08VJJlBwfGQXXk9/9sOW5ZJx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TZ8kDupOtIdSGuviXgP2XmVUPs82XRa321DcluanrkfxYFCVuCtaMSPwS06vESiop
	 nUNPydpB7sCGNrphpgu3X9DElYXyn2qbCv8BJGjKBDB8hc0X5nIgycf4e99sh+seZU
	 fD+3KCpDpN8k2A+p4K/Mtp9fRYVnGqBuaSueoo722mhMyEjRqZJnb/CsnfQ6KiUVOl
	 G1YJidDH3ln2GrX8wWrwc+S99Lakk/j1W7mEOD9kwnG8yEPPY7VweJwDC4ow74JpgE
	 oQchiJoS7FMsNGban8mMc7OMZgaejXoMKxUJ9vzQr1QfyB9CCUYx1nuoMAZLcddV71
	 cNJCWTXeu69+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4487338068DB;
	Fri, 23 Oct 2026 04:30:42 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261022160928.231626-1-pabeni@redhat.com>
References: <20261022160928.231626-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261022160928.231626-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.4
X-PR-Tracked-Commit-Id: 1a2c35c49cc7c6be860038b8442b52424a8f123c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
Message-Id: <179272984097.350559.4140930284972532012.pr-tracker-bot@kernel.org>
Date: Fri, 23 Oct 2026 04:30:40 +0000
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

The pull request you sent on Thu, 22 Oct 2026 18:09:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/734bef548a96e8774d6eef5dfa2026c6edc4e80b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
