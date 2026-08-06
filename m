Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720437E5D6;
	Thu,  6 Aug 2026 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035073; cv=none; b=Q/leljnQ8YVWOa3YPRk7BY+Gvt04QIQdYIAW5V2PqFWuD7EIUuWg3EfoSylq3X4SnDayvi3gOt/Y/Pt9+xC+Dt75tS2DF0TiI43Rm30K1YRv5JPw3+kJtiXUn8VJoB3cSKJccEMazCBA22ak2uGRufcuNA2u2WM61JIDCCPybvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035073; c=relaxed/simple;
	bh=wx61V6k9UT7I6BPYSM0f8QJJq+iOQIRUCppl+UZDg9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gndk2W1j88W4dBts/RNiBMCan+j9a6/ok4MzpFcITBLi/cY3Yshm4oL285b7q+WZpIOSlwFZeF2e3FD0HFkxSG2JrbRUta2oN3v6LGSvO4CVpbz8aHRGoJ+5AYCqBZvvnplzj2EIiT1BsWbe8leSgHp4u9Dexp7E3+sCN25CZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgXqd4oT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgXqd4oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECA81F00A3A;
	Thu,  6 Aug 2026 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035061;
	bh=Ifhfs0fGj2DTHxVW1jC536LInZKvb4z6yJmgO5VTnTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dgXqd4oTXg7JL12o4Qyp89bnljNMSfstpAc8w3J8j29mTzz/KPOoZXMzHqCiK4ZhW
	 wtHHkR4qiEPQlfN62dZEp+gGNxaDVve5VKyGGMA4P/dkeyYZh/wceNSWqPXot4sXAG
	 0Q/4r7QP0S67EpXbkMT4n17VXaWFO8TbnaB/C+/5fPAJ99NyC7p58qPfnWUbaon9jQ
	 BVu7S8EGF1UY0SOcZBn7G7v+UM04aQFTUHxbsk1HyXJeHMDkcFDdcLkpgtZ3Ff4vSa
	 nzV5jTYDLXofYq6OQWZjblVZG9SNMORCMmF0dP2FVGGhdyo3wbpF8CvXlsvpMAmk1o
	 OiNYhEovO2vDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19921380820D;
	Thu,  6 Aug 2026 16:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tls: don't abort the connection on
 signal-interrupted
 sends
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603502065.1375455.781310626292605942.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:50:20 +0000
References: <20260805063109.1772314-1-maxbr@linux.ibm.com>
In-Reply-To: <20260805063109.1772314-1-maxbr@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 svens@linux.ibm.com, brueckner@linux.ibm.com, ben.coddington@hammerspace.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 08:22:48 +0200 you wrote:
> When a signal interrupts a blocking send, tls_tx_records() treats the
> resulting -ERESTARTSYS as a transmission failure and marks the socket
> errored via tls_err_abort() with the raw error code. Later syscalls
> return the kernel-internal errno 512 (ERESTARTSYS) to userspace, as the
> signal it stems from is no longer pending during syscall exit and thus
> never translated.
> 
> [...]

Here is the summary with links:
  - [net,v2] tls: don't abort the connection on signal-interrupted sends
    https://git.kernel.org/netdev/net/c/af0e5cdd031f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


