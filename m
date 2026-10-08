Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F803A5E70;
	Thu,  8 Oct 2026 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426616; cv=none; b=ZODbOqn8xoq/JsqOYdeZIDqsRAFZtkYGNycxZ4DdMxENc8qoXum6txi6p4S1aTXtV2zDZM8+motWYL/ksTuXO+tQx+LPvsYOyjeC8YJlz9gaTjxmQUEdHjm0ZLS79w2PTqA/bMMRHlnZWPMWOqGgWxmGUeN0Gs5mZpykO9d/kAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426616; c=relaxed/simple;
	bh=JjnQ2NmHnO714o5ECuJkVXspoErwbcNIRDk9bhBZCHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ouuuh3JE/iad5cNs5PzFJhUzaLpAiQoE1+7FDU1fLlKRdcamzpW2kLoV5sirsQKkSyeDliKbJQ5pkWlk2SllohOGyA7Ed1Qw+mZfbjdwuBJqJXhD2x8jOXC+7wR03n+306EvHQJG6DkSAlK36jkf60Nd418jiGJKb4VTsytrUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REKLYEGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REKLYEGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE17E1F00893;
	Thu,  8 Oct 2026 02:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791426613;
	bh=Cyvp8J8O/UX74ofdZh4G/na0YJdI+aB9VUs9pqWXgKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=REKLYEGH738E4/6a7AA78ohMSP+ASotQsNber6/lrZgWMch+wqU4CvM438ePi0fjb
	 s7wC/zgG+3JTr8iNyOTnVbamFh61eGJHOfJwDZmcFlUQbh5K1OjJYKAy33aBDP7+dC
	 dlWNV/h4A8WuWxfsvY0GSbcvhBtS6Q4mvDJBqtwjR+qT1xUWQHlBIhezlTJkH4+Cis
	 i5exNp9e0NBxcRNJfOenacy8JoIKskOdBUm8w8/ygR2ikNyfIvxLoJT+unvWkaK/Wj
	 eLQ92MbzhzqKyvWbMIFqgyEoV03LQKmB1CIL8MBSHZf3eFi4EY5uO/6yR0e0oEuCxG
	 T3vTBI2hkA2nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B42D63809A09;
	Thu,  8 Oct 2026 02:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: r8153_ecm: reject short register reads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179142661227.3776717.15877279078660669633.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 02:30:12 +0000
References: <20261005055943.35180-1-xinsheng.zhu.ny@gmail.com>
In-Reply-To: <20261005055943.35180-1-xinsheng.zhu.ny@gmail.com>
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 01:59:43 -0400 you wrote:
> pla_read_word() and pla_write_word() read four bytes into an
> uninitialized stack variable, but only check usbnet_read_cmd() for
> negative return values. The helper can also return a non-negative
> length smaller than requested, leaving part or all of tmp
> uninitialized.
> 
> pla_read_word() may then derive the register value from uninitialized
> bytes. pla_write_word() may include uninitialized bytes in the buffer
> sent to the device during its read-modify-write operation.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: r8153_ecm: reject short register reads
    https://git.kernel.org/netdev/net-next/c/802f46305787

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


