Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E329B76F;
	Fri, 13 Feb 2026 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015217; cv=none; b=mGXQUa7/qZiv97+OseeOQOgnk5v0b2AQRlK1vaZ8qL6VsxxTWhUtkJReUbddZw2150WWICMtWjE7TDpX9eyi2VbXKnSBMkPkGYFwpSs0rxIcIuj/eQNkhIm7M5eTv3Ks+Hhwg/MmBOk8lGmxLRXQaUGMlTIC65oJ4QbZpA2DVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015217; c=relaxed/simple;
	bh=G7QvLL+eIKztV9yjyjes6G3D+BHNcxmYXOnXri5mbgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C5maIS73qPPZ3mmtAbGdAOAZXHWAs1srH65UaeEcSoFmOVTEkCz8HKWMXiQ5HQi/wv6xcvPki86seXx1l9ad56JJiR72Krn95s0fKVjvyIU0o5CIJBK6j7amIKUyXRUKUTv6gV9vwqbfnjpzdeup+/r/5xQjco+BRNDUGDMs30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofh/qfP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofh/qfP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D84BC116C6;
	Fri, 13 Feb 2026 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771015217;
	bh=G7QvLL+eIKztV9yjyjes6G3D+BHNcxmYXOnXri5mbgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ofh/qfP4BpbXIZ7aeCENVGL8xkB4vsQmYd5e8H8FsjjiYAjfefK27lMEMnANlENog
	 5Le83tgWHqZqvDujB4O3KtwdLZHxDf+UwMKJbKWH34n5Uy5LxW1Xd7fmEMcO545i1s
	 pILY6whoF8UxgNba4ETtsCaFEOXJSgoIC1/AWE+X3EKbnYqtFOgiw+O+2WZhhD70Yy
	 sC/B+WzaoH94xi/xTKCo9xHTgbKeS2H8FvbWukByd3upnpblPGRHu2Zd7p5TWpXp2r
	 mjoITsGPTRjEZuPUfnO/0/R0LurD7UyCnkorel08QhwE9RScxXUvlu8hJWR29VZj48
	 KGkov/T2TbyFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852923811A44;
	Fri, 13 Feb 2026 20:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] fbnic: close fw_log race between users and teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177101521107.2551386.8449101353077047132.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 20:40:11 +0000
References: <20260211191329.530886-1-dg573847474@gmail.com>
In-Reply-To: <20260211191329.530886-1-dg573847474@gmail.com>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: kernel-team@meta.com, alexander.duyck@gmail.com, lee@trager.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jacob.e.keller@intel.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Feb 2026 19:13:29 +0000 you wrote:
> Fixes a theoretical race on fw_log between the teardown path and fw_log
> write functions.
> 
> fw_log is written inside fbnic_fw_log_write() and can be reached from
> the mailbox handler fbnic_fw_msix_intr(), but fw_log is freed before
> IRQ/MBX teardown during cleanup, resulting in a potential data race of
> dereferencing a freed/null variable.
> 
> [...]

Here is the summary with links:
  - [v3] fbnic: close fw_log race between users and teardown
    https://git.kernel.org/netdev/net/c/ee5492fd88cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


