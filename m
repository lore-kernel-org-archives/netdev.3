Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B640D59E
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178221; cv=none; b=VB6x3q1HJ/ahpOyXYMwSry9JaDYJjincMahNbznTzmvx8jGXK185EesDAnyICQxtnJbx4XAneDeOdEErUUCcm3hIRL4LrxjzokFQoDpmo3iSDqyndmZPBBVYK+R8InUBk7Akd6TPfJ1ooUGjef7e/ox0FjHCAiFbb+UbgGLmx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178221; c=relaxed/simple;
	bh=Cbc1IptnmyYPWbPHJpfHk+EdGrUyRbCcPiTcIXYcq9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P6Y/UMc5KJ4A7jGvyk6O6ZKx3gKqCASChQI9DFy1ViQqcbMgwtDnNhSNCGYn6oR47s6QjhaIIh8pn8NpJv4PBHqBu3EPwPU32fYtnknxw28DeFitSxVOS8mQcFaTv6+fB3WwjywVaPqA4nMGBs6te/yw0SnmCFPlOaF6GRIzqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIYvL7+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIYvL7+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E781F000E9;
	Tue, 23 Jun 2026 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782178220;
	bh=bY9CbvwNiGdx3n/spdaZ2EO/smQd5Nd7llRFcIMgLk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IIYvL7+PGgbdrCY7JxjDYjnikEHmYnxE3336cBqLwPCHvPUd3DDQmCUDJEwpikE6I
	 u5zmvp0FqH+JlYWj0AS55H8MiLy/51Z1YiSdHLh3GIGCUcaUGQFpetg68MZDdZvgfL
	 7ohrwgt+TbxgWotfBdCKerCc5ew7WD8IVgP/xybc8RIpspgGHUitmD8kBBPg8pgRQl
	 qaWg0ZBACHSqqRRUhTKeDtlOjfGw4AbQ5RKRvkVplVwyyjB+ha+qdDIbyJr7SgEhXE
	 wmCt8pvymEb725p+YiKvBXbTA7nCDVzRCiTbzIcWLkDKUShM7tkDFLFiuTfPeDTfVX
	 cHe0ndGX+t9PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0FCF393098F;
	Tue, 23 Jun 2026 01:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] eth: bnxt: improve the timing of stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217821051.1493333.5714369108079292852.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 01:30:10 +0000
References: <20260619191538.104165-1-kuba@kernel.org>
In-Reply-To: <20260619191538.104165-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 12:15:38 -0700 you wrote:
> Kernel selftests wait 1.25x of the promised stats refresh time
> (as read from ethtool -c). bnxt reports 1sec by default, but
> the stats update process has two steps. First device DMAs the
> new values, then the service task performs update in full-width
> SW counters. So the worst case delay is actually 2x.
> 
> Note that the behavior is different for ring stats and port stats.
> Port stats are fetched synchronously by the service worker, so
> there's no risk of doubling up the delay there.
> 
> [...]

Here is the summary with links:
  - [net,v2] eth: bnxt: improve the timing of stats
    https://git.kernel.org/netdev/net/c/40529e58629b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


