Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F92F261C;
	Fri, 17 Apr 2026 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393655; cv=none; b=Nf4wgqG/KMLRUJd6gloYyJdHWueCK30hUmPGnM7qthbywvXwp107I7FXjggBQEqeMhY+QpSJg4XbKBCfCtRBJrLOQQhTXLw+r2sKRzokZywOcUTahT7y3Zmwfco7w7jPL9ZFdut3bA5EziF+AVDSTnBKTIVpaNMDRFUpFnhXVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393655; c=relaxed/simple;
	bh=J+WFY5F5Qp8wcWvTLN3N6Svvu3ddvpKW4eD2LK7SHxc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XXc+QR5KvtELh8Zr8884Scjs2+TMs0IrzpypZBRBobj4uiRFE4vTppqTjn502hEyo1QsiifNNys/uO0Shlc00XEIwv9HChMX8nZYEjW/QyoZZO9fFz5E94qySL/oVRsiCW5SAoq3QjKFnNt2B7vCGjRqTTxHxdlAXtyRyV1UWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi+Y0Ggh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi+Y0Ggh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B511FC2BCAF;
	Fri, 17 Apr 2026 02:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776393654;
	bh=J+WFY5F5Qp8wcWvTLN3N6Svvu3ddvpKW4eD2LK7SHxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mi+Y0Ggh6sJuJsLd/qdBqP+VxiPGWPX8D1JECrfZCB9LLyzAVIGdWAoOmeknuqvsz
	 zs4j6zacDQ9cDIVEY43dQSMaTdGublwXAEC+aWgBgC/sMvZInlwR/0ccKL0C0cTDNm
	 6kP+tNlRnec98gHKc3GnjBA69DB3oL9SF4c8JuZ/pcoVICLAwqomI0r1YlnAocuN/E
	 W1niRo+fephsmd5xJCtzLPpk0f5bKMWvWpX/N580IuUaADFQDUb0qRSHZex+o+8gnN
	 szbO8fd/V87x4/nib2pBC/YBE9BuXbQpDpK/2j5qSBGYJSkO0/qiTt4K2V/qWzuUnC
	 G8AzKfrjncVvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CAD380AA76;
	Fri, 17 Apr 2026 02:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: pse-pd: fix out-of-bounds bitmap access in
 pse_isr() on 32-bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177639362279.3490984.676013154429796843.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 02:40:22 +0000
References: <20260415130300.806152-1-kory.maincent@bootlin.com>
In-Reply-To: <20260415130300.806152-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 github@szelinsky.de, thomas.petazzoni@bootlin.com, o.rempel@pengutronix.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Apr 2026 15:02:59 +0200 you wrote:
> In pse_isr(), notifs_mask was declared as a single unsigned long on the
> stack (32 bits on 32-bit architectures). For PSE controllers with more
> than 32 ports, this causes two problems:
> 
> - map_event callbacks could wrote bit positions >= 32 via
>   *notifs_mask |= BIT(i), which is undefined behaviour on a 32-bit
>   unsigned long and corrupts adjacent stack memory.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: pse-pd: fix out-of-bounds bitmap access in pse_isr() on 32-bit
    https://git.kernel.org/netdev/net/c/5099807f335c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


