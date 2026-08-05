Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6D1EB5FD;
	Wed,  5 Aug 2026 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895846; cv=none; b=BKnUFf5MJbvBxOpaLpQW0bVZMiIMBYGDrjMMYpaPHy1Y/DeKjuPy1TZ95W5jHRAOHM6MokcyZmYwkAWtFkT+FGBiDWEgyN4pepKjX4OpwnZS5RCLs0pIcT0/zxZcjxiKYIpUFgcYhqoa4zVkkjfPQZ2fivb+Bqwe453tu/6+sCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895846; c=relaxed/simple;
	bh=+rNU6tr+/6Z7qvvI9x2V7zCIUeMd7cXEVsKEmOm+t8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pnpbt9NGakaeXg+hbe+Py/QawBs2VwRCQGWeyVG/f/fJeTw8I49/YemleDawvGKKIot/fkdSUlyVvf6lZYuQogpb+5YvheRkMWFczMQVMCJ5aVrOuDRLnTkwpJ44YTZG6xaFKTuunoMWOPe9ddnFJR4J5mt/mcHGHSx03k1AbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB+Kt9cL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB+Kt9cL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C291F000E9;
	Wed,  5 Aug 2026 02:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895845;
	bh=Pai2kZO3RBdrY3ZtP7Dqyr9GC6gcdW+fNyBqL0mbXec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mB+Kt9cLZJZeFhwJ9CorXGBax6MXgG2L98+UykS7HfS0sY+qDxmeCPeIWD1tlw3qQ
	 ofmFU8Mt3UOwMmRs/5jk0BccDWQdPsAMXm5cha0gV4GW/xo3grtq/11Ab3pjVUscCh
	 LEaBFer/kwAJjLH/sUI8sGeZmaVq4rd1z1j6aQSssmAFv5RHFH6jBFT1Ln/P/B0IWO
	 964nSZ9NzyVk8PPt240gcRmNPZLfLg7tWkZ1hMJQ13punP3K02XnWjnwr7TTKT1Eeu
	 mjxvNcpCiWbVi/rc+3RN6FjSkzb3Mk+Ztm92sMM1V3lT0i5KimrYZF95xCG+2uoLCn
	 MpniLSrFNldlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099F3926667;
	Wed,  5 Aug 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bonding: check register_netdevice_notifier()
 error
 in bonding_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589580539.3876081.5205422408146857454.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 02:10:05 +0000
References: <20260803090012.142638-1-heminhong@kylinos.cn>
In-Reply-To: <20260803090012.142638-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 17:00:12 +0800 you wrote:
> bonding_init() ignores register_netdevice_notifier() errors and still
> returns success, which can leave the bonding module loaded without its
> netdev notifier registered.
> 
> Check the error and unwind prior initialization on failure.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net] net: bonding: check register_netdevice_notifier() error in bonding_init()
    https://git.kernel.org/netdev/net-next/c/b16bab325801

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


