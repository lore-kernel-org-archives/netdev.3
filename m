Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0549AA4B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911467; cv=none; b=GwQeKM/pcDAcjvIOKe4EbVk5ig4Vvi1Xxf+135aI9SfEItdRB38cSnxjrg18w3GijMu8EnZvEx08g2umnWIlpIIkNejaW3C8Dz5FVWPGUeXeoKFYm+DoFVbWx1dEpzVT2eQJlN8+QjgpngmkeNN6H7Wa20/0pa87VV4Wb9HN3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911467; c=relaxed/simple;
	bh=zX5I4dNSZ7ByZCHqy7dBt6BRGEmuEvyp74sPlvf8fa0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UCNLVwvBzl97Zpn0+IvkteDzU/aDjoLzLL+euWcq211vMXeTrNoTvw2Yk5d1eUrjh8d2Nezndw89fAUnSksoAhEu7zUNstUc5qZXNr6VjyU/s8OLo01OXjxTZ+ZY+T0WMFeqVnNvGQvGimywYQG67qyjIxHpM+qbDgPUfLgiIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBAee9rR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBAee9rR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE051F00A3A;
	Tue,  8 Sep 2026 23:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911466;
	bh=a6E29Wk5rNL66HKJaOgcYVmnbWg+rDHI5NAB9voBUbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hBAee9rRDqjp13uHRGUX0ozzOOEmaYJYeHJbhYsRP/BL6eJscdCqsBADjDGOPKuPC
	 vl7HePxGC0SdcTh3S3v0VBsCDeTlabP1Sl4WVE/CfhOiqKOkzQwuBbk9ueID18QGBj
	 f2mZ01Prm2/i8GJ+/jbttKSlgxLlDi22NBZ5GwVOVW9HnEv1VZa8ZCZYripAEaSHoS
	 /2jcVEOnkuAogPt9DF/f0y1o20AFX1XsvxCCnW6RAgYInl9Yu+GZffVih6m8ac7Rp8
	 go48+JZiGjpfkuzY09+2HDLTTloMcBJWNCf+mrVTZ+y+jM/zWPkzULe384A4FnkHlP
	 5UA6yR/sSfDSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198AD380820D;
	Tue,  8 Sep 2026 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Update the so_txtime selftest path in SOCKET
 TIMESTAMPING
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891140489.68202.14683668049218705518.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 23:50:04 +0000
References: <20260905100608.42539-1-kmehltretter@gmail.com>
In-Reply-To: <20260905100608.42539-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
 netdev@vger.kernel.org, akpm@linux-foundation.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 12:06:08 +0200 you wrote:
> Commit 5c6baef3885c ("selftests: drv-net: convert so_txtime to
> drv-net") moved the test to tools/testing/selftests/drivers/net/, but
> the SOCKET TIMESTAMPING entry still lists the old path and
> scripts/get_maintainer.pl --self-test=patterns reports it as matching
> nothing.
> 
> Point the pattern at the new location.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Update the so_txtime selftest path in SOCKET TIMESTAMPING
    https://git.kernel.org/netdev/net/c/e24279bffec6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


