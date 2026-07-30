Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DD17BEBF
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372649; cv=none; b=blsox37JDCQQQdjyqPjIIGE2m2k17ijMp3li7m0jviV9NJ6BR3rfoafbqQM0bmImWW4RYb6kaKxBcqkR68V6xgahFJ+f1xiFbuE9NZm5a3BBJTyFThcNKCRK9exzMSnRZLuVm9XXXSQN7AFr76RgB1Hy0nsuGn3HMXNlRV7gOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372649; c=relaxed/simple;
	bh=bW5KN3iXPlDdJhun0lUP22gct8jjTVtdKx5ZLHXe3Ug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g2OJGvwBTuAAvk2p7EjD5lN5TOSdHZjtEWsMr03rARFOoimXUn4hwgmcJT0HHhO1QwDwsSOUhjrgA+8BKAPHEJULlz1wZE27+1y8TENjsTOhIKBajhnR6qJ5Z6HC2c6E4qZ/OdNY/rNjXc4HOkuJcu4tVmdQMekc59ISQ9kvXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhUQEZaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhUQEZaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679881F00A3A;
	Thu, 30 Jul 2026 00:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785372648;
	bh=4EWWwZfEqdW0+vbxJmCwbHiQBi6lOzJHLG1cxTrwb9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RhUQEZaXrwrTSGJ8Lku7rAXt8y5xs0DFkEP07drhVeqz9lB71sdBX5u2A4OYpWFpL
	 Z2w8/HaAffnOqHkIcX7xQHr5g8SzDG9odBsII3qB9Rvg27ofGC24rjW7qfRqT8TFFV
	 Rq6WCqhBF1ncPINlagoYBc+rSFUbmou/FZ2zLOdJxrYagYmTCryglCzJQINeWofcWm
	 TmAO3tIp9FVz642aBJhwAk9Z4DFuOtqC3wzlxYZ5ZwWQ4p/5UmEwptLDz/xSLTMWD1
	 MP3mj1B4gcrA9OAoHwGw0JdgwEC/W4H+vQI/K8MS8b8TV1FWFs7NaQVMkkhSAiJrH5
	 ToQI43MajKrOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8D3926251;
	Thu, 30 Jul 2026 00:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: Fix E2E delay mechanism
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537261239.3300615.14871055634290835947.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 00:50:12 +0000
References: 
 <20260728060904.31993-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: 
 <20260728060904.31993-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Nazle@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Asmade@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Muhammad Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: netdev@vger.kernel.org, rohan.g.thomas@altera.com, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 23:09:04 -0700 you wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> For E2E delay mechanism, "received DELAY_REQ without timestamp" error
> messages show up for dwmac v3.70+ and dwxgmac IPs.
> 
> This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
> Agilex5 (dwxgmac). According to the databook, to enable timestamping
> for all events, the SNAPTYPSEL bits in the MAC_Timestamp_Control
> register must be set to 2'b01, and the TSEVNTENA bit must be cleared
> to 0'b0.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: Fix E2E delay mechanism
    https://git.kernel.org/netdev/net/c/b041ed62aa6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


