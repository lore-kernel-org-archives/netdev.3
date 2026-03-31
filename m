Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4618859B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918821; cv=none; b=MsUjSZ/bX1GvXhB7kr4D3B6TgzJF/xQmeTkuyfpS4qv8+0z783gh0X0xQBBQn3DcKXMCk/y1hBafCLGhlBPCglQKNfYDAw62PS+Stxy6oAjBGONsQNRyJMJhiTP07ikuYyOVESZVDXZX2hhFq3h84kxWwBRtFVgfjBuCAlzDSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918821; c=relaxed/simple;
	bh=szpEjX0j6heXzguxWqJ0qH7qpPaR+6vOp8U6CI4dkXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FurC3Ff70ImOzvyD1UwV/gCtuNN4Mx6f5EmlP3zCG1cfMbN7nRFWsxsy4lH09eelH1jX6/e7XLMiJltjQ7mGhDLkVEl5jmetolPbFLSFwWLA8/DMc4BolmH22NWoHeKtTytG+n+rTXl3YXQ8v7maioOlVdihlP4bftW7c6CbEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gijhxp5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gijhxp5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B15C4CEF7;
	Tue, 31 Mar 2026 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918821;
	bh=szpEjX0j6heXzguxWqJ0qH7qpPaR+6vOp8U6CI4dkXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gijhxp5S35kX2LmIbq7BsLVAGOIjfArqd1GvOuzAQOh+x4TGgku2C2y7FVs0Nlxxm
	 ghCe5TJkDmgUKYdRoA8dg/FmyPnS4kZPR/TI8SMxMWVHMw3cYt6QKg0NXK2+YiYUDh
	 6UD1na2OlRGRbX/qg8EfeDPH1KMaYm/itnvlhhx9NvY8ZuCY3r107qop1wK+L5m7v9
	 MEqO3HZyqXCOvzostCgW1VfxkQDUYEl+3Fc6bpBZ7XPLeLh2qwj9rhv7RzG6ecvQw5
	 gXHVaAyK4a3680PvndlYtcX248+u7nRel7+s5CBeI/QZbNmLORQ/ozHIMyfQorAhvr
	 XZGwwQLpaj07w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2A41392FF97;
	Tue, 31 Mar 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: cls_api: fix tc_chain_fill_node to initialize
 tcm_info to zero to prevent an info-leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177491880562.2039242.10970042830045841478.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 01:00:05 +0000
References: <20260328211436.1010152-1-echelonh@gmail.com>
In-Reply-To: <20260328211436.1010152-1-echelonh@gmail.com>
To: Yochai E <echelonh@gmail.com>
Cc: davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
 security@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Mar 2026 00:14:36 +0300 you wrote:
> When building netlink messages, tc_chain_fill_node() never initializes
> the tcm_info field of struct tcmsg. Since the allocation is not zeroed,
> kernel heap memory is leaked to userspace through this 4-byte field.
> 
> The fix simply zeroes tcm_info alongside the other fields that are
> already initialized.
> 
> [...]

Here is the summary with links:
  - net: sched: cls_api: fix tc_chain_fill_node to initialize tcm_info to zero to prevent an info-leak
    https://git.kernel.org/netdev/net/c/e6e3eb5ee89a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


