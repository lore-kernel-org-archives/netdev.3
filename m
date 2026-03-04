Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD430DEB0;
	Wed,  4 Mar 2026 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587839; cv=none; b=DGTgg8uN6Dpv31CtU/ltwKBjA4g/bQerqLTegJJdOt+8uZ8o0yT6ILNmr6YG5WOUvXI137r4yjJQU7Sz/sbWUOlXlPWSfJt9f8P4SPmRGSNE8S+YJREIcqSYbG28S1LadK3U/cZ7JWjnthjfqXKHuurgZgg9YknpgBs8JeX1EfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587839; c=relaxed/simple;
	bh=J+o42nD30Q9XGQPhZRpHPHFlthgqLGGBwjilk3yA/QU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t3AFtJXcXYFX67KXrQrHTRno/ej3XDplY7ibIdVfJNJITw3X49eL5ZwzfGL5XlSP48x9JNeOYlCBekoHfuRyIFGOA1ULtr0qBw/ifnPbsznG6VRSdIyp8NkH1TG3hygfJIfwVkTS2NsGwyD5RTg4J3G26AGzsTnakAta4DDYQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJJFuH6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJJFuH6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E8DC2BC9E;
	Wed,  4 Mar 2026 01:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587839;
	bh=J+o42nD30Q9XGQPhZRpHPHFlthgqLGGBwjilk3yA/QU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UJJFuH6zut4KhTOQ29J7wMeZRhFoTYpXyC6Ns2UwrbAwxhgpiGyp3jfDw9E+fvFfh
	 xxVQGOdnxkRrGB27gdhQuvnG7UCehHDDltbGN6R7Uenx4AfTmJuQ97qMI4Q36W2z43
	 hY5IoFXfm0YvMmH3fEJiWUmWUeI35kPjVMsiu80aUSubAaRp/Dg7XVyMIeBtXA0DMx
	 l6hxr2NxiHoI0pYxts8H2fzJ1RcNnjmge2CYSqducJ3MJVMrLFqOr8fVUWEKMsJmX4
	 MtL8KzAiaOtKR6LtTMzEdbQO/5ETusRuFkgE9n6+AvKQvQsjsvTw8dq+UAcZK6AQ9x
	 YqhV15UFE38Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0683808200;
	Wed,  4 Mar 2026 01:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] NFC: pn544: i2c: Replace strcpy() with
 strscpy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258784004.1546050.18331574720470240854.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:40 +0000
References: <20260301121254.174354-1-tomasz.unger@yahoo.pl>
In-Reply-To: <20260301121254.174354-1-tomasz.unger@yahoo.pl>
To: None <tomasz.unger@yahoo.pl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Mar 2026 13:12:54 +0100 you wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> Replace strcpy() with strscpy() which limits the copy to the size of
> the destination buffer. Since phy->firmware_name is an array, the
> two-argument variant of strscpy() is used - the compiler deduces
> the buffer size automatically.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] NFC: pn544: i2c: Replace strcpy() with strscpy()
    https://git.kernel.org/netdev/net-next/c/e63f5918adb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


