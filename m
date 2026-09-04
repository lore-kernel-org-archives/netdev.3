Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F21F1932;
	Fri,  4 Sep 2026 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481269; cv=none; b=ntjmqTUdh+2oglNTX8BxvTAxBiWrs6KnYsHLoTdlIx95/mhAvFeXh0zjqEeq0WPYyQDUHLIUYJ0SgYXqkrJkXPkLulX+PSUCUPa1ydJ2FMpCsJZxpomo7Q60sFlh/3wjXAuTx7wE3Zsm5zNrX2qVTbg6qKo5c2pcWtkGn/QHF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481269; c=relaxed/simple;
	bh=xgmJhiizEoiVDkcsuSQNyQcYcBakqqWVw+nd82m6XWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IlfjwDrgV03o1B06AcVyro4x5RkzM5eee7fRNXXxm2NBgYq+FR3GIqqPFYFOT+SdSNQw4SjiBznrzEDnwj0FoxA2310X/eYP4P6hTdwe1wwCtvh0IiZHkEvzuGOJXzQxwg5lmRVL+8eMMC5YVzXCIV0/Abg9/z8ut3XsxPz+7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz4Jak/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz4Jak/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413AD1F000E9;
	Fri,  4 Sep 2026 00:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788481268;
	bh=LwiOAInPPppouL9BNo6MOyuuINfW/HQETl4h0QYriBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Dz4Jak/4MV1lvmPxjW8oMtnSJ64+FAwWAYKbSmamOQTE0RS9krhbcuBjq8XUgPYze
	 sYDMTxI7ZetTbz6rmnJl2WrtwS2omfPkwO4+WeZlR78/ngI9uDhhLUs4LX+LRm/6Y/
	 2EfHO2oDelLJme4ffTUeUv+VXvKhSXCjyZU+O0S3MbyTEV86WfvOb874G5rk6qzcTK
	 qPLaSNjITknOaBSFiimz9LbEgJnC1vU6o0V2/pqmlPwsdPzxcfSWvR1o4OMyAEHtxC
	 hdtzE1TQLgBdHVfzXKI/qGJJEXMrqXi6IQOsVWsmINelRG2P9OXX8L0GcjAatmh3Hm
	 6PlJW/PthqN2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0438119E3;
	Fri,  4 Sep 2026 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] devlink: use direct firmware requests for flash
 updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848120911.4082713.2895395373266662503.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:20:09 +0000
References: <20260902095739.3587287-1-miguelgarciaroman8@gmail.com>
In-Reply-To: <20260902095739.3587287-1-miguelgarciaroman8@gmail.com>
To: Miguel Garcia <miguelgarciaroman8@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, jacob.e.keller@intel.com,
 syzbot+372a7d84708b07f64d9b@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 11:57:30 +0200 you wrote:
> request_firmware() may enter the sysfs fallback and call
> try_to_freeze(). Devlink invokes it while holding the instance lock,
> causing syzbot to report:
> 
>   WARNING: syz-executor/... still has locks held!
> 
> Firmware flash requests already name a file provided by userspace.
> Use request_firmware_direct() in both flash update paths so a missing
> file fails immediately instead of entering the sysfs fallback. This
> keeps the normal devlink locking intact.
> 
> [...]

Here is the summary with links:
  - [net,v4] devlink: use direct firmware requests for flash updates
    https://git.kernel.org/netdev/net-next/c/94284e5442ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


