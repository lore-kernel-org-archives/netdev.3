Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2729E114;
	Thu, 12 Mar 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277817; cv=none; b=i+5JvCzgWI2gXcwXovVL6bfnCLhZPfW+o1V2ygNCS6E2ohP0/MJoeFRomu84rene81wzA/Hxio/Rx/xckBwiUfzDNl+sB086SqUc6SzzxVosBxkIWaa8O1HfxQW0ugPeYqrgEPcDdhZpOjTt9yn1m5ZousmnfPu9C4OAIPlMvwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277817; c=relaxed/simple;
	bh=2VnEX2d2kKChCsMfXVjFhEUVpPvckvqNRzWmuUKDOZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IAuVWhQqP7n5PUZnH1zvQaSn+YqXBUxAX+kXdMFzjh4L7Afdb/CJnH0ZkA9NZBDeG639XRz9yuLmkz+SlENRu+o8bwgs003chc4wQJRfmjkndtLKzmMsKjdo6hUjxhRTaHK2vxzqt+MhBNcxFkpvznsI3c1RiQpI7Td0tXckgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWH5v7i0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWH5v7i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2F5C4CEF7;
	Thu, 12 Mar 2026 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773277816;
	bh=2VnEX2d2kKChCsMfXVjFhEUVpPvckvqNRzWmuUKDOZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MWH5v7i0GAwzWOKLOmTkbyl08UKsT7GlzcQtJe8KWr/Sn/KIPa2W9zlBlfXtCCHcg
	 59uEVMwwdGzhhVoQ0tvCqaJnly4/S1ow0fIyCVFgo3zWgWUFUXb6+vj64VSTGxtZh0
	 0QXywMMf6UmeozKWdIa28iQ5VkuypUNV7a6gq33q9LzEFDFPTbxvpRr6B/UC9OQc1d
	 +p+dLrfliEwKaWefEUqKSNFPTCN//B2bAa/EM36XlSr2FJtdNZEaWJBWwS8elz1g1k
	 sKIFqsjAvJnu+bYS/tFg2ljFLtPlke3sMcKu9gb4RCs2AyHc7FJKA/CFSdF0dNHo9L
	 J7LvC8HL/T1mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E8A3808200;
	Thu, 12 Mar 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: microchip: Fix error path in PTP IRQ setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177327781280.3893274.11029073930876613838.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 01:10:12 +0000
References: <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>
In-Reply-To: <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Mar 2026 14:15:43 +0100 you wrote:
> If request_threaded_irq() fails during the PTP message IRQ setup, the
> newly created IRQ mapping is never disposed. Indeed, the
> ksz_ptp_irq_setup()'s error path only frees the mappings that were
> successfully set up.
> 
> Dispose the newly created mapping if the associated
> request_threaded_irq() fails at setup.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: microchip: Fix error path in PTP IRQ setup
    https://git.kernel.org/netdev/net/c/99c8c16a4aad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


