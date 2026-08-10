Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C150403146
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403459; cv=none; b=RRhyhKdPdMSN0kYc9FnZrYp6EplTeahUJaYUHVwUsjHK2ngnYH7IxF50biBmGr6GQodLHm1ph31lt/IYJqFPR9zbu03qPr2xv12mH6H51+UJ0m5qTDpjwJLOapqbfyKRD1Fgi93MntgVwH/wak2xWL53pxsmfaUnXvRlRuL2NMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403459; c=relaxed/simple;
	bh=+DLzZdzbtUCr1YTDFYL4DNz1QuNUEOzHjkEIiZEdbBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qmrnyWiTaBDo+M2nkZYRpO+sDxE18LTEZEcqGkYuR26uI21MOBuA5ryL+yanm6WblfsPBRmDX3P63f2etdmyEdRMQOizwMQu0mwoADnbhRZ+DvU/64FcRtjmypngFzKq+KrtbWzG+iLRLAjT9QEKBe1aIF7lkT5hAx288wPnHPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VastCcyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VastCcyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174E71F00A3A;
	Mon, 10 Aug 2026 23:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786403458;
	bh=XnrfiUDUM0hF3yat9vqDXODZEzslUp9M6k4+HS5bmE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VastCcyztVxvoQB+r1JvSinrxqFLb6tBmhSZETm17Wu/YweEjmNumKlSwWnoNZlI+
	 KVo0sP6QPK6vvjZUI6Zcua9IkMjb0WVhS5ssvKWd47hdRWft02Hv5u2SLaSocx2WHO
	 BuK5Cfu0JDS2pdcboe3pbRD9gevwydETd7GMKqAWfaK7+f3PGakRbSurL86ulCuNFs
	 84bxRMLHeO74dymgPZYO/85GOmGj9rVXFVRLG9Gp3Y4VCXQhTvDqGJw78swBer3KyI
	 qn8x/eg1HZiKz5m9kwTLCFE8NYYLO3LzwI9vBpaZGU4oIasMjbwKtU22jlBe7rKRGz
	 kIyIrWk851+0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A443926265;
	Mon, 10 Aug 2026 23:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] amt: Don't support cross-netns setup.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640341439.247552.5618775617996938441.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:10:14 +0000
References: <20260807020326.2519445-1-kuniyu@google.com>
In-Reply-To: <20260807020326.2519445-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Aug 2026 02:03:23 +0000 you wrote:
> When a lower device is unregistered, amt_device_event() tries
> to unregister its upper AMT device, but it has two problems.
> 
>   1. amt_lookup_upper_dev() looks up an upper device in the
>       lower device's netns only
> 
>   2. amt_device_event() unregisters a single upper device only
> 
> [...]

Here is the summary with links:
  - [v1,net] amt: Don't support cross-netns setup.
    https://git.kernel.org/netdev/net-next/c/e99ecc3046ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


