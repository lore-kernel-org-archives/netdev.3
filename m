Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5764963D4;
	Thu, 13 Aug 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639389; cv=none; b=As7qhU5GBKg8A9GNuamiD7jFNV3ogbCL/36nvK/+52UDOMO0fM4ESBGPwZELcgFpHTnn0LOBFiWcOLB49gzg4XfN2hXl8W4/pCKZa+n4MvkXayL+FPFxQbxNxMjVKECIddc8IxHwZbKH0XG2RXIVr/lJqlTfJDcExmj5NAA5/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639389; c=relaxed/simple;
	bh=m0eJmoxnLNRqoaOK7kd6qGA9PBzhKFjUVOAB1HiwI4c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xfz5lV4upne09RIMjsuXkjx2a/3J9Uz/RPdeIKHRjYpndt2iJ02XHUMKKI3mqpUhbKe7nag6uiRjU24N1o8YbW+KEi/9a5DJdBaiq6ym0I9fT2QNByVmUk7vLpIMD+BjxGQL97QloQRpxl3Ag4F3cMJmG2wmiBY1rVPle6awkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsmJH7g5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsmJH7g5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9386D1F00AC4;
	Thu, 13 Aug 2026 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786639369;
	bh=Iu773MiPFji24edldqQBc6vOQb331GhqaiCwkXnRw+8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EsmJH7g5zqdo5uh0wBi+ieFSDKCj+ZpdtaT2fhQ2Rox9l9ezGaHMIx5eoWXvmfaR1
	 pn3D4RZSMkdAtPCzDnFkKLVtmBw4XUwJa+j7SCJNRrf425pzcEsS7b+yfB+1dGP4eX
	 jdCMkdSa3IPU5HCFQX3Hee9QrcDTBdoIOBKN2hl9DxzGFzNHk2dE/TKMXqCWMeqCqN
	 qr3dRGO7Men3DtUNaG8bjwZtVoyY0ExkqWsDWVAkFU4YeC4wGCviC0Zva6DAG4sKX5
	 ORqArLmh+PCU/l/R+SoqUEfJ9IKCNS5A1zIYwXlMLk/95ddPsyLLTn9NbGS9CTvLQ5
	 2vCNUF0T/MGUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A41380CEE2;
	Thu, 13 Aug 2026 16:42:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.2-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260813152104.256382-1-pabeni@redhat.com>
References: <20260813152104.256382-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260813152104.256382-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc8
X-PR-Tracked-Commit-Id: 9006c116dd111d457bf5d074990210f70a4ad2c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e14aacefb78d942d2308d9821fe52d75d21a824e
Message-Id: <178663932418.2953617.10249078688574059035.pr-tracker-bot@kernel.org>
Date: Thu, 13 Aug 2026 16:42:04 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Aug 2026 17:21:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e14aacefb78d942d2308d9821fe52d75d21a824e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
