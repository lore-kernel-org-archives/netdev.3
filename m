Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94987326939;
	Wed,  2 Sep 2026 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339065; cv=none; b=O1AUIHpTf8cFmZ9BwGXwqAoWRlJV6ngbJjoAMVYbNiwvpXRs4ZV/dcgR7N45G5PZnnWLtPcZxhZeKLZDQiEOEQhR7fA1RuFtAlvMBvtKvF+pD2k4VFaz4mHgClT2HE9fKHoHHR7roM3hR+yla9XgdKjsQFjpOXlxUkdb8MrSrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339065; c=relaxed/simple;
	bh=PWb2EXu9Qge/gQKYu0WmECe0tESY53GJYuzh9I/Cr2E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nBUiOiD/eTCkqDH1uGkK3Fa7wcEVid9bq863/qQ5sHOuttYkLvqax6xOyMJzpzPQf/WXw9C20xr52E/fjAazy7RNK0ZdGr2IYncsQ0047REKFI0RDx9TjhK1oOAcNPKPYQhqI4g/nnuZCFZybvxEcOYQt2UQSXXESPXdkblmbdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCdGwvXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCdGwvXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCED1F000E9;
	Wed,  2 Sep 2026 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788339064;
	bh=0DDHDXaK6X/sut222H6itlthRjneRhUKkvzhTmsK18g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SCdGwvXZjoOZ6h996y490Dj3tMNsQs//IpcEeMIe5YoYOw1x422XvbXnkUV7defVE
	 HK64w8JKElAsb9zyF4szc0ZrNIkkAEXY+BPH105Rb7MHKDx0HJw6mqdGrezRyzpuWU
	 OVgRijZtSwd6w7SxvNm3jeQTJ5m7wB64FrFaoRTxbwmKmujEAUGSMeJR3Gb5w04pgM
	 HdLe0LXAa96x4Y4MP7oICis4OWyEbT7dfYGIm8XmXreBbKcaPMfYZVXNJPcKIJKmM/
	 aeLwHN6Pc9nX2IbZ9UaKQeTIzweqvvTdYHTAfCLcRrRZ31ncQSw2fFp/xFQ6xRVVjW
	 CJnoPwDYlYWYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569533926272;
	Wed,  2 Sep 2026 08:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] octeontx2-af: Fix limiting SRIOV VF count logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178833900590.2154846.12703511604316854383.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 08:50:05 +0000
References: <20260828091945.683722-1-nshettyj@marvell.com>
In-Reply-To: <20260828091945.683722-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 tduszynski@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Aug 2026 14:49:45 +0530 you wrote:
> From: Sunil Goutham <sgoutham@marvell.com>
> 
> When RVU PF0/AF's VFs are SDP instead of LBK, limiting the VF count
> based on the LBK channel count is incorrect.
> 
> Apply LBK channel-based VF limits only when the VF device ID matches
> the LBK RVU AFVF device.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: Fix limiting SRIOV VF count logic
    https://git.kernel.org/netdev/net/c/f695390ea639

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


