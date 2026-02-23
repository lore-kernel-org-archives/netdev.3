Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81597168BD
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771805398; cv=none; b=kDpYQKrEcMCdAaX5YggH59xDHqk2LhnkzZ2QNpbL1Q/GwBv+35EMUcqlRgNwezlDL/9rwYqATjMMS5EYOKNKdlk4CDwVhw5Z7j26L986ZxTArLW09zJuV57V0Ix1RU6bWtsCYq/oJ1PelHW1ysFj7mJeELowEGn0C9MkY/Q4bxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771805398; c=relaxed/simple;
	bh=MH4tZZPwWNEHafoTLBpL9UaVOWMqJQUAawQeGJAY7Do=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=peZl9rtOKJcrF3AKZMTclWsmYjG25apGdEmYtwKT6dXg1cMthoEZnzTuAiSHf+AxmEkaZQ1b0pzF7XCSxHYe6n6/skkYs+/HzDIBZQuebV7Ks7rahXGYRw2yJEcOzcqXF0pyPOdFffPgUGciS1EHoKk5fs6qkomgukK3W/Y56/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoIWoAR7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoIWoAR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2242DC116D0;
	Mon, 23 Feb 2026 00:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771805398;
	bh=MH4tZZPwWNEHafoTLBpL9UaVOWMqJQUAawQeGJAY7Do=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MoIWoAR74L8Ker4zzBPhpFobocEu0uCzgSWL68Q4P5dBOBYmcKayeRdKWcQ2I6DBv
	 e8Q04ReV2CjfOIdFk2NgqXRhkpK6upHvb1jERawyDiZEPHb/ZZ4e1+1IcCJmAUwpEA
	 8tEZQdYzLFQeC4bkSDZyCxqIBa0/KIYtNaMLcnh0+Gbl8dzzpCfQT0Ku0bSYvM4y6S
	 RltUMfFHcVUa5DFQlHLUCFi75xN4ZN6zqgxl9s8KljtUeuWl5Co1Tsy/ibeq6V+yVm
	 CE7R5CeLh2g6WjNqJHE8UWoJFHLxwfpu5sIc4/NDW9F+q4EptmxTlyrN3GFlITq6D1
	 uzCx2QJmfztmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC83808200;
	Mon, 23 Feb 2026 00:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool v2] man: ethtool: Fix small typos in manpage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177180540479.1952110.10897245252626064230.git-patchwork-notify@kernel.org>
Date: Mon, 23 Feb 2026 00:10:04 +0000
References: <20260217064404.2817775-1-carnil@debian.org>
In-Reply-To: <20260217064404.2817775-1-carnil@debian.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: mkubecek@suse.cz, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Tue, 17 Feb 2026 07:44:04 +0100 you wrote:
> Fix the ocurences of 'allows to' with 'allows one to'. Adjust as well
> one occurence of 'withing' to 'within'.
> 
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
> v1 -> v2:
>  - correct the subject for the patch which on its own contained a typo
>    using a ; instread of :
> 
> [...]

Here is the summary with links:
  - [ethtool,v2] man: ethtool: Fix small typos in manpage
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=9e862c0034af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


