Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71536EAAB
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280059; cv=none; b=SRdfDUkxSJcoygMX3+P+hfdTReYivUxrupi/zbFzwyxgsePbJ0AE0fy13siJX3ay24WwrP1NHeTNncM4ieo6PyRShrtLkld/p8z8QDkKprZd2BX75P12mJQ52QbFIkqkgbrbtWCpm8AMuhGnz2inIwoSaofUuwoPKPUXeQoCkK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280059; c=relaxed/simple;
	bh=aHFjIP8Uhi/R3+zj2qmTyppwEebhAQYAmpMMYW9Qbe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T+kfvIA/KJ7XC4+rBrVL5a4NFwRoUe4+XheBSkqDLGHesfcahqOq5HJa/fQP2fkB+RzOR9SaGkEjYxIFGiQwJj/cYcVPOUa6DV+xJ/vPxREOUIQnc4k1XIcBnzq+GEUZT8D5rX+BG70qaRk1FzKLCxhd0tc3biCZ0BLc9nrv/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWVnn6yc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWVnn6yc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624C2C2BCB0;
	Fri,  8 May 2026 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280059;
	bh=aHFjIP8Uhi/R3+zj2qmTyppwEebhAQYAmpMMYW9Qbe8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hWVnn6yckD8Tca6YG4uSt57TaJXeXCGH0wKFkjqGhEj8LacM0RnbFp//KOytSLEfc
	 72bLJUkc8qSHHpsDno59BO9b23z+P6LGA+fYS4JxjmWUd5Hz4VTUbTPu1VpOy7fLHB
	 /flYqjg/vhc2p9/ELNMBKrj0WeNtXQSUt7mwXcoKlTzMQuIKi0/45Dm4yvi8C6Ne8k
	 GzN14lxems1GATHIZPi5Lc/gk2iPJpHCQprtbVqxUCtLM/ZrgHSAyWMNDj45soB82i
	 8uwThB3qL5VUK6GUj8ZEebq3VLxXYN+pUYKxeSiPbGIp9Dnk4WrqJ51cPZ9fKSTCZt
	 RSJOgYQpjCmGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C5138119D3;
	Fri,  8 May 2026 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethtool: fix NULL pointer dereference in
 phy_reply_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828000780.878212.13962692522047721706.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:40:07 +0000
References: <20260507131738.1173835-1-2022090917019@std.uestc.edu.cn>
In-Reply-To: <20260507131738.1173835-1-2022090917019@std.uestc.edu.cn>
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, andrew@lunn.ch,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 21:17:38 +0800 you wrote:
> In phy_prepare_data(), several strings such as 'name', 'drvname',
> 'upstream_sfp_name', and 'downstream_sfp_name' are allocated using
> kstrdup(). However, these allocations were not checked  for failure.
> 
> If kstrdup() fails for 'name', it returns NULL while the function
> continues. This leads to a kernel NULL pointer dereference and panic
> later in phy_reply_size() when it unconditionally calls strlen() on
> the NULL pointer.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethtool: fix NULL pointer dereference in phy_reply_size
    https://git.kernel.org/netdev/net/c/4908f1395fb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


