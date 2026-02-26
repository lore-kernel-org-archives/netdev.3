Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE237B3EF;
	Thu, 26 Feb 2026 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074802; cv=none; b=SXr1wTRQoSJbJDkpPHuACZIkcwSvO8m8qcNSnOJpD6qx1lxRqmrzU/vE09oFYOasXZZr1xh7NXHLmWoQIBwj8JYLxOU3p6vLgq5lrWh7ADp6xbFi+ZjDCUqncW5NmC6h7Kc9I7XncZSgr3qlX7R6Qn9K+aOS/B9b3QS2n1ZFkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074802; c=relaxed/simple;
	bh=OFagvjvC8U7g8UKx5nCn+eSYxzfVlmkV76bNuRUnuXs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eM/wmxxMiDf8M1BO3YBrBPvSQSQUuO7qFGoXobW1jJB1EP9Vbu5NTQ5cKam0G59wfhpPGE1de+/mbYeaCyz0D9L1ockjIawiKATKUuqtKU66/vtPJphMfFLKEAwT40qqJmkmWyq7glPZ2XvUr4H7mWdwbIQf5hGZP17xXEhpdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pByMDzh9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pByMDzh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE496C116D0;
	Thu, 26 Feb 2026 03:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772074801;
	bh=OFagvjvC8U7g8UKx5nCn+eSYxzfVlmkV76bNuRUnuXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pByMDzh9sFCBau7jy6g1XhnRxlqvmMlHNhoAgAVjM9Mb5N/M9yHIhSYgAP+kRudmb
	 s62E9O2f73HIMzEr2l+G+7r+l3Lvgtcjt9rsD82WTw65Idi3bzR+0xI1t9A7xeoHpi
	 THgXZjwyfH5L4H6HcqE1K3DGmq8C+xw73OPnJKHrJv6d8HSEGjokpU8SqSB8Wxjoeb
	 UG2HrvZc9UZQWxg+wLVRfUQyarA1KnBBxtuDqOeB369tbXVOhzsIZyjfLSWZwvwHge
	 7fqRLPT9eeey8k/t8wlMiht9MFUjgqyRRmw76uH5oCGN+2kvsfnt4daVif0WPf6EHk
	 ykvRd2uuZURQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 40076380A94B;
	Thu, 26 Feb 2026 03:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfc: pn533: properly drop the usb interface reference
 on
 disconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207480605.1011529.4354590118191782765.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:00:06 +0000
References: <2026022329-flashing-ought-7573@gregkh>
In-Reply-To: <2026022329-flashing-ought-7573@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 12:28:30 +0100 you wrote:
> When the device is disconnected from the driver, there is a "dangling"
> reference count on the usb interface that was grabbed in the probe
> callback.  Fix this up by properly dropping the reference after we are
> done with it.
> 
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - [net] nfc: pn533: properly drop the usb interface reference on disconnect
    https://git.kernel.org/netdev/net/c/12133a483dfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


