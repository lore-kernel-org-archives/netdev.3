Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC94368D57;
	Tue,  1 Sep 2026 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224468; cv=none; b=rb2s5YtuySqSzUQ6HtA7A6+zzqvzEGROEzFu3+7jy/QupgmW/H/bnXvPjQbO98aslNJJ3Xfbu9zXroVGsJEBXwOf5JealcX7p4SSAsdU6Qn9emOMJ1FX6lCk95w2TaPw/CbASYO7KgJLReodi9qOs3mRIrtEuBvyTdurRsE3Vd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224468; c=relaxed/simple;
	bh=mipydyEjHYfdhAPCLXZ66tBI7Sv+IqQT4SHorWwipU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CYkXpyz43n/qgzuX12ClFcv+4b9KURd3FISxnAJOXZ90Kg9FwwvfCccwbL9ezr5n5iebDn//bfhzPOUqBXpfL+872hDHYldoDrQr2gSgE5DQHs7t7le+lz20sq8e+XFJMBIvogF+eDM04zZZbz8kpY7C886hUIarw9wOEDEvZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHXvtnV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHXvtnV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24891F000E9;
	Tue,  1 Sep 2026 01:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788224466;
	bh=qb5Sdcffuw6jgiRZLGzjS48W/Bl53rX7hLmSgwGrXEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lHXvtnV/KwfmnGvIuCPc8QYCui78lhSD9v6wbZRsA3zfs8u6Es6YnVE/L0nkuAxZR
	 POcUKleOFGb4p0XCzsiffPx/DSrsti/rkqA3HV8HRkeGzzpb79FNLxO1o3O/BPiHsR
	 KaVPi8XkKqWzOE1oH5yb0hFVSWLMER5bkPoRHJ+gywIktXFPPxCng6kVuppkKcu6yN
	 jbawX6WcYYcpKyfdDOUuc3ahfNJS25hbvmOyX3xGYnJQIbtGlOhwMv40Ute6NbFU7B
	 f+GY2zz9ZBH3/GBVMk/E9v9LQBYl6f5Uz8RcAfG0xl4ImysbF7vvNgy7VoSobndIL7
	 VfZauIt0tDUZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099B3924A40;
	Tue,  1 Sep 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] ppp: ppp_async: simplify tty disc_data access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178822440939.861275.10014391745794552179.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 01:00:09 +0000
References: <20260828073245.126804-1-qingfang.deng@linux.dev>
In-Reply-To: <20260828073245.126804-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kees@kernel.org, jirislaby@kernel.org,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+8e808eb853386f575d86@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 15:32:36 +0800 you wrote:
> tty_ldisc_hangup() invokes the hangup callback while holding only a read
> lock on tty->ldisc_sem, so it can run concurrently with other line
> discipline callbacks. This currently forces async PPP to maintain
> separate lifetime protection around tty->disc_data.
> 
> Line discipline close is called under the write lock during hangup
> processing. Remove the hangup callback and rely on close for teardown,
> as done for SLIP by commit 23c53269f2ba ("slip: remove slip_hangup() to
> fix use-after-free in slip_receive_buf()"). This serializes teardown
> with all other line discipline operations.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ppp: ppp_async: simplify tty disc_data access
    https://git.kernel.org/netdev/net/c/9feb069e5ed0
  - [net,2/2] ppp: ppp_synctty: simplify tty disc_data access
    https://git.kernel.org/netdev/net/c/d8d4d1cf40d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


