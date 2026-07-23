Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA443CE79;
	Thu, 23 Jul 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818243; cv=none; b=qDaMVgDGt9/mEjTasWdmclNtPv6pIn2R43iJwD7qVXLManwXNTCAuMhXBesTLK5s6K3V3TQOMuvEmFpGEq7zcDL0IMTkNf+mIvcnOiWq6W9DjzBUgIfyHXQKH6ilZLbmZ3zwhKt5ymXpoQKJYrovlNnGR8cL9lWQi2I/Mgxuon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818243; c=relaxed/simple;
	bh=OIaH+x8H/BYvoLJVn507YmFcX+yOVgWu8XcQQ20hCnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aAzBTHQgsPAJxjHr36kU8YJ2oJxqYsb1xJjxl2p2hd7q0CB7kxRwfGAWfVTuRjz6QXBXnCZVsyKRQ7qjI0zosS7557PhRaFEXnrnFdM423hlUWoKEUWqSJgm6MCLC7DRPOIBWMAw/1N+pcBDvSxUY5q3X+6KaLMKfI7huAkGTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXp+4Dzb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXp+4Dzb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ADE1F000E9;
	Thu, 23 Jul 2026 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784818242;
	bh=82cI42zGu8QyHbopoESEt9egvuNUUJz+qVZKRKZGIJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NXp+4Dzbkbi22eXg+Pqkwsb1PW9nRhdp4zBid4eReZZmUFFsJ5RD2jEqWm6mlSYvz
	 s7AhednzEUDl5HJVJ68eN5WUOxcjUCu3jfxuB2UbJpQKnj89KsME3E/krjsmycRKwX
	 845+f2PVtwCZ1nbO4gk4mizWBHjmKuTHhvm8+VNQA0hRwan4YrinTZykSPDFYy26Af
	 /QvQy1HkjjZlibhPybVd0JkqRWcZLKPViQDEwa62VS48h6f51olXgZHbW1LVaUBJ48
	 woEX2Yk6s5uaVgDFHyIcU1AnRkKQ2WLe/y5amUlagyHer9BN5HTjDXsb1WEH1ccZ+Q
	 CFGzcZLOxAj+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199BE3924441;
	Thu, 23 Jul 2026 14:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: qrtr: restrict socket creation to the initial
 network namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481820665.2303439.3370268777197256291.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 14:50:06 +0000
References: <20260716154319.3297699-1-qwe.aldo@gmail.com>
In-Reply-To: <20260716154319.3297699-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andersson@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jul 2026 12:43:19 -0300 you wrote:
> QRTR keeps its entire port and node state in module-global variables
> that are not partitioned per network namespace: qrtr_local_nid is a
> single global node id (always 1) and qrtr_ports is a single global
> xarray. qrtr_port_lookup() and qrtr_local_enqueue() operate on that
> global state with no network-namespace check, and qrtr_create() places
> no restriction on the namespace a socket is created in.
> 
> [...]

Here is the summary with links:
  - [net] net: qrtr: restrict socket creation to the initial network namespace
    https://git.kernel.org/netdev/net/c/3b536db8fb32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


