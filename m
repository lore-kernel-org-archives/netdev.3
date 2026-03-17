Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDB372B35;
	Tue, 17 Mar 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773720018; cv=none; b=Tgyj+EjAXvtcF48vn5pDsct9R2m2q8odSZABN84XZ/vGe07jpWC6Biy0rMIJB2kSYwnygYvo9HxpwyMS2W3bMzla7eOTAJk0l71IxYYgiiPRTLw2iaefbpv+QKoPhW67hrL2gb2pdaP1UqQUdM3GId8tXkI1/WghSQTdH7IOIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773720018; c=relaxed/simple;
	bh=qh78evnI6b2oNbS3HOo8a6tx5SN1XunAmJL558jOnRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kKfaAzwNGRUA9YWoLsZ9YjL8h+MCoUguamTQ/dLgIGV9ZnU2uYG+0yN1RadF9TdJwy932cUaFiXwu+OjvPf3GcQX7P5G39fxX3z6YdBKmtyzlm+lvR7rNJ8p8PcXLaSVDd21W1lIK9zG/iji3C0rjXJwHMxjy8HggKTs/A8bIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHnjrFNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHnjrFNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7BFC4CEF7;
	Tue, 17 Mar 2026 04:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773720018;
	bh=qh78evnI6b2oNbS3HOo8a6tx5SN1XunAmJL558jOnRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nHnjrFNzz7vN97Uae18SAfnVJVkYhnLCTL8FA/BjPuVmQanyZtsK0ko/T2FP+4ARB
	 TCTtzuPTzTBDCESoKPQO7KU3P/RZcs++X3HLmjF7ZjXfXhzTI8wlmP7wK/OL9nACrh
	 RiF9yRIXOn2tcYPrD+ii2SkWogtpoHwW4dob9LQsQzdGU2S5Ze5AQTW9QkyLRQLYeG
	 wtTr49TCxgpR3ftaGQ8ld4FOmIXPIzU5r+yQmZ/SB68Juwh+VkGu7+gIL1lm2FR07T
	 7YGu9T+0jon0W7ZWPTHeeyMJvAOhqd/lvd02E289V7trT6T9q7HG/52wDywluvtA9Y
	 wAysFR4gXl9xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400EB3808200;
	Tue, 17 Mar 2026 04:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] tg3: replace placeholder MAC address with device
 property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177372001078.3420008.8862910370039444826.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 04:00:10 +0000
References: <20260314215432.3589-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20260314215432.3589-1-atharvatiwarilinuxdev@gmail.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: mithicalaviator85@gmail.com, vinc@42.fr, paul.sage@42.fr,
 pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Mar 2026 03:24:30 +0530 you wrote:
> From: Paul SAGE <paul.sage@42.fr>
> 
> On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads
> a default placeholder mac address (00:10:18:00:00:00) from the
> mailbox. The correct value on those systems are stored in the
> 'local-mac-address' property.
> 
> [...]

Here is the summary with links:
  - [v4] tg3: replace placeholder MAC address with device property
    https://git.kernel.org/netdev/net/c/e4c00ba7274b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


