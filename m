Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5138553F
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430680; cv=none; b=JOeY6YLHp9q3J7XM/9X3KmIuQpS9gyoPXDQkzKubAnGLm84VIt4VthA3zBXyrC/ohOiU53+Q8YCh0xy60wv0okZSdeeAqaa1T8meKckxrK2jF56gF9h+Lz6iSjRAUu4fi40oGLlcNZRd3gL1MPy+/4g+WUAzT4Ble/SYOOwN5/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430680; c=relaxed/simple;
	bh=HR9ebaDhgcIGvWKTuIfFmxBCOmlEEATKg+/tWrzxV7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q4Sgfc8xCtX3TVBi0foNQLotHhYXDrbwbParC4GWN5ggM3vZXYEzWlfcMAkCYos7fbFD02sXo3NF/+5Xyqk851P4D0xvHOB1Ia6pxC0qAeb3hj5Id7WEGyHqNDMR07KA46lXsfqDa5ewvmwn1Po8LBvPKWzwY/NrM8lujEy/TrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dhue2QGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dhue2QGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C5C1F00A3F;
	Sat, 22 Aug 2026 20:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430679;
	bh=N+Y7eFSesDwPMldg/5UXSU7VI0nF9YvLEtFMtoVSVgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Dhue2QGKfmHCctq1B8CAZUZo9lbtg5/b4meen6RzRFOkSaU+rn8o4WBo0H7o1Cgdi
	 me7/YpEtstYASBT4t8BypL5yuNPjdOfBsU9YT48z41mpvuPsu6ddxASmYmtmdB6lQW
	 peXNueQgMwrBp8Ac+dlbHAq9jVTyWXKK+A8rAl1fAkNRi0UJWd08/3GZrihDafLfg6
	 p6z/9PA34dRBIaTnusiAB+ulNUtsRHmjLmSYxx299/Nt2H0Zc9jIA3SIlcJpAFkm7M
	 lw0fBbKjp2WnhCT4ZGYCdo//ChlHUkxpKO/kNKGQR1VEdM1X0kyy2deI/CP8hBt921
	 LKIFnOS4LXHCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56821380CEF9;
	Sat, 22 Aug 2026 20:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: txgbe: fix MISC interrupt unmasking in
 non-MSI-X
 mode and device shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743062788.1819488.7883475761777498134.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:30:27 +0000
References: <56A53978B83EEDE9+20260818023026.6631-1-jiawenwu@trustnetic.com>
In-Reply-To: <56A53978B83EEDE9+20260818023026.6631-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 larysa.zaremba@intel.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 10:30:26 +0800 you wrote:
> In txgbe_misc_irq_thread_fn(), the driver unmasks the miscellaneous
> interrupt at the end of the handler using TXGBE_INTR_MISC(wx) (which
> resolves to BIT(wx->num_q_vectors)). While this is correct for MSI-X
> mode, it is incorrect for legacy INTx or single MSI modes.
> 
> Due to hardware behavior, the WX_PX_MISC_IVAR register is completely
> ignored by the hardware when MSI-X is disabled. In non-MSI-X mode, the
> hardware forcibly merges all interrupt causes (both Queue and MISC) into
> a single bit: BIT(0) of the interrupt register.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: txgbe: fix MISC interrupt unmasking in non-MSI-X mode and device shutdown
    https://git.kernel.org/netdev/net/c/7bf29145d7a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


