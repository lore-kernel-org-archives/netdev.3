Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1973955C4
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485422; cv=none; b=JW3X4TBS3COyMIc1iGoRTwYMiwcgV5gWON3yUTiEkYvqCBdXyeVmAeWF5Zd3hSu1BlpH3d2jDHu5+uwXCDEqVR2GD0Yw/inscb6mRcFXdNvmsgunzcRX75ElVo8kXlBOa5J3HTfWDvce6MVfAcKnts5yk6Ps6taqFbFgP43nb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485422; c=relaxed/simple;
	bh=+fzxIdwQCggSNp8ZWN5CJseMC5xrDxSZuHqMcy40q5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lDJtOZl6a/5OYGRAIHn6tOKeLzKAikNf3SUAbz/5sak9V4pcxNEhhBkHK+knx4oSv+iJuly2DO6YD+kld97d7yrk3f9aMuMSASpsPfdUYB5vKJqk+5CD1VwSjQg+cQIf+EA6Bnp0qzaL4PV7HAF9d5AzauDw82i9WswCtBQ+xWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esSe/tz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esSe/tz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0712D1F000FF;
	Thu,  8 Oct 2026 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791485419;
	bh=fSEMp8YdDghemj4S7WiCS7EZx2ulfr6E61d5EPZTFAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=esSe/tz7hiu8/HI9UdznBNy6VUUKDqJSml0t4ahOyFSK94myQ3KaKv2jpj+U6vgLb
	 9s1vUuD8pbBDugFSKFvko+9fj4Z9kSxrvbjDdGrCP1VCgs69a1+8HAuvDxEpvkN3fT
	 Hl9XEEKoWB2j/48Gm64XSeq+Tv4VdhX6s9Pg2afKk+7cV/98fGE1UIWWFWyixBofCy
	 I8Q/ylXbNXFhbdrErt1W3627xDHaqOs8tPPy6CjzM9tb/hYufZ8537FILf2X5Nipxi
	 HqwHRJRCW6vbVxgv3rawXJqUEVneq9oNVY3XbvTtjARGay/3/Yh9JGlLrL6xjq+cS8
	 Kwqv3ewM1sZgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16AD380CEC8;
	Thu,  8 Oct 2026 18:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] WireGuard fixes for 7.3-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148541751.391001.14153892817695850789.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:50:17 +0000
References: <20261008130124.724119-1-Jason@zx2c4.com>
In-Reply-To: <20261008130124.724119-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Oct 2026 14:59:13 +0200 you wrote:
> Hi Jakub,
> 
> This series contains two important WireGuard fixes and one trivial
> cleanup.
> 
> 1) Remove an unused variable.
> 
> [...]

Here is the summary with links:
  - [net,1/3] wireguard: noise: remove unused variable
    https://git.kernel.org/netdev/net-next/c/3f65f6ff8594
  - [net,2/3] wireguard: queueing: preserve tstamp_type when encapsulating packet
    (no matching commit)
  - [net,3/3] wireguard: noise: reject response consumption after intermediate initiation
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


