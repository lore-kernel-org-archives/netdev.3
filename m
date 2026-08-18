Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8EC2BEC45;
	Tue, 18 Aug 2026 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047857; cv=none; b=Kev/zDMWZ8ndkCYwlQQuvU92MYRcSdJp0n+mas3sGUUsrRpmW6PxvumQ7b8PBIL1ctVlqWdazxm2STsXkiNOnzZpxbAjrk3SZUQbHe1FysS2zOxfotap252uOPqVw4lxzmKXeK7U1QGOrbK1woeG+mZJ/4UProFPrtRYaifT3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047857; c=relaxed/simple;
	bh=0HOpzrPdvLs47baz8A8dc1uHjatIXxtQdWw6JbwVkZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=stvPB0Wl/uDr3XV/wGrScdfKAuNpt1/k83kCff0ILRVTMmvHCGsUsWzSKAbDSyMUM9ghgSwjCV516WIbr29++uHsj+vUHbPZZEZ6M4SEJ9XU2Fw3qVXX/32BEkIHe5r6asI7wMAzBLi3fZiQJBY2FO0EwDlWZ6Bav6ooymlAmiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2xHcoWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2xHcoWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EA51F00A3E;
	Tue, 18 Aug 2026 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047855;
	bh=xF9k9FvhKwu0hWNlm7t8BtRrxhk0Qzn/1yI2DOhCdJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i2xHcoWgvriWX6xQCyXkPSIbjBh1I4aHlcrqmXe4V2ltLNpz6yZjtqIn85Pb48isp
	 sKEuF5U0kr4xWRMOrOubJZYtEwm7AZUJLvJqSVv8pBsn14OFMnoVX+IFccfLSVf4jI
	 GnJJtc8i4xUTAFHo6fsEHp77CdxJlvvMaeIB7M6IXqsV3/Ovr1JNZw2lktbeKQzOYI
	 RlHahwNsc0SePelwQHKefAGC8hZTx8gLFMiNt0dzlgPpbh4tt5/cXXwqYv229/iyaT
	 dkb6jy8wc3KShSyS+ukNlrD7Vosqlau1e5hDb+geNTBSI3nGpM2doBs0+Gi+ax8DHv
	 LBH797UGlK6Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9391C3926645;
	Tue, 18 Aug 2026 10:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] 8139cp: fix Rx and Tx not being disabled in
 cp_suspend
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178704780717.2000568.3698484772536774625.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 10:10:07 +0000
References: <20260817043057.20099-1-kmehltretter@gmail.com>
In-Reply-To: <20260817043057.20099-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 17 Aug 2026 06:30:57 +0200 you wrote:
> On QEMU rtl8139 model, frames that arrive while the interface is
> suspended still end up in the stack after resume. With pm_test=devices,
> which keeps devices suspended for 5s, 200 frames sent to interface
> during that time and 50 frames after resume, eth0 reports 113
> received frames.
> 
> cp_suspend() is supposed to stop receiver and the transmitter, but
> the mask is wrong: (~RxOn | ~TxOn) is ~0, nothing is cleared and Cmd
> still reads 0x0d when cp_suspend() returns.
> 
> [...]

Here is the summary with links:
  - [net] 8139cp: fix Rx and Tx not being disabled in cp_suspend
    https://git.kernel.org/netdev/net/c/cb7643b78d35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


