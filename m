Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861042571BE;
	Thu,  5 Mar 2026 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676009; cv=none; b=EuCqxwkMn+kDQIY+0+KtpRUOGdHzc2ejugHErJ/R5VzLKIo17Zt5xV2aJ+mwwuRbiE/q1Yw9G1OUD+g1RDfVBQSkL8B+LwPnmOlGz0+tKw8q+PmSAd4i4O4pUhKeCt29Wr2sLIKmSu10ZQX6cc4dFM6L9fxdyLWXxVNwWsbYaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676009; c=relaxed/simple;
	bh=0kk2Gaw85VM7v8obVqo+8TWqra0YrF7sPYtvdDXgAKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LenXWFQfgS9vXbLdpd+bq0WIbnWZC11TOa6F6FZuG5nGluDKMvSMCqWNQ6IcQGqxhBLjOjwzDga15lWFufhBAytoH8ouFKE1+Pe4yPMXA/ylP/KsS+IXtsqDNkVIuiHDHCiRAkS8fh6Mx8ut2N+kAAqipUK1zuO75nAGStpc0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz+dMEAQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz+dMEAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32580C4CEF7;
	Thu,  5 Mar 2026 02:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772676009;
	bh=0kk2Gaw85VM7v8obVqo+8TWqra0YrF7sPYtvdDXgAKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kz+dMEAQLkFTTwcnhgXzeU/BubsO+MGbJnoYYFf34pXsrHsaRXSUd1V9opy4k3xdJ
	 aK8diejhqM7LNeKP1H3PFkGWeys83RWpf+LhjnDCM4xQG4JT/rRUg4UNjRTQnIITfx
	 AafYdRIMmBH+JnKjRifCFm/A+Dr7lmVuZIYJECg9zn14hcKs5vXI6yGQohD++Zddh2
	 HLMZoGHt67h/VXCUvVO7B9iukkNyscMIJDES8BGKdeAXzcx/KwDKELraVNi94fwSiH
	 O1rZl2Ez4x5+LZiYWoiZ4bSc3eZJCtQOThB4t1uWl1g8UL87hK63/STQP9UwZBMjSw
	 jgUCU/1qrcJWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0D43808200;
	Thu,  5 Mar 2026 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] net: nfc: nci: Fix zero-length proprietary
 notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267600930.2478763.3590512130422753607.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:00:09 +0000
References: <20260302163238.140576-1-ian.ray@gehealthcare.com>
In-Reply-To: <20260302163238.140576-1-ian.ray@gehealthcare.com>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, krzk@kernel.org, jeremy@jcline.org,
 ryasuoka@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 18:32:37 +0200 you wrote:
> NCI NFC controllers may have proprietary OIDs with zero-length payload.
> One example is: drivers/nfc/nxp-nci/core.c, NXP_NCI_RF_TXLDO_ERROR_NTF.
> 
> Allow a zero length payload in proprietary notifications *only*.
> 
> Before:
> 
> [...]

Here is the summary with links:
  - [V2] net: nfc: nci: Fix zero-length proprietary notifications
    https://git.kernel.org/netdev/net/c/f7d92f11bd33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


