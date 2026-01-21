Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C461F4631
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962007; cv=none; b=rQPt8VzbjqF7ORMb9g/OQDkiTbNWZkjmWy0PH6pBy9X9QApdnH+13Q6FSoFesQTp1arbPvXo/WIQKHL72PIOL2CW+YYm0br0chiYvzhrnql3hN2V4Ey9rscsg3PPQ/J1f0FOGYJZfdF9kCDZnKCOzC5cVQxpPTCjtJFj0C7KiDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962007; c=relaxed/simple;
	bh=wfphaBOx40a7a5xJa17JtEpHIL5h78k/LJRJ+AqLG80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O0NXW+45wEf2Ey9shQOCeVSUmlHStZEn4HWqEx4DXT+dLEoWrehYwYyb/puXeu/WroLEYPG3hYSIRlkhOak6/lCq9Yy8sz+2eYJFogkITqE1OlxvQO7a/KbmB+JEUiMOaMqcR0vYti9Osoq6Q+8wrUlmmSR96gWI86apSFXW+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuhxmkDc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuhxmkDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B76DC16AAE;
	Wed, 21 Jan 2026 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768962007;
	bh=wfphaBOx40a7a5xJa17JtEpHIL5h78k/LJRJ+AqLG80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WuhxmkDc1QBjvARCR3Ej4bRg8uqOurS0/nKqfxF34OoApaCpl0EcTYa54I6bUG/8L
	 FR3KE66YKegn3yyVYP4hS2Lbs2/0cSy1lC7XOlVEuZ6L62S5m5IajyJrMNJGflbzkJ
	 QwqVRXzeGzxlG70co8xfPoP812t8IkAhJqn68NY0OToKT+9+T6z2L5GCOuLbZfW6RI
	 0X7XVEjYjNiZgmxqVzICZ++3g69zff+v7qNS4EmcM5uPZjtytgRPVabwMni6x9YsP6
	 TGu4fdZlkHV+ex9RpvakqHTY5piZ5UBa978szBpMzxGCzWN6mZ2VJFiF7G3LjbSvnU
	 LDLR4fpCQ64JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11AB6380820D;
	Wed, 21 Jan 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tools/net/ynl: Makefile's install target now
 installs
 ynltool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896200485.692363.3605980916506691510.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:20:04 +0000
References: <aWqr9gUT4hWZwwcI@mbp-m3-fedora.vm>
In-Reply-To: <aWqr9gUT4hWZwwcI@mbp-m3-fedora.vm>
To: Michel Lind <michel@michel-slm.name>
Cc: netdev@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jan 2026 21:21:58 +0000 you wrote:
> This tool is built by default, but was not being installed by default
> when running `make install`. Fix this by calling ynltool's install
> target.
> 
> Signed-off-by: Michel Lind <michel@michel-slm.name>
> ---
>  tools/net/ynl/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net,v2] tools/net/ynl: Makefile's install target now installs ynltool
    https://git.kernel.org/netdev/net/c/a917cd0a23fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


