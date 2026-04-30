Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C7247291;
	Thu, 30 Apr 2026 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510860; cv=none; b=dLemPPSksvWIYcNjQzx29P9XNEeUxoUqKwtvkcUR5T9uDIRVCYUt849d8kQsSkAyhVeG7mYoEccxsxwKgF8vJDsZqAjsKbnip2675ohAMv34Q07MZjkZLBKt/CbQm7tnJkZLtPLpfSNYe5VeCVK39HjwpuzgZYYvryNxJodg7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510860; c=relaxed/simple;
	bh=zE5Db1JOGYu8x01qkIIi7F5we9s05iV964wPXzcIyVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eJs3qBXmzMiRjvBWegrHRZXq8Fc1Ct7yc7WZr+lEUbVbkwx60DZdda0NSeAAUTTErDB/MkrvCg1RDi5j+BGhREllsd0Cn0SXKsf2BjGhIsSUWwKzPU4UR9JoRkWGNMdo6eWAJxVSPr9aglF+dbs24XI7dlTeGCdQFCzOC2fontk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwzZVpuS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwzZVpuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE29C2BCC4;
	Thu, 30 Apr 2026 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777510859;
	bh=zE5Db1JOGYu8x01qkIIi7F5we9s05iV964wPXzcIyVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qwzZVpuS0YXun3IQKyhTE/yDT4+CaRuTAIJ41tOe4A3RcbXIJ8jzBEUP9o0SrqYfm
	 mKlTiipH9FkhrU83kbJ7GNV7B/23YY6nNPJ18GoM7v3Cdl6NFI1fJXZbtcNDGHUhu6
	 alPHJGr9GNMu7QWGr75WCZCO3A2rpiaIL6UOwZHxwFGX2n1xLxP5rqRxg3vO8H9m1A
	 4egUV2Tb537TVnddPRWxGSQYeE1Skxz8zXyNyXvpWdI4v029pdbOax9crIOhb2xbJ6
	 hUuD/LPl1BhEKj4RL9SNUeUiTYTf0kPxWg4WehytZiCKsDIWNSt0A00Nfjncbig1Gx
	 bJsTnwT2R1AMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400453809A33;
	Thu, 30 Apr 2026 01:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8152: Use ocp/mdio test and clear functions in
 r8157_hw_phy_cfg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751081479.2244169.324712113730417132.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 01:00:14 +0000
References: <20260428-use_bit_functions-v1-1-6eb5a3507610@birger-koblitz.de>
In-Reply-To: <20260428-use_bit_functions-v1-1-6eb5a3507610@birger-koblitz.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 hsu.chih.kai@realtek.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 05:44:58 +0200 you wrote:
> Replace explicit testing of bits and clearing these bits by existing
> functions ocp_word_test_and_clr_bits() and r8152_mdio_test_and_clr_bit()
> to re-use this code.
> 
> This allows to remove the "ocp_data" variable. Also remove the "ret" variable
> which was incorrectly used for the r8153_phy_status() return value which
> is a u16, so that the remaining "data" variable is sufficient.
> 
> [...]

Here is the summary with links:
  - [net-next] r8152: Use ocp/mdio test and clear functions in r8157_hw_phy_cfg()
    https://git.kernel.org/netdev/net-next/c/b7ebbf9f7aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


