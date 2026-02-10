Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEE316904;
	Tue, 10 Feb 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720010; cv=none; b=GRE2RW482nSItEAPzi4gJSllhfejwk/EtZFMT7uBU8E974cx56ciUsfnr+kAsPYtObyUDCwqLzt7lbZDf82srKiZptR7/+ETWbIrygk61jpf3twQVfgegScgSRLvo9lutaMGPzpcSWZcHwPM/ICF/5hko5rIHy1aqbdkxvtQQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720010; c=relaxed/simple;
	bh=FIv+tmEXWh9/H5O+J8eYReExCUXlQVL0LHvRMPQcucQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nn7a73z65kRemc49IGo3bcSSO/u82pV8/SLAHHUb7/aUPdQZR9YqbaX8cLoF4NAyOhIMKwUGoTi3ZrAVRFiIccpO9Jo3PIXI0bRg+D2SIIO5rhApQm2TtxC2EuP3Sj6NstuFIW1KD3l3nOMtLPKzJ7+f/AdbuFFzMy4CtsPkn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy3aLxez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy3aLxez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B9FC116C6;
	Tue, 10 Feb 2026 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770720009;
	bh=FIv+tmEXWh9/H5O+J8eYReExCUXlQVL0LHvRMPQcucQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qy3aLxezN9koXDlD36Ev/BeXdS7s0wRDfW/jsbhhUVGCj+xe5E7JL2NPFDP+kepVO
	 wtILpau2nav3Jfy87D5sQVFPURKTqRLLVKCXeZvm9PSOgl0IWaRyB9C4LAU/gAUF/S
	 eK88lPNRxCyANoftUcX3RXJSsLq3cZ0ozDSvOg2XhcmXOIn9JX2PFSvL9vzYA3nL4c
	 azAuzLoIvv//Wc5ruMqeWh5xfbj639NizTCak14q5wMNeKz0WMA5wQx19V0QxNZUVG
	 Ow5TiysFr8XsEmRLfLam8SiIyFhhNj486L0JVSd+jmUbaa+0vsdFW1Eeyu/HCRQISO
	 nLB4vdPO0mk2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 850FD39B167A;
	Tue, 10 Feb 2026 10:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: atm: fix crash due to unvalidated vcc pointer
 in
 sigd_send()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177072000533.3455745.207010128594113653.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 10:40:05 +0000
References: <20260205095501.131890-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260205095501.131890-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  5 Feb 2026 17:54:51 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Reproducer available at [1].
> 
> The ATM send path (sendmsg -> vcc_sendmsg -> sigd_send) reads the vcc
> pointer from msg->vcc and uses it directly without any validation. This
> pointer comes from userspace via sendmsg() and can be arbitrarily forged:
> 
> [...]

Here is the summary with links:
  - [net,v1] net: atm: fix crash due to unvalidated vcc pointer in sigd_send()
    https://git.kernel.org/netdev/net/c/ae88a5d2f29b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


