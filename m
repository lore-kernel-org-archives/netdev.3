Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11633A715;
	Thu, 21 May 2026 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329427; cv=none; b=L4NzqMhS0jxdP1Spy1OsWNehzEUOd/YDTUGO323BIVCLxC+FlAghFxGKCSagxo5+1DQVVdg2mVyAi3bHaYQuSNWjM8lL18/PMvEKMaI47wYGV0XmPsfwUzudoDdpXo0Qlj5R5X4feBj3BrzdYg9FstSX59DHi36BSdAJHpXpLw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329427; c=relaxed/simple;
	bh=mIA/+3GpAR32WgQROFnggJXsV0NR/bPuybaawUzoSSg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qqhJ/gBbZ3055AHwh3elG5xh9bOaZpZuZAeYwcxs+XiHB+vqqkhJpEswFmhpv+7sNFNnkzLJuLgjjZDUtsMIgHmFZaQpcKv6NIPZnClH8I2j48+IAgzinJVtvEEuculEaAv9BVMmk6rGaLl1dU+Ims0vU8ywV8iDnSLEDzeg6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0pe2+Zq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0pe2+Zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF471F000E9;
	Thu, 21 May 2026 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329424;
	bh=RXxIIXqObLufHUtvrkFJgqKRSTfMPon9gL6r7mThJkM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m0pe2+Zqt/q8Ao3JzR+hhSGti/gYjydodpvBXygH9UXabJed/07p8AMyf5gdMwa/R
	 9tZiXJOzQd6I2tKFqCvtOncSJohfpLsYjmCYlK2uv8DEeqmalbpnj1h4Wp5QBwq/ef
	 DPnw60hrfmwNF6uvSPkVyvuF2MUe2MCggnmeSGgJy+n92/ctS/MV1P4o/9LV4uuAr2
	 pM7Yq8CKQcYKnndwCnsMS19AgRsVqjrx3ydUNFnXji0I4ZazaDUjoK6VegzaxlsdX2
	 I6Rx3lTLd43qYKwlDiSTOoOKUCcgV/8yxh0pQ8ISQsUrqRbbo9PpxM1AgfP9sDbrf6
	 Syh80F/NlTz5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938B83930C38;
	Thu, 21 May 2026 02:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] mctp: i2c: Use named initializers for struct
 i2c_device_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932943413.3832404.17668206981539637987.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:34 +0000
References: <20260519153613.1594429-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260519153613.1594429-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 17:36:13 +0200 you wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> [...]

Here is the summary with links:
  - [v1] mctp: i2c: Use named initializers for struct i2c_device_id
    https://git.kernel.org/netdev/net-next/c/0b87d2ab030f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


