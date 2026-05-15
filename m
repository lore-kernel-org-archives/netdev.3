Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736E1DE8BE;
	Fri, 15 May 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808061; cv=none; b=G2lZKXujiC47kpaOWE4vdtEqfuiC1Kd030l8W23BwLIO7X3EU5n1baMKctxvyWBOswUHNiFmIYeG5vjznM6wYnqQHn9tdPrqXgRbUEwuOtrckWMZWB/7ynRHHlRhsKpF0suVWK4u7pR5x+OcQ6AMHgDGEchxAuPCOX08MqYu3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808061; c=relaxed/simple;
	bh=vixR+NcNe3DosSISesGP9v3e0AqCPZv9q5Th9ASWfC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P5peLzr5vJBjU86d41LPTpUHC5J/FZ1j3anQmnPzRjsRrj/uRhFsu5ydqWjNlMREa3XCbw/dvcPJrpRchlySPvzSXJ6hcKgG3qLW9IPbY+7fXdaazelLd/duGjCmozcMvARcxBbblOYe9az1NU4LkHIiuORY0J1GSvGn7kfQv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUTpASeC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUTpASeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482E9C2BCB3;
	Fri, 15 May 2026 01:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808061;
	bh=vixR+NcNe3DosSISesGP9v3e0AqCPZv9q5Th9ASWfC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GUTpASeCy85j9QmtLDbNJvg+Zwp/jHaV34/QCK54QsoOTcfTrTIiW7cyCh40dIrMT
	 YgbxW2rynyDWCoYMqFw20PyNM9f9SHrm4QKGZQVBkKLggv1mt9zv/o66JHlCMWuX55
	 j57xsJvPWF7Qp3byv8e529tQggybbZGETCIvQa56Qsw1cONuf158P6I8PcUax5bmPB
	 vq/xsnLESvZ4hXTr5BSfXt8BPaAj6ivlfLDIaLLLiqyhk8rQfF6gttHqnlcO5AGVj0
	 seNLX1vOKxJ82PKbHLc2gusXa42aE/NeTtLSAu9xodVa+B5irRgHl7TKrBolbzydwz
	 eji8huSr2UOhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE739E4DB5;
	Fri, 15 May 2026 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: fix double free in rvu_rep_rsrc_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880800580.150313.8207368814594738900.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:20:05 +0000
References: <20260513151320.213260-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260513151320.213260-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org, zilin@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 23:13:20 +0800 you wrote:
> rvu_rep_rsrc_init() allocates queue memory before calling
> otx2_init_hw_resources(). When hardware resource setup fails,
> otx2_init_hw_resources() already unwinds the partially initialized
> SQ, CQ, and aura state before returning an error. The representor
> error path then calls otx2_free_hw_resources() again and can free
> the same resources a second time.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: fix double free in rvu_rep_rsrc_init()
    https://git.kernel.org/netdev/net/c/e8fb3de2a8ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


