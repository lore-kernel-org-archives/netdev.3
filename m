Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99D35B64D
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100034; cv=none; b=RgPHPSw4qt+eTGPXC2c0XpUpO/ET8v5ZnpBF06hnXMIWMGE7D3CcXVkzy7veEM4la9JZpX8Ma2DecZv0vVI5cvQF6AixeZtwqkLxNX6FsDFsF/3KNZcGaPHuWzA6BDtxLh5wOrpYCDxTWmTTMEtlTgHRDvXGltTbh8AJqvIwpE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100034; c=relaxed/simple;
	bh=r/7AcvnZmLhiUSukvelwDueQA9Aa8psmud/lHKM3+7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=epERSY4z13oJCLYi8A+VzNcNF47xf1IxKXZtythywtwby/eAi8D6aNRCW3s9c2KHWHJwFG/TUpZy689hSemAoBV4bwWvQnJBzuOQ7eBuTOwVMyr4a3wPE24a4USf6/wbViCVL2NDIhUmTGg+YP/JY2mYe8SGax+fUBGzJbenY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyjQaAjq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyjQaAjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70FDC4CEF7;
	Thu,  2 Apr 2026 03:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775100033;
	bh=r/7AcvnZmLhiUSukvelwDueQA9Aa8psmud/lHKM3+7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OyjQaAjqgAs4GnXXeb4OumUksQYvT7mgoIpfpBdsneJ+nsvki9u6vgoG3xx9SgDFd
	 +Zk3xKMgRH455Czr6aa3lWYKbcqtxJ/4hRk4+UNPzk8fm/AQkLvtYtYpt5dIJHzDW0
	 PzPD3Jro3uDz7mW2yFl2W3ZB/zRV3nudyXeJoGetL3N4lDAQ0YJWJgM4678APTe4dl
	 LNHG4S7Wm+ad3BhdGY0urdFth1lcGA+tR82tvmT+lpHzISMqplPR2tZ/TXQgO/I4CE
	 XB2WqakCXzf2hjUkgif4N9aoTfnBrjXZQ5ztYJLBQUs/n2cj1L6l4eogl2Hr4QAFjR
	 +UHKpH93aXnNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F103808203;
	Thu,  2 Apr 2026 03:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] bnxt_en: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177510001628.3972881.2911888747538140018.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 03:20:16 +0000
References: <20260331065138.948205-1-michael.chan@broadcom.com>
In-Reply-To: <20260331065138.948205-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 23:51:35 -0700 you wrote:
> The first patch is a refactor patch needed by the second patch to
> fix XDP ring initialization during FW reset.  The third patch
> fixes an issue related to stats context reservation for RoCE.
> 
> v2: Fix Fixes tag commit ID for patch #2
> 
> v1: https://lore.kernel.org/netdev/20260329232528.870637-1-michael.chan@broadcom.com/
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] bnxt_en: Refactor some basic ring setup and adjustment logic
    https://git.kernel.org/netdev/net/c/ceee35e5674a
  - [net,v2,2/3] bnxt_en: Don't assume XDP is never enabled in bnxt_init_dflt_ring_mode()
    https://git.kernel.org/netdev/net/c/e4bf81dcad0a
  - [net,v2,3/3] bnxt_en: Restore default stat ctxs for ULP when resource is available
    https://git.kernel.org/netdev/net/c/071dbfa304e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


