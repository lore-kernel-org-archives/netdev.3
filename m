Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10F2D8390;
	Thu,  9 Jul 2026 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611498; cv=none; b=GzfDN7PIxK3O3mfMWgJcOE2fNBVwK58OVW/fvbcvkjkVOWET5qSHpblmtjs01xrJRJyT6a9WiL6nYfpNpF97Xg7oTX39hzl5r+x0VGN9Q3ACqrXylfJx8oVQywzPiQbRvlMSSpLObDzSWLUXU4KIwlTXPfLE3QUrd7NmId00szI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611498; c=relaxed/simple;
	bh=CFj7c9xa8WXVuQNEY7+x6ThVvUN1GQ95be/svQIJZ80=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gw9pSlJftJbOOzo06NTAu2LZxVIXwcmm5WrryxREfyl5XvvMXQROCuuzw4ro8xrjMURgnFwaGlCI8Dim4BBBZG8A6aedAw/D1sLLTqX7H8htBiJHowTQ6ZOC2cvGYGGxSskpTY3zoLlvQ4F3Rlla1XMNSPLoIvyJ0nAN1O6ppRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcfGPJbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcfGPJbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BA11F000E9;
	Thu,  9 Jul 2026 15:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611494;
	bh=MBSjCZW8DQ49yVblv0FW6CGWPq0DmAWzPqC5dFf3G5U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=AcfGPJbLhmZV2GhQ752jO2Q+uwHyy+Y9tlUcDttP389RgHYeVhEr2xwX6qWb20jf6
	 7iEuds6Sr946/cRu0bObqNZrmuEUihmp1B+JpL9v+Sh/O6Wf2EweLOkrQdX0QHqEWS
	 Nn4UcN6rcgky7QwKumZjvBrw/gTHxKHX1aJPE0Skmcix4vFTwMU9LKdxi3/Jeqeyr9
	 Q6k7eMh0zMpPU5whvobTm3x+hQRcF0u12Q8b30KUve4QanBuXiNK0I1ieoaPIbomAV
	 421e/pu6w874rPB51Dor4g2Q2d/YpcGCb12CN2DQRVorrGITBfDsC6YXzgHAV/pxcE
	 kLDPPqK+02dbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C1A39250E1;
	Thu,  9 Jul 2026 15:37:54 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.2-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260709134751.242764-1-pabeni@redhat.com>
References: <20260709134751.242764-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260709134751.242764-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc3
X-PR-Tracked-Commit-Id: f5089008f90c0a7c5520dff3934e0af00adf322d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
Message-Id: <178361147304.3550747.3085234207222809075.pr-tracker-bot@kernel.org>
Date: Thu, 09 Jul 2026 15:37:53 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 Jul 2026 15:47:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c7c88a412aa6d09cd04b414211b4ef8553b5309

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
