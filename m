Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C18435EE2
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664042; cv=none; b=gym2k815MIjyaz4OxrEDWKhwkCqMwAvRc3+WT69Z0ZAuecWbDlt3ReDBnthfp2xAWOnLa+xS27DbmSjeV/16eayhi7tnQJHcXWhCQLtcXgpa1qrxn9u4EuXygbOTFWFr79cfwXJlOOvzfh0olr2KqUSRy2VTd8EBu3aPElD4Ve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664042; c=relaxed/simple;
	bh=E49cuTDCHHnnVem0IukUoutwt4BqXyA3wR5oiqn6vhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=COxFuqfADI5Iy3OVznPmAP8hPpSsniD+RijZOiVU3CCo2gVcjxwIwEN8QCR4oM1FTvQRm0wZPMJp/MCCpmS08y1MCrmyXVwAWwyyE/7l/GlvjhFmatMv4UXzwyFUWA3Hdx6ae5C5KkjhSRESOFsGM8udBL/np0LCdBc0xUtiPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO2Uuv+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO2Uuv+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622B11F00A3A;
	Tue, 21 Jul 2026 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784664041;
	bh=fU3ZpyhDiIo2sCTKbSPkYT+vcQt28F0qxCxwfE40WL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZO2Uuv+zjCfDCzCz3AsTB3J5P4DjbGH/PmqCtoKEL0BblS0CRygfqOwx8bAHVumny
	 kqKu5cK/E83ZyMlz/Wk+96C/ZZ1TEa8iccqZPBg6FzgDXk/9ncpi4EVuFgc/dGZRD9
	 lIb35bkFAQb4WRQz/PoQwM1uxUK03Xn8q7gJEUH+yFhF5FEA2INrq98gSYFDBp5a8K
	 xfFLgfooSOuiehERkcnBOJH27Q3IYB3tRE2L3sWtsvQPGC2MY7Yn45gDChBieoxiyZ
	 VGKtlfnnd+yZyXDUjANzm9ncqOWpO+Uq+iZ7qYnHqCo4r18EZlf0e67GEHdTtFi0Zx
	 ulMXdqADML36g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988B3926242;
	Tue, 21 Jul 2026 20:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: fix auxiliary device add/del races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466401064.1013514.16323550913509027898.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 20:00:10 +0000
References: <20260714210745.1785625-1-nikhil.rao@amd.com>
In-Reply-To: <20260714210745.1785625-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 21:07:45 +0000 you wrote:
> Two paths add or delete the same slot (pf->vfs[vf_id].padev): a VF's
> pdsc_reset_done() and the PF's devlink enable_vnet/disable_vnet handler.
> They serialize on config_lock, but neither guards the slot under it
> correctly.
> 
> add() registers and stores a new auxiliary device without first checking
> the slot, so a second add of an already-populated slot leaks the first
> device. del() makes that check outside config_lock, so two concurrent
> dels can both pass it; the first clears the slot, and the second
> dereferences a NULL pointer.
> 
> [...]

Here is the summary with links:
  - [net] pds_core: fix auxiliary device add/del races
    https://git.kernel.org/netdev/net/c/bfa33cd513c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


