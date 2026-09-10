Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939C493D20;
	Thu, 10 Sep 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053675; cv=none; b=lQIUHV3sdTb/Px2iUUIs2NJx3BpnPFDgHWs8Lg+VYtG2Kc+PPPgfyJmBuKFUOgcXmCu2deHUTJCaxnCtrFZApi/xOc/HR+RVUJGCE67Rug8lyybunFvmr4jl4UiIkGY3R3y32z/T0RQ+PiL44Noj+TuAslHmohC7pjYTZIFcQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053675; c=relaxed/simple;
	bh=eF5jUpAuBcMD6Zq15hZ3pqXZwLCzQWqPM1wimyeLT5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QC+y375ESKtkMcRpRwDoFXHUDD0uAf7TnvSDcleuYhfer65/lHQBQrCvQavpkFN3PahjJmx1QNE2f1I3H5n95fh6f/idos6UeA9ftYkiN4pebhOA67AzgwHgIq2w9VR4qF6+phoKEc1apUIXPgbgJuDcyiaONCqhkwgCJsjqxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T72oFTzo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T72oFTzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6B71F000FF;
	Thu, 10 Sep 2026 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053666;
	bh=xR+RWcIA9HIbE1Wf1B8u5A87IqN9IKHSfMEx283YPfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T72oFTzoH6WPs91ZevZ2TlS+ihTGlRhLgQxsxB/oXptGzNXj29N+UH3ShMaHPlUe/
	 iVRwdt6W6ho3FUYl7A2IfdTrJHtnhZfUULq/IqWCmTApd6rskUmqjwmVoAEqF+nlS3
	 XFgmSqpciFXbLHSYBY2lmJDceJPi9UX6AB2ZAIOWjY50H9OK4hNWDvN9H7nZLS9k6D
	 UTvjO/D06QFJzLx2geeVING3zKg/09MvSW5Cme/Nbc4bT1tU6XUJPhYliTpgzDFHFi
	 b5rXrijv9/MQc8CCVGJsnRSeBkyloFIlpU5N/NmQHkUgfHKTSTt43JlTmu98e7ZcS4
	 KQHH28abdBaFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93869380CEF8;
	Thu, 10 Sep 2026 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] octeontx2-af: fix PF/CGX debugfs PCI bus lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905360439.1492964.17732959701772223922.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 15:20:04 +0000
References: <20260904085114.3385530-1-rkannoth@marvell.com>
In-Reply-To: <20260904085114.3385530-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 rsaladi2@marvell.com, sbhatta@marvell.com, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Sep 2026 14:21:13 +0530 you wrote:
> rvu_dbg_rvu_pf_cgx_map_display() locates each RVU PF PCI device via
> pci_get_domain_bus_and_slot() when printing the PF-to-CGX map. It
> assumed PF0 always sits on PCI bus 1 and derived other PF bus numbers
> as pf + 1, but the AF device can be enumerated on a different bus.
> 
> Use rvu->pdev->bus->number as the base bus instead, so each PF lookup
> uses pf + start on systems where RVU functions are on contiguous buses
> but do not start at bus 1.
> 
> [...]

Here is the summary with links:
  - [v2,net] octeontx2-af: fix PF/CGX debugfs PCI bus lookup
    https://git.kernel.org/netdev/net/c/4f4b743c2d2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


