Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A43B8BC4;
	Thu, 20 Aug 2026 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254298; cv=none; b=A0Hp0+7eDH3gWnP/GoYbsbtE+lp5LYoXcHL3WkzvaT8niuxz/Sw3jGfF+WW0motbDtmEqe0/TLyhKQ55H4/bJPtt39k4S++lU1M55q7W4DBRnE4iP25BYx8ogYYhcZx2RiKblIiPgLDmR63FtXkH8Zxu9eeNvkd68cM2DqhTTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254298; c=relaxed/simple;
	bh=QbVf+BNpEUdA5JHFn/DcKTS3IW02pR7/TAHmTGXyYRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IFUdvKrJ2xsxLN+9ya7D14OIScylMjHZg/1ldiF1NwtM6/Cf3MNCz496LNBqjuXtJQ/stNr5KXk9gDOrEG0i9O08UUecyp13V43Y0+4SLU6Kx9zhSB2ah2rDJkLnAF5EYINp2ahmbZ0UDyP26k+5d6rLYf4tDHnzZxFap7I6j1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8A4vG3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8A4vG3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1611F00A3E;
	Thu, 20 Aug 2026 19:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254289;
	bh=1HSCBBGC4RaeTefarmYVGcRMNxjyi5eyHlf2CKWdXLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E8A4vG3l0+TQGwuAumWpwljlL3Ted57uVHuHcJ8H4++JTaSCq9FOihlTcftQccY7t
	 iPXQt3T26IvJG0GgG7D4maNWBAmyUc63yKHcxeYaBC5Ru4nQ0+opnevqplHrX2urZ5
	 CktBfqvjWgE5ZBgD4H6ixRNbyvcP5jdaqPN/tDYLzK0KmhGmyn2OGRzkV/HBw7V9Ji
	 l1sVuJoxX0AdpCGqOgn0h0TpDA0b4lXulASz3C+B81oRbCQnELV6xKvnKTuGZoEzTQ
	 DjGWTqnPzVYAKWv1TRC63ReYVClGD/sQCz7ie7mOR6tVm5EMn73TfXYT7p+fPHrAWI
	 nFw9Dfrsh/pKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197FA3924459;
	Thu, 20 Aug 2026 19:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ipa: balance runtime PM reference on remove
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725423963.446762.8002019450211307478.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:30:39 +0000
References: <20260815151737.3758320-1-ruoyuw560@gmail.com>
In-Reply-To: <20260815151737.3758320-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, elder@riscstar.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 23:17:37 +0800 you wrote:
> ipa_remove() takes a runtime PM reference before accessing IPA hardware
> during teardown. If a concurrent modem start or stop keeps
> ipa_modem_stop() busy across both attempts, the callback intentionally
> returns without releasing the remaining resources because proceeding
> with teardown could crash. That return also skips the matching
> pm_runtime_put_noidle(), leaving the callback's usage-count reference
> held.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipa: balance runtime PM reference on remove error
    https://git.kernel.org/netdev/net/c/6b9eaa61ff2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


