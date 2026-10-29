Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298494;
	b=Tn2N11meRv+ayrjAcEJXGD7+9c5kB8pBE8daYhDV07sFlig0pI9e675lVlnOyU8MV9gP
	 JyPh0pxm2D/980NSqIaOzZDGdvhJdB873R29GEQF/S2n629+fOGSsz32ZpesOl/Kw7+Es
	 BFIbr33OKxPc7Wuu+cPgQ1P24mSz9GpN0//K4UNv587Z/+uPrQ8TqpfRELy3OBq/VTOkh
	 jEwnDzVRleuUG0cvBR7W8Buygd4+Z4gZ7r44vCSUm8+3qAdhgewfa8hsQwgxQcfuH7Htf
	 u5BrPAlITEWHFWR7G+1KzhK4+YIZrhHszn8Luq53Cu6N2GjFmvXjhCdcsaYGX9zkk1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298494;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=zFY+hQKJJkdZ2eVCe8sAblxb//C3U4CmmuspuAXd1mY=;
	b=MTfFqEllh9Zs0h74pYotXI1YeVK2ZElp05OtOiX/3936n3Drqw7usFBpEY0AgRLsxWfc
	 6vF2vI7o7DNwc9xqIrxoMDD36FJUYerfUwWw4ewKGpL7UTt2eLfA4+JNUa63J/EQm4GUB
	 XrAmPVMRNmk5KDxr4IOVF5DYirMDPzNzdhc0SKS3gU4kPSOC8HNG9jjslXeGGqy/WAhLe
	 J7M2eq8P3em4dLgvyZGF41GGCESRPS8gwVGZI0IRICpRJJoKjIHOA4uA3dkzsc9auGZ8x
	 +yp8eFUNl+Ad/0pucRsQLrGyectbkPNI3VS8kJgAqR3i4TSa8Bw0ksPx0JEEpPhCepg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QV3FaSL3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72953606A31A;
	Thu, 29 Oct 2026 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QV3FaSL3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483171F01816;
	Thu, 29 Oct 2026 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793298494;
	bh=zFY+hQKJJkdZ2eVCe8sAblxb//C3U4CmmuspuAXd1mY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QV3FaSL3K3aPpREXsBW3Yi01/S0WygWHyj4zh1aY6i6avPQzjFVUtYo0CxUI1KuYv
	 laCekqnKWw/ZymBtdbg1WSmGpGrYoVBLxYeqHOz+0rFp4mVZCuWucCQ5SNQEEbQ1Zp
	 1P3A2miLjrbgCtJu9AMah6we8/fn+Nh4O13337LMDL6Uo+8I0PMUttOM1zQKgWajFD
	 AnHU0JomNMxcR/60tQ5LkR+2BDt2Yte1x5hDElSd4DeowMx9kMZ5VVb/bW5d+umoMe
	 MarAQg1O2928yxvtCwN/1SqsSh18eSk14nySOK76vHV7RTlaB/bLZZtL0XYmkSTfWE
	 ezuTkyj6jCRXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 403A83808228;
	Thu, 29 Oct 2026 18:28:14 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261029165928.3587812-1-kuba@kernel.org>
References: <20261029165928.3587812-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261029165928.3587812-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.4-rc1
X-PR-Tracked-Commit-Id: 8f44631ba02afe9fff2f0a0fb66560ab19df87fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dd16e31135ea8437a720222df34e8745f385d6d
Message-Id: <179329849291.621556.10699145417534532755.pr-tracker-bot@kernel.org>
Date: Thu, 29 Oct 2026 18:28:12 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 29 Oct 2026 09:59:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dd16e31135ea8437a720222df34e8745f385d6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
